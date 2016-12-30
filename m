From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] Revert "mmc: dw_mmc-rockchip: add runtime PM support"
Date: Fri, 30 Dec 2016 11:35:01 +0900
Message-ID: <20afb1da-9e45-f515-01bf-2f5365d20d61@samsung.com>
References: <CGME20161228153516epcas2p253c6bc0371ab0df464573b63218795ef@epcas2p2.samsung.com>
 <1482939288-14950-1-git-send-email-ayaka@soulik.info>
 <e0cc8029-0155-4879-a643-ddc4239a55ab@samsung.com>
 <7e37b8ad-39d0-3a94-f75a-2166ae2caf10@samsung.com>
 <7fb90b9e-75c3-0184-4f0a-d4113899b860@rock-chips.com>
 <04b667d9-2591-51ff-e024-047bbb6e17c3@rock-chips.com>
 <6ccade72-ae20-2ffa-1504-2536b9f03adf@soulik.info>
 <95648282-38f5-42c2-fd8b-ab603eb3a168@gmail.com>
 <0ccf164f-0d35-9cc3-f288-9b582db23efb@soulik.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <0ccf164f-0d35-9cc3-f288-9b582db23efb@soulik.info>
Sender: linux-kernel-owner@vger.kernel.org
To: ayaka <ayaka@soulik.info>, Jaehoon Chung <jh80.chung@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Cc: Randy Li <randy.li@rock-chips.com>, ulf.hansson@linaro.org, heiko@sntech.de, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, xzy.xu@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

On 12/30/2016 12:07 AM, ayaka wrote:
> 
> 
> On 12/29/2016 10:04 PM, Jaehoon Chung wrote:
>> Hi,
>>
>> On 12/29/2016 09:55 PM, ayaka wrote:
>>> [    5.849733] rk_gmac-dwmac ff290000.ethernet (unnamed net_device) (uninitialized): Enable RX Mitigation via HW Watchdog Timer
>>> [    5.944512] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 50000000Hz, actual 50000000HZ div = 0)
>>> [    5.958249] mmc1: new ultra high speed DDR50 SDIO card at address 0001
>>> [    6.294548] dwmmc_rockchip ff0f0000.dwmmc: Successfully tuned phase to 177
>>> [    6.301591] mmc2: new HS200 MMC card at address 0001
>>> [    6.306758] mmc_host mmc0: Bus speed (slot 0) = 300000Hz (slot req 300000Hz, actual 300000HZ div = 0)
>>> [    6.316830] mmcblk2: mmc2:0001 AGND3R 14.6 GiB
>>> [    6.321881] mmcblk2boot0: mmc2:0001 AGND3R partition 1 4.00 MiB
>>> [    6.328331] mmcblk2boot1: mmc2:0001 AGND3R partition 2 4.00 MiB
>>> [    6.334792] mmcblk2rpmb: mmc2:0001 AGND3R partition 3 4.00 MiB
>>> [    6.344295]  mmcblk2: p1 p2 p3 p4 p5 p6 p7
>>> [    6.469892] mmc_host mmc0: Bus speed (slot 0) = 200000Hz (slot req 200000Hz, actual 200000HZ div = 0)
>>> [    6.621888] mmc_host mmc0: Bus speed (slot 0) = 187500Hz (slot req 100000Hz, actual 93750HZ div = 1)
>>> [    6.917883] libphy: stmmac: probed
>>> [    6.921319] rk_gmac-dwmac ff290000.ethernet eth0: PHY ID 001cc915 at 0 IRQ POLL (stmmac-0:00) active
>>> [    6.930476] rk_gmac-dwmac ff290000.ethernet eth0: PHY ID 001cc915 at 2 IRQ POLL (stmmac-0:02)
>>> [    6.939757] input: gpio-keys as /devices/platform/gpio-keys/input/input0
>>> [    6.946937] rtc-hym8563 0-0051: no valid clock/calendar values available
>>> [    6.953694] rtc-hym8563 0-0051: hctosys: unable to read the hardware clock
>>> [    6.961262] vcc_sd: disabling
>>> [    6.964275] dovdd_1v8: disabling
>>> [    6.967527] dvdd_1v2: disabling
>>> [    6.971006] vdd10_lcd: disabling
>>> [    6.974701] vcc18_lcd: disabling
>>> [    6.978467] ttyS2 - failed to request DMA
>>> [    7.101883] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
>>> [    7.253874] mmc_host mmc0: Bus speed (slot 0) = 300000Hz (slot req 300000Hz, actual 300000HZ div = 0)
>>> [    7.405883] mmc_host mmc0: Bus speed (slot 0) = 200000Hz (slot req 200000Hz, actual 200000HZ div = 0)
>>> [    7.557885] mmc_host mmc0: Bus speed (slot 0) = 187500Hz (slot req 100000Hz, actual 93750HZ div = 1)
>>> [    8.037872] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
>>> [    8.189877] mmc_host mmc0: Bus speed (slot 0) = 300000Hz (slot req 300000Hz, actual 300000HZ div = 0)
>>> [    8.341881] mmc_host mmc0: Bus speed (slot 0) = 200000Hz (slot req 200000Hz, actual 200000HZ div = 0)
>>> [    8.493884] mmc_host mmc0: Bus speed (slot 0) = 187500Hz (slot req 100000Hz, actual 93750HZ div = 1)
>>> [    8.973871] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
>>> [    9.125876] mmc_host mmc0: Bus speed (slot 0) = 300000Hz (slot req 300000Hz, actual 300000HZ div = 0)
>>> [    9.277884] mmc_host mmc0: Bus speed (slot 0) = 200000Hz (slot req 200000Hz, actual 200000HZ div = 0)
>>> [    9.429882] mmc_host mmc0: Bus speed (slot 0) = 187500Hz (slot req 100000Hz, actual 93750HZ div = 1)
>>>
>>> looping here
>>>
>>> If I revert that patch, there are still lots of Bus speed messages, but finally would enter into system.
>>>
>> Plz..Don't put the comment on the top.
>>
>> Which kernel did you use?
> Add linux-next specific files for 20161224

mmc0 is what card? Is it polling for detecting card?
(It seems the SD-card..right?)
Those logs should be polled for detecting mmc0 card..Hmm..I sent the patch for disabling log message when polling.
If this log is displayed, then my patch might be some wrong.. :(

Best Regards,
Jaehoon Chung

>>
>>>>>>
>>>>>>
>>>>>>
>>>>>

[snip]

> 
> 
> 
> 
