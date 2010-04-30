From: Matt Fleming <matt@console-pimps.org>
Subject: Re: + sdhci-rename-sdhci-i-o-accessor-functions.patch added to -mm
 tree
Date: Fri, 30 Apr 2010 07:38:17 +0100
Message-ID: <871vdxphra.fsf@linux-g6p1.site>
References: <201004292229.o3TMTQcA015391@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:52766 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758261Ab0D3RBV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Apr 2010 13:01:21 -0400
In-Reply-To: <201004292229.o3TMTQcA015391@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: cbouatmailru@gmail.com, linux-mmc@vger.kernel.org, zgao6@marvell.com, Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>, mm-commits@vger.kernel.org

On Thu, 29 Apr 2010 15:29:26 -0700, akpm@linux-foundation.org wrote:
> Subject: sdhci: build fix: rename SDHCI I/O accessor functions
> From: Matt Fleming <matt@console-pimps.org>
> 
> Unfortunately some architectures #define their read{b,w,l} and
> write{b,w,l} I/O accessors which makes the SDHCI I/O accessor functions of
> the same names subject to preprocessing.  This leads to the following
> compiler error,
> 
> In file included from drivers/mmc/host/sdhci.c:26:
> drivers/mmc/host/sdhci.h:318:35: error: macro "writel" passed 3 arguments, but takes just 2
> 
> Rename the SDHCI I/O functions so that CONFIG_MMC_SDHCI_IO_ACCESSORS can
> be enabled for architectures that implement their read{b,w,l} and
> write{b,w,l} functions with macros.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> Cc: Zhangfei Gao <zgao6@marvell.com>
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Hi Andrew,

this patch got a couple more ACKs from Wolfram Sang and Ben Dooks. Would
like me to respin the patch?

