From: Chris Ball <cjb@laptop.org>
Subject: Re: + mmc-make-id-freq-configurable-v5.patch added to -mm tree
Date: Wed, 8 Sep 2010 00:46:35 +0100
Message-ID: <20100907234635.GA27030@void.printf.net>
References: <201009072338.o87Ncnk7013457@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33253 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755991Ab0IGXqg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Sep 2010 19:46:36 -0400
Content-Disposition: inline
In-Reply-To: <201009072338.o87Ncnk7013457@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: hein_tibosch@yahoo.es, linux-mmc@vger.kernel.org, matt@console-pimps.org

Hi,

On Tue, Sep 07, 2010 at 04:38:49PM -0700, akpm@linux-foundation.org wrote:
> +				/*
> +				 * Try SDMEM (but not MMC) even if SDIO
> +				 * is broken.
> +				*/
>  				if (mmc_send_app_op_cond(host, 0, &ocr))
>  					goto out_fail;

Last line of the comment is missing a space.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
