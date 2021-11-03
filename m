Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0531C433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 13:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D27B610FC
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 13:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhKCNjZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Nov 2021 09:39:25 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.103]:33236 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhKCNjW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Nov 2021 09:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1635946588;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=tvoaaXMd99Aly5rEwx0+nDfU+NKtixpNXJWzrFtUn1w=;
    b=AcC9vrg3ysgfi8RqVBHIIFDtJQiZVZOeo/Dp7kPPD0xFHDjLU3RHeDBcPE3xe/xpvi
    APUhPqn794VyphisxHMiWKHXj9L33c4mVnWPbUwAmCc1t8S+rzyNL614omjxT1P6SxeC
    vS4Dg1LUTakBilxg6lwyWp+mZLRgad2bvYJImZzbC+ROxqsbZX8WcGwn6qwbYVWahJ+5
    pDM4gsBNE2sTXXn2TFknutt06DFlHmahSCbJ23cq+4fvcjQ9FcefB8UDrHUl88xQ1Uzb
    OdoXD9UGR4ois2vuWQMvLSSY0bIWX3/XVGfYrLYuuTW8gWdn6sMnHRx7yUlzMuy0CUNF
    /YXw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDOoFRs="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA3DaR0Qf
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 3 Nov 2021 14:36:27 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [RFC v3 2/6] mmc: core: allow to match the device tree to apply
 quirks
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <12030734.Zn5U6lzIJN@pc-42>
Date:   Wed, 3 Nov 2021 14:36:21 +0100
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>, notasas@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <01F92CD5-89B8-4BF1-9E90-1A37BD49B68A@goldelico.com>
References: <cover.1635944413.git.hns@goldelico.com>
 <e6a52b238af3022b9a3dad7cad29b632fa34c00b.1635944413.git.hns@goldelico.com>
 <12030734.Zn5U6lzIJN@pc-42>
To:     =?utf-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi jerome,


> Am 03.11.2021 um 14:24 schrieb J=C3=A9r=C3=B4me Pouiller =
<jerome.pouiller@silabs.com>:
>=20
> Hi Nikolaus,
>=20
> On Wednesday 3 November 2021 14:00:10 CET H. Nikolaus Schaller wrote:
>> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>>=20
>> MMC subsystem provides a way to apply quirks when a device match some
>> properties (VID, PID, etc...) Unfortunately, some SDIO devices does =
not
>> comply with the SDIO specification and does not provide reliable =
VID/PID
>> (eg. Silabs WF200).
>>=20
>> So, the drivers for these devices rely on device tree to identify the
>> device.
>>=20
>> This patch allows the MMC to also rely on the device tree to apply a
>> quirk.
>>=20
>> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>> ---
>> drivers/mmc/core/card.h   |  3 +++
>> drivers/mmc/core/quirks.h | 18 ++++++++++++++++++
>> 2 files changed, 21 insertions(+)
>>=20
>> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
>> index 7bd392d55cfa5..2f73f8567e14f 100644
>> --- a/drivers/mmc/core/card.h
>> +++ b/drivers/mmc/core/card.h
>> @@ -59,6 +59,9 @@ struct mmc_fixup {
>>        /* for MMC cards */
>>        unsigned int ext_csd_rev;
>>=20
>> +       /* Match against functions declared in device tree */
>> +       const char *const *of_compatible;
>> +
>>        void (*vendor_fixup)(struct mmc_card *card, int data);
>>        int data;
>> };
>> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
>> index c7ef2d14b359f..a8b82b34dcfd2 100644
>> --- a/drivers/mmc/core/quirks.h
>> +++ b/drivers/mmc/core/quirks.h
>> @@ -10,6 +10,7 @@
>>  *
>>  */
>>=20
>> +#include <linux/of.h>
>> #include <linux/mmc/sdio_ids.h>
>>=20
>> #include "card.h"
>> @@ -145,6 +146,20 @@ static const struct mmc_fixup __maybe_unused =
sdio_fixup_methods[] =3D {
>>        END_FIXUP
>> };
>>=20
>> +static inline bool mmc_fixup_of_compatible_match(struct mmc_card =
*card,
>> +                                                const char *const =
*compat_list)
>> +{
>> +       struct device_node *of_node;
>> +       int i;
>> +
>> +       for (i =3D 0; i < 7; i++) {
>> +               of_node =3D mmc_of_find_child_device(card->host, i);
>> +               if (of_node && of_device_compatible_match(of_node, =
compat_list))
>> +                       return true;
>> +       }
>> +       return false;
>> +}
>> +
>> static inline void mmc_fixup_device(struct mmc_card *card,
>>                                    const struct mmc_fixup *table)
>> {
>> @@ -173,6 +188,9 @@ static inline void mmc_fixup_device(struct =
mmc_card *card,
>>                        continue;
>>                if (rev < f->rev_start || rev > f->rev_end)
>>                        continue;
>> +               if (f->of_compatible &&
>> +                   !mmc_fixup_of_compatible_match(card, =
f->of_compatible))
>> +                       continue;
>>=20
>>                dev_dbg(&card->dev, "calling %ps\n", f->vendor_fixup);
>>                f->vendor_fixup(card, f->data);
>> --
>> 2.33.0
>>=20
>>=20
>=20
> Thanks to take care of this. Do you know if the comments for Ulf[1]
> are still relevant?
>=20
> [1]: =
https://lore.kernel.org/lkml/CAPDyKFpr0kpRXoUACNNSwe8pL1S9wJPjnX+GFGS1PNez=
KCDYzQ@mail.gmail.com/

Ah yes. I think so.

Especially the comment about doing the loop over the child nodes...

I'll make a note for v4.

BR and thanks,
Nikolaus

