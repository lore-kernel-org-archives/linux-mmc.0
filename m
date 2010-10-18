From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Mon, 18 Oct 2010 17:44:34 +0800
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA0D5820@zch01exm22.fsl.freescale.net>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>	<87aamjxe00.fsf@lechat.rtp-net.org> <4CB56A88.2040101@eukrea.com>	<20101013082930.GA11286@pengutronix.de>	<8762x6xx00.fsf@lechat.rtp-net.org>	<A88EF4D64D8447468743DC1503C0B6CA0D557C@zch01exm22.fsl.freescale.net>	<20101013100632.GC11286@pengutronix.de>	<4CB58565.5020806@eukrea.com>	<A88EF4D64D8447468743DC1503C0B6CA0D557D@zch01exm22.fsl.freescale.net>	<20101013102055.GD11286@pengutronix.de>	<20101015102729.GB4276@pengutronix.de> <A88EF4D64D8447468743DC1503C0B6CA0D581A@zch01exm22.fsl.freescale.net> <4CBC1528.40907@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:57470
	"EHLO AM1EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754761Ab0JRJoY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Oct 2010 05:44:24 -0400
Received: from mail29-am1 (localhost.localdomain [127.0.0.1])	by
 mail29-am1-R.bigfish.com (Postfix) with ESMTP id CF2E610B02CE	for
 <linux-mmc@vger.kernel.org>; Mon, 18 Oct 2010 09:44:21 +0000 (UTC)
Received: from AM1EHSMHS004.bigfish.com (unknown [10.3.201.248])	by
 mail29-am1.bigfish.com (Postfix) with ESMTP id 42C54D9004E	for
 <linux-mmc@vger.kernel.org>; Mon, 18 Oct 2010 09:44:21 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id o9I9ij0f028294	for
 <linux-mmc@vger.kernel.org>; Mon, 18 Oct 2010 02:44:45 -0700 (MST)
Received: from zch01exm22.fsl.freescale.net (zch01exm22.ap.freescale.net
 [10.192.129.206])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
 o9IA0fVh005348	for <linux-mmc@vger.kernel.org>; Mon, 18 Oct 2010 05:00:42
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <4CBC1528.40907@eukrea.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?gb2312?B?RXJpYyBCqKZuYXJk?= <eric@eukrea.com>, Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Guo Shawn-R65073 <R65073@freescale.com>, linux-mmc@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>

Hi Eric:
Got that, great.
I tested at my side with the "SDHCI_QUIRK_BROKEN_TIMEOUT_VAL" added, an=
d I can login the ROOTFS, and complete some general tests.
:)

HI Wolfram:
About the codes I used in my verification, pls refer to the following l=
og with "git log" cmd
commit 44139322fc36bb23a066ccebb85981b544c957e7
Author: Wolfram Sang <w.sang@pengutronix.de>
Date:   Fri Sep 3 18:27:48 2010 +0200

    mmc: sdhci-pltfm: add pltfm-driver for imx35/51

    This driver adds basic support for the esdhc-core found on e.g.
    imx35/51. It adds up to the pltfm-core.

    Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
    Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
    Tested-by : Eric B=C3=A9nard <eric@eukrea.com>

commit 1c458bcff936e8b391b47cf916bcc2b17774cba9
Author: Wolfram Sang <w.sang@pengutronix.de>
Date:   Tue Sep 7 13:00:26 2010 +0200

    mmc: sdhci-of-esdhc: factor out common stuff

    Put everything which can be shared between the OF and platform vers=
ion
    of this driver into a local .h-file.

    Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
    Tested-by : Eric B=C3=A9nard <eric@eukrea.com>

Best Regards
Richard Zhu


> -----Original Message-----
> From: Eric B=A8=A6nard [mailto:eric@eukrea.com]
> Sent: Monday, October 18, 2010 5:37 PM
> To: Zhu Richard-R65037
> Cc: Wolfram Sang; linux-arm-kernel@lists.infradead.org; Guo Shawn-R65=
073;
> linux-mmc@vger.kernel.org; Arnaud Patard
> Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
>=20
> Hi Richard,
>=20
> Le 18/10/2010 10:48, Zhu Richard-R65037 a =A8=A6crit :
> > I tested your serial patches with Eric's platform related codes on
> i.MX51 BBG3.0 board.
> > Two phenomena:
> > The debug msg "mmc0: mmc_rescan: trying to init card at 400000 Hz..=
=2E"
> are dumped out repeatedly.
> > ROOT: There are pr_info codes in the mmc_rescan func.
> >
> fixed by this patch :
> http://git.kernel.org/?p=3Dlinux/kernel/git/cjb/mmc.git;a=3Dcommit;h=3D=
0ca6d53e
> c81a13263f6643372b2a5abf7818e8fa
>=20
> > The other:
> > Encounter the Timeout and CRC error when the sandisk 4G SDHC card a=
re
> > used as the ROOTFS storage media When I boot up the BBG board.
> >
> > It seems that the "SDHCI_QUIRK_BROKEN_TIMEOUT_VAL" is mandatory
> required at my side when I did the tests
> >   on BBG3.0 board, and the i.MX51 board can support the "MULTI-BLOC=
K".
> >
> you seems to be right, the attached patch seems to fix it (tested on =
our
> board using a Linaro rootfs on a Transcend SDHC card and I didn't get
> errors after applying this patch but I'm stopped by udev errors now w=
ith
> this rootfs).
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 2e9cca1..e8f7048 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -134,7 +134,8 @@ static struct sdhci_ops sdhci_esdhc_ops =3D {
>=20
>   struct sdhci_pltfm_data sdhci_esdhc_imx_pdata =3D {
>          .quirks =3D ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_MULTIBLOCK
> -                       | SDHCI_QUIRK_BROKEN_ADMA,
> +                       | SDHCI_QUIRK_BROKEN_ADMA
> +                       | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>          /* ADMA has issues. Might be fixable */
>          /* NO_MULTIBLOCK might be MX35 only (Errata: ENGcm07207) */
>          .ops =3D &sdhci_esdhc_ops,
>=20
>=20
> > What's kinds of tests and environment you did at your side?
> >
> Environment : our i.MX515 based boards.
> Tests (until now) : mount + a few read/write.
> We have a nand flash on board so our rootfs is on it so I didn't test=
 a
> rootfs until this morning.
>=20
> Eric


