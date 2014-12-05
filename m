From: Alexandru Stan <amstan@chromium.org>
Subject: Re: [PATCH v3] mmc: dw_mmc: add quirk for broken data transfer over scheme
Date: Fri, 5 Dec 2014 15:56:11 -0800
Message-ID: <CAHNYxRxga=HQDBaw5Tp84TwH9BVe9B286Eh4rtwVdd=QTaE=0A@mail.gmail.com>
References: <1415970338-2637-1-git-send-email-addy.ke@rock-chips.com>
 <1417576563-5033-1-git-send-email-addy.ke@rock-chips.com> <CAD=FV=Vfe_UUT=fTdQESEyrE56Jy4p9NtKh80PkR+C4mDCHDxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=Vfe_UUT=fTdQESEyrE56Jy4p9NtKh80PkR+C4mDCHDxA@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Addy Ke <addy.ke@rock-chips.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Dinh Nguyen <dinguyen@altera.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, Sonny Rao <sonnyrao@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, op
List-Id: linux-mmc@vger.kernel.org

Seems like the BROKEN_DTO also affects EVENT_DATA_COMPLETE, sometimes we don't
see that (but we do see EVENT_XFER_COMPLETE), leave the state machine and never
come back to it to timeout. I have this happening on emmc specifically, haven't
seen it on sdmmc yet.

The fix is to also start the timer when we don't see a EVENT_DATA_COMPLETE.

More details for how I debugged this can be found at:
https://chromium-review.googlesource.com/#/c/233691/

In ~100 reboot tests I haven't seen any hangs, whereas before it was
hanging about 20% of the time.

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 50865e7..c678206 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1685,8 +1685,17 @@ static void dw_mci_tasklet_func(unsigned long priv)

                case STATE_DATA_BUSY:
                        if (!test_and_clear_bit(EVENT_DATA_COMPLETE,
-                                               &host->pending_events))
+                                               &host->pending_events)) {
+                               if (host->quirks & DW_MCI_QUIRK_BROKEN_DTO) {
+                                       drto_clks = mci_readl(host, TMOUT) >> 8;
+                                       drto_ms = DIV_ROUND_UP(drto_clks * 1000,
+                                                              host->bus_hz);
+
+                                       mod_timer(&host->dto_timer, jiffies +
+                                               msecs_to_jiffies(drto_ms));
+                               }
                                break;
+                       }

                        host->data = NULL;
                        set_bit(EVENT_DATA_COMPLETE, &host->completed_events);
Alexandru Stan (amstan)


On Tue, Dec 2, 2014 at 9:08 PM, Doug Anderson <dianders@chromium.org> wrote:
> Addy,
>
> On Tue, Dec 2, 2014 at 7:16 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
>> This patch add a new quirk to add a s/w timer to notify the driver
>> to terminate current transfer and report a data timeout to the core,
>> if DTO interrupt does NOT come within the given time.
>>
>> dw_mmc call mmc_request_done func to finish transfer depends on
>> DTO interrupt. If DTO interrupt does not come in sending data state,
>> the current transfer will be blocked.
>>
>> But this case really exists, when driver reads tuning data from
>> card on RK3288-pink2 board. I measured waveforms by oscilloscope
>> and found that card clock was always on and data lines were always
>> holded high level in sending data state.
>>
>> We got the reply from synopsys:
>> There are two counters but both use the same value of [31:8] bits.
>> Data timeout counter doesn't wait for stop clock and you should get
>> DRTO even when the clock is not stopped.
>> Host Starvation timeout counter is triggered with stop clock condition.
>>
>> This means that host should get DRTO and DTO interrupt.
>>
>> But we really don't get any data-related interrupt in RK3X SoCs.
>> And driver can't get data transfer state, it can do nothing but wait for.
>>
>> We don't know why we have this problem, but we need it to fix this problem now.
>> And I will post a follow up change when we find the root cause.
>>
>> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
>> ---
>> Changes in v2:
>> - fix some typo.
>> - remove extra timeout value (250ms).
>> - remove dw_mci_dto_start_monitor func.
>> - use "broken-dto" for new quirk and change Subject for it.
>>
>> Changes in v3:
>> - Remove dts for broken-dto, just add this quirk in dw_mci_rockchip_init
>>
>>  drivers/mmc/host/dw_mmc-rockchip.c |  3 +++
>>  drivers/mmc/host/dw_mmc.c          | 41 +++++++++++++++++++++++++++++++++++++-
>>  include/linux/mmc/dw_mmc.h         |  5 +++++
>>  3 files changed, 48 insertions(+), 1 deletion(-)
>
> This seems reasonable to me.  I do hope that you can get to a root
> cause, but I don't think this is a terrible bit of code to carry.
> Obviously it's up to the folks who maintain dw_mmc and the mmc
> subsystem, but:
>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
