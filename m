Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92770C11F66
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Jun 2021 11:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F8D61D2A
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Jun 2021 11:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhF2Lt3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Jun 2021 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhF2Lt3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jun 2021 07:49:29 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E58AC061760
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2021 04:47:02 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id s72so4687451vkb.8
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2021 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MbmNTjEMUYPVWd2OjnExZ4CNs/u60sGS+Ve+WP4hyl0=;
        b=LhtlTDeMGE5xifJ8TTBz38mtZoinY6YRKZHsyp90PP1tc1PeKXz96oxHx/ACpuTa06
         e6TYmLCEzKxyLIIoaVc+fLNdWagO4/ZDOpiuoAcj6kCcngiPKjn88Ukxh/bKy5U6yekS
         YuIA4+fTHSDmts1zanmnVrOPWbq9HkxogP16pp7HVOH8F4WhiO0Aah8VeGZnv7jaaQJd
         gfOozLTWQ9IkJgBcVImc6/q+KJSP05cjLp5GAkBDbqK9Ii7TNEJILyIYQU2HOquAEQrW
         qg+iUznE+Ynucok06gqJrpJNrfHnV+7xXnBQ4PygKyvIxADfVn63ibSANqSorcuLvCWA
         fcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MbmNTjEMUYPVWd2OjnExZ4CNs/u60sGS+Ve+WP4hyl0=;
        b=GmPl9NrXtU7hsKnLSOVwKwPrc2LHxt0ccxsn/BEVEnZRDX9myUzoOKIo9S94riT9vE
         VU3jEyF2ix2BbYWqZyXfxG64gO5ER/6vAHY+tDgUh4WcmRZkVve2m9qNFLeZhO0OODcR
         /RvYmgsgHx6Paf9t6MmOJQEnhATbHADRDu4ZGzaUam93GaPpwIe+vMQ9TARt4KSXlbXa
         ZlC/7AQ5NVSoiX44o0q3gxPQAC7Z7uM7ql6Rz9Qpfg9szbIPH0pFimAG3mctkZtCDtCw
         vRtYNQuMhHi6W3NK+auwAb0rFWws911VQR84bRdhTlXsBT2M6bz5qJLRAeavEAAudyI+
         SBnw==
X-Gm-Message-State: AOAM5329DnqFOPmqK1fnaDEPSoTvdhfhsI4CvqHjJglrdGhmBTuG+8MW
        hKX9ybqvFeTrLvBqsWKdar5zM65Y5rT9O7W5VHx15A==
X-Google-Smtp-Source: ABdhPJxwPtxx6lpbyv2ryhDwW+UP2ojga/RnLADDUA6eIPJDopmLTNBcmtczBtTtqn0lBYgz6Dnc9qc/rdxSwU04GVE=
X-Received: by 2002:a1f:a482:: with SMTP id n124mr8025678vke.15.1624967221088;
 Tue, 29 Jun 2021 04:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210619225118.1862634-1-linus.walleij@linaro.org> <20210619225118.1862634-2-linus.walleij@linaro.org>
In-Reply-To: <20210619225118.1862634-2-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Jun 2021 13:46:24 +0200
Message-ID: <CAPDyKFppUJWcmHHzP4V1WQPRmMYe50M721kwtaLkkp6M9rz2Gg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: mmci: Implement .hw_reset() callback
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 20 Jun 2021 at 00:54, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The .hw_reset() callback is optionally called when attaching
> a host if and only if MMC_CAP_HW_RESET is set on the host,
> which can be done from the device tree by putting the flag
> cap-mmc-hw-reset in the DT node. This is sometimes helpful
> for eMMC.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Yann Gautier <yann.gautier@foss.st.com>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/host/mmci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index af2ed6013ef9..97fa5e67ca0c 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1883,6 +1883,15 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>         return ret;
>  }
>
> +static void mmci_hw_reset(struct mmc_host *mmc)
> +{
> +       struct mmci_host *host = mmc_priv(mmc);
> +
> +       reset_control_assert(host->rst);
> +       udelay(2);
> +       reset_control_deassert(host->rst);
> +}

Unfortunately, this is not the purpose of the ->hw_reset() ops.
Instead, it's supposed to be used to make a HW reset of the card, not
the controller.

> +
>  static struct mmc_host_ops mmci_ops = {
>         .request        = mmci_request,
>         .pre_req        = mmci_pre_request,
> @@ -1891,6 +1900,7 @@ static struct mmc_host_ops mmci_ops = {
>         .get_ro         = mmc_gpio_get_ro,
>         .get_cd         = mmci_get_cd,
>         .start_signal_voltage_switch = mmci_sig_volt_switch,
> +       .hw_reset       = mmci_hw_reset,
>  };
>
>  static void mmci_probe_level_translator(struct mmc_host *mmc)
> --
> 2.31.1
>

Kind regards
Uffe
