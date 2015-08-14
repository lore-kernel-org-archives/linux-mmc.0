From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: block: disable the reliable write If the card does
 not support CMD23
Date: Fri, 14 Aug 2015 16:13:02 +0800
Message-ID: <55CDA30E.7030208@rock-chips.com>
References: <1439537446-7713-1-git-send-email-sdliyong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439537446-7713-1-git-send-email-sdliyong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sdliyong@gmail.com, chris@printf.net, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: shawn.lin@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

=D4=DA 2015/8/14 15:30, sdliyong@gmail.com =D0=B4=B5=C0:
> From: Yong Li <sdliyong@gmail.com>
>
> Signed-off-by: Yong Li <sdliyong@gmail.com>
> ---
>   drivers/mmc/card/block.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 452782b..d9e3c45 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1366,7 +1366,8 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue=
_req *mqrq,
>   	bool do_rel_wr =3D ((req->cmd_flags & REQ_FUA) ||
>   			  (req->cmd_flags & REQ_META)) &&
>   		(rq_data_dir(req) =3D=3D WRITE) &&
> -		(md->flags & MMC_BLK_REL_WR);
> +		(md->flags & MMC_BLK_REL_WR) &&
> +		!(card->quirks & MMC_QUIRK_BLK_NO_CMD23);

Hi Yong,

pls check that code below.

MMC_BLK_REL_WR will not be enabled if we know this card CANNOT support=20
CMD23 form SCR. AND=A3=AC "card->quirks & MMC_QUIRK_BLK_NO_CMD23" would=
 be=20
checked here as well. So I think your code is unnecessary.

if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->cmd.opcode) &&
	    (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23) ||
	     do_data_tag)) {
		brq->sbc.opcode =3D MMC_SET_BLOCK_COUNT;
		brq->sbc.arg =3D brq->data.blocks |
			(do_rel_wr ? (1 << 31) : 0) |
			(do_data_tag ? (1 << 29) : 0);
		brq->sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
		brq->mrq.sbc =3D &brq->sbc;
	}

Thanks.
Shawn

>
>   	memset(brq, 0, sizeof(struct mmc_blk_request));
>   	brq->mrq.cmd =3D &brq->cmd;
>


--=20
Shawn Lin
