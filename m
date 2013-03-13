From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ARM: mach-moxart: platform port for MOXA ART SoC
Date: Wed, 13 Mar 2013 19:34:26 +0100
Message-ID: <5140C6B2.7040702@gmail.com>
References: <CACmBeS1NLFUYHBOVL28aCCzRrgXYGPZF9t3qj6AdcgaMkrPGoQ@mail.gmail.com> <CACmBeS01vs=fHOXu1Lnq8GX8YAbF6aBKmqopKPVt78mPYm=_9w@mail.gmail.com> <CACmBeS05cyT8N9nZeqbJUPMSGeZYLWjL0Tu1GSZ-ms+Hjc0UoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:65327 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178Ab3CMSef (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Mar 2013 14:34:35 -0400
In-Reply-To: <CACmBeS05cyT8N9nZeqbJUPMSGeZYLWjL0Tu1GSZ-ms+Hjc0UoQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jonas Jensen <jonas.jensen@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, jirislaby@gmail.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org

Hi Jonas,

On 13.03.2013 16:37, Jonas Jensen wrote:
> I ask for feedback and to submit (if possible) a new ARM SoC platform
> port. This is now near complete (I think) (tested on UC-7112-LX Plus)
> and applies to 2.6.34.14.

=46irst of all - thanks for submitting to the upstream kernel!

However, your patch has many severe problems which you need to address.

* please rebase your work. 2.6.34 is almost three years old now. 3.9 is
in it's stabilisation phase, and all new support has to be done for 3.1=
0.
* all new platforms must be written with device-tree support
* all drivers must have device-tree support as well

> The patch contains the following drivers and platform specific
implementations:
>
> * ARCH_MOXART (FA526 processor)
> * 100Hz interrupt timer
> * UART
> * MTD map driver
> * Ethernet driver (RTL8201CP)
> * MMC driver
> * MOXA Smartio/Industio family multiport serial driver
> * RTC driver
> * Watchdog driver
> * GPIO driver

Never send one big patch but series of smaller ones, so the individual
subsystem maintainers can review and approve their bits.

Please also read Documentation/SubmittingPatches for a lot more
information about this subject.


Best regards,
Daniel



> Predicted patch rejects below (in need of a solution, feedback is muc=
h
> appreciated) because they are critical in areas of boot, MMC and TTY.
>=20
> arch/arm/boot/compressed/head.S:
> A valid (and unique) architecture ID is not loaded to r1. Looks like
> the bootloader is broken, it should be doing this!
> http://gicl.cs.drexel.edu/people/sevy/linux/ARM_Linux_boot_sequence.h=
tml
>=20
> arch/arm/tools/mach-types:
> Omitted (do not edit manually / add a new machine using
> http://www.arm.linux.org.uk/developer/machines/?action=3Dnew). A fix =
to
> this and above is not feasible as long as MOXA withholds bootloader
> sources (requested without success).
>=20
> drivers/char/mxser.c drivers/char/mxser.h: MOXA
> SMARTIO/INDUSTIO/INTELLIO SERIAL CARD (Ji=C5=99=C3=AD Slab=C3=BD):
> Force board setup for CONFIG_ARCH_MOXART.
> ASYNCB_CLOSING is avoided because of a lockup (infinite wait after
> tty_wait_until_sent). Why this happens is unknown (to me) I'm hoping
> someone (Ji=C5=99=C3=AD?) can shed light. SysRq trace @ http://ideone=
=2Ecom/e845mr
> What significance does ASYNCB_CLOSING have?
> Obviously, automatic detection is better but "mxser_read_register" is
> pointless on this hardware. What to do instead? Is it better to make =
a
> copy and submit a new driver?
>=20
> drivers/mmc/core/sd.c:
> The MMC controller is "special"? "UNSTUFF_BITS" is redefined here
> http://repo.or.cz/w/linux-2.6.19-moxart.git/blob/50cdf2c57662f9f69c56=
15976412f76bfd73311a:/drivers/mmc/mmc.c
> . Without the new macro it'll report the wrong geometry and prod_name=
=2E
> I'm thinking a driver should never have to redefine UNSTUFF_BITS.
> Possible workaround: modify bits (in driver) to line up as expected
> before returning the response (mmc_request_done).
>=20
>=20
> For reference, this is my previous post from a few months back:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/1=
37130.html
>=20
> Gitweb: http://repo.or.cz/w/linux-2.6.34.14-moxart.git/commitdiff/?h=3D=
3bc2e98ebb92961e1c5992736186920cd070f4ee&hp=3Db7f1d43323eceb02fd663a71e=
b2f8be9c17e6740
>=20
> Download link (size: 193K):
> https://linux-2-6-34-14-moxart.googlecode.com/files/linux-2.6.34.14-m=
oxart.patch
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

