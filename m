From: Chris Ball <cjb@laptop.org>
Subject: Re: drivers/mmc/host/sdhci-of-core.c on sparc64
Date: Thu, 13 Jan 2011 23:38:28 +0000
Message-ID: <20110113233828.GA21404@void.printf.net>
References: <20110113151033.dbfd7524.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41139 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757120Ab1AMXib (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 Jan 2011 18:38:31 -0500
Content-Disposition: inline
In-Reply-To: <20110113151033.dbfd7524.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org

On Thu, Jan 13, 2011 at 03:10:33PM -0800, Andrew Morton wrote:
> drivers/mmc/host/sdhci-of-core.c:24:25: asm/machdep.h: No such file or directory
> drivers/mmc/host/sdhci-of-core.c: In function `sdhci_of_wp_inverted':
> drivers/mmc/host/sdhci-of-core.c:115: error: implicit declaration of function `machine_is'
> 
> That code's been there for a while.  Did someone change Kconfig?

Can you attach a .config?  <asm/machdep.h> is arch-specific, so I'd
suggest that you're building on an unsupported arch.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
