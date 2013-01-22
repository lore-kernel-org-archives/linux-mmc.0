From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into
 the driver
Date: Tue, 22 Jan 2013 09:00:00 +0000
Message-ID: <20130122090000.GH6857@gmail.com>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
 <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:39717 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab3AVJAJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jan 2013 04:00:09 -0500
Received: by mail-bk0-f48.google.com with SMTP id jk14so989036bkc.35
        for <linux-mmc@vger.kernel.org>; Tue, 22 Jan 2013 01:00:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

> From: Lee Jones <lee.jones@linaro.org>
>=20
> There are currently two instances of the ios_handler being used.
> Both of which mearly toy with some regulator settings. Now there
> is a GPIO regulator API, we can use that instead, and lessen the
> per platform burden. By doing this, we also become more Device
> Tree compatible.

Russell,

Why is this patch in your tree with Ulf as the Author?

> Cc: Chris Ball <cjb@laptop.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/mmci.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 9da5f24..e56655a 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1097,6 +1097,11 @@ static void mmci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios)
>  	case MMC_POWER_OFF:
>  		if (!IS_ERR(mmc->supply.vmmc))
>  			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +
> +		if (!IS_ERR(mmc->supply.vqmmc) &&
> +		    regulator_is_enabled(mmc->supply.vqmmc))
> +			regulator_disable(mmc->supply.vqmmc);
> +
>  		break;
>  	case MMC_POWER_UP:
>  		if (!IS_ERR(mmc->supply.vmmc))
> @@ -1111,6 +1116,10 @@ static void mmci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios)
> =20
>  		break;
>  	case MMC_POWER_ON:
> +		if (!IS_ERR(mmc->supply.vqmmc) &&
> +		    !regulator_is_enabled(mmc->supply.vqmmc))
> +			regulator_enable(mmc->supply.vqmmc);
> +
>  		pwr |=3D MCI_PWR_ON;
>  		break;
>  	}

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
