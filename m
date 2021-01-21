Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113FAC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 21:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B826B23381
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 21:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbhAUVW5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jan 2021 16:22:57 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3388 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbhAUVW1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2021 16:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611264146; x=1642800146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IU7N6M9WqExUVmZAY20bnYzUlhHSkV8kquJkto9eAP0=;
  b=GjPJPFatPWvDhqT9JS7d0Y5M1fnd/2A+uedw8MKfDc+QfwPG6spXrm6o
   VsflD6RpXoQq09VDpwJSrXLkzJbpRKttYNwGDNoq+uTcpfW7r1QybCVCi
   Vp0DZFwtZNWjXLl2GWuHIZqDcu3GhR6qf44ppeiUbqgc6EdF5rff8fmRu
   j1DuAHl3MAB0VZr7fgdqjORkIlmxfcppZikho3mlAwKJ31hDj/u9IrI63
   mSI2yuuonS9e/s0fWKsZrSlVgV2fkv4Tq/cRj81lIFtxHrAiod9t6HCdK
   ljUQc5CIH5b1edDJfsyhZCT6Z8I2H53QTyGzczUyAObE3kzYiZvk+gJux
   w==;
IronPort-SDR: VQhmM0FZL1T92OJLLiODRsCJEF8Q7muLfGs3WBaMgk6PGjWKxSDTiLegwUXGkdj70Nj+mxwo3N
 cRRfiyOCdgVNPilk8wf5ewOCiHfzcJO1H96QacFP5joJWLPIHEVaO+POJDzYmHHjsWUx7Nw5Bs
 Y/zhslARHk2SeNxKI3Iqqce3ii8hMlFcLR3pNVfcOOeuRx8vSHk3L9OBlNUi0W/Q+/+YzCRy/M
 Gdi13yLSWvKfovqydu7jlaJkexHbFx8e6X4AmffpmlLazu/49rm8RrHrTT33OCo46qT2Jz38gM
 Kj4=
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="111998573"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2021 14:20:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 21 Jan 2021 14:20:58 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 21 Jan 2021 14:20:58 -0700
Date:   Thu, 21 Jan 2021 22:20:57 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
CC:     <ulf.hansson@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: Assign boolean values to a bool variable
Message-ID: <20210121212057.kxoh7timeczhd4yh@sekiro>
References: <1611128377-66216-1-git-send-email-abaci-bugfix@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1611128377-66216-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jan 20, 2021 at 03:39:37PM +0800, Jiapeng Zhong wrote:
> Fix the following coccicheck warnings:
> 
> ./drivers/mmc/host/atmel-mci.c:2436:2-34: WARNING: Assignment
> of 0/1 to bool variable.
> 
> ./drivers/mmc/host/atmel-mci.c:2425:2-20: WARNING: Assignment
> of 0/1 to bool variable.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

> ---
>  drivers/mmc/host/atmel-mci.c | 46 ++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 444bd3a..6324120 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2401,45 +2401,45 @@ static void atmci_get_cap(struct atmel_mci *host)
>         dev_info(&host->pdev->dev,
>                         "version: 0x%x\n", version);
> 
> -       host->caps.has_dma_conf_reg = 0;
> -       host->caps.has_pdc = 1;
> -       host->caps.has_cfg_reg = 0;
> -       host->caps.has_cstor_reg = 0;
> -       host->caps.has_highspeed = 0;
> -       host->caps.has_rwproof = 0;
> -       host->caps.has_odd_clk_div = 0;
> -       host->caps.has_bad_data_ordering = 1;
> -       host->caps.need_reset_after_xfer = 1;
> -       host->caps.need_blksz_mul_4 = 1;
> -       host->caps.need_notbusy_for_read_ops = 0;
> +       host->caps.has_dma_conf_reg = false;
> +       host->caps.has_pdc = true;
> +       host->caps.has_cfg_reg = false;
> +       host->caps.has_cstor_reg = false;
> +       host->caps.has_highspeed = false;
> +       host->caps.has_rwproof = false;
> +       host->caps.has_odd_clk_div = false;
> +       host->caps.has_bad_data_ordering = true;
> +       host->caps.need_reset_after_xfer = true;
> +       host->caps.need_blksz_mul_4 = true;
> +       host->caps.need_notbusy_for_read_ops = false;
> 
>         /* keep only major version number */
>         switch (version & 0xf00) {
>         case 0x600:
>         case 0x500:
> -               host->caps.has_odd_clk_div = 1;
> +               host->caps.has_odd_clk_div = true;
>                 fallthrough;
>         case 0x400:
>         case 0x300:
> -               host->caps.has_dma_conf_reg = 1;
> -               host->caps.has_pdc = 0;
> -               host->caps.has_cfg_reg = 1;
> -               host->caps.has_cstor_reg = 1;
> -               host->caps.has_highspeed = 1;
> +               host->caps.has_dma_conf_reg = true;
> +               host->caps.has_pdc = false;
> +               host->caps.has_cfg_reg = true;
> +               host->caps.has_cstor_reg = true;
> +               host->caps.has_highspeed = true;
>                 fallthrough;
>         case 0x200:
> -               host->caps.has_rwproof = 1;
> -               host->caps.need_blksz_mul_4 = 0;
> -               host->caps.need_notbusy_for_read_ops = 1;
> +               host->caps.has_rwproof = true;
> +               host->caps.need_blksz_mul_4 = false;
> +               host->caps.need_notbusy_for_read_ops = true;
>                 fallthrough;
>         case 0x100:
> -               host->caps.has_bad_data_ordering = 0;
> -               host->caps.need_reset_after_xfer = 0;
> +               host->caps.has_bad_data_ordering = false;
> +               host->caps.need_reset_after_xfer = false;
>                 fallthrough;
>         case 0x0:
>                 break;
>         default:
> -               host->caps.has_pdc = 0;
> +               host->caps.has_pdc = false;
>                 dev_warn(&host->pdev->dev,
>                                 "Unmanaged mci version, set minimum capabilities\n");
>                 break;
> --
> 1.8.3.1
> 
