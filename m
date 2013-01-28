From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: correct the EXCEPTION_EVENTS_STATUS vaule comment
Date: Mon, 28 Jan 2013 15:56:09 -0500
Message-ID: <87sj5l81sm.fsf@laptop.org>
References: <1A230AD7863570458C6CF2BE7CD6618B102BE5CB@SHSMSX102.ccr.corp.intel.com>
	<50EBD75F.7050805@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41829 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531Ab3A1U4r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Jan 2013 15:56:47 -0500
In-Reply-To: <50EBD75F.7050805@codeaurora.org> (Konstantin Dorfman's message
	of "Tue, 08 Jan 2013 10:22:55 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: "Zhang, YiX X" <yix.x.zhang@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On Tue, Jan 08 2013, Konstantin Dorfman wrote:
> May be it is worth to change all this struct comments to be:
>
> u8	raw_exception_status;	/* EXT_CSD_EXP_EVENTS_STATUS */
>
> This will reference actual offset value from "include/linux/mmc/mmc.h"

I think I prefer having the literal numbers accessible, even though it
duplicates data, so I've taken Zhang's original patch for now.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
