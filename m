From: Chris Ball <cjb@laptop.org>
Subject: Re: + sdio-recognize-io-card-without-powercycle.patch added to -mm tree
Date: Sun, 20 Sep 2009 04:03:13 +0100
Message-ID: <20090920030311.GA21188@void.printf.net>
References: <200909132245.n8DMj4P5007763@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45990 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbZITDF0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 19 Sep 2009 23:05:26 -0400
Content-Disposition: inline
In-Reply-To: <200909132245.n8DMj4P5007763@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: albert_herranz@yahoo.es, linux-mmc@vger.kernel.org

Hi Andrew,

On Sun, Sep 13, 2009 at 03:45:04PM -0700, akpm@linux-foundation.org wrote:
> +++ a/drivers/mmc/core/core.c
> @@ -1073,6 +1073,7 @@ void mmc_rescan(struct work_struct *work
>  	mmc_claim_host(host);
>  
>  	mmc_power_up(host);
> +		sdio_reset(host);
>  	mmc_go_idle(host);

Looks like this hunk gained an extra tab on the way into -mm.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>
