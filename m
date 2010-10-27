From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] MMC: add support for the Marvell platform SDHCI controller
Date: Wed, 27 Oct 2010 11:17:27 +0200
Message-ID: <4CC7EE27.4030704@compulab.co.il>
References: <1288166860-28556-1-git-send-email-mike@compulab.co.il> <FCBE654890C0334289D0AD3AF4EF009FE1475AA356@IL-MB01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:48839 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760807Ab0J0JRx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Oct 2010 05:17:53 -0400
In-Reply-To: <FCBE654890C0334289D0AD3AF4EF009FE1475AA356@IL-MB01.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 10/27/10 10:46, Saeed Bishara wrote:
>  
>  
>> +config MMC_SDHCI_MV
>> +	bool "SDHCI support on Marvell's SoC"
>> +	depends on MMC_SDHCI
>> +	depends on MMC_SDHCI_PLTFM
>> +	select MMC_SDHCI_IO_ACCESSORS
>> +	help
>> +	  This selects the Secure Digital Host Controller Interface in
>> +	  Marvell's SoC controllers.
>> +
>> +	  If you have a controller with this interface, say Y or M here.
>> +
>> +	  If unsure, say N.
>> +
> Mike, the config name and description is too generic as there are several sdhci
> controllers on Marvell devices (see like pxa), I suggest to name it SDHCI_DOVE
> and make it depends on ARCH_DOVE and modify the description accordingly.

No problem. That said, no ARCH_MPP for now, like it was in [1]?

[1] http://marc.info/?l=linux-kernel&m=128458441031769&q=raw


>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +#include <linux/mmc/host.h>
>> +#include "sdhci.h"
>> +#include "sdhci-pltfm.h"
> are those includes are realy needed? At least the delay.h and clk.h not needed for now.
> 
> saeed


-- 
Sincerely yours,
Mike.
