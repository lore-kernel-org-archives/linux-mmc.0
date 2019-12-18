Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD6FC43603
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 08:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AE420717
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 08:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576658051;
	bh=4VCT67i+evtU3b+1NrYmjCFgfKrbwyawxotLanrLNAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tWN4DlUQ3SLqj6aUt0jONJyDMg8J2VVLVMFAvfQM6NYBwxNYrAN6cO3V6CFdHD+uZ
	 QYoxdNeihibdspz/73OPcKBcF6PAPPm0AFe6YkKGPiiMkRRRcdjyX/ZkNoM9FYF3kv
	 GySr4+O71piNTdKZiML7VcLJyLTJU69hfZ3JR/+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbfLRIeK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:34:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfLRIeK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Dec 2019 03:34:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5547620717;
        Wed, 18 Dec 2019 08:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576658049;
        bh=4VCT67i+evtU3b+1NrYmjCFgfKrbwyawxotLanrLNAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fd+Q+Zs3jaPia+HO/AmBYGyQAwwixgXWmGSO/k7zY4RWO8eFHK2Gc7Hyz58Q0LNAX
         AR4JlLdkQeOQtmofAAT3kvx5Wk071HU82ebvRi7R1uM7b3aaD38RKlPDfvnTu4ejni
         hry7odHFOkZuHhbdoATx+SRTDanYl2nUEIGosGDk=
Date:   Wed, 18 Dec 2019 09:34:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Bao D. Nguyen" <nguyenb@codeaurora.org>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [<PATCH v1> 6/9] mmc: sdhci-msm: Ignore data timeout error for
 R1B commands
Message-ID: <20191218083407.GD1554871@kroah.com>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
 <22061d3479b876e8590b966162d6385a47f851b1.1576540908.git.nguyenb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22061d3479b876e8590b966162d6385a47f851b1.1576540908.git.nguyenb@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Dec 16, 2019 at 06:50:39PM -0800, Bao D. Nguyen wrote:
> From: Sahitya Tummala <stummala@codeaurora.org>
> 
> Ignore data timeout error for R1B commands as there will be no
> data associated and the busy timeout value for these commands
> could be lager than the maximum timeout value that controller
> can handle.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci.c | 15 +++++++++------
>  drivers/mmc/host/sdhci.h |  7 +++++++
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c04e1ac..0a05d74 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2925,12 +2925,6 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  		 * above in sdhci_cmd_irq().
>  		 */
>  		if (data_cmd && (data_cmd->flags & MMC_RSP_BUSY)) {
> -			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
> -				host->data_cmd = NULL;
> -				data_cmd->error = -ETIMEDOUT;
> -				__sdhci_finish_mrq(host, data_cmd->mrq);
> -				return;
> -			}
>  			if (intmask & SDHCI_INT_DATA_END) {
>  				host->data_cmd = NULL;
>  				/*
> @@ -2944,6 +2938,15 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  				__sdhci_finish_mrq(host, data_cmd->mrq);
>  				return;
>  			}
> +			if (host->quirks2 &
> +				SDHCI_QUIRK2_IGNORE_DATATOUT_FOR_R1BCMD)
> +				return;
> +			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
> +				host->data_cmd = NULL;
> +				data_cmd->error = -ETIMEDOUT;
> +				__sdhci_finish_mrq(host, data_cmd->mrq);
> +				return;
> +			}
>  		}
>  
>  		/*
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0ed3e0e..1a88f74 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -482,6 +482,13 @@ struct sdhci_host {
>   * block count.
>   */
>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
> +/*
> + * Ignore data timeout error for R1B commands as there will be no
> + * data associated and the busy timeout value for these commands
> + * could be lager than the maximum timeout value that controller
> + * can handle.
> + */
> +#define SDHCI_QUIRK2_IGNORE_DATATOUT_FOR_R1BCMD         (1<<19)

No tabs?

And what about using BIT(19) instead?

thanks,

greg k-h
