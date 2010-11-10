From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH v2] mmc, sh: Move constants to sh_mmcif.h
Date: Wed, 10 Nov 2010 18:32:23 +0900
Message-ID: <20101110093223.GA369@linux-sh.org>
References: <20101109092952.01349C223F@yukiko.kent.sydney.vergenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:36421 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab0KJJcs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 04:32:48 -0500
Content-Disposition: inline
In-Reply-To: <20101109092952.01349C223F@yukiko.kent.sydney.vergenet.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>

On Tue, Nov 09, 2010 at 05:47:02PM +0900, Simon Horman wrote:
> This moves some constants from sh_mmcif.c to sh_mmcif.h
> so that they can be used in sh_mmcif_boot_init().
> 
> It also alters the definition of SOFT_RST_OFF from (0 << 31) to
> ~SOFT_RST_ON (= ~(1 << 31)). The former seems bogus.  The latter is
> consistent with the code in sh_mmcif_boot_init().
> 
> Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  drivers/mmc/host/sh_mmcif.c  |   23 -----------------------
>  include/linux/mmc/sh_mmcif.h |   39 ++++++++++++++++++++++++++++++++++-----
>  2 files changed, 34 insertions(+), 28 deletions(-)
> 
As this doesn't appear to introduce any bugfixes or functionality changes
I've queued it with the .38 changes. Its on its own topic branch for now,
but let me know if you have a dependency on this in future patches aimed
at the merge window and I'll make sure it ends up merged wherever its
needed.
