From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCHv9 1/4] clk: socfpga: Add a clk-phase property to the "altr,socfpga-gate-clk"
Date: Fri, 10 Jan 2014 15:26:05 -0600
Message-ID: <52D0656D.6010307@gmail.com>
References: <1389303079-19808-1-git-send-email-dinguyen@altera.com> <003501cf0e06$9c194c50$d44be4f0$%jun@samsung.com> <1389369111.13556.29.camel@linux-builds1> <201401102000.25484.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:35709 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbaAJVZv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jan 2014 16:25:51 -0500
In-Reply-To: <201401102000.25484.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@altera.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, cjb@laptop.org, jh80.chung@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, mturquette@linaro.org, zhangfei.gao@linaro.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Arnd,

On 1/10/14 1:00 PM, Arnd Bergmann wrote:
> On Friday 10 January 2014, Dinh Nguyen wrote:
>>>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>>>> index f936476..e776512 100644
>>>> --- a/arch/arm/boot/dts/socfpga.dtsi
>>>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>>>> @@ -413,6 +413,7 @@
>>>>                                             compatible = "altr,socfpga-gate-clk";
>>>>                                             clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>,
>>>> <&per_nand_mmc_clk>;
>>>>                                             clk-gate = <0xa0 8>;
>>>> +                                           clk-phase = <0 135>;
>>> Can clk-phase be applicable commonly for various board?
>>> Isn't specific timing values?
>> No, the clock-phase does not change for various board. It is a
>> SoC-specific property.
> I'm curious about this: If the setting is fixed per soc, why is it even
> configurable, rather than hardwired to the correct setting, or set up
> by the boot loader?
Yes, I guess it can be hardwired, but currently it is not and the values
all default
to 0. The bootloader does set it up, but only when the system is booting
from
the SD/MMC source. When booting from other flash medium(i.e. NAND,
QSPI), these SD/MMC settings are not set, so they must be set by the OS
if SD/MMC is to work correctly.

Dinh
>
> 	Arnd

