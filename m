From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Fix menuconfig alignment of MMC_SDHCI_* options
Date: Tue, 27 Jan 2015 14:57:13 +0100
Message-ID: <CAPDyKFqQCy-g0ubFFfg+C0x==qQpdFY-JQAG0JDCYoSwy_xtCA@mail.gmail.com>
References: <20150126113544.3f44e4a1@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:39150 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbbA0N5O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jan 2015 08:57:14 -0500
Received: by mail-qg0-f49.google.com with SMTP id i50so11696333qgf.8
        for <linux-mmc@vger.kernel.org>; Tue, 27 Jan 2015 05:57:13 -0800 (PST)
In-Reply-To: <20150126113544.3f44e4a1@endymion.delvare>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Albert Herranz <albert_herranz@yahoo.es>

On 26 January 2015 at 11:35, Jean Delvare <jdelvare@suse.de> wrote:
> Let MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER depend on MMC_SDHCI. Not
> only this is more correct, but this also avoids breaking the alignment
> of all other MMC_SDHCI_* options in menuconfig.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Chris Ball <chris@printf.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Albert Herranz <albert_herranz@yahoo.es>

Thanks! Applied for next.

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-3.19-rc6.orig/drivers/mmc/host/Kconfig        2015-01-26 11:18:57.715667965 +0100
> +++ linux-3.19-rc6/drivers/mmc/host/Kconfig     2015-01-26 11:26:31.986215716 +0100
> @@ -57,6 +57,7 @@ config MMC_SDHCI_IO_ACCESSORS
>
>  config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
>         bool
> +       depends on MMC_SDHCI
>         select MMC_SDHCI_IO_ACCESSORS
>         help
>           This option is selected by drivers running on big endian hosts
>
>
> --
> Jean Delvare
> SUSE L3 Support
