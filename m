From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/2] sdhci-acpi initialization performance regression
Date: Wed, 17 Apr 2013 08:55:23 +0300
Message-ID: <516E394B.6090507@intel.com>
References: <1365082866-28404-1-git-send-email-adrian.hunter@intel.com> <87fvyvfwor.fsf@octavius.laptop.org> <516BA282.2000500@intel.com> <87k3o3ajh4.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39217 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757777Ab3DQFur (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Apr 2013 01:50:47 -0400
In-Reply-To: <87k3o3ajh4.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Namjae Jeon <linkinjeon@gmail.com>, Sergey Yanovich <ynvich@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>

On 15/04/13 18:42, Chris Ball wrote:
> Hi,
>
> On Mon, Apr 15 2013, Adrian Hunter wrote:
>> On 12/04/13 21:09, Chris Ball wrote:
>>> Hi Adrian,
>>>
>>> On Thu, Apr 04 2013, Adrian Hunter wrote:
>>>> When I submitted the sdhci-acpi driver, it's initialization performance
>>>> was satisfactory.  Now it is not.  Here are 2 fixes to restore that
>>>> regression.
>>>>
>>>> Adrian Hunter (2):
>>>>       Revert "mmc: core: wait while adding MMC host to ensure root mounts successfully"
>>>>       mmc: core: fix performance regression initializing MMC host controllers
>>>>
>>>>  drivers/mmc/core/core.c       | 4 ++--
>>>>  drivers/mmc/host/sdhci-acpi.c | 2 ++
>>>>  include/linux/mmc/host.h      | 1 +
>>>>  3 files changed, 5 insertions(+), 2 deletions(-)
>>> Thanks, both pushed to mmc-next (using v4 of patch 2/2) for 3.10.
>> Thanks you!
>>
>> It looks like mmc-next and linux-next have the V1 version of patch 2/2.  Can
>> you replace it with V4?
> Ouch, I'm sorry about that; thank you for catching it.  I applied the
> incremental patch below to bring it up to v4 (to avoid rebasing a
> public tree):

That is fine with me.  Is it in any tree?

>
>
> From: Adrian Hunter <adrian.hunter@intel.com>
> Subject: [PATCH] mmc: core: fix init controller performance regression,
>  updated patch
>
> Add MMC_CAP2_NO_PRESCAN_POWERUP to sdhci-pci.c also, use mmc_power_off()
> for MMC_CAP2_NO_PRESCAN_POWERUP.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> [cjb: previously applied v1 of this patch instead of v4]
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
>  drivers/mmc/core/core.c      | 4 +++-
>  drivers/mmc/host/sdhci-pci.c | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index c1893c9..65f9ca7 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2416,7 +2416,9 @@ void mmc_start_host(struct mmc_host *host)
>  {
>  	host->f_init = max(freqs[0], host->f_min);
>  	host->rescan_disable = 0;
> -	if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP))
> +	if (host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)
> +		mmc_power_off(host);
> +	else
>  		mmc_power_up(host);
>  	mmc_detect_change(host, 0);
>  }
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index c1f0372..0012d3f 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -1280,6 +1280,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  
>  	host->mmc->pm_caps = MMC_PM_KEEP_POWER | MMC_PM_WAKE_SDIO_IRQ;
>  	host->mmc->slotno = slotno;
> +	host->mmc->caps2 |= MMC_CAP2_NO_PRESCAN_POWERUP;
>  
>  	ret = sdhci_add_host(host);
>  	if (ret)

