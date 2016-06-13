From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: add auto bkops support
Date: Mon, 13 Jun 2016 09:29:00 +0300
Message-ID: <575E52AC.6000902@intel.com>
References: <1465182439-27963-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465182439-27963-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Alex Lemberg <alex.lemberg@sandisk.com>
List-Id: linux-mmc@vger.kernel.org

On 06/06/16 06:07, Shawn Lin wrote:
> JEDEC eMMC v5.1 introduce an autonomously initiated method
> for background operations.
> 
> Host that wants to enable the device to perform background
> operations during device idle time, should signal the device
> by setting AUTO_EN in BKOPS_EN field EXT_CSD[163] to 1b. When
> this bit is set, the device may start or stop background operations
> whenever it sees fit, without any notification to the host.
> 
> When AUTO_EN bit is set, the host should keep the device power
> active. The host may set or clear this bit at any time based on
> its power constraints or other considerations.
> 
> Currently the manual bkops is only be used under the async req
> circumstances and it's a bit complicated to be controlled as the
> perfect method is that we should do some idle monitor just as rpm
> and send HPI each time if receiving rd/wr req. But it will impact
> performance significantly, especially for random iops since the
> weight of executing HPI against r/w small piece of LBAs is
> nonnegligible.
> 
> So we now prefer to select the auto one unconditionally if supported
> which makes it as simple as possible. It should really good enough
> for devices to manage its internal policy for bkops rather than the
> host, which makes us believe that we could achieve the best
> performance for all the devices implementing auto bkops and the only
> thing we should do is to disable it when cutting off the power.

Do you know if there is really a requirement to do that? Because then, what
is the point of power off notification? And why is AUTO_EN persistent across
power failure?
