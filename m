From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: Disable SDIO interrupts while suspended to
 fix suspend/resume
Date: Wed, 24 Apr 2019 08:57:26 +0800
Message-ID: <6e5c9395-51b0-7f28-ec91-de95cb54f58d@rock-chips.com>
References: <20190410221237.160856-1-dianders@chromium.org>
 <CAD=FV=Wm+T+W=LWTSiwBT3UQWG7YKQdGuL2+BmAFQhk8CYY1mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=Wm+T+W=LWTSiwBT3UQWG7YKQdGuL2+BmAFQhk8CYY1mQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com, Kalle Valo <kvalo@codeaurora.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Brian Norris <briannorris@chromium.org>, linux-wireless <linux-wireless@vger.kernel.org>, Matthias Kaehlcke <mka@chromium.org>, Ryan Case <ryandcase@chromium.org>, stable@vger.kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


On 2019/4/22 23:21, Doug Anderson wrote:
> Hi,
> 
> On Wed, Apr 10, 2019 at 3:13 PM Douglas Anderson <dianders@chromium.org> wrote:
>>
>> Processing SDIO interrupts while dw_mmc is suspended (or partly
>> suspended) seems like a bad idea.  We really don't want to be
>> processing them until we've gotten ourselves fully powered up.
>>
>> You might be wondering how it's even possible to become suspended when
>> an SDIO interrupt is active.  As can be seen in
>> dw_mci_enable_sdio_irq(), we explicitly keep dw_mmc out of runtime
>> suspend when the SDIO interrupt is enabled.  ...but even though we
>> stop normal runtime suspend transitions when SDIO interrupts are
>> enabled, the dw_mci_runtime_suspend() can still get called for a full
>> system suspend.
>>
>> Let's handle all this by explicitly masking SDIO interrupts in the
>> suspend call and unmasking them later in the resume call.  To do this
>> cleanly I'll keep track of whether the client requested that SDIO
>> interrupts be enabled so that we can reliably restore them regardless
>> of whether we're masking them for one reason or another.
>>
>> Without this fix it can be seen that rk3288-veyron Chromebooks with
>> Marvell WiFi would sometimes fail to resume WiFi even after picking my
>> recent mwifiex patch [1].  Specifically you'd see messages like this:
>>    mwifiex_sdio mmc1:0001:1: Firmware wakeup failed
>>    mwifiex_sdio mmc1:0001:1: PREP_CMD: FW in reset state
>>
>> ...and tracing through the resume code in the failing cases showed
>> that we were processing a SDIO interrupt really early in the resume
>> call.
>>
>> NOTE: downstream in Chrome OS 3.14 and 3.18 kernels (both of which
>> support the Marvell SDIO WiFi card) we had a patch ("CHROMIUM: sdio:
>> Defer SDIO interrupt handling until after resume") [2].  Presumably
>> this is the same problem that was solved by that patch.
>>
>> [1] https://lkml.kernel.org/r/20190404040106.40519-1-dianders@chromium.org
>> [2] https://crrev.com/c/230765
>>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>> I didn't put any "Fixes" tag here, but presumably this could be
>> backported to whichever kernels folks found it useful for.  I have at
>> least confirmed that kernels v4.14 and v4.19 (as well as v5.1-rc2)
>> show the problem.  It is very easy to pick this to v4.19 and it
>> definitely fixes the problem there.
>>
>> I haven't spent the time to pick this to 4.14 myself, but presumably
>> it wouldn't be too hard to backport this as far as v4.13 since that
>> contains commit 32dba73772f8 ("mmc: dw_mmc: Convert to use
>> MMC_CAP2_SDIO_IRQ_NOTHREAD for SDIO IRQs").  Prior to that it might
>> make sense for anyone experiencing this problem to just pick the old
>> CHROMIUM patch to fix them.
>>
>>   drivers/mmc/host/dw_mmc.c | 24 ++++++++++++++++++++----
>>   drivers/mmc/host/dw_mmc.h |  3 +++
>>   2 files changed, 23 insertions(+), 4 deletions(-)
> 
> Jaehoon / Shawn: any thoughts on this patch?

The intention seems reasonable to me, but just wonder if we need
mask/unmask SDIO interrupt when it's never used?  It's the same
situation for SDMMC_CLKEN_LOW_PWR that we couldn't stop providing
clock for SDIO cards, so I guess we need to check MMC_CAP_SDIO_IRQ
as well.

> 
> -Doug
> 
> 
> 
