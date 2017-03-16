From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Add support for setting parent clock
Date: Thu, 16 Mar 2017 18:00:00 +0000
Message-ID: <6072f40f-78e1-9c7a-6c9a-8db99f771af1@nvidia.com>
References: <1489660364-17698-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11808 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbdCPSCi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Mar 2017 14:02:38 -0400
In-Reply-To: <1489660364-17698-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Ritesh Harjani <riteshh@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org


On 16/03/17 10:32, Jon Hunter wrote:
> It is common for SD/MMC host controllers to set the parent clock that
> drives the SD/MMC interface in order to support various operating
> speeds. Typically, this is performed by calling common clock framework
> APIs such as clk_set_rate(). The problem is that these APIs may sleep
> and must not be called from within atomic sections and therefore, these
> functions cannot be called within the existing 'set_clock' SDHCI
> operator because they are called from within the context of a spinlock.
> Add a new 'set_parent_clock' operator for the SDHCI driver that is
> called early during the SDHCI 'set_ios' before the spinlock is aquire to
> give the platform driver the opportunity to set the parent clock rate.
> 
> Please note that, unfortunately, the Tegra and MSM SDHCI drivers
> currently appear to mis-use the 'set_clock' operator by calling
> clk_set_rate(). In the case of Tegra, occasionally but not always,
> 'scheduling while atomic' errors are reported (so most of the time we
> are getting lucky). In the of the MSM SDHCI driver, it is releasing and
> re-acquiring the spinlock which is bad.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> 
> I have not attempted to fix the MSM driver in this seris, but I am
> copying hopefully, the right people to fix it.
> 
>  drivers/mmc/host/sdhci.c | 3 +++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6fdd7a70f229..b7f1521edbec 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1579,6 +1579,9 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	if (ios->power_mode == MMC_POWER_UNDEFINED)
>  		return;
>  
> +	if (host->ops->set_parent_clock)
> +		host->ops->set_parent_clock(host, ios->power_mode);

Ugh ... not sure what happened here but this should be 'ios->clock'! And
I did test this!

Sorry will resend.

Jon

-- 
nvpublic
