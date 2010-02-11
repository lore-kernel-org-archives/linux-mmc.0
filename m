From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 0/3] mmc: omap_hsmmc: support SDIO cards
Date: Thu, 11 Feb 2010 11:10:23 +0000
Message-ID: <4B73E59F.3020400@csr.com>
References: <cover.1265801967.git.david.vrabel@csr.com> <4B73BFD3.8090106@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:47535 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab0BKLL0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2010 06:11:26 -0500
In-Reply-To: <4B73BFD3.8090106@compulab.co.il>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com

Mike Rapoport wrote:
> Hi David,
> 
> David Vrabel wrote:
>> These patches add support for SDIO cards to the omap_hsmmc driver.  Less
>> restrictions on the sizes of transfers, power management changes to 
>> prevent SDIO cards from being turned off and losing all state, and card
>> interrupts.
>>
>> I've been unable to test these exact patches as I only have an N900 for 
>> testing and the N900 support in mainline is incomplete.
> 
> I've tried your patches on CM-T35 that has 8686 SDIO and the result was
> absence of MMC/SDIO devices at all :( Morover, kmmcd hangs:
> 
> [  399.427764] INFO: task kmmcd:149 blocked for more than 120 seconds.
> [...]
> [  399.485290] [<c01e6264>] (mmc_wait_for_cmd+0x64/0x74) from
> [<c01e86b0>] (mmc_go_idle+0x60/0xac)

I suspect interrupts aren't enabled correctly as this command does not
complete.  Try reverting this hunk.

@@ -426,12 +431,6 @@ omap_hsmmc_start_command(struct omap_hsmmc_host
*host, struct mmc_command *cmd,
                mmc_hostname(host->mmc), cmd->opcode, cmd->arg);
        host->cmd = cmd;

-       /*
-        * Clear status bits and enable interrupts
-        */
-       OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
-       OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
-
        if (host->use_dma)
                OMAP_HSMMC_WRITE(host->base, IE,
                                 INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE));

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
