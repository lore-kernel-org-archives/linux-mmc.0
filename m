From: Saeed Bishara <saeed@marvell.com>
Subject: RE: [PATCH v2 1/2] MMC: add support for the Marvell Dove SDHCI
	controller
Date: Wed, 27 Oct 2010 14:35:49 +0200
Message-ID: <FCBE654890C0334289D0AD3AF4EF009FE1475AA476@IL-MB01.marvell.com>
References: <cover.1288178148.git.mike@compulab.co.il>
 <b0ae564fec46432f6cb845f258f5940d3ed2008d.1288178148.git.mike@compulab.co.il>
 <20101027115641.GA17418@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:60360 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756397Ab0J0Mgm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Oct 2010 08:36:42 -0400
In-Reply-To: <20101027115641.GA17418@void.printf.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Mike Rapoport <mike@compulab.co.il>, Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <w.sang@pengutronix.de>

 
>
>Let's add a little text here -- something like "Implement an 
>sdhci-pltfm
>driver for the controller found on Marvell Dove and MMP SoCs" is fine.
This driver for Dove only. I think MMP uses sdhci-pxa. 
>
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> CC: Saeed Bishara <saeed@marvell.com>
>
>> ---
>>  drivers/mmc/host/Kconfig       |   13 +++++++
>>  drivers/mmc/host/Makefile      |    1 +
>>  drivers/mmc/host/sdhci-dove.c  |   72 
>++++++++++++++++++++++++++++++++++++++++
>>  drivers/mmc/host/sdhci-pltfm.c |    3 ++
>>  drivers/mmc/host/sdhci-pltfm.h |    1 +
>>  5 files changed, 90 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/mmc/host/sdhci-dove.c
>> 
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 68d1279..4958839 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -130,6 +130,19 @@ config MMC_SDHCI_CNS3XXX
>>  
>>  	  If unsure, say N.
>>  
>> +config MMC_SDHCI_DOVE
>> +	bool "SDHCI support on Marvell's Dove SoC"
>> +	depends on ARCH_DOVE
>
>The previous submission included ARCH_MMP, so I expect you'll want to
>resubmit with the extra dependency added once Saeed replies.
>
>> +	depends on MMC_SDHCI_PLTFM
>> +	select MMC_SDHCI_IO_ACCESSORS
>> +	help
>> +	  This selects the Secure Digital Host Controller Interface in
>> +	  Marvell's Dove SoC.
>> +
>> +	  If you have a controller with this interface, say Y or M here.
>> +
>> +	  If unsure, say N.
>> +
>>  config MMC_SDHCI_S3C
>>  	tristate "SDHCI support on Samsung S3C SoC"
>>  	depends on MMC_SDHCI && PLAT_SAMSUNG
>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>> index 840bcb5..9e1c418 100644
>> --- a/drivers/mmc/host/Makefile
>> +++ b/drivers/mmc/host/Makefile
>> @@ -40,6 +40,7 @@ obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
>>  obj-$(CONFIG_MMC_SDHCI_PLTFM)			+= 
>sdhci-platform.o
>>  sdhci-platform-y				:= sdhci-pltfm.o
>>  sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX)	+= sdhci-cns3xxx.o
>> +sdhci-platform-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
>>  
>>  obj-$(CONFIG_MMC_SDHCI_OF)	+= sdhci-of.o
>>  sdhci-of-y				:= sdhci-of-core.o
>> diff --git a/drivers/mmc/host/sdhci-dove.c 
>b/drivers/mmc/host/sdhci-dove.c
>> new file mode 100644
>> index 0000000..ac844d1
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-dove.c
>> @@ -0,0 +1,72 @@
>> +/*
>> + * sdhci-dove.c Support for SDHCI on Marvell's Dove SoC
>> + *
>> + * Author: Saeed Bishara <saeed@marvell.com>
>
>If Saeed is indeed the author of this code, the commit should be:
>   From: Saeed Bishara <saeed@marvell.com>
>rather than in your name.  (If it's not correct, it should be changed.)
This code partially based on a code that I previously sent. So I think it's enough to add Mike to the Author's list.
>
>> + * Based on  sdhci-cns3xxx.c
>> + *
>> + * This program is free software; you can redistribute it 
>and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> + */
>> +
>> +/* #include <linux/clk.h> */
>> +/* #include <linux/delay.h> */
>
>Please don't submit commented out code to mainline -- if these aren't
>needed, they should just be dropped.
>
>Thanks!
>
>-- 
>Chris Ball   <cjb@laptop.org>   <http://printf.net/>
>One Laptop Per Child
>