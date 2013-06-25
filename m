From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 4/4] mmc: sdhci-s3c: remove the duplicated calling sequence
Date: Tue, 25 Jun 2013 21:55:57 +0200
Message-ID: <201306252155.58225.heiko@sntech.de>
References: <51C8F07B.5080205@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:36299 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314Ab3FYT4B (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 25 Jun 2013 15:56:01 -0400
In-Reply-To: <51C8F07B.5080205@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Am Dienstag, 25. Juni 2013, 03:20:59 schrieb Jaehoon Chung:
> Didn't need to call the sdhci_s3c_notify_change in
> setup_card_detect_gpio().
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>


with the issue below addressed:

Acked-by: Heiko Stuebner <heiko@sntech.de>

and on a s3c2416
Tested-by: Heiko Stuebner <heiko@sntech.de>


> ---
>  drivers/mmc/host/sdhci-s3c.c |   26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index f1d5965..64defad 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -409,20 +409,18 @@ static void sdhci_s3c_setup_card_detect_gpio(struct
> sdhci_s3c *sc) if (devm_gpio_request(dev, pdata->ext_cd_gpio, "SDHCI EXT
> CD") == 0) { sc->ext_cd_gpio = pdata->ext_cd_gpio;
>  		sc->ext_cd_irq = gpio_to_irq(pdata->ext_cd_gpio);
> -		if (sc->ext_cd_irq &&
> -		    request_threaded_irq(sc->ext_cd_irq, NULL,
> -					 sdhci_s3c_gpio_card_detect_thread,
> -					 IRQF_TRIGGER_RISING |
> -					 IRQF_TRIGGER_FALLING |
> -					 IRQF_ONESHOT,
> -					 dev_name(dev), sc) == 0) {
> -			int status = gpio_get_value(sc->ext_cd_gpio);
> -			if (pdata->ext_cd_gpio_invert)
> -				status = !status;
> -			sdhci_s3c_notify_change(sc->pdev, status);
> -		} else {
> -			dev_warn(dev, "cannot request irq for card detect\n");
> -			sc->ext_cd_irq = 0;
> +		if (sc->ext_cd_irq) {
> +			ret = request_threaded_irq(sc->ext_cd_irq, NULL,

when testing on linux-next from 20130624 I get a
ret undeclared here.

> +					sdhci_s3c_gpio_card_detect_thread,
> +					IRQF_TRIGGER_RISING |
> +					IRQF_TRIGGER_FALLING |
> +					IRQF_ONESHOT,
> +					dev_name(dev), sc);
> +			if (ret) {
> +				dev_warn(dev,
> +					"cannot request irq for card detect\n");
> +				sc->ext_cd_irq = 0;
> +			}
>  		}
>  	} else {
>  		dev_err(dev, "cannot request gpio for card detect\n");

