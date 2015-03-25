From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Cascade EPROBE_DEFER from regulators.
Date: Wed, 25 Mar 2015 09:51:55 +0100
Message-ID: <CAPDyKFoZ1ztGJ5TTJkDBSipm1Xru8=voXo7_CO_p9mB1XZCnbA@mail.gmail.com>
References: <1427247589-1229-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427247589-1229-1-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Russell King <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 25 March 2015 at 02:39, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Thanks! Applied.

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 7fe1619..fb26674 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1613,7 +1613,10 @@ static int mmci_probe(struct amba_device *dev,
>         dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
>
>         /* Get regulators and the supported OCR mask */
> -       mmc_regulator_get_supply(mmc);
> +       ret = mmc_regulator_get_supply(mmc);
> +       if (ret == -EPROBE_DEFER)
> +               goto clk_disable;
> +
>         if (!mmc->ocr_avail)
>                 mmc->ocr_avail = plat->ocr_mask;
>         else if (plat->ocr_mask)
> --
> 1.8.2.2
>
