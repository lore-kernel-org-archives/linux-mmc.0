From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH v2 1/2] MMC: add support for the Marvell Dove SDHCI	controller
Date: Wed, 27 Oct 2010 14:41:03 +0200
Message-ID: <4CC81DDF.3020400@compulab.co.il>
References: <cover.1288178148.git.mike@compulab.co.il> <b0ae564fec46432f6cb845f258f5940d3ed2008d.1288178148.git.mike@compulab.co.il> <20101027115641.GA17418@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:50325 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754846Ab0J0Mla (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Oct 2010 08:41:30 -0400
In-Reply-To: <20101027115641.GA17418@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Saeed Bishara <saeed@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>

On 10/27/10 13:56, Chris Ball wrote:
> Hi Mike, adding Wolfram to CC in case he has comments,
> 
> On Wed, Oct 27, 2010 at 01:21:58PM +0200, Mike Rapoport wrote:
>>
> 
> Let's add a little text here -- something like "Implement an sdhci-pltfm
> driver for the controller found on Marvell Dove and MMP SoCs" is fine.

Ok.

>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> CC: Saeed Bishara <saeed@marvell.com>
> 
>> ---
>>  drivers/mmc/host/Kconfig       |   13 +++++++
>>  drivers/mmc/host/Makefile      |    1 +
>>  drivers/mmc/host/sdhci-dove.c  |   72 ++++++++++++++++++++++++++++++++++++++++
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
> The previous submission included ARCH_MMP, so I expect you'll want to
> resubmit with the extra dependency added once Saeed replies.

I've understood Saeed's comment that he prefers to limit this to Dove only. I'll
add MMP if it'll also work with this driver.

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
>>  obj-$(CONFIG_MMC_SDHCI_PLTFM)			+= sdhci-platform.o
>>  sdhci-platform-y				:= sdhci-pltfm.o
>>  sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX)	+= sdhci-cns3xxx.o
>> +sdhci-platform-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
>>  
>>  obj-$(CONFIG_MMC_SDHCI_OF)	+= sdhci-of.o
>>  sdhci-of-y				:= sdhci-of-core.o
>> diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
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
> If Saeed is indeed the author of this code, the commit should be:
>    From: Saeed Bishara <saeed@marvell.com>
> rather than in your name.  (If it's not correct, it should be changed.)

Sure, indeed.
Saeed, shall I add your "Signed-off" as well?

>> + * Based on  sdhci-cns3xxx.c
>> + *
>> + * This program is free software; you can redistribute it and/or modify
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
> Please don't submit commented out code to mainline -- if these aren't
> needed, they should just be dropped.

will fix.

> Thanks!
> 


-- 
Sincerely yours,
Mike.
