From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH 0/3] brcmfmac: sdio: Deal better w/ transmission errors
 waking from sleep
Date: Mon, 20 May 2019 10:55:12 +0200
Message-ID: <8c3fa57a-3843-947c-ec6b-a6144ccde1e9@broadcom.com>
References: <20190517225420.176893-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517225420.176893-1-dianders@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-rockchip@lists.infradead.org, Double Lo <double.lo@cypress.com>, briannorris@chromium.org, Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org, Wright Feng <wright.feng@cypress.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, brcm80211-dev-list@cypress.com, YueHaibing <yuehaibing@huawei.com>, Hante Meuleman <hante.meuleman@broadcom.com>, Martin Hicks <mort@bork.org>, Ritesh Harjani <riteshh@codeaurora.org>, Michael Trimarchi <michael@amarulasolutions.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Franky Lin <franky.lin@broadcom.com>, Jiong Wu <lohengrin1024@gmail.com>, brcm80211-dev-list.pdl@broadcom.com, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.orgli
List-Id: linux-mmc@vger.kernel.org

On 5/18/2019 12:54 AM, Douglas Anderson wrote:
> This series attempts to deal better with the expected transmission
> errors that we get when waking up the SDIO-based WiFi on
> rk3288-veyron-minnie, rk3288-veyron-speedy, and rk3288-veyron-mickey.
> 
> Some details about those errors can be found in
> <https://crbug.com/960222>, but to summarize it here: if we try to
> send the wakeup command to the WiFi card at the same time it has
> decided to wake up itself then it will behave badly on the SDIO bus.
> This can cause timeouts or CRC errors.
> 
> When I tested on 4.19 and 4.20 these CRC errors can be seen to cause
> re-tuning.  Since I am currently developing on 4.19 this was the
> original problem I attempted to solve.
> 
> On mainline it turns out that you don't see the retuning errors but
> you see tons of spam about timeouts trying to wakeup from sleep.  I
> tracked down the commit that was causing that and have partially
> reverted it here.  I have no real knowledge about Broadcom WiFi, but
> the commit that was causing problems sounds (from the descriptioin) to
> be a hack commit penalizing all Broadcom WiFi users because of a bug
> in a Cypress SD controller.  I will let others comment if this is
> truly the case and, if so, what the right solution should be.

Let me give a bit of background. The brcmfmac driver implements its own 
runtime-pm like functionality, ie. if the driver is idle for some time 
it will put the device in a low-power state. When it does that it powers 
down several cores in the chip among which the SDIO core. However, the 
SDIO bus used be very bad at handling devices that do that so instead it 
has the Always-On-Station (AOS) block take over the SDIO core in 
handling the bus. Default is will send a R1 response, but only for CMD52 
(and CMD14 but no host is using that cruft). In noCmdDecode it does not 
respond and simply wakes up the SDIO core, which takes over again. 
Because it does not respond timeouts (-110) are kinda expected in this mode.

Regards,
Arend
