From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] SDHCI: Suspend/Resume needs to save/restore INT_ENABLE on ARM/Tegra2
Date: Mon, 28 Mar 2011 22:21:30 -0400
Message-ID: <m339m6hdjp.fsf@pullcord.laptop.org>
References: <20110308213921.00625208186@grundler.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39002 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295Ab1C2CP2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Mar 2011 22:15:28 -0400
In-Reply-To: <20110308213921.00625208186@grundler.mtv.corp.google.com> (Grant
	Grundler's message of "Tue, 8 Mar 2011 13:39:20 -0800 (PST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: linux-mmc@vger.kernel.org

Hi Grant,

On Tue, Mar 08 2011, Grant Grundler wrote:
> Save and restore SDHCI interrupt mask during suspend/resume.
> Enables ARM Tegra2 board to suspend/resume.
>
> Signed-off-by: Venkat Rao <vrao@broadcom.com>
> Reviewed-by: Olof Johansson <olofj@chromium.org>
> Reviewed-by: Grant Grundler <grundler@chromium.org>
> ---
>  drivers/mmc/host/sdhci.c  |    5 +++++
>  include/linux/mmc/sdhci.h |    2 ++
>  2 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3c6358f..68d2e36 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1654,6 +1654,8 @@ int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
>  	if (mmc->card && (mmc->card->type != MMC_TYPE_SDIO))
>  		ret = mmc_suspend_host(host->mmc);
>  
> +	/* Save the original intmask to restore later */
> +	host->save_intmask = sdhci_readl(host, SDHCI_INT_ENABLE);
>  	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
>  
>  	if (host->vmmc)
> @@ -1695,6 +1697,9 @@ int sdhci_resume_host(struct sdhci_host *host)
>  
>  	sdhci_enable_card_detection(host);
>  
> +	/* Restore the original intmask */
> +	sdhci_unmask_irqs(host, host->save_intmask);
> +
>  	return ret;
>  }

I'm okay with the patch in principle, but it doesn't apply to any mainline
kernel as far as I can see -- we've never called sdhci_mask_irqs() in the
suspend path, which is context in this patch.  Maybe I'm missing something?
If not, it would be good to know whether the patch is needed on a mainline
kernel, as well as posting a rebased version.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
