From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv2 ] sdhci-esdhc: Make 8BIT bus work.
Date: Wed, 22 Jul 2015 16:50:31 +0200
Message-ID: <CAPDyKFr3ibjhCN8EQgLJu-vi9_8OXJ3YJtrKwzq7PPKNgAy=uQ@mail.gmail.com>
References: <1437576266-21120-1-git-send-email-joakim.tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35786 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933694AbbGVOuc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jul 2015 10:50:32 -0400
Received: by qgii95 with SMTP id i95so72644698qgi.2
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jul 2015 07:50:31 -0700 (PDT)
In-Reply-To: <1437576266-21120-1-git-send-email-joakim.tjernlund@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 22 July 2015 at 16:44, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
> Support for 8BIT bus with was added some time ago to sdhci-esdhc but
> then missed to remove the 8BIT from the reserved bit mask which made
> 8BIT non functional.
>
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> Fixes: 66b50a00992d ("mmc: esdhc: Add support for 8-bit bus width and non-removable card")

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>
>  - v2: Added Fixes: tag
>
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
