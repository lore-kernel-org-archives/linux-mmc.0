From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: add set_power callback
Date: Mon, 21 Aug 2017 14:11:53 +0800
Message-ID: <20170821141153.2cac52f6@xhacker>
References: <1503089284-29101-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:39758 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750937AbdHUGQw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Aug 2017 02:16:52 -0400
In-Reply-To: <1503089284-29101-1-git-send-email-zjwu@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, zmxu@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com

On Fri, 18 Aug 2017 13:48:04 -0700 Zhoujie Wu wrote:

> Xenon sdh controller requests proper SD bus voltage select
> bits programmed even with vmmc power supply. Any reserved
> value(100b-000b) programmed in this field will lead to controller
> ignore SD bus power bit and keep its value at zero.
> Add set_power callback to handle this.
> 
> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> ---
>  drivers/mmc/host/sdhci-xenon.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index edd4d915..e82dc01 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -210,8 +210,28 @@ static void xenon_set_uhs_signaling(struct sdhci_host *host,
>  	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>  }
>  
> +

remove this extra blank line.

> +static void xenon_set_power(struct sdhci_host *host, unsigned char mode,
> +		unsigned short vdd)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	u8 pwr = host->pwr;
> +
> +	sdhci_set_power_noreg(host, mode, vdd);
> +
> +	if (host->pwr == pwr)
> +		return;
> +
> +	if (host->pwr == 0)
> +		vdd = 0;
> +
> +	if (!IS_ERR(mmc->supply.vmmc))
> +		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> +}
> +
>  static const struct sdhci_ops sdhci_xenon_ops = {
>  	.set_clock		= sdhci_set_clock,
> +	.set_power		= xenon_set_power,
>  	.set_bus_width		= sdhci_set_bus_width,
>  	.reset			= xenon_reset,
>  	.set_uhs_signaling	= xenon_set_uhs_signaling,

