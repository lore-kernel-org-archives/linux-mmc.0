From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sh_mmcif: simplify bitmask macros
Date: Sat, 17 Mar 2012 11:38:56 -0400
Message-ID: <874ntn9qzz.fsf@laptop.org>
References: <Pine.LNX.4.64.1203161247360.13465@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1203161247360.13465@axis700.grange> (Guennadi
	Liakhovetski's message of "Fri, 16 Mar 2012 12:49:04 +0100 (CET)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Fri, Mar 16 2012, Guennadi Liakhovetski wrote:
> Purely cosmetic readability improvement, no functional change.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  include/linux/mmc/sh_mmcif.h |   21 +++++++++------------
>  1 files changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
> index b36caa9..c37956c 100644
> --- a/include/linux/mmc/sh_mmcif.h
> +++ b/include/linux/mmc/sh_mmcif.h
> @@ -71,18 +71,15 @@ struct sh_mmcif_plat_data {
>  
>  /* CE_CLK_CTRL */
>  #define CLK_ENABLE		(1 << 24) /* 1: output mmc clock */
> -#define CLK_CLEAR		((1 << 19) | (1 << 18) | (1 << 17) | (1 << 16))
> -#define CLK_SUP_PCLK		((1 << 19) | (1 << 18) | (1 << 17) | (1 << 16))
> -#define CLKDIV_4		(1<<16) /* mmc clock frequency.
> -					 * n: bus clock/(2^(n+1)) */
> -#define CLKDIV_256		(7<<16) /* mmc clock frequency. (see above) */
> -#define SRSPTO_256		((1 << 13) | (0 << 12)) /* resp timeout */
> -#define SRBSYTO_29		((1 << 11) | (1 << 10) |	\
> -				 (1 << 9) | (1 << 8)) /* resp busy timeout */
> -#define SRWDTO_29		((1 << 7) | (1 << 6) |		\
> -				 (1 << 5) | (1 << 4)) /* read/write timeout */
> -#define SCCSTO_29		((1 << 3) | (1 << 2) |		\
> -				 (1 << 1) | (1 << 0)) /* ccs timeout */
> +#define CLK_CLEAR		(0xf << 16)
> +#define CLK_SUP_PCLK		(0xf << 16)
> +#define CLKDIV_4		(1 << 16) /* mmc clock frequency.
> +					   * n: bus clock/(2^(n+1)) */
> +#define CLKDIV_256		(7 << 16) /* mmc clock frequency. (see above) */
> +#define SRSPTO_256		(2 << 12) /* resp timeout */
> +#define SRBSYTO_29		(0xf << 8) /* resp busy timeout */
> +#define SRWDTO_29		(0xf << 4) /* read/write timeout */
> +#define SCCSTO_29		(0xf << 0) /* ccs timeout */
>  
>  /* CE_VERSION */
>  #define SOFT_RST_ON		(1 << 31)

Thanks, pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
