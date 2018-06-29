From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mmc: core: cd_label must be last entry of mmc_gpio struct
Date: Fri, 29 Jun 2018 17:00:27 -0300
Message-ID: <CAOMZO5BnvwB5rUr2H0=tp9wWnePoMWyfX86CT15jxsi_PaFG0Q@mail.gmail.com>
References: <1530236132-7968-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530236132-7968-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, evgreen@chromium.org, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, NXP Linux Team <Linux-imx@nxp.com>
List-Id: linux-mmc@vger.kernel.org

Hi Anson,

On Thu, Jun 28, 2018 at 10:35 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> commit bfd694d5e21c ("mmc: core: Add tunable delay
> before detecting card after card is inserted") adds
> "u32 cd_debounce_delay_ms" to the last of mmc_gpio
> struct and cause "char cd_label[0]" NOT work as string
> pointer of card detect label, when "cat /proc/interrupts",
> the devname for card detect gpio is incorrect as below:
>
> 144:          0  gpio-mxc  22 Edge      =E2=96=92
> 161:          0  gpio-mxc   7 Edge      =E2=96=92
>
> Making "char cd_label[0]" the last entry of mmc_gpio struct,
> the result is correct as below:
>
> 144:          0  gpio-mxc  22 Edge      2198000.mmc cd
> 161:          0  gpio-mxc   7 Edge      2190000.mmc cd

Please add a Fixes: tag.

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/mmc/core/slot-gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index ef05e00..1ccf9dc 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -27,8 +27,8 @@ struct mmc_gpio {
>         bool override_cd_active_level;
>         irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
>         char *ro_label;
> -       char cd_label[0];
>         u32 cd_debounce_delay_ms;
> +       char cd_label[0];

Thanks for the fix.

A more robust solution would be:

--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -27,8 +27,8 @@ struct mmc_gpio {
        bool override_cd_active_level;
        irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
        char *ro_label;
-       char cd_label[0];
        u32 cd_debounce_delay_ms;
+       char cd_label[];
 };

This way if someone tries to rearrange the struct members in the
future, then GCC will complain with the following error:
error: flexible array member not at end of struct

Please see a158531f3c92 ("gpio: 74x164: Fix crash during .remove()")
which provides a nice explanation for this same kind of problem.

Then you can add:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
