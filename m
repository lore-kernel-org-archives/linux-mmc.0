From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] mmc: sdhci-esdhc-imx: Fix version register read
Date: Thu, 27 Jun 2013 11:30:16 -0400
Message-ID: <87zjubo9kn.fsf@octavius.laptop.org>
References: <1370438006-13093-1-git-send-email-l.stach@pengutronix.de>
	<1370441562.4279.9.camel@weser.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54559 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273Ab3F0PaU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 11:30:20 -0400
In-Reply-To: <1370441562.4279.9.camel@weser.hi.pengutronix.de> (Lucas Stach's
	message of "Wed, 05 Jun 2013 16:12:42 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, kernel@pengutronix.de

Hi Lucas,

On Wed, Jun 05 2013, Lucas Stach wrote:
> Please disregard this patch. I just realized that this was already sent
> out and the current upstream behavior is the result of discussion
> regarding this patch.

Thanks, I pushed patches 2 and 3 only to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
