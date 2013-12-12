From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc: mxs: Use mmc_of_parse
Date: Wed, 11 Dec 2013 20:39:36 -0500
Message-ID: <87y53q6e5j.fsf@octavius.laptop.org>
References: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56919 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab3LLBjk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Dec 2013 20:39:40 -0500
In-Reply-To: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de> (Sascha
	Hauer's message of "Thu, 5 Dec 2013 14:34:45 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Sascha,

On Thu, Dec 05 2013, Sascha Hauer wrote:
> We have a generic mmc_of_parse function. Use it in the mxs-mmc driver
> to make the code simpler and to parse some new devicetree propeties.

Great, thanks for doing this; all six patches pushed to mmc-next for 3.14.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
