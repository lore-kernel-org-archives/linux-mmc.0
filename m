Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7FDC07E9D
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Sep 2022 12:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiI0MOt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Sep 2022 08:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiI0MOk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2022 08:14:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A8DB493
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 05:14:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z6so14735819wrq.1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 05:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=K5bhQFM6cdwYGK7zEmf7+6Ox07lt75ToNJlyJel3u1M=;
        b=KNN92b3pIFdjbzjwnEl3rnyvhjP60yIlXIDRfEMGxlO6lOTMldNHEqkBuIOiqc3rIs
         RtAShtBdU9Q+DlvKk2yoyinoU71y3cjFAZVhr4IcKnrkmh6wockl2eHNHbokUhwprdjL
         bCPwd6594M2/IZiPrBj3oQyVl3nh7PUB6wHmVCDpgGAxKC3wD4MmxOBSUzrH/LS6nFJe
         jwF9cpzLH48xZn+kZlauMyMuO5LDyd9QIUyFBMzIen70vyRa1HtcPSGUWo8L3+EaAQx8
         AcEY7ne1jp07paUrApj8vsobzfIXUASm4NF5zRGpySk3XKHGBf4IAw7hOmS14qH+N0sZ
         dFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=K5bhQFM6cdwYGK7zEmf7+6Ox07lt75ToNJlyJel3u1M=;
        b=adP8yj1gWDZmgg26teq+4noiOqhj+zqgG8Hkot/N4FmrGyys5dMe8tP4OpaZRfZx/e
         do45inxQmguUzy9LlG7qbZ0jQgB2/xq6ADDDFzaeZ4x3wa3RzaIG6kvsYULyC+zsDYuA
         bVgouPA30Nu3j6V6bUiN4MRwcOlhRxy8uKYy/ZGQnIPpjlumBMxj5jv75UYi45r70/k5
         l9d0fwkjYxdzY2RfV70XqUathpoD0w5U6DZ072hve5dHqxRyVaHrgmuKEx57p16jU3HT
         j2cAD/n0nDiLQabxTPXTt9FrEFxsZGVqB7JHzVNXtBE3YN0bHYoYi/1h0kBZtXtaR/qs
         B9TQ==
X-Gm-Message-State: ACrzQf0J0SvUoIgQTF9tQWeENDI9y7O/ATfokX+HgARGLuU+GhcMVo2Q
        8mCn56ZiLN2sT1/wewSRCIDue4IY9tsxzF7WRJjJ+Q==
X-Google-Smtp-Source: AMsMyM6XJJEl1yowqN3tXdesQwFszvVHgiT+Ssv2FIGYCo7+gnklhn6hbeNu8sGq/CqjPBcd+M7UePw6iBgFN/Y6bc0=
X-Received: by 2002:a5d:588f:0:b0:22b:5cc:e1d3 with SMTP id
 n15-20020a5d588f000000b0022b05cce1d3mr15755133wrf.142.1664280874087; Tue, 27
 Sep 2022 05:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220926192022.85660-1-adrian.hunter@intel.com>
In-Reply-To: <20220926192022.85660-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Sep 2022 14:13:58 +0200
Message-ID: <CAPDyKFpe_h8H+6JGzqpik75Eijz=UpZZwooScZj+qTjUHJawyg@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: sdhci: Tidy reset handling
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     pshete@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 26 Sept 2022 at 21:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> When reviewing the patch "mmc: sdhci-tegra: Issue CMD and DAT resets
> together" currently on the mailing list:
>
> https://lore.kernel.org/linux-mmc/20220926094906.14537-3-pshete@nvidia.com/
>
> it seemed like some small tidy up was needed first.  Hence these patches.
>
> In particular, patch 4 "mmc: sdhci: Centralize CMD and DATA reset handling"
> should enable the proposed quirk from the sdhci-tegra patch to be
> implemented in a more consistent way.
>
>
> Adrian Hunter (4):
>       mmc: sdhci: Separate out sdhci_reset_for_all()
>       mmc: sdhci: Remove misleading comment about resets
>       mmc: sdhci: Get rid of SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS
>       mmc: sdhci: Centralize CMD and DATA reset handling
>
>  drivers/mmc/host/sdhci-pci-core.c | 23 ++++++++++-
>  drivers/mmc/host/sdhci.c          | 84 ++++++++++++++++++++++++---------------
>  drivers/mmc/host/sdhci.h          |  2 -
>  3 files changed, 73 insertions(+), 36 deletions(-)
>
>
> Regards
> Adrian

Applied for next, thanks!

Kind regards
Uffe
