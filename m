From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 09/15] mmc: sdhci-pxav3: add quirks2
Date: Thu, 27 Sep 2012 15:34:14 +0800
Message-ID: <CAMj5Bkgy6i2tg2yvEyLvEDOxB9n=ON5H4zqxiGOnzT-2pHz-FA@mail.gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
	<1348659527-4200-10-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:40555 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756459Ab2I0HeQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Sep 2012 03:34:16 -0400
Received: by bkcjk13 with SMTP id jk13so1253216bkc.19
        for <linux-mmc@vger.kernel.org>; Thu, 27 Sep 2012 00:34:15 -0700 (PDT)
In-Reply-To: <1348659527-4200-10-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

> diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
> index 59acd98..fdf38d6 100644
> --- a/include/linux/platform_data/pxa_sdhci.h
> +++ b/include/linux/platform_data/pxa_sdhci.h
> @@ -38,6 +38,7 @@
>   * @max_speed: the maximum speed supported
>   * @host_caps: Standard MMC host capabilities bit field.
>   * @quirks: quirks of platfrom
> + * @quirks2: quirks2 of platfrom
>   * @pm_caps: pm_caps of platfrom
>   */
>  struct sdhci_pxa_platdata {
> @@ -51,6 +52,7 @@ struct sdhci_pxa_platdata {
>         unsigned int    host_caps;
>         unsigned int    host_caps2;
>         unsigned int    quirks;
> +       unsigned int    quirks2;
>         unsigned int    pm_caps;
>  };
>
Not find the patch using quirks2.
Could you merge the patch together?
