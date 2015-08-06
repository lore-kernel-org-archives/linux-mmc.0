From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH v4 1/9] mmc: dw_mmc: Add external dma interface
 support
Date: Thu, 6 Aug 2015 15:26:20 +0800
Message-ID: <55C30C1C.6070801@rock-chips.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <1438843491-23853-1-git-send-email-shawn.lin@rock-chips.com>
 <55C307D4.1020209@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <55C307D4.1020209@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc: shawn.lin@rock-chips.com, heiko@sntech.de, dianders@chromium.org, Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>, Joachim Eastwood <manabian@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kukjin Kim <kgene@kernel.org>, Russell King <linux@arm.linux.org.uk>, Jun Nie <jun.nie@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, Govindraj Raja <govindraj.raja@imgtec.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2015/8/6 15:08, Krzysztof Kozlowski =E5=86=99=E9=81=93:
> On 06.08.2015 15:44, Shawn Lin wrote:
>> DesignWare MMC Controller can supports two types of DMA
>> mode: external dma and internal dma. We get a RK312x platform
>> integrated dw_mmc and ARM pl330 dma controller. This patch add
>> edmac ops to support these platforms. I've tested it on RK312x
>> platform with edmac mode and RK3288 platform with idmac mode.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v4:
>> - remove "host->trans_mode" and use "host->use_dma" to indicate
>>    transfer mode.
>> - remove all bt-bindings' changes since we don't need new properitie=
s.
>> - check transfer mode at runtime by reading HCON reg
>> - spilt defconfig changes for each sub-architecture
>> - fix the title of cover letter
> How did you fixed the title? It is still empty :)
> 	Subject: [RFC PATCH v4 0/9]
   I mentioned that in ChangeLog-v4 but unfortunately I forgot it.
   Thanks, Krzysztof.  I will be more careful and add it for next versi=
on.

>
>> - reuse some code for reducing code size
>>
>> Changes in v3:
>> - choose transfer mode at runtime
>> - remove all CONFIG_MMC_DW_IDMAC config option
>> - add supports-idmac property for some platforms
>>
>> Changes in v2:
>> - Fix typo of dev_info msg
>> - remove unused dmach from declaration of dw_mci_dma_slave
>>
>>   drivers/mmc/host/Kconfig        |  11 +-
>>   drivers/mmc/host/dw_mmc-pltfm.c |   2 +
>>   drivers/mmc/host/dw_mmc.c       | 258 ++++++++++++++++++++++++++++=
++++--------
>>   include/linux/mmc/dw_mmc.h      |  27 ++++-
>>   4 files changed, 232 insertions(+), 66 deletions(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 6a0f9c7..a86c0eb 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -607,15 +607,7 @@ config MMC_DW
>>   	help
>>   	  This selects support for the Synopsys DesignWare Mobile Storage=
 IP
>>   	  block, this provides host support for SD and MMC interfaces, in=
 both
>> -	  PIO and external DMA modes.
>> -
>> -config MMC_DW_IDMAC
>> -	bool "Internal DMAC interface"
>> -	depends on MMC_DW
>> -	help
>> -	  This selects support for the internal DMAC block within the Syno=
psys
>> -	  Designware Mobile Storage IP block. This disables the external D=
MA
>> -	  interface.
>> +	  PIO, internal DMA mode and external DMA modes.
>>  =20
>>   config MMC_DW_PLTFM
>>   	tristate "Synopsys Designware MCI Support as platform device"
>> @@ -644,7 +636,6 @@ config MMC_DW_K3
>>   	tristate "K3 specific extensions for Synopsys DW Memory Card Inte=
rface"
>>   	depends on MMC_DW
>>   	select MMC_DW_PLTFM
>> -	select MMC_DW_IDMAC
>>   	help
>>   	  This selects support for Hisilicon K3 SoC specific extensions t=
o the
>>   	  Synopsys DesignWare Memory Card Interface driver. Select this o=
ption
>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_m=
mc-pltfm.c
>> index ec6dbcd..7e1d13b 100644
>> --- a/drivers/mmc/host/dw_mmc-pltfm.c
>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>> @@ -59,6 +59,8 @@ int dw_mci_pltfm_register(struct platform_device *=
pdev,
>>   	host->pdata =3D pdev->dev.platform_data;
>>  =20
>>   	regs =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	/* Get registers' physical base address */
>> +	host->phy_regs =3D (void *)(regs->start);
>>   	host->regs =3D devm_ioremap_resource(&pdev->dev, regs);
>>   	if (IS_ERR(host->regs))
>>   		return PTR_ERR(host->regs);
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 40e9d8e..5d6cdff 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -56,7 +56,7 @@
>>   #define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
>>   #define DW_MCI_FREQ_MIN	400000		/* unit: HZ */
>>  =20
>> -#ifdef CONFIG_MMC_DW_IDMAC
>> +
>>   #define IDMAC_INT_CLR		(SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI | =
\
>>   				 SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
>>   				 SDMMC_IDMAC_INT_FBE | SDMMC_IDMAC_INT_RI | \
>> @@ -99,7 +99,6 @@ struct idmac_desc {
>>  =20
>>   	__le32		des3;	/* buffer 2 physical address */
>>   };
>> -#endif /* CONFIG_MMC_DW_IDMAC */
>>  =20
>>   static bool dw_mci_reset(struct dw_mci *host);
>>   static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
>> @@ -403,7 +402,6 @@ static int dw_mci_get_dma_dir(struct mmc_data *d=
ata)
>>   		return DMA_FROM_DEVICE;
>>   }
>>  =20
>> -#ifdef CONFIG_MMC_DW_IDMAC
>>   static void dw_mci_dma_cleanup(struct dw_mci *host)
>>   {
>>   	struct mmc_data *data =3D host->data;
>> @@ -441,12 +439,21 @@ static void dw_mci_idmac_stop_dma(struct dw_mc=
i *host)
>>   	mci_writel(host, BMOD, temp);
>>   }
>>  =20
>> -static void dw_mci_idmac_complete_dma(struct dw_mci *host)
>> +static void dw_mci_dmac_complete_dma(void *arg)
>>   {
>> +	struct dw_mci *host =3D arg;
> Why changing the argument to void*?

This function will be used as callback hook of dmaengine, and the=20
prototype is
"typedef void (*dma_async_tx_callback)(void *dma_async_param);".
w/o this change, we meet a warning  for incompatible pointer case.

>
> Best regards,
> Krzysztof
>
>>   	struct mmc_data *data =3D host->data;
>>  =20
>>   	dev_vdbg(host->dev, "DMA complete\n");
>>  =20
>> +	if (host->use_dma =3D=3D TRANS_MODE_EDMAC)
>> +		if (data && (data->flags & MMC_DATA_READ))
>> +			/* Invalidate cache after read */
>> +			dma_sync_sg_for_cpu(mmc_dev(host->cur_slot->mmc),
>> +					    data->sg,
>> +					    data->sg_len,
>> +					    DMA_FROM_DEVICE);
>> +
>>   	host->dma_ops->cleanup(host);
>
>
>
>


--=20
Shawn Lin
