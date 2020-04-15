Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0AEC2BA19
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 09:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3A0206D9
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 09:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405668AbgDOJ4c (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:56:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:26352 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405625AbgDOJ4b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Apr 2020 05:56:31 -0400
IronPort-SDR: JV2deZu3/5BvwyguiVm1YnAJzVdThZt303jsN/JkFSU39hIYQfP/mkzPp4TiurJNZFfn6wKOcu
 fR/i9KCk/EUQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 02:56:30 -0700
IronPort-SDR: bbf5Dp6mPqwehj4OyPOVzgHnFNLB2UCJfUQnsyijN7ar/rD9dgPdmvw1CDVMZRQGmecT60E1B4
 izyCuG+MfLzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="332452142"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga001.jf.intel.com with ESMTP; 15 Apr 2020 02:56:28 -0700
Subject: Re: [PATCH] mmc: sdhci: add spin lock for sdhci_set_default_irqs in
 sdhci_init
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-imx@nxp.com
References: <1586941255-9237-1-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a798dc19-afc1-133d-1037-43adcb4fd70b@intel.com>
Date:   Wed, 15 Apr 2020 12:55:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1586941255-9237-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/04/20 12:00 pm, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> When use one SDIO wifi which enable the runtime PM feature on i.MX6SX,
> we meet system hang. This hang happened during the usdhc runtime resume,
> in sdhci_init(), when call the sdhci_set_default_irqs. One interrupt
> (SDHCI_INT_CARD_INT) triggered just after the host->ier update and before
> the write of register SDHCI_SIGNAL_ENABLE. So in sdhci_irq, it will skip
> the call of sdio_signal_irq() because current host->ier do not set the
> SDHCI_INT_CARD_INT. So this SDIO wifi interrupt always keep triggered,
> let the system stuck in irq handle, can't response any other thread.
> 
> This patch add spin lock for the sdhci_set_default_irqs to fix this issue.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3f716466fcfd..79b6324a500c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -317,6 +317,7 @@ static void sdhci_config_dma(struct sdhci_host *host)
>  static void sdhci_init(struct sdhci_host *host, int soft)
>  {
>  	struct mmc_host *mmc = host->mmc;
> +	unsigned long flags;
>  
>  	if (soft)
>  		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> @@ -326,7 +327,9 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>  	if (host->v4_mode)
>  		sdhci_do_enable_v4_mode(host);
>  
> +	spin_lock_irqsave(&host->lock, flags);
>  	sdhci_set_default_irqs(host);
> +	spin_unlock_irqrestore(&host->lock, flags);
>  
>  	host->cqe_on = false;
>  
> 

