From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH 2/2] mmc: sdhci: Deal with failure case in
 sdhci_suspend_host
Date: Thu, 29 Dec 2011 10:32:16 +0800
Message-ID: <20111229023215.GA7182@ladygaga>
References: <1325041873-1320-1-git-send-email-aaron.lu@amd.com>
 <1325041873-1320-3-git-send-email-aaron.lu@amd.com>
 <4EFB0A44.5070006@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:33640
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750714Ab1L2CcZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Dec 2011 21:32:25 -0500
Content-Disposition: inline
In-Reply-To: <4EFB0A44.5070006@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

On Wed, Dec 28, 2011 at 02:23:32PM +0200, Adrian Hunter wrote:
> > -
> > -err_pci_suspend:
> > -	while (--i >= 0)
> > -		sdhci_resume_host(chip->slots[i]->host);
> > -	return ret;
> 
> This doesn't look right.  This is about having multiple
> host controllers on the same PCI device.  If those
> hosts have been successfully suspended, then they must
> be resumed on error.
>

You are right, I failed to understand the code.
Will send the patch again without touching the pci recover code, thanks.

> 
> >  }
> >


