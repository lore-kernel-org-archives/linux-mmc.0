From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2 v3] Powerpc/eSDHC: Calculate the applicable mmc erase timeout value
Date: Sun, 25 Nov 2012 14:54:48 -0500
Message-ID: <87ip8t8nlj.fsf@octavius.laptop.org>
References: <1353303061-16679-1-git-send-email-Haijun.Zhang@freescale.com>
	<1353303061-16679-3-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53599 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753337Ab2KYTyw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Nov 2012 14:54:52 -0500
In-Reply-To: <1353303061-16679-3-git-send-email-Haijun.Zhang@freescale.com>
	(Haijun Zhang's message of "Mon, 19 Nov 2012 13:31:01 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>

Hi,

On Mon, Nov 19 2012, Haijun Zhang wrote:
> As large area erase needs long time usually a few minutes,
> which the host can't wait will bring about timeout error.
> So we need to split the large area to small sections which
> only need short erase time to avoid timeout error.
>
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
