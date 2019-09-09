From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 06/11] mmc: core: Clarify that the ->ack_sdio_irq()
 callback is mandatory
Date: Mon, 9 Sep 2019 15:34:07 -0700
Message-ID: <CAD=FV=UM5_FzEuS5AfvA94_gKw5aog2VKDtZrnRiA_gAz+bq+A@mail.gmail.com>
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-7-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190908101236.2802-7-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Matthias Kaehlcke <mka@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sun, Sep 8, 2019 at 3:12 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> For the MMC_CAP2_SDIO_IRQ_NOTHREAD case and when using sdio_signal_irq(),
> the ->ack_sdio_irq() is already mandatory, which was not the case for those
> host drivers that called sdio_run_irqs() directly.
>
> As there are no longer any drivers calling sdio_run_irqs(), let's clarify
> the code by dropping the unnecessary check and explicitly state that the
> callback is mandatory in the header file.
>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 3 +--
>  include/linux/mmc/host.h    | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
