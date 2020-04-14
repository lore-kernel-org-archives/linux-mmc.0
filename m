Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DDFC2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 13:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE0620644
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 13:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbgDNNs6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:48:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:30458 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388105AbgDNNss (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Apr 2020 09:48:48 -0400
IronPort-SDR: Wnz1yPzBLW0c1HLt3uEdhL1QT150Y4SrgB5i9x6/WMFQFu1lh/8Xl1QvR+J3PUk5x4V5KC1T3p
 z6Uvo+D2ukFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 06:48:47 -0700
IronPort-SDR: Ny/ZagQyHiMzUsJbw7iCuEBiMwf3T11gCmuZPUzB0PbQQ1XB5A6ROCjYYxclPkrI+XrQKUqnLl
 x90OkNyxbUtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="243817401"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga007.fm.intel.com with ESMTP; 14 Apr 2020 06:48:45 -0700
Subject: Re: [PATCH v5 2/3] mmc: host: sdhci: Implement the request_atomic()
 API
To:     Baolin Wang <baolin.wang7@gmail.com>, ulf.hansson@linaro.org
Cc:     arnd@arndb.de, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1586744073.git.baolin.wang7@gmail.com>
 <9ed34afa9fb42e0c234065cac5401d7826942b55.1586744073.git.baolin.wang7@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9d118792-8551-7988-464e-162550bc6614@intel.com>
Date:   Tue, 14 Apr 2020 16:47:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9ed34afa9fb42e0c234065cac5401d7826942b55.1586744073.git.baolin.wang7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/04/20 5:46 am, Baolin Wang wrote:
> Implement the request_atomic() ops for the sdhci driver to process
> one request in the atomic context if the card is nonremovable.
> 
> Moreover, we should return BUSY flag if controller has not released
> the inhibit bits to allow HSQ trying to send request again in non-atomic
> context.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 34 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.h |  1 +
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 10b9570f48aa..0baef595de26 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2144,6 +2144,40 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_request);
>  
> +int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct mmc_command *cmd;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	if (sdhci_present_error(host, mrq->cmd, true)) {
> +		sdhci_finish_mrq(host, mrq);
> +		goto out_finish;
> +	}
> +
> +	cmd = sdhci_manual_cmd23(host, mrq) ? mrq->sbc : mrq->cmd;
> +
> +	/*
> +	 * The HSQ may send a command in interrupt context without polling
> +	 * the busy signaling, which means we should return BUSY if controller
> +	 * has not released inhibit bits to allow HSQ trying to send request
> +	 * again in non-atomic context. So we should not finish this request
> +	 * here.
> +	 */
> +	if (!sdhci_send_command(host, cmd))
> +		ret = -EBUSY;
> +	else
> +		sdhci_led_activate(host);
> +
> +out_finish:
> +	spin_unlock_irqrestore(&host->lock, flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_request_atomic);
> +
>  void sdhci_set_bus_width(struct sdhci_host *host, int width)
>  {
>  	u8 ctrl;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index a7e469c00617..4bd70da7aa00 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -776,6 +776,7 @@ void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  			   unsigned short vdd);
>  void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
> +int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
> 

