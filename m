Return-Path: <SRS0=mOb4=6T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15238C47258
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 11:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E626C206D7
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 11:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAe1lcnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgEELdV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 May 2020 07:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728233AbgEELdV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2020 07:33:21 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D89FC061A10
        for <linux-mmc@vger.kernel.org>; Tue,  5 May 2020 04:33:21 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id p5so392283vke.1
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2020 04:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XbyGoPJWVWnSDkRym+hO3GL3emx5VJ8UO1Iz7FkyzXo=;
        b=kAe1lcnhk0AC+HNEKrxmbsfWWqiEmVJqjXXN1MxQazq3A4fEbFhoK9aUNx1U7rmAJ6
         +toRCf4tLAp4Y8zT96gk0ZFUwLe0D848dQh1/6BIqxgiCPzp19vMbJO0nRs7O9gL+6Es
         5dKiAG7bVfUm8wkwzvuHL7XrY9TYyxbLJ79LwefIeh8xwRja0m8oAG/aSpqAjA6+AmXw
         DgXWQhfqfeM4ZT6RkcVxwzawcCIs51Ng1T7//WHx/qOGKSsilEEMxZGR7+ZCp2KHDy2Z
         HB436HnMyTOw5bVHN294nVvnSD4P7FADwQ77H8IiSAZrj6vR+TzG7e4ZVdSf1ML42nN/
         VDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XbyGoPJWVWnSDkRym+hO3GL3emx5VJ8UO1Iz7FkyzXo=;
        b=gXZWl6svYPr2iO4hNl6zdFF2f8u9XIiB2ft8/gzwqOub5hNNThiuDGKgzy69NaQc8G
         OVdtLUToEs9r0kVDahhz6q7FIADnCFuTxSjmIbbUasryEexpwUfGv316SJtRAqdE5rAO
         kIZnyHBhHLdSpW3rcQudh9l6/O90N6e9OGXOmH7kOfGHS9SXpYtnoL3BaKF5Af8SBtDa
         nb8MixZW6rfmpADbRlG9UhDm6AQ82FexG0e+/gH1roS18idwsLVS6pWHUUcdjJ5+2h+t
         eqAyBSIDqwCN1a882qLg78WblUOrH8R7RzVBITupaGIUmYM19+djWAHW6A98QpSSPzyC
         mSlQ==
X-Gm-Message-State: AGi0Pub8+Go34wUiqMKNJuQnrkXcunMeyAniS7GLxDP/UU99swj2qfM6
        QRhmeuWAgTjNVypz10HZR0EMs6KJOXYaviCNNL0axyn+
X-Google-Smtp-Source: APiQypLpbeypU4ki+UmD5JuIgl73+i/KYp2i1XhWJ1EL1TbPRT9iSb2h8h/xOs7g1rD6SJ9y0+P6/9yASt1/vFoSHTA=
X-Received: by 2002:a1f:1a4c:: with SMTP id a73mr1887649vka.59.1588678400145;
 Tue, 05 May 2020 04:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200423130432.9990-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200423130432.9990-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 May 2020 13:32:43 +0200
Message-ID: <CAPDyKFpbNyEcyWpPCNNm_H4m204Kw8C2mHiRc3b4HZrOtSozzw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: renesas_sdhi: avoid bad TAPs for Gen3
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 23 Apr 2020 at 15:04, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> From: Wolfram Sang <wsa@the-dreams.de>
>
> Here is a series which avoids using TAPs on R-Car Gen3 SoCs which are
> bad to use according to HW engineers. The patch was originally for the
> BSP (Thanks, Saito-san) and has been upported for the upstream driver.
> Before we can apply this, we need to add some mising information for
> R-Car M3-W ES1.[23].
>
> Patches have been tested on Renesas Salvator-XS boards with R-Car H3
> ES2.0 (changing from TAP3 to TAP4 here) and R-Car M3-N (changing from
> TAP7 to TAP0 here).
>
> A branch can be found here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/new_manual_calib
>
> It is based on current mmc/next + "[PATCH] mmc: renesas_sdhi: shorten
> types after refactorization"
>
> One implementation detail: For now, I kept using a generic naming for
> the quirks, e.g. "sdhi_quirks_bad_taps2367". It is possible that we need
> to rename/add ones later which are SoC bound, e.g. "sdhi_quirks_m3w_30".
> Especially when we add manual calibration somewhen. But for now, the
> generic approach seems better to me, so I sticked to it.
>
> Looking forward to further comments and/or testing.
>
> Happy hacking,
>
>    Wolfram
>
> Takeshi Saito (1):
>   mmc: renesas_sdhi: Avoid bad TAP in HS400
>
> Wolfram Sang (1):
>   mmc: renesas_sdhi: handle M3-W ES1.2 and 1.3 revisions
>
>  drivers/mmc/host/renesas_sdhi.h      |  1 +
>  drivers/mmc/host/renesas_sdhi_core.c | 61 ++++++++++++++++++++++++----
>  2 files changed, 54 insertions(+), 8 deletions(-)
>
> --
> 2.20.1
>

Applied for next, thanks!

Kind regards
Uffe
