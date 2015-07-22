From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] sdhci-esdhc: Make 8BIT bus work.
Date: Wed, 22 Jul 2015 14:18:43 +0200
Message-ID: <CAPDyKFpzMrzoY3xDHsMTwOUk0Xkp1d-cY_UW7U0EEfoYQakU0A@mail.gmail.com>
References: <1437409187-7039-1-git-send-email-joakim.tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35184 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964878AbbGVMSo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jul 2015 08:18:44 -0400
Received: by qkbm65 with SMTP id m65so97413440qkb.2
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jul 2015 05:18:43 -0700 (PDT)
In-Reply-To: <1437409187-7039-1-git-send-email-joakim.tjernlund@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kevin Hao <haokexin@gmail.com>

On 20 July 2015 at 18:19, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
> Support for 8BIT bus with was added some time ago to sdhci-esdhc but
> then missed to remove the 8BIT from the reserved bit mask which made
> 8BIT non functional.
>
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>

Should this be queued as a fix then? If so, please resend and include
a fixes tag.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index 3497cfa..a870c42 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -45,6 +45,6 @@
>  #define ESDHC_DMA_SYSCTL       0x40c
>  #define ESDHC_DMA_SNOOP                0x00000040
>
> -#define ESDHC_HOST_CONTROL_RES 0x05
> +#define ESDHC_HOST_CONTROL_RES 0x01
>
>  #endif /* _DRIVERS_MMC_SDHCI_ESDHC_H */
> --
> 2.3.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
