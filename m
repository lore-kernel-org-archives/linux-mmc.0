From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-pxav3: add wake up support
Date: Mon, 14 Jan 2013 14:43:50 -0500
Message-ID: <87k3rfsg7d.fsf@laptop.org>
References: <1357377694-2167-1-git-send-email-kliu5@marvell.com>
	<1357377694-2167-2-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34633 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174Ab3ANToN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Jan 2013 14:44:13 -0500
In-Reply-To: <1357377694-2167-2-git-send-email-kliu5@marvell.com> (Kevin Liu's
	message of "Sat, 5 Jan 2013 17:21:34 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Adrian Hunter <adrian.hunter@intel.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao

Hi,

On Sat, Jan 05 2013, Kevin Liu wrote:
> Signed-off-by: Jialing Fu <jlfu@marvell.com>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> ---
>  drivers/mmc/host/sdhci-pxav3.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index b4aca81..ff06aff 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -325,6 +325,13 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, host);
>  
> +	if (pdata->pm_caps & MMC_PM_KEEP_POWER) {
> +		device_init_wakeup(&pdev->dev, 1);
> +		host->mmc->pm_flags |= MMC_PM_WAKE_SDIO_IRQ;
> +	} else {
> +		device_init_wakeup(&pdev->dev, 0);
> +	}
> +
>  	pm_runtime_put_autosuspend(&pdev->dev);
>  
>  	return 0;

Thanks, pushed to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
