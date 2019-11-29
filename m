Return-Path: <SRS0=5U+E=ZV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B82C432C0
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Nov 2019 09:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC62F215A5
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Nov 2019 09:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfK2JSO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:18:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:26108 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfK2JSO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 29 Nov 2019 04:18:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 01:18:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; 
   d="scan'208";a="384033767"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.95]) ([10.237.72.95])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2019 01:18:12 -0800
Subject: Re: [PATCH] mmc: sdhci: fix up CMD12 sending
To:     Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20191114111814.35199-1-yangbo.lu@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d16270bd-7d88-2c6e-252c-7df191ef2e59@intel.com>
Date:   Fri, 29 Nov 2019 11:17:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191114111814.35199-1-yangbo.lu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/11/19 1:18 pm, Yangbo Lu wrote:
> The STOP command is disabled for multiple blocks r/w commands
> with auto CMD12, when start to send. However, if there is data
> error, software still needs to send CMD12 according to SD spec.
> This patch is to allow software CMD12 sending for this case.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Sorry for the delay.  This looks good to me.  Sending a STOP command
on the error path in the auto-CMD12 case should be fine whether it has
been sent already or not.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 09cdbe8..3041c39 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1326,12 +1326,12 @@ static void sdhci_finish_data(struct sdhci_host *host)
>  
>  	/*
>  	 * Need to send CMD12 if -
> -	 * a) open-ended multiblock transfer (no CMD23)
> +	 * a) open-ended multiblock transfer not using auto CMD12 (no CMD23)
>  	 * b) error in multiblock transfer
>  	 */
>  	if (data->stop &&
> -	    (data->error ||
> -	     !data->mrq->sbc)) {
> +	    ((!data->mrq->sbc && !sdhci_auto_cmd12(host, data->mrq)) ||
> +	     data->error)) {
>  		/*
>  		 * 'cap_cmd_during_tfr' request must not use the command line
>  		 * after mmc_command_done() has been called. It is upper layer's
> @@ -1825,17 +1825,6 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  
>  	sdhci_led_activate(host);
>  
> -	/*
> -	 * Ensure we don't send the STOP for non-SET_BLOCK_COUNTED
> -	 * requests if Auto-CMD12 is enabled.
> -	 */
> -	if (sdhci_auto_cmd12(host, mrq)) {
> -		if (mrq->stop) {
> -			mrq->data->stop = NULL;
> -			mrq->stop = NULL;
> -		}
> -	}
> -
>  	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
>  		mrq->cmd->error = -ENOMEDIUM;
>  		sdhci_finish_mrq(host, mrq);
> 

