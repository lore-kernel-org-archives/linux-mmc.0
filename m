From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH v2 2/3] mmc: dw_mmc: Use mmc_regulator_set_vqmmc in start_signal_voltage_switch
Date: Mon, 15 Dec 2014 15:44:24 -0800
Message-ID: <CAL1qeaHfsq1xOOBMQc58uSvV4unuEWHjqVpiZrpu2bQD36LbXg@mail.gmail.com>
References: <1418685929-13096-1-git-send-email-dianders@chromium.org>
	<1418685929-13096-2-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418685929-13096-2-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Mark Brown <broonie@kernel.org>, Alexandru Stan <amstan@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Doug,

On Mon, Dec 15, 2014 at 3:25 PM, Doug Anderson <dianders@chromium.org> wrote:
> We've introduced a new helper in the MMC core:
> mmc_regulator_set_vqmmc().  Let's use this in dw_mmc.  Using this new
> helper has some advantages:
>
> 1. We get the mmc_regulator_set_vqmmc() behavior of trying to match
>    VQMMC and VMMC when the signal voltage is 3.3V.  This ensures max
>    compatibility.
>
> 2. We get rid of a few more warnings when probing unsupported
>    voltages.
>
> 3. We get rid of some non-dw_mmc specific code in dw_mmc.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

One small comment below...

> @@ -1170,24 +1168,11 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>          */
>         uhs = mci_readl(host, UHS_REG);
>         if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> -               min_uv = 2700000;
> -               max_uv = 3600000;
>                 uhs &= ~v18;
>         } else {
> -               min_uv = 1700000;
> -               max_uv = 1950000;
>                 uhs |= v18;
>         }
> -       if (!IS_ERR(mmc->supply.vqmmc)) {
> -               ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
> -
> -               if (ret) {
> -                       dev_dbg(&mmc->class_dev,
> -                                        "Regulator set error %d: %d - %d\n",
> -                                        ret, min_uv, max_uv);
> -                       return ret;
> -               }
> -       }
> +       mmc_regulator_set_vqmmc(mmc, ios);

Shouldn't we check the return value here and bail out of the voltage
switch procedure if it fails?
