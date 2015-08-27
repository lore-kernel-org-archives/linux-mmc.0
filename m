From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Re: [v4,1/6] mmc: dt: add DT binding for big endian controller
Date: Thu, 27 Aug 2015 15:35:51 +0200
Message-ID: <CAPDyKFqteCuod9wztRUMYB1uNEBnHGTue_v6qCDmqN6XUio=Jw@mail.gmail.com>
References: <DM2PR0301MB0734002AABE322D7106D3AF6BA620@DM2PR0301MB0734.namprd03.prod.outlook.com>
	<BY1PR0301MB1192D64A16D187E5485796DCF2610@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<CAPDyKFpR=qbheQ8hJueAbHA_5f9kBDNb9_zqanGTna+1POhbdg@mail.gmail.com>
	<BY1PR0301MB11925C4491BEA2DC7ECB5C75F2600@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<CAPDyKFoYXEU+1k9nsdnrc2pUTgtN3-FvsPGVjDNYxwaEHOQmvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36634 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbbH0Nfx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2015 09:35:53 -0400
Received: by wicgk12 with SMTP id gk12so8955123wic.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2015 06:35:52 -0700 (PDT)
In-Reply-To: <CAPDyKFoYXEU+1k9nsdnrc2pUTgtN3-FvsPGVjDNYxwaEHOQmvA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Lu Y.B." <yangbo.lu@freescale.com>
Cc: Li Leo <LeoLi@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 27 August 2015 at 15:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>
>> What I had in mind is replacing in_be32() with a esdhc_ops->readl() in this function. And the esdhc_ops->readl() would be assigned at the beginning according endian.
>>
>> static u32 esdhc_readl(struct sdhci_host *host, int reg)
>> {
>>         u32 ret;
>>
>>         ret = in_be32(host->ioaddr + reg);
>>         /*
>>          * The bit of ADMA flag in eSDHC is not compatible with standard
>>          * SDHC register, so set fake flag SDHCI_CAN_DO_ADMA2 when ADMA is
>>          * supported by eSDHC.
>>          * And for many FSL eSDHC controller, the reset value of field
>>          * SDHCI_CAN_DO_ADMA1 is one, but some of them can't support ADMA,
>>          * only these vendor version is greater than 2.2/0x12 support ADMA.
>>          * For FSL eSDHC, must aligned 4-byte, so use 0xFC to read the
>>          * the verdor version number, oxFE is SDHCI_HOST_VERSION.
>>          */
>>         if ((reg == SDHCI_CAPABILITIES) && (ret & SDHCI_CAN_DO_ADMA1)) {
>>                 u32 tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
>>                 tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
>>                 if (tmp > VENDOR_V_22)
>>                         ret |= SDHCI_CAN_DO_ADMA2;
>>         }
>>
>>         return ret;
>> }
>>
>> The LE and BE accessors could be defined in sdhci-esdhc.h for esdhc_ops->readl() as below.
>> static u32 esdhc_be32bs_readl(struct sdhci_host *host, int reg)
>> {
>>        return ioread32be(host->ioaddr + reg);
>> }
>>
>> static u32 esdhc_le32bs_readl(struct sdhci_host *host, int reg)
>> {
>>        return ioread32(host->ioaddr + reg);
>> }
>>
>> Do you think it is ok for you?
>
> It becomes a bit "hacky", but currently I can't think of a better solution.
>
>>
>>
>> Or Maybe there is another method, use conditional compilation. The previous method would delete the MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER to use accessors defined in sdhci-esdhc.h, and add dependency of ARM. This method could use 'select <accessors> if <ARCH>' to compile LE or BE accessors according ARCH.
>
> I don't really follow your suggestion.
>
> Isn't the problem that you need the
> MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER for configurations and for
> some you don't? More precisely, for those where you don't you would
> rather just use the regulator ioread* functions since those will

/s/regulator/regular

> internally deal with the endianess in runtime?
>
> If you can make these decisions at compile time an depending of the
> ARCH - I believe I would be fine with that as well.
>
> [...]
>
> Kind regards
> Uffe
