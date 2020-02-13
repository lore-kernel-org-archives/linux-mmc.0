Return-Path: <SRS0=nQxR=4B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C971DC3F68F
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 13:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04862168B
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 13:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ozoCrbCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgBMN4n (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:56:43 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35970 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbgBMN4n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2020 08:56:43 -0500
Received: by mail-ua1-f66.google.com with SMTP id y3so2278764uae.3
        for <linux-mmc@vger.kernel.org>; Thu, 13 Feb 2020 05:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jm/LAyla74Pje9uLjF10qj2ILC0qUy9rgPkylb/miHg=;
        b=ozoCrbCGv9vsI93eriaIXp1DjthK3gP16bqd4JZh3y5S+JxSMUxG88W2Hdnn5WDUBO
         WWhlbIVtucymLG4GspFI9ESJ1Ie7wTDwFW+udUNPNU9+yZSIG9QL7oDVTUPcQn7fxSHs
         7uV9VHiIbnPSP3A4jripb8JeE5dWGK+Q3KICf29UCUVzZF40YfrFAUBtD3LH0m1FmmcY
         VeKn2qHGuDGEhsN8Ieo0NAGLdHhPKec/9w75Fc0vSDybg3B0RE29Jsl+kFp0iTm9XDTb
         aJ+ZpOP0fxPDPpt9JV9CCnxVzUhj7WzvIyLcJRfJD6MPqu7avnX73WDxyNGt6U22d2H6
         gxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jm/LAyla74Pje9uLjF10qj2ILC0qUy9rgPkylb/miHg=;
        b=JhUxap/OK/UghxqVjF0LmJ/lwFb+XSk/8N90qP9LhGlPz13LeCV+K1U370xhzwriCh
         rpwpBdFcwfQEHbaentEm05cPjD32DCAQHbPwg6eqMkT0DyVGe3IWCKA9IT0n6hCi7soc
         0HTT9FdlH+ElalJlIM1WgYi38y8lNL6nv3Ms5Uk74rFdGxlHDuPm7G19SIQ2ys3ctnQ6
         zKFAYQKzi0RStFx7hv1EW+5LtHwQwy+MBVHTLFTZvy/xlAzVhdEvXXO3LbaPlRPhPIg1
         frvos6z24PrW/1trCdfKNhByGjatT/9p5wtjUfCDGuqsgBtgBpyiu2UmzPFGK+NQ1tsC
         cUzg==
X-Gm-Message-State: APjAAAW1KktbD2TW5f4O5Oir+gIaLe5OulmCJ8V85fMD/BaVMo9Hfb8o
        HPW5QBaN4RlVNirXvjnKxb+QgFL99O+mNYelD3iOWQ==
X-Google-Smtp-Source: APXvYqziDyiYnfdAWiJq7bdnX0mVuUOG7aJihW34usJdVxGekhvjtSJSIbDBQYxYQDhhLhtI3SP60+gG1ACb2O27uS8=
X-Received: by 2002:ab0:7802:: with SMTP id x2mr7660143uaq.100.1581602198751;
 Thu, 13 Feb 2020 05:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20200129203709.30493-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200129203709.30493-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Feb 2020 14:56:02 +0100
Message-ID: <CAPDyKFp-pUwKLKDz8+rvt_yoNOZeK_-pDAxbdX+r0ViLtqnEmw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] mmc: tmio: move TAP handling to SDHI driver
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 29 Jan 2020 at 21:37, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> TAP and SCC handling is Renesas specific, so it should be moved to the
> SDHI driver. After previous refactoring, this is possible now. And
> feasible, too, to simplify further HS400 corrections. IMHO it also makes
> the driver less complicated.
>
> See the patches why this series is still RFC.
>
> This is based on top of the series:
> [RFC PATCH v2 0/5] mmc: renesas_sdhi: add manual correction
>
> A branch can be found here:
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/new_manual_calib
>
> It has been tested with a Renesas Salvator-XS boards, one with a R-Car
> M3-N and one with H3-ES2.0. Tuning to HS400 still works.
>
>
> Wolfram Sang (6):
>   mmc: tmio: refactor tuning execution into SDHI driver
>   mmc: renesas_sdhi: complain loudly if driver needs update
>   mmc: tmio: give callback a generic name
>   mmc: tmio: enforce retune after runtime suspend
>   mmc: tmio: factor out TAP usage
>   mmc: tmio: remove superfluous callback wrappers
>
>  drivers/mmc/host/renesas_sdhi.h      |  5 ++
>  drivers/mmc/host/renesas_sdhi_core.c | 90 +++++++++++++++++-----------
>  drivers/mmc/host/tmio_mmc.h          | 11 +---
>  drivers/mmc/host/tmio_mmc_core.c     | 77 +++---------------------
>  4 files changed, 71 insertions(+), 112 deletions(-)
>
> --
> 2.20.1
>

Wolfram, I realize that there were potentially a few minor nitpicks to
address, but let's do that on top.

So, applied for next, thanks!

Kind regards
Uffe
