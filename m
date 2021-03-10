Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFE4C433E6
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 20:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D3D364FC8
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 20:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCJU6f (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Mar 2021 15:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231293AbhCJU6U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 10 Mar 2021 15:58:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED4D664EE8;
        Wed, 10 Mar 2021 20:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615409900;
        bh=pRdp6Or+xWH9uQm/XD+ddLGeOs+oJVy1HPUmgvyVhfI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qnrnn+ZvxH0YHuXXsI/nLVbDxnrjE+Gd1pmUDVRXEvwgTHJ3jIUdNaUuKbC0djob7
         2ZAMcvq+dzH14VfYeQ7QMIQQ/iE4u+E02BhRY9Fj+3BWAVEl9sH6S913pa5tuFQ8AK
         kFmQSJaHycvKKwhtnxMN5efcyzK9GLSUjNcvwukMMe7V6TJFWlOM8QgBClHGUTdAO8
         tj7g2amwdfwoaj0bkSUq4F8IjyVeJcsm50Dzoecdk1G6g50C8ihD/HYmair0eTvOHj
         Ml+D+Aq5hOJYmQQcZ/nb1tM2lBbt25lUem1PnIr7Gy/1SCFGTVrVlIdYyT2az9JScA
         Ixh2FLDot/W3A==
Received: by mail-ej1-f54.google.com with SMTP id jt13so41608340ejb.0;
        Wed, 10 Mar 2021 12:58:19 -0800 (PST)
X-Gm-Message-State: AOAM530gqu2Oo53fnbXCuWZ+l+wwxxr5VN3qlRvl4w+M5MmWH7o8m5J0
        K7Cjl7Ep33/nhKvceaCFfCibHnNiUGIS4liv1Q==
X-Google-Smtp-Source: ABdhPJw0cfBK+wxXYoeL+KV83s9r5gdTg3TpXOSPGEAiK5qMN3apGPP2k4JS/2HWZwYXB2MoQtWXYO1Wozz1AHBqMzY=
X-Received: by 2002:a17:906:7d48:: with SMTP id l8mr333166ejp.108.1615409898298;
 Wed, 10 Mar 2021 12:58:18 -0800 (PST)
MIME-Version: 1.0
References: <1615254990-192784-1-git-send-email-shawn.lin@rock-chips.com>
 <1615254990-192784-2-git-send-email-shawn.lin@rock-chips.com>
 <20210310030122.GA1664258@robh.at.kernel.org> <9f8b3be6-d87e-d944-d5db-67f3bcf0fad0@gmail.com>
 <7573e8c1-3f55-9925-bc14-534455f1ffa3@rock-chips.com>
In-Reply-To: <7573e8c1-3f55-9925-bc14-534455f1ffa3@rock-chips.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Mar 2021 13:58:06 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKTvzmskPL5eNVCzMmS7YO4oiyGdrf1+73ET1_DfgjPyQ@mail.gmail.com>
Message-ID: <CAL_JsqKTvzmskPL5eNVCzMmS7YO4oiyGdrf1+73ET1_DfgjPyQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add rockchip support
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Mar 10, 2021 at 2:37 AM Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
>
> On 2021/3/10 15:00, Johan Jonker wrote:
> > On 3/10/21 4:01 AM, Rob Herring wrote:
> >> On Tue, Mar 09, 2021 at 09:56:29AM +0800, Shawn Lin wrote:
> >>> This patch adds rockchip support in sdhci-of-dwcmhsc.yaml
> >>>
> >>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >>> ---
> >>>
> >>> Changes in v3: None
> >>>
> >>>   .../bindings/mmc/snps,dwcmshc-sdhci.yaml           | 24 ++++++++++++++++++++++
> >>>   1 file changed, 24 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> >>> index f99fb9f..43989f2 100644
> >>> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> >>> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> >>> @@ -16,6 +16,7 @@ allOf:
> >>>   properties:
> >>>     compatible:
> >>>       enum:
> >
> >>> +      - rockchip,dwcmshc-sdhci
> >
> > Compatible strings are supposed to be SoC orientated.
> > What SoC was this change for? rk3568 ?
> > Could Shawn confirm that?
>
> Yes. We are inclined to use this controller from now on for a
> long time for up-coming SoCs. Should we tag compatible for rk3568
> specified? One of the negative things I could come up with is that we
> do this for dwmmc-rockchip, but we end up doing nothing else,
> except for adding new compatible string again and again in Document.

Yes, you should make this SoC specific.

It's one line patches if nothing else changed.

> >
> >           - rockchip,rk3568-dwcmshc-sdhci ??

I'd shorten it to 'rockchip,rk3568-dwcmshc'.

> >
> > Could Rob advise here?
