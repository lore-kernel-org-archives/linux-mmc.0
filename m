From: Phil Turmel <philip@turmel.org>
Subject: Re: [PATCH v6 0/3] Add modules to support realtek PCIE card reader
Date: Fri, 28 Sep 2012 21:00:04 -0400
Message-ID: <50664814.30407@turmel.org>
References: <cover.1347330871.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atl.turmel.org ([74.117.157.138]:38966 "EHLO atl.turmel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964989Ab2I2BP5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 28 Sep 2012 21:15:57 -0400
In-Reply-To: <cover.1347330871.git.wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: cjb@laptop.org, sameo@linux.intel.com, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com, bp@alien8.de

On 09/11/2012 12:54 AM, wei_wang@realsil.com.cn wrote:
> From: Wei WANG <wei_wang@realsil.com.cn>
> 
> Support for Realtek PCI-Express driver-based card readers including rts5209 and rts5229.
> 
> v2:
> 1. Using platform device to replace realtek slot bus
> 
> v3:
> 1. Fix a bug that DMA out of SW-IOMMU space in Lenovo Thinkpad x121e
> 2. Tested by Borislav Petkov <bp@alien8.de>
> 
> v4:
> 1. Fulfill power management callbacks
> 
> v5:
> 1. Support Memstick card
> 
> v6:
> 1. Fix some coding style
> 
> Wei WANG (3):
>   drivers/mfd: Add realtek pcie card reader driver
>   drivers/mmc: Add realtek pcie sdmmc host driver
>   drivers/memstick: Add realtek pcie memstick host driver

I have a recent HP Pavilion dv6 with this card reader, 10ec:5209
(rev 01).  I just applied these patches on top of 3.6-rc7.  Appears
to work properly with a SanDisk 8GB SDHC card.  I don't have a
memstick to test.

For patches 1 & 2, feel free to add my:

Tested-by: Philip J. Turmel <philip@turmel.org>

Regards,

Phil

