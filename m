From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Quirk for long data read time
Date: Fri, 11 Nov 2011 21:40:26 -0500
Message-ID: <87obwihxlx.fsf@laptop.org>
References: <1320309852-21893-1-git-send-email-stefan.xk.nilsson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36545 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481Ab1KLCk0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Nov 2011 21:40:26 -0500
In-Reply-To: <1320309852-21893-1-git-send-email-stefan.xk.nilsson@stericsson.com>
	(Stefan Nilsson's message of "Thu, 3 Nov 2011 09:44:12 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>

Hi,

On Thu, Nov 03 2011, Stefan Nilsson XK wrote:
> Adds a quirk that sets the data read timeout to a fixed value instead
> of relying on the information in the CSD. The timeout value choosen
> is 300ms since that has proven enough for the problematic cards found,
> but could be increased if other cards require this.
>
> This patch also enables this quirk for certain Micron cards known to
> have this problem.
>
> Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> ---
>  drivers/mmc/card/block.c |    7 +++++++
>  drivers/mmc/core/core.c  |   12 ++++++++++++
>  include/linux/mmc/card.h |    6 ++++++
>  3 files changed, 25 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 4fd5723..04af5e5 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1603,6 +1603,13 @@ static const struct mmc_fixup blk_fixups[] =
>  		  MMC_QUIRK_BLK_NO_CMD23),
>  	MMC_FIXUP("MMC32G", 0x11, CID_OEMID_ANY, add_quirk_mmc,
>  		  MMC_QUIRK_BLK_NO_CMD23),
> +
> +	/*
> +	 * Some Micron MMC cards needs longer data read timeout than
> +	 * indicated in CSD.
> +	 */
> +	MMC_FIXUP("", 0x13, 0x200, add_quirk_mmc, MMC_QUIRK_LONG_READ_TIME),

I think we should use CID_NAME_ANY instead of "", so I'll push that
change unless you object.  Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
