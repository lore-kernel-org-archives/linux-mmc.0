From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] sdhci: Rename SDHCI I/O accessor functions
Date: Wed, 28 Apr 2010 01:26:06 +0100
Message-ID: <20100428002606.GD24020@trinity.fluff.org>
References: <a2d0197b810b93814fe3ab8aa78fb0e721b9f08e.1272347885.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:37398 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652Ab0D1A0M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 27 Apr 2010 20:26:12 -0400
Content-Disposition: inline
In-Reply-To: <a2d0197b810b93814fe3ab8aa78fb0e721b9f08e.1272347885.git.matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>

On Tue, Apr 27, 2010 at 07:01:27AM +0100, Matt Fleming wrote:
> Unfortunately some architectures #define their read{b,w,l} and
> write{b,w,l} I/O accessors which makes the SDHCI I/O accessor functions
> of the same names subject to preprocessing. This leads to the following
> compiler error,
> 
> In file included from drivers/mmc/host/sdhci.c:26:
> drivers/mmc/host/sdhci.h:318:35: error: macro "writel" passed 3 arguments, but takes just 2
> 
> Rename the SDHCI I/O functions so that CONFIG_MMC_SDHCI_IO_ACCESSORS can
> be enabled for architectures that implement their read{b,w,l} and
> write{b,w,l} functions with macros.
> 
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Acked-by: Ben Dooks <ben-linux@fluff.org>

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

