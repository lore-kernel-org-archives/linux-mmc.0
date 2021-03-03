Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BC6C4332B
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCC664F5A
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhCDAAn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:24500 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233969AbhCCRu5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 3 Mar 2021 12:50:57 -0500
IronPort-SDR: 7h2OmpTfRD1hjR54l3G29yuKwpp5dc0tLoTPiPbDZpjxGlqYk5gDkut0xFFyQZkI1T+MKFZsSa
 GSkbQBzDyV3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="272246022"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="272246022"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 09:49:27 -0800
IronPort-SDR: s3zWAmWsgRQdPTkEF0qxVAoyJTgvQ/7p8tv/XMEU2A28UY+/J6H+3qPecnHmBPIjV3Th3iGGeT
 cvlN3F3WmhzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="406549230"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2021 09:49:24 -0800
Subject: Re: [PATCH v2 1/1] mmc: cqhci: fix random crash when remove mmc
 module
To:     Frank Li <lznuaa@gmail.com>, asutoshd@codeaurora.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, haibo.chen@nxp.com
References: <20210303174248.542175-1-Frank.Li@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1b8c461b-a286-9099-3c63-fd98340bf3c6@intel.com>
Date:   Wed, 3 Mar 2021 19:49:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210303174248.542175-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 3/03/21 7:42 pm, Frank Li wrote:
> [ 6684.493350] Unable to handle kernel paging request at virtual address ffff800011c5b0f0
> [ 6684.498531] mmc0: card 0001 removed
> [ 6684.501556] Mem abort info:
> [ 6684.509681]   ESR = 0x96000047
> [ 6684.512786]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 6684.518394]   SET = 0, FnV = 0
> [ 6684.521707]   EA = 0, S1PTW = 0
> [ 6684.524998] Data abort info:
> [ 6684.528236]   ISV = 0, ISS = 0x00000047
> [ 6684.532986]   CM = 0, WnR = 1
> [ 6684.536129] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000081b22000
> [ 6684.543923] [ffff800011c5b0f0] pgd=00000000bffff003, p4d=00000000bffff003, pud=00000000bfffe003, pmd=00000000900e1003, pte=0000000000000000
> [ 6684.557915] Internal error: Oops: 96000047 [#1] PREEMPT SMP
> [ 6684.564240] Modules linked in: sdhci_esdhc_imx(-) sdhci_pltfm sdhci cqhci mmc_block mmc_core fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc caamalg_desc crypto_engine rng_core authenc libdes crct10dif_ce flexcan can_dev caam error [last unloaded: mmc_core]
> [ 6684.587281] CPU: 0 PID: 79138 Comm: kworker/0:3H Not tainted 5.10.9-01410-g3ba33182767b-dirty #10
> [ 6684.596160] Hardware name: Freescale i.MX8DXL EVK (DT)
> [ 6684.601320] Workqueue: kblockd blk_mq_run_work_fn
> 
> [ 6684.606094] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
> [ 6684.612286] pc : cqhci_request+0x148/0x4e8 [cqhci]
> ^GMessage from syslogd@  at Thu Jan  1 01:51:24 1970 ...[ 6684.617085] lr : cqhci_request+0x314/0x4e8 [cqhci]
> [ 6684.626734] sp : ffff80001243b9f0
> [ 6684.630049] x29: ffff80001243b9f0 x28: ffff00002c3dd000
> [ 6684.635367] x27: 0000000000000001 x26: 0000000000000001
> [ 6684.640690] x25: ffff00002c451000 x24: 000000000000000f
> [ 6684.646007] x23: ffff000017e71c80 x22: ffff00002c451000
> [ 6684.651326] x21: ffff00002c0f3550 x20: ffff00002c0f3550
> [ 6684.656651] x19: ffff000017d46880 x18: ffff00002cea1500
> [ 6684.661977] x17: 0000000000000000 x16: 0000000000000000
> [ 6684.667294] x15: 000001ee628e3ed1 x14: 0000000000000278
> [ 6684.672610] x13: 0000000000000001 x12: 0000000000000001
> [ 6684.677927] x11: 0000000000000000 x10: 0000000000000000
> [ 6684.683243] x9 : 000000000000002b x8 : 0000000000001000
> [ 6684.688560] x7 : 0000000000000010 x6 : ffff00002c0f3678
> [ 6684.693886] x5 : 000000000000000f x4 : ffff800011c5b000
> [ 6684.699211] x3 : 000000000002d988 x2 : 0000000000000008
> [ 6684.704537] x1 : 00000000000000f0 x0 : 0002d9880008102f
> [ 6684.709854] Call trace:
> [ 6684.712313]  cqhci_request+0x148/0x4e8 [cqhci]
> [ 6684.716803]  mmc_cqe_start_req+0x58/0x68 [mmc_core]
> [ 6684.721698]  mmc_blk_mq_issue_rq+0x460/0x810 [mmc_block]
> [ 6684.727018]  mmc_mq_queue_rq+0x118/0x2b0 [mmc_block]
> 
> cqhci_request was called after cqhci_disable.
> 
> cqhci_disable                                 cqhci_request
> {                                             {
> 	dmam_free_coherent();  (1) free
>                                                   if(!cq_host->enable)
>                                                        return
> 				         (2) pass check here
> 	cq_host->enable = false;
> 
>                                                   task_desc= get_desc(cq_host,tag);
>                                                              ^^^^ crash here
>                                          (3) access memory which is already free
> 
> }                                             }
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Change from v1 to v2
>  - use Adrian Hunter suggested method to fix this problem
> 
>  drivers/mmc/core/bus.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index c2e70b757dd1..4383c262b3f5 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -399,11 +399,6 @@ void mmc_remove_card(struct mmc_card *card)
>  	mmc_remove_card_debugfs(card);
>  #endif
>  
> -	if (host->cqe_enabled) {
> -		host->cqe_ops->cqe_disable(host);
> -		host->cqe_enabled = false;
> -	}
> -
>  	if (mmc_card_present(card)) {
>  		if (mmc_host_is_spi(card->host)) {
>  			pr_info("%s: SPI card removed\n",
> @@ -416,6 +411,10 @@ void mmc_remove_card(struct mmc_card *card)
>  		of_node_put(card->dev.of_node);
>  	}
>  
> +	if (host->cqe_enabled) {
> +		host->cqe_ops->cqe_disable(host);
> +		host->cqe_enabled = false;
> +	}
> +
>  	put_device(&card->dev);
>  }
> -
> 

