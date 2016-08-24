From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/5] mmc: sunxi-mmc: change idma descriptor to __le32
Date: Wed, 24 Aug 2016 11:31:56 +0200
Message-ID: <CAPDyKFouYMjAajS68QRY6SvORQ1YZTf2dZsO_DtSJ+voKPWFdA@mail.gmail.com>
References: <20160822164219.14272-1-michael.weiser@gmx.de>
 <20160822164219.14272-5-michael.weiser@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160822164219.14272-5-michael.weiser@gmx.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michael Weiser <michael.weiser@gmx.de>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 22 August 2016 at 18:42, Michael Weiser <michael.weiser@gmx.de> wrote:
> The sunxi-mmc driver does not take into account the processor may be big
> endian when writing the DMA descriptors. This causes cards not to be
> detected when running a big-endian kernel. Change the descriptors for
> IDMA to use __le32 and ensure they are suitably swapped before writing.
> Tested successfully on the Cubieboard2.
>
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-mmc@vger.kernel.org

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 2ec91ce..a1935a1 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -223,10 +223,10 @@ struct sunxi_mmc_clk_delay {
>  };
>
>  struct sunxi_idma_des {
> -       u32     config;
> -       u32     buf_size;
> -       u32     buf_addr_ptr1;
> -       u32     buf_addr_ptr2;
> +       __le32 config;
> +       __le32 buf_size;
> +       __le32 buf_addr_ptr1;
> +       __le32 buf_addr_ptr2;
>  };
>
>  struct sunxi_mmc_cfg {
> @@ -329,22 +329,25 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
>         int i, max_len = (1 << host->cfg->idma_des_size_bits);
>
>         for (i = 0; i < data->sg_len; i++) {
> -               pdes[i].config = SDXC_IDMAC_DES0_CH | SDXC_IDMAC_DES0_OWN |
> -                                SDXC_IDMAC_DES0_DIC;
> +               pdes[i].config = cpu_to_le32(SDXC_IDMAC_DES0_CH |
> +                                            SDXC_IDMAC_DES0_OWN |
> +                                            SDXC_IDMAC_DES0_DIC);
>
>                 if (data->sg[i].length == max_len)
>                         pdes[i].buf_size = 0; /* 0 == max_len */
>                 else
> -                       pdes[i].buf_size = data->sg[i].length;
> +                       pdes[i].buf_size = cpu_to_le32(data->sg[i].length);
>
>                 next_desc += sizeof(struct sunxi_idma_des);
> -               pdes[i].buf_addr_ptr1 = sg_dma_address(&data->sg[i]);
> -               pdes[i].buf_addr_ptr2 = (u32)next_desc;
> +               pdes[i].buf_addr_ptr1 =
> +                       cpu_to_le32(sg_dma_address(&data->sg[i]));
> +               pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc);
>         }
>
> -       pdes[0].config |= SDXC_IDMAC_DES0_FD;
> -       pdes[i - 1].config |= SDXC_IDMAC_DES0_LD | SDXC_IDMAC_DES0_ER;
> -       pdes[i - 1].config &= ~SDXC_IDMAC_DES0_DIC;
> +       pdes[0].config |= cpu_to_le32(SDXC_IDMAC_DES0_FD);
> +       pdes[i - 1].config |= cpu_to_le32(SDXC_IDMAC_DES0_LD |
> +                                         SDXC_IDMAC_DES0_ER);
> +       pdes[i - 1].config &= cpu_to_le32(~SDXC_IDMAC_DES0_DIC);
>         pdes[i - 1].buf_addr_ptr2 = 0;
>
>         /*
> --
> 2.9.2
>
