From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: Fix crash on boot with C0 stepping Moorestown
	platforms
Date: Tue, 9 Nov 2010 14:35:57 +0000
Message-ID: <20101109143557.GB7977@void.printf.net>
References: <20101109135708.21760.22164.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54754 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320Ab0KIOf6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Nov 2010 09:35:58 -0500
Content-Disposition: inline
In-Reply-To: <20101109135708.21760.22164.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-mmc@vger.kernel.org

Hi Alan,

On Tue, Nov 09, 2010 at 01:57:29PM +0000, Alan Cox wrote:
> Try again with the header fixed properly this time (thought I'd fixed it
> the last time - sorry)
> 
> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> SDHC2 is newly added in C0 stepping of Langwell. Without the Moorestown
> specific quirk, the default pci_probe will be called and crash the kernel.
> 
> This patch unblocks the crash problem on C0 by using the same probing
> function as HC1, which limits the number of slots to one.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Thanks, this is pushed and queued for 2.6.37 now.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
