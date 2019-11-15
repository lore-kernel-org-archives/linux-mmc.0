From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: arm64: dts: rockchip: Disable HS400 for mmc on rk3399-roc-pc
Date: Fri, 15 Nov 2019 12:19:13 +0100
Message-ID: <3460135.SDF8zhHPq4@diego>
References: <20190301153348.29870-1-christoph.muellner@theobroma-systems.com> <2766673.iMURPl8gB5@phil> <69472c06-8b21-c3d8-acad-1a0a292c0fa2@fivetechno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <69472c06-8b21-c3d8-acad-1a0a292c0fa2@fivetechno.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Reichl <m.reichl@fivetechno.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Tony Xie <tony.xie@rock-chips.com>, Viresh Kumar <viresh.kumar@linaro.org>, shawn.lin@rock-chips.com, Jeffy Chen <jeffy.chen@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-kernel@vger.kernel.org, Vicente Bergas <vicencb@gmail.com>, Douglas Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, Klaus Goger <klaus.goger@theobroma-systems.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Randy Li <ayaka@soulik.info>, Kishon Vijay Abraham I <kishon@ti.com>, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org, Chr
List-Id: linux-mmc@vger.kernel.org

Hi Markus,

Am Freitag, 15. November 2019, 11:37:58 CET schrieb Markus Reichl:
> Am 14.11.19 um 14:10 schrieb Heiko Stuebner:
> > $subject is missing the [PATCH] prefix
> will fix.

no need to resend just for this ... just to keep in mind for future patches ;-)


> > Am Montag, 11. November 2019, 10:51:04 CET schrieb Markus Reichl:
> >> Working with rootfs on two 128GB mmcs on rk3399-roc-pc.
> >> 
> >> One (mmc name 128G72, one screw hole) works fine in HS400 mode.
> >> Other (mmc name DJNB4R, firefly on pcb, two screw holes) gets lots of
> >> mmc1: "running CQE recovery", even hangs with damaged fs,
> >> when running under heavy load, e.g. compiling kernel.
> >> Both run fine with HS200.
> >> 
> >> Disabling CQ with patch mmc: core: Add MMC Command Queue Support kernel parameter [0] did not help.
> >> [0] https://gitlab.com/ayufan-repos/rock64/linux-mainline-kernel/commit/54e264154b87dfe32a8359b2726e2d5611adbaf3
> > 
> > I'm hoping for some input from other people in Cc but your mail headers
> > also referenced the drive-impendance series from Christoph [0], which
> > it seems we need to poke the phy maintainer again.
> > 
> > Did you check if changing the impedance helped (like the signal dampening
> > Philipp described in one of the replies there).
> 
> checked with
> 
> &emmc_phy {
> +       drive-impedance-ohm = <33>;
> 
> gives no improvement:

That is sad ... I guess we really should disable hs400 then ...
that may give others more incentive to dive deeper ;-)


Heiko


> [    1.688590] mmc1: CQHCI version 5.10
> [    1.714157] mmc1: SDHCI controller on fe330000.sdhci [fe330000.sdhci] using ADMA
> [    1.797822] mmc1: Command Queue Engine enabled
> [    1.798259] mmc1: new HS400 Enhanced strobe MMC card at address 0001
> [    1.800034] mmcblk1: mmc1:0001 DJNB4R 116 GiB 
> [    1.800643] mmcblk1boot0: mmc1:0001 DJNB4R partition 1 4.00 MiB
> [    1.801408] mmcblk1boot1: mmc1:0001 DJNB4R partition 2 4.00 MiB
> [    1.802886] mmcblk1rpmb: mmc1:0001 DJNB4R partition 3 4.00 MiB, chardev (246:0)
> ...
> [  100.118020] mmc1: running CQE recovery
> [  100.120890] ------------[ cut here ]------------
> [  100.121310] mmc1: cqhci: spurious TCN for tag 2
> [  100.121802] WARNING: CPU: 0 PID: 232 at drivers/mmc/host/cqhci.c:729 cqhci_irq+0x30c/0x480
> [  100.122530] Modules linked in: rfkill snd_soc_hdmi_codec dw_hdmi_i2s_audio dw_hdmi_cec rockchipdrm crct10dif_ce analogix_dp dw_mipi_dsi snd_soc_simple_card dw_hdmi cec snd_soc_rockchip_i2s snd_soc_simple_card_utils panfrost snd_soc_rockchip_pcm drm_kms_helper snd_soc_core gpu_sched snd_pcm_dmaengine syscopyarea sysfillrect sysimgblt snd_pcm fb_sys_fops snd_timer snd drm soundcore fusb302 tcpm typec rockchip_saradc drm_panel_orientation_quirks ipv6
> [  100.126097] CPU: 0 PID: 232 Comm: kworker/0:2H Not tainted 5.4.0-rc7-next-20191112-00007-g2ad177c77749 #44
> [  100.126946] Hardware name: Firefly ROC-RK3399-PC Board (DT)
> [  100.127454] Workqueue: kblockd blk_mq_run_work_fn
> [  100.127885] pstate: 20000085 (nzCv daIf -PAN -UAO)
> [  100.128318] pc : cqhci_irq+0x30c/0x480
> [  100.128660] lr : cqhci_irq+0x30c/0x480
> [  100.128997] sp : ffff800010003d10
> [  100.129298] x29: ffff800010003d10 x28: 0000000000000000 
> [  100.129777] x27: 0000000000000001 x26: ffff8000108e0fe8 
> [  100.130257] x25: ffff0000f5ae5c98 x24: ffff800010b7e1a8 
> [  100.130737] x23: ffff800010b198c8 x22: ffff0000f5a80000 
> [  100.131216] x21: 0000000000000002 x20: 0000000000000002 
> [  100.131694] x19: ffff0000f5ae5c80 x18: 0000000000000010 
> [  100.132173] x17: 0000000000000000 x16: 0000000000000000 
> [  100.132653] x15: ffffffffffffffff x14: ffff800010b198c8 
> [  100.133132] x13: ffff800090003a77 x12: ffff800010003a7f 
> [  100.133612] x11: ffff800010b30000 x10: ffff800010003a00 
> [  100.134092] x9 : 00000000ffffffd0 x8 : ffff80001045a060 
> [  100.134571] x7 : 000000000000025f x6 : ffff800010b979e2 
> [  100.135050] x5 : 0000000000000001 x4 : 0000000000000000 
> [  100.135529] x3 : 0000000000000000 x2 : 0000000000000000 
> [  100.136007] x1 : e005989da46f2500 x0 : 0000000000000000 
> [  100.136486] Call trace:
> [  100.136719]  cqhci_irq+0x30c/0x480
> [  100.137033]  sdhci_arasan_cqhci_irq+0x58/0x80
> [  100.137430]  sdhci_irq+0xb8/0xbb8
> [  100.137742]  __handle_irq_event_percpu+0x6c/0x170
> [  100.138169]  handle_irq_event_percpu+0x34/0x88
> [  100.138575]  handle_irq_event+0x44/0xc8
> [  100.138927]  handle_fasteoi_irq+0xb4/0x160
> [  100.139302]  generic_handle_irq+0x24/0x38
> [  100.139670]  __handle_domain_irq+0x60/0xb8
> [  100.140045]  gic_handle_irq+0xc0/0x158
> [  100.140389]  el1_irq+0xb8/0x180
> [  100.140684]  _raw_spin_unlock_irqrestore+0x20/0x48
> [  100.141119]  sdhci_cqe_enable+0xec/0x108
> [  100.141478]  sdhci_arasan_cqe_enable+0x4c/0x58
> [  100.141880]  cqhci_request+0x2d0/0x500
> [  100.142226]  mmc_cqe_start_req+0x50/0x60
> [  100.142585]  mmc_blk_mq_issue_rq+0x430/0x794
> [  100.142974]  mmc_mq_queue_rq+0x104/0x270
> [  100.143332]  blk_mq_dispatch_rq_list+0xa8/0x580
> [  100.143746]  blk_mq_sched_dispatch_requests+0xf4/0x1d8
> [  100.144210]  __blk_mq_run_hw_queue+0xac/0x120
> [  100.144605]  blk_mq_run_work_fn+0x1c/0x28
> [  100.144974]  process_one_work+0x1e0/0x358
> [  100.145340]  worker_thread+0x40/0x488
> [  100.145679]  kthread+0x118/0x120
> [  100.145977]  ret_from_fork+0x10/0x18
> [  100.146302] ---[ end trace 6277099ad751ed64 ]---
> [  100.213815] mmc1: running CQE recovery
> [  100.413933] mmc1: running CQE recovery
> 
> > 
> > [0] https://patchwork.kernel.org/patch/10835567/
> > most current v2 it seems is https://patchwork.kernel.org/patch/10842421/
> > 
> >> Therefore I propose to disable HS400 mode on roc-pc for now.
> > 
> > Hoping for more input :-)
> 
> Hoping, too.
> 
> 
> Gruß,
> > 
> > 
> > Heiko
> > 
> > 
> >> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> >> ---
> >>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 2 --
> >>  1 file changed, 2 deletions(-)
> >> 
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> >> index 29a50a083c42..33df95e384b4 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> >> @@ -660,8 +660,6 @@
> >>  
> >>  &sdhci {
> >>  	bus-width = <8>;
> >> -	mmc-hs400-1_8v;
> >> -	mmc-hs400-enhanced-strobe;
> >>  	non-removable;
> >>  	status = "okay";
> >>  };
> >> 
> > 
> 
> 
