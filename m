From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: Fix multiblock SDIO transfers in AT91 MCI
Date: Fri, 10 Dec 2010 16:23:51 +0000
Message-ID: <20101210162351.GA11798@void.printf.net>
References: <1290679911-5992-1-git-send-email-yauhen.kharuzhy@promwad.com> <4CEF9741.1010007@atmel.com> <4D024D25.2000501@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60602 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756549Ab0LJQYD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Dec 2010 11:24:03 -0500
Content-Disposition: inline
In-Reply-To: <4D024D25.2000501@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Nicolas,

On Fri, Dec 10, 2010 at 04:54:13PM +0100, Nicolas Ferre wrote:
> A little "ping"!
> 
> Do you want that I re-send you the patch with relevant S-O-B lines or
> you can include them yourself?

Thanks for the ping -- I've pushed this to mmc-next and queued it for
2.6.37 now.  This looks like a candidate for the stable kernel to me;
do you agree?

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
