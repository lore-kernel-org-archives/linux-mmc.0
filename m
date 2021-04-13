Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764B1C43460
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Apr 2021 15:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515E5613B3
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Apr 2021 15:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhDMPiB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Apr 2021 11:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhDMPh7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Apr 2021 11:37:59 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F8FC061756
        for <linux-mmc@vger.kernel.org>; Tue, 13 Apr 2021 08:37:39 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u4so19855971ljo.6
        for <linux-mmc@vger.kernel.org>; Tue, 13 Apr 2021 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5/FrSblRNF16xo12z2HXymizhLrS+DD0LJX4Kh417pE=;
        b=nyk6OmlI78zH/+ehzoCzVD7l2s4uZ2l/xDGYYMH4G3CTs2X16wNS4OC6u8u274LuId
         cPvKviltOINNN6L+IwS+4T0FbvVGvtpR7wuIoJlVCwfqCkTk0m4nSlB9she3hsoddYfT
         EYPUeMAcSrMI+OZaloGdmIzP598JLEfyMK7F8CUzdOeXVZrxJaGhdgMaOdwWkhcT8Bcs
         0QCO2JfF4VT6fWl8YxfL01dyf0UoxfFaOPc00sqN4DuqDfz94K+rYHIQ/KyT86xAVo8H
         tPrZrjnqW9ETMlXj9hd4A71YGA/kzguhLnN9GzWZKSZGg0w4UKntAtbvmv2lmzwq+k4K
         JB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5/FrSblRNF16xo12z2HXymizhLrS+DD0LJX4Kh417pE=;
        b=SEEtuQp4vS7ZvRQ0t5Qes7GGSfV1Xe7Yb8QjyXXGwvt9tQkH3IXc1xpao/5HuaGcb2
         HzeEnmvCONF0a5cYpCGK/qrKwTeKyS8Esgi7i1ibefUprMP3wa0ryKYZsToheSKV+NQ4
         QNx1wZo9/oVvGS11oMG3ywJMWp+jPVMq5/K+kuF0NT4RreHXeEKh/x5iVrdCL0P6RsI7
         MidtNfBZ7CS37XcdhOgFWYNuJkM8dJdXAxTg1yhtlN0xOPE/m85wWlBqdWtaPD4dDSu4
         EULywLfqCxpPmfp2GAvIv6Zqc2AY7jwgpgTG70j8U64bCbs2MEjsp41v2A0TUYiOWWo4
         fzeQ==
X-Gm-Message-State: AOAM531Q+5N8+CIIVSinju5nZFqdu1v5UpKHrdSHGX7ZzCxqA/PdSwjL
        38TkNVPGPjWSrtAUeJRoDaNE8N8ig9+fhA==
X-Google-Smtp-Source: ABdhPJy5CTxHJJZ7rBDm7c1bgdcR01FgpP/HfEVuSUpsxCQM9v+AoVVEDk9jsd0deSXnO0Hvm2D0pw==
X-Received: by 2002:a2e:a7d2:: with SMTP id x18mr4962085ljp.335.1618328257833;
        Tue, 13 Apr 2021 08:37:37 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id g29sm3487663lfj.267.2021.04.13.08.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:37:37 -0700 (PDT)
Date:   Tue, 13 Apr 2021 17:37:36 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v2] mmc: tmio: always restore irq register
Message-ID: <YHW6wD1XmeYV6L5M@oden.dyn.berto.se>
References: <20210413083137.11171-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210413083137.11171-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2021-04-13 10:31:37 +0200, Wolfram Sang wrote:
> Currently, only SDHI on R-Car Gen2+ reinitializes the irq register
> during reset but it should be done on all instances. We can move it from
> the SDHI driver to the TMIO core, because we now have the
> 'sd_irq_mask_all' variable which carries the proper value to use. That
> also means we can remove the initialization from tmio_mmc_probe()
> because it calls tmio_mmc_reset(), too. We only move that
> tmio_mmc_reset() call there a little to ensure 'sd_irq_mask_all' is
> properly set.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I like patches like this.

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> 
> Changes since v1:
> 
> * use direct register write to initialize irq register instead of
>   masking bits. Also initialize the cache variable directly.
> 
>  drivers/mmc/host/renesas_sdhi_core.c |  2 --
>  drivers/mmc/host/tmio_mmc_core.c     | 11 ++++++-----
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index d36181b6f687..635bf31a6735 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -588,8 +588,6 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host)
>  		renesas_sdhi_scc_reset(host, priv);
>  	}
>  
> -	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, TMIO_MASK_ALL_RCAR2);
> -
>  	if (sd_ctrl_read16(host, CTL_VERSION) >= SDHI_VER_GEN3_SD) {
>  		val = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT);
>  		val |= CARD_OPT_EXTOP;
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 0c474d78b186..7dfc26f48c18 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -192,6 +192,9 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
>  	if (host->reset)
>  		host->reset(host);
>  
> +	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
> +	host->sdcard_irq_mask = host->sdcard_irq_mask_all;
> +
>  	tmio_mmc_set_bus_width(host, host->mmc->ios.bus_width);
>  
>  	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
> @@ -1176,13 +1179,11 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
>  	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
>  		_host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
>  
> -	_host->set_clock(_host, 0);
> -	tmio_mmc_reset(_host);
> -
> -	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
>  	if (!_host->sdcard_irq_mask_all)
>  		_host->sdcard_irq_mask_all = TMIO_MASK_ALL;
> -	tmio_mmc_disable_mmc_irqs(_host, _host->sdcard_irq_mask_all);
> +
> +	_host->set_clock(_host, 0);
> +	tmio_mmc_reset(_host);
>  
>  	if (_host->native_hotplug)
>  		tmio_mmc_enable_mmc_irqs(_host,
> -- 
> 2.30.0
> 

-- 
Regards,
Niklas Söderlund
