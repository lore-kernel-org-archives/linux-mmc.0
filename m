From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tmio_mmc: Revise a limit of the data size
Date: Thu, 8 Jul 2010 14:46:47 -0700
Message-ID: <20100708144647.1e77364b.akpm@linux-foundation.org>
References: <4C33DFF0.3040804@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53669 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755325Ab0GHVr0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jul 2010 17:47:26 -0400
In-Reply-To: <4C33DFF0.3040804@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Wed, 07 Jul 2010 11:01:20 +0900
Yusuke Goda <yusuke.goda.sx@renesas.com> wrote:

> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> ---
>  drivers/mmc/host/tmio_mmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index ee7d0a5..cac1c97 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -661,7 +661,7 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
>  		 data->blksz, data->blocks);
> 
>  	/* Hardware cannot perform 1 and 2 byte requests in 4 bit mode */
> -	if (data->blksz < 4 && host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
> +	if (data->blksz < 2 && host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
>  		pr_err("%s: %d byte block unsupported in 4 bit mode\n",
>  		       mmc_hostname(host->mmc), data->blksz);
>  		return -EINVAL;

Again, please provide a suitable description for this change.
