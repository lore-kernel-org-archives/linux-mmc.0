From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH] mmc: core: Check regulator pointer
Date: Tue, 18 Oct 2016 16:55:14 +0800
Message-ID: <CAMz4kuK8AivjBZX6AQdfmNWrMq0E3a=5iv2ekOi54edXkT8C8w@mail.gmail.com>
References: <20161018084343.680-1-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161018084343.680-1-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 18 October 2016 at 16:43, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> mmc_regulator_get_supply might silently fail if the regulators are not
> found, which is the right thing to do since both these regulators are
> optional.
>
> However, the drivers then have no way to know whether or not they should
> proceed and call mmc_regulator_set_ocr. And since this function doesn't
> check for the validity of the regulator pointer, it leads to a null pointer
> dereference. Add such a check to make sure everything works fine.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/mmc/core/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 2553d903a82b..1d3ea5e1aa37 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1474,6 +1474,12 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
>         int                     result = 0;
>         int                     min_uV, max_uV;
>
> +       if (!supply)
> +               return -EINVAL;
> +
> +       if (IS_ERR(supply))
> +               return PTR_ERR(supply);

You can simply these checking with IS_ERR_OR_NULL().

> +
>         if (vdd_bit) {
>                 mmc_ocrbitnum_to_vdd(vdd_bit, &min_uV, &max_uV);
>
> --
> 2.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Baolin.wang
Best Regards
