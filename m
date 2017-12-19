From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4] mmc: sdhci-xenon: wait 5ms after set 1.8V signal
 enable
Date: Tue, 19 Dec 2017 09:24:57 +0200
Message-ID: <77625101-e03e-18b1-9524-639baefcdda6@intel.com>
References: <1513636727-4503-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:19897 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932910AbdLSHZ0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 19 Dec 2017 02:25:26 -0500
In-Reply-To: <1513636727-4503-1-git-send-email-zjwu@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: nadavh@marvell.com, xigu@marvell.com, xswang@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com

On 19/12/17 00:38, Zhoujie Wu wrote:
> According to SD spec 3.00 3.6.1 signal voltage switch
> procedure step 6~8,
> (6) Set 1.8V Signal Enable in the Host Control 2 register.
> (7) Wait 5ms. 1.8V voltage regulator shall be stable within this period.
> (8) If 1.8V Signal Enable is cleared by Host Controller, go to step (12).
> Host should wait 5ms after set 1.8V signal enable bit in
> Host Control 2 register and check if 1.8V is stable or not.
> 
> But current code checks this bit right after set it.
> On some platforms with xenon controller found the bit is
> cleared right away and host reports "1.8V regulator output
> did not became stable" and 5ms delay can help.
> 
> Implement voltage_switch callback for xenon controller to add 5ms
> delay to make sure the 1.8V signal enable bit is set by controller.
> 
> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v4: move the 5ms delay from sdhci.c to xenon driver.
> v3: give more details in comments.
> v2: remove undeliverable cc list email.
> 
>  drivers/mmc/host/sdhci-xenon.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 0842bbc..4d0791f 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -230,7 +230,14 @@ static void xenon_set_power(struct sdhci_host *host, unsigned char mode,
>  		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>  }
>  
> +static void xenon_voltage_switch(struct sdhci_host *host)
> +{
> +	/* Wait for 5ms after set 1.8V signal enable bit */
> +	usleep_range(5000, 5500);
> +}
> +
>  static const struct sdhci_ops sdhci_xenon_ops = {
> +	.voltage_switch		= xenon_voltage_switch,
>  	.set_clock		= sdhci_set_clock,
>  	.set_power		= xenon_set_power,
>  	.set_bus_width		= sdhci_set_bus_width,
> 

