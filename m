From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: mediatek: Use mmc_regulator_set_vqmmc in start_signal_voltage_switch
Date: Fri, 4 Mar 2016 10:41:51 +0100
Message-ID: <CAPDyKFptSCN8xHqHbGv+EBzweKRuKoYATAkK1UETHiqyF7YgGg@mail.gmail.com>
References: <1457000385-2317-1-git-send-email-drinkcat@chromium.org>
	<1457000385-2317-2-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457000385-2317-2-git-send-email-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On 3 March 2016 at 11:19, Nicolas Boichat <drinkcat@chromium.org> wrote:
> We've introduced a new helper in the MMC core:
> mmc_regulator_set_vqmmc().  Let's use this in mtk-sd.  Using this new
> helper has some advantages:
>
>     1. We get the mmc_regulator_set_vqmmc() behavior of trying to match
>        VQMMC and VMMC when the signal voltage is 3.3V.  This ensures max
>        compatibility.
>
>     2. We get rid of a few more warnings when probing unsupported
>        voltages.
>
>     3. We get rid of some non-mediatek specific code in mtk-sd.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> Similar to e0848f5d294c703917260a6228cc08b8be46c527
> mmc: dw_mmc: Use mmc_regulator_set_vqmmc in start_signal_voltage_switch ,
> where I copied the commit message from.
>
>  drivers/mmc/host/mtk-sd.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 07809f4..b17f30d 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1021,26 +1021,19 @@ static void msdc_set_buswidth(struct msdc_host *host, u32 width)
>  static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         struct msdc_host *host = mmc_priv(mmc);
> -       int min_uv, max_uv;
>         int ret = 0;
>
>         if (!IS_ERR(mmc->supply.vqmmc)) {
> -               if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> -                       min_uv = 3300000;
> -                       max_uv = 3300000;
> -               } else if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> -                       min_uv = 1800000;
> -                       max_uv = 1800000;
> -               } else {
> +               if (ios->signal_voltage != MMC_SIGNAL_VOLTAGE_330 &&
> +                   ios->signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
>                         dev_err(host->dev, "Unsupported signal voltage!\n");
>                         return -EINVAL;
>                 }
>
> -               ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
> +               ret = mmc_regulator_set_vqmmc(mmc, ios);
>                 if (ret) {
> -                       dev_dbg(host->dev,
> -                                       "Regulator set error %d: %d - %d\n",
> -                                       ret, min_uv, max_uv);
> +                       dev_dbg(host->dev, "Regulator set error %d (%d)\n",
> +                               ret, ios->signal_voltage);
>                 } else {
>                         /* Apply different pinctrl settings for different signal voltage */
>                         if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
> --
> 2.7.0.rc3.207.g0ac5344
>
