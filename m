Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F105DC43217
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Dec 2021 08:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345714AbhLBIm6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Dec 2021 03:42:58 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47234
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345662AbhLBImz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Dec 2021 03:42:55 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B0AB83F1EF
        for <linux-mmc@vger.kernel.org>; Thu,  2 Dec 2021 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638434372;
        bh=bzHPDCQxivWPQ9IWDe85z++O9zhlMxtBFGzHj4yUahI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=JgxLBl1sSbuKFYSMie2j5k+UiGdvwO70sgAZqu6bWcccGWQ91PZ93hd2p71DQ6w9O
         Vmd0teYK9Y8pUu/nfLbD+4tdymJPSD8u2RC9NSK9Dc1+pB4ZvWWh/A/xE9/GLznSLe
         uQg241mmk5gM9WxD37sKE3y8gMYXIimxGu9nPgIWm3y+894E7wX11WqYghzgTNPeKg
         adA+vq6oxOi772XQoywM5cUukqMVs+m8XedNVUdUj70fAMa/9SMQs5n5WlGOmocKjE
         OiTHuyqrE780IHZITjDYpfJnWKYjHncMkCP9tFPMkRY19JC6f6u37hzd6S5HkA47jP
         wwnzrfGP/VdNg==
Received: by mail-lf1-f72.google.com with SMTP id t9-20020a056512068900b00417ba105469so8610624lfe.4
        for <linux-mmc@vger.kernel.org>; Thu, 02 Dec 2021 00:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bzHPDCQxivWPQ9IWDe85z++O9zhlMxtBFGzHj4yUahI=;
        b=WeTZoogcdStj5siEkmWcxmTVQrzH8hqdRy8lb9bJuYhbOHC+wbNmNaPeIuA1B8U5NH
         VIM4y0C/+tloTsF+AgsE4mhGFzOOzicIqKBBe6qdemtSG+ZWU03+Trjp4KAZ1VBG0e+a
         5/io/01dhWl3vmITy33pH6PXu9+Zjw28iGtOxQq0FD0UETLpOZqPWgIrzN5QUrgdzDes
         EnkDz5lcVVkssTJlomptCpoXuOUmJR/tYBouC/WU/hlIhZQHK4Z6IH8PwQmLDJiNwu4r
         OjPTnbtnHuvFrOepLMfoSMPK2+xu18wpqi7zon2B+XBKhDFnf0HzEzIkMK7MW5HXd8EQ
         latw==
X-Gm-Message-State: AOAM530GoHHhY71gKsCSkeblTg9tjtAXwiuMC/8uXOwZVT/lnh5egnZX
        S7D+iWU6/kaDKghZYIwXUYvtXRjbgZ8gtA0zngcUC8/sCxLjGDTmpWsAC9S5OR1iLN6xvVSTw7k
        9n9YAgOt47ey/dk0rJzBjLvvApBDfi4JQEujBWg==
X-Received: by 2002:a05:6512:3322:: with SMTP id l2mr10573104lfe.556.1638434371888;
        Thu, 02 Dec 2021 00:39:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJza7lLCAo9zxOj1HYXolUOQdlHjybMWwBpr86P/vqEMZGuzy2NQ5lsVP5PlD1kw9r9I8wo+IA==
X-Received: by 2002:a05:6512:3322:: with SMTP id l2mr10573087lfe.556.1638434371687;
        Thu, 02 Dec 2021 00:39:31 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id z14sm260458lfg.173.2021.12.02.00.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 00:39:31 -0800 (PST)
Message-ID: <2875d5c8-dc98-0e3c-41b8-c71bd439ced4@canonical.com>
Date:   Thu, 2 Dec 2021 09:39:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 3/4] mmc: dw_mmc: Add quirk for extended data read timeout
Content-Language: en-US
To:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     Doug Anderson <dianders@google.com>, kernel@axis.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211201153804.27655-1-marten.lindahl@axis.com>
 <20211201153804.27655-4-marten.lindahl@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211201153804.27655-4-marten.lindahl@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 01/12/2021 16:38, Mårten Lindahl wrote:
> Current dw_mci driver supports a TMOUT register which consists of a 24
> bit field (TMOUT[31:8]) for the DATA_TIMEOUT. The maximum value of this
> field is 0xFFFFFF, which with a 200MHz clock will give a full DRTO of:
> 
> 0xFFFFFF / 200000000 => ~84 ms
> 
> However, the ARTPEC-8 SoC DWMMC IP version has a TMOUT register with an
> extended DATA_TIMEOUT field, which supports longer timers for the DRTO.
> In this version the DATA_TIMEOUT field is split into two, which with the
> same 200MHz clock as above will allow a maximum timeout of:
> 
> ((TMOUT[10:8] -1) * 0xFFFFFF + TMOUT[31:11] * 8) / 200000000 => ~587 ms
> 
> Add a quirk to support this. The quirk is enabled for ARTPEC-8 SoCs.
> 
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |  5 +++++
>  drivers/mmc/host/dw_mmc.c        | 33 ++++++++++++++++++++++++++++----
>  drivers/mmc/host/dw_mmc.h        |  7 +++++++
>  3 files changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index cae7c94b5d6e..6ae9c0ec1282 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -127,6 +127,11 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
>  				DQS_CTRL_GET_RD_DELAY(priv->saved_strobe_ctrl);
>  	}
>  
> +	if (priv->ctrl_type == DW_MCI_TYPE_ARTPEC8) {
> +		/* Quirk needed for ARTPEC-8 SoCs */
> +		host->quirks |= DW_MMC_QUIRK_EXTENDED_TMOUT;
> +	}
> +
>  	host->bus_hz /= (priv->ciu_div + 1);
>  
>  	return 0;
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index f2a14a434bef..45ea9fd97a6a 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1289,6 +1289,7 @@ static void dw_mci_set_data_timeout(struct dw_mci *host,
>  {
>  	u32 clk_div, tmout;
>  	u64 tmp;
> +	unsigned int tmp2;
>  
>  	clk_div = (mci_readl(host, CLKDIV) & 0xFF) * 2;
>  	if (clk_div == 0)
> @@ -1301,10 +1302,28 @@ static void dw_mci_set_data_timeout(struct dw_mci *host,
>  	tmout = 0xFF; /* Set maximum */
>  
>  	/* TMOUT[31:8] (DATA_TIMEOUT) */
> -	if (!tmp || tmp > 0xFFFFFF)
> -		tmout |= (0xFFFFFF << 8);
> -	else
> -		tmout |= (tmp & 0xFFFFFF) << 8;
> +	if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT) {
> +		/*
> +		 * Extended HW timer (max = 0x6FFFFF2):
> +		 * ((TMOUT[10:8] - 1) * 0xFFFFFF + TMOUT[31:11] * 8)
> +		 */
> +		if (!tmp || tmp > 0x6FFFFF2)
> +			tmout |= (0xFFFFFF << 8);
> +		else {
> +			/* TMOUT[10:8] */
> +			tmp2 = (((unsigned int)tmp / 0xFFFFFF) + 1) & 0x7;
> +			tmout |= tmp2 << 8;
> +
> +			/* TMOUT[31:11] */
> +			tmp = tmp - ((tmp2 - 1) * 0xFFFFFF);
> +			tmout |= (tmp & 0xFFFFF8) << 8;
> +		}
> +	} else {
> +		if (!tmp || tmp > 0xFFFFFF)
> +			tmout |= (0xFFFFFF << 8);
> +		else
> +			tmout |= (tmp & 0xFFFFFF) << 8;
> +	}
>  
>  	mci_writel(host, TMOUT, tmout);
>  	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%#08x",
> @@ -2005,9 +2024,15 @@ static void dw_mci_set_drto(struct dw_mci *host)
>  	if (drto_div == 0)
>  		drto_div = 1;
>  
> +	if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT)
> +		drto_clks = (((drto_clks & 0x7) - 1) * 0xFFFFFF) +
> +			((drto_clks & 0xFFFFF8));
> +
>  	drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
>  				   host->bus_hz);
>  
> +	dev_dbg(host->dev, "drto_ms: %u\n", drto_ms);
> +
>  	/* add a bit spare time */
>  	drto_ms += 10;
>  
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 771d5afa3136..071f4479f166 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -118,6 +118,7 @@ struct dw_mci_dma_slave {
>   * @part_buf: Simple buffer for partial fifo reads/writes.
>   * @push_data: Pointer to FIFO push function.
>   * @pull_data: Pointer to FIFO pull function.
> + * @quirks: Set of quirks that apply to specific versions of the IP.
>   * @vqmmc_enabled: Status of vqmmc, should be true or false.
>   * @irq_flags: The flags to be passed to request_irq.
>   * @irq: The irq value to be passed to request_irq.
> @@ -223,6 +224,9 @@ struct dw_mci {
>  	void (*push_data)(struct dw_mci *host, void *buf, int cnt);
>  	void (*pull_data)(struct dw_mci *host, void *buf, int cnt);
>  
> +	/* Workaround flags */

No need for this comment - you already described the field in kerneldoc.

> +	u32			quirks;
> +
>  	bool			vqmmc_enabled;
>  	unsigned long		irq_flags; /* IRQ flags */
>  	int			irq;
> @@ -274,6 +278,9 @@ struct dw_mci_board {
>  	struct dma_pdata *data;
>  };
>  
> +/* Support for longer data read timeout */
> +#define DW_MMC_QUIRK_EXTENDED_TMOUT	(1<<0)

BIT()

> +
>  #define DW_MMC_240A		0x240a
>  #define DW_MMC_280A		0x280a
>  
> 


Best regards,
Krzysztof
