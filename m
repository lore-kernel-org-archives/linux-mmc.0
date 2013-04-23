From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH] mmc: core: Fix select power class after resume
Date: Tue, 23 Apr 2013 14:43:22 +0200
Message-ID: <CA+20K0AQQ6PxSRwyL+TAP0B0i=zUpCm6=5y0k0wKNx9yonOsYA@mail.gmail.com>
References: <1366641977-31914-1-git-send-email-fredrik.soderstedt@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:63436 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308Ab3DWMnX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Apr 2013 08:43:23 -0400
Received: by mail-qa0-f47.google.com with SMTP id bn16so577015qab.6
        for <linux-mmc@vger.kernel.org>; Tue, 23 Apr 2013 05:43:22 -0700 (PDT)
In-Reply-To: <1366641977-31914-1-git-send-email-fredrik.soderstedt@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>

Hi,

2013/4/22 Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>:
> Use the saved values in card->ext_csd when selecting power class.
> By doing this the power class will be selected even if mmc_init_card
> is called with oldcard != NULL, which is the case after a suspend/resume.
>
> Today ext_csd is NULL if mmc_init_card is called with oldcard != NULL
> and power class will not be selected.
>
> According to the eMMC specification the POWER_CLASS value is reset after
> power failure, H/W reset assertion and any CMD0 reset.
>
> CC: Girish K S <girish.shivananjappa@linaro.org>
> Signed-off-by: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
> ---

<snip>


> @@ -720,13 +750,13 @@ static int mmc_select_powerclass(struct mmc_card *card,
>         case MMC_VDD_34_35:
>         case MMC_VDD_35_36:
>                 if (host->ios.clock <= 26000000)
> -                       index = EXT_CSD_PWR_CL_26_360;
> +                       pwrclass_val = card->ext_csd.raw_pwr_cl_26_360;
>                 else if (host->ios.clock <= 52000000)
> -                       index = (bus_width <= EXT_CSD_BUS_WIDTH_8) ?
> -                               EXT_CSD_PWR_CL_52_360 :
> -                               EXT_CSD_PWR_CL_DDR_52_360;
> +                       pwrclass_val = (bus_width <= EXT_CSD_BUS_WIDTH_8) ?
> +                               card->ext_csd.raw_pwr_cl_52_360 :
> +                               card->ext_csd.raw_pwr_cl_52_360;

I believe you should have "_ddr" here, right? Otherwise it looks good.

Kind regards, Johan
