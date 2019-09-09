From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 04/11] mmc: core: Move code to get pending SDIO IRQs to
 a function
Date: Mon, 9 Sep 2019 15:32:51 -0700
Message-ID: <CAD=FV=WhJ_wL181sWUZoKKaQWnZUDkkG=QovJsugsBVOzAOi9Q@mail.gmail.com>
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-5-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190908101236.2802-5-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Matthias Kaehlcke <mka@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sun, Sep 8, 2019 at 3:12 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> From: Matthias Kaehlcke <mka@chromium.org>
>
> To improve code quality, let's move the code that gets pending SDIO IRQs
> from process_sdio_pending_irqs() into a dedicated function.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> [Ulf: Converted function into static]
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 46 ++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 16 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
