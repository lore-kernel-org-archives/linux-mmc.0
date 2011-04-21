From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC] MMC: Block: Ensure hardware partitions don't mess with mmcblk device naming.
Date: Thu, 21 Apr 2011 10:44:58 -0400
Message-ID: <m3pqofack5.fsf@pullcord.laptop.org>
References: <BANLkTik9s49HDYzmmeeFuaWU8bLYf67Cbg@mail.gmail.com>
	<1303366079-2196-1-git-send-email-andreiw@motorola.com>
	<BANLkTi=eZBEHrxAP36QAP8M7bkhw88uNGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41724 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859Ab1DUOkv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Apr 2011 10:40:51 -0400
In-Reply-To: <BANLkTi=eZBEHrxAP36QAP8M7bkhw88uNGQ@mail.gmail.com> (Andrei
	Warkentin's message of "Thu, 21 Apr 2011 03:17:25 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

Hi Andrei,

On Thu, Apr 21 2011, Andrei Warkentin wrote:
> Chris, unfortunately I am working OOF for next couple of days(I am
> happy I took my eMMC board with me), so I was not able to test second
> card (laptop only has 1 slot). Tested on your mmc tree with SDHCI and
> my MMC08G card. Would you mind testing above RFC change? Sorry again
> for the regression, grrrr.

Sure, happy to test.  No need to feel too bad about the regression,
we're very early on in preparation for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
