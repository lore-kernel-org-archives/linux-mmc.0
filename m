From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 05/11] mmc: core: Clarify sdio_irq_pending flag for MMC_CAP2_SDIO_IRQ_NOTHREAD
Date: Mon, 9 Sep 2019 15:33:52 -0700
Message-ID: <CAD=FV=XixFRMaKV8z84aBSwZirfoFmy9PcXGaD4aPuyu0BQy-A@mail.gmail.com>
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-6-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190908101236.2802-6-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Matthias Kaehlcke <mka@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sun, Sep 8, 2019 at 3:12 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The sdio_irq_pending flag is used to let host drivers indicate that it has
> signaled an IRQ. If that is the case and we only have a single SDIO func
> that have claimed an SDIO IRQ, our assumption is that we can avoid reading
> the SDIO_CCCR_INTx register and just call the SDIO func irq handler
> immediately. This makes sense, but the flag is set/cleared in a somewhat
> messy order, let's fix that up according to below.
>
> First, the flag is currently set in sdio_run_irqs(), which is executed as a
> work that was scheduled from sdio_signal_irq(). To make it more implicit
> that the host have signaled an IRQ, let's instead immediately set the flag
> in sdio_signal_irq(). This also makes the behavior consistent with host
> drivers that uses the legacy, mmc_signal_sdio_irq() API. This have no
> functional impact, because we don't expect host drivers to call
> sdio_signal_irq() until after the work (sdio_run_irqs()) have been executed
> anyways.
>
> Second, currently we never clears the flag when using the sdio_run_irqs()
> work, but only when using the sdio_irq_thread(). Let make the behavior

s/Let/Let's


> consistent, by moving the flag to be cleared inside the common
> process_sdio_pending_irqs() function. Additionally, tweak the behavior of
> the flag slightly, by avoiding to clear it unless we processed the SDIO
> IRQ. The purpose with this at this point, is to keep the information about
> whether there have been an SDIO IRQ signaled by the host, so at system
> resume we can decide to process it without reading the SDIO_CCCR_INTx
> register.
>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Re-wrote changelog.
>
> ---
>  drivers/mmc/core/sdio_irq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
