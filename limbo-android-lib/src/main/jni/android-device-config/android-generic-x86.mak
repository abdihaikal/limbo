#Needs platform = android-17

#NDK VERSION
NDK_TOOLCHAIN_VERSION=4.9

#TARGET ARCH
APP_ABI := x86

#Standard C 99
ARCH_CFLAGS += -std=gnu99

# Suppress some warnings
ARCH_CFLAGS += -Wno-psabi

# Smaller code generation for shared libraries, usually faster
# if doesn't work use -fPIC
ARCH_CFLAGS += -fpic

# Slower but needed for some devices where stack corruption is more probable
ARCH_CFLAGS += -fstack-protector-strong

# prevent unwanted optimizations for Qemu
ARCH_CFLAGS += -fno-strict-aliasing

# Don't keep the frame pointer in a register for functions that don't need one
ARCH_CFLAGS += -fomit-frame-pointer



################## OPTIMIZATION

ifeq ($(USE_OPTIMIZATION),true)
    ARCH_CFLAGS += -O2
    ARCH_CFLAGS += -foptimize-sibling-calls

    # Loop optimization might be safe
    ARCH_CFLAGS += -fstrength-reduce
    ARCH_CFLAGS += -fforce-addr

    # Faster math might not be safe
    #ARCH_CFLAGS += -ffast-math

    # Fast optimizations but maybe crashing apps?
    #ARCH_CFLAGS += -funsafe-math-optimizations

    # Useful for IEEE non-stop floating
    #ARCH_CFLAGS += -fno-trapping-math

    # Reduce executable size
    ARCH_CFLAGS += -ffunction-sections

else
    ARCH_CFLAGS += -O0
endif

###################### DEBUGGING
ifeq ($(NDK_DEBUG),1)
	ARCH_CFLAGS += -g
	# for Debugging only
	ARCH_CFLAGS += -funwind-tables
	ARCH_CFLAGS += -funswitch-loops
endif
