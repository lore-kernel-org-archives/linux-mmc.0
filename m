From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/4] mmc: meson-gx: chained descriptor fixup and improvements
Date: Tue, 8 Jan 2019 23:00:13 +0100
Message-ID: <CAFBinCApEio05u+Us9XUK4UMpGi8bGa5j6psz21-3ry10PV6pg@mail.gmail.com>
References: <20181206151828.24417-1-jbrunet@baylibre.com> <CAFBinCCUO6ihxNWDup5ZVKWBc8+oiW_-j8OUxRhb+tjpGsUBkg@mail.gmail.com>
 <db2580c8740ca202d02f37ef567be0e273eca6d7.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <db2580c8740ca202d02f37ef567be0e273eca6d7.camel@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Jerome,

On Wed, Jan 2, 2019 at 1:46 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Sat, 2018-12-22 at 18:28 +0100, Martin Blumenstingl wrote:
> > Hi Jerome,
> >
> > On Thu, Dec 6, 2018 at 4:18 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > The goal of the patchset was mainly to address the following warning:
> > >
> > > WARNING: CPU: 0 PID: 0 at /usr/src/kernel/drivers/mmc/host/meson-gx-
> > > mmc.c:1025 meson_mmc_irq+0xc0/0x1e0
> > > Modules linked in: crc32_ce crct10dif_ce ipv6 overlay
> > > CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         4.19.1 #1
> > > Hardware name: Some A113 Board (DT)
> > > pstate: 40000085 (nZcv daIf -PAN -UAO)
> > > pc : meson_mmc_irq+0xc0/0x1e0
> > > lr : __handle_irq_event_percpu+0x70/0x180
> > > sp : ffff000008003980
> > > x29: ffff000008003980 x28: 0000000000000000
> > > [...]
> > > x1 : ffff80001a71bd40 x0 : 0000000000000000
> > > Call trace:
> > >  meson_mmc_irq+0xc0/0x1e0
> > >  __handle_irq_event_percpu+0x70/0x180
> > >  handle_irq_event_percpu+0x34/0x88
> > >  handle_irq_event+0x48/0x78
> > >  handle_fasteoi_irq+0xa0/0x180
> > >  generic_handle_irq+0x24/0x38
> > >  __handle_domain_irq+0x5c/0xb8
> > >  gic_handle_irq+0x58/0xa8
> > >
> > > This happens when using the chained descriptor mode. If there is an
> > > error, we call mmc_request_done(), loosing any reference to the cmd. It
> > > turns out that the chained descriptor does really stops when we do so, at
> > > least not completly. Most of the time, it can be seen with this harmless
> > > warning because the descriptor will raise another unexpected IRQ. On rare
> > > occasion, it will completly break the MMC.
> > >
> > > This is mostly adressed by patch #1.
> > > With this fixed, I took (yet) another look at the ultra-high speed modes
> > > and the tuning.
> > >
> > > I came up with new settings in patch 3 and 4. I've tested them on eMMC,
> > > sdcard and sdio on the following platforms:
> > >  * gxbb p200
> > >  * gxl p230, libretech (eMMC only), kvim.
> > >  * axg s400
> > >
> > > So far, these new settings seems to be working great but I think it
> > > would be nice if others could test this and provide their feedback.
> > > This why  patch 3 and 4 are RFT tagged.
> > >
> > > Jerome Brunet (4):
> > >   mmc: meson-gx: make sure the descriptor is stopped on errors
> > >   mmc: meson-gx: remove useless lock
> > >   mmc: meson-gx: align default phase on soc vendor tree
> > >   mmc: meson-gx: add signal resampling
> > I gave all four patches a go on my Khadas VIM2 Basic (16GB eMMC).
> > regardless of whether I have your patch applied or not: eMMC
> > sporadically fails tuning (if I reboot the board a few times it starts
> > to work)
> > [    4.172686] mmc1: tuning execution failed: -5
> > [    4.182535] mmc1: error -5 whilst initialising MMC card
>
> Damn ...
>
> This particular device is set to use hs400 ATM. Could you try with hs200 only
> ? (removing mmc-hs400-1_8v from meson-gxm-khadas-vim2.dts)
I put that on my TODO-list to re-try it
last year that "fixed" it for me, see [0]

> I might be wrong but I think tuning is supposed to be done with hs200, before
> activating DDR mode to switch to hs400. In theory, removing hs400 should not
> change anything (so I expect the tuning to still fail) but it is worth
> checking.
>
> >
> > I'm not sure if this issue is specific to my Khadas VIM2 so this is
> > *not* a nack for your patches.
>
> I'll check if I can get my hands on this device.
>
> When cooking this series, I tried another trick which was cycling on the
> resampling delays (see ADJUST_ADJ_DELAY_MASK). At the time, I could not see
> any significant improvement while doing it, so I dropped it.
>
> If possible. could you check if any particular value in this field, between 0
> and 5, makes things any better ?
>
> Alternatively, if you find another combination of phase for the mmc_clk and
> tx_clk that works better for this device, feel free to let me know. Maybe we
> can work something out.
I booted whatever Android / Linux is on the eMMC of my Khadas VIM2:
kvim2:/ $ dmesg | grep -i emmc
[    2.605927@2] aml_sd_emmc_probe: line 3608
[    2.609368@2] mmc driver version: 1.07, 2017-4-26: Support new emmc
host controller for version 3
[    2.618678@2] aml_sd_emmc_reg_init 1152
[    2.647411@2] get property:                  pinname, str:emmc
[    2.669798@2] emmc:pdata->caps = c0000d47
[    2.673712@2] emmc:pdata->caps2 = 18060
[    2.677509@2] emmc:pdata->pm_caps = 0
[    2.725316@2] [aml_sd_emmc_probe] aml_sd_emmc_probe() success!
[    2.725543@2] aml_sd_emmc_probe: line 3608
[    2.729971@2] aml_sd_emmc_reg_init 1152
[    2.845635@2] [aml_sd_emmc_probe] aml_sd_emmc_probe() success!
[    2.845871@2] aml_sd_emmc_probe: line 3608
[    2.850305@2] aml_sd_emmc_reg_init 1152
[    2.890367@0] emmc: BKOPS_EN bit is not set
[    2.896816@0] emmc: trying cali 0-th time(s)
[    2.903969@0] emmc: delay[0]= 1000 padding= 4, bidx=1
[    2.903971@0] emmc: delay[1]= 1000 padding= 4, bidx=1
[    2.903973@0] emmc: delay[2]=  750 padding= 1, bidx=0
[    2.903975@0] emmc: delay[3]= 1250 padding= 3, bidx=1
[    2.903977@0] emmc: delay[4]= 1250 padding= 3, bidx=1
[    2.903979@0] emmc: delay[5]= 1250 padding= 3, bidx=1
[    2.903981@0] emmc: delay[6]= 1000 padding= 4, bidx=1
[    2.903983@0] emmc: delay[7]= 1250 padding= 3, bidx=1
[    2.903985@0] emmc: calibration result @ 0: max(1250), min(750)
[    2.903988@0] emmc: line_delay =0x1000211, max_cal_result =1250
[    2.903990@0] emmc: base_index_max 1, base_index_min 0
[    2.903996@0] emmc: clk 100000000 SDR mode tuning start
[    2.904428@0] emmc: rx_tuning_result[1] = 10
[    2.904795@0] emmc: rx_tuning_result[2] = 10
[    2.905159@0] emmc: rx_tuning_result[3] = 10
[    2.905530@0] emmc: rx_tuning_result[4] = 10
[    2.905896@0] emmc: rx_tuning_result[5] = 10
[    2.906260@0] emmc: rx_tuning_result[6] = 10
[    2.906626@0] emmc: rx_tuning_result[7] = 10
[    2.906991@0] emmc: rx_tuning_result[8] = 10
[    2.907357@0] emmc: rx_tuning_result[9] = 10
[    2.907360@0] emmc: best_win_start =1, best_win_size =9
[    2.907362@0] emmc:
sd_emmc_regs->gclock=0x100024a,sd_emmc_regs->gadjust=0x52000
[    2.907365@0] emmc: gclock =0x100024a, gdelay=0x1000211, gadjust=0x52000
[    2.907506@0] emmc: support driver strength type 1
[    2.907575@0] emmc: try set sd/emmc to DDR mode
[    2.907579@0] emmc: try set sd/emmc to DDR mode
[    2.907710@0] emmc: new HS400 MMC card at address 0001
[    2.908238@1] emmc: clock 100000000, 8-bit-bus-width
[    2.908239@1] mmcblk0: emmc:0001 AJNB4R 14.5 GiB
[    2.908375@1] mmcblk0boot0: emmc:0001 AJNB4R partition 1 4.00 MiB
[    2.908504@1] mmcblk0boot1: emmc:0001 AJNB4R partition 2 4.00 MiB
[    2.908631@1] mmcblk0rpmb: emmc:0001 AJNB4R partition 3 4.00 MiB
[    2.909793@0] [aml_sd_emmc_irq] emmc: warning... response
crc,vstat:0xa1ff2400,virqc:3fff
[    2.909801@0] [aml_host_bus_fsm_show] emmc: err: wait for irq
service, bus_fsm:0x8
[    2.909801@0] [mmc_cmd_LBA_show] emmc: cmd 18, arg 0x12000,
operation is in [reserved] disk!
[    2.909819@6] aml_sd_emmc_data_thread 2642 emmc: cmd:18
[    2.909824@6] [aml_sd_emmc_data_thread] aml_sd_emmc_data_thread()
2658: set 1st retry!
[    2.909827@6] [aml_sd_emmc_data_thread] retry cmd 18 the 10-th time(s)
[    2.909829@6] [aml_sd_emmc_data_thread] cmd_delay change to 2
[    2.909840@0] [aml_sd_emmc_irq] emmc:
resp_timeout,vstat:0xa1ff2800,virqc:3fff
[    2.909858@6] aml_sd_emmc_data_thread : 2589
[    2.910078@1] add_emmc_partition
[    2.911868@0] emmc_key_init:527 emmc key lba_start:0x12020,lba_end:0x12220
[    2.911870@0] emmc key: emmc_key_init:552 ok.
[    2.916963@1] Exit aml_emmc_partition_ops OK.
[    2.919073@1] clear_emmc_wait_flag
[    3.355313@2] [aml_sd_emmc_probe] aml_sd_emmc_probe() success!
[    9.546113@4] emmc_key_read:428, read ok
[   19.016202@0] [aml_sd_emmc_irq] sdio:
resp_timeout,vstat:0xa3ff2800,virqc:3fff
[   19.028652@6] aml_sd_emmc_data_thread 2642 sdio: cmd:52
[   19.035022@0] [aml_sd_emmc_irq] sdio:
resp_timeout,vstat:0xa3ff2800,virqc:3fff
[   19.048492@6] aml_sd_emmc_data_thread 2642 sdio: cmd:52
[   19.058504@0] [aml_sd_emmc_irq] sdio:
resp_timeout,vstat:0xa3ff2800,virqc:3fff
[   19.068332@6] aml_sd_emmc_data_thread 2642 sdio: cmd:8
[   19.251397@1] sdio:
sd_emmc_regs->gclock=0x1000245,sd_emmc_regs->gadjust=0x32000
[   20.509105@4] sdio:
sd_emmc_regs->gclock=0x1000245,sd_emmc_regs->gadjust=0x32000
[   21.970494@4] sdio:
sd_emmc_regs->gclock=0x1000245,sd_emmc_regs->gadjust=0x32000

the register values of the clock, delay and adjust registers are
printed by Amlogic's 3.14 kernel - in case that helps you


Regards
Martin


[0] http://lists.infradead.org/pipermail/linux-amlogic/2018-January/006251.html
