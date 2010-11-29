From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/3] sh, mmc: Make mmcif_update_progress static inline
Date: Mon, 29 Nov 2010 12:55:06 +0900
Message-ID: <20101129035505.GA709@linux-sh.org>
References: <1290812579-20410-1-git-send-email-horms@verge.net.au> <1290812579-20410-3-git-send-email-horms@verge.net.au> <20101127000109.GA29427@verge.net.au> <20101127001155.GA30946@verge.net.au> <1290812579-20410-1-git-send-email-horms@verge.net.au> <1290812579-20410-2-git-send-email-horms@verge.net.au> <1290812579-20410-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:41614 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab0K2D4C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Nov 2010 22:56:02 -0500
Content-Disposition: inline
In-Reply-To: <20101127001155.GA30946@verge.net.au> <1290812579-20410-2-git-send-email-horms@verge.net.au> <1290812579-20410-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>

On Sat, Nov 27, 2010 at 08:02:57AM +0900, Simon Horman wrote:
> extern inline doesn't make much sense
> 
> Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

On Sat, Nov 27, 2010 at 08:02:58AM +0900, Simon Horman wrote:
> This resolves a regression that I introduced in
> "mmc, sh: Move constants to sh_mmcif.h". Having
> examined the manual and tested the code on an AP4EVB board
> it seems that the correct sequence is.
> 
> 1) Write 1 to bit 31 and zeros to all other bits
> 2) Write zero to all bits
> 
> Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

On Sat, Nov 27, 2010 at 09:11:55AM +0900, Simon Horman wrote:
> The 16-19th bits of CE_CLK_CTRL set the
> MMC clock frequency.
> 
> Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

Applied, thanks.
