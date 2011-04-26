From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] mmc: sdhci: add support for pre_req and post_req
Date: Tue, 26 Apr 2011 10:47:59 +0800
Message-ID: <20110426024758.GB6145@S2100-06.ap.freescale.net>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
 <1302972516-8673-1-git-send-email-shawn.guo@linaro.org>
 <BANLkTi=pqGyijbfuHD=uQzPnaYvNOQyzdg@mail.gmail.com>
 <4DB61F29.4090600@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:38193
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757907Ab1DZCnw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Apr 2011 22:43:52 -0400
Content-Disposition: inline
In-Reply-To: <4DB61F29.4090600@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Andrei Warkentin <andreiw@motorola.com>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, cjb@laptop.org, per.forlin@linaro.org, Kyungmin Park <kyungmin.park@samsung.com>

On Tue, Apr 26, 2011 at 10:26:01AM +0900, Jaehoon Chung wrote:
> Hi Shawn
> 
> I tested using ADMA with your patch...(benchmark : IOzone)
> But I didn't get improvement of performance with ADMA..
> (i can see improvement of performance with SDMA)
> 
> I want to know how you think about this..
> 
It's still an open question if pre_req and post_req were correctly
added, even you have seen improvement of SDMA case with IOzone.  I
would leave the question to Per Forlin.

With your result, I'm interested in trying IOzone test with esdhc
to see any difference with SDMA.

BTW, what is the number of performance improvement you are seeing?
And do you have mmc_test result to share?

-- 
Regards,
Shawn

