From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 0/3] mmc: omap_hsmmc: support SDIO cards
Date: Thu, 18 Feb 2010 18:06:09 +0000
Message-ID: <4B7D8191.4050809@csr.com>
References: <cover.1265801967.git.david.vrabel@csr.com> <4B73BFD3.8090106@compulab.co.il> <4B73E59F.3020400@csr.com> <4B7CE60D.1090904@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4B7CE60D.1090904@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com
List-Id: linux-mmc@vger.kernel.org

Mike Rapoport wrote:
> 
> Reverting this hunk and reverting/adjusting changes to IRQ handler makes
> SD card recognizable again. No luck with SDIO interrupts though...

Your card might need CLKEXTFREE enabled in MMCHSi_CON if it cannot
generate card interrupts asynchronously.  If that doesn't help you'll
have to see if one of the TI people has any suggestions.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
