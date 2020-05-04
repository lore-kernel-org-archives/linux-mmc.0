Return-Path: <SRS0=85Gt=6S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D562C47257
	for <linux-mmc@archiver.kernel.org>; Mon,  4 May 2020 07:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6627E215A4
	for <linux-mmc@archiver.kernel.org>; Mon,  4 May 2020 07:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgEDH3f (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 May 2020 03:29:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:41622 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgEDH3f (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 4 May 2020 03:29:35 -0400
IronPort-SDR: /IHtxQzSY5XFbLBgxa2nVHWZbE5MsvliIEukanb50vOnyk3TS6SWL/4fth95te2hZMZS6YV0ld
 yKrV+gtiHbsA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 00:29:34 -0700
IronPort-SDR: zNtXKyB4w4WjyC6WiVnuuzBAG4T3rPGYx2NUWFTtHfK//89qW4A/ilWT2H0QDxQmJyGU/g28gi
 Lj+lMnDnYtow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,351,1583222400"; 
   d="scan'208";a="259249561"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga003.jf.intel.com with ESMTP; 04 May 2020 00:29:31 -0700
Subject: Re: [PATCH] mmc: sdhci-esdhc: update contact email
To:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-mmc@vger.kernel.org
References: <20200502142840.19418-1-wsa@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <20f61d5b-74ab-a214-ec36-6e362ba3457b@intel.com>
Date:   Mon, 4 May 2020 10:29:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200502142840.19418-1-wsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/05/20 5:28 pm, Wolfram Sang wrote:
> The 'pengutronix' address is defunct for years. Use the proper contact
> address.
> 
> Signed-off-by: Wolfram Sang <wsa@kernel.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc.h              | 2 +-
>  include/linux/platform_data/mmc-esdhc-imx.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index 947212f16bc6..a30796e79b1c 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -5,7 +5,7 @@
>   * Copyright (c) 2007 Freescale Semiconductor, Inc.
>   * Copyright (c) 2009 MontaVista Software, Inc.
>   * Copyright (c) 2010 Pengutronix e.K.
> - *   Author: Wolfram Sang <w.sang@pengutronix.de>
> + *   Author: Wolfram Sang <kernel@pengutronix.de>
>   */
>  
>  #ifndef _DRIVERS_MMC_SDHCI_ESDHC_H
> diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
> index 0434f68eda86..cba1184b364c 100644
> --- a/include/linux/platform_data/mmc-esdhc-imx.h
> +++ b/include/linux/platform_data/mmc-esdhc-imx.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright 2010 Wolfram Sang <w.sang@pengutronix.de>
> + * Copyright 2010 Wolfram Sang <kernel@pengutronix.de>
>   */
>  
>  #ifndef __ASM_ARCH_IMX_ESDHC_H
> 

