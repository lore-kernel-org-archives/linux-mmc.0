From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: "refcount_t: underflow; use-after-free" when removing a SD card
Date: Tue, 13 Jun 2017 00:05:53 +0200
Message-ID: <e9ff53a6-2863-0d69-ba7c-eab80b9b5552@gmail.com>
References: <636ebd78-d813-aad2-bb24-b52ad75ff192@gmail.com>
 <CAPDyKFrmKUj2jv_HOxVJfAQD1emzXLv_80__Bddm2_EABqqRVQ@mail.gmail.com>
 <993cbd83-7e11-7655-ffab-1f352a16fd4b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34072 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbdFLWGA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jun 2017 18:06:00 -0400
Received: by mail-wr0-f193.google.com with SMTP id u101so25163654wrc.1
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2017 15:05:59 -0700 (PDT)
In-Reply-To: <993cbd83-7e11-7655-ffab-1f352a16fd4b@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Am 12.06.2017 um 23:54 schrieb Heiner Kallweit:
> Am 12.06.2017 um 10:10 schrieb Ulf Hansson:
>> Hi Heiner,
>>
>>
>> On 11 June 2017 at 09:27, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>> When removing a SD card I get the following error. IIRC this did not
>>> happen when I started testing the Meson GPIO IRQ driver few weeks ago.
>>
>> I have just stepped the base for the mmc next branch to 4.12-rc5.
>>
>> Could run a test on top of mmc next and then compare the results with
>> a fresh 4.12-rc5?
>>
>>>
>>> It occurs in card detect polling mode and in cd irq mode as well.
>>>
>>> Looking at recent changes to the mmc core I didn't find anything
>>> clearly related to this error.
>>
>> Thanks for reporting!
>>
> 
> There may be a relationship with commit
> d573ed66a89 "mmc: core: Allocate per-request data using the block layer core"
> 
> blk_put_queue is called multiple times after card removal:
> 
> mmc_blk_remove_req -> mmc_cleanup_queue -> blk_cleanup_queue -> blk_put_queue
> mmc_blk_remove_req -> mmc_blk_put -> blk_cleanup_queue -> blk_put_queue
> mmc_blk_remove_req -> mmc_blk_put -> put_disk -> disk_release -> blk_put_queue
> 
> Mentioned commit added a call to blk_cleanup_queue to mmc_cleanup_queue.
> Now blk_cleanup_queue is called twice and I'm not sure whether this is correct.
> 
By the way: Removing the new call to blk_cleanup_queue in mmc_cleanup_queue
fixed the issue for me, but whether this is the correct fix I can't tell.

> Rgds, Heiner
> 
> 
>> Kind regards
>> Uffe
>>
>>>
>>>
>>> [   32.661577] mmc1: new high speed SDHC card at address 1234
>>> [   32.669902] mmcblk1: mmc1:1234 SA08G 7.21 GiB
>>> [   32.674059]  mmcblk1: p1
>>> [   44.958867] mmc1: card 1234 removed
>>> [   44.990779] refcount_t: underflow; use-after-free.
>>> [   44.991112] ------------[ cut here ]------------
>>> [   44.994658] WARNING: CPU: 0 PID: 1126 at lib/refcount.c:184 refcount_sub_and_test+0xc4/0xe0
>>> [   45.002850] Modules linked in: dwc2 udc_core fb_sh1106(C) fbtft(C) syscopyarea sysfillrect sysimgblt fb_sys_fops      dwmac_generic realtek fb rtc_ds1307 ir_lirc_codec dwmac_meson8b ir_sony_decoder lirc_dev regmap_i2c at24 usbcore stm     mac_platform phy_meson8b_usb2 stmmac meson_rng spi_gpio meson_ir spi_bitbang rng_core meson_gxbb_wdt meson_saradc rc     _core industrialio usb_common i2c_meson i2c_core leds_gpio nvmem_meson_efuse led_class nvmem_core ipv6
>>> [   45.041870] CPU: 0 PID: 1126 Comm: kworker/0:4 Tainted: G         C      4.12.0-rc4-next-20170609+ #15
>>> [   45.051062] Hardware name: Hardkernel ODROID-C2 (DT)
>>> [   45.056025] Workqueue: events_freezable mmc_rescan
>>> [   45.060734] task: ffff800071090000 task.stack: ffff800071b70000
>>> [   45.066625] PC is at refcount_sub_and_test+0xc4/0xe0
>>> [   45.071532] LR is at refcount_sub_and_test+0xc4/0xe0
>>> [   45.076431] pc : [<ffff0000083047fc>] lr : [<ffff0000083047fc>] pstate: 00000145
>>> [   45.083747] sp : ffff800071b73ad0
>>> [   45.087028] x29: ffff800071b73ad0 x28: 0000000000000000
>>> [   45.092288] x27: 0000000000000000 x26: ffff0000085f95c8
>>> [   45.097549] x25: 00000000fffffef7 x24: ffff800071b62818
>>> [   45.102810] x23: 0000000000000060 x22: 0000000000000004
>>> [   45.108073] x21: ffff80006deacb00 x20: ffff800071b63000
>>> [   45.113334] x19: ffff8000712eb918 x18: 0000000000000010
>>> [   45.118594] x17: 0000ffff80dd19d8 x16: 0000000000000000
>>> [   45.123856] x15: ffffffffffffffff x14: ffff0000887451f7
>>> [   45.129117] x13: ffff0000086d8938 x12: ffff000008363150
>>> [   45.134378] x11: 0000000005f5e0ff x10: 0000000000000005
>>> [   45.139639] x9 : 00000000ffffffd0 x8 : 6572662d72657466
>>> [   45.144901] x7 : 612d657375203b77 x6 : 00000000000000d6
>>> [   45.150160] x5 : 0000000000000000 x4 : 0000000000000000
>>> [   45.155422] x3 : 0000000000000000 x2 : ffff80007ff807c0
>>> [   45.160684] x1 : 00008000778b8000 x0 : 0000000000000026
>>> [   45.165945] Call trace:
>>> [   45.168384] Exception stack(0xffff800071b73900 to 0xffff800071b73a30)
>>> [   45.174773] 3900: ffff8000712eb918 0001000000000000 ffff800071b73ad0 ffff0000083047fc
>>> [   45.182531] 3920: 0000000000000000 0000000000000000 ffff800071b73970 0000000000000000
>>> [   45.190296] 3940: ffff800071b73ad0 ffff800071b73ad0 ffff800071b73a90 00000000ffffffc8
>>> [   45.198059] 3960: ffff800071b73990 ffff0000080e98e4 ffff800071b73ad0 ffff800071b73ad0
>>> [   45.205821] 3980: ffff800071b73a90 00000000ffffffc8 ffff800071b73a40 ffff000008142c30
>>> [   45.213582] 39a0: 0000000000000026 00008000778b8000 ffff80007ff807c0 0000000000000000
>>> [   45.221343] 39c0: 0000000000000000 0000000000000000 00000000000000d6 612d657375203b77
>>> [   45.229106] 39e0: 6572662d72657466 00000000ffffffd0 0000000000000005 0000000005f5e0ff
>>> [   45.236871] 3a00: ffff000008363150 ffff0000086d8938 ffff0000887451f7 ffffffffffffffff
>>> [   45.244619] 3a20: 0000000000000000 0000ffff80dd19d8
>>> [   45.249472] [<ffff0000083047fc>] refcount_sub_and_test+0xc4/0xe0
>>> [   45.255420] [<ffff00000830482c>] refcount_dec_and_test+0x14/0x20
>>> [   45.261363] [<ffff0000082ec43c>] kobject_put+0x24/0xe0
>>> [   45.266461] [<ffff0000082bd4a0>] blk_put_queue+0x10/0x18
>>> [   45.271716] [<ffff0000082d2f70>] disk_release+0x90/0xb0
>>> [   45.276900] [<ffff00000837f22c>] device_release+0x34/0x90
>>> [   45.282234] [<ffff0000082ec48c>] kobject_put+0x74/0xe0
>>> [   45.287320] [<ffff0000082d2064>] put_disk+0x14/0x28
>>> [   45.292159] [<ffff0000083f6654>] mmc_blk_put+0x64/0x90
>>> [   45.297250] [<ffff0000083f7c9c>] mmc_blk_remove_req.part.13+0x74/0x80
>>> [   45.303626] [<ffff0000083f7e3c>] mmc_blk_remove+0x104/0x198
>>> [   45.309143] [<ffff0000083e9aec>] mmc_bus_remove+0x1c/0x28
>>> [   45.314500] [<ffff000008384d3c>] device_release_driver_internal+0x174/0x200
>>> [   45.321391] [<ffff000008384ddc>] device_release_driver+0x14/0x20
>>> [   45.327342] [<ffff000008383c2c>] bus_remove_device+0x12c/0x150
>>> [   45.333131] [<ffff00000838071c>] device_del+0x1ac/0x300
>>> [   45.338297] [<ffff0000083ea238>] mmc_remove_card+0x48/0x88
>>> [   45.343739] [<ffff0000083ef340>] mmc_sd_detect+0x38/0x70
>>> [   45.348990] [<ffff0000083e94ec>] mmc_rescan+0xbc/0x3b8
>>> [   45.354085] [<ffff0000080bd54c>] process_one_work+0x1dc/0x340
>>> [   45.359770] [<ffff0000080bd6f8>] worker_thread+0x48/0x480
>>> [   45.365129] [<ffff0000080c345c>] kthread+0x12c/0x130
>>> [   45.370040] [<ffff0000080826c0>] ret_from_fork+0x10/0x50
>>> [   45.375280] ---[ end trace 68e15ca00eff8617 ]---
>>
> 

