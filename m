From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] mmc: sdhci - if MAX_CURRENT returns 0 try to use regulator to get current
Date: Wed, 27 Jun 2012 04:18:45 -0400
Message-ID: <87bok588wq.fsf@octavius.laptop.org>
References: <prakity@marvell.com>
	<1338169004-2122-1-git-send-email-prakity@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42046 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408Ab2F0ISt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Jun 2012 04:18:49 -0400
In-Reply-To: <1338169004-2122-1-git-send-email-prakity@marvell.com>
	(philipspatches@gmail.com's message of "Sun, 27 May 2012 18:36:44
	-0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: philipspatches@gmail.com
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, "Mark F. Brown" <mark.brown314@gmail.com>

Hi Philip,

On Sun, May 27 2012, philipspatches@gmail.com wrote:
> From: Philip Rakity <prakity@marvell.com>
>
> The sd host controller spec indicates the the MAX_CURRENT value may be
> returned as 0.  In this case other methods need to be used to return
> the current.  If 0 is returned and there is a regulator, ask the regulator
> for how much current is available.
>
> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Reviewed-by: Aaron Lu <aaron.lu@amd.com>

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
