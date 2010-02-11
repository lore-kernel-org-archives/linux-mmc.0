From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 0/3] mmc: omap_hsmmc: support SDIO cards
Date: Thu, 11 Feb 2010 12:12:08 +0000
Message-ID: <4B73F418.6070804@csr.com>
References: <cover.1265801967.git.david.vrabel@csr.com> <4B73BFD3.8090106@compulab.co.il> <4B73E59F.3020400@csr.com> <4B73ED3C.9010107@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:40951 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab0BKMM6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2010 07:12:58 -0500
In-Reply-To: <4B73ED3C.9010107@compulab.co.il>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com

Mike Rapoport wrote:
> 
> I've started to apply the patches one by one and after the first patch
> is applied, the SD card works Ok, but libertas fails to initialize with
> the following messages:
> 
>> modprobe libertas_sdio
> [   82.233489] lib80211: common routines for IEEE802.11 drivers
> [   82.833251] cfg80211: Calling CRDA to update world regulatory domain
> [   83.327911] libertas_sdio: Libertas SDIO driver
> [   83.332489] libertas_sdio: Copyright Pierre Ossman
> [   83.348510] libertas_sdio mmc1:0001:1: firmware: requesting
> sd8686_helper.bin
> [   83.497619] libertas_sdio mmc1:0001:1: firmware: requesting sd8686.bin
> [   83.679229] DMA synchronization event drop occurred with device 47

What block size are you using?  It looks like you're using something
less than 512. I've checked the spec again and the DMA packet size
should be the block size in words (and not the FIFO depth).

Also, keep in mind that the buffers for transfers must begin and end on
a word boundary.  The OMAP's DMA controller can only transfer whole
words to the MMC FIFO.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
