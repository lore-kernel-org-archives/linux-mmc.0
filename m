From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: debugfs: implement ios show for SDR12 and SDR25
Date: Tue, 29 Sep 2015 12:30:51 +0200
Message-ID: <CAPDyKFrhM+jjnJuJXN03wGmH8pk_UpmC6sNMM4OXhKag8ToDhg@mail.gmail.com>
References: <1443053623-13759-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36962 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934494AbbI2Kaw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Sep 2015 06:30:52 -0400
Received: by wicfx3 with SMTP id fx3so8919479wic.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2015 03:30:51 -0700 (PDT)
In-Reply-To: <1443053623-13759-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 24 September 2015 at 02:13, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> This patch add MMC_TIMING_UHS_SDR12 and MMC_TIMING_UHS_SDR25
> for mmc_ios_show to show the ios->timing if mmc card runs under
> these two modes.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next.

Kind regards
Uffe

>
> ---
>
> Changes in v2:
> - replace "mmc uhs sdr12" with "sd uhs sdr12"
>   replace "mmc uhs sdr25" with "sd uhs sdr25"
>
>  drivers/mmc/core/debugfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 9adba8d..f4db93e 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -126,6 +126,12 @@ static int mmc_ios_show(struct seq_file *s, void *data)
>         case MMC_TIMING_SD_HS:
>                 str = "sd high-speed";
>                 break;
> +       case MMC_TIMING_UHS_SDR12:
> +               str = "sd uhs SDR12";
> +               break;
> +       case MMC_TIMING_UHS_SDR25:
> +               str = "sd uhs SDR25";
> +               break;
>         case MMC_TIMING_UHS_SDR50:
>                 str = "sd uhs SDR50";
>                 break;
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
