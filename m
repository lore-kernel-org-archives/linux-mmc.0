From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] MMC: use pci_dev->revision
Date: Fri, 18 Mar 2011 12:24:25 +0100
Message-ID: <20110318112425.GW18597@sunbeam.hmw-consulting.de>
References: <201103172108.45989.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from berligate.hmw-consulting.de ([83.236.178.202]:51781 "EHLO
	sunbeam.hmw-consulting.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752862Ab1CRLkI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Mar 2011 07:40:08 -0400
Content-Disposition: inline
In-Reply-To: <201103172108.45989.sshtylyov@ru.mvista.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, brucechang@via.com.tw, HaraldWelte@viatech.com

Hi Sergei,

On Thu, Mar 17, 2011 at 09:08:45PM +0300, Sergei Shtylyov wrote:
> The SDHCI driver uses PCI_CLASS_REVISION instead of PCI_REVISION_ID, so it was
> not converted by commit 44c10138fd4bbc4b6d6bff0873c24902f2a9da65 (PCI: Change
> all drivers to use pci_device->revision). The newer VIA driver has the similar
> code too. So convert both drivers to using the 'revision' field of 'struct
> pci_dev' now...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Acked-by: Harald Welte <HaraldWelte@viatech.com>
-- 
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
============================================================================
We all know Linux is great...it does infinite loops in 5 seconds. -- Linus
