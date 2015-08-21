From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC PATCH v6 1/9] mmc: dw_mmc: Add external dma interface support
Date: Fri, 21 Aug 2015 16:38:41 +0900
Message-ID: <55D6D581.3050509@samsung.com>
References: <1440060204-26203-1-git-send-email-shawn.lin@rock-chips.com>
 <1440060233-26244-1-git-send-email-shawn.lin@rock-chips.com>
 <55D6C4D4.8010005@samsung.com> <55D6C57D.4070402@rock-chips.com>
 <55D6C6B6.3060706@samsung.com> <55D6D2EF.7010501@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:37956 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbbHUHis convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Aug 2015 03:38:48 -0400
In-reply-to: <55D6D2EF.7010501@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, ulf.hansson@linaro.org
Cc: Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>, Joachim Eastwood <manabian@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Russell King <linux@arm.linux.org.uk>, Zhangfei Gao <zhangfei.gao@linaro.org>, Jun Nie <jun.nie@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, Govindraj Raja <govindraj.raja@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de, dianders@chromium.org, linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, CPGS <cpgs@samsung.com>

On 08/21/2015 04:27 PM, Shawn Lin wrote:
> On 2015/8/21 14:35, Jaehoon Chung wrote:
>> On 08/21/2015 03:30 PM, Shawn Lin wrote:
>>> On 2015/8/21 14:27, Jaehoon Chung wrote:
>>>> Hi, Shawn.
>>>>
>>>> Is this based on Ulf's repository?
>>>
>>>
>>> no, it's based on "https://github.com/jh80chung/dw-mmc.git tags/dw-=
mmc-for-ulf-v4.2" =EF=BC=9A=EF=BC=89
>>
>> Oh..I will rebase to Ulf's next branch on this weekend.
>> Then could you rebase this patch? And i added more comments at below=
=2E. :)
>>
>=20
> Okay, I will rebase to Ulf's next.
>=20
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>=20
> [...]
>=20
>>>>> index ec6dbcd..7e1d13b 100644
>>>>> --- a/drivers/mmc/host/dw_mmc-pltfm.c
>>>>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>>>>> @@ -59,6 +59,8 @@ int dw_mci_pltfm_register(struct platform_devic=
e *pdev,
>>>>>        host->pdata =3D pdev->dev.platform_data;
>>>>>
>>>>>        regs =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>> +    /* Get registers' physical base address */
>>>>> +    host->phy_regs =3D (void *)(regs->start);
>>>>>        host->regs =3D devm_ioremap_resource(&pdev->dev, regs);
>>>>>        if (IS_ERR(host->regs))
>>>>>            return PTR_ERR(host->regs);
>>>>
>>>> Is this board specific code? If so, separate the patch.
>=20
> It's might not board specific code.
> dmaengine need dw_mmc's *physical* fifo address for data transfer, so=
 I get controller physical address  here in order to calculate physical=
 fifo address.
>=20
> regs is from dt-bindings, for instance:
>          dwmmc0@12200000 {
>                  compatible =3D "snps,dw-mshc";
>                   clocks =3D <&clock 351>, <&clock 132>;
>                  clock-names =3D "biu", "ciu";
>                  reg =3D <0x12200000 0x1000>;
>                  interrupts =3D <0 75 0>;
>                  #address-cells =3D <1>;
>                  #size-cells =3D <0>;
>          };
>=20
> so, host->phy_regs will be 0x12200000 .
>=20
> [...]
>=20
>>>>> +static void dw_mci_dmac_complete_dma(void *arg)
>>>>>    {
>>>>> +    struct dw_mci *host =3D arg;
>>>>>        struct mmc_data *data =3D host->data;
>>>>>
>>>>>        dev_vdbg(host->dev, "DMA complete\n");
>>>>>
>>>>> +    if (host->use_dma =3D=3D TRANS_MODE_EDMAC)
>>>>> +        if (data && (data->flags & MMC_DATA_READ))
>>>>
>>>> Combine one condition.
>=20
> okay.
>=20
> [...]
>=20
>>>>> +    u32 fifo_offset =3D host->fifo_reg - host->regs;
>>>>> +    int ret =3D 0;
>>>>> +
>>>>> +    /* Set external dma config: burst size, burst width */
>>>>> +    cfg.dst_addr =3D (dma_addr_t)(host->phy_regs + fifo_offset);
>>>>
>>>> host->phy_regs is not assigned?
>=20
> we got it at dw_mci_pltfm_register. See comments above. :)
>=20
> [...]
>=20
>>>>>            mmc->max_blk_count =3D mmc->max_req_size / 512;
>>>>> +    } else if (host->use_dma =3D=3D TRANS_MODE_EDMAC) {
>>>>> +            mmc->max_segs =3D 64;
>>>>> +            mmc->max_blk_size =3D 65536;
>>>>> +            mmc->max_blk_count =3D 65535;
>>>>> +            mmc->max_req_size =3D
>>>>> +                    mmc->max_blk_size * mmc->max_blk_count;
>>>>> +            mmc->max_seg_size =3D mmc->max_req_size;
>>>>
>>>> Fix the indention
>=20
> Hmm..I check it attentively but can't find the indention . Might it's=
 because you apply it against Ulf's repo?
>=20
>>>>
>=20
> [...]
>=20
>>>>>
>>>>> -    /* Alloc memory for sg translation */
>>>>> -    host->sg_cpu =3D dmam_alloc_coherent(host->dev, PAGE_SIZE,
>>>>> -                      &host->sg_dma, GFP_KERNEL);
>>>>> -    if (!host->sg_cpu) {
>>>>> -        dev_err(host->dev, "%s: could not alloc DMA memory\n",
>>>>> -            __func__);
>>>>> +    /* Check tansfer mode */
>>>>> +    trans_mode =3D SDMMC_GET_TRANS_MODE(mci_readl(host, HCON));
>>>>> +    if (trans_mode =3D=3D 0) {
>>>>> +        trans_mode =3D TRANS_MODE_IDMAC;
>>>>> +    } else if (trans_mode =3D=3D 1 || trans_mode =3D=3D 2) {
>>>>> +        trans_mode =3D TRANS_MODE_EDMAC;
>>>>> +    } else {
>>>>> +        trans_mode =3D TRANS_MODE_PIO;
>>>>
>>>> what are trans_mode "0, 1, 2"?
>>>> (00 - none) is NO-DMA interface, isn't? is it IDMAC mode?
>>>>
>=20
> No, I guess the databook's ambiguous description confuse everybody.
>=20
> I got double comfirm from my ASCI team as well as Synoposys
> 2b'00: NO-DMA interface -->  It support IDMAC actually
> 2b'01 & 2b'02: DW_DMA & GENERIC_DMA --> Support 2 types of external d=
ma.
> 2b'02: NON-DW-DMA --> only support PIO

Then Could you add the comment about this?
Use definition instead of "0, 1, 2". Developer don't know meaning that =
is 0, 1, 2.

Best Regards,
Jaehoon Chung

>=20
> refer to the description below:
> Parameter Name: DMA_INTERFACE
> Legal Values: 0-3
> Default Value: 0
> Description:
>  0- No DMA Interface
>  1- DesignWare DMA Interface
>  2- Generic DMA Interface
>  3- Non DW DMA Interface
> In DesignWare DMA mode, request/acknowledge protocol meets DW_ahb_dma=
c
> controller protocol. In this mode, host data bus is also used for DMA=
 transfers.Generic DMA-type interface has simpler request/acknowledge h=
andshake and has dedicated read/write data bus for DMA transfers. Non D=
W DMAC interface uses dw_dma_single interface in addition to the existi=
ng interface and uses host data bus for DMA transfers. This is configur=
able only if INTERNAL_DMAC=3D0.
>=20
>>>>>            goto no_dma;
>>>>>        }
>>
>>>>> +        dev_info(host->dev, "Using external DMA controller.\n");
>>>>> +    }
>>>>>
>>>>>        if (!host->dma_ops)
>>>>>            goto no_dma;
>>>>> @@ -2562,12 +2720,12 @@ static void dw_mci_init_dma(struct dw_mci=
 *host)
>>>>>            goto no_dma;
>>>>>        }
>>>>>
>>>>> -    host->use_dma =3D 1;
>>>>> +    host->use_dma =3D trans_mode;
>>>>
>>>> Also confuse, if trans_mode is assigned host->use_dma, can mode va=
lue be directly assigned to host->use_dma?
>>>>
>=20
> Good idea, I will do it.  :)
>=20
>>>> trans_mode =3D TRAMS_MODE_PIO;
>>>> host->use_dma =3D trans_mode;
>>>>
>=20
> [...]
>=20
>>>>>
>>>>> @@ -2890,7 +3047,7 @@ int dw_mci_probe(struct dw_mci *host)
>>>>>         * Get the host data width - this assumes that HCON has be=
en set with
>>>>>         * the correct values.
>>>>>         */
>>>>> -    i =3D (mci_readl(host, HCON) >> 7) & 0x7;
>>>>> +    i =3D SDMMC_GET_HDATA_WIDTH(mci_readl(host, HCON));
>>>>
>>>> This is not related with supporting external dma interface.
>>>> Separate this.
>>>>
>=20
> Okay, It will be split into another one.
>=20
>>>>>        if (!i) {
>>>>>            host->push_data =3D dw_mci_push_data16;
>>>>>            host->pull_data =3D dw_mci_pull_data16;
>=20
>=20
>=20

