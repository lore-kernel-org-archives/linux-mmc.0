From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH 4/10] MAINTAINERS: add entry for Marvell Xenon MMC Host
 Controller drivers
Date: Sat, 8 Oct 2016 08:59:57 +0800
Message-ID: <05c3c587-96ee-94e9-8508-54d048ab297a@marvell.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
 <86b237c01d9767d4e0edf6d41194ab959838e5c0.1475853198.git-series.gregory.clement@free-electrons.com>
 <1475873086.1945.20.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475873086.1945.20.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, "Jack(SH) Zhu" <jmzhu@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Xueping Liu <xpliu@marvell.com>, Hilbert Zhang <zzhang@marvell.com>, Liuliu Zhao <zhaoliul@marvell.com>, Peng Zhu <zhupeng@marvell.com>, Yu Cao <yuca>
List-Id: linux-mmc@vger.kernel.org

Hi Joe,

On 2016/10/8 4:44, Joe Perches wrote:
> On Fri, 2016-10-07 at 17:22 +0200, Gregory CLEMENT wrote:
>> Add maintainer entry for Marvell Xenon eMMC/SD/SDIO Host
>> Controller drivers.
> []
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> @@ -7578,6 +7578,11 @@ M:	Nicolas Pitre <nico@fluxnic.net>
>>  S:	Odd Fixes
>>  F:	drivers/mmc/host/mvsdio.*
>>  
>> +MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
>> +M:	Ziji Hu <huziji@marvell.com>
>> +L:	linux-mmc@vger.kernel.org
>> +S:	Supported
> 
> You should really add F: file patterns here
> 
	The specific file patterns will be added later when the corresponding file is included in patch.
	Otherwise, it cannot pass checkpatch.pl.

	Thank you.

Best regards,
Hu Ziji
