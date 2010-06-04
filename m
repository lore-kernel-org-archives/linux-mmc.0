From: Chris Ball <cjb@laptop.org>
Subject: Re: + mmc-recognize-csd-structure.patch added to -mm tree
Date: Sat, 5 Jun 2010 00:12:26 +0100
Message-ID: <20100604231226.GA14477@void.printf.net>
References: <201006042236.o54MaLod022299@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51532 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757467Ab0FDXr4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Jun 2010 19:47:56 -0400
Content-Disposition: inline
In-Reply-To: <201006042236.o54MaLod022299@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org, kmpark@infradead.org, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org

Hi,

On Fri, Jun 04, 2010 at 03:36:21PM -0700, akpm@linux-foundation.org wrote:
> diff -puN drivers/mmc/core/mmc.c~mmc-recognize-csd-structure drivers/mmc/core/mmc.c
> --- a/drivers/mmc/core/mmc.c~mmc-recognize-csd-structure
> +++ a/drivers/mmc/core/mmc.c
> @@ -114,17 +114,18 @@ static int mmc_decode_cid(struct mmc_car
>  static int mmc_decode_csd(struct mmc_card *card)
>  {
>  	struct mmc_csd *csd = &card->csd;
> -	unsigned int e, m, csd_struct;
> +	unsigned int e, m;
>  	u32 *resp = card->raw_csd;
>  
>  	/*
>  	 * We only understand CSD structure v1.1 and v1.2.
>  	 * v1.2 has extra information in bits 15, 11 and 10.
> +	 * also support the for eMMC v4.4 & v4.41.
>  	 */

Minor typo here.  I suggest "We also support eMMC v4.4 & v4.41."

-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
