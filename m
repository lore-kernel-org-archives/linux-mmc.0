From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] SDHC2 is newly added in C0 stepping of Langwell.
	Without the Moorestown
Date: Fri, 15 Oct 2010 20:54:51 +0100
Message-ID: <20101015195451.GA18898@void.printf.net>
References: <20101015125553.14241.72148.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40235 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932485Ab0JOTyw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 Oct 2010 15:54:52 -0400
Content-Disposition: inline
In-Reply-To: <20101015125553.14241.72148.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-mmc@vger.kernel.org

On Fri, Oct 15, 2010 at 01:56:23PM +0100, Alan Cox wrote:
> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> specific quirk, the default pci_probe will be called and crash the kernel.
> 
> This patch unblocks the crash problem on C0 by using the same probing
> function as HC1, which limits the number of slots to one.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
 
Hi Alan -- could you resend this with a summary/subject line, please?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
