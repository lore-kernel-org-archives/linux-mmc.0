From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/2] mmc: fixes for eMMC v4.5 discard / sanitize operations
Date: Mon, 09 Apr 2012 13:49:55 -0400
Message-ID: <87aa2kyev0.fsf@laptop.org>
References: <1333626348-11170-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39718 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753710Ab2DIRuJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 Apr 2012 13:50:09 -0400
In-Reply-To: <1333626348-11170-1-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Thu, 5 Apr 2012 14:45:46 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, "Luca Porzio (lporzio)" <lporzio@micron.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kyungmin Park <kmpark@infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>

Hi,

On Thu, Apr 05 2012, Adrian Hunter wrote:
> Here are patches in response to the thread
> "mmc: card: move variable initialization earlier"
>
> The patches have not been tested on eMMC v4.5
> because I do not have one.  Consequently, these
> patches need an ack or tested-by someone who has
> one that supports discard and sanitize.
>
>
> Adrian Hunter (2):
>       mmc: fixes for eMMC v4.5 discard operation
>       mmc: fixes for eMMC v4.5 sanitize operation
>
>  drivers/mmc/card/block.c |   54 ++++++++++++++++++++++++++++++++-------------
>  drivers/mmc/card/queue.c |    2 +-
>  drivers/mmc/core/core.c  |    9 +++++--
>  3 files changed, 45 insertions(+), 20 deletions(-)

Thanks very much, Adrian, pushed to mmc-next with ACKs from Jaehoon
and Linus W.

I'm not sure whether to merge these for 3.4, or let them soak until
the 3.5 window opens given how scarce the 4.5 devices are.  Opinions
welcome; I'm thinking about waiting until 3.5 if no-one feels strongly.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
