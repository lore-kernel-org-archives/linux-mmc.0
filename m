From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: [PATCH 1/2 v2] mmc: tmio: handle missing HW interrupts
Date: Wed, 05 Jan 2011 23:31:00 +0100
Message-ID: <4D24F124.9000303@arndnet.de>
References: <1293628874-8140-1-git-send-email-arnd@arndnet.de> <1293628874-8140-2-git-send-email-arnd@arndnet.de> <20110105212223.GJ9198@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:43318 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751338Ab1AEWbK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Jan 2011 17:31:10 -0500
In-Reply-To: <20110105212223.GJ9198@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, linux-sh@vger.kernel.org

Hi Chris,

Am 05.01.2011 22:22, schrieb Chris Ball:
> Hi Arnd,
>=20
> On Wed, Dec 29, 2010 at 02:21:13PM +0100, Arnd Hannemann wrote:
>> This patch addresses this problem by introducing timeouts for outsta=
nding
>> interrupts. If a hardware interrupt is missing, a soft reset will be=
 performed
>> to bring the hardware back to a working state.
>> Tested with the SDHI hardware block in sh7372 / AP4EVB.
>>
>> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
>=20
> This breaks compilation without CONFIG_TMIO_MMC_DMA=3Dy, because it
> attempts to compile tmio_mmc_reset_work() unconditionally even though
> delayed_reset_work is only a member of tmio_mmc_host if TMIO_MMC_DMA=3D=
y:
>=20
> drivers/mmc/host/tmio_mmc.c: In function =E2=80=98tmio_mmc_reset_work=
=E2=80=99:
> drivers/mmc/host/tmio_mmc.c:357:31: error: =E2=80=98struct tmio_mmc_h=
ost=E2=80=99 has no member named =E2=80=98delayed_reset_work=E2=80=99

Hmm, I could not reproduce this.
delayed_reset_work should not be in the #ifdef TMIO_MMC_DMA #endif scop=
e.
And it isn't according to the patch.

I tried with mmc-next last commit "549bad416ef62f09711cb22e77adff029e27=
ce07".
The patch would apply with some fuzz, but compilation without CONFIG_TM=
IO_MMC_DMA=3Dy works.

With what tree and .config did you try?

Maybe I confused you with my email mentioning the older patches, did yo=
u try the (rebased) v2:
https://patchwork.kernel.org/patch/439421/
https://patchwork.kernel.org/patch/439431/


Thanks
Arnd
