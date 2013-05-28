From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] mmc: sdhci-acpi: fix error return code in
 sdhci_acpi_add_own_cd()
Date: Tue, 28 May 2013 14:35:27 +0900
Message-ID: <000801ce5b65$28d9f400$7a8ddc00$@samsung.com>
References: <CAPgLHd_FWg3egTZxBena+BTgWdZCzqr9AjV1_NpWBGYD3aPz0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55792 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932643Ab3E1Ff3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 May 2013 01:35:29 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNH00JLUU6EYLI0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 May 2013 14:35:28 +0900 (KST)
In-reply-to: <CAPgLHd_FWg3egTZxBena+BTgWdZCzqr9AjV1_NpWBGYD3aPz0w@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Wei Yongjun' <weiyj.lk@gmail.com>, cjb@laptop.org
Cc: adrian.hunter@intel.com, rafael.j.wysocki@intel.com, sonic.zhang@analog.com, yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

On Tuesday, May 28, 2013 2:26 PM, Wei Yongjun wrote:
> 
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code in the gpio_to_irq() error
> handling case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

It looks good.

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/mmc/host/sdhci-acpi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index a51e603..08a85ec 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -189,8 +189,10 @@ static int sdhci_acpi_add_own_cd(struct device *dev, int gpio,
>  		goto out;
> 
>  	irq = gpio_to_irq(gpio);
> -	if (irq < 0)
> +	if (irq < 0) {
> +		err = irq;
>  		goto out_free;
> +	}
> 
>  	flags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
>  	err = devm_request_irq(dev, irq, sdhci_acpi_sd_cd, flags, "sd_cd", mmc);

