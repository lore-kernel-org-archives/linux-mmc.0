From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/6] mmc: jz4740: Use clk_prepare_enable/clk_disable_unprepare
Date: Thu, 27 Jun 2013 11:40:38 -0400
Message-ID: <87fvw3o93d.fsf@octavius.laptop.org>
References: <1370805005-8104-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60343 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753958Ab3F0Pkl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 11:40:41 -0400
In-Reply-To: <1370805005-8104-1-git-send-email-lars@metafoo.de> (Lars-Peter
	Clausen's message of "Sun, 9 Jun 2013 21:10:00 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Paul Cercueil <paul@crapouillou.net>, Maarten ter Huurne <maarten@treewalker.org>, linux-mmc@vger.kernel.org

Hi Lars-Peter,

On Sun, Jun 09 2013, Lars-Peter Clausen wrote:
> In preparation to switching the jz4740 clk driver to the common clk framework
> update the clk enable/disable calls to clk_prepare_enable/clk_disable_unprepare.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks, all six patches pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
