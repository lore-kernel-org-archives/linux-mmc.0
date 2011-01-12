From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: bfin_sdh: fix alloc size for private data
Date: Wed, 12 Jan 2011 04:05:34 +0000
Message-ID: <20110112040532.GA28429@void.printf.net>
References: <1294803575-24087-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35209 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932791Ab1ALEFk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 Jan 2011 23:05:40 -0500
Content-Disposition: inline
In-Reply-To: <1294803575-24087-1-git-send-email-vapier@gentoo.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-mmc@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

Hi Mike, Sonic,

On Tue, Jan 11, 2011 at 10:39:35PM -0500, Mike Frysinger wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> The bfin_sdh driver allocates the wrong size for the private data
> in the mmc_host.  The first parameter of mmc_alloc_host should be
> the size of the local driver struct rather than the common mmc_host.
>  
> -	mmc = mmc_alloc_host(sizeof(*mmc), &pdev->dev);
> +	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);

Thanks, I'll add a stable tag and merge as a .38 fix.  Mind if we
use "mmc_alloc_host(sizeof(struct sdh_host), &pdev-dev);" instead?

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
