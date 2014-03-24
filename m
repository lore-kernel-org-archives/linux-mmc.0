From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: Re: [PATCH v9 resend 1/3] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Mon, 24 Mar 2014 11:30:43 +0200
Message-ID: <532FFB43.5020408@compulab.co.il>
References: <1395404448-30030-1-git-send-email-afenkart@gmail.com> <1395404448-30030-2-git-send-email-afenkart@gmail.com> <532C6489.4050307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:40858 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbaCXJbW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Mar 2014 05:31:22 -0400
In-Reply-To: <532C6489.4050307@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

I've tested the branch omap_hsmmc_sdio_irq_devm_cleanup on custom OMAP5 
based board.
We have mwifiex connected to MMC3.

I used two approaches:

* Using dat1 line as GPIO with dynamic remuxing
* Using separate GPIO connected to dat1 with static mux settings

Both works just fine. Thanks Andreas for a great solution.

I have just one issue - how to define GPIO IRQ using DT in OMAP5 case.
As a temporary hack for testing I used a fixed GPIO number and 
gpio_to_irq() call in omap_hsmmc_configure_wake_irq().

OMAP5 MMC3 has the following DT entry (omap5.dtsi):

                 mmc3: mmc@480ad000 {
                         compatible = "ti,omap4-hsmmc";
                         reg = <0x480ad000 0x400>;
                         interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
                         ti,hwmods = "mmc3";
                         ti,needs-special-reset;
                         dmas = <&sdma 77>, <&sdma 78>;
                         dma-names = "tx", "rx";
                 };

What should be by board MMC3 setup?

Something like this?

&mmc3 {
         pinctrl-names = "default", "active", "idle";
         pinctrl-0 = <&mmc3_pins>;
         pinctrl-1 = <&mmc3_pins>;
         pinctrl-2 = <&mmc3_cirq_pin>;

         interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
                             <????????>;

         vmmc-supply = <&ldo2_reg>;
         bus-width = <4>;
         ti,non-removable;
};

I tried to specify the second interrupt as (wlsdio_data1 / gpio5_131):

<&gpio5 3 IRQ_TYPE_NONE>

but it fails:

[    2.275777] ------------[ cut here ]------------
[    2.280604] WARNING: CPU: 1 PID: 6 at 
/home/lifshitz/workroot/OMAP5-eewiki/omap5-kernel/kernel/irq/manage.c:1418 
request_threaded_irq+0x11c/0x12c()
[    2.294414] Modules linked in:
[    2.297611] CPU: 1 PID: 6 Comm: kworker/u4:0 Tainted: G W    
3.14.0-rc4-cm-t54-test-suit+ #30
[    2.307165] Workqueue: deferwq deferred_probe_work_func
[    2.312629] [<c001597c>] (unwind_backtrace) from [<c001283c>] 
(show_stack+0x10/0x14)
[    2.320739] [<c001283c>] (show_stack) from [<c06494dc>] 
(dump_stack+0x70/0x88)
[    2.328294] [<c06494dc>] (dump_stack) from [<c003a520>] 
(warn_slowpath_common+0x70/0x88)
[    2.336761] [<c003a520>] (warn_slowpath_common) from [<c003a554>] 
(warn_slowpath_null+0x1c/0x24)
[    2.345940] [<c003a554>] (warn_slowpath_null) from [<c0083ce4>] 
(request_threaded_irq+0x11c/0x12c)
[    2.355312] [<c0083ce4>] (request_threaded_irq) from [<c0085964>] 
(devm_request_threaded_irq+0x5c/0x90)
[    2.361973] mmc1: host does not support reading read-only switch. 
assuming write-enable.
[    2.362020] mmc1: new SDHC card at address e624
[    2.362331] mmcblk1: mmc1:e624 SU08G 7.40 GiB
[    2.368152]  mmcblk1: p1 p2
[    2.385850] [<c0085964>] (devm_request_threaded_irq) from 
[<c047d958>] (omap_hsmmc_configure_wake_irq+0x7c/0xfc)
[    2.393150] usb 1-2: New USB device found, idVendor=0424, idProduct=3503
[    2.393156] usb 1-2: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[    2.393674] hub 1-2:1.0: USB hub found
[    2.393769] hub 1-2:1.0: 3 ports detected
[    2.419038] [<c047d958>] (omap_hsmmc_configure_wake_irq) from 
[<c047ea28>] (omap_hsmmc_probe+0x5b4/0x854)
[    2.429052] [<c047ea28>] (omap_hsmmc_probe) from [<c0359ec0>] 
(platform_drv_probe+0x18/0x48)
[    2.437879] [<c0359ec0>] (platform_drv_probe) from [<c03580c8>] 
(really_probe+0x80/0x208)
[    2.446427] [<c03580c8>] (really_probe) from [<c0358360>] 
(driver_probe_device+0x30/0x48)
[    2.454976] [<c0358360>] (driver_probe_device) from [<c0356a58>] 
(bus_for_each_drv+0x5c/0x88)
[    2.463891] [<c0356a58>] (bus_for_each_drv) from [<c03582f4>] 
(device_attach+0x80/0xa0)
[    2.472247] [<c03582f4>] (device_attach) from [<c03577b4>] 
(bus_probe_device+0x84/0xa8)
[    2.480617] [<c03577b4>] (bus_probe_device) from [<c0357bb8>] 
(deferred_probe_work_func+0x68/0x98)
[    2.489987] [<c0357bb8>] (deferred_probe_work_func) from [<c00533c0>] 
(process_one_work+0x150/0x41c)
[    2.499542] [<c00533c0>] (process_one_work) from [<c0053d10>] 
(worker_thread+0xf4/0x31c)
[    2.508011] [<c0053d10>] (worker_thread) from [<c0059994>] 
(kthread+0xd4/0xe8)
[    2.512785] usb 1-3: new high-speed USB device number 3 using ehci-omap
[    2.522474] [<c0059994>] (kthread) from [<c000e878>] 
(ret_from_fork+0x14/0x3c)
[    2.530023] ---[ end trace 8d60f1d3adba88d7 ]---


Regards,

Dmitry

On 03/21/2014 06:10 PM, Balaji T K wrote:
> On Friday 21 March 2014 05:50 PM, Andreas Fenkart wrote:
>
> Thanks Andreas for the patch series
>
> I rebased against latest mmc-next, made few changes to your patch.
> I have hosted your series along with devm cleanups on a branch[1] for 
> testing
> [1]
> git://git.ti.com/~balajitk/ti-linux-kernel/omap-hsmmc.git 
> omap_hsmmc_sdio_irq_devm_cleanup
>
> Can you please test on your platform and provide feedback.
>
> Details about the changes below.

