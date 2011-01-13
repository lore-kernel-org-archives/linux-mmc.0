From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: drivers/mmc/host/sdhci-of-core.c on sparc64
Date: Thu, 13 Jan 2011 15:41:40 -0800
Message-ID: <20110113154140.7176df4c.akpm@linux-foundation.org>
References: <20110113151033.dbfd7524.akpm@linux-foundation.org>
	<20110113233828.GA21404@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56119 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752187Ab1AMXmK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jan 2011 18:42:10 -0500
In-Reply-To: <20110113233828.GA21404@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Thu, 13 Jan 2011 23:38:28 +0000
Chris Ball <cjb@laptop.org> wrote:

> On Thu, Jan 13, 2011 at 03:10:33PM -0800, Andrew Morton wrote:
> > drivers/mmc/host/sdhci-of-core.c:24:25: asm/machdep.h: No such file or directory
> > drivers/mmc/host/sdhci-of-core.c: In function `sdhci_of_wp_inverted':
> > drivers/mmc/host/sdhci-of-core.c:115: error: implicit declaration of function `machine_is'
> > 
> > That code's been there for a while.  Did someone change Kconfig?
> 
> Can you attach a .config?  <asm/machdep.h> is arch-specific, so I'd
> suggest that you're building on an unsupported arch.
> 

sparc64 allmodconfig.
