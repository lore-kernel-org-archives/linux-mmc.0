Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B49CDB474
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Oct 2023 05:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjJTFgc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Oct 2023 01:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjJTFgb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2023 01:36:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D941A6
        for <linux-mmc@vger.kernel.org>; Thu, 19 Oct 2023 22:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697780190; x=1729316190;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tNTb/YzTKlxnWx8pKW04n6YpJfcY5e8tengbATlO2C8=;
  b=d+WCFtSX9PW7ppa+bFy7+0CXZhnsMVkUVQ7SM9ZJlFlFXsii/grfkYY/
   aUXPuduUyN2rWs8Lverml1DVHcjxeYJZUVNmQkRlHwdpo2dLHoS65mpDW
   N46U8jRuBkQROexD7BU8mncoD3fpvDmXH/1sw07wSChQwHpO8Akwvzizx
   lcAKzhwCmGsrUgKpMTsRrIPaZ+pkujaXHdutMFgGyk0IiLd8ahT1gogGl
   3f5O2n3bCZnbbabav2B3aE89Ki1WCAYFTt70lLIw7Scnr7NVhYLUjqP1L
   VQB7F2zk1uFJZbcSGLpXFgekK3HgOxdKcad7IYHO2MF+cCvfTqMxfQj4H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="371504592"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="371504592"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 22:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707131517"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707131517"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.209.150])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 22:36:27 -0700
Message-ID: <cee3c9ac-4beb-4d78-87fc-fe1dab418cc2@intel.com>
Date:   Fri, 20 Oct 2023 08:36:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mmc: host: Quirk - Disable auto-cmd12 during ffu
To:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
References: <20231012184041.1837455-1-avri.altman@wdc.com>
 <20231012184041.1837455-2-avri.altman@wdc.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231012184041.1837455-2-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/10/23 21:40, Avri Altman wrote:
> Field Firmware Update (ffu) may use close-ended or open ended sequence.
> Each such sequence is comprised of a write commands enclosed between 2
> switch commands - to and from ffu mode.
> 
> Some platforms generate auto command error interrupt when it shouldn't,
> e.g. auto-cmd12 while in close-ended ffu sequence.
> 
> Therefore, add a quirk that disable auto-cmd12 while close-ended ffu is
> in progress.

If you hook the request function, maybe the existing SDHCI_AUTO_CMD12
flag could be used instead of introducing a new quirk:

void sdhci_msm_request(etc)
{
	if data-mrq and using-auto-cmd-12
		if ffu
			host->flags &= ~SDHCI_AUTO_CMD12;
		else
			host->flags |= SDHCI_AUTO_CMD12;
	sdhci_request(etc)
}

> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/host/sdhci.c | 8 +++++++-
>  drivers/mmc/host/sdhci.h | 2 ++
>  include/linux/mmc/core.h | 3 +++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ff41aa56564e..6d58f71f926e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1389,11 +1389,17 @@ void sdhci_switch_external_dma(struct sdhci_host *host, bool en)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_switch_external_dma);
>  
> +static inline bool sdhci_dont_auto_cmd12_ffu(struct sdhci_host *host,
> +					     struct mmc_request *mrq) {
> +	return (host->quirks2 & SDHCI_QUIRK2_FFU_ACMD12) && mrq->ffu;
> +}
> +
>  static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>  				    struct mmc_request *mrq)
>  {
>  	return !mrq->sbc && (host->flags & SDHCI_AUTO_CMD12) &&
> -	       !mrq->cap_cmd_during_tfr;
> +	       !mrq->cap_cmd_during_tfr &&
> +	       !sdhci_dont_auto_cmd12_ffu(host, mrq);
>  }
>  
>  static inline bool sdhci_auto_cmd23(struct sdhci_host *host,
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f219bdea8f28..ccab3a76883c 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -485,6 +485,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
>  /* Issue CMD and DATA reset together */
>  #define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER	(1<<19)
> +/* Controller generates auto-cmd error interrupt during close-ended ffu */
> +#define SDHCI_QUIRK2_FFU_ACMD12				(1<<20)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 6efec0b9820c..aca4e84f648c 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -161,6 +161,9 @@ struct mmc_request {
>  	/* Allow other commands during this ongoing data transfer or busy wait */
>  	bool			cap_cmd_during_tfr;
>  
> +	/* Be aware that ffu is in progress and avoid auto-cmd12 */
> +	bool			ffu;
> +
>  	int			tag;
>  
>  #ifdef CONFIG_MMC_CRYPTO

