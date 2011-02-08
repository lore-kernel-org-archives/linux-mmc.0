From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] [patch v3] tmio_mmc: Improve readability of the output
	of pr_debug_status()
Date: Tue, 8 Feb 2011 04:05:58 +0000
Message-ID: <20110208040555.GA7832@void.printf.net>
References: <1296856076-2387-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1296856076-2387-1-git-send-email-horms@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Simon,

On Sat, Feb 05, 2011 at 06:47:56AM +0900, Simon Horman wrote:
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h

Mind rebasing against Linus' tree or mmc-next?  Guennadi has merged
tmio_mmc.h into tmio_mmc.c there.

Once the patch applies, I'll merge it into mmc-next with a Reviewed-by:
line from Guennadi unless anyone objects.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
