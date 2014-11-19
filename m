From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: avoid write to CDTHRCTL on older versions
Date: Wed, 19 Nov 2014 11:53:55 +0100
Message-ID: <CAPDyKFqC3kuHRV5Rt+0mgTeB6A5uQfbPg4CgOTHdfX9oTzNnMA@mail.gmail.com>
References: <1416246545-14118-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1416246545-14118-1-git-send-email-james.hogan@imgtec.com>
Sender: stable-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, stable@vger.kernel.org, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 17 November 2014 18:49, James Hogan <james.hogan@imgtec.com> wrote:
> Commit f1d2736c8156 (mmc: dw_mmc: control card read threshold) added
> dw_mci_ctrl_rd_thld() with an unconditional write to the CDTHRCTL
> register at offset 0x100. However before version 240a, the FIFO region
> started at 0x100, so the write messes with the FIFO and completely
> breaks the driver.
>
> If the version id < 240A, return early from dw_mci_ctl_rd_thld() so as
> not to hit this problem.
>
> Fixes: f1d2736c8156 (mmc: dw_mmc: control card read threshold)
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: <stable@vger.kernel.org> # v3.13+
> Cc: Seungwon Jeon <tgih.jun@samsung.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Chris Ball <chris@printf.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org

Thanks! Applied for next and removing some of the Cc:s above,

Kind regards
Uffe


> ---
> Note I've completely guessed at 240A being the point where that register
> was introduced since the FIFO region moved then.
> ---
>  drivers/mmc/host/dw_mmc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 69f0cc68d5b2..f7c95abc8c11 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -626,6 +626,13 @@ static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
>
>         WARN_ON(!(data->flags & MMC_DATA_READ));
>
> +       /*
> +        * CDTHRCTL doesn't exist prior to 240A (in fact that register offset is
> +        * in the FIFO region, so we really shouldn't access it).
> +        */
> +       if (host->verid < DW_MMC_240A)
> +               return;
> +
>         if (host->timing != MMC_TIMING_MMC_HS200 &&
>             host->timing != MMC_TIMING_UHS_SDR104)
>                 goto disable;
> --
> 2.0.4
>
