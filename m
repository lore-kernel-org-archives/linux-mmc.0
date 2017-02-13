From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/4] mmc: host: tmio: fix minor typos in a comment
Date: Mon, 13 Feb 2017 13:39:43 +0100
Message-ID: <20170213123943.GA29718@verge.net.au>
References: <20170212111227.1550-1-wsa+renesas@sang-engineering.com>
 <20170212111227.1550-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170212111227.1550-3-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Sun, Feb 12, 2017 at 12:12:25PM +0100, Wolfram Sang wrote:
> Making sure we match the actual register name.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mmc/host/tmio_mmc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index b20b451ad90daa..8a4e99ffe64eb1 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -54,7 +54,7 @@
>  #define TMIO_STOP_STP		BIT(0)
>  #define TMIO_STOP_SEC		BIT(8)
>  
> -/* Definitions for values the CTRL_STATUS register can take. */
> +/* Definitions for values the CTL_STATUS register can take */
>  #define TMIO_STAT_CMDRESPEND    BIT(0)
>  #define TMIO_STAT_DATAEND       BIT(2)
>  #define TMIO_STAT_CARD_REMOVE   BIT(3)

Is a similar update for CTRL_STATUS2 appropriate a few lines further down?
