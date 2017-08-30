From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sunxi: Reset the device at probe time
Date: Wed, 30 Aug 2017 15:14:11 +0200
Message-ID: <CAPDyKFqAyhB1C096YjXNz2iAPL0Vrr5-hsyoiL8meho1b0qNPg@mail.gmail.com>
References: <20170825094953.3247-1-maxime.ripard@free-electrons.com> <20170825094953.3247-2-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35142 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbdH3NOM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Aug 2017 09:14:12 -0400
Received: by mail-io0-f172.google.com with SMTP id k22so4918450iod.2
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2017 06:14:12 -0700 (PDT)
In-Reply-To: <20170825094953.3247-2-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 25 August 2017 at 11:49, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> We might be into some troubles if the bootloader misconfigured the MMC
> controller.
>
> We currently only de-assert the reset line at probe time, which means that
> if the device was already out of reset, we're going to keep whatever state
> was set already.
>
> Switch to a reset instead of the deassert to have a device in a pristine
> state when we start operating.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index da5f46a14497..53c970fe0873 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1242,7 +1242,7 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>         }
>
>         if (!IS_ERR(host->reset)) {
> -               ret = reset_control_deassert(host->reset);
> +               ret = reset_control_reset(host->reset);
>                 if (ret) {
>                         dev_err(&pdev->dev, "reset err %d\n", ret);
>                         goto error_disable_clk_sample;
> --
> 2.13.5
>
