From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 2/5] mmc: tmio: rename tmio_mmc_{pio => core}.c
Date: Tue, 9 May 2017 15:14:57 +0200
Message-ID: <20170509131457.GC13938@verge.net.au>
References: <1493723743-22821-1-git-send-email-horms+renesas@verge.net.au>
 <1493723743-22821-3-git-send-email-horms+renesas@verge.net.au>
 <20170502131132.gqg4uem2boborohm@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:44478 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbdEINQB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 May 2017 09:16:01 -0400
Content-Disposition: inline
In-Reply-To: <20170502131132.gqg4uem2boborohm@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Tue, May 02, 2017 at 03:11:32PM +0200, Wolfram Sang wrote:
> 
> > - * linux/drivers/mmc/host/tmio_mmc_pio.c
> > + * linux/drivers/mmc/host/tmio_mmc_core.c
> 
> I think we should drop the filenames here (and in other places)  and use
> a human readable string instead?

Sure, I've shuffled around the comments at the top of the source files
accordingly.
