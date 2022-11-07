Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F426C4332F
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Nov 2022 20:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiKGUOO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiKGUOB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2022 15:14:01 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1067B2AE2C
        for <linux-mmc@vger.kernel.org>; Mon,  7 Nov 2022 12:13:52 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id j12so12081006plj.5
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2022 12:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A6b9G0SCZxoZRwMrRSH3C6wfOBkmLuDPQpwT0I2yX9Q=;
        b=WSDf0ig7BOOdDboef+ggJmeXY+xzqqVm4ytlUjbJ5ECJQwG599gRWYUvOfCFn/qzah
         FYHHGhRDBgKYj/iMnDblRQXsPoLDpgogXLg9cy3IPoUfSq1YiNDI6pByEwF+p8U7vlBK
         hGR5p8N17I5eOTLOEnZW0LzebTRa9FixOtIGsr2/0VYyNguvl6W0XGEnI5r1VaJ99A2p
         qhx3doJRqZ5JArcBujJxZqcrJp2hVybr7XNsesDA0BzRZhCJul9s+lMo4YipmGXBtLVb
         yTqYxhAzFnDYGL8cP+NR8g7ze+dLH6u1n2PdS9JZhyRk81C60k6izZ9cFMEF5fDEpDj2
         uU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6b9G0SCZxoZRwMrRSH3C6wfOBkmLuDPQpwT0I2yX9Q=;
        b=4VnlIv5Olu3mSOu8rCbArsIyZ8OmESub0dD9SCOKVIcFvjA5Mt1HNyd+m7QBT2GDrC
         8/H7ytl1fVqXc5DoQBFZAdjS8E9jBOjMsHC3GDRi0gD5D6RwH4Veq0Gm71Fl0JXPNUFn
         4+O2l2sVfMLobt+x6Z8XOMQoDWl6ZMaZP+pwXeg/BOkTwqF4m36JzlCoL7iYCpF3fUhs
         E6YmQ9LfBG/ag144Bu9xTJHpl90LltLeCm3J3yoi5tXpcH8N+dhMN/JLygEI5HQLKr2/
         xC0nsKOAzGF06R+df4J/5T3VWEedKf1SQmrlPj/WvpDPxwVxX8Rnl+IwySBjpN5udRzr
         d3CA==
X-Gm-Message-State: ACrzQf0IeRS6Is2iLi+oTIJUt9QyH+udqtS9+pEUh5o6QywPem12+KbE
        QXMEJChVywKko7qd/txPOCrtDHWD5Ygw58GbEgy2o564mCc=
X-Google-Smtp-Source: AMsMyM5vMJVy21KVcqnnT7Au3Mp0CWhuRPw7wo1kgid2M+MIB8owKUaJDcrxbTp0exHOuevBmX0h+x/eWeCQ0nS9sRs=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr53387786plb.148.1667852031705; Mon, 07
 Nov 2022 12:13:51 -0800 (PST)
MIME-Version: 1.0
References: <20221102120105.5747-1-adrian.hunter@intel.com>
In-Reply-To: <20221102120105.5747-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Nov 2022 21:13:14 +0100
Message-ID: <CAPDyKFqKu5FpeyzifzCzyvmpiCZOwD4Pqq-8Eqf_L7a=uDDYbw@mail.gmail.com>
Subject: Re: [PATCH] mmc: Remove duplicate words in comments
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Nov 2022 at 13:21, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Remove duplicate words in comments found using the following commands:
>
> pcregrep --color=always -n \
>         '([^a-zA-Z_])([a-zA-Z_]+)[[:space:]]+\2[^a-zA-Z_]' \
>         drivers/mmc/host/*.[ch] drivers/mmc/core/*.[ch] \
>         include/linux/mmc/*.h \
>         include/uapi/linux/mmc/*.h | \
>         grep -v 'long long'
>
> pcregrep --color=always -n -M \
>         '([^a-zA-Z_])([a-zA-Z_]+)[ \t]*\n[[:space:]*]+\2[^a-zA-Z_]' \
>         drivers/mmc/host/*.[ch] \
>         drivers/mmc/core/*.[ch] \
>         include/linux/mmc/*.h \
>         include/uapi/linux/mmc/*.h
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Nice way of doing things like this!

Applied for next, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/core/core.c           | 4 ++--
>  drivers/mmc/core/host.c           | 2 +-
>  drivers/mmc/host/sdhci-acpi.c     | 2 +-
>  drivers/mmc/host/sdhci-bcm-kona.c | 2 +-
>  drivers/mmc/host/sdhci-omap.c     | 2 +-
>  drivers/mmc/host/sdhci.h          | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 95fa8fb1d45f..757208b5a65c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -56,7 +56,7 @@ static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
>  /*
>   * Enabling software CRCs on the data blocks can be a significant (30%)
>   * performance cost, and for other reasons may not always be desired.
> - * So we allow it it to be disabled.
> + * So we allow it to be disabled.
>   */
>  bool use_spi_crc = 1;
>  module_param(use_spi_crc, bool, 0);
> @@ -527,7 +527,7 @@ EXPORT_SYMBOL(mmc_cqe_post_req);
>   * mmc_cqe_recovery - Recover from CQE errors.
>   * @host: MMC host to recover
>   *
> - * Recovery consists of stopping CQE, stopping eMMC, discarding the queue in
> + * Recovery consists of stopping CQE, stopping eMMC, discarding the queue
>   * in eMMC, and discarding the queue in CQE. CQE must call
>   * mmc_cqe_request_done() on all requests. An error is returned if the eMMC
>   * fails to discard its queue.
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index b89dca1f15e9..5457c8aeeea1 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -269,7 +269,7 @@ EXPORT_SYMBOL(mmc_of_parse_clk_phase);
>   * @host: host whose properties should be parsed.
>   *
>   * To keep the rest of the MMC subsystem unaware of whether DT has been
> - * used to to instantiate and configure this host instance or not, we
> + * used to instantiate and configure this host instance or not, we
>   * parse the properties and set respective generic mmc-host flags and
>   * parameters.
>   */
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index bddfaba091a9..8f0e639236b1 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -651,7 +651,7 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
>          *       instead use the SDR104 preset register.
>          *
>          *    If the above issues are resolved we could remove this quirk for
> -        *    firmware that that has valid presets (i.e., SDR12 <= 12 MHz).
> +        *    firmware that has valid presets (i.e., SDR12 <= 12 MHz).
>          */
>         host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
>
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index 61a12f2f7f03..6a93a54fe067 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -168,7 +168,7 @@ static void sdhci_bcm_kona_init_74_clocks(struct sdhci_host *host,
>         /*
>          *  JEDEC and SD spec specify supplying 74 continuous clocks to
>          * device after power up. With minimum bus (100KHz) that
> -        * that translates to 740us
> +        * translates to 740us
>          */
>         if (power_mode != MMC_POWER_OFF)
>                 udelay(740);
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 033be559a730..8ed9256b83da 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -370,7 +370,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>         /*
>          * Stage 1: Search for a maximum pass window ignoring any
> -        * any single point failures. If the tuning value ends up
> +        * single point failures. If the tuning value ends up
>          * near it, move away from it in stage 2 below
>          */
>         while (phase_delay <= MAX_PHASE_DELAY) {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d750c464bd1e..908da47ac5ba 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -345,7 +345,7 @@ struct sdhci_adma2_64_desc {
>   */
>  #define SDHCI_MAX_SEGS         128
>
> -/* Allow for a a command request and a data request at the same time */
> +/* Allow for a command request and a data request at the same time */
>  #define SDHCI_MAX_MRQS         2
>
>  /*
> --
> 2.34.1
>
