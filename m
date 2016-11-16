From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCHv2 01/10] mmc: dw_mmc: display the real register value on
 debugfs
Date: Wed, 16 Nov 2016 17:04:05 +0800
Message-ID: <8c985696-742c-5f93-9e47-2d709e3aee64@rock-chips.com>
References: <20161115101232.3854-1-jh80.chung@samsung.com>
 <20161115101232.3854-2-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161115101232.3854-2-jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

ÔÚ 2016/11/15 18:12, Jaehoon Chung Ð´µÀ:
> Developer wants to see the real register value, not register offset.
> This patch fixed to display the real value of register.
>

IIRC, you had submited some similar patch but I don't remember
why it wasn't merged?

Anyway,

Reviewed-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

> Signed-off-by: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a16c537..e53899e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -165,12 +165,14 @@ static const struct file_operations dw_mci_req_fops = {
>
>  static int dw_mci_regs_show(struct seq_file *s, void *v)
>  {
> -	seq_printf(s, "STATUS:\t0x%08x\n", SDMMC_STATUS);
> -	seq_printf(s, "RINTSTS:\t0x%08x\n", SDMMC_RINTSTS);
> -	seq_printf(s, "CMD:\t0x%08x\n", SDMMC_CMD);
> -	seq_printf(s, "CTRL:\t0x%08x\n", SDMMC_CTRL);
> -	seq_printf(s, "INTMASK:\t0x%08x\n", SDMMC_INTMASK);
> -	seq_printf(s, "CLKENA:\t0x%08x\n", SDMMC_CLKENA);
> +	struct dw_mci *host = s->private;
> +
> +	seq_printf(s, "STATUS:\t0x%08x\n", mci_readl(host, STATUS));
> +	seq_printf(s, "RINTSTS:\t0x%08x\n", mci_readl(host, RINTSTS));
> +	seq_printf(s, "CMD:\t0x%08x\n", mci_readl(host, CMD));
> +	seq_printf(s, "CTRL:\t0x%08x\n", mci_readl(host, CTRL));
> +	seq_printf(s, "INTMASK:\t0x%08x\n", mci_readl(host, INTMASK));
> +	seq_printf(s, "CLKENA:\t0x%08x\n", mci_readl(host, CLKENA));
>
>  	return 0;
>  }
>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
