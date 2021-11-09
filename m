Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF23C433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 10:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83DB4611C4
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 10:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243137AbhKILBh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:01:37 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:32615 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241381AbhKILBg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2021 06:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636455520;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=bOG02lyzrxPvPgbhhEPxvJgmZtyePuW31NB1W7OZX9M=;
    b=Tw6vovwnao8Vxi45qZyJVEp8VoUdjuDTgLEZOTSb/kSUcYDrLEqpxStSVhssB55ngu
    wdTDkAXD2Bhn2LOSEN8kdebtOHS2NdCPyhf2FO3LiJDfH5MXj9Ph9DJksh5dwvg7azZM
    UFh5jX8IV4I05zXocOjJclyYWJqvO58lSL8VRk5pw/Bz22O+pCkSw1RNkvxm5L6uOx4x
    MJ8Za0TlepwYXMFADBg9M1+KPNGalssmC7mC2DwPxVhDbW/l0q+NM42uu2jammBn3EPh
    6e86JFDBk9VWlc6raF5JreDH0wvI/3jfRFpbv9AeAFD4txkYQ0+vLwRdnnAO1C4OLe8M
    wL7A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3i8cT6Q=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA9AwdOVl
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 9 Nov 2021 11:58:39 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [RFC v4 5/6] mmc: core: transplant ti,wl1251 quirks from to be
 retired omap_hsmmc
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAPDyKFrH8f80cs5dbh=3ugjyEzoUYXhStpHQyhUSd6b9wD78vw@mail.gmail.com>
Date:   Tue, 9 Nov 2021 11:58:38 +0100
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
Message-Id: <C2F065E7-10C5-4701-A6F7-6B5A6198F0DF@goldelico.com>
References: <cover.1636103151.git.hns@goldelico.com>
 <3ca9a3099d86d631235b6c03ae260bc581cc8d60.1636103151.git.hns@goldelico.com>
 <CAPDyKFrH8f80cs5dbh=3ugjyEzoUYXhStpHQyhUSd6b9wD78vw@mail.gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

> Am 08.11.2021 um 16:33 schrieb Ulf Hansson <ulf.hansson@linaro.org>:
>=20
> On Fri, 5 Nov 2021 at 10:06, H. Nikolaus Schaller <hns@goldelico.com> =
wrote:
>>=20
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

I have checked with the schematics but the wlan_en regulator-fixed is =
just a GPIO
controlling some pin of the wifi chip.

I guess it enables some regulator or power switch inside the wifi module =
which
has unknown voltage.

We can interpret this as two sequential power-switches. The first one =
controlled
by the gpio-register bit and switches gpio power to the gpio pad of the =
SoC. The second
one switches the battery voltage to the internal circuits of the wifi =
module.

The GPIO itself is on 1.8V VIO level which seems to be the reason for =
the min/max.

Now it is a little arbitrary what the DTS describes: the gpio voltage or =
the unknown
internal voltage of the second switch.

So from hardware perspective the min/max values are irrelevant.

>=20
> I would be very interested to know if we would change
> "regulator-min|max-microvolt" of the regulator in the DTS, into
> somewhere in between 2700000-3600000 (2.7-3.6V)

Ok, if the mmc driver does something with these values it may have =
indeed an influence.

> - and see if that
> allows us to drop the assignment of "card->ocr =3D  0x80;" above. =
Would
> you mind doing some tests for this?

Well, with min/max=3D3.3V and no ocr I get:

[    2.765136] omap_hsmmc 480ad000.mmc: card claims to support voltages =
below defined range
[    2.776367] omap_hsmmc 480ad000.mmc: found wl1251
[    2.782287] mmc2: new SDIO card at address 0001
[   10.874237] omap_hsmmc 480ad000.mmc: could not set regulator OCR =
(-22)
[   10.945373] wl1251_sdio: probe of mmc2:0001:1 failed with error -16

Adding back card->ocr =3D 0x80 (and keeping 3.3V for min/max) shows =
exactly the same.

Only min/max 1.8V + OCR works:

[    2.824188] mmc2: new SDIO card at address 0001
[    2.806518] omap_hsmmc 480ad000.mmc: card claims to support voltages =
below defined range
[    2.815979] omap_hsmmc 480ad000.mmc: found wl1251
[   10.981018] omap_hsmmc 480ad000.mmc: found wl1251
[   11.018280] wl1251: using dedicated interrupt line
[   11.321136] wl1251: loaded
[   11.378601] wl1251: initialized
[   14.521759] omap_hsmmc 480ad000.mmc: found wl1251
[   38.680725] omap_hsmmc 480ad000.mmc: found wl1251
[   39.646942] wl1251: 151 tx blocks at 0x3b788, 35 rx blocks at 0x3a780
[   39.654785] wl1251: firmware booted (Rev 4.0.4.3.7)

Therefore I also tried the 4th combination: min/max 1.8V and no ocr =
quirk and it fails again.

Finally I tried setting min to 2.7V and max to 3.6V. This ends up in

[    0.402648] reg-fixed-voltage fixed-regulator-wg7210_en: Fixed =
regulator specified with variable voltages

So it seems that we need both: min/max =3D 1.8V and OCR. A little =
unexpected since I had expected
that min/max is completely irrelevant.

> If that works, we should add some comments about it above, I think.

So at the moment no change for [PATCH v1] which I can now send out.

BR and thanks,
Nikolaus

