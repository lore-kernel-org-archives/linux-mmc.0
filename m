From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 11/44] drivers/mmc: Remove unnecessary semicolons
Date: Sun, 5 Dec 2010 03:32:32 +0000
Message-ID: <20101205033232.GD24000@void.printf.net>
References: <cover.1289789604.git.joe@perches.com> <6391af02ba7ec4a76c5c5f462d8013fc1f52f999.1289789604.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42897 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473Ab0LEDcf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Dec 2010 22:32:35 -0500
Content-Disposition: inline
In-Reply-To: <6391af02ba7ec4a76c5c5f462d8013fc1f52f999.1289789604.git.joe@perches.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Jiri Kosina <trivial@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Joe,

On Sun, Nov 14, 2010 at 07:04:30PM -0800, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/mmc/host/davinci_mmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index e15547c..b643dde 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -480,7 +480,7 @@ static void mmc_davinci_send_dma_request(struct mmc_davinci_host *host,
>  	struct scatterlist	*sg;
>  	unsigned		sg_len;
>  	unsigned		bytes_left = host->bytes_left;
> -	const unsigned		shift = ffs(rw_threshold) - 1;;
> +	const unsigned		shift = ffs(rw_threshold) - 1;
>  
>  	if (host->data_dir == DAVINCI_MMC_DATADIR_WRITE) {
>  		template = &host->tx_template;
> -- 

Pushed to mmc-next for .38, thanks.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
