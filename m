From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: Initialising eMMC: Card stuck in programming state! __mmc_switch
Date: Thu, 1 Sep 2016 09:34:52 +0800
Message-ID: <f0fcbbef-8af7-780d-ddb2-42533b76c6d7@rock-chips.com>
References: <57C6A9D8.6020705@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:44326 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753524AbcIABfa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Aug 2016 21:35:30 -0400
In-Reply-To: <57C6A9D8.6020705@phytec.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wadim Egorov <w.egorov@phytec.de>, jh80.chung@samsung.com
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org

On 2016/8/31 17:56, Wadim Egorov wrote:
> Hello,
>
> I have a RK3288 based board with a Micron eMMC chip (MTFC16GAKAECN-4M
> IT). This eMMC is EDEC/MMC standard version 5.0-compliant.
>

By looking up the emmc AVL for rockchip product line, we didn't test
this eMMC chip yet, so I couldn't say whether it's related to the buggy
eMMC firmware rather than host stack. But it looks more like a buggy
firmware from my debug experience. :)

> While doing eMMC boot tests with a 4.4.16 and 4.8.0-rc4 kernel I run
> into the following problem after more than 100 cold resets:
>
> [    3.535448] dwmmc_rockchip ff0c0000.dwmmc: 1 slots initialized
> [    3.543823] dwmmc_rockchip ff0f0000.dwmmc: IDMAC supports 32-bit address mode.
> [    3.551276] dwmmc_rockchip ff0f0000.dwmmc: Using internal DMA controller.
> [    3.558206] dwmmc_rockchip ff0f0000.dwmmc: Version ID is 270a
> [    3.564275] dwmmc_rockchip ff0f0000.dwmmc: DW MMC controller at irq 31,32 bit host data width,256 deep fifo
> [    3.604426] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> [    3.634510] dwmmc_rockchip ff0f0000.dwmmc: 1 slots initialized
> [    3.645305] leds-pca953x 4-0062: setting platform data
> [    3.656675] ledtrig-cpu: registered to indicate activity on CPUs
> [    3.663200] usbcore: registered new interface driver usbhid
> [    3.668783] usbhid: USB HID core driver
> [    3.672674] usbcore: registered new interface driver r8188eu
> [    3.678393] usbcore: registered new interface driver rtl8723au
> [    3.699210] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
> [    3.900398] random: crng init done
> [    3.954089] NET: Registered protocol family 10
> [    3.974107] mmc0: Card stuck in programming state! __mmc_switch
> [    3.980027] mmc0: error -110 whilst initialising MMC card
>
>
> The bootloader I am using has no problems with the eMMC as you can see
> below:
>
> barebox@phycore-rk3288:/ devinfo mshc0
> Host information:
>   current clock: 52000000
>   current buswidth: 8
>   capabilities: 4bit 8bit sd-hs mmc-hs mmc-52MHz
> Card information:
>   Attached is a MMC card
>   Version: 4.0
>   Capacity: 14080 MiB
>   High capacity card
>    CID: 13014E52-314A3536-4C11616D-559BA2BD
>    CSD: D04F0132-0F5913FF-FFFFFFEF-8A4000BF
>   Max. transfer speed: 52000000 Hz
>   capabilities: 4bit mmc-hs mmc-52MHz
>   Manufacturer ID: 13
>   OEM/Application ID: 014E
>   Product name: 'R1J56'
>   Product revision: 4.12
>   Serial no: 1634555291
>   Manufacturing date: 10.1999
> Parameters:
>   boot: disabled ("disabled", "boot0", "boot1", "user")
>   nt_signature: 8a35eb82
>   probe: 0
>
> Any hints on what the problem could be?
>
> Regards,
> Wadim
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

