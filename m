Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A812C433F5
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Nov 2021 14:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE47B61220
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Nov 2021 14:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhKFOec (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 6 Nov 2021 10:34:32 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:34701 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbhKFOeb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Nov 2021 10:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636209070;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ZeeCJW7l3ZPDA299GYFKuVzlW6550AhTIF2LRz8dGB8=;
    b=aYCMy7/iUS3VrrNpTUDPdYGhWvk85MibtHW3BK1t6p/qznZkw0unQckmKk11QfN8We
    Qj0XST9AY7ki/n1UPvrBUWmdXCHwJm8iWjdYQ6V4lNlcE+jE2TyEP+szgIIrT52dALF2
    jW61sNeLdkoPl+WJ1N2uFC7iL7ZJVh/yB/KdYyg8S5knrNElgzA7XRgdfkk0id9g9oW/
    djUGT2ZlBtSyiLQtNqAOE1G/MkZMfvD3IARR7KxzL9zLQ7/BjGQcNpTRCNX8sQ+oYBWK
    3+lDjtzHjAPGmjnfxOm76JEnTzCPTLncvgsuxu0iN1cz0RPcJs2Ct+C0DdF5m1hnN2u1
    HkRQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw47qsg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 SBL|AUTH)
    with ESMTPSA id 902c63xA6EV6Eki
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 6 Nov 2021 15:31:06 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [RFC v4 2/6] mmc: core: allow to match the device tree to apply
 quirks
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <4570288.hTGhjlNkSs@pc-42>
Date:   Sat, 6 Nov 2021 15:31:05 +0100
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>, notasas@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7121F069-56C7-402C-BA82-A922B1A36587@goldelico.com>
References: <cover.1636103151.git.hns@goldelico.com>
 <e072de2b480103dbebd941f35be96197534642ee.1636103151.git.hns@goldelico.com>
 <4570288.hTGhjlNkSs@pc-42>
To:     =?utf-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi J=C3=A9r=C3=B4me,

> Am 05.11.2021 um 15:27 schrieb J=C3=A9r=C3=B4me Pouiller =
<jerome.pouiller@silabs.com>:
>=20
> On Friday 5 November 2021 10:05:47 CET H. Nikolaus Schaller wrote:
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
>=20
> Thank you for to have taken care of that (Maybe, you would like to add =
a
> "Co-developed-by:" tag).

Well, I just have taken your and Ulf's proposal and done 90% copy&paste.
So there wasn't much development, just editing...

>=20
>=20
>> ---
>> drivers/mmc/core/card.h   |  3 +++
>> drivers/mmc/core/quirks.h | 17 +++++++++++++++++
>> 2 files changed, 20 insertions(+)
>>=20
>> +static inline bool mmc_fixup_of_compatible_match(struct mmc_card =
*card,
>> +                                                const char *const =
*compat_list)
>> +{
>> +       struct device_node *np;
>> +
>> +       for_each_child_of_node(mmc_dev(card->host)->of_node, np) {
>> +               if (of_device_compatible_match(np, compat_list))
>> +                       return true;
>=20
> Intel robot complains about of_device_compatible_match():
>=20
>    ERROR: modpost: "of_device_compatible_match" =
[drivers/mmc/core/mmc_core.ko] undefined!
>=20
> I think we have to add this line:
>=20
>    EXPORT_SYMBOL(of_device_compatible_match);
>=20
> in drivers/of/base.c

I had seen the krobot message as well but could not figure out
what it meant...

But with your hint it indeed looks like an omission in drivers/of/base.c
Having something exported in include/linux/of.h but code not
marked EXPORT_SYMBOL...

That needs a separate patch. I'll add one with a

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>

and some Fixes: tag. Since it has a different audience I think
I should post it separately.

BTW: krobot noted the same issue for mmc_of_find_child_device()
in drivers/mmc/core/core.c (which we do not touch in this series).
But maybe it should be fixed as well.

So let's wait for more comments and then I may distribute a [PATCH v1].
Or should I do a [PATCH v5] to continue version counting?

BR,
Nikolaus

