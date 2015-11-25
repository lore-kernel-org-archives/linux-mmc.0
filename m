From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/2] mmc: mvsdio: delete platform data code path
Date: Wed, 25 Nov 2015 16:02:03 +0100
Message-ID: <20151125150203.GG11384@lunn.ch>
References: <1448459877-32626-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:41462 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbbKYPCF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 Nov 2015 10:02:05 -0500
Content-Disposition: inline
In-Reply-To: <1448459877-32626-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Wed, Nov 25, 2015 at 02:57:57PM +0100, Linus Walleij wrote:
> There are no in-kernel users of the MVSDIO platform data method
> (instantiating from a board file) so just delete this code and
> make this a DT-only driver. We depend on OF and check that we have
> an OF node in probe().
> 
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Looks good. I guess i would of reversed the order of these two patches
so you don't first add struct mvsdio_platform_data to the driver and
then remove it, but that is a minor nit pick.

Acked-by: Andrew Lunn <andrew@lunn.ch>
