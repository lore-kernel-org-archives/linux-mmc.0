Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385A4EB64D7
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jun 2023 09:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjFUJTm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jun 2023 05:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjFUJTe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jun 2023 05:19:34 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7363B1704
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jun 2023 02:19:33 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bc4e41b7bc9so5708357276.2
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jun 2023 02:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687339172; x=1689931172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=blhz7/V1C3W9DzsMbwpQGpPUyl+Pvgprpm212Tnw4/M=;
        b=DosAmceuSluu4pRZ0jDD5k1r0luSwhBBu4Qfggea8QGvIfEANXlnUJFHGamdu0gLCz
         4orfZ9XV9S91k1K2WpEDdgqA+QR8mqBdbZWaYFdN2sZ2rnzMDfvTFjGQvXOgLN+iJsYG
         rvqwne7KiLVoVkq8BwD3I3EpE3iz2q8xiWOkZK3TzAD5g9oBdI/PlpnQBZ6h3ob/qMq7
         GcE0LKdhDoxgcz8+tpXAoogyQMLZR5ueaf8QB4FnaJgv6+96FjEf1WM9OM0ttc368RvG
         ZpdGa58W2txzMfYIDEW4o2snqGG1MwNsMG0R9ErC0TyWdWXZxI9TfQRSX2eiz2PYA0I6
         FGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339172; x=1689931172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blhz7/V1C3W9DzsMbwpQGpPUyl+Pvgprpm212Tnw4/M=;
        b=J71nVJ0aeBP9Jwox3KemiGxTKwCvVvucvNit37ReRHRVkl6fPBp9X+l1NoGcs6/if1
         ApcZ2lKCI6U3fSRZ4oRnPFRyKFoxhQJcIVlKQ6SaX52tqPJh1PlaBniA0hGjbSinuG8n
         YTsUDJYWY5LQjYfl+HkOSHxYjG9Ia0o2zo3kchHIW0Ub3hnp5hAx5UWOGIQ46HncIgAF
         Wk510vg1NxVZoQWuaskS9smZ6xnMFAU2ifgiTuosttCqnKeBwM3XuDAV6BjLuSewoZFk
         UjmP69m0CbWOo8Sqfqg+jL2Bo2KB6Oh2DlvVCibkh8AVucZXFk11BLTrQqWPVq7UNUqV
         mkcw==
X-Gm-Message-State: AC+VfDz6YeChXfPau+sbzA9SQ3HzGm5LiIeKXXQmNFBC1/OCsaRx6lBG
        etIQO16pLEWeEe2K8wiQMpD9Txxgm1U/U9+QiwdUvA==
X-Google-Smtp-Source: ACHHUZ6wsb6HDmy/tgd2rGPKYukZqx+Jm4/FUTUQc9z5sl1jkW9KYuVn30Bre8qVwcbfl55c0hRy8W3EPwOn7BHlDjc=
X-Received: by 2002:a25:73c9:0:b0:ba6:e17a:abc2 with SMTP id
 o192-20020a2573c9000000b00ba6e17aabc2mr11244407ybc.63.1687339172634; Wed, 21
 Jun 2023 02:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230620104722.16465-1-marex@denx.de> <CAPDyKFqZ_r=gjpRm833ax4LwASCTGAuO0a0ABXo-kN8dtYje-Q@mail.gmail.com>
 <289cd876-e6e1-8610-bcb6-b0259c68fd89@denx.de>
In-Reply-To: <289cd876-e6e1-8610-bcb6-b0259c68fd89@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Jun 2023 11:18:56 +0200
Message-ID: <CAPDyKFoLaYegCxw35XPNWuzg_F4M-UPho=+XweB+V4oCXaMxGA@mail.gmail.com>
Subject: Re: [PATCH 01/11] mmc: core: Use BIT() macro
To:     Marek Vasut <marex@denx.de>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>, Bo Liu <liubo03@inspur.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pierre Ossman <pierre@ossman.eu>,
        Russell King <linux@armlinux.org.uk>,
        Yang Yingliang <yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 21 Jun 2023 at 04:36, Marek Vasut <marex@denx.de> wrote:
>
> On 6/20/23 13:15, Ulf Hansson wrote:
> > On Tue, 20 Jun 2023 at 12:47, Marek Vasut <marex@denx.de> wrote:
> >>
> >> Use the BIT(n) macro instead of (1<<n), no functional change.
> >> Regex 's@(1 \?<< \?\([0-9A-Z_]\+\))@BIT(\1)' .
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >
> > I don't think the benefit of this change is worth it. For example,
> > it's quite useful to run a git blame to see the history of what has
> > happened.
>
> Understood.
>
> git blame does allow you to specify either --since or revision range though.

Yes, but I think you get my point.

>
> > So, sorry, but I am not going to pick this up - or any other similar
> > changes, at least for the core layer.
>
> Is this a policy of the mmc subsystem to reject all code clean ups then ?

Of course it isn't, I regularly pick up clean ups.

My point here is that the clean-up should make the code better, in
some way. I don't think converting to the BIT macro helps in this
regard. It may be preferred to use the BIT macro by some and by others
not.

Kind regards
Uffe
