Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6B4C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 16:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34EB160EDF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 16:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbhKHQKT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 11:10:19 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:29441 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbhKHQKT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2021 11:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636387650;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=07yFpp0NBIJt76EAOUVS+i+HKo29LgtcF4Hu3VjH5NQ=;
    b=Rg2vJPmt/+LkW5+xEpO9Ep9kTp/m2n7CoqKMhUqJn+oGDrp8Ux/tCxZ/6p3Lg9nFRf
    +M9afqTz5pxIeIhJmTdP01n+6v8byBMolulugXqSiFzy6Q2OC3BCjjd3/LJlRjiz5SQg
    SeRJrA2UHCFoXhusV4BJE71ISi6QzGgEs3203f7B2DR93+dG7vIub5+E9r+g6xn1Nzze
    UaYACgIQRXhbaNu78rrUbneneX6X8wCKbHYRRWuLyYfE5w1/KUlcSRskRlCzvo1x9CuZ
    RAbspFz1Q5HWylw+bF63EP4YXVCJwFLlHb2Po13djo8YDj2/fMzOpc3pR9hRsVeBJy8F
    w1Cg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3gMZ+"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA8G7TLba
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 8 Nov 2021 17:07:29 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [RFC v4 4/6] mmc: core: add new calls to
 mmc_fixup_device(sdio_card_init_methods)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAPDyKFr5=sQsb2KEh_nkDZY5ThjMTOZWzwN7mkd4AS5jWDYtWg@mail.gmail.com>
Date:   Mon, 8 Nov 2021 17:07:28 +0100
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
Message-Id: <532B045A-951B-4104-9D77-4AA620958F52@goldelico.com>
References: <cover.1636103151.git.hns@goldelico.com>
 <73440c0f227778e57167dd9fedd350637a1d737a.1636103151.git.hns@goldelico.com>
 <CAPDyKFr5=sQsb2KEh_nkDZY5ThjMTOZWzwN7mkd4AS5jWDYtWg@mail.gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> Am 08.11.2021 um 16:08 schrieb Ulf Hansson <ulf.hansson@linaro.org>:
>=20
> On Fri, 5 Nov 2021 at 10:06, H. Nikolaus Schaller <hns@goldelico.com> =
wrote:
>>=20
>> This allows to add quirks based on device tree instead of having
>> card specific code in the host ops.
>>=20
>> We call it just after where host->ops->init_card() can be optionally
>> called.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/mmc/core/mmc.c  | 1 +
>> drivers/mmc/core/sd.c   | 2 ++
>> drivers/mmc/core/sdio.c | 1 +
>> 3 files changed, 4 insertions(+)
>>=20
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 29e58ffae3797..19cd138acaec9 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1634,6 +1634,7 @@ static int mmc_init_card(struct mmc_host *host, =
u32 ocr,
>>         */
>>        if (host->ops->init_card)
>>                host->ops->init_card(host, card);
>> +       mmc_fixup_device(card, sdio_card_init_methods);
>>=20
>>        /*
>>         * For native busses:  set card RCA and quit open drain mode.
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 4646b7a03db6b..0d174fdf47164 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -23,6 +23,7 @@
>> #include "host.h"
>> #include "bus.h"
>> #include "mmc_ops.h"
>> +#include "quirks.h"
>> #include "sd.h"
>> #include "sd_ops.h"
>>=20
>> @@ -1427,6 +1428,7 @@ static int mmc_sd_init_card(struct mmc_host =
*host, u32 ocr,
>>         */
>>        if (host->ops->init_card)
>>                host->ops->init_card(host, card);
>> +       mmc_fixup_device(card, sdio_card_init_methods);
>>=20
>>        /*
>>         * For native busses:  get card RCA and quit open drain mode.
>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>> index 68edf7a615be5..cf8ee66990508 100644
>> --- a/drivers/mmc/core/sdio.c
>> +++ b/drivers/mmc/core/sdio.c
>> @@ -707,6 +707,7 @@ static int mmc_sdio_init_card(struct mmc_host =
*host, u32 ocr,
>>         */
>>        if (host->ops->init_card)
>>                host->ops->init_card(host, card);
>> +       mmc_fixup_device(card, sdio_card_init_methods);
>>=20
>>        /*
>>         * If the host and card support UHS-I mode request the card
>> --
>> 2.33.0
>>=20
>=20
> As the quirk is for SDIO cards, we don't need to call
> mmc_fixup_device(card, sdio_card_init_methods) - other than from
> mmc_sdio_init_card().

Ok. Well, the old code did have some logic for some SD_COMBO.
But I have no idea if that is needed.

> Additionally, for sd/mmc we should not be using
> 'sdio_card_init_methods'.

Ok ,I see.

>=20
> That said, it looks also reasonable to me, to squash $subject patch =
with patch3.

Ok.

BR and thanks,
Nikolaus


