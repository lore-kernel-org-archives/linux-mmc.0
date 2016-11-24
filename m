From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Thu, 24 Nov 2016 18:57:18 +0800
Message-ID: <f7334e41-39dd-f868-ff10-199afaebe926@marvell.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
 <2204525.IWIYQVjIXl@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2204525.IWIYQVjIXl@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, "Jack(SH) Zhu" <jmzhu@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Xueping Liu <xpliu@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Hi Arnd,

On 2016/11/24 17:56, Arnd Bergmann wrote:
> On Monday, October 31, 2016 12:09:56 PM CET Gregory CLEMENT wrote:
>> From: Ziji Hu <huziji@marvell.com>
>>
>> Marvell Xenon eMMC/SD/SDIO Host Controller contains PHY.
>> Three types of PHYs are supported.
>>
>> Add support to multiple types of PHYs init and configuration.
>> Add register definitions of PHYs.
>>
>> Signed-off-by: Hu Ziji <huziji@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>
> 
> Please explain in the changelog why this is not a generic
> phy driver (or three of them).
> 
	Actually we tried to put the PHY code into Linux PHY framework.
	But it cannot fit in Linux common PHY framework.

	Our Xenon SDHC PHY register is a part of Xenon SDHC register set.
	Besides, during MMC initialization, MMC sequence has to call several PHY functions to complete timing setting.
	In those PHY setting functions, they have to access SDHC register and know current MMC setting, such as bus width, clock frequency and speed mode.
	As a result, we have to implement PHY under MMC directory.

	Thank you.

Best regards,
Hu Ziji

> 	Arnd
> 
