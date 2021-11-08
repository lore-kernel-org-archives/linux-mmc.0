Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1880C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 16:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36C761186
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 16:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbhKHQHu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 11:07:50 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:23818 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbhKHQHt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2021 11:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636387495;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=PK1HOtrrDdxTgOO8UphIBb6lJvOT4Qvb1ttzQln7tm0=;
    b=aS//u9qKPBSrTM9/uH2GB40LrYPLyDqQuQGfgKSvPeT3hT8uCTw0kaEfgJL9XEW4Hg
    FkaRHzPG1wUbkugh/LEKicwZECPsd+Asb2IEa6AE6gpjDnjxzXGptuidWvzKzHfZ32KW
    RHEnHxXK4aRNQKBrRML1odz1ZxLCvoSJxD8JLDQJ8UzPtnIh0KjKSFx3lqKmFLfmrL18
    3gPi5Q9SpA6n2D/glija8DZdp+Jm1roFqLQXGqMrEt4qVblNvYtcKhqHsQEmTv6gnWEv
    9pxPX7MM1WU//+ZBTZy3hwChqlJfWrnZDkP4AxbX2ghNS5DXsbCKRXfGm+ML1AHhEdwr
    2XOA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3gMZ+"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA8G4tLab
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 8 Nov 2021 17:04:55 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [RFC v4 4/6] mmc: core: add new calls to
 mmc_fixup_device(sdio_card_init_methods)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <5014485.RYphtzS1IF@pc-42>
Date:   Mon, 8 Nov 2021 17:04:54 +0100
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>,
        =?utf-8?Q?Gra=C5=BEvydas_Ignotas?= <notasas@gmail.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E022F77C-82D5-46DA-9F35-4C7D09F22C51@goldelico.com>
References: <cover.1636103151.git.hns@goldelico.com>
 <73440c0f227778e57167dd9fedd350637a1d737a.1636103151.git.hns@goldelico.com>
 <5014485.RYphtzS1IF@pc-42>
To:     =?utf-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> Am 08.11.2021 um 16:39 schrieb J=C3=A9r=C3=B4me Pouiller =
<jerome.pouiller@silabs.com>:
>=20
> On Friday 5 November 2021 10:05:49 CET H. Nikolaus Schaller wrote:
>> This allows to add quirks based on device tree instead of having
>> card specific code in the host ops.
>>=20
>> We call it just after where host->ops->init_card() can be optionally
>> called.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>=20
> [...]
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
>=20
> sdio_read_common_cis(card) is called a bit after this line. I think it=20=

> will overwrite all the card->cis fields. This does not conflict with =
what=20
> your are doing in wl1251_quirk()?

No, because the wl1251_quirk sets MMC_QUIRK_NONSTD_SDIO which
skips reading CIS. The key issue with the wl1251 seems to be
that it reports random CIS tuples if we try to probe without
quirks (I have no further idea about the wl1251 than moving the
quirks around...).

