From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: mmc0: Invalid maximum block size, assuming 512 bytes
Date: Wed, 20 Jan 2016 09:17:51 +0800
Message-ID: <569EE03F.9090008@rock-chips.com>
References: <569E575A.5070401@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:57136 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934296AbcATBSK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2016 20:18:10 -0500
In-Reply-To: <569E575A.5070401@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mason <slash.tmp@free.fr>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: shawn.lin@rock-chips.com, Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Suman Tripathi <stripathi@apm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Frias <sf84@laposte.net>

On 2016/1/19 23:33, Mason wrote:
> Hello,
>
> My SoC provides an Arasan SDIO/eMMC controller supported by the
> drivers/mmc/host/sdhci-of-arasan.c driver.
>
> At init, the driver prints a warning to the console:
>
> [    0.887301] sdhci: Secure Digital Host Controller Interface driver
> [    0.893537] sdhci: Copyright(c) Pierre Ossman
> [    0.897928] sdhci-pltfm: SDHCI platform and OF driver helper
> [    0.903903] sdhci-arasan 21000.mmc: No vmmc regulator found
> [    0.909537] sdhci-arasan 21000.mmc: No vqmmc regulator found
> [    0.915247] mmc0: Invalid maximum block size, assuming 512 bytes
> [    0.953797] mmc0: SDHCI controller on 21000.mmc [21000.mmc] using ADMA
> [    0.961494] sdhci-arasan 21200.mmc: No vmmc regulator found
> [    0.967110] sdhci-arasan 21200.mmc: No vqmmc regulator found
>
> Is "mmc0: Invalid maximum block size, assuming 512 bytes" something
> serious which requires investigating, in your experience?
>

you can look into this commit 0633f654241
 From <SD host controller simplified specfication version 3.00>
sdhci doesn't support blocks of 4096 bytes.

But at least check my arasan-5.1 databook, it supports 4096 from
the capabilities register. So, you don't force arasan to use
SDHCI_QUIRK_FORCE_BLK_SZ_2048, then sdhci core force it to be 512 bytes.
Not serious problem, just a proper warn.

> The corresponding DT is:
>
> mmc0: mmc@21000 {
> 	compatible = "arasan,sdhci-8.9a";
> 	reg = <0x21000 0x200>;
> 	clock-names = "clk_xin", "clk_ahb";
> 	clocks = <&sdio_clk>, <&clkgen 1>;
> 	interrupts = <60 IRQ_TYPE_LEVEL_HIGH>;
> };
>
> Regards.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


-- 
Best Regards
Shawn Lin

