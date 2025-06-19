Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACEE23ABAB
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750305791; cv=none; b=ed7DPRSrLwCMYM45UPwesguIdmuyXOtM3rCJycCeNOceIZDYd7TNIK/b8lH0jU9WUVd9sbTA66jDvIz3Bal9Qh+t8i/5f0CTWKI5HLUhMnHjP0hEF+YObtshs6dStE/HDISsWQ33M8oMjL3BmZuYh4aaaBGOXtnBMsGT756SQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750305791; c=relaxed/simple;
	bh=tKyuzDhBr7lG55mAhl9+jS7QPbpkvkugmspZdlU8ivw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcbVLkWI/LD1iFrsygSHbtUn0W2mxE7QVgowu5luNFlSY8sMy2qw+kZ2kwK60dIKnidbJCs3XxkGmhkseygDIJ5oDIJzgUL4PpV3UCLogrB3WNX2HV7uZDcJYZN9g7Hlxan3n/Jzi+AgCZGIfgDxKhEkEP7BQqNdShADt7SkQys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx7vgq9t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx7vgq9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18667C4CEEA
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 04:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750305791;
	bh=tKyuzDhBr7lG55mAhl9+jS7QPbpkvkugmspZdlU8ivw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qx7vgq9t/E29V0I7aLjuTzxSRfniVARZDVmTJ0MNF7peuAdyqzU/cs5002N8bbOA+
	 7Qy07DFwBYKxWLTULhT45FF1SsPQ9HfSdiotShv6/gNTvb7mgJhWVCwYdGwPju12G1
	 q1cKb0Z2F2KrrP2prXCLVtGdvuW6wtzErs/8vSIrB1Y/YufF+6lDdkNp+aJT7f2x/l
	 YXUVeQVzw5U0r0VRsU38yvCp3kzNH/CXACRBX1FUNpfTlJN4wTzTIHEUbjmjlqlXFa
	 YeC4qYmDPoQlWT9AQ1SLdAQRnlEzmaIcW+7PSZrNmo7ZDOnu7Cl2MU/hCeatA0T5UD
	 3weuZF/8EZEmA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-606b6dbe316so540160a12.3
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jun 2025 21:03:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCX6R+6zHNe8mHC4w54nswA7i4AOCzLTQwGtvY319/yZn9MR71gKUOMLvTpxliaNqjh/e6z8So/yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXa3qsgMBBor92VJw4PGWsWcRNn2Oq34tTuJJbtN+m/6+zw1j2
	ThNCozLPjoY2iHrZhOu2CxHfwAJmgt3LrkJAHoPOCkk83Y6S2x3QU/uK8wqInPYi0/fACQwgAxD
	F0XPioKsWRBbYOFHwOyja5M6sqksN0Qg=
X-Google-Smtp-Source: AGHT+IFKoTxUhOg3TL8cMBy6ogC7FtnFnLf+q7snpzq2zLEY0a/aQAZYYND1cz/yOW6y3gEdYW01um5JoPUJKCawBFc=
X-Received: by 2002:a05:6402:909:b0:607:19a6:9f1d with SMTP id
 4fb4d7f45d1cf-608d08aa3d4mr17052300a12.14.1750305789646; Wed, 18 Jun 2025
 21:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750216134.git.zhoubinbin@loongson.cn> <aa9cfb9707334cd2e56692397dd4f54c418262ce.1750216134.git.zhoubinbin@loongson.cn>
In-Reply-To: <aa9cfb9707334cd2e56692397dd4f54c418262ce.1750216134.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 19 Jun 2025 12:02:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5qHrfOApRBKinseMsZq7rS4QoznzzVFgjv8_EOivMW9w@mail.gmail.com>
X-Gm-Features: AX0GCFtz9DuXpq35x6XtyOuzb-wO9AXlrgCChZu1XTkqNFo-58zpjpxuBUF7fOo
Message-ID: <CAAhV-H5qHrfOApRBKinseMsZq7rS4QoznzzVFgjv8_EOivMW9w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC
 controller driver
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-mmc@vger.kernel.org, wanghongliang@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Binbin,

On Wed, Jun 18, 2025 at 4:08=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> This patch describes the two MMC controllers of the Loongson-2K2000 SoC,
> one providing an eMMC interface and the other exporting an SD/SDIO
> interface.
>
> Compared to the Loongson-2K1000's MMC controllers, their internals are
> similar, except that we use an internally exclusive DMA engine instead of
> an externally shared APBDMA engine.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/mmc/host/loongson2-mmc.c | 212 +++++++++++++++++++++++++++++++
>  1 file changed, 212 insertions(+)
>
> diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson=
2-mmc.c
> index 872f5dc21b21..75144221a821 100644
> --- a/drivers/mmc/host/loongson2-mmc.c
> +++ b/drivers/mmc/host/loongson2-mmc.c
> @@ -44,6 +44,18 @@
>  #define LOONGSON2_MMC_REG_DATA         0x40 /* Data Register */
>  #define LOONGSON2_MMC_REG_IEN          0x64 /* Interrupt Enable Register=
 */
>
> +/* EMMC DLL Mode Registers */
> +#define LOONGSON2_MMC_REG_DLLVAL       0xf0 /* DLL Master Lock-value Reg=
ister */
> +#define LOONGSON2_MMC_REG_DLLCTL       0xf4 /* DLL Control Register */
> +#define LOONGSON2_MMC_REG_DELAY                0xf8 /* DLL Delayed Param=
eter Register */
> +#define LOONGSON2_MMC_REG_SEL          0xfc /* Bus Mode Selection Regist=
er */
> +
> +/* Exclusive DMA R/W Registers */
> +#define LOONGSON2_MMC_REG_WDMA_LO      0x400
> +#define LOONGSON2_MMC_REG_WDMA_HI      0x404
> +#define LOONGSON2_MMC_REG_RDMA_LO      0x800
> +#define LOONGSON2_MMC_REG_RDMA_HI      0x804
> +
>  /* Bitfields of control register */
>  #define LOONGSON2_MMC_CTL_ENCLK                BIT(0)
>  #define LOONGSON2_MMC_CTL_EXTCLK       BIT(1)
> @@ -109,6 +121,9 @@
>  #define LOONGSON2_MMC_DSTS_RESUME      BIT(15)
>  #define LOONGSON2_MMC_DSTS_SUSPEND     BIT(16)
>
> +/* Bitfields of FIFO Status Register */
> +#define LOONGSON2_MMC_FSTS_TXFULL      BIT(11)
> +
>  /* Bitfields of interrupt register */
>  #define LOONGSON2_MMC_INT_DFIN         BIT(0)
>  #define LOONGSON2_MMC_INT_DTIMEOUT     BIT(1)
> @@ -136,6 +151,41 @@
>  #define LOONGSON2_MMC_IEN_ALL          GENMASK(9, 0)
>  #define LOONGSON2_MMC_INT_CLEAR                GENMASK(9, 0)
>
> +/* Bitfields of DLL master lock-value register */
> +#define LOONGSON2_MMC_DLLVAL_DONE      BIT(8)
> +
> +/* Bitfields of DLL control register */
> +#define LOONGSON2_MMC_DLLCTL_TIME      GENMASK(7, 0)
> +#define LOONGSON2_MMC_DLLCTL_INCRE     GENMASK(15, 8)
> +#define LOONGSON2_MMC_DLLCTL_START     GENMASK(23, 16)
> +#define LOONGSON2_MMC_DLLCTL_CLK_MODE  BIT(24)
> +#define LOONGSON2_MMC_DLLCTL_START_BIT BIT(25)
> +#define LOONGSON2_MMC_DLLCTL_TIME_BPASS        GENMASK(29, 26)
> +
> +#define LOONGSON2_MMC_DELAY_PAD                GENMASK(7, 0)
> +#define LOONGSON2_MMC_DELAY_RD         GENMASK(15, 8)
> +
> +#define LOONGSON2_MMC_SEL_DATA         BIT(0)  /* 0: SDR, 1: DDR */
> +#define LOONGSON2_MMC_SEL_BUS          BIT(0)  /* 0: EMMC, 1: SDIO */
> +
> +/* Internal dma controller registers */
> +
> +/* Bitfields of Global Configuration Register */
> +#define LOONGSON2_MMC_DMA_64BIT_EN     BIT(0) /* 1: 64 bit support */
> +#define LOONGSON2_MMC_DMA_UNCOHERENT_EN        BIT(1) /* 0: cache, 1: un=
cache */
> +#define LOONGSON2_MMC_DMA_ASK_VALID    BIT(2)
> +#define LOONGSON2_MMC_DMA_START                BIT(3) /* DMA start opera=
tion */
> +#define LOONGSON2_MMC_DMA_STOP         BIT(4) /* DMA stop operation */
> +#define LOONGSON2_MMC_DMA_CONFIG_MASK  GENMASK_ULL(4, 0) /* DMA controll=
er config bits mask */
> +
> +/* Bitfields of ndesc_addr field of HW descriptor */
> +#define LOONGSON2_MMC_DMA_DESC_EN      BIT(0) /*1: The next descriptor i=
s valid */
> +#define LOONGSON2_MMC_DMA_DESC_ADDR_LOW        GENMASK(31, 1)
> +
> +/* Bitfields of cmd field of HW descriptor */
> +#define LOONGSON2_MMC_DMA_INT          BIT(1)  /* Enable DMA interrupts =
*/
> +#define LOONGSON2_MMC_DMA_DATA_DIR     BIT(12) /* 1: write to device, 0:=
 read from device */
> +
>  /* Loongson-2K1000 SDIO2 DMA routing register */
>  #define LS2K1000_SDIO_DMA_MASK         GENMASK(17, 15)
>  #define LS2K1000_DMA0_CONF             0x0
> @@ -180,6 +230,8 @@ struct loongson2_mmc_host {
>         struct resource *res;
>         struct clk *clk;
>         u64 rate;
> +       void *sg_cpu;
> +       dma_addr_t sg_dma;
>         int dma_complete;
>         struct dma_chan *chan;
>         int cmd_is_stop;
> @@ -192,6 +244,7 @@ struct loongson2_mmc_host {
>  struct loongson2_mmc_pdata {
>         const struct regmap_config *regmap_config;
>         void (*reorder_cmd_data)(struct loongson2_mmc_host *host, struct =
mmc_command *cmd);
> +       void (*fix_data_timeout)(struct loongson2_mmc_host *host, struct =
mmc_command *cmd);
>         int (*setting_dma)(struct loongson2_mmc_host *host, struct platfo=
rm_device *pdev);
>         int (*prepare_dma)(struct loongson2_mmc_host *host, struct mmc_da=
ta *data);
>         void (*release_dma)(struct loongson2_mmc_host *host, struct devic=
e *dev);
> @@ -282,6 +335,9 @@ static void loongson2_mmc_send_request(struct mmc_hos=
t *mmc)
>                 return;
>         }
>
> +       if (host->pdata->fix_data_timeout)
> +               host->pdata->fix_data_timeout(host, cmd);
> +
>         loongson2_mmc_send_command(host, cmd);
>
>         /* Fix deselect card */
> @@ -426,6 +482,36 @@ static irqreturn_t loongson2_mmc_irq(int irq, void *=
devid)
>         return IRQ_WAKE_THREAD;
>  }
>
> +static void loongson2_mmc_dll_mode_init(struct loongson2_mmc_host *host)
> +{
> +       u32 val, pad_delay, delay, ret;
> +
> +       regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_SEL,
> +                          LOONGSON2_MMC_SEL_DATA, LOONGSON2_MMC_SEL_DATA=
);
> +
> +       val =3D FIELD_PREP(LOONGSON2_MMC_DLLCTL_TIME, 0xc8)
> +           | FIELD_PREP(LOONGSON2_MMC_DLLCTL_INCRE, 0x1)
> +           | FIELD_PREP(LOONGSON2_MMC_DLLCTL_START, 0x1)
> +           | FIELD_PREP(LOONGSON2_MMC_DLLCTL_CLK_MODE, 0x1)
> +           | FIELD_PREP(LOONGSON2_MMC_DLLCTL_START_BIT, 0x1)
> +           | FIELD_PREP(LOONGSON2_MMC_DLLCTL_TIME_BPASS, 0xf);
> +
> +       regmap_write(host->regmap, LOONGSON2_MMC_REG_DLLCTL, val);
> +
> +       ret =3D regmap_read_poll_timeout(host->regmap, LOONGSON2_MMC_REG_=
DLLVAL, val,
> +                                      (val & LOONGSON2_MMC_DLLVAL_DONE),=
 0, 4000);
> +       if (ret < 0)
> +               return;
> +
> +       regmap_read(host->regmap, LOONGSON2_MMC_REG_DLLVAL, &val);
> +       pad_delay =3D FIELD_GET(GENMASK(7, 1), val);
> +
> +       delay =3D FIELD_PREP(LOONGSON2_MMC_DELAY_PAD, pad_delay)
> +             | FIELD_PREP(LOONGSON2_MMC_DELAY_RD, pad_delay + 1);
> +
> +       regmap_write(host->regmap, LOONGSON2_MMC_REG_DELAY, delay);
> +}
> +
>  static void loongson2_mmc_set_clk(struct loongson2_mmc_host *host, struc=
t mmc_ios *ios)
>  {
>         u32 pre;
> @@ -438,6 +524,10 @@ static void loongson2_mmc_set_clk(struct loongson2_m=
mc_host *host, struct mmc_io
>
>         regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_CTL,
>                            LOONGSON2_MMC_CTL_ENCLK, LOONGSON2_MMC_CTL_ENC=
LK);
> +
> +       /* EMMC DLL mode setting */
> +       if (ios->timing =3D=3D MMC_TIMING_UHS_DDR50 || ios->timing =3D=3D=
 MMC_TIMING_MMC_DDR52)
> +               loongson2_mmc_dll_mode_init(host);
>  }
>
>  static void loongson2_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *=
ios)
> @@ -655,6 +745,127 @@ static struct loongson2_mmc_pdata ls2k1000_mmc_pdat=
a =3D {
>         .release_dma            =3D loongson2_mmc_release_external_dma,
>  };
>
> +static const struct regmap_config ls2k2000_mmc_regmap_config =3D {
> +       .reg_bits =3D 32,
> +       .val_bits =3D 32,
> +       .reg_stride =3D 4,
> +       .max_register =3D LOONGSON2_MMC_REG_RDMA_HI,
> +};
> +
> +static void ls2k2000_mmc_reorder_cmd_data(struct loongson2_mmc_host *hos=
t,
> +                                         struct mmc_command *cmd)
> +{
> +       struct scatterlist *sg;
> +       u32 *data;
> +       int i, j;
> +
> +       if (cmd->opcode !=3D SD_SWITCH || mmc_cmd_type(cmd) !=3D MMC_CMD_=
ADTC)
> +               return;
> +
> +       for_each_sg(cmd->data->sg, sg, cmd->data->sg_len, i) {
> +               data =3D sg_virt(&sg[i]);
> +               for (j =3D 0; j < (sg_dma_len(&sg[i]) / 4); j++)
> +                       data[j] =3D bitrev8x4(data[j]);
> +       }
> +}
> +
> +/*
> + * This is a controller hardware defect. Single/multiple block write com=
mands
> + * must be sent after the TX FULL flag is set, otherwise a data timeout =
interrupt
> + * will occur.
> + */
> +static void ls2k2000_mmc_fix_data_timeout(struct loongson2_mmc_host *hos=
t,
> +                                         struct mmc_command *cmd)
> +{
> +       int val;
> +
> +       if (cmd->opcode !=3D MMC_WRITE_BLOCK && cmd->opcode !=3D MMC_WRIT=
E_MULTIPLE_BLOCK)
> +               return;
> +
> +       regmap_read_poll_timeout(host->regmap, LOONGSON2_MMC_REG_FSTS, va=
l,
> +                                (val & LOONGSON2_MMC_FSTS_TXFULL), 0, 50=
0);
> +}
> +
> +static int loongson2_mmc_prepare_internal_dma(struct loongson2_mmc_host =
*host,
> +                                             struct mmc_data *data)
> +{
> +       struct loongson2_dma_desc *pdes =3D (struct loongson2_dma_desc *)=
host->sg_cpu;
> +       struct mmc_host *mmc =3D mmc_from_priv(host);
> +       dma_addr_t next_desc =3D host->sg_dma;
> +       struct scatterlist *sg;
> +       int reg_lo, reg_hi;
> +       u64 dma_order;
> +       int i, ret;
> +
> +       ret =3D dma_map_sg(mmc_dev(mmc), data->sg, data->sg_len,
> +                        mmc_get_dma_dir(data));
> +       if (!ret)
> +               return -ENOMEM;
> +
> +       for_each_sg(data->sg, sg, data->sg_len, i) {
> +               pdes[i].len =3D sg_dma_len(&sg[i]) / 4;
> +               pdes[i].step_len =3D 0;
> +               pdes[i].step_times =3D 1;
> +               pdes[i].mem_addr =3D lower_32_bits(sg_dma_address(&sg[i])=
);
> +               pdes[i].high_mem_addr =3D upper_32_bits(sg_dma_address(&s=
g[i]));
> +               pdes[i].apb_addr =3D host->res->start + LOONGSON2_MMC_REG=
_DATA;
> +               pdes[i].cmd =3D LOONGSON2_MMC_DMA_INT;
> +
> +               if (data->flags & MMC_DATA_READ) {
> +                       reg_lo =3D LOONGSON2_MMC_REG_RDMA_LO;
> +                       reg_hi =3D LOONGSON2_MMC_REG_RDMA_HI;
> +               } else {
> +                       pdes[i].cmd |=3D LOONGSON2_MMC_DMA_DATA_DIR;
> +                       reg_lo =3D LOONGSON2_MMC_REG_WDMA_LO;
> +                       reg_hi =3D LOONGSON2_MMC_REG_WDMA_HI;
> +               }
> +
> +               next_desc +=3D sizeof(struct loongson2_dma_desc);
> +               pdes[i].ndesc_addr =3D lower_32_bits(next_desc) |
> +                                    LOONGSON2_MMC_DMA_DESC_EN;
> +               pdes[i].high_ndesc_addr =3D upper_32_bits(next_desc);
> +       }
> +
> +       /* Setting the last descriptor enable bit */
> +       pdes[i - 1].ndesc_addr &=3D ~LOONGSON2_MMC_DMA_DESC_EN;
> +
> +       dma_order =3D (host->sg_dma & ~LOONGSON2_MMC_DMA_CONFIG_MASK) |
> +                   LOONGSON2_MMC_DMA_64BIT_EN |
> +                   LOONGSON2_MMC_DMA_START;
> +
> +       regmap_write(host->regmap, reg_hi, upper_32_bits(dma_order));
> +       regmap_write(host->regmap, reg_lo, lower_32_bits(dma_order));
> +
> +       return 0;
> +}
> +
> +static int loongson2_mmc_set_internal_dma(struct loongson2_mmc_host *hos=
t,
> +                                         struct platform_device *pdev)
> +{
> +       host->sg_cpu =3D dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
> +                                         &host->sg_dma, GFP_KERNEL);
> +       if (!host->sg_cpu)
> +               return -ENOMEM;
> +
> +       memset(host->sg_cpu, 0, PAGE_SIZE);
> +       return 0;
> +}
> +
> +static void loongson2_mmc_release_internal_dma(struct loongson2_mmc_host=
 *host,
> +                                              struct device *dev)
> +{
> +       dma_free_coherent(dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
> +}
> +
> +static struct loongson2_mmc_pdata ls2k2000_mmc_pdata =3D {
> +       .regmap_config          =3D &ls2k2000_mmc_regmap_config,
> +       .reorder_cmd_data       =3D ls2k2000_mmc_reorder_cmd_data,
> +       .fix_data_timeout       =3D ls2k2000_mmc_fix_data_timeout,
> +       .setting_dma            =3D loongson2_mmc_set_internal_dma,
> +       .prepare_dma            =3D loongson2_mmc_prepare_internal_dma,
> +       .release_dma            =3D loongson2_mmc_release_internal_dma,
> +};
From the whole series we get:

+static struct loongson2_mmc_pdata ls2k0500_mmc_pdata =3D {
+ .regmap_config =3D &ls2k1000_mmc_regmap_config,
+ .reorder_cmd_data =3D loongson2_mmc_reorder_cmd_data,
+ .setting_dma =3D ls2k0500_mmc_set_external_dma,
+ .prepare_dma =3D loongson2_mmc_prepare_external_dma,
+ .release_dma =3D loongson2_mmc_release_external_dma,
+};

+static struct loongson2_mmc_pdata ls2k1000_mmc_pdata =3D {
+ .regmap_config =3D &ls2k1000_mmc_regmap_config,
+ .reorder_cmd_data =3D loongson2_mmc_reorder_cmd_data,
+ .setting_dma =3D ls2k1000_mmc_set_external_dma,
+ .prepare_dma =3D loongson2_mmc_prepare_external_dma,
+ .release_dma =3D loongson2_mmc_release_external_dma,
+};

+static struct loongson2_mmc_pdata ls2k2000_mmc_pdata =3D {
+ .regmap_config =3D &ls2k2000_mmc_regmap_config,
+ .reorder_cmd_data =3D ls2k2000_mmc_reorder_cmd_data,
+ .fix_data_timeout =3D ls2k2000_mmc_fix_data_timeout,
+ .setting_dma =3D loongson2_mmc_set_internal_dma,
+ .prepare_dma =3D loongson2_mmc_prepare_internal_dma,
+ .release_dma =3D loongson2_mmc_release_internal_dma,
+};

The prefix of function names are confusing, can we rename them better?


Huacai




> +
>  static int loongson2_mmc_resource_request(struct platform_device *pdev,
>                                           struct loongson2_mmc_host *host=
)
>  {
> @@ -777,6 +988,7 @@ static void loongson2_mmc_remove(struct platform_devi=
ce *pdev)
>  static const struct of_device_id loongson2_mmc_of_ids[] =3D {
>         { .compatible =3D "loongson,ls2k0500-mmc", .data =3D &ls2k0500_mm=
c_pdata },
>         { .compatible =3D "loongson,ls2k1000-mmc", .data =3D &ls2k1000_mm=
c_pdata },
> +       { .compatible =3D "loongson,ls2k2000-mmc", .data =3D &ls2k2000_mm=
c_pdata },
>         { },
>  };
>  MODULE_DEVICE_TABLE(of, loongson2_mmc_of_ids);
> --
> 2.47.1
>
>
