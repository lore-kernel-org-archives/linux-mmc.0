From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] sdio: Fix reference counting in sdio_remove_func()
Date: Wed, 2 Dec 2009 09:43:59 +0000
Message-ID: <20091202094359.GA6659@console-pimps.org>
References: <20091202092219.2AD329D404F@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:43994 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbZLBJmM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2009 04:42:12 -0500
Content-Disposition: inline
In-Reply-To: <20091202092219.2AD329D404F@zog.reactivated.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org

On Wed, Dec 02, 2009 at 09:22:19AM +0000, Daniel Drake wrote:
> sdio_remove_func() needs to be more careful about reference counting.
> It can be called in error paths where sdio_add_func() has never been called
> e.g. mmc_attach_sdio error path --> mmc_sdio_remove --> sdio_remove_func
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>

Reviewed-by: Matt Fleming <matt@console-pimps.org>

