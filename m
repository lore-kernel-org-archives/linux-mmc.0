Return-Path: <SRS0=aPfc=5B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C800C0044D
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 13:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369F72051A
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 13:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbgCPNJO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:09:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:25949 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731094AbgCPNJO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Mar 2020 09:09:14 -0400
IronPort-SDR: VGinNkE0QJ8atWsdctpYzrxADn6puc7SHHqn32XUPbATYHrzEcvnQZKrARR0Imv1fq5ghv6r+E
 dq/2VlThmd7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 06:09:13 -0700
IronPort-SDR: 0CeY80JCmqMRFF8PRRwqjCJTuc1Tu7GsgKQr52YKi11iJStA/m1bmE/80Ik3TgXwgODzGweN8w
 O4YWoKhrBOMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,560,1574150400"; 
   d="scan'208";a="247451195"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2020 06:09:11 -0700
Subject: Re: [RESEND PATCH 1/3] mmc: host: Introduce the request_atomic() for
 the host
To:     Baolin Wang <baolin.wang7@gmail.com>, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1583307441.git.baolin.wang7@gmail.com>
 <ace53bca354e2846f19684bd33a9c0f3c2ee2c44.1583307441.git.baolin.wang7@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <dd44e606-3eb5-f7fc-5995-021705a9b5d9@intel.com>
Date:   Mon, 16 Mar 2020 15:08:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ace53bca354e2846f19684bd33a9c0f3c2ee2c44.1583307441.git.baolin.wang7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/03/20 9:42 am, Baolin Wang wrote:
> The SD host controller can process one request in the atomic context if
> the card is nonremovable, which means we can submit next request in the
> irq hard handler when using the MMC software queue to reduce the latency.
> Thus this patch adds a new API request_atomic() for the host controller
> and implement it for the SD host controller.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/mmc/host/sdhci.c | 27 +++++++++++++++++++--------
>  drivers/mmc/host/sdhci.h |  1 +
>  include/linux/mmc/host.h |  3 +++
>  3 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9c37451..4febbcb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2016,17 +2016,12 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>   *                                                                           *
>  \*****************************************************************************/
>  
> -void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +static void sdhci_start_request(struct mmc_host *mmc, struct mmc_request *mrq,
> +				int present)
>  {
> -	struct sdhci_host *host;
> -	int present;
> +	struct sdhci_host *host = mmc_priv(mmc);
>  	unsigned long flags;
>  
> -	host = mmc_priv(mmc);
> -
> -	/* Firstly check card presence */
> -	present = mmc->ops->get_cd(mmc);
> -
>  	spin_lock_irqsave(&host->lock, flags);
>  
>  	sdhci_led_activate(host);
> @@ -2043,6 +2038,22 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
> +
> +void sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	sdhci_start_request(mmc, mrq, 1);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_request_atomic);
> +
> +void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	int present;
> +
> +	/* Firstly check card presence */
> +	present = mmc->ops->get_cd(mmc);
> +
> +	sdhci_start_request(mmc, mrq, present);
> +}
>  EXPORT_SYMBOL_GPL(sdhci_request);
>  
>  void sdhci_set_bus_width(struct sdhci_host *host, int width)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index cac2d97..5507a73 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -775,6 +775,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  			   unsigned short vdd);
>  void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
> +void sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 562ed06..db5e59c 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -92,6 +92,9 @@ struct mmc_host_ops {
>  			    int err);
>  	void	(*pre_req)(struct mmc_host *host, struct mmc_request *req);
>  	void	(*request)(struct mmc_host *host, struct mmc_request *req);
> +	/* Submit one request to host in atomic context. */
> +	void	(*request_atomic)(struct mmc_host *host,
> +				  struct mmc_request *req);

This doesn't have the flexibility to return "busy".  For example,
sdhci_send_command() will potentially wait quite some time if the inhibit
bits are set.  That is not good in interrupt context.  It would be better to
return immediately in that case and have the caller fall back to a
non-atomic context.  Thoughts?

>  
>  	/*
>  	 * Avoid calling the next three functions too often or in a "fast
> 

