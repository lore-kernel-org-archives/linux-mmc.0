From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/5] mmc: mvsdio: use devm_ API to simplify/correct
 error paths.
Date: Tue, 22 Jan 2013 20:09:31 -0500
Message-ID: <20130123010931.GB1758@titan.lakedaemon.net>
References: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
 <1358342040-7130-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:65341 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750855Ab3AWBJu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jan 2013 20:09:50 -0500
Content-Disposition: inline
In-Reply-To: <1358342040-7130-2-git-send-email-andrew@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux@arm.linux.org.uk, linux-mmc@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Jan 16, 2013 at 02:13:56PM +0100, Andrew Lunn wrote:
> There are a number of bugs in the error paths of this driver.  Make
> use of devm_ functions to simplify the cleanup on error.
> 
> Based on a patch by Russell King.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/mmc/host/mvsdio.c |   92 +++++++++++++++------------------------------
>  1 file changed, 30 insertions(+), 62 deletions(-)

Applied to mvebu/fixes

thx,

Jason.
