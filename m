From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: Provide tracepoints for request processing
Date: Wed, 30 Mar 2016 11:25:55 +0200
Message-ID: <CAPDyKFq3p37rwKHD_YwV_i0T+bAA1iiDBkm63e5McVBkO0a+3A@mail.gmail.com>
References: <45a62181170848cbd00c8e863f7c84772f2a8a5c.1459147046.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <45a62181170848cbd00c8e863f7c84772f2a8a5c.1459147046.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: rostedt@goodmis.org, mingo@redhat.com, Adrian Hunter <adrian.hunter@intel.com>, Yangbo Lu <yangbo.lu@freescale.com>, Andrew Morton <akpm@linux-foundation.org>, "JBottomley@Odin.com" <JBottomley@odin.com>, "Luca Porzio (lporzio)" <lporzio@micron.com>, Jon Hunter <jonathanh@nvidia.com>, Grant Grundler <grundler@chromium.org>, Jens Axboe <axboe@fb.com>, Fabian Frederick <fabf@skynet.be>, Yunpeng Gao <yunpeng.gao@intel.com>, Dan Williams <dan.j.williams@intel.com>, Rabin Vincent <rabin.vincent@axis.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Doug Anderson <dianders@chromium.org>, David Jander <david@protonic.nl>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kern>
List-Id: linux-mmc@vger.kernel.org

On 28 March 2016 at 08:39, Baolin Wang <baolin.wang@linaro.org> wrote:
> This patch provides some tracepoints for the lifecycle of a mmc request from
> starting to completion to help with performance analysis of MMC subsystem.
>
> Changes since v2:
>  - Remove some redundant tracepoints which are repeated in block layer.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/mmc/core/core.c    |    7 +++
>  include/trace/events/mmc.h |  129 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 136 insertions(+)
>  create mode 100644 include/trace/events/mmc.h
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index f95d41f..7222e3f 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -36,6 +36,9 @@
>  #include <linux/mmc/sd.h>
>  #include <linux/mmc/slot-gpio.h>
>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/mmc.h>
> +
>  #include "core.h"
>  #include "bus.h"
>  #include "host.h"
> @@ -152,6 +155,8 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>
>                 led_trigger_event(host->led, LED_OFF);
>
> +               trace_mmc_request_done(host, mrq);
> +

At this point we will lack information about "retries" and also about
the re-tune state. I think both would be valuable information to share
about each request.

So, I would suggest you to move the trace a bit further up, before the
if-sentence and include "retries" and the "re-tune state" via trace
print.

>                 if (mrq->sbc) {
>                         pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
>                                 mmc_hostname(host), mrq->sbc->opcode,
> @@ -229,6 +234,8 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>         if (mmc_card_removed(host->card))
>                 return -ENOMEDIUM;
>
> +       trace_mmc_request_start(host, mrq);

This isn't the only place a request will be started from, thus we may
be missing valuable information about which command/request is being
sent.

I would move this to __mmc_start_request() instead and similar to my
upper comment, please add "retries" and "re-tune state" in the trace
print.

> +
>         if (mrq->sbc) {
>                 pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
>                          mmc_hostname(host), mrq->sbc->opcode,
>

[...]

Kind regards
Uffe
