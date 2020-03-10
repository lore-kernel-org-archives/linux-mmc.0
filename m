Return-Path: <SRS0=AZQG=43=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D703AC10F27
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 15:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA81208E4
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 15:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovGRu8ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgCJP5m (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:57:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42361 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCJP5m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Mar 2020 11:57:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id q19so14723796ljp.9
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2020 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIgWMEUEnzMUO5qeAJf+3Sy0SHnEGgfI7oeBzr66tew=;
        b=ovGRu8ipxa47t0zw1KebClXw0/944SlzIpp67xXgYdRgvllfT8RC809EJv5QuPXRrk
         Bx+cMaLKKTLNMvBOGBMUm0GQZtSZktIFmeU9uTzhhNUX80gAMphm2F02fcKkqiCpetmo
         DGGZouiZP3MaKx6XjW3PRa8GL57lCIjBsIyBupB1yk0Fcq6xkjKFwm1JiQ1RQWlUK5QA
         06qLju0WCU/+jNY0UsOEOLDA7ce8fCAV9QgUsVkK2d3LLlmeCb6brm68vtG5K5w/udAX
         0ExA01rcUlF/MftY49JvahD4/X8trd54Rti/iUqMrC4KgUOU+G6FVZlw7qs4gBCfQs7x
         6ymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIgWMEUEnzMUO5qeAJf+3Sy0SHnEGgfI7oeBzr66tew=;
        b=Ia7zPCMWop+GiHEg7MNUHGik+w5sdg8uGZiHP5OId7wD6k2zUpEY1qRmSqPuAOOF45
         WboBb96kevlRS99irI8MNW1KxpvTYVdiVPjPzVPaJoCa/VO4MiNC2SnJgthADNSAUSxZ
         4AhiaZKM31EvIduYrrgyR4qZ61Yqm7ZuWePAyNC37u8B7g1+a0qEnse+sFhMRhvh25vw
         batt23A2YYKAbTi6I0TSfHoOMvmsZUYWkqJBxwXMzPyveHxOZLQWaU1Utdqa4lxaGXcb
         99d26vOXtqO3fMjjpVwmVr51sFUyicEreQwnxIZQdmBkmwwldw8dFuYSzYt01SpOduoS
         Cn0A==
X-Gm-Message-State: ANhLgQ2uc+qLrlhrOg9RW84HfB+zfkFooO1WzpWa9Ph+T360xb5JavtK
        0MVkSdVZ6V2mlZinVfWPvmHOQqR6oKt+OxYKuyS6uw==
X-Google-Smtp-Source: ADFU+vuGpCpxs2yPlXNtDk+H1pPsUzYSuFgKRf+Y+DyZWDW5vHdGOWwvlLaMY9QcmRqMp3GGcpu4Tc1La+rkkHACUrw=
X-Received: by 2002:a2e:2a44:: with SMTP id q65mr13377815ljq.8.1583855860282;
 Tue, 10 Mar 2020 08:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200310153340.5593-1-ulf.hansson@linaro.org>
In-Reply-To: <20200310153340.5593-1-ulf.hansson@linaro.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 10 Mar 2020 16:57:29 +0100
Message-ID: <CADYN=9Lu5F4Zom5KJc04jaxfA6UEaXWRADwqs=h5dFQg_1pSZw@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: Fix busy detection timeouts for some SDHCI variant
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl,
        Bitan Biswas <bbiswas@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 10 Mar 2020 at 16:33, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The mmc core may decide (for CMD6 and erase/trim/discard operations) to convert
> from using an R1B response into using an R1 response, in cases when the needed
> busy timeout exceeds the host's maximum supported HW max_busy_timeout. The core
> does this to prevent the host from doing HW busy detection and instead rely on
> polling, as to cope with the needed busy timeout.
>
> However, it has turned out that some SDHCI variants (tegra, omap), really
> requires R1B for all commands that have this response associated with them. This
> became especially obvious when commit 24ed3bd01d6a ("mmc: core: Specify timeouts
> for BKOPS and CACHE_FLUSH for eMMC") (and a few other commits on top) got
> introduced in v5.6-rc1, as several people reported errors (thanks!). More
> precisely, the mentioned commit triggered the existing problems described above
> in the SDHCI variant drivers, when an eMMC cache flush command (CMD6) was
> issued.
>
> This series fixes these problems, but the changes are also targeted for stable
> releases as the problems have existed since a long time back.
>
> Please help out in testing this!

Tested-by: Anders Roxell <anders.roxell@linaro.org>

I tested it on a beagleboard x15.

Cheers,
Anders

>
> Kind regards
> Ulf Hansson
>
>
> Ulf Hansson (4):
>   mmc: core: Allow host controllers to require R1B for CMD6
>   mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for erase/trim/discard
>   mmc: sdhci-omap: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
>   mmc: sdhci-tegra: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
>
>  drivers/mmc/core/core.c        | 5 ++++-
>  drivers/mmc/core/mmc_ops.c     | 6 ++++--
>  drivers/mmc/host/sdhci-omap.c  | 3 +++
>  drivers/mmc/host/sdhci-tegra.c | 3 +++
>  include/linux/mmc/host.h       | 1 +
>  5 files changed, 15 insertions(+), 3 deletions(-)
>
> --
> 2.20.1
>
