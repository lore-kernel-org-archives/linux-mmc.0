From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [REGRESSION 4.10] dw_mmc: failures on Rockchip rk3288 veyron
 boards
Date: Wed, 12 Apr 2017 08:54:07 +0800
Message-ID: <23842930-ece6-8879-daa5-c2220cfbf09f@rock-chips.com>
References: <20170330011709.GA110687@google.com>
 <CAD=FV=WWt=20WUT8jhZ3fBPiQq9UM-bEuFSXuuNu_7d3ONLdLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:44901 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbdDLAyS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Apr 2017 20:54:18 -0400
In-Reply-To: <CAD=FV=WWt=20WUT8jhZ3fBPiQq9UM-bEuFSXuuNu_7d3ONLdLQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: Brian Norris <briannorris@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Heiko Stuebner <heiko@sntech.de>, Alexandru M Stan <amstan@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, kevin@archlinuxarm.org

Hi Doug,

在 2017/4/11 7:35, Doug Anderson 写道:
> Hi,
>
> On Wed, Mar 29, 2017 at 6:17 PM, Brian Norris <briannorris@chromium.org> wrote:
>> Hi all,
>>
>> I haven't managed to get as far as a bugfix for this, but I've bisected
>> some issues seen on v4.10+ with a Chromebook of the Veyron family (Jaq,
>> in particular). v4.9 works fine.
>
> OK, I finally got everything up and running to test this too...
>
>
>> Issue #1 - eMMC complains periodically:
>>
>> [    4.358135] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>> [    4.461466] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>> [    5.291450] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>> [    5.381471] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>> [   11.243337] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>> [   17.371628] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>
> I don't believe that this is an error, actually.  Really we just need
> to quiet this message or (since I've always found it useful) move it
> to a different place.  I believe that with runtime PM we're
> effectively turning the clock off whenever the MMC device isn't in
> use.  On dw_mmc we have a "helpful" printout every time the clock is
> changed, and that's what you're seeing here.
>
> You can see with:
>
> while true; do
>   dd if=/dev/mmcblk2 of=/dev/null bs=512 count=1 iflag=direct;
>   sleep .1;
> done
>
> ...that you'll get a printout every 100ms.
>
>
> Ah, looks like this is in:
>
> ce69e2fea093 mmc: dw_mmc: silent verbose log when calling from PM context
>
> ...as pointed out by Shawn Lin.  So I think in 4.10 we can just ignore
> those messages and they're good on 4.11.
>
>
>> and if I stress it out at all (e.g., dd if=/dev/mmcblk2 bs=1M >
>> /dev/null), it will eventually croak:
>>
>> [  359.916315] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>> [  360.071378] dwmmc_rockchip ff0f0000.dwmmc: Successfully tuned phase to 153
>> [  360.211351] mmcblk2: error -110 transferring data, sector 8644608, nr 2048, cmd response 0x900, card status 0x0
>> [  360.221936] mmcblk2: retrying using single block read
>> [  363.491362] mmcblk2: error -110 transferring data, sector 8646656, nr 2048, cmd response 0x900, card status 0x0
>> [  363.531569] mmc_host mmc2: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
>> [  363.596326] mmc_host mmc2: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
>> [  363.612712] dwmmc_rockchip ff0f0000.dwmmc: Successfully tuned phase to 152
>> [  363.751351] mmcblk2: error -110 transferring data, sector 8646656, nr 2048, cmd response 0x900, card status 0x0
>> [  363.761938] mmcblk2: retrying using single block read
>> [  366.611356] INFO: task mmcqd/2boot1:92 blocked for more than 120 seconds.
>> [  366.618134]       Not tainted 4.10.0 #284
>> [  366.622146] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  366.629960] mmcqd/2boot1    D    0    92      2 0x00000000
>> [  366.635454] [<c07dc21c>] (__schedule) from [<c07dc4e0>] (schedule+0x90/0xa0)
>> [  366.642497] [<c07dc4e0>] (schedule) from [<c066e8b4>] (__mmc_claim_host+0xd4/0x19c)
>> [  366.650142] [<c066e8b4>] (__mmc_claim_host) from [<c066e9ac>] (mmc_get_card+0x30/0x34)
>> [  366.658056] [<c066e9ac>] (mmc_get_card) from [<c067fc8c>] (mmc_blk_issue_rq+0x64/0x48c)
>> [  366.666052] [<c067fc8c>] (mmc_blk_issue_rq) from [<c0680230>] (mmc_queue_thread+0x114/0x1b4)
>> [  366.674484] [<c0680230>] (mmc_queue_thread) from [<c023d1b0>] (kthread+0x128/0x144)
>> [  366.682134] [<c023d1b0>] (kthread) from [<c02076e8>] (ret_from_fork+0x14/0x2c)
>
> I'm not convinced this is a regression.
>
> I remember Heiko saying that he's heard reports that on some boards
> eMMC doesn't work with high speed, and I'be believe that's what you're
> seeing here.  It would be interesting to try to debug this.  I can't
> personally reproduce, though.
>
> I think veyron_minnie already has UHS turned off for eMMC upstream.  I
> guess we could do it for other veyron boards too until someone can
> debug?
>
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
>
> On veyron, WiFi is connected via SDIO.  For good speed, it uses SDIO
> Interrupts.  See this bit in the device tree:
>
>   cap-sdio-irq;
>

all of *my* boards are using side-band interrupt, so there are no
"cap-sdio-irq".

> SDIO interrupts (in 4-bit mode) specifically need the card clock to be
> running all the time to work.  I can reproduce your regression (on
> veryron-jerry, which also has Marvell WiFi) and I can also find that
> the regression is "gone' if I take out the "cap-sdio-irq" in the
> veyron device tree.  Ah, interestingly enough, turning off SDIO
> interrupts has the side effect of sending enough (polling) traffic
> that we never seem to runtime suspend, either.  ;-P
>
> In general I'd question whether dw_mmc actually gets much power
> benefit from Runtime PM in Linux.  The dw_mmc IP blocks already have a
> feature in them to automatically stop and restart the card clock.  See
> SDMMC_CLKEN_LOW_PWR.  Maybe you're getting the benefit of turning off
> VMMC or VQMMC?  Is that really a lot of power?  Presumably those power
> savings would be for eMMC or normal SD cards (not SDIO).
>
> Maybe someone else on this thread knows how Runtime PM is supposed to
> work in general for SDIO?  I notice that in sdio.c the
> mmc_sdio_runtime_suspend() unconditionally calls mmc_power_off().
> That seems odd since the main mmc_sdio_suspend() _doesn't_ call it if
> mmc_card_keep_power().  Hrmmm...
>
> OK, so I just tried this on veyron-minnie.  On minnie we have Broadcom
> WiFi.  That actually works (!).  Presumably this is because
> brcmf_sdiod_host_fixup() calls pm_runtime_forbid().  Commenting that
> out breaks things.
>
> OK, and I can make Marvell work by adding
> "pm_runtime_forbid(func->card->host->parent);" to the end of
> mwifiex_sdio_probe().
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
>
> B) Technically we could hack this in the dw_mmc code to disable
> Runtime PM if we see that an SDIO interrupt is used.  One advantage of
> doing it here is that if we ever add support in dw_mmc for the
> external SDIO interrupt we could allow Runtime PM in that case.  In
> theory the dw_mmc IP block has some basic support for a dedicated SDIO
> interrupt pin, but there's no code to support it.
>
> C) Technically we could add this into the MMC core.
>
> D) Technically we could remove Runtime PM support from dw_mmc for now
> until someone can address all these issues (and ideally show a real
> power savings).
>
>
> I'd tend to vote for D, but I've been pretty absent from dw_mmc for a
> long time, so probably my vote isn't worth that much...
>
> Shawn: I think you actually enabled runtime PM.  Did you really see
> power savings, or did it just seem like enabling Runtime PM would be a
> neat thing to do?

As Ulf pointed out that the genpd for mmc IP on Rockchip platforms were
shared with others, so it's worth to add runtime PM.


>
>
> -Doug
>
>
>

