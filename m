From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [RFC PATCH v5 1/9] mmc: dw_mmc: Add external dma interface
 support
Date: Mon, 17 Aug 2015 09:11:07 +0800
Message-ID: <55D134AB.80403@rock-chips.com>
References: <1439541232-30100-1-git-send-email-shawn.lin@rock-chips.com>
 <1439541275-30146-1-git-send-email-shawn.lin@rock-chips.com>
 <1522710.BT6Gc0L6oH@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1522710.BT6Gc0L6oH@diego>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexey Brodkin <abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Govindraj Raja <govindraj.raja-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2015/8/15 6:13, Heiko St=C3=BCbner =E5=86=99=E9=81=93:
> Hi Shawn,
>
> Am Freitag, 14. August 2015, 16:34:35 schrieb Shawn Lin:
>> DesignWare MMC Controller can supports two types of DMA
>> mode: external dma and internal dma. We get a RK312x platform
>> integrated dw_mmc and ARM pl330 dma controller. This patch add
>> edmac ops to support these platforms. I've tested it on RK312x
>> platform with edmac mode and RK3288 platform with idmac mode.
>>
>> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>
> judging by your "from", I guess you're running this on some older Roc=
kchip soc
> without the idma? Because I tried testing this on a Radxa Rock, but o=
nly got
> failures, from the start (failed to read card status register). In PI=
O mode
> everything works again.
>
>
> I guess I overlooked just some tiny detail, but to me the dma channel=
 ids seem
> correct after all. Maybe you have any hints what I'm doing wrong?
>

Thanks, HeiKo.

yes, I'm running a quite older low-end Rockchip soc w/o idma.

Hmm... from your failure to read CSR, I think generic DMA of Radxa Rock=
=20
was not runing properly. Your dma channel ids is correct, but it=20
certainly work on my platform=E3=80=82 I will try to find a Radxa Rock =
to=20
re-test my patch ASAP.



> diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx=
=2Edtsi
> index 4497d28..92d7156 100644
> --- a/arch/arm/boot/dts/rk3xxx.dtsi
> +++ b/arch/arm/boot/dts/rk3xxx.dtsi
> @@ -217,6 +217,8 @@
>                  interrupts =3D <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>                  clocks =3D <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
>                  clock-names =3D "biu", "ciu";
> +             dmas =3D <&dmac2 1>;
> +             dma-names =3D "rx-tx";
>                  fifo-depth =3D <256>;
>                  status =3D "disabled";
>          };
> @@ -227,6 +229,8 @@
>                  interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>                  clocks =3D <&cru HCLK_SDIO>, <&cru SCLK_SDIO>;
>                  clock-names =3D "biu", "ciu";
> +             dmas =3D <&dmac2 3>;
> +             dma-names =3D "rx-tx";
>                  fifo-depth =3D <256>;
>                  status =3D "disabled";
>          };
> @@ -237,6 +241,8 @@
>                  interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>                  clocks =3D <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
>                  clock-names =3D "biu", "ciu";
> +             dmas =3D <&dmac2 4>;
> +             dma-names =3D "rx-tx";
>                  fifo-depth =3D <256>;
>                  status =3D "disabled";
>          };
>
>
> [...]
>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index fcbf552..e01ead3 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2517,8 +2642,23 @@ static void dw_mci_cleanup_slot(struct dw_mci=
_slot
>> *slot, unsigned int id) static void dw_mci_init_dma(struct dw_mci *h=
ost)
>>   {
>>   	int addr_config;
>> +	int trans_mode;
>> +	struct device *dev =3D host->dev;
>> +	struct device_node *np =3D dev->of_node;
>> +
>> +	/* Check tansfer mode */
>> +	trans_mode =3D SDMMC_GET_TRANS_MODE(mci_readl(host, HCON));
>> +	if (trans_mode =3D=3D 0) {
>> +		trans_mode =3D TRANS_MODE_IDMAC;
>> +	} else if (trans_mode =3D=3D 1 || trans_mode =3D=3D 2) {
>> +		trans_mode =3D TRANS_MODE_EDMAC;
>> +	} else {
>> +		trans_mode =3D TRANS_MODE_PIO;
>> +		goto no_dma;
>> +	}
>> +
>>   	/* Check ADDR_CONFIG bit in HCON to find IDMAC address bus width =
*/
>> -	addr_config =3D (mci_readl(host, HCON) >> 27) & 0x01;
>> +	addr_config =3D SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON));
>>
>>   	if (addr_config =3D=3D 1) {
>>   		/* host supports IDMAC in 64-bit address mode */
>
> I guess the idmac address size checking block
>
>          /* Check ADDR_CONFIG bit in HCON to find IDMAC address bus w=
idth */
>          addr_config =3D SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON))=
;
>
>          if (addr_config =3D=3D 1) {
>                  /* host supports IDMAC in 64-bit address mode */
>                  host->dma_64bit_address =3D 1;
>                  dev_info(host->dev, "IDMAC supports 64-bit address m=
ode.\n");
>                  if (!dma_set_mask(host->dev, DMA_BIT_MASK(64)))
>                          dma_set_coherent_mask(host->dev, DMA_BIT_MAS=
K(64));
>          } else {
>                  /* host supports IDMAC in 32-bit address mode */
>                  host->dma_64bit_address =3D 0;
>                  dev_info(host->dev, "IDMAC supports 32-bit address m=
ode.\n");
>          }
>
> could either live inside the trans_mode =3D=3D 0 conditional above or=
 get its own
> if (trans_mode =3D=3D 0) conditional. Either way I guess it should no=
t talk about
> idmac when either pio or extdmac are used.
>
>
> Thanks
> Heiko
>
>
>


--=20
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
