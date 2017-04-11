From: Doug Anderson <dianders@google.com>
Subject: Re: [REGRESSION 4.10] dw_mmc: failures on Rockchip rk3288 veyron boards
Date: Tue, 11 Apr 2017 15:57:54 -0700
Message-ID: <CAD=FV=WTEjuiwVzsSUVg03WgGQ6mO8Yy4NOTJXyYZHV3P9QV5w@mail.gmail.com>
References: <20170330011709.GA110687@google.com> <CAD=FV=WWt=20WUT8jhZ3fBPiQq9UM-bEuFSXuuNu_7d3ONLdLQ@mail.gmail.com>
 <CAPDyKFrMm8fw_-CodDL5KfD131_4w1NTTfKs6pzVV3_EoMufhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:34838 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752428AbdDKW55 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Apr 2017 18:57:57 -0400
Received: by mail-wr0-f178.google.com with SMTP id o21so6820076wrb.2
        for <linux-mmc@vger.kernel.org>; Tue, 11 Apr 2017 15:57:56 -0700 (PDT)
In-Reply-To: <CAPDyKFrMm8fw_-CodDL5KfD131_4w1NTTfKs6pzVV3_EoMufhw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Brian Norris <briannorris@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Heiko Stuebner <heiko@sntech.de>, Alexandru M Stan <amstan@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, kevin@archlinuxarm.org

Hi,

On Tue, Apr 11, 2017 at 3:21 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>
>>> Issue #2 - Wifi (via SDIO, mmc1) is completely dead:
>>>
>>> [    1.444125] mmc_host mmc1: card is non-removable.
>>> [    1.471368] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
>>> [    1.619553] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>>> [    1.881699] mmc1: new ultra high speed SDR104 SDIO card at address 0001
>>> [   25.681172] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>>> [   25.691666] mwifiex: rx work enabled, cpus 4
>>> [   26.827000] mwifiex_sdio mmc1:0001:1: info: FW download over, size 800344 bytes
>>> [   27.561352] mwifiex_sdio mmc1:0001:1: WLAN FW is active
>>> [   33.585165] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>>> [   37.651344] mwifiex_sdio mmc1:0001:1: mwifiex_cmd_timeout_func: Timeout cmd id = 0xa9, act = 0x0
>>> [   37.660122] mwifiex_sdio mmc1:0001:1: num_data_h2c_failure = 0
>>> [   37.665951] mwifiex_sdio mmc1:0001:1: num_cmd_h2c_failure = 0
>>> [   37.671688] mwifiex_sdio mmc1:0001:1: is_cmd_timedout = 1
>>> [   37.677076] mwifiex_sdio mmc1:0001:1: num_tx_timeout = 0
>>> [   37.682380] mwifiex_sdio mmc1:0001:1: last_cmd_index = 1
>>> [   37.687681] mwifiex_sdio mmc1:0001:1: last_cmd_id: 00 00 a9 00 00 00 00 00 00 00
>>> [   37.695066] mwifiex_sdio mmc1:0001:1: last_cmd_act: 00 00 00 00 00 00 00 00 00 00
>>> [   37.702536] mwifiex_sdio mmc1:0001:1: last_cmd_resp_index = 0
>>> [   37.708269] mwifiex_sdio mmc1:0001:1: last_cmd_resp_id: 00 00 00 00 00 00 00 00 00 00
>>> [   37.716087] mwifiex_sdio mmc1:0001:1: last_event_index = 0
>>> [   37.721564] mwifiex_sdio mmc1:0001:1: last_event: 00 00 00 00 00 00 00 00 00 00
>>> [   37.728857] mwifiex_sdio mmc1:0001:1: data_sent=1 cmd_sent=0
>>> [   37.734508] mwifiex_sdio mmc1:0001:1: ps_mode=0 ps_state=0
>>> [   37.740016] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>>> [   37.750268] mwifiex_sdio mmc1:0001:1: info: mwifiex_fw_dpc: unregister device
>>
>> This doesn't surprise me at all.  What surprises me, though, is that
>> nobody else seems to be able to reproduce this.
>
> Me too.
>
> As I have stated several times, the PM code for SDIO is fragile/broken
> for many scenarios. This is just one case.
>
>>
>> On veyron, WiFi is connected via SDIO.  For good speed, it uses SDIO
>> Interrupts.  See this bit in the device tree:
>>
>>   cap-sdio-irq;
>>
>> SDIO interrupts (in 4-bit mode) specifically need the card clock to be
>> running all the time to work.  I can reproduce your regression (on
>> veryron-jerry, which also has Marvell WiFi) and I can also find that
>> the regression is "gone' if I take out the "cap-sdio-irq" in the
>> veyron device tree.  Ah, interestingly enough, turning off SDIO
>> interrupts has the side effect of sending enough (polling) traffic
>> that we never seem to runtime suspend, either.  ;-P
>
> We did a similar fix for sdhci recently. Simply, in cases when sdio
> IRQ is turned on, we call pm_runtime_get_noresume() to prevent the
> device from being runtime suspended.

I tried a similar mechanism for dw_mmc and it mostly worked.  Until I
stressed it out.  I stressed it out by running:

while true; do
  ifconfig mlan0 up;
  ifconfig mlan0 down;
done

When I did this long enough, I somehow managed to get into a state
where the card allowed itself to temporarily be runtime suspended.
This caused communication errors and eventually the mwifiex driver did
a full reset of itself.  I found that when communication errors were
happening that I was runtime suspended.

For whatever reason this was easiest to reproduce when I added a
printk to a serial console in the enable_sdio_irq() callback, but I
could also reproduce by setting the autosuspend_delay_ms to 1 and
using pm_runtime_put() instead of pm_runtime_put_noidle() in my patch.


It looks like on dw_mmc enable_sdio_irq(0) enable_sdio_irq(1) is
called almost constantly.  Without having boards with SDHCI and SDIO
to test with, it appears that this is different than how things work
with SDHCI.  For dw_mmc enable/disable is called in sdio_irq_thread()
to mask new interrupts while processing the current one.  SDHCI
doesn't use sdio_irq_thread() because it sets
MMC_CAP2_SDIO_IRQ_NOTHREAD.

Because of this constant stream of disable / enable calls we spend
some amount of time with Runtime PM enabled.  If we happen to have
enough delays (or printks) and we happen to get lucky then we can end
up running the PM Runtime suspend code for dw_mmc.  This is bad
because dw_mci_runtime_resume() fully resets the host controller and
clears all interrupts.  That doesn't seem so great, but I believe the
specific problem is that we might be clearing the next SDIO interrupt
which might have already come in (I haven't proven this).

Overall we really just don't want any Runtime PM at all when SDIO
Interrupts are being used.  There's currently no callback into dw_mmc
that gets called when someone holds a SDIO IRQ.  I suppose we could
add one from sdio_claim_irq() / sdio_release_irq() if that was
desired...


We could also (in theory) get the core SDIO code to get / put Runtime
PM whenever it's currently processing an interrupt.  I coded this up
and I can post it if you want, but it feels a bit complicated.


Instead I'm thinking of using the same solution I came up with for
DW_MMC_CARD_NO_LOW_PWR in dw_mmc: putting this in dw_mci_init_card().
It's not 100% perfect if there are use cases where the SDIO interrupt
is really disabled for long periods of times (and we want to save
power) but seems like a good stopgap and eliminates this particular
regression quickly.

OK, I've posted that now.  https://patchwork.kernel.org/patch/9676197/

Whew, that took a lot longer to dig into than I originally thought it
would.  :-P


>> In general I'd question whether dw_mmc actually gets much power
>> benefit from Runtime PM in Linux.  The dw_mmc IP blocks already have a
>> feature in them to automatically stop and restart the card clock.  See
>> SDMMC_CLKEN_LOW_PWR.  Maybe you're getting the benefit of turning off
>> VMMC or VQMMC?  Is that really a lot of power?  Presumably those power
>> savings would be for eMMC or normal SD cards (not SDIO).
>
> I think that depends on the PM topology of the SoC. Perhaps the dw_mmc
> devices are in PM domains sharing power rails etc, and preventing
> runtime PM could be very costly as it then prevent those shared
> resources to be put into low power state.

Ah, good point.  I hadn't thought about the shared power domain case.



-Doug
