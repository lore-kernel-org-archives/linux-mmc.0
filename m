Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F258C4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 06:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKPGs5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 01:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbiKPGnR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 01:43:17 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6875B60E5
        for <linux-mmc@vger.kernel.org>; Tue, 15 Nov 2022 22:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668580996; x=1700116996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YnlAl6anjWVjwvPOH5Gh8/0WCK4IzbNaUuIgHwZIHl8=;
  b=XoUh0H+WYMbkWT4vm2wkEvjTKLJgp67XliVyjSmIPOe0AXMPG5W69kre
   aAdbMn9gPoIM15t7ird4aly/sfx5ipbRqAArDfrl1aL289BzCG1MPEdCB
   Emcxjcuwl7lpkYOKpukeAMoU/lDSl4+LTZfQqbaT6tguTOfWIlPpuxyPp
   QnqZ6ZcLfC9/rGDs3Z2zQInuWZUs99bKxvmPm1Kaizktodc4ajrS62wTP
   osCh2uuQIoxIgFGpzh8mjqpm71ujac5t5PkfAoWDuzZGK4ELbiiqSo8/C
   SJG12VC4sMMGTIYF+aIPNvyiFh5GjBhX33pEePQwDHMiPaEdXmOSTy70E
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="339278278"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="339278278"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 22:43:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="968303509"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="968303509"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.88])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 22:43:14 -0800
Message-ID: <e3516bcf-5b5c-e81d-b51a-c9637d734886@intel.com>
Date:   Wed, 16 Nov 2022 08:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] mmc: CQHCI: solve DMA boundary limitation of CQHCI driver
Content-Language: en-US
To:     Jyan Chou <jyanchou@realtek.com>, riteshh@codeaurora.org,
        asutoshd@codeaurora.org
Cc:     linux-mmc@vger.kernel.org, james.tai@realtek.com,
        cy.huang@realtek.com
References: <20221116020012.19318-1-jyanchou@realtek.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221116020012.19318-1-jyanchou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/11/22 04:00, Jyan Chou wrote:
> Because CQHCI has its own DMA descriptors, when using DMA,
> if the DMA addr or buffer size has limitaion, we need to add an
> option to set up tran_desc.

Thanks for the patch, however we always require that features must
be used to be included in the kernel i.e. the patch with driver
changes that implements the ->setup_tran_desc() callback must
also be submitted.

> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> ---
>  drivers/mmc/host/cqhci-core.c | 5 +++++
>  drivers/mmc/host/cqhci.h      | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index b3d7d6d8d654..4d6fb228a21e 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -516,6 +516,11 @@ static int cqhci_prep_tran_desc(struct mmc_request *mrq,
>  
>  	desc = get_trans_desc(cq_host, tag);
>  
> +	if (cq_host->ops->setup_tran_desc) {
> +		cq_host->ops->setup_tran_desc(data, cq_host, desc, sg_count);
> +		return 0;
> +	}
> +
>  	for_each_sg(data->sg, sg, sg_count, i) {
>  		addr = sg_dma_address(sg);
>  		len = sg_dma_len(sg);
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index ba9387ed90eb..2e47461096e8 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -290,6 +290,8 @@ struct cqhci_host_ops {
>  	int (*program_key)(struct cqhci_host *cq_host,
>  			   const union cqhci_crypto_cfg_entry *cfg, int slot);
>  #endif
> +	void (*setup_tran_desc)(struct mmc_data *data,
> +		struct cqhci_host *cq_host, u8 *desc, int sg_count);
>  };
>  
>  static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)

