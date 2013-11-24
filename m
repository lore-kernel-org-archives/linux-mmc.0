From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 3/3] mmc: mvsdio: silence card detect notice
Date: Sun, 24 Nov 2013 12:07:18 -0500
Message-ID: <20131124170718.GJ29241@titan.lakedaemon.net>
References: <1384525354-901-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1384525354-901-4-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43806 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab3KXRH0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Nov 2013 12:07:26 -0500
Content-Disposition: inline
In-Reply-To: <1384525354-901-4-git-send-email-sebastian.hesselbarth@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Fri, Nov 15, 2013 at 03:22:34PM +0100, Sebastian Hesselbarth wrote:
> mvsdio reports method of card detection with dev_notice, while for
> removable cards it may be sane, for non-removable cards it is not.
> Also, as the user cannot do anything about it, silence the message
> by reducing it from dev_notice to dev_dbg.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/mmc/host/mvsdio.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
