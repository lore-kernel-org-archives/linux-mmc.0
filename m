From: Hein Tibosch <hein_tibosch@yahoo.es>
Subject: Re: [PATCH] ARM: pxa: propagate errors from regulator_enable() to
 pxamci
Date: Tue, 09 Jul 2013 01:42:57 +0800
Message-ID: <51DAFA21.8060708@yahoo.es>
References: <201307051751.20729.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bosmailout13.eigbox.net ([66.96.185.13]:52289 "EHLO
	bosmailout13.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab3GHSZH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jul 2013 14:25:07 -0400
Received: from bosmailscan19.eigbox.net ([10.20.15.19])
	by bosmailout13.eigbox.net with esmtp (Exim)
	id 1UwFVE-0005cZ-BT
	for linux-mmc@vger.kernel.org; Mon, 08 Jul 2013 13:45:32 -0400
Received: from bosmailscan25.eigbox.net ([10.20.15.25])
	by bosmailscan19.eigbox.net with esmtp (Exim)
	id 1UwFVE-0004IH-BC
	for linux-mmc@vger.kernel.org; Mon, 08 Jul 2013 13:45:32 -0400
In-Reply-To: <201307051751.20729.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>, Paul Gortmaker <paul.gortmaker@windriver.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org

Hi Arnd,

On 7/5/2013 11:51 PM, Arnd Bergmann wrote:
> The em_x270_mci_setpower() and em_x270_usb_hub_init() functions
> call regulator_enable(), which may return an error that must
> be checked.
>
> This changes the em_x270_usb_hub_init() function to bail out
> if it fails, and changes the pxamci_platform_data->setpower
> callback so that the a failed em_x270_mci_setpower call
> can be propagated by the pxamci driver into the mmc core.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Mike Rapoport <mike@compulab.co.il>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Chris Ball <cjb@laptop.org>
>
> diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
> index f6726bb..f8062e4 100644
> --- a/arch/arm/mach-pxa/em-x270.c
> +++ b/arch/arm/mach-pxa/em-x270.c
> @@ -477,16 +477,24 @@ static int em_x270_usb_hub_init(void)
>  	/* USB Hub power-on and reset */
>  	gpio_direction_output(usb_hub_reset, 1);
>  	gpio_direction_output(GPIO9_USB_VBUS_EN, 0);
> -	regulator_enable(em_x270_usb_ldo);
> +	err = regulator_enable(em_x270_usb_ldo);
> +	if (err)
> +		goto err_free_rst_gpio;
> +
>  	gpio_set_value(usb_hub_reset, 0);
>  	gpio_set_value(usb_hub_reset, 1);
>  	regulator_disable(em_x270_usb_ldo);
> -	regulator_enable(em_x270_usb_ldo);
> +	if (err)
> +		goto err_free_rst_gpio;
> +
> +	err = regulator_enable(em_x270_usb_ldo);

Didn't you mean the other way around:

 	regulator_disable(em_x270_usb_ldo);
-	regulator_enable(em_x270_usb_ldo);
+	err = regulator_enable(em_x270_usb_ldo);
+	if (err)
+		goto err_free_rst_gpio;
+

?

Hein

>  	gpio_set_value(usb_hub_reset, 0);
>  	gpio_set_value(GPIO9_USB_VBUS_EN, 1);
>
>  	return 0;
>
> +err_free_rst_gpio:
> +	gpio_free(usb_hub_reset);
>  err_free_vbus_gpio:
>  	gpio_free(GPIO9_USB_VBUS_EN);
>  err_free_usb_ldo:
> @@ -592,7 +600,7 @@ err_irq:
>  	return err;
>  }
> <snip>

