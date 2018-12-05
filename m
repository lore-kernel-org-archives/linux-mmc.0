From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: meson-mx-sdio: check devm_kasprintf for failure
Date: Wed, 5 Dec 2018 15:23:52 +0100
Message-ID: <CAPDyKFpWevQkGncmeJjnsusTBWOc6xecUGsP_8oUMeAwwF4D7Q@mail.gmail.com>
References: <1542879319-2196-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542879319-2196-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 22 Nov 2018 at 10:40, Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> devm_kasprintf() may return NULL on failure of internal allocation thus
> the assignments to  init.name  are not safe if not checked. On error
> meson_mx_mmc_register_clks() returns negative values so -ENOMEM in the
> (unlikely) failure case of devm_kasprintf() should be fine here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")

Applied for next, thanks!

Kind regards
Uffe

> ---
>
> Problem located with an experimental coccinelle script
>
> Patch was compile tested with: multi_v7_defconfig (implies ARCH_MESON=y &
> MMC_MESON_MX_SDIO=y)
>
> Patch is against 4.20-rc3 (localversion-next is next-20181122)
>
>  drivers/mmc/host/meson-mx-sdio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index abe253c..ec980bd 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -596,6 +596,9 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
>         init.name = devm_kasprintf(host->controller_dev, GFP_KERNEL,
>                                    "%s#fixed_factor",
>                                    dev_name(host->controller_dev));
> +       if (!init.name)
> +               return -ENOMEM;
> +
>         init.ops = &clk_fixed_factor_ops;
>         init.flags = 0;
>         init.parent_names = &clk_fixed_factor_parent;
> @@ -612,6 +615,9 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
>         clk_div_parent = __clk_get_name(host->fixed_factor_clk);
>         init.name = devm_kasprintf(host->controller_dev, GFP_KERNEL,
>                                    "%s#div", dev_name(host->controller_dev));
> +       if (!init.name)
> +               return -ENOMEM;
> +
>         init.ops = &clk_divider_ops;
>         init.flags = CLK_SET_RATE_PARENT;
>         init.parent_names = &clk_div_parent;
> --
> 2.1.4
>
