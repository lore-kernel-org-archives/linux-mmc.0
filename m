Return-Path: <SRS0=joLi=AM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8607EC433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 09:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B50B2073E
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 09:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgGAJ5u (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:57:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:20571 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729332AbgGAJ5u (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 1 Jul 2020 05:57:50 -0400
IronPort-SDR: 1A3Q9ey3bFzkFE2+bWsI66/08coGxjPulEDFygyy7wIeGUthqrql5woZ0NUFpLe+FqgTAHW9lf
 DLKEMyOKdJLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="164527274"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="164527274"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 02:57:49 -0700
IronPort-SDR: eLaADTkcKhiOvG4JlSZ0Sxp3y0KdIygaZBalh8sTPTeY0Cingbus4yq/wDFE49FVZ/AkvAyNXD
 pQ0TrId8spCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="303788511"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jul 2020 02:57:48 -0700
Subject: Re: 0001-Fix-CQE-task-queue-timeout.patch
To:     chen jiangnan <chen.jiangnan@zlingsmart.com>
Cc:     "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "ulf.hansson@linaro.or" <ulf.hansson@linaro.or>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <5a7b5ad9-bb3a-4281-a065-f57f9cf71a5a.chen.jiangnan@zlingsmart.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <40cccbed-1cbf-c709-9d5b-b87e796b07e5@intel.com>
Date:   Wed, 1 Jul 2020 12:57:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <5a7b5ad9-bb3a-4281-a065-f57f9cf71a5a.chen.jiangnan@zlingsmart.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22/06/20 8:44 am, chen jiangnan wrote:
> From 547e5635c04f4f9d62cbc1e3a4b4527f87c4e83b Mon Sep 17 00:00:00 2001
> From: JiangnanChen <chen.jiangnan@zlingsmart.com>
> Date: Mon, 22 Jun 2020 05:32:21 +0000
> Subject: [PATCH] Fix CQE task queue timeout. CQE notifies the software that

Please separate subject from commit message.

>  task has completed through task completion notification (TCN), but some CQE
>  will occasionally mark the task in the pending state (via DPT). At this time,
>  if a QBR task (such as flush cache) is followed, the entire command queue
>  will be blocked, causing the mmc subsystem to report a timeout error, and cqe
>  enters the recovery process.

It seems like this is a workaround for broken HW, so you could create a quirk for
this, but making use of the ->write_l host op is cleaner for cqhci.

e.g. in your driver, for the broken controller set cqhci_host_ops write_l to use
the following:

static void ???_cqhci_writel(struct cqhci_host *cq_host, u32 val, int reg)
{
	writel_relaxed(val, cq_host->mmio + reg);

	if (reg == CQHCI_TCN) {
               u32 pend_status = cqhci_readl(cq_host, CQHCI_DPT);
               if (val & pend_status) {
                       pr_debug("%s: cqhci conflict: TCN: 0x%08lx DPT: 0x%08lx\n",
                                mmc_hostname(cq_host->mmc), val, pend_status);
                       cqhci_writel(cq_host, val & pend_status, CQHCI_TCLR);
               }
	}
}

> 
> Signed-off-by: JiangnanChen <chen.jiangnan@zlingsmart.com>
> ---
>  drivers/mmc/host/cqhci.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 75934f3c117e..b8c7f6119ac4 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -760,7 +760,7 @@ irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
>                       int data_error)
>  {
>         u32 status;
> -       unsigned long tag = 0, comp_status;
> +       unsigned long tag = 0, comp_status, pend_status;
>         struct cqhci_host *cq_host = mmc->cqe_private;
>  
>         status = cqhci_readl(cq_host, CQHCI_IS);
> @@ -778,6 +778,13 @@ irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
>                 pr_debug("%s: cqhci: TCN: 0x%08lx\n",
>                          mmc_hostname(mmc), comp_status);
>  
> +               pend_status = cqhci_readl(cq_host, CQHCI_DPT);
> +               if (comp_status & pend_status) {
> +                       pr_debug("%s: cqhci conflict: TCN: 0x%08lx DPT: 0x%08lx\n",
> +                                mmc_hostname(mmc), comp_status, pend_status);
> +                       cqhci_writel(cq_host, comp_status & pend_status, CQHCI_TCLR);
> +               }
> +
>                 spin_lock(&cq_host->lock);
>  
>                 for_each_set_bit(tag, &comp_status, cq_host->num_slots) {
> -- 
> 2.17.1

