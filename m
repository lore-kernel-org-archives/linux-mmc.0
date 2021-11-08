Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3268BC433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 16:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177766101C
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 16:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241169AbhKHQLB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 11:11:01 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:31187 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbhKHQLB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2021 11:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636387693;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=OWta8qPy7Rz4O3vAbvE7uq7v9vG3C895qdAIdUoRe4Q=;
    b=B3HJSWEj6Y3IcSUm7V4uKH9P8VNJfXzhkN2xRHoHAwhdZtU0rqtOobdbvOx6Hs5Z0u
    D7qjRgGkHymlmzvTcapuEtrNcaq+Jdc13kCwkx4D97zPscdfXrj1icWS3AiVC1cbc32g
    ZJ40wzbX6Jm38MXvcaRAEstYsox0v2Gju35IjSfCsCGSP0yQMEJLqdtLToNnrnf03MxB
    XFOXpiUKOscPC3uJH8+VmbrXtmnIhIbAU25VVUi6WlyrQ1cwDoQVnTfjAPtcTPaDw3gz
    eZQOHjchdFfEFJAmUGUhTWPeaV1nubueoGxSO4+/3OwuQa2n30jDDASyy2btM3CpNPGM
    8E3w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3gMZ+"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA8G8CLcO
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 8 Nov 2021 17:08:12 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [RFC v4 5/6] mmc: core: transplant ti,wl1251 quirks from to be
 retired omap_hsmmc
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAPDyKFrH8f80cs5dbh=3ugjyEzoUYXhStpHQyhUSd6b9wD78vw@mail.gmail.com>
Date:   Mon, 8 Nov 2021 17:08:12 +0100
Cc:     =?utf-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <Jerome.Pouiller@silabs.com>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>,
        =?utf-8?Q?Gra=C5=BEvydas_Ignotas?= <notasas@gmail.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C170E2D-C9E6-4D90-AD0B-CFC0864F3F17@goldelico.com>
References: <cover.1636103151.git.hns@goldelico.com>
 <3ca9a3099d86d631235b6c03ae260bc581cc8d60.1636103151.git.hns@goldelico.com>
 <CAPDyKFrH8f80cs5dbh=3ugjyEzoUYXhStpHQyhUSd6b9wD78vw@mail.gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> Am 08.11.2021 um 16:33 schrieb Ulf Hansson <ulf.hansson@linaro.org>:
>=20
> On Fri, 5 Nov 2021 at 10:06, H. Nikolaus Schaller <hns@goldelico.com> =
wrote:
>>=20
>> The TiWi WL1251 WiFi chip needs special setup of the sdio
>> interface before it can be probed.
>>=20
>> So far, this is done in omap_hsmmc_init_card() in omap_hsmmc.c
>> which makes it useable only if connected to omap devices
>> which use the omap_hsmmc. The OpenPandora is the most promient
>> example.
>>=20
>> There are plans to switch to a newer sdhci-omap driver and
>> retire omap_hsmmc. Hence this quirk must be reworked or moved
>> somewhere else. Ideally to some location that is not dependent
>> on the specific SoC mmc host driver.
>>=20
>> This is achieved by the new mmc_fixup_device() option introduced
>> by ("mmc: allow to match the device tree to apply quirks") to match
>> through device tree compatible string.
>>=20
>> This quirk will be called early right after where =
host->ops->init_card()
>> and thus omap_hsmmc_init_card() was previously called.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/mmc/core/card.h   | 19 +++++++++++++++++++
>> drivers/mmc/core/quirks.h |  7 +++++++
>> 2 files changed, 26 insertions(+)
>>=20
>> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
>> index 089ede71d3150..20c8dfd6831cf 100644
>> --- a/drivers/mmc/core/card.h
>> +++ b/drivers/mmc/core/card.h
>> @@ -168,6 +168,25 @@ static inline void __maybe_unused =
add_limit_rate_quirk(struct mmc_card *card,
>>        card->quirk_max_rate =3D data;
>> }
>>=20
>> +static inline void __maybe_unused wl1251_quirk(struct mmc_card =
*card,
>> +                                              int data)
>> +{
>> +       /*
>> +        * We have TI wl1251 attached to this mmc. Pass this
>> +        * information to the SDIO core because it can't be
>> +        * probed by normal methods.
>> +        */
>> +
>> +       dev_info(card->host->parent, "found wl1251\n");
>> +       card->quirks |=3D MMC_QUIRK_NONSTD_SDIO;
>> +       card->cccr.wide_bus =3D 1;
>> +       card->cis.vendor =3D 0x104c;
>> +       card->cis.device =3D 0x9066;
>> +       card->cis.blksize =3D 512;
>> +       card->cis.max_dtr =3D 24000000;
>> +       card->ocr =3D 0x80;
>=20
> In the past, we discussed a bit around why card->ocr needs to be set =
here.
>=20
> The reason could very well be that the DTS file is specifying the
> vmmc-supply with 1.8V fixed regulator, which seems wrong to me.
>=20
> I would be very interested to know if we would change
> "regulator-min|max-microvolt" of the regulator in the DTS, into
> somewhere in between 2700000-3600000 (2.7-3.6V) - and see if that
> allows us to drop the assignment of "card->ocr =3D  0x80;" above. =
Would
> you mind doing some tests for this?
>=20
> If that works, we should add some comments about it above, I think.

Will try before posting next version [PATCH v1].

