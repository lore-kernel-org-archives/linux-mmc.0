From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: debugfs: implement ios show for SDR12 and SDR25
Date: Wed, 23 Sep 2015 21:33:45 +0200
Message-ID: <CAPDyKFqe=QyN1J4oLjDHLyn_xpCUWQC0RxP56pmA6xGih_qBTw@mail.gmail.com>
References: <1442884713-11193-1-git-send-email-shawn.lin@rock-chips.com>
	<1442884795-11493-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37698 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838AbbIWTdq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Sep 2015 15:33:46 -0400
Received: by wicfx3 with SMTP id fx3so84245860wic.0
        for <linux-mmc@vger.kernel.org>; Wed, 23 Sep 2015 12:33:45 -0700 (PDT)
In-Reply-To: <1442884795-11493-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 22 September 2015 at 03:19, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> This patch add MMC_TIMING_UHS_SDR12 and MMC_TIMING_UHS_SDR25
> for mmc_ios_show to show the ios->timing if mmc card runs under
> these two mode.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/mmc/core/debugfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index b2ab936..31155e8 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -126,6 +126,12 @@ static int mmc_ios_show(struct seq_file *s, void *data)
>         case MMC_TIMING_SD_HS:
>                 str = "sd high-speed";
>                 break;
> +       case MMC_TIMING_UHS_SDR12:
> +               str = "mmc uhs SDR12";

/s/mmc/sd

> +               break;
> +       case MMC_TIMING_UHS_SDR25:
> +               str = "mmc uhs SDR25";

/s/mmc/sd


> +               break;
>         case MMC_TIMING_UHS_SDR50:
>                 str = "sd uhs SDR50";
>                 break;
> --
> 2.3.7
>
>

Otherwise it looks good.

Kind regards
Uffe
