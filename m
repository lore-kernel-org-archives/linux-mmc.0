From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] Revert "mmc: dw_mmc-rockchip: add runtime PM support"
Date: Fri, 20 Jan 2017 15:08:57 +0900
Message-ID: <fba28eda-51c7-2012-03ca-48b6f94e4a18@samsung.com>
References: <CGME20161228153516epcas2p253c6bc0371ab0df464573b63218795ef@epcas2p2.samsung.com>
 <1482939288-14950-1-git-send-email-ayaka@soulik.info>
 <e0cc8029-0155-4879-a643-ddc4239a55ab@samsung.com>
 <7e37b8ad-39d0-3a94-f75a-2166ae2caf10@samsung.com>
 <7fb90b9e-75c3-0184-4f0a-d4113899b860@rock-chips.com>
 <04b667d9-2591-51ff-e024-047bbb6e17c3@rock-chips.com>
 <6ccade72-ae20-2ffa-1504-2536b9f03adf@soulik.info>
 <95648282-38f5-42c2-fd8b-ab603eb3a168@gmail.com>
 <0ccf164f-0d35-9cc3-f288-9b582db23efb@soulik.info>
 <20afb1da-9e45-f515-01bf-2f5365d20d61@samsung.com>
 <8f8c66f1-82d6-5151-ff64-ef62596aa10d@rock-chips.com>
 <c8307da1-8e43-29b5-c87d-292a56831c98@samsung.com>
 <CABgxDo+3qMcHn6e2s_ZJy1crdi=ch5hQk6sy3W29Q12-ye33Qw@mail.gmail.com>
 <2cdd0b6c-a099-595d-1c0b-be7933b0d4a6@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <2cdd0b6c-a099-595d-1c0b-be7933b0d4a6@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Perier <romain.perier@collabora.com>, Romain Perier <romain.perier@gmail.com>
Cc: Randy Li <randy.li@rock-chips.com>, ayaka <ayaka@soulik.info>, Jaehoon Chung <jh80.chung@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, xzy.xu@rock-chips.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 01/17/2017 10:38 PM, Romain Perier wrote:
> Hi,
> 
> In my case I can reproduce the issue on the rock2 and the firefly-rk3288. A workaround is to
> 
> comment the line ".pm = <&pm_ops_foo>" .

Sorry for late. I'm checking runtime PM for this. 
After that, i will decide whether revert or not.

Best Regards,
Jaehoon Chung

> 
> Thanks,
> Romain
> 
> 
> Le 17/01/2017 à 14:28, Romain Perier a écrit :
>> Hello,
>>
>> This commit also breaks reboot and poweroff (the pmic no longer turn the power supply off), see below:
>>
>> # poweroff
>> # Stopping network: ifdown: interface lo not configured
>> OK
>> Saving random seed... done.
>> Stopping logging: OK
>> umount: devtmpfs busy - remounted read-only
>> The system is going down NOW!
>> Sent SIGTERM to all processes
>> Sent SIGKILL to all processes
>> Requesting system poweroff
>> [  243.673159] INFO: task init:168 blocked for more than 120 seconds.
>> [  243.701298]       Not tainted 4.10.0-rc4-13066-gc10b6c6 #108
>> [  243.728802] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  243.758948] init            D    0   168      1 0x00000000
>> [  243.786412] [<c0888740>] (__schedule) from [<c0888b10>] (schedule+0x44/0x9c)
>> [  243.815411] [<c0888b10>] (schedule) from [<c088c218>] (schedule_timeout+0x1d8/0x220)
>> [  243.845267] [<c088c218>] (schedule_timeout) from [<c0889528>] (wait_for_common+0xa4/0x168)
>> [  243.876105] [<c0889528>] (wait_for_common) from [<c06da03c>] (mmc_wait_for_req_done+0x8c/0x110)
>> [  243.907150] [<c06da03c>] (mmc_wait_for_req_done) from [<c06da204>] (mmc_wait_for_cmd+0x58/0x78)
>> [  243.937855] [<c06da204>] (mmc_wait_for_cmd) from [<c06e14ec>] (__mmc_switch+0xbc/0x34c)
>> [  243.967791] [<c06e14ec>] (__mmc_switch) from [<c06e17a4>] (mmc_switch+0x28/0x30)
>> [  243.997029] [<c06e17a4>] (mmc_switch) from [<c06db144>] (mmc_flush_cache+0x54/0x80)
>> [  244.026955] [<c06db144>] (mmc_flush_cache) from [<c06e0084>] (_mmc_suspend+0x40/0x268)
>> [  244.057529] [<c06e0084>] (_mmc_suspend) from [<c06dcf3c>] (mmc_bus_shutdown+0x40/0x64)
>> [  244.088412] [<c06dcf3c>] (mmc_bus_shutdown) from [<c04db050>] (device_shutdown+0x144/0x1d8)
>> [  244.120015] [<c04db050>] (device_shutdown) from [<c01503b8>] (kernel_power_off+0x34/0x70)
>> [  244.151235] [<c01503b8>] (kernel_power_off) from [<c0150598>] (SyS_reboot+0x15c/0x1d0)
>> [  244.182037] [<c0150598>] (SyS_reboot) from [<c01076c0>] (ret_fast_syscall+0x0/0x3c)
>> [  366.553025] INFO: task init:168 blocked for more than 120 seconds.
>> [  366.583187]       Not tainted 4.10.0-rc4-13066-gc10b6c6 #108
>> [  366.613053] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>
>>
>>
>> Reverting this commit solves the issue.
>>
>> Regards,
>> Romain
>>
>>
>> 2016-12-30 3:50 GMT+01:00 Jaehoon Chung <jh80.chung@samsung.com <mailto:jh80.chung@samsung.com>>:
>>
>>     On 12/30/2016 11:44 AM, Randy Li wrote:
>>     >
>>     >
>>     > On 12/30/2016 10:35 AM, Jaehoon Chung wrote:
>>     >> On 12/30/2016 12:07 AM, ayaka wrote:
>>     >>>
>>     >>>
>>     >>> On 12/29/2016 10:04 PM, Jaehoon Chung wrote:
>>     >>>> Hi,
>>     >>>>
>>     >>>> On 12/29/2016 09:55 PM, ayaka wrote:
>>     >>>>> [    5.849733] rk_gmac-dwmac ff290000.ethernet (unnamed
>>     net_device) (uninitialized): Enable RX Mitigation via HW Watchdog
>>     Timer
>>     >>>>> [    5.944512] mmc_host mmc1: Bus speed (slot 0) =
>>     50000000Hz (slot req 50000000Hz, actual 50000000HZ div = 0)
>>     >>>>> [    5.958249] mmc1: new ultra high speed DDR50 SDIO card at
>>     address 0001
>>     >>>>> [    6.294548] dwmmc_rockchip ff0f0000.dwmmc: Successfully
>>     tuned phase to 177
>>     >>>>> [    6.301591] mmc2: new HS200 MMC card at address 0001
>>     >>>>> [    6.306758] mmc_host mmc0: Bus speed (slot 0) = 300000Hz
>>     (slot req 300000Hz, actual 300000HZ div = 0)
>>     >>>>> [    6.316830] mmcblk2: mmc2:0001 AGND3R 14.6 GiB
>>     >>>>> [    6.321881] mmcblk2boot0: mmc2:0001 AGND3R partition 1
>>     4.00 MiB
>>     >>>>> [    6.328331] mmcblk2boot1: mmc2:0001 AGND3R partition 2
>>     4.00 MiB
>>     >>>>> [    6.334792] mmcblk2rpmb: mmc2:0001 AGND3R partition 3
>>     4.00 MiB
>>     >>>>> [    6.344295]  mmcblk2: p1 p2 p3 p4 p5 p6 p7
>>     >>>>> [    6.469892] mmc_host mmc0: Bus speed (slot 0) = 200000Hz
>>     (slot req 200000Hz, actual 200000HZ div = 0)
>>     >>>>> [    6.621888] mmc_host mmc0: Bus speed (slot 0) = 187500Hz
>>     (slot req 100000Hz, actual 93750HZ div = 1)
>>     >>>>> [    6.917883] libphy: stmmac: probed
>>     >>>>> [    6.921319] rk_gmac-dwmac ff290000.ethernet eth0: PHY ID
>>     001cc915 at 0 IRQ POLL (stmmac-0:00) active
>>     >>>>> [    6.930476] rk_gmac-dwmac ff290000.ethernet eth0: PHY ID
>>     001cc915 at 2 IRQ POLL (stmmac-0:02)
>>     >>>>> [    6.939757] input: gpio-keys as
>>     /devices/platform/gpio-keys/input/input0
>>     >>>>> [    6.946937] rtc-hym8563 0-0051: no valid clock/calendar
>>     values available
>>     >>>>> [    6.953694] rtc-hym8563 0-0051: hctosys: unable to read
>>     the hardware clock
>>     >>>>> [    6.961262] vcc_sd: disabling
>>     >>>>> [    6.964275] dovdd_1v8: disabling
>>     >>>>> [    6.967527] dvdd_1v2: disabling
>>     >>>>> [    6.971006] vdd10_lcd: disabling
>>     >>>>> [    6.974701] vcc18_lcd: disabling
>>     >>>>> [    6.978467] ttyS2 - failed to request DMA
>>     >>>>> [    7.101883] mmc_host mmc0: Bus speed (slot 0) = 400000Hz
>>     (slot req 400000Hz, actual 400000HZ div = 0)
>>     >>>>> [    7.253874] mmc_host mmc0: Bus speed (slot 0) = 300000Hz
>>     (slot req 300000Hz, actual 300000HZ div = 0)
>>     >>>>> [    7.405883] mmc_host mmc0: Bus speed (slot 0) = 200000Hz
>>     (slot req 200000Hz, actual 200000HZ div = 0)
>>     >>>>> [    7.557885] mmc_host mmc0: Bus speed (slot 0) = 187500Hz
>>     (slot req 100000Hz, actual 93750HZ div = 1)
>>     >>>>> [    8.037872] mmc_host mmc0: Bus speed (slot 0) = 400000Hz
>>     (slot req 400000Hz, actual 400000HZ div = 0)
>>     >>>>> [    8.189877] mmc_host mmc0: Bus speed (slot 0) = 300000Hz
>>     (slot req 300000Hz, actual 300000HZ div = 0)
>>     >>>>> [    8.341881] mmc_host mmc0: Bus speed (slot 0) = 200000Hz
>>     (slot req 200000Hz, actual 200000HZ div = 0)
>>     >>>>> [    8.493884] mmc_host mmc0: Bus speed (slot 0) = 187500Hz
>>     (slot req 100000Hz, actual 93750HZ div = 1)
>>     >>>>> [    8.973871] mmc_host mmc0: Bus speed (slot 0) = 400000Hz
>>     (slot req 400000Hz, actual 400000HZ div = 0)
>>     >>>>> [    9.125876] mmc_host mmc0: Bus speed (slot 0) = 300000Hz
>>     (slot req 300000Hz, actual 300000HZ div = 0)
>>     >>>>> [    9.277884] mmc_host mmc0: Bus speed (slot 0) = 200000Hz
>>     (slot req 200000Hz, actual 200000HZ div = 0)
>>     >>>>> [    9.429882] mmc_host mmc0: Bus speed (slot 0) = 187500Hz
>>     (slot req 100000Hz, actual 93750HZ div = 1)
>>     >>>>>
>>     >>>>> looping here
>>     >>>>>
>>     >>>>> If I revert that patch, there are still lots of Bus speed
>>     messages, but finally would enter into system.
>>     >>>>>
>>     >>>> Plz..Don't put the comment on the top.
>>     >>>>
>>     >>>> Which kernel did you use?
>>     >>> Add linux-next specific files for 20161224
>>     >>
>>     >> mmc0 is what card? Is it polling for detecting card?
>>     >> (It seems the SD-card..right?)
>>     > Yes, but the Firefly release won't show that, just stop at
>>     "ttyS2 - failed to request DMA". I check both the firefly reload
>>     and firefly release, they both have a cd line for them, so it
>>     won't be poll mode.
>>
>>     I don't have Rockchip board, so I hope that Shawn will check it.
>>     But i will check the displayed the log message.
>>
>>     Best Regards,
>>     Jaehoon Chung
>>
>>     >> Those logs should be polled for detecting mmc0 card..Hmm..I
>>     sent the patch for disabling log message when polling.
>>     >> If this log is displayed, then my patch might be some wrong.. :(
>>     >>
>>     >> Best Regards,
>>     >> Jaehoon Chung
>>     >>
>>     >>>>
>>     >>>>>>>>
>>     >>>>>>>>
>>     >>>>>>>>
>>     >>>>>>>
>>     >>
>>     >> [snip]
>>     >>
>>     >>>
>>     >>>
>>     >>>
>>     >>>
>>     >>
>>     >>
>>     >
>>
>>
>>     _______________________________________________
>>     Linux-rockchip mailing list
>>     Linux-rockchip@lists.infradead.org
>>     <mailto:Linux-rockchip@lists.infradead.org>
>>     http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>     <http://lists.infradead.org/mailman/listinfo/linux-rockchip>
>>
>>
> 
> 
