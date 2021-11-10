Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A6CC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Nov 2021 16:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE6761205
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Nov 2021 16:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhKJQjf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Nov 2021 11:39:35 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:19620 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhKJQje (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2021 11:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636562190;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=vixtzLgz9wAeqX7MgV8LYC7Uo4wMPwTAmWbOEZb+dx4=;
    b=XrZKyA4TyM2YCWaRM3n9RD6dA7/hN42tVFe0HSvlNFUcqdkD3YQpY3j2RjPoFvqCez
    1zT2Lrenp2Zvog52Sddstj14peb1TOyegHrTZmpcE1Hd6kolADT/LsHLWRroNZncd3ZE
    Y/KhIevbLN7TJU3rHowunhoFJ8VFUnscncTiPeNGtBXGsNSSIoJXHyFrftYBDt4yK4m4
    OXMWdEzq4EDCu5VfW/bAX3QP9taTxOEsA1SztPROc1S5EIu2bD7sA4WCyYUV0JiSp3uC
    AvIZHvcNIxADT5C8hEKhc+tM7DyJBWGh0z3sbv25JSTWX/1BMq4ZGJ5dRxO59pNPUH36
    +ovg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw47pgLk="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.34.5 DYNA|AUTH)
    with ESMTPSA id Y02aa4xAAGaT4uA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 10 Nov 2021 17:36:29 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [RFC v4 5/6] mmc: core: transplant ti,wl1251 quirks from to be
 retired omap_hsmmc
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAPDyKFoz6b-+HQYdypYD7EUXxwj7th-=41MAK=ZTnKQWRmLArQ@mail.gmail.com>
Date:   Wed, 10 Nov 2021 17:36:28 +0100
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
Message-Id: <B6ECEECF-EC1D-431E-B4E4-915B29E31AEE@goldelico.com>
References: <cover.1636103151.git.hns@goldelico.com>
 <3ca9a3099d86d631235b6c03ae260bc581cc8d60.1636103151.git.hns@goldelico.com>
 <CAPDyKFrH8f80cs5dbh=3ugjyEzoUYXhStpHQyhUSd6b9wD78vw@mail.gmail.com>
 <C2F065E7-10C5-4701-A6F7-6B5A6198F0DF@goldelico.com>
 <CAPDyKFoz6b-+HQYdypYD7EUXxwj7th-=41MAK=ZTnKQWRmLArQ@mail.gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

> Am 09.11.2021 um 21:01 schrieb Ulf Hansson <ulf.hansson@linaro.org>:
>=20
> On Tue, 9 Nov 2021 at 11:58, H. Nikolaus Schaller <hns@goldelico.com> =
wrote:
>>=20
>> Hi Ulf,
>>=20
>>> Am 08.11.2021 um 16:33 schrieb Ulf Hansson <ulf.hansson@linaro.org>:
>>>=20
>>> On Fri, 5 Nov 2021 at 10:06, H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>>=20
>>>> +       card->quirks |=3D MMC_QUIRK_NONSTD_SDIO;
>>>> +       card->cccr.wide_bus =3D 1;
>>>> +       card->cis.vendor =3D 0x104c;
>>>> +       card->cis.device =3D 0x9066;
>>>> +       card->cis.blksize =3D 512;
>>>> +       card->cis.max_dtr =3D 24000000;
>>>> +       card->ocr =3D 0x80;
>>>=20
>>> In the past, we discussed a bit around why card->ocr needs to be set =
here.
>>>=20
>>> The reason could very well be that the DTS file is specifying the
>>> vmmc-supply with 1.8V fixed regulator, which seems wrong to me.
>>=20
>> I have checked with the schematics but the wlan_en regulator-fixed is =
just a GPIO
>> controlling some pin of the wifi chip.
>>=20
>> I guess it enables some regulator or power switch inside the wifi =
module which
>> has unknown voltage.
>>=20
>> We can interpret this as two sequential power-switches. The first one =
controlled
>> by the gpio-register bit and switches gpio power to the gpio pad of =
the SoC. The second
>> one switches the battery voltage to the internal circuits of the wifi =
module.
>>=20
>> The GPIO itself is on 1.8V VIO level which seems to be the reason for =
the min/max.
>>=20
>> Now it is a little arbitrary what the DTS describes: the gpio voltage =
or the unknown
>> internal voltage of the second switch.
>>=20
>> So from hardware perspective the min/max values are irrelevant.
>=20
> I completely agree with you! That's also why I earlier suggested
> moving to use an mmc-pwrseq node
> (Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml), that
> would allow a better description of the HW.

Basically yes.

> Nevertheless, the important point is that the mmc core gets a valid
> host->ocr_avail to work with during card initialization. And in this
> case, it's probably good enough to model this via changing the
> regulator-min|max-microvolt to get a proper value from the
> "regulator".
>=20
>>=20
>>>=20
>>> I would be very interested to know if we would change
>>> "regulator-min|max-microvolt" of the regulator in the DTS, into
>>> somewhere in between 2700000-3600000 (2.7-3.6V)
>>=20
>> Ok, if the mmc driver does something with these values it may have =
indeed an influence.
>>=20
>>> - and see if that
>>> allows us to drop the assignment of "card->ocr =3D  0x80;" above. =
Would
>>> you mind doing some tests for this?
>>=20
>> Well, with min/max=3D3.3V and no ocr I get:
>>=20
>> [    2.765136] omap_hsmmc 480ad000.mmc: card claims to support =
voltages below defined range
>> [    2.776367] omap_hsmmc 480ad000.mmc: found wl1251
>> [    2.782287] mmc2: new SDIO card at address 0001
>=20
> That's really great information! During the first initialization
> attempt, things are working fine and the SDIO card gets properly
> detected.
>=20
>> [   10.874237] omap_hsmmc 480ad000.mmc: could not set regulator OCR =
(-22)
>> [   10.945373] wl1251_sdio: probe of mmc2:0001:1 failed with error =
-16
>=20
> It looks like the card is being re-initialized when it's time to probe
> with the SDIO func driver. This makes sense, assuming it's been
> powered off via runtime PM (the "cap-power-off-card" DT property
> should be set in the DTS for this card's slot).
>=20
> I looked a bit closer to understand the problem above and then I
> realized why the card->ocr is being set from omap_hsmmc ->init_card()
> callback. It's most likely because the mmc core in
> mmc_sdio_init_card() doesn't save the card->ocr when
> MMC_QUIRK_NONSTD_SDIO is set. Instead it becomes the responsibility
> for the ->init_card() callback to do it, which seems wrong to me.
>=20
> Note that the card->ocr is being used when re-initializing the SDIO =
card.
>=20
> I have just sent a patch [1], would you mind trying it, in combination
> with not assigning card->ocr in $subject patch?

Yes, it works! I have not even played with the wlan_en regulator =
voltage.

>=20
>>=20
>> Adding back card->ocr =3D 0x80 (and keeping 3.3V for min/max) shows =
exactly the same.
>>=20
>> Only min/max 1.8V + OCR works:
>>=20
>> [    2.824188] mmc2: new SDIO card at address 0001
>> [    2.806518] omap_hsmmc 480ad000.mmc: card claims to support =
voltages below defined range
>> [    2.815979] omap_hsmmc 480ad000.mmc: found wl1251
>> [   10.981018] omap_hsmmc 480ad000.mmc: found wl1251
>> [   11.018280] wl1251: using dedicated interrupt line
>> [   11.321136] wl1251: loaded
>> [   11.378601] wl1251: initialized
>> [   14.521759] omap_hsmmc 480ad000.mmc: found wl1251
>> [   38.680725] omap_hsmmc 480ad000.mmc: found wl1251
>> [   39.646942] wl1251: 151 tx blocks at 0x3b788, 35 rx blocks at =
0x3a780
>> [   39.654785] wl1251: firmware booted (Rev 4.0.4.3.7)
>>=20
>> Therefore I also tried the 4th combination: min/max 1.8V and no ocr =
quirk and it fails again.
>>=20
>> Finally I tried setting min to 2.7V and max to 3.6V. This ends up in
>>=20
>> [    0.402648] reg-fixed-voltage fixed-regulator-wg7210_en: Fixed =
regulator specified with variable voltages
>>=20
>> So it seems that we need both: min/max =3D 1.8V and OCR. A little =
unexpected since I had expected
>> that min/max is completely irrelevant.
>>=20
>>> If that works, we should add some comments about it above, I think.
>>=20
>> So at the moment no change for [PATCH v1] which I can now send out.
>>=20
>> BR and thanks,
>> Nikolaus
>>=20
>=20
> Thanks a lot for doing these tests! If I am right, it looks like we
> should be able to skip assigning card->ocr for this quirk, but let's
> see.

Indeed we can. That is great.

Now the question is how to handle the dependency on your patch.
Somehow we must ensure that it is merged before my $subject patch.
Even if someone decides to backport this to stable.

BR and thanks,
Nikolaus=
