Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA25C53210
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Jan 2023 15:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjABPHa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Jan 2023 10:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbjABPHI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2023 10:07:08 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE2A25D6
        for <linux-mmc@vger.kernel.org>; Mon,  2 Jan 2023 07:07:07 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jl4so23493107plb.8
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jan 2023 07:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6DplKz/bdbUn4I1drkD6LUlMhNXhcjCCxMqIdGwR6jA=;
        b=qqRjprM8LCe/yNVm2wYWqIbwmA2zv+bEGnk0qTVjpVlTDRbmE9lV2y2LKXZcueri4h
         OsRUHz7yNFE2/4hoRKl/R+5O+CzaJ4uunl+3rYMutDM0yNlaQLVKw0tZMs+DcQcKX62U
         0lULqsi5vEBper87ambl0Amg6GlGhnNHpGxSko7NDUKDb5ySXIHipt/5dITwwV6FlRFa
         FAJhaJz3xIkHQPP1s7J0McxCzfY1tbE2x/KG+nR7/7HpndSEgN9iBZYQOXhDRZHd6kay
         gew3+ESgUX23Bdd8ysrUTPBVuX+MPtM1JhpvhLqTX4z+s3WI8+Mi1XES7uqrljKFazen
         k5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DplKz/bdbUn4I1drkD6LUlMhNXhcjCCxMqIdGwR6jA=;
        b=O0fK2bTraipK7JjpxVFoWGDsfajwuDEVxzmsKrlDIkeOBOh1YU+nC9o2CHzKlWcNDA
         dmnMZL1Mnd8hmrfBafNybDvwmv1PimvCdHRhwI3jmNMI5TswOPWp6i1b7jFWRwAflx79
         LaXteNOh/Jb9aasRVjAj4otbJXzdrqBVJk+ftpO29EY35ROIaNGScKUi5OeDcNTK/fbh
         9nlfzLglxUuZl43wrleZS21ovZjv77wsmIlcvzhbzZ/jarUarJsclAAOfRlh29NmYu7v
         97TU5qXbiC5FZxhXw5dWD0/P/S8Swnc+JJO4XwXhF5RN7bTUJrNeW2znVyX98lC92wrX
         oQCg==
X-Gm-Message-State: AFqh2krLpndm0L5qf9Uvlm+kLlDZgXp4h8+8VbisdaE9Wc4J2OBVcEDf
        ADhsRAKQknV4tf0VgPNjK5rys8bPS46kMUZOP6b3rw==
X-Google-Smtp-Source: AMrXdXum0ZuGHHRxd9dbaKOzoVvRRRc/Jq5n7+i+DBDWy4+YOBN+r2yUToiRbrwGRMNlDwNaRtF+tGEfQbyQ12o5g3A=
X-Received: by 2002:a17:902:b902:b0:190:e27b:b554 with SMTP id
 bf2-20020a170902b90200b00190e27bb554mr2443807plb.148.1672672027019; Mon, 02
 Jan 2023 07:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20221223025022.1893102-1-haibo.chen@nxp.com>
In-Reply-To: <20221223025022.1893102-1-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 16:06:30 +0100
Message-ID: <CAPDyKFrYNThzEq_4vfb86U+ZNeybRKYkmKk8cMYEW7c5Co8+3g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] fix the sdio device DATA/CMD CRC and Timeout issue
 after tuning
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        kgroeneveld@lenbrook.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 23 Dec 2022 at 03:50, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> V3:
>   - involve init_card() callback instead of change the common code.
>
> V2:
>   - drop the dts/dt-binding change, since this is one IC limitation,
>     so handle this directlly in driver.
>   - simply the auto tuning code logic.
>   - To detect the SDIO device in host driver side, add some change
>     in common code, move host->card = card a bit upper.
>
> Haibo Chen (2):
>   mmc: sdhci-esdhc-imx: simplify the auto tuning logic
>   mmc: sdhci-esdhc-imx: only enable DAT[0] and CMD line auto tuning for
>     SDIO device
>
>  drivers/mmc/host/sdhci-esdhc-imx.c | 66 ++++++++++++++++++++++++++----
>  1 file changed, 57 insertions(+), 9 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
