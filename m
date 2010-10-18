From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Mon, 18 Oct 2010 11:36:40 +0200
Message-ID: <4CBC1528.40907@eukrea.com>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>	<87aamjxe00.fsf@lechat.rtp-net.org> <4CB56A88.2040101@eukrea.com>	<20101013082930.GA11286@pengutronix.de>	<8762x6xx00.fsf@lechat.rtp-net.org>	<A88EF4D64D8447468743DC1503C0B6CA0D557C@zch01exm22.fsl.freescale.net>	<20101013100632.GC11286@pengutronix.de>	<4CB58565.5020806@eukrea.com>	<A88EF4D64D8447468743DC1503C0B6CA0D557D@zch01exm22.fsl.freescale.net>	<20101013102055.GD11286@pengutronix.de>	<20101015102729.GB4276@pengutronix.de> <A88EF4D64D8447468743DC1503C0B6CA0D581A@zch01exm22.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 68.mail-out.ovh.net ([91.121.185.69]:55606 "HELO
	68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750718Ab0JRJgq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Oct 2010 05:36:46 -0400
In-Reply-To: <A88EF4D64D8447468743DC1503C0B6CA0D581A@zch01exm22.fsl.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Guo Shawn-R65073 <R65073@freescale.com>, linux-mmc@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>

Hi Richard,

Le 18/10/2010 10:48, Zhu Richard-R65037 a =E9crit :
> I tested your serial patches with Eric's platform related codes on i.=
MX51 BBG3.0 board.
> Two phenomena:
> The debug msg "mmc0: mmc_rescan: trying to init card at 400000 Hz..."=
 are dumped out repeatedly.
> ROOT: There are pr_info codes in the mmc_rescan func.
>
fixed by this patch :
http://git.kernel.org/?p=3Dlinux/kernel/git/cjb/mmc.git;a=3Dcommit;h=3D=
0ca6d53ec81a13263f6643372b2a5abf7818e8fa

> The other:
> Encounter the Timeout and CRC error when the sandisk 4G SDHC card are=
 used as the ROOTFS storage media
> When I boot up the BBG board.
>
> It seems that the "SDHCI_QUIRK_BROKEN_TIMEOUT_VAL" is mandatory requi=
red at my side when I did the tests
>   on BBG3.0 board, and the i.MX51 board can support the "MULTI-BLOCK"=
=2E
>
you seems to be right, the attached patch seems to fix it (tested on ou=
r board=20
using a Linaro rootfs on a Transcend SDHC card and I didn't get errors =
after=20
applying this patch but I'm stopped by udev errors now with this rootfs=
).

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c=20
b/drivers/mmc/host/sdhci-esdhc-imx.c
index 2e9cca1..e8f7048 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -134,7 +134,8 @@ static struct sdhci_ops sdhci_esdhc_ops =3D {

  struct sdhci_pltfm_data sdhci_esdhc_imx_pdata =3D {
         .quirks =3D ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_MULTIBLOCK
-                       | SDHCI_QUIRK_BROKEN_ADMA,
+                       | SDHCI_QUIRK_BROKEN_ADMA
+                       | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
         /* ADMA has issues. Might be fixable */
         /* NO_MULTIBLOCK might be MX35 only (Errata: ENGcm07207) */
         .ops =3D &sdhci_esdhc_ops,


> What's kinds of tests and environment you did at your side?
>
Environment : our i.MX515 based boards.
Tests (until now) : mount + a few read/write.
We have a nand flash on board so our rootfs is on it so I didn't test a=
 rootfs=20
until this morning.

Eric
