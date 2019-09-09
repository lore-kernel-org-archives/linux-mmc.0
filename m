From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 08/11] mmc: core: Fixup processing of SDIO IRQs during
 system suspend/resume
Date: Mon, 9 Sep 2019 15:34:15 -0700
Message-ID: <CAD=FV=U+eqnMX9TuyBhi7r_qjG39P9dtHHO9=PvKOvRKuoOvKw@mail.gmail.com>
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-9-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190908101236.2802-9-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Matthias Kaehlcke <mka@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sun, Sep 8, 2019 at 3:12 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> System suspend/resume of SDIO cards, with SDIO IRQs enabled and when using
> MMC_CAP2_SDIO_IRQ_NOTHREAD is unfortunate still suffering from a fragile
> behaviour. Some problems have been taken care of so far, but more issues
> remains.
>
> For example, calling the ->ack_sdio_irq() callback to let host drivers
> re-enable the SDIO IRQs is a bad idea, unless the IRQ have been consumed,
> which may not be the case during system suspend/resume. This may lead to
> that a host driver re-signals the same SDIO IRQ over and over again,
> causing a storm of IRQs and gives a ping-pong effect towards the
> sdio_irq_work().
>
> Moreover, calling the ->enable_sdio_irq() callback at system resume to
> re-enable already enabled SDIO IRQs for the host, causes the runtime PM
> count for some host drivers to become in-balanced. This then leads to the
> host to remain runtime resumed, no matter if it's needed or not.
>
> To fix these problems, let's check if process_sdio_pending_irqs() actually
> consumed the SDIO IRQ, before we continue to ack the IRQ by invoking the
> ->ack_sdio_irq() callback.
>
> Additionally, there should be no need to re-enable SDIO IRQs as the host
> driver already knows if they were enabled at system suspend, thus also
> whether it needs to re-enable them at system resume. For this reason, drop
> the call to ->enable_sdio_irq() during system resume.
>
> In regards to these changes there is yet another issue, which is when there
> is an SDIO IRQ being signaled by the host driver, but after the SDIO card
> has been system suspended. Currently these IRQs are just thrown away, while
> we should at least make sure to try to consume them when the SDIO card has
> been system resumed. Fix this by queueing a sdio_irq_work() after we system
> resumed the SDIO card.
>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Queue a sdio_irq_work() rather using sdio_signal_irq().
>
> ---
>  drivers/mmc/core/sdio.c     | 2 +-
>  drivers/mmc/core/sdio_irq.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
