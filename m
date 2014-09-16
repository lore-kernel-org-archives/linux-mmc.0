From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-exynos: fixed wrong sample-clock selection
Date: Wed, 17 Sep 2014 03:57:58 +0530
Message-ID: <CAGOxZ53veu=t+8yzkqCmh0wTWKBBDvuE99qbNbfZuuPxAG=m=Q@mail.gmail.com>
References: <1410776768-1303-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:45104 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbaIPW2k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Sep 2014 18:28:40 -0400
Received: by mail-lb0-f171.google.com with SMTP id 10so723001lbg.16
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2014 15:28:39 -0700 (PDT)
In-Reply-To: <1410776768-1303-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

Hi Jaehoon,

On Mon, Sep 15, 2014 at 3:56 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Almost all case is selected to 0.
> (It's not correct sample-clock value.)
> Since it set to wrong value, HS200 mode don't work fine.
Can you please explain what problem you are facing here?
It is not clear from your patch description.
> If we want to select the correct value, it has to check from 1 to 7.(skip 0)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 0fbc53a..5294035 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -25,6 +25,7 @@
>  #define NUM_PINS(x)                    (x + 2)
>
>  #define SDMMC_CLKSEL                   0x09C
> +#define SDMMC_CLKSEL_CCLK_SAMPLE_MASK  0x7
>  #define SDMMC_CLKSEL_CCLK_SAMPLE(x)    (((x) & 7) << 0)
>  #define SDMMC_CLKSEL_CCLK_DRIVE(x)     (((x) & 7) << 16)
>  #define SDMMC_CLKSEL_CCLK_DIVIDER(x)   (((x) & 7) << 24)
> @@ -330,6 +331,12 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
>         if (!blk_test)
>                 return -ENOMEM;
>
> +       /*
> +        * In order to check all selclk_sample clock,
> +        * it needs to reset to 0.
> +        */
> +       dw_mci_exynos_set_clksmpl(host, 0);
> +
>         start_smpl = dw_mci_exynos_get_clksmpl(host);
>
>         do {
> @@ -372,7 +379,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
>                                 "Tuning error: cmd.error:%d, data.error:%d\n",
>                                 cmd.error, data.error);
>                 }
> -       } while (start_smpl != smpl);
> +       } while (start_smpl < SDMMC_CLKSEL_CCLK_SAMPLE_MASK);
>
>         found = dw_mci_exynos_get_best_clksmpl(candiates);
>         if (found >= 0)
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
