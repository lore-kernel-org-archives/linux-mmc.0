From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdio: Fix to support any block size optimally
Date: Fri, 11 Nov 2011 19:47:55 -0500
Message-ID: <87hb2ajhdw.fsf@laptop.org>
References: <1319619137-17156-1-git-send-email-stefan.xk.nilsson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43379 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755053Ab1KLAr4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Nov 2011 19:47:56 -0500
In-Reply-To: <1319619137-17156-1-git-send-email-stefan.xk.nilsson@stericsson.com>
	(Stefan Nilsson's message of "Wed, 26 Oct 2011 10:52:17 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>

Hi Stefan,

On Wed, Oct 26 2011, Stefan Nilsson XK wrote:
> This patch allows any block size to be set on the SDIO link,
> and still have an arbitrary sized packet (adjusted in size by
> using sdio_align_size) transferred in an optimal way
> (preferably one transfer).
>
> Previously if the block size was larger than the default of
> 512 bytes and the transfer size was exactly one block size
> (possibly thanks to using sdio_align_size to get an optimal
> transfer size), it was sent as a number of byte transfers instead
> of one block transfer. Also if the number of blocks was
> (max_blocks * N) + 1, the tranfer would be conducted with a number
> of blocks and finished off with a number of byte transfers.
>
> When doing this change it was also possible to break out the quirk
> for broken byte mode in a much cleaner way, and collect the logic of
> when to do byte or block transfer in one function instead of two.
>
> Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

Pushed to mmc-next for 3.3, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
