From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mediatek: add SD write protect support
Date: Tue, 16 Feb 2016 17:35:33 +0100
Message-ID: <CAPDyKFoVj9BDsAsuDV+h7=06FD7Kv=ivN=p=LZMMO+yF2QZ67Q@mail.gmail.com>
References: <1455474660-19864-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455474660-19864-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On 14 February 2016 at 19:31, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> use mmc core layer's API to support sd write protect
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 82a97ac..f01972e 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -35,6 +35,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/sd.h>
>  #include <linux/mmc/sdio.h>
> +#include <linux/mmc/slot-gpio.h>
>
>  #define MAX_BD_NUM          1024
>
> @@ -1452,6 +1453,7 @@ static struct mmc_host_ops mt_msdc_ops = {
>         .pre_req = msdc_pre_req,
>         .request = msdc_ops_request,
>         .set_ios = msdc_ops_set_ios,
> +       .get_ro = mmc_gpio_get_ro,
>         .start_signal_voltage_switch = msdc_ops_switch_volt,
>         .card_busy = msdc_card_busy,
>         .execute_tuning = msdc_execute_tuning,
> --
> 1.8.1.1.dirty
>
