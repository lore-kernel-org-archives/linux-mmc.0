Return-Path: <SRS0=Rhqe=2J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3705C43603
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 14:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C2B21655
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 14:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TYPOmbxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLSOrA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:47:00 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33277 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfLSOrA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2019 09:47:00 -0500
Received: by mail-vs1-f66.google.com with SMTP id n27so3929781vsa.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2019 06:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NcNiQ0cWhumNV09gnKioIAlAsyp7P9+w7lSDB77wTFs=;
        b=TYPOmbxAOSpkVMQFPeMGVI7syrRmzn0OGv0wVAItrvpCXTGq+pLoIF7VqdZ3YLp+7T
         cMDQn1xvCRArNsAK5Ta0VhLWKT1nUGwTRvhfWLxLsRYT3g9qBx2zI6YeFairSuN/0llD
         rMrmJlx8aMX/RpP0k6liplWW77NdrWZ3c/ZBpQlE7Lxae7wEqzoBpancuVGgTt02wv/8
         I/gxM+5NE1w3Zrn5Kog7Y7y3AWY/p6coeu2U0yq9Xb692YubYBXR5FO4RPyUOAP5pcYR
         8c+R2KV+36St6K+mgoalL0QFR6Jv/gnpkObJTUBsnfTMnVwXBaPN0bQxkOaVFFM00he9
         4xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NcNiQ0cWhumNV09gnKioIAlAsyp7P9+w7lSDB77wTFs=;
        b=gj+IwItHOeGHUK/pBtQft10AuZenYEEB076sOXxIMS13LzR86XyD9Tvs8dj/LHs9bR
         y1cKAD4mFE9BSxgS6GyezC+GsTc19KE+7wlc2MK4085irz6afsUX7+3HqFeiyMKaxqxW
         sg4dC8YC+glA2/kvZowLUh/KOk6/Q1MBi6SUeDAKCexxBSnz6EASw1y3CRtDn6Fh4QRf
         2KZpTWlh15XKwgfdGeAciyya6SyRghZ5nAw49RMFS+phypeAqX091BGxwTaWtg4F/jsQ
         sFdicv0NJvpUSjrnM+iFT09m4uFsryWVT/bre1lQwRh1Vg1uWiUO6TA+UdxlrPyLlMeh
         YByw==
X-Gm-Message-State: APjAAAWnnXi9+y1tbzjZNn8pRU6o2YkpnQXOmuu/WrQwx9p5gec7xv+j
        dohKyWrpC25YLYj6hnjkBYKGrdsW9sbEv+h1bxJFZg==
X-Google-Smtp-Source: APXvYqxqzEukg9KN5GHlmroBpjR4+6Ip5jPb6XbXGjlqV3tuFpljJyCyIleM2UH5s5i1I3P3TTmElTKiqB6eZ9/FPKc=
X-Received: by 2002:a05:6102:5d1:: with SMTP id v17mr4965249vsf.200.1576766819061;
 Thu, 19 Dec 2019 06:46:59 -0800 (PST)
MIME-Version: 1.0
References: <HK0PR01MB3521E416A9562724AC4A14EDFA520@HK0PR01MB3521.apcprd01.prod.exchangelabs.com>
In-Reply-To: <HK0PR01MB3521E416A9562724AC4A14EDFA520@HK0PR01MB3521.apcprd01.prod.exchangelabs.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Dec 2019 15:46:23 +0100
Message-ID: <CAPDyKFq=Jg8Gs-QOS6OD1EJt=y_O4fieTvDhHTpeBYWCZ-r_ZA@mail.gmail.com>
Subject: Re: Please review the patch "mmc: core: try to use an id from the
 devicetree " again
To:     =?UTF-8?B?Sm9obnNvbiBDSCBDaGVuICjpmbPmmK3li7Mp?= 
        <JohnsonCH.Chen@moxa.com>
Cc:     "lkundrak@v3.sk" <lkundrak@v3.sk>,
        "dianders@chromium.org" <dianders@chromium.org>,
        =?UTF-8?B?VmljdG9yIFl1ICjmuLjli53nvqkp?= <victor.yu@moxa.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 19 Dec 2019 at 11:57, Johnson CH Chen (=E9=99=B3=E6=98=AD=E5=8B=B3)
<JohnsonCH.Chen@moxa.com> wrote:
>
> Dear Ulf,
>
> We have a requirement to set a specific mmc's disk slot for a root path w=
hen booting. I think a specific "slot" is different from a specific "device=
". For example, When a platform has four mmc/sd slots, and we have ten mmc/=
sd cards. We need to test some cards for booting in one slot, and other slo=
ts can be filled with one card each for another use. Actually the order of =
these four slots is not constant because it depends on the order of registe=
ring mmc/sd drivers, and different platforms may have different situations.=
 Slot id can be related with block id, so it can be related with mmc id for=
 current linux kernel, too. We need to set a specific slot id to satisfy ou=
r requirement.
>
> I find the following patch: https://lkml.org/lkml/2019/6/20/638
> This is Lubomir provides has a function we need. Actually I have a patch =
with similar function without mmc alias and just set "mmc-id" in device tre=
e, but I think Lubomir's is better than myself.
>
> Someone think why not use "LABEL" or "UUID" for initramfs, or use "PARTLA=
BEL" or "PARTUUID" for u-boot? I think they assign a specific numbers/chara=
cters for mmc/sd cards, not for mmc/sd slots. Besides, if I set the same "L=
ABEL" or "PARTLABEL" in some mmc/sd card, I think kernel will be confused h=
ow to find a desired mmc/sd card.
>
> So kindly review the patch "mmc: core: try to use an id from the devicetr=
ee " if you are free, thanks!

There have been several attempts to fix this and me personally don't
have a problem with using aliases/labels in DT. I said that before as
well.

However, what is missing today, is that someone collects the proper
arguments for *why* this is needed (and especially why UUID/LABEL
doesn't work). I think all that information is available in the
discussion here: https://lore.kernel.org/patchwork/cover/674381/

When I see a new patch posted, that contains these arguments in the
commit message of the patch, I am ready to review it again.

Kind regards
Uffe
