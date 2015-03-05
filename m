From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sunxi: Use devm_reset_control_get_optional() for
 reset control
Date: Thu, 5 Mar 2015 14:45:05 +0100
Message-ID: <CAPDyKFpp2BTt8=uZpDW5=UoCHb_bV8gpX=EXms6GeT+OwZJYRw@mail.gmail.com>
References: <1425347080-1789-1-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:43140 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbCENpF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 08:45:05 -0500
Received: by qcxr5 with SMTP id r5so43012422qcx.10
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2015 05:45:05 -0800 (PST)
In-Reply-To: <1425347080-1789-1-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org

On 3 March 2015 at 02:44, Chen-Yu Tsai <wens@csie.org> wrote:
> The reset control for the sunxi mmc controller is optional. Some
> newer platforms (sun6i, sun8i, sun9i) have it, while older ones
> (sun4i, sun5i, sun7i) don't.
>
> Use the properly stubbed _optional version so the driver does not
> fail to compile when RESET_CONTROLLER=n.
>
> This patch also adds a check for deferred probing on the reset
> control.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Cc: <stable@vger.kernel.org> # 3.16+

Applied, thanks!

Kind regards
Uffe


> ---
>
> Arnd had some proposals about the reset control API.
> Not sure if the sunxi-mmc driver was on that list.
>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index e8a4218b5726..459ed1b601db 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -930,7 +930,9 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>                 return PTR_ERR(host->clk_sample);
>         }
>
> -       host->reset = devm_reset_control_get(&pdev->dev, "ahb");
> +       host->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");
> +       if (PTR_ERR(host->reset) == -EPROBE_DEFER)
> +               return PTR_ERR(host->reset);
>
>         ret = clk_prepare_enable(host->clk_ahb);
>         if (ret) {
> --
> 2.1.4
>
