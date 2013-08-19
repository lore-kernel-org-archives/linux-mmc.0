From: "Christian Daudt" <csd@broadcom.com>
Subject: Re: [PATCH] ARM: mmc: fix NONREMOVABLE test in sdhci-bcm-kona
Date: Mon, 19 Aug 2013 16:30:00 -0700
Message-ID: <5212AA78.9040101@broadcom.com>
References: <1375901981-1495-1-git-send-email-csd@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:3895 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436Ab3HSXaI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 19 Aug 2013 19:30:08 -0400
In-Reply-To: <1375901981-1495-1-git-send-email-csd@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Christian Daudt <csd@broadcom.com>
Cc: Chris Ball <cjb@laptop.org>, Matt Porter <matt.porter@linaro.org>, Markus Mayer <markus.mayer@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, csd_b@daudt.org

On 13-08-07 11:59 AM, Christian Daudt wrote:
> sdhci-bcm-kona driver is incorrectly doing "|" to bit-test
> NONREMOVABLE. Switch to "&"
>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> Signed-off-by: Christian Daudt <csd@broadcom.com>
>
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index 87175f9..9ffac0b 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -263,7 +263,7 @@ static int __init sdhci_bcm_kona_probe(struct platform_device *pdev)
>   		(mmc_gpio_get_cd(host->mmc) != -ENOSYS) ? 'Y' : 'N',
>   		(mmc_gpio_get_ro(host->mmc) != -ENOSYS) ? 'Y' : 'N');
>   
> -	if (host->mmc->caps | MMC_CAP_NONREMOVABLE)
> +	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
>   		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>   
>   	dev_dbg(dev, "is_8bit=%c\n",
> @@ -282,7 +282,7 @@ static int __init sdhci_bcm_kona_probe(struct platform_device *pdev)
>   	}
>   
>   	/* if device is eMMC, emulate card insert right here */
> -	if (host->mmc->caps | MMC_CAP_NONREMOVABLE) {
> +	if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
>   		ret = sdhci_bcm_kona_sd_card_emulate(host, 1);
>   		if (ret) {
>   			dev_err(dev,
applied to bcm/for-3.12/soc

  thanks,
    csd


