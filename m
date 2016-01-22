From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: mmc0: Invalid maximum block size, assuming 512 bytes
Date: Fri, 22 Jan 2016 10:07:58 +0800
Message-ID: <56A18EFE.6000900@rock-chips.com>
References: <569E575A.5070401@free.fr> <569EE03F.9090008@rock-chips.com>
 <56A0F2A1.3060805@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:37378 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbcAVCIV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2016 21:08:21 -0500
In-Reply-To: <56A0F2A1.3060805@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mason <slash.tmp@free.fr>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: shawn.lin@rock-chips.com, Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Suman Tripathi <stripathi@apm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Frias <sf84@laposte.net>

On 2016/1/21 23:00, Mason wrote:
> On 20/01/2016 02:17, Shawn Lin wrote:
>
>> On 2016/1/19 23:33, Mason wrote:
>>
>>> My SoC provides an Arasan SDIO/eMMC controller supported by the
>>> drivers/mmc/host/sdhci-of-arasan.c driver.
>>>
>>> At init, the driver prints a warning to the console:
>>>
>>> [    0.887301] sdhci: Secure Digital Host Controller Interface driver
>>> [    0.893537] sdhci: Copyright(c) Pierre Ossman
>>> [    0.897928] sdhci-pltfm: SDHCI platform and OF driver helper
>>> [    0.903903] sdhci-arasan 21000.mmc: No vmmc regulator found
>>> [    0.909537] sdhci-arasan 21000.mmc: No vqmmc regulator found
>>> [    0.915247] mmc0: Invalid maximum block size, assuming 512 bytes
>>> [    0.953797] mmc0: SDHCI controller on 21000.mmc [21000.mmc] using ADMA
>>> [    0.961494] sdhci-arasan 21200.mmc: No vmmc regulator found
>>> [    0.967110] sdhci-arasan 21200.mmc: No vqmmc regulator found
>>>
>>> Is "mmc0: Invalid maximum block size, assuming 512 bytes" something
>>> serious which requires investigating, in your experience?
>>
>> you can look into this commit 0633f654241
>>   From <SD host controller simplified specfication version 3.00>
>> sdhci doesn't support blocks of 4096 bytes.
>>
>> But at least check my arasan-5.1 databook, it supports 4096 from
>> the capabilities register. So, you don't force arasan to use
>> SDHCI_QUIRK_FORCE_BLK_SZ_2048, then sdhci core force it to be 512 bytes.
>> Not serious problem, just a proper warn.
>>
>>> The corresponding DT is:
>>>
>>> mmc0: mmc@21000 {
>>> 	compatible = "arasan,sdhci-8.9a";
>>> 	reg = <0x21000 0x200>;
>>> 	clock-names = "clk_xin", "clk_ahb";
>>> 	clocks = <&sdio_clk>, <&clkgen 1>;
>>> 	interrupts = <60 IRQ_TYPE_LEVEL_HIGH>;
>>> };
>
> Hello Shawn,
>
> Thanks for pointing out SDHCI_QUIRK_FORCE_BLK_SZ_2048.
>
> I don't think there is currently a way to enable this quirk
> for the Arasan controller from the device tree, right?

Right, no property available fot this.

>
> $ git grep SDHCI_QUIRK_FORCE_BLK_SZ_2048 drivers/mmc
> drivers/mmc/host/sdhci-bcm-kona.c:              SDHCI_QUIRK_FORCE_BLK_SZ_2048 |
> drivers/mmc/host/sdhci-esdhc.h:#define ESDHC_DEFAULT_QUIRKS     (SDHCI_QUIRK_FORCE_BLK_SZ_2048 | \
> drivers/mmc/host/sdhci.c:       if (host->quirks & SDHCI_QUIRK_FORCE_BLK_SZ_2048) {
> drivers/mmc/host/sdhci.h:#define SDHCI_QUIRK_FORCE_BLK_SZ_2048                  (1<<20)
>
> So that means I have to write code in
> drivers/mmc/host/sdhci-of-arasan.c correct?

It depends. If you think 512 block size if okay for you, leave it alone.
Otherwise, add it in drivers/mmc/host/sdhci-of-arasan.c :)



>
> Regards.
>
>
>
>


-- 
Best Regards
Shawn Lin

