From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V4 0/3] adding write_protect and card_detect for mx25/35
Date: Mon, 28 Feb 2011 15:55:40 -0500
Message-ID: <m3r5ar281f.fsf@pullcord.laptop.org>
References: <1298727881-12141-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54536 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754521Ab1B1U5S (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Feb 2011 15:57:18 -0500
In-Reply-To: <1298727881-12141-1-git-send-email-w.sang@pengutronix.de>
	(Wolfram Sang's message of "Sat, 26 Feb 2011 14:44:38 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Wolfram,

On Sat, Feb 26 2011, Wolfram Sang wrote:
> Last tests showed some problems with MX51, especially with card_detect. While
> the approach in general will suffice for i.MX5x, it seems there are a few
> details missing right now. Because I do not have the resources (both time and
> hardware) to deal with these issues, I propose a step by step approach. Let's
> add the functionality for mx25/35 first and make sure there is no difference in
> behaviour for mx5x. (Note that the i.MX5x can route the pins directly to the
> controller, so a properly designed board should not need these gpio-additions.)
> That is what this patch series does: The main change is that mx5x won't notice
> any difference. For mx25/35, it is the same as it has been tested by Eric and
> Marc.
>
> Thanks to all involved in providing feedback, I hope it can go in now. If you
> want to add support for it to your board, please CC me.

Thanks, pushed to mmc-next for .39 now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
