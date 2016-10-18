From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Check regulator pointer
Date: Tue, 18 Oct 2016 11:03:02 +0200
Message-ID: <CAPDyKFquN_f1ZKW3G6ZsTnnGJa-7N4R4-RpF=E4PN+7OTrxhZg@mail.gmail.com>
References: <20161018084343.680-1-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34150 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758328AbcJRJDE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 05:03:04 -0400
Received: by mail-qk0-f173.google.com with SMTP id f128so267497228qkb.1
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2016 02:03:03 -0700 (PDT)
In-Reply-To: <20161018084343.680-1-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 18 October 2016 at 10:43, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> mmc_regulator_get_supply might silently fail if the regulators are not
> found, which is the right thing to do since both these regulators are
> optional.
>
> However, the drivers then have no way to know whether or not they should
> proceed and call mmc_regulator_set_ocr. And since this function doesn't

Host drivers should check "if (!IS_ERR(mmc->supply.vmmc))" before
invoking mmc_regulator_set_ocr(). I wasn't aware that some didn't.

My point is, that in some cases the regulator is optional, then a host
driver need to take other actions to power on/off the card. So, I am
wondering whether adding these checks in mmc_regulator_set_ocr() is a
bit unnecessary, as the host drivers are already checking the
IS_ERR().

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
> +
>         if (vdd_bit) {
>                 mmc_ocrbitnum_to_vdd(vdd_bit, &min_uV, &max_uV);
>
> --
> 2.9.3
>

Kind regards
Uffe
