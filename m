From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
Date: Mon, 9 Sep 2019 15:32:41 -0700
Message-ID: <CAD=FV=V3gkAW6xLdi_yPkKzwZCMAgnmHKYi-jpXTzqS1+EU5fA@mail.gmail.com>
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-3-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190908101236.2802-3-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Matthias Kaehlcke <mka@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sun, Sep 8, 2019 at 3:12 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> the driver. However, this still means dw_mci_runtime_suspend|resume() gets
> called during system suspend/resume, via pm_runtime_force_suspend|resume().
> This means during system suspend/resume, the register context of the dw_mmc
> device most likely loses its register context, even in cases when SDIO IRQs
> have been enabled.
>
> To re-enable the SDIO IRQs during system resume, the dw_mmc driver
> currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
> the SDIO card, but this isn't the recommended solution. Instead, it's
> better to deal with this locally in the dw_mmc driver, so let's do that.
>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
