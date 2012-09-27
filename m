From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 11/15] mmc: sdhci-pxav3: add signal_voltage_switch function
Date: Thu, 27 Sep 2012 15:17:30 +0800
Message-ID: <CAMj5BkiLdUbWEUQUXQLBbj-KTEw4XQ-vPRXMDzBB_qOJhS8dpQ@mail.gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
	<1348659527-4200-12-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:62713 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454Ab2I0HRb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Sep 2012 03:17:31 -0400
Received: by lagh6 with SMTP id h6so309662lag.19
        for <linux-mmc@vger.kernel.org>; Thu, 27 Sep 2012 00:17:30 -0700 (PDT)
In-Reply-To: <1348659527-4200-12-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Bin Wang <binw@marvell.com>

> +       if (pdata && pdata->signal_voltage_switch)
> +               pdata->signal_voltage_switch(set);
> +}
> +

>  #ifdef CONFIG_OF
> diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
> index fdf38d6..3b94ab1 100644
> --- a/include/linux/platform_data/pxa_sdhci.h
> +++ b/include/linux/platform_data/pxa_sdhci.h
> @@ -40,6 +40,7 @@
>   * @quirks: quirks of platfrom
>   * @quirks2: quirks2 of platfrom
>   * @pm_caps: pm_caps of platfrom
> + * @signal_voltage_switch: soc/platfrom handling needed for voltage switch
>   */
>  struct sdhci_pxa_platdata {
>         unsigned int    flags;
> @@ -54,6 +55,7 @@ struct sdhci_pxa_platdata {
>         unsigned int    quirks;
>         unsigned int    quirks2;
>         unsigned int    pm_caps;
> +       void    (*signal_voltage_switch)(unsigned int set);
>  };
>

Using callback from pdata is in-acceptable.
DT can not doing such way.

/Zhangfei
