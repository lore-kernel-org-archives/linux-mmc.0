From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] mmc: mvsdio: Replace IS_ERR_NULL() is with IS_ERR()
Date: Thu, 10 Jan 2013 15:49:31 -0500
Message-ID: <20130110204931.GP5075@titan.lakedaemon.net>
References: <1357849755-8168-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:52331 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750827Ab3AKAYw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jan 2013 19:24:52 -0500
Content-Disposition: inline
In-Reply-To: <1357849755-8168-1-git-send-email-andrew@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Jan 10, 2013 at 09:29:15PM +0100, Andrew Lunn wrote:
> A NULL is a valid clk cookie, so we should not be tested with
> IS_ERR_NULL(). Replace it with IS_ERR().
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/mmc/host/mvsdio.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The subject and commit entry should be IS_ERR_OR_NULL, but other than
that:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
