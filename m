From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
Date: Mon, 22 Feb 2010 14:28:36 +0000
Message-ID: <4B829494.5000200@csr.com>
References: <cover.1265801967.git.david.vrabel@csr.com> <846fbf1a68cde5fd2d7c7ab084ace239c8de6867.1265801967.git.david.vrabel@csr.com> <f4f02c7875316b7f65466a5ac06f5b2b2960aa96.1265801967.git.david.vrabel@csr.com> <9ce6cf93ba1e6c3fd239f732ea5889a856948db3.1265801967.git.david.vrabel@csr.com> <008801cab1a7$36c49c70$544ff780@am.dhcp.ti.com> <00bd01cab1cd$4a452d20$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <00bd01cab1cd$4a452d20$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Madhusudhan wrote:
> 
> A little bit of rearranging the David's changes to the irq handler gets the
> MMC/SD cards to work fine again. Changes are shown in the attached patch for
> now and it should not hurt the CIRQ handling as well. 

This breaks detecting card interrupts unless a command is in progress.

>>> +	status = OMAP_HSMMC_READ(host->base, STAT);
>>> +	OMAP_HSMMC_WRITE(host->base, STAT, status);
>>> +	OMAP_HSMMC_READ(host->base, STAT); /* Flush posted write. */
>>> +
>>> +	if (status & CIRQ)
>>> +		card_irq = true;
>>> +
>>> +	if (host->mrq == NULL)
>>> +		goto out;
>>>
>>>  	data = host->data;
>>>  	status = OMAP_HSMMC_READ(host->base, STAT);

This line is the real problem.  We re-read MMCi_STAT after acknowledging
 (clearing) it.

Please see the version #2 of the patchset.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
