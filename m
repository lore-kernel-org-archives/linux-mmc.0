From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: A MMC card transfer issue
Date: Tue, 9 Nov 2010 14:53:01 +0900
Message-ID: <AANLkTimfnj8GcSwmALjaZUBsiq6ssaVuzVZZsZHRYmiX@mail.gmail.com>
References: <4CD8DE9C.4040505@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:48130 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab0KIFxC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2010 00:53:02 -0500
In-Reply-To: <4CD8DE9C.4040505@dsn.okisemi.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew\"" <andrew.chih.howe.khor@intel.com>, kok.howg.ewe@intel.com

2010/11/9 Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>:
> I am facing the issue about some MMC cards on Intel EG20T PCH (Platfo=
rm Controller Hub).
> The linux version is 2.6.36.
> I can not transfer data the MMC cards (e.g. Transcned MMC card).
> The card is 1 bit bus width. And the card is according to MMC specifi=
cation V3.x.
> And the EG20T has a 4 bit bus width capability
> Linux MMC standard driver decides the card bus width as 4 bit,
> if the MMC specification version is larger than or equal to V4.0 like=
 below.
>
> linux/drivers/mmc/core/mmc.c
>
> =A0505 =A0 =A0 =A0 =A0/*
> =A0506 =A0 =A0 =A0 =A0 * Activate wide bus (if supported).
> =A0507 =A0 =A0 =A0 =A0 */
> =A0508 =A0 =A0 =A0 =A0if ((card->csd.mmca_vsn >=3D CSD_SPEC_VER_4) &&
> =A0509 =A0 =A0 =A0 =A0 =A0 =A0(host->caps & (MMC_CAP_4_BIT_DATA | MMC=
_CAP_8_BIT_DATA))) {
> =A0510 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned ext_csd_bit, bus_width=
;
> =A0511
> =A0512 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->caps & MMC_CAP_8_BIT_=
DATA) {
> =A0513 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd_bit =3D=
 EXT_CSD_BUS_WIDTH_8;
> =A0514 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bus_width =3D M=
MC_BUS_WIDTH_8;
> =A0515 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0516 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd_bit =3D=
 EXT_CSD_BUS_WIDTH_4;
> =A0517 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bus_width =3D M=
MC_BUS_WIDTH_4;
> =A0518 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0519
> =A0520 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(card, EXT_CS=
D_CMD_SET_NORMAL,
> =A0521 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 EXT_CSD_BUS_WIDTH, ext_csd_bit);
> =A0522
> =A0523 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err && err !=3D -EBADMSG)
> =A0524 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_card;
> =A0525
> =A0526 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err) {
> =A0527 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_WAR=
NING "%s: switch to bus width %d "
> =A0528 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "f=
ailed\n", mmc_hostname(card->host),
> =A0529 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 =
<< bus_width);
> =A0530 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D 0;
> =A0531 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0532 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_set_bus_wid=
th(card->host, bus_width);
> =A0533 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0534 =A0 =A0 =A0 =A0}
> =A0535
>
> However the MMC specification version id is the same as V3.x and V4.0=
=2E
> Therefore the driver uses the 4 bit bus width for the MMC card
> even if the card has only 1 bit bus width.
> I modified the driver to use 1 bit bus width only tentatively and con=
firmed that
> we can mount the card and R/W correctly.
>
> I think we can not support MMC_CAP_4_BIT_DATA or MMC_CAP_8_BIT_DATA i=
n MMC V4.0.
>
> How do you think ?

You can find a patch for 4-bit support. the problem is there's some
bug related so it set the 4 & 8 bit support both.
So line 512 is always true. you can just remove the one line like this.

It's quirk-and-dirty patch. now we try to find a generic solution to
solve this issue.
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1849,7 +1849,7 @@ int sdhci_add_host(struct sdhci_host *host)
        mmc->caps |=3D MMC_CAP_SDIO_IRQ;

        if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
-               mmc->caps |=3D MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
+               mmc->caps |=3D MMC_CAP_4_BIT_DATA;

        if (caps & SDHCI_CAN_DO_HISPD)
                mmc->caps |=3D MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHS=
PEED;

Thank you,
Kyungmin Park
>
> --
> Thanks,
> Tomoya MORINAGA(OKI SEMICONDUCTOR CO., LTD.)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
