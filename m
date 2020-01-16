Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83089C33CB1
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563582075B
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SZhcyTGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgAPOkX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:40:23 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:32937 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgAPOkX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 09:40:23 -0500
Received: by mail-vs1-f67.google.com with SMTP id n27so12806009vsa.0
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2020 06:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLOtx1Cm2kQjqIZAryXlYAwPA/kH+UoHc2cF2Zi/hG4=;
        b=SZhcyTGG7LgbCVPGxPjdGPVv08lKymOWt6837KKCDp+TxAgzrZXQgE1LmFIiupUnf7
         1BsFsxjwlElet9UM98uV2cZCHigpQmncFYFAhzPnssFMpfYslkzWDSdjfD1zrXzkBZyw
         SOnnTZcPA7tgpQBETYzxXa1rSVsWpQ76+knrJ+3jF6SkAYPfynNqtOuegbyhCtDdWk8/
         fR9sm51NjZk5l/9MqcSihxSHpWab5HyxiWSZ6V80138L3yinrN9Pj4Wk/RrArxufZb82
         GFAvPdihk5fXTMzG5QkHVzKzdofdiQym3dcQpyt1H8WG7vIsREQcVnLyuxgx869CyQp8
         obwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLOtx1Cm2kQjqIZAryXlYAwPA/kH+UoHc2cF2Zi/hG4=;
        b=O4ScjNxzT+BgY4C+87RhQCK+yx19wNRb3ongmcAv197OH9Ym5EftV4Lgom7Gj7DIix
         c92/BYJYYjcx7zYEm107trfiRArlrsS2m1zdWCIcSh7+VnUmHpUZqjYfMYTPH1YTQ9bu
         nVwkPBx9rNWgnS2Xnx6hSA2Oaw/2TZutatU65nFluQ673YJR2IdPxNPeNvRO/uNx8wTL
         TeNFfI3msJXVgSLmLjaopHAMVjYctUp7QvOgl55l72lwZEZmHgzJFpQRjCL/tl6ww7Sj
         nxjRLEVAYXzZx3CdQomJGdvgfqg/10xsgEve2+cG6cK+7FN5eFpjLpnqVHsLsKID7Av6
         eGiQ==
X-Gm-Message-State: APjAAAV9awCE9vdA5EycBk/at9doZ0tx3W/g4HUFY5chFche5k3/vXRF
        cXt5GlF5Ni0AHm3h/m5Rs1XhpXBSMVUTaaiYNO/BCBn0
X-Google-Smtp-Source: APXvYqyj1RyQ4mHv6sAPKJt/aQxTv2YBBQwx5jDuljMrFdCRef4nwJ3cwMFYoYujq9ZdHOX6GrjmQ5Jm0bASvcwkKXE=
X-Received: by 2002:a67:e9da:: with SMTP id q26mr1749830vso.34.1579185622440;
 Thu, 16 Jan 2020 06:40:22 -0800 (PST)
MIME-Version: 1.0
References: <20200108143301.1929-1-faiz_abbas@ti.com>
In-Reply-To: <20200108143301.1929-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 15:39:46 +0100
Message-ID: <CAPDyKFpjFkoSy9qJ0Ehy9eD38HEfdpOjBa+3mj1SnfFKKTeiVA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fixes for Am65x controllers
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Jan 2020 at 15:31, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> The following are some fixes for sdhci_am654 driver.
>
> Patch 3 depends on patch 2.
>
> v1 of patch 2 was posted:
> https://patchwork.kernel.org/project/linux-mmc/list/?series=222279
>
> Faiz Abbas (3):
>   mmc: sdhci_am654: Remove Inverted Write Protect flag
>   mmc: sdhci_am654: Reset Command and Data line after tuning
>   mmc: sdhci_am654: Fix Command Queuing in AM65x
>
>  drivers/mmc/host/sdhci_am654.c | 54 ++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 19 deletions(-)
>
> --
> 2.19.2
>

Applied for fixes, thanks!

Kind regards
Uffe
