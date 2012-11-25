From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] Powerpc eSDHC: Use u64 to calculate the timeout value to avoid overflow
Date: Sun, 25 Nov 2012 14:49:30 -0500
Message-ID: <87mwy58nud.fsf@octavius.laptop.org>
References: <1353303061-16679-1-git-send-email-Haijun.Zhang@freescale.com>
	<1353303061-16679-2-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47541 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367Ab2KYTtg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Nov 2012 14:49:36 -0500
In-Reply-To: <1353303061-16679-2-git-send-email-Haijun.Zhang@freescale.com>
	(Haijun Zhang's message of "Mon, 19 Nov 2012 13:31:00 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>

Hi,

On Mon, Nov 19 2012, Haijun Zhang wrote:
> As some mmc cards need large timeout value usually a few seconds,
> so data timeout nanosecond will overflow with u32 variable and
> give the wrong timeout value, so use u64 will be safe.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
