From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH v4 07/15] mmc: host: adjust uhs timing value
Date: Wed, 26 Sep 2012 22:00:19 +0900
Message-ID: <CAGxe1ZEaUujjPzB0nZX4nJbcnU+Y=pz_sKr_9CGUKT8q234eQw@mail.gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
	<1348659527-4200-8-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:38799 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab2IZNAU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Sep 2012 09:00:20 -0400
Received: by vbbff1 with SMTP id ff1so551000vbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 26 Sep 2012 06:00:19 -0700 (PDT)
In-Reply-To: <1348659527-4200-8-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

Reviewed By: Girish K S <girish.shivananjappa@linaro.org>

On 26 September 2012 20:38, Kevin Liu <keyuan.liu@gmail.com> wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> Both of MMC_TIMING_LEGACY and MMC_TIMING_UHS_SDR12 are defined
> to 0. And ios->timing is set to MMC_TIMING_LEGACY during power up.
> But set_ios can't distinguish these two timing if host support
> spec 3.0. Just adjust timing values to be different can resolve
> this issue without any other impact.
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> ---
>  include/linux/mmc/host.h |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index d5d9bd4..036a5cc 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -53,12 +53,12 @@ struct mmc_ios {
>  #define MMC_TIMING_LEGACY      0
>  #define MMC_TIMING_MMC_HS      1
>  #define MMC_TIMING_SD_HS       2
> -#define MMC_TIMING_UHS_SDR12   MMC_TIMING_LEGACY
> -#define MMC_TIMING_UHS_SDR25   MMC_TIMING_SD_HS
> -#define MMC_TIMING_UHS_SDR50   3
> -#define MMC_TIMING_UHS_SDR104  4
> -#define MMC_TIMING_UHS_DDR50   5
> -#define MMC_TIMING_MMC_HS200   6
> +#define MMC_TIMING_UHS_SDR12   3
> +#define MMC_TIMING_UHS_SDR25   4
> +#define MMC_TIMING_UHS_SDR50   5
> +#define MMC_TIMING_UHS_SDR104  6
> +#define MMC_TIMING_UHS_DDR50   7
> +#define MMC_TIMING_MMC_HS200   8
>
>  #define MMC_SDR_MODE           0
>  #define MMC_1_2V_DDR_MODE      1
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
