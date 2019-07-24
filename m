From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH v2 2/2] mwifiex: Make use of the new sdio_trigger_replug()
 API to reset
Date: Wed, 24 Jul 2019 11:35:08 +0000 (UTC)
Message-ID: <20190724113508.CD35360388@smtp.codeaurora.org>
References: <20190722193939.125578-3-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722193939.125578-3-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Ganapathi Bhat <gbhat@marvell.com>, linux-wireless@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>, Brian Norris <briannorris@chromium.org>, Amitkumar Karwar <amitkarwar@gmail.com>, linux-rockchip@lists.infradead.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Nishant Sarmukadam <nishants@marvell.com>, netdev@vger.kernel.org, Avri Altman <avri.altman@wdc.com>, linux-mmc@vger.kernel.org, davem@davemloft.net, Xinming Hu <huxinming820@gmail.com>, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Douglas Anderson <dianders@chromium.org> wrote:

> As described in the patch ("mmc: core: Add sdio_trigger_replug()
> API"), the current mwifiex_sdio_card_reset() is broken in the cases
> where we're running Bluetooth on a second SDIO func on the same card
> as WiFi.  The problem goes away if we just use the
> sdio_trigger_replug() API call.
> 
> NOTE: Even though with this new solution there is less of a reason to
> do our work from a workqueue (the unplug / plug mechanism we're using
> is possible for a human to perform at any time so the stack is
> supposed to handle it without it needing to be called from a special
> context), we still need a workqueue because the Marvell reset function
> could called from a context where sleeping is invalid and thus we
> can't claim the host.  One example is Marvell's wakeup_timer_fn().
> 
> Cc: Andreas Fenkart <afenkart@gmail.com>
> Cc: Brian Norris <briannorris@chromium.org>
> Fixes: b4336a282db8 ("mwifiex: sdio: reset adapter using mmc_hw_reset")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

I assume this is going via some other tree so I'm dropping this from my
queue. If I should apply this please resend once the dependency is in
wireless-drivers-next.

Patch set to Not Applicable.

-- 
https://patchwork.kernel.org/patch/11053351/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
