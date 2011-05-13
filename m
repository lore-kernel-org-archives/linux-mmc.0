From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 0/4] eMMC DDR support
Date: Fri, 13 May 2011 09:32:29 -0400
Message-ID: <m3mxiqvi8i.fsf@pullcord.laptop.org>
References: <1305265638-1572-1-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59284 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932345Ab1EMNaR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 May 2011 09:30:17 -0400
In-Reply-To: <1305265638-1572-1-git-send-email-arindam.nath@amd.com> (Arindam
	Nath's message of "Fri, 13 May 2011 11:17:14 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: linux-mmc@vger.kernel.org, prakity@marvell.com, zhangfei.gao@gmail.com

Hi Arindam,

On Fri, May 13 2011, Arindam Nath wrote:
> V2
> ----
> [PATCH 1/4]: Fixed tabbing for comment.
> [PATCH 2/4]: Use switch-case instead of if-else.
> [PATCH 3/4]: Use bool type for argument *cmd11* instead of int.
>
> Philip Rakity (4):
>   [PATCH 1/4]: sdhci add hooks for UHS setting by platform specific code
>   [PATCH 2/4]: sdhci-pxa add platform specific code for UHS signaling
>   [PATCH 3/4]: mmc eMMC signal voltage does not use CMD11
>   [PATCH 4/4]: mmc add support for eMMC Dual Data Rate
>
>  drivers/mmc/core/core.c      |   19 +++++--------------
>  drivers/mmc/core/core.h      |    5 ++---
>  drivers/mmc/core/mmc.c       |   35 ++++++++++++++++++++++++++++++-----
>  drivers/mmc/core/sd.c        |    5 +++--
>  drivers/mmc/host/sdhci-pxa.c |   41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c     |   33 ++++++++++++++++++---------------
>  drivers/mmc/host/sdhci.h     |    2 ++
>  include/linux/mmc/host.h     |    1 +
>  8 files changed, 102 insertions(+), 39 deletions(-)

Excellent, thanks -- pushed to mmc-next for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
