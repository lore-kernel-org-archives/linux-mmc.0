From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCHv2 04/10] mmc: dw_mmc: use the hold register when send stop
 command
Date: Wed, 16 Nov 2016 17:09:15 +0800
Message-ID: <4a966587-7207-f4e6-d430-d4282af10f2f@rock-chips.com>
References: <20161115101232.3854-1-jh80.chung@samsung.com>
 <20161115101232.3854-5-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161115101232.3854-5-jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

ÔÚ 2016/11/15 18:12, Jaehoon Chung Ð´µÀ:
> If DW_MMC_CARD_NO_USE_HOLD isn't set, it's usesd by default.
> Enve if SDMMC_CMD_USB_HOLD_REG is set in prepare_command(), but it
> doesn't set in pre_stop_abort().
>
> To maintain the consistency, add the checking condition for this.

Actually I hacked the driver  w/ or w/o this patch to see how the
controller would do when looking at your V1.

Interesting, I didn't see failure when missing to set this...But
definitely it should be fixed.

Reviewed-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

>
> Signed-off-by: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index be36f48..3cda68c 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -337,6 +337,9 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
>  	cmdr = stop->opcode | SDMMC_CMD_STOP |
>  		SDMMC_CMD_RESP_CRC | SDMMC_CMD_RESP_EXP;
>
> +	if (!test_bit(DW_MMC_CARD_NO_USE_HOLD, &host->cur_slot->flags))
> +		cmdr |= SDMMC_CMD_USE_HOLD_REG;
> +
>  	return cmdr;
>  }
>
>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
