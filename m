From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] SDHC2 is newly added in C0 stepping of Langwell.
	Without the Moorestown
Date: Tue, 9 Nov 2010 14:06:33 +0000
Message-ID: <20101109140633.GA7449@void.printf.net>
References: <20101109112717.20502.57468.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39741 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823Ab0KIOGe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Nov 2010 09:06:34 -0500
Content-Disposition: inline
In-Reply-To: <20101109112717.20502.57468.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-mmc@vger.kernel.org

Hi Alan,

On Tue, Nov 09, 2010 at 11:27:19AM +0000, Alan Cox wrote:
> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> specific quirk, the default pci_probe will be called and crash the kernel.
> 
> This patch unblocks the crash problem on C0 by using the same probing
> function as HC1, which limits the number of slots to one.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>

You've submitted this one before, my reply was:

On Fri, Oct 15, 2010 at 08:54:51PM +0100, Chris Ball wrote:
> Hi Alan -- could you resend this with a summary/subject line, please?

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
