From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 03/11] mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
Date: Mon, 9 Sep 2019 15:29:10 -0700
Message-ID: <CAD=FV=U=ohP9KFWrMYfdbT4WbOxGXFNMd71c7ej1G9Qrtim=7w@mail.gmail.com>
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-4-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190908101236.2802-4-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Matthias Kaehlcke <mka@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, LKML <linux-kernel@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sun, Sep 8, 2019 at 3:12 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> the driver. However, this still means msdc_runtime_suspend|resume() gets
> called during system suspend/resume, via pm_runtime_force_suspend|resume().
>
> This means during system suspend/resume, the register context of the mtk-sd
> device most likely loses its register context, even in cases when SDIO IRQs
> have been enabled.
>
> To re-enable the SDIO IRQs during system resume, the mtk-sd driver
> currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
> the SDIO card, but this isn't the recommended solution. Instead, it's
> better to deal with this locally in the mtk-sd driver, so let's do that.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/mtk-sd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 6946bb040a28..ae7688098b7b 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2408,6 +2408,9 @@ static void msdc_save_reg(struct msdc_host *host)
>         } else {
>                 host->save_para.pad_tune = readl(host->base + tune_reg);
>         }
> +
> +       if (sdio_irq_claimed(host->mmc))
> +               __msdc_enable_sdio_irq(host, 1);
>  }
>
>  static void msdc_restore_reg(struct msdc_host *host)

I don't personally have a Mediatek device setup to test this patch on.
If it's super urgent I could try to track down one and try to set it
up, but hopefully it's easier for someone else...

That being said, from code inspection it seems like you should be
adding your code to msdc_restore_reg(), not to msdc_save_reg().  Am I
confused?

-Doug
