From: "Jan.Kloetzke@preh.de" <Jan.Kloetzke@preh.de>
Subject: Re: [RFT] mmc: tmio: fix CMD12 (STOP) handling
Date: Tue, 4 Jul 2017 09:13:18 +0000
Message-ID: <20170704091317.GC12202@kloetzke.dresden.tgr.local>
References: <20170703192823.8116-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170703192823.8116-1-wsa+renesas@sang-engineering.com>
Content-Language: de-DE
Content-ID: <2DDBAD540A71B541A6DF570294F6FEF9@tgr.local>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "Jan.Kloetzke@preh.de" <Jan.Kloetzke@preh.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>, Kouei Abe <kouei.abe.cp@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jul 03, 2017 at 09:28:23PM +0200, Wolfram Sang wrote:
> I always anticipated this code to be not correct, but now I had a test
> case to prove it. According to all documentation I have, setting the
> TMIO_STOP_STP bit ever only worked during block transfers. This bit is
> like manually enforcing an autocmd12 during a so far seamless transfer.
> It does NOT work when the block transfer had errors. It also does NOT
> work with any other cmd except block commands. For all those, CMD12 has
> to be treated like any other command. So, basically, we could use this
> bit only for mrq->data->stop cmds. But for these, we happily use the
> autocmd12 feature using the TMIO_STOP_SEC bit. As a result, the above
> bit is not useful for us and we need to treat CMD12 as a regular cmd
> always. Just remove the special handling code. Note that the BSP
> recognized this issue as well yet had a more cautious solution to the
> problem [1]. Which is understandable but makes CMD12 handling even more
> complicated.
> 
> Checked with a Renesas Salvator-X/M3-W which needed to send CMD12 when
> retuning one of my SD cards.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=2838a2ff8ca776f6d18b7fbbe75f3df8dd64183a
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> So, this is a friendly call for further testing to make sure no regressions
> happen. I also put the authors of the BSP patch to CC to check if this patch
> also matches their use case. I hope this is fine for these people, please
> accept my apologies if not. I just really like to have your opinion on this
> patch.

We've stumbled upon this issue some months ago and the patch below was
exactly the one that I came up with too. We've provided the feedback to
Renesas and they fixed it as [1]. As I'm laking proper data sheets for
the controller I was not able to judge it in depth, though.

Unfortunately I was not able to reproduce the original issue to test the
Renesas version [1] with enough confidence. What I can tell with
confidence is that the patch below does fix the issue that the driver
gets stuck on CMD12 and it did not have any further negative side
effects. So from my side (tested on RCar-M3):

Tested-by: Jan Klötzke <jan.kloetzke@preh.de>

Maybe someone from Reseas can comment on the rationale of their version
of the patch.

> 
> Geert, Simon: any chance you can run this patch on your board farms?
> 
> In any case: as far as my understanding goes, if I am wrong with my
> assumptions, the worst case is that for older SoCs CMD12 handling might become
> a tad more inefficient because we now do in software what was expected to be
> done in hardware. However, I am quite sure that the HW feature was always
> over-estimated and CMD12 support is simply broken. For my test case and the BSP
> patch above, it definately was.
> 
> Thanks for any assistance,
> 
>    Wolfram
> 
> 
>  drivers/mmc/host/tmio_mmc_core.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 1851c883bfc82a..fbcd56c58bce24 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -355,12 +355,6 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host,
>  	int c = cmd->opcode;
>  	u32 irq_mask = TMIO_MASK_CMD;
>  
> -	/* CMD12 is handled by hardware */
> -	if (cmd->opcode == MMC_STOP_TRANSMISSION && !cmd->arg) {
> -		sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, TMIO_STOP_STP);
> -		return 0;
> -	}
> -
>  	switch (mmc_resp_type(cmd)) {
>  	case MMC_RSP_NONE: c |= RESP_NONE; break;
>  	case MMC_RSP_R1:
> -- 
> 2.11.0
> 
