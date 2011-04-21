From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] mmc: mxs-mmc: add support for pre_req and post_req
Date: Thu, 21 Apr 2011 14:29:25 +0800
Message-ID: <20110421062924.GB4024@S2100-06.ap.freescale.net>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
 <1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
 <20110417164830.GE17935@S2100-06.ap.freescale.net>
 <BANLkTimwvX633UaUoc4P4DD1xnpLbMTrZA@mail.gmail.com>
 <20110420140120.GF1965@S2100-06.ap.freescale.net>
 <BANLkTimzk89VC1Vti4CZ60TTJ20e2YpwNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:29643
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750799Ab1DUGZ1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 02:25:27 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimzk89VC1Vti4CZ60TTJ20e2YpwNg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, linaro-kernel@lists.linaro.org, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Wed, Apr 20, 2011 at 05:30:22PM +0200, Per Forlin wrote:
[...]
> Remove dma_map and dma_unmap from your host driver and run the tests
> (obviously nonblocking and blocking will have the same results). If
> there is still no performance gain the cache penalty is very small on
> your platform and therefore nonblocking doesn't improve things much.
> Please let me know the result.
> 
Sorry, I could not understand.  What's the point to run the test when
the driver is even broken.  The removal of  dma_map_sg and
dma_unmap_sg makes mxs-mmc host driver broken.

-- 
Regards,
Shawn

