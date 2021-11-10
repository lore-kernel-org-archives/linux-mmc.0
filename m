Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10227C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Nov 2021 17:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A34610A2
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Nov 2021 17:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhKJRMc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Nov 2021 12:12:32 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:18124 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhKJRMc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2021 12:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636564167;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=VogIBdJ+pahIETg+bq9eGn8JF1e4igREsQzr4VmxO4I=;
    b=cFAGJFtzKTtwUKaohFsiRrMmnxtlRRZoa0bYpY65bZT0DUKm7LuPt1zvUJJCqNaQdS
    4h3b8bPh7mO2GL9sPxJRB8rgvJkgzQXdNa3R2V6koqaDu/+dtM6moO+dRnZ8sOXKu7ED
    AByW7QPFeLEHGvGw5KBpXLX6+lEz3PoNSSaQGZbDmnwzEHFlB51WBQP4j82Ng92eRbh3
    R9wWTAmtNn3hURdInJbwO6uutQle81qGZJH8imKCWKC8dfWd7YfYxklpy3h5wJy877o2
    PtaqcqkY16G0jkGxkf62lazyIU2UNyu1sXH6L2Hua5B2mT+7lEI9xXRGM2vT1XMQMMDI
    umCA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw47pgLk="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.34.5 DYNA|AUTH)
    with ESMTPSA id Y02aa4xAAH9R50Y
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 10 Nov 2021 18:09:27 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [RFC v4 5/6] mmc: core: transplant ti,wl1251 quirks from to be
 retired omap_hsmmc
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAPDyKFqsBkWBajYvS2DXsHzO01-hgQp7YuzTs61N7vmLkZLgKg@mail.gmail.com>
Date:   Wed, 10 Nov 2021 18:09:26 +0100
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
Message-Id: <B7FC3305-7C27-4D17-9BBD-856CF6C542C8@goldelico.com>
References: <cover.1636103151.git.hns@goldelico.com>
 <3ca9a3099d86d631235b6c03ae260bc581cc8d60.1636103151.git.hns@goldelico.com>
 <CAPDyKFrH8f80cs5dbh=3ugjyEzoUYXhStpHQyhUSd6b9wD78vw@mail.gmail.com>
 <C2F065E7-10C5-4701-A6F7-6B5A6198F0DF@goldelico.com>
 <CAPDyKFoz6b-+HQYdypYD7EUXxwj7th-=41MAK=ZTnKQWRmLArQ@mail.gmail.com>
 <B6ECEECF-EC1D-431E-B4E4-915B29E31AEE@goldelico.com>
 <CAPDyKFqsBkWBajYvS2DXsHzO01-hgQp7YuzTs61N7vmLkZLgKg@mail.gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> Am 10.11.2021 um 18:03 schrieb Ulf Hansson <ulf.hansson@linaro.org>:
>=20
> On Wed, 10 Nov 2021 at 17:36, H. Nikolaus Schaller <hns@goldelico.com> =
wrote:
>>=20
>>=20
>> Indeed we can. That is great.
>>=20
>> Now the question is how to handle the dependency on your patch.
>> Somehow we must ensure that it is merged before my $subject patch.
>> Even if someone decides to backport this to stable.
>=20
> Yes, I can pick up my patch first. As it's not really fixing a
> problem, but rather preparing for your series to work better, I don't
> think we need to care about stable backports, at least for now.
>=20
> If you re-submit before rc1, then just include my patch early in your =
series.

Ok, I'll submit a v2 asap (isn't much work since I have your patch =
already in my test branch).

BR and thanks,
Nikolaus

