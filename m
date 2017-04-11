From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [REGRESSION 4.10] dw_mmc: failures on Rockchip rk3288 veyron boards
Date: Tue, 11 Apr 2017 12:21:14 +0200
Message-ID: <CAPDyKFrMm8fw_-CodDL5KfD131_4w1NTTfKs6pzVV3_EoMufhw@mail.gmail.com>
References: <20170330011709.GA110687@google.com> <CAD=FV=WWt=20WUT8jhZ3fBPiQq9UM-bEuFSXuuNu_7d3ONLdLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:36122 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbdDKKVQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Apr 2017 06:21:16 -0400
Received: by mail-vk0-f45.google.com with SMTP id s68so109269725vke.3
        for <linux-mmc@vger.kernel.org>; Tue, 11 Apr 2017 03:21:15 -0700 (PDT)
In-Reply-To: <CAD=FV=WWt=20WUT8jhZ3fBPiQq9UM-bEuFSXuuNu_7d3ONLdLQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: Brian Norris <briannorris@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Heiko Stuebner <heiko@sntech.de>, Alexandru M Stan <amstan@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, kevin@archlinuxarm.org

[...]

>
>> Issue #2 - Wifi (via SDIO, mmc1) is completely dead:
>>
>> [    1.444125] mmc_host mmc1: card is non-removable.
>> [    1.471368] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
>> [    1.619553] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>> [    1.881699] mmc1: new ultra high speed SDR104 SDIO card at address 0001
>> [   25.681172] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>> [   25.691666] mwifiex: rx work enabled, cpus 4
>> [   26.827000] mwifiex_sdio mmc1:0001:1: info: FW download over, size 800344 bytes
>> [   27.561352] mwifiex_sdio mmc1:0001:1: WLAN FW is active
>> [   33.585165] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>> [   37.651344] mwifiex_sdio mmc1:0001:1: mwifiex_cmd_timeout_func: Timeout cmd id = 0xa9, act = 0x0
>> [   37.660122] mwifiex_sdio mmc1:0001:1: num_data_h2c_failure = 0
>> [   37.665951] mwifiex_sdio mmc1:0001:1: num_cmd_h2c_failure = 0
>> [   37.671688] mwifiex_sdio mmc1:0001:1: is_cmd_timedout = 1
>> [   37.677076] mwifiex_sdio mmc1:0001:1: num_tx_timeout = 0
>> [   37.682380] mwifiex_sdio mmc1:0001:1: last_cmd_index = 1
>> [   37.687681] mwifiex_sdio mmc1:0001:1: last_cmd_id: 00 00 a9 00 00 00 00 00 00 00
>> [   37.695066] mwifiex_sdio mmc1:0001:1: last_cmd_act: 00 00 00 00 00 00 00 00 00 00
>> [   37.702536] mwifiex_sdio mmc1:0001:1: last_cmd_resp_index = 0
>> [   37.708269] mwifiex_sdio mmc1:0001:1: last_cmd_resp_id: 00 00 00 00 00 00 00 00 00 00
>> [   37.716087] mwifiex_sdio mmc1:0001:1: last_event_index = 0
>> [   37.721564] mwifiex_sdio mmc1:0001:1: last_event: 00 00 00 00 00 00 00 00 00 00
>> [   37.728857] mwifiex_sdio mmc1:0001:1: data_sent=1 cmd_sent=0
>> [   37.734508] mwifiex_sdio mmc1:0001:1: ps_mode=0 ps_state=0
>> [   37.740016] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>> [   37.750268] mwifiex_sdio mmc1:0001:1: info: mwifiex_fw_dpc: unregister device
>
> This doesn't surprise me at all.  What surprises me, though, is that
> nobody else seems to be able to reproduce this.

Me too.

As I have stated several times, the PM code for SDIO is fragile/broken
for many scenarios. This is just one case.

>
> On veyron, WiFi is connected via SDIO.  For good speed, it uses SDIO
> Interrupts.  See this bit in the device tree:
>
>   cap-sdio-irq;
>
> SDIO interrupts (in 4-bit mode) specifically need the card clock to be
> running all the time to work.  I can reproduce your regression (on
> veryron-jerry, which also has Marvell WiFi) and I can also find that
> the regression is "gone' if I take out the "cap-sdio-irq" in the
> veyron device tree.  Ah, interestingly enough, turning off SDIO
> interrupts has the side effect of sending enough (polling) traffic
> that we never seem to runtime suspend, either.  ;-P

We did a similar fix for sdhci recently. Simply, in cases when sdio
IRQ is turned on, we call pm_runtime_get_noresume() to prevent the
device from being runtime suspended.

Unless the SoC supports the SDIO irq to be re-routed to a wakeup IRQ
at runtime suspend, there is no other solution. However, re-routing to
a wakeup IRQ should be done, when switching to 1-bit mode is
completed. This is currently not supported by the mmc core.

>
> In general I'd question whether dw_mmc actually gets much power
> benefit from Runtime PM in Linux.  The dw_mmc IP blocks already have a
> feature in them to automatically stop and restart the card clock.  See
> SDMMC_CLKEN_LOW_PWR.  Maybe you're getting the benefit of turning off
> VMMC or VQMMC?  Is that really a lot of power?  Presumably those power
> savings would be for eMMC or normal SD cards (not SDIO).

I think that depends on the PM topology of the SoC. Perhaps the dw_mmc
devices are in PM domains sharing power rails etc, and preventing
runtime PM could be very costly as it then prevent those shared
resources to be put into low power state.

I think the best we can do at this point is something similar as we do
for sdhci.

>
> Maybe someone else on this thread knows how Runtime PM is supposed to
> work in general for SDIO?  I notice that in sdio.c the
> mmc_sdio_runtime_suspend() unconditionally calls mmc_power_off().
> That seems odd since the main mmc_sdio_suspend() _doesn't_ call it if
> mmc_card_keep_power().  Hrmmm...

As stated above, the system PM and runtime PM code for SDIO is fragile
and needs an update. I know how to do it, but it requires some work. I
have started to hack on it several times, maybe I just need to put
everything else aside and focus on this. :-)

Moreover, I would really like to invent the feature being able to
defer system PM resume of the SDIO card (in cases when it means a full
re-init of the SDIO card) to runtime PM resume instead. Why? It would
saves several hundreds of milliseconds in system PM resume time. The
very similar feature as we already have for SD/(e)MMC.

>
> OK, so I just tried this on veyron-minnie.  On minnie we have Broadcom
> WiFi.  That actually works (!).  Presumably this is because
> brcmf_sdiod_host_fixup() calls pm_runtime_forbid().  Commenting that
> out breaks things.

I think this should be managed in the dw_mmc driver instead, as it is
there the problem lies.

>
> OK, and I can make Marvell work by adding
> "pm_runtime_forbid(func->card->host->parent);" to the end of
> mwifiex_sdio_probe().

Again, dw_mmc is the correct place.

>
> --
>
> So where does that leave us?
>
> A) Technically we can fix Marvell's driver to work like Broadcom's.
> One could possibly assert that this is the wrong fix because
> technically we could make Runtime PM work with SDIO with enough work.
> We could theoretically move into 1-bit mode and there (I think) you
> can get interrupts with the clock off.  ...or we could have a
> dedicated SDIO Interrupt pin (for the embedded case), which is talked
> about in the SDIO spec.

If the WIFI chip supports an external SDIO irq pin, that is very much
preferred. Both from PM point of view, but actually also from
performance point of view (mainly because it's faster to ack the IRQ).

That said, for these scenarios, I assume the switching to 1-bit mode
isn't necessary before gating the clock, as the IRQ is driven
completely separately from the SDIO bus. From my own experience, this
is how cw1200 WIFI chip behaves on ux500.

>
> B) Technically we could hack this in the dw_mmc code to disable
> Runtime PM if we see that an SDIO interrupt is used.  One advantage of
> doing it here is that if we ever add support in dw_mmc for the
> external SDIO interrupt we could allow Runtime PM in that case.  In
> theory the dw_mmc IP block has some basic support for a dedicated SDIO
> interrupt pin, but there's no code to support it.

Right.

>
> C) Technically we could add this into the MMC core.

Perhaps the MMC core needs to play a role, not sure exactly how yet.

>
> D) Technically we could remove Runtime PM support from dw_mmc for now
> until someone can address all these issues (and ideally show a real
> power savings).

No. Then it's better to just prevent runtime suspend when SDIO irq
becomes enabled.

>
>
> I'd tend to vote for D, but I've been pretty absent from dw_mmc for a
> long time, so probably my vote isn't worth that much...
>
> Shawn: I think you actually enabled runtime PM.  Did you really see
> power savings, or did it just seem like enabling Runtime PM would be a
> neat thing to do?
>
>
> -Doug

Dough, really appreciate you efforts in testing this and the detailed
way you describes the problem.

Kind regards
Uffe
