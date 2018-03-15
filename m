From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix falling from idmac to PIO mode when
 dw_mci_reset occurs
Date: Thu, 15 Mar 2018 10:57:32 +0100
Message-ID: <CAPDyKFrgBm8-G1CsnqS9G62xFA2qA0XkuGBfA5v6grZnjRLteA@mail.gmail.com>
References: <20180314193051.16791-1-Evgeniy.Didin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180314193051.16791-1-Evgeniy.Didin@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-snps-arc@lists.infradead.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

On 14 March 2018 at 20:30, Evgeniy Didin <Evgeniy.Didin@synopsys.com> wrote:
> It was found that in IDMAC mode after soft-reset driver switches
> to PIO mode.
>
> That's what happens in case of DTO timeout overflow calculation failure:
> 1. soft-reset is called
> 2. driver restarts dma
> 3. descriptors states are checked, one of descriptor is owned by the IDMAC.
> 4. driver can't use DMA and then switches to PIO mode.
>
> Failure was already fixed in:
> https://www.spinics.net/lists/linux-mmc/msg48125.html.

Evgeniy,

It seems like I should squash this fix into the above commit? Makes sense?

Kind regards
Uffe

>
> Behaviour while soft-reset is not something we except or
> even want to happen. So we switch from dw_mci_idmac_reset
> to dw_mci_idmac_init, so descriptors are cleaned before starting dma.
>
> And while at it explicitly zero des0 which otherwise might
> contain garbage as being allocated by dmam_alloc_coherent().
>
> Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: linux-snps-arc@lists.infradead.org
> ---
>  drivers/mmc/host/dw_mmc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0aa39975f33b..26f2ac107702 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -558,6 +558,7 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>                                         (sizeof(struct idmac_desc_64addr) *
>                                                         (i + 1))) >> 32;
>                         /* Initialize reserved and buffer size fields to "0" */
> +                       p->des0 = 0;
>                         p->des1 = 0;
>                         p->des2 = 0;
>                         p->des3 = 0;
> @@ -580,6 +581,7 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>                      i++, p++) {
>                         p->des3 = cpu_to_le32(host->sg_dma +
>                                         (sizeof(struct idmac_desc) * (i + 1)));
> +                       p->des0 = 0;
>                         p->des1 = 0;
>                 }
>
> @@ -1795,8 +1797,8 @@ static bool dw_mci_reset(struct dw_mci *host)
>         }
>
>         if (host->use_dma == TRANS_MODE_IDMAC)
> -               /* It is also recommended that we reset and reprogram idmac */
> -               dw_mci_idmac_reset(host);
> +               /* It is also required that we reinit idmac */
> +               dw_mci_idmac_init(host);
>
>         ret = true;
>
> --
> 2.11.0
>
