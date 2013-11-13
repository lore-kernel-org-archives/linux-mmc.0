From: Jackey Shen <jackey.shen@amd.com>
Subject: Re: [PATCH V2] mmc: sdhci: supporting PCI MSI
Date: Wed, 13 Nov 2013 14:00:12 +0800
Message-ID: <20131113060011.GB3755@ubuntu.amd.com>
References: <1384239413-7027-1-git-send-email-Jackey.Shen@amd.com>
 <5281DC68.3080606@intel.com>
 <20131112092716.GA7285@ubuntu.amd.com>
 <5282CDE2.60500@intel.com>
 <20131113055508.GA3755@ubuntu.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:52216
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751505Ab3KMGBA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2013 01:01:00 -0500
Content-Disposition: inline
In-Reply-To: <20131113055508.GA3755@ubuntu.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: alexander.stein@systec-electronic.com, manuel.lauss@googlemail.com, hanfi@spahan.ch, linux-mmc@vger.kernel.org, mcuos.com@gmail.com, Ray.Huang@amd.com

On Wed, Nov 13, 2013 at 01:55:08PM +0800, Jackey Shen wrote:
> > >> What about we only call pci_enable_msi in sdhci-pci.c and then assign
> > >> host->irq appropriately before calling sdhci_add_host, will that work?
> > >> The only difference would be, request_irq will have SHARED flag, but I
> > >> suppose that's not a problem.
> > >>
> > > There are 2 points for this part:
> > > 1. fall back to legacy interrupt right after MSI request fails;
> > 
> > If we call pci_enable_msi somewhere in sdhci_pci_probe_slot, then if it
> > failed, we can also fall back I suppose?
> > 
> Yes, it is. 
> But, sdhci_pci_disable_msi should be kept since pci_disable_msi is
> pci bus releted and better not used in sdhci.c.
> So, enable msi and disable msi are NOT symmetric in style.
> What's your opinion?

Sorry for missing word.
So, enable msi and disable msi are NOT symmetric in style.

Thanks,
Jackey

 

