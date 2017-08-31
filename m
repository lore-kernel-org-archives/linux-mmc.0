From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC 1/4] mmc: cqhci: Move CQHCI_ENABLE before setting
 TDLBA/TDLBAU
Date: Thu, 31 Aug 2017 09:01:34 +0300
Message-ID: <82b52d84-6eb1-9f97-5e0a-bea6d25ddbda@intel.com>
References: <1504098251-27739-1-git-send-email-riteshh@codeaurora.org>
 <1504098251-27739-2-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:27506 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdHaGKP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 31 Aug 2017 02:10:15 -0400
In-Reply-To: <1504098251-27739-2-git-send-email-riteshh@codeaurora.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stummala@codeaurora.org, asutoshd@codeaurora.org

On 30/08/17 16:04, Ritesh Harjani wrote:
> Without this patch the CQHCI registers are getting reset
> again.
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  drivers/mmc/host/cqhci.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 8650a13..2a7351c 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -262,6 +262,9 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>  
>  	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>  
> +	cqcfg |= CQHCI_ENABLE;
> +	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
That doesn't follow the flow in the specification B.6.1. Command Queuing
Initialization Sequence.  Also in B.3.5 Task List, the spec. says "Changing
the value of TDLBA is not allowed when command queue mode is enabled."

So you will need to add a quirk for this.

> +
>  	cqhci_writel(cq_host, lower_32_bits(cq_host->desc_dma_base),
>  		     CQHCI_TDLBA);
>  	cqhci_writel(cq_host, upper_32_bits(cq_host->desc_dma_base),
> @@ -271,10 +274,6 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>  
>  	cqhci_set_irqs(cq_host, 0);
>  
> -	cqcfg |= CQHCI_ENABLE;
> -
> -	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> -
>  	mmc->cqe_on = true;
>  
>  	if (cq_host->ops->enable)
> 

