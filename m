From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: fix checkpatch error and warnings
Date: Wed, 29 Aug 2012 06:36:18 -0400
Message-ID: <87txvmugrh.fsf@octavius.laptop.org>
References: <002701cd85a8$0c35e130$24a1a390$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49781 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021Ab2H2KgY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Aug 2012 06:36:24 -0400
In-Reply-To: <002701cd85a8$0c35e130$24a1a390$%han@samsung.com> (Jingoo Han's
	message of "Wed, 29 Aug 2012 14:35:06 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Ben Dooks' <ben-linux@fluff.org>

Hi,

On Wed, Aug 29 2012, Jingoo Han wrote:
> This patch fixes the checkpatch error and warnings listed below:
>
> ERROR: return is not a function, parentheses are not required
> WARNING: Prefer pr_err(... to printk(KERN_ERR, ...
> WARNING: quoted string split across lines
> WARNING: line over 80 characters
> WARNING: braces {} are not necessary for single statement blocks
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Thanks, pushed to mmc-next for 3.7 with Jaehoon's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
