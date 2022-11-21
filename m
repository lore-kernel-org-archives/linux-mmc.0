Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC576C4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Nov 2022 20:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKUUaH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Nov 2022 15:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKUUaG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2022 15:30:06 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFF8D92FE
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2022 12:30:02 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so5970478pjc.2
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2022 12:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=myNR1dHCzOToepErRrsD8EFVvG4FbDL4QiAIuBT0+Ok=;
        b=u7VlmPLF/RvGHIzZiQ5Uh0MzRhuDgphVQ8PBip5YmeAO7Z7FdNN0Igspn5h05rjCwU
         H6QRi9//TntfDBFM0bG4o9KSnOP96Z8EmU38+lO1vscPaEVFAbbKnibmv4LbbWk59jJH
         BVR9YtqYk6xFQtDYFPFTq/k3lnWExzWA1i9hSIyXnnfGxUE/zjbPcXUVvguBo6deXoK1
         IhEePpS3rZ5L6CcFF1kFTO+YDp0OUGMy0+FcX0gfZrWruWHgQphM8sjzGXuF4OQPci0O
         7+rNNJKGXzjQNevCHEhwj2s85oBa7gqrncz85RHpE95IZpy0QOc8KQti8MRlsGTPjex7
         IKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myNR1dHCzOToepErRrsD8EFVvG4FbDL4QiAIuBT0+Ok=;
        b=oHay2KvMmLOVb/aH8o+a6Qgm7kJyzfop7Owx1T5wxr1YBZg3KfWaBTP1fj7dtVHYF0
         eRIUnTqJNrvms7W4QpNQLrkIkFQtr5lZVITlTeDwInXoTx3r0U5X5rK5IuDshZfNzUMx
         9rH2+yunv9q3VaMkKzYmcQDN+2bcTA7Krg/zu31H9d/UpQ4KSQenHJICQof61Z3h7YIn
         vMJIgse1L+joDtgTBkcbBM0XAEaZRbFBLIoXuun1r8zr9pkaY1LAQpacj/7xcKXEFaHo
         ewiBJgVeayV+zpZwDaTkPhH6snOqwwHlEryBSB57xRNSFS4R/eZWC7aAET2+Itdu51fv
         qT5g==
X-Gm-Message-State: ANoB5pni2UCwNGSUW22YksDaEaH3vfsuPR5iy/Y6DmLR9MqVpU/csE3q
        XzgYWk94nN8x5wr0slyxA3miOsywe8FztrvdhrrUqZhhdO8=
X-Google-Smtp-Source: AA0mqf7ZrUy+0ZfCtjXsI8kHFev3U9+wk0wofNjh90U1cdOVcEMC95/tWTvBR/GxZKZ3Ov4MfHVlNRNVNIEi1qMI4o4=
X-Received: by 2002:a17:902:b283:b0:186:be05:798e with SMTP id
 u3-20020a170902b28300b00186be05798emr521420plr.37.1669062602054; Mon, 21 Nov
 2022 12:30:02 -0800 (PST)
MIME-Version: 1.0
References: <20221120113457.42010-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20221120113457.42010-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Nov 2022 21:29:25 +0100
Message-ID: <CAPDyKFqEw7zr3XH6zM14UgFOscbC11ovSNpC5k2OyGhb6=6=2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] mmc: renesas_sdhi: upport improvements from BSP
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 20 Nov 2022 at 12:35, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> This series upports two BSP improvements in a refactored way. BSP patch
> de9461ece1fa ("mmc: renesas_sdhi: scc_ctl is always set in after R-Car
> Gen3") made sure we have a pointer to always reset SCC. I refactored it
> to include Gen2 as well, so we can optimize the following code a bit.
> This is patch 1. BSP patch 15d7abbfc3f0 ("mmc: renesas_sdhi: reset
> calibration register") added a new quirk for devices which always should
> disable HS400 adjustment. This was only applicable for SoCs which either
> had bad_taps or needed a calibration table. So, I simply used this logic
> directly instead of a quirk. This is patch 2.
>
> Two cleanups come afterwards. To increase readability, I finally did
> something I wanted to do for some time now. Having a helper to check for
> SDHI quirks. This is patch 3. And while working on this, I discovered a
> new macro from the MMC core which we can make use of. This is patch 4.
>
> The series has been tested on a Salvator-XS (R-Car M3-N) and a Lager
> (R-Car H2) board. The patches are based on mmc/next as of today as they
> depend on d901e2ba566 ("mmc: renesas_sdhi: take DMA end interrupts into
> account"). A branch can be found here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/for-6.2
>
> Let me know what you think!
>
> Happy hacking,
>
>    Wolfram
>
> Changes since V1:
> * added another improvement to the series
> * reordered cleanups last so backporting fixes is easier
>
>
> Wolfram Sang (4):
>   mmc: renesas_sdhi: alway populate SCC pointer
>   mmc: renesas_sdhi: better reset from HS400 mode
>   mmc: renesas_sdhi: add helper to access quirks
>   mmc: renesas_sdhi: use new convenience macro from MMC core
>
>  drivers/mmc/host/renesas_sdhi.h               |  2 ++
>  drivers/mmc/host/renesas_sdhi_core.c          | 29 ++++++++++---------
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  8 ++---
>  3 files changed, 21 insertions(+), 18 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
