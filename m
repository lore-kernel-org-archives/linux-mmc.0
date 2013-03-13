From: Jonas Jensen <jonas.jensen@gmail.com>
Subject: [PATCH] ARM: mach-moxart: platform port for MOXA ART SoC
Date: Wed, 13 Mar 2013 16:37:16 +0100
Message-ID: <CACmBeS05cyT8N9nZeqbJUPMSGeZYLWjL0Tu1GSZ-ms+Hjc0UoQ@mail.gmail.com>
References: <CACmBeS1NLFUYHBOVL28aCCzRrgXYGPZF9t3qj6AdcgaMkrPGoQ@mail.gmail.com>
	<CACmBeS01vs=fHOXu1Lnq8GX8YAbF6aBKmqopKPVt78mPYm=_9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACmBeS01vs=fHOXu1Lnq8GX8YAbF6aBKmqopKPVt78mPYm=_9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, jirislaby@gmail.com, linux@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

I ask for feedback and to submit (if possible) a new ARM SoC platform
port. This is now near complete (I think) (tested on UC-7112-LX Plus)
and applies to 2.6.34.14.

The patch contains the following drivers and platform specific implemen=
tations:

* ARCH_MOXART (FA526 processor)
* 100Hz interrupt timer
* UART
* MTD map driver
* Ethernet driver (RTL8201CP)
* MMC driver
* MOXA Smartio/Industio family multiport serial driver
* RTC driver
* Watchdog driver
* GPIO driver

Predicted patch rejects below (in need of a solution, feedback is much
appreciated) because they are critical in areas of boot, MMC and TTY.

arch/arm/boot/compressed/head.S:
A valid (and unique) architecture ID is not loaded to r1. Looks like
the bootloader is broken, it should be doing this!
http://gicl.cs.drexel.edu/people/sevy/linux/ARM_Linux_boot_sequence.htm=
l

arch/arm/tools/mach-types:
Omitted (do not edit manually / add a new machine using
http://www.arm.linux.org.uk/developer/machines/?action=3Dnew). A fix to
this and above is not feasible as long as MOXA withholds bootloader
sources (requested without success).

drivers/char/mxser.c drivers/char/mxser.h: MOXA
SMARTIO/INDUSTIO/INTELLIO SERIAL CARD (Ji=C5=99=C3=AD Slab=C3=BD):
=46orce board setup for CONFIG_ARCH_MOXART.
ASYNCB_CLOSING is avoided because of a lockup (infinite wait after
tty_wait_until_sent). Why this happens is unknown (to me) I'm hoping
someone (Ji=C5=99=C3=AD?) can shed light. SysRq trace @ http://ideone.c=
om/e845mr
What significance does ASYNCB_CLOSING have?
Obviously, automatic detection is better but "mxser_read_register" is
pointless on this hardware. What to do instead? Is it better to make a
copy and submit a new driver?

drivers/mmc/core/sd.c:
The MMC controller is "special"? "UNSTUFF_BITS" is redefined here
http://repo.or.cz/w/linux-2.6.19-moxart.git/blob/50cdf2c57662f9f69c5615=
976412f76bfd73311a:/drivers/mmc/mmc.c
=2E Without the new macro it'll report the wrong geometry and prod_name=
=2E
I'm thinking a driver should never have to redefine UNSTUFF_BITS.
Possible workaround: modify bits (in driver) to line up as expected
before returning the response (mmc_request_done).


=46or reference, this is my previous post from a few months back:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137=
130.html

Gitweb: http://repo.or.cz/w/linux-2.6.34.14-moxart.git/commitdiff/?h=3D=
3bc2e98ebb92961e1c5992736186920cd070f4ee&hp=3Db7f1d43323eceb02fd663a71e=
b2f8be9c17e6740

Download link (size: 193K):
https://linux-2-6-34-14-moxart.googlecode.com/files/linux-2.6.34.14-mox=
art.patch
