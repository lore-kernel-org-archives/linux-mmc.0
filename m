Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF93232C96
	for <linux-mmc@vger.kernel.org>; Mon,  5 Feb 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149278; cv=none; b=KSBadVT+MnH5eKCnLNC+EcqSx87KCQTfVqVnRsMYM4+lzAMd0iPbZyx646CbC+DNIBC5MW8+oX2RJENh4BNsSsfbeB76E1DPwZgXLWZ6YIU3nS6ybsC2drXk9V9sH8wfKHH2smIj9Unj+lkF1Mz9UrBrrsfN9nHhrZLWt7A4ADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149278; c=relaxed/simple;
	bh=u/tdxtONYEe8qMQ5xAm9sEia0kTIy2tXT0RURmRTv0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6/BeLHW9+t6y2tlrzlBHv7F22ATpjKDej9RrKM/DtP9NliRRf2vsTmjS6FaDIpQPtgk9FI+4YcmBR2VsiigM9VvJWGu3nsRh62lTPt/H+5byaodMirx7xgWz+0mK2fE3yuUE9i0+DC+kQYX/s4KqBhlNDqC8imBqfLqclllDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oPkkiTrC; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPkkiTrC"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3be78c26850so2906927b6e.0
        for <linux-mmc@vger.kernel.org>; Mon, 05 Feb 2024 08:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707149276; x=1707754076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GhsVM/adS9vpjWA6Lr2DjRuOomXm3++4vE/uCT9yL/I=;
        b=oPkkiTrCl4LvOV9dtPA+cStkxKx0d0aicNuu9YjoKYIKpOByZxUa9V7Fz0kGBUbgBM
         0AYeRycfYkXAbQKzV5vuM6kJingu9hLzWlPrz+D5HMCx6p/+x5dUUCCNZgl0P/aBAyKN
         US/WjuoesNmcIcFK7UQv2C8bo3fotFGpFWfYOftzkRDdUFA/ZDBYjl8iDr0W7KNd5Imf
         ho/PXeSzqKAwPDH7EWWkzFXhX1vsm09bwl5LsKqTX+o9qku6o6lhkuykXeYL+peaPT5d
         XsPI++e6wneKBKO5sjIbh8O0HPUom5iv+fDL0XatkVZsePrXAGnriP+GugF3q72w/Yz6
         4YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149276; x=1707754076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhsVM/adS9vpjWA6Lr2DjRuOomXm3++4vE/uCT9yL/I=;
        b=MQtzUn3Iru5PsfURZzmVInkpsAGJjY8AeASXggWrlZrjIueLWMYCLcBLA65f8/jeU8
         jlgK4RnoX5q1NPWgQODPEP5cIupFuSxtSWtTQ1/oNYZX7SBV1r4K0OiX4kIDfwkouKco
         mHuw8fDBDYdqAqhVTwlkWLuzCxiXSdv9gJUZmiFugeTpmH5QRlHuynJJkMrqoaOras6u
         E7kX6tzxAVlJy5h1zC2HsTZeyZRxl5tYUK9+EGxkVOIeJji2yCkjnkV09KgiUIYrJ/4O
         VLIA3qXftR+3l59hC1MXfUTlEHvXNK+D5Wu5B1VMh9IXdpv3D9SgH8SM6oGFQpNLDyym
         dPLw==
X-Gm-Message-State: AOJu0YzRT8u6IkWHW2shXhk0+WpUiWcxBnuXVDj4iFNKQTp790IQSaX4
	OAG5X1SzGLW5zxBDkRCTL6F3OmCgCM0/U6ztePeIUpQJD2GhUcObtVtBLvE9MgR4uxwMLyhf+Jq
	OLwf7XAJwKwruPUMiFRYOfEyQbH9gz0VgLRhe6f2YAxrFdv07Cjs=
X-Google-Smtp-Source: AGHT+IHZ2u/3DJCHrxp3p5K0kiW9ap5TEVnWFWWUOBXKP62k5AYYZH/Tv0b8MtAUMi2IwAMLCXfJASG4PMP3iwry+sg=
X-Received: by 2002:a05:6359:428f:b0:178:bf01:1d with SMTP id
 kp15-20020a056359428f00b00178bf01001dmr234543rwb.25.1707149275789; Mon, 05
 Feb 2024 08:07:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202121050.977223-1-fiona.klute@gmx.de> <20240202121050.977223-10-fiona.klute@gmx.de>
In-Reply-To: <20240202121050.977223-10-fiona.klute@gmx.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Feb 2024 17:07:19 +0100
Message-ID: <CAPDyKFqRjNTvApfKou1xQn0_x5C9LXGwFHMw4OyvFcgwsrA4Zg@mail.gmail.com>
Subject: Re: [PATCH 9/9] wifi: rtw88: SDIO device driver for RTL8723CS
To: Fiona Klute <fiona.klute@gmx.de>
Cc: linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>, 
	Kalle Valo <kvalo@kernel.org>, linux-mmc@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, 
	=?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 13:11, Fiona Klute <fiona.klute@gmx.de> wrote:
>
> This driver uses the new rtw8703b chip driver code.
>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For SDIO

Kind regards
Uffe

> ---
>  drivers/net/wireless/realtek/rtw88/Kconfig    | 18 ++++++++++
>  drivers/net/wireless/realtek/rtw88/Makefile   |  6 ++++
>  .../net/wireless/realtek/rtw88/rtw8723cs.c    | 34 +++++++++++++++++++
>  include/linux/mmc/sdio_ids.h                  |  1 +
>  4 files changed, 59 insertions(+)
>  create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723cs.c
>
> diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
> index 07b5b2f6ee..22838ede03 100644
> --- a/drivers/net/wireless/realtek/rtw88/Kconfig
> +++ b/drivers/net/wireless/realtek/rtw88/Kconfig
> @@ -31,6 +31,10 @@ config RTW88_8822C
>  config RTW88_8723X
>         tristate
>
> +config RTW88_8703B
> +       tristate
> +       select RTW88_8723X
> +
>  config RTW88_8723D
>         tristate
>         select RTW88_8723X
> @@ -126,6 +130,20 @@ config RTW88_8723DS
>
>           802.11n SDIO wireless network adapter
>
> +config RTW88_8723CS
> +       tristate "Realtek 8723CS SDIO wireless network adapter"
> +       depends on MMC
> +       select RTW88_CORE
> +       select RTW88_SDIO
> +       select RTW88_8703B
> +       help
> +         Select this option to enable support for 8723CS chipset (EXPERIMENTAL)
> +
> +         This module adds support for the 8723CS 802.11n SDIO
> +         wireless network adapter.
> +
> +         If you choose to build a module, it'll be called rtw88_8723cs.
> +
>  config RTW88_8723DU
>         tristate "Realtek 8723DU USB wireless network adapter"
>         depends on USB
> diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
> index 22516c9846..8f47359b43 100644
> --- a/drivers/net/wireless/realtek/rtw88/Makefile
> +++ b/drivers/net/wireless/realtek/rtw88/Makefile
> @@ -47,6 +47,12 @@ rtw88_8822cu-objs            := rtw8822cu.o
>  obj-$(CONFIG_RTW88_8723X)      += rtw88_8723x.o
>  rtw88_8723x-objs               := rtw8723x.o
>
> +obj-$(CONFIG_RTW88_8703B)      += rtw88_8703b.o
> +rtw88_8703b-objs               := rtw8703b.o rtw8703b_tables.o
> +
> +obj-$(CONFIG_RTW88_8723CS)     += rtw88_8723cs.o
> +rtw88_8723cs-objs              := rtw8723cs.o
> +
>  obj-$(CONFIG_RTW88_8723D)      += rtw88_8723d.o
>  rtw88_8723d-objs               := rtw8723d.o rtw8723d_table.o
>
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723cs.c b/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
> new file mode 100644
> index 0000000000..8d38d36be8
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/* Copyright Fiona Klute <fiona.klute@gmx.de> */
> +
> +#include <linux/mmc/sdio_func.h>
> +#include <linux/mmc/sdio_ids.h>
> +#include <linux/module.h>
> +#include "main.h"
> +#include "rtw8703b.h"
> +#include "sdio.h"
> +
> +static const struct sdio_device_id rtw_8723cs_id_table[] = {
> +       {
> +               SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK,
> +                           SDIO_DEVICE_ID_REALTEK_RTW8723CS),
> +               .driver_data = (kernel_ulong_t)&rtw8703b_hw_spec,
> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(sdio, rtw_8723cs_id_table);
> +
> +static struct sdio_driver rtw_8723cs_driver = {
> +       .name = "rtw8723cs",
> +       .id_table = rtw_8723cs_id_table,
> +       .probe = rtw_sdio_probe,
> +       .remove = rtw_sdio_remove,
> +       .drv = {
> +               .pm = &rtw_sdio_pm_ops,
> +               .shutdown = rtw_sdio_shutdown
> +       }};
> +module_sdio_driver(rtw_8723cs_driver);
> +
> +MODULE_AUTHOR("Fiona Klute <fiona.klute@gmx.de>");
> +MODULE_DESCRIPTION("Realtek 802.11n wireless 8723cs driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 7fada7a714..7cddfdac2f 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -124,6 +124,7 @@
>  #define SDIO_DEVICE_ID_REALTEK_RTW8723DS_2ANT  0xd723
>  #define SDIO_DEVICE_ID_REALTEK_RTW8723DS_1ANT  0xd724
>  #define SDIO_DEVICE_ID_REALTEK_RTW8821DS       0xd821
> +#define SDIO_DEVICE_ID_REALTEK_RTW8723CS       0xb703
>
>  #define SDIO_VENDOR_ID_SIANO                   0x039a
>  #define SDIO_DEVICE_ID_SIANO_NOVA_B0           0x0201
> --
> 2.43.0
>
