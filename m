From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 1/3] mmc: omap_hsmmc: use packet sync'd DMA
Date: Wed, 17 Feb 2010 17:47:26 +0000
Message-ID: <4B7C2BAE.4000008@csr.com>
References: <cover.1265801967.git.david.vrabel@csr.com> <846fbf1a68cde5fd2d7c7ab084ace239c8de6867.1265801967.git.david.vrabel@csr.com> <003601caaff5$9bf1e4d0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:55771 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab0BQRrx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2010 12:47:53 -0500
In-Reply-To: <003601caaff5$9bf1e4d0$544ff780@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

Madhusudhan wrote:
> 
>> -----Original Message-----
>> From: David Vrabel [mailto:david.vrabel@csr.com]
>> Sent: Wednesday, February 10, 2010 5:52 AM
>> To: linux-mmc@vger.kernel.org
>> Cc: David Vrabel; linux-omap@vger.kernel.org; madhu.cr@ti.com
>> Subject: [PATCH 1/3] mmc: omap_hsmmc: use packet sync'd DMA
>>
>> Use packet sync'd DMA in the omap_hsmmc driver to avoid the
>> restriction that transfers must be a multiple of the block size.  This
>> is required for byte-mode transfers to SDIO cards.
>>
> What is the typical scenario here? Is it IO_RW_EXTENDED with block_mode
> turned off? 

This patch isn't necessary.  With byte mode transfers you get a single
sg element and the transfer's block size is set to the length of the
transfer so frame sync mode works fine.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
