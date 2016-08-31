From: Wadim Egorov <w.egorov@phytec.de>
Subject: Re: Initialising eMMC: Card stuck in programming state! __mmc_switch
Date: Wed, 31 Aug 2016 16:25:08 +0200
Message-ID: <57C6E8C4.7090407@phytec.de>
References: <CGME20160831095654epcas1p46eff3c8b36117c8baef87050aee315a9@epcas1p4.samsung.com>
 <57C6A9D8.6020705@phytec.de>
 <41404a08-c383-f087-4e4f-5d8f2dbbcad6@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.phytec.de ([217.6.246.34]:43744 "EHLO root.phytec.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934976AbcHaOZR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 31 Aug 2016 10:25:17 -0400
In-Reply-To: <41404a08-c383-f087-4e4f-5d8f2dbbcad6@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org

Hi Jaehoon,

On 31.08.2016 12:29, Jaehoon Chung wrote:
> Hi Wadim,
>
> On 08/31/2016 06:56 PM, Wadim Egorov wrote:
>> Hello,
>>
>> I have a RK3288 based board with a Micron eMMC chip (MTFC16GAKAECN-4M
>> IT). This eMMC is EDEC/MMC standard version 5.0-compliant.
>>
>> While doing eMMC boot tests with a 4.4.16 and 4.8.0-rc4 kernel I run
>> into the following problem after more than 100 cold resets:
>>
>> [    3.535448] dwmmc_rockchip ff0c0000.dwmmc: 1 slots initialized
>> [    3.543823] dwmmc_rockchip ff0f0000.dwmmc: IDMAC supports 32-bit address mode.
>> [    3.551276] dwmmc_rockchip ff0f0000.dwmmc: Using internal DMA controller.
>> [    3.558206] dwmmc_rockchip ff0f0000.dwmmc: Version ID is 270a
>> [    3.564275] dwmmc_rockchip ff0f0000.dwmmc: DW MMC controller at irq 31,32 bit host data width,256 deep fifo
>> [    3.604426] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
>> [    3.634510] dwmmc_rockchip ff0f0000.dwmmc: 1 slots initialized
>> [    3.645305] leds-pca953x 4-0062: setting platform data
>> [    3.656675] ledtrig-cpu: registered to indicate activity on CPUs
>> [    3.663200] usbcore: registered new interface driver usbhid
>> [    3.668783] usbhid: USB HID core driver
>> [    3.672674] usbcore: registered new interface driver r8188eu
>> [    3.678393] usbcore: registered new interface driver rtl8723au
>> [    3.699210] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
>> [    3.900398] random: crng init done
>> [    3.954089] NET: Registered protocol family 10
>> [    3.974107] mmc0: Card stuck in programming state! __mmc_switch
>> [    3.980027] mmc0: error -110 whilst initialising MMC card
> Is it produced with both 4.4.16 and 4.8.0-rc4?

yes, with both versions.

> Could you enable the CONFIG_MMC_DEBUG? And which mode do you use?

mode? Do you mean busmode? I am not sure. The eMMC runs with 50MHz, so I
think it should be SDR/DDR52 mode. Debug message below says busmode 2:

[    4.588352] dwmmc_rockchip ff0f0000.dwmmc: Looking up vmmc-supply
from device tree
[    4.588671] dwmmc_rockchip ff0f0000.dwmmc: Looking up vqmmc-supply
from device tree
[    4.589246] mmc_host mmc0: card is present
[    4.589784] mmc0: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 21 width 1
timing 0
[    4.589849] dwmmc_rockchip ff0f0000.dwmmc: mmc_regulator_set_vqmmc:
found vmmc voltage r
ange of 3300000-3400000uV
[    4.589897] mmc_host mmc0: Regulator set error -22 - 3.3 V
[    4.589937] dwmmc_rockchip ff0f0000.dwmmc: Initial signal voltage of 1.8v
[    4.615903] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21
width 1 timing 0
[    4.616148] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req
400000Hz, actual 4000
00HZ div = 0)
[    4.646014] dwmmc_rockchip ff0f0000.dwmmc: 1 slots initialized
[    4.646792] leds-pca953x 4-0062: setting platform data
[    4.714311] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
...
[    5.454083] mmc0: starting CMD52 arg 00000c00 flags 00000195
[    5.454090] mmc_host mmc0: card is present
[    5.455108] mmc0: req done (CMD52): -110: 00000000 00000000 00000000
00000000
[    5.465492] mmc0: starting CMD52 arg 80000c08 flags 00000195
[    5.465498] mmc_host mmc0: card is present
[    5.471260] mmc0: req done (CMD52): -110: 00000000 00000000 00000000
00000000
[    5.471288] mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21
width 1 timing 0
[    5.472249] mmc0: starting CMD0 arg 00000000 flags 000000c0
[    5.472254] mmc_host mmc0: card is present
...
   5.641973] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[    5.641981] mmc0: clock 52000000Hz busmode 2 powermode 2 cs 0 Vdd 21
width 1 timing 1
[    5.641996] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req
52000000Hz, actual
50000000HZ div = 0)
...
[    5.935949] mmc0: req done (CMD13): 0: 00000e00 00000000 00000000
00000000
[    5.935955] mmc0: Card stuck in programming state! __mmc_switch
[    5.935960] mmc0: error -110 whilst initialising MMC card
[    5.935964] mmc0: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 1
timing 0
[    6.441560] mmc_host mmc0: Timeout sending command (cmd 0x202000 arg
0x0 status 0x0)


Here is the full output (without mmc1* messages) with CONFIG_MMC_DEBUG:

  http://pastebin.com/qVTZfE6c


>
> According to below bootloader log, you're using eMMC4.0 card, right?

No, it is an eMMC5.0 card. The bootloader output seems to be wrong.

  mmc extcsd read /dev/mmcblk0
  =============================================
    Extended CSD rev 1.7 (MMC 5.0)
  =============================================

Regards,
Wadim

>
> Best Regards,
> Jaehoon Chung
>
>>
>> The bootloader I am using has no problems with the eMMC as you can see
>> below:
>>
>> barebox@phycore-rk3288:/ devinfo mshc0
>> Host information:
>>   current clock: 52000000
>>   current buswidth: 8
>>   capabilities: 4bit 8bit sd-hs mmc-hs mmc-52MHz
>> Card information:
>>   Attached is a MMC card
>>   Version: 4.0
>>   Capacity: 14080 MiB
>>   High capacity card
>>    CID: 13014E52-314A3536-4C11616D-559BA2BD
>>    CSD: D04F0132-0F5913FF-FFFFFFEF-8A4000BF
>>   Max. transfer speed: 52000000 Hz
>>   capabilities: 4bit mmc-hs mmc-52MHz
>>   Manufacturer ID: 13
>>   OEM/Application ID: 014E
>>   Product name: 'R1J56'
>>   Product revision: 4.12
>>   Serial no: 1634555291
>>   Manufacturing date: 10.1999
>> Parameters:
>>   boot: disabled ("disabled", "boot0", "boot1", "user")
>>   nt_signature: 8a35eb82
>>   probe: 0
>>
>> Any hints on what the problem could be?
>>
>> Regards,
>> Wadim
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> .
>>

