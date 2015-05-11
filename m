From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v3, 2/6] mmc: sdhci-pltfm: support both LE and BE mode for SDHCI platform
Date: Mon, 11 May 2015 12:15:03 +0200
Message-ID: <CAPDyKFr=1Yh9hgAV5b3To1ZCjkaG_+xbcwRByRkptZvoEfrM9Q@mail.gmail.com>
References: <1431067818-41378-1-git-send-email-yangbo.lu@freescale.com>
	<2093374.CPZJl41Uyy@wuerfel>
	<BY1PR0301MB1192096115DF67131BBE7BA1F2DB0@BY1PR0301MB1192.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33080 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbbEKKPD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 May 2015 06:15:03 -0400
Received: by qkx62 with SMTP id 62so83257803qkx.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2015 03:15:03 -0700 (PDT)
In-Reply-To: <BY1PR0301MB1192096115DF67131BBE7BA1F2DB0@BY1PR0301MB1192.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "yangbo.lu@freescale.com" <yangbo.lu@freescale.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>

On 11 May 2015 at 08:46, yangbo.lu@freescale.com
<yangbo.lu@freescale.com> wrote:
> Thanks.
> The drivers/mmc/host/sdhci-of-esdhc.c also have same struct.
> static const struct sdhci_ops sdhci_esdhc_ops = {
>         .read_l = esdhc_readl,
>         .read_w = esdhc_readw,
>         .read_b = esdhc_readb,
>         .write_l = esdhc_writel,
>         .write_w = esdhc_writew,
>         .write_b = esdhc_writeb,
>         .set_clock = esdhc_of_set_clock,
>         .enable_dma = esdhc_of_enable_dma,
>         .get_max_clock = esdhc_of_get_max_clock,
>         .get_min_clock = esdhc_of_get_min_clock,
>         .platform_init = esdhc_of_platform_init,
>         .adma_workaround = esdhci_of_adma_workaround,
>         .set_bus_width = esdhc_pltfm_set_bus_width,
>         .reset = esdhc_reset,
>         .set_uhs_signaling = esdhc_set_uhs_signaling,
> };
>
> Do you mean defining functions for little-endian and big-endian separately in sdhci-pltm.c?
> But it seems to need adding much code in drivers/mmc/host/sdhci-of-esdhc.c if don't use run-time checks.

On the other hand it will give you an optimized execution path. It's
better to check it once in ->probe() once, instead of every time.

Kind regards
Uffe

>
>
> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Friday, May 08, 2015 3:41 PM
> To: Lu Yangbo-B47093
> Cc: linux-mmc@vger.kernel.org; chris@printf.net; ulf.hansson@linaro.org
> Subject: Re: [v3, 2/6] mmc: sdhci-pltfm: support both LE and BE mode for SDHCI platform
>
> On Friday 08 May 2015 14:50:18 Yangbo Lu wrote:
>> -static inline u32 sdhci_be32bs_readl(struct sdhci_host *host, int
>> reg)
>> +static inline void sdhci_clrsetbits(struct sdhci_host *host, u32 mask,
>> +                                   u32 val, int reg)
>>  {
>> -       return in_be32(host->ioaddr + reg);
>> +       void __iomem *base = host->ioaddr + (reg & ~0x3);
>> +       u32 shift = (reg & 0x3) * 8;
>> +
>> +       if (host->mmc->big_endian_mode)
>> +               iowrite32be(((ioread32be(base) & ~(mask << shift)) |
>> +                           (val << shift)), base);
>> +       else
>> +               iowrite32(((ioread32(base) & ~(mask << shift)) |
>> +                         (val << shift)), base);
>>  }
>>
>>
>
> I think it would be better to use function pointers that are assigned at probe time than run-time checks here.
>
> Have a look at drivers/mmc/host/sdhci-of-hlwd.c:
>
> static const struct sdhci_ops sdhci_hlwd_ops = {
>         .read_l = sdhci_be32bs_readl,
>         .read_w = sdhci_be32bs_readw,
>         .read_b = sdhci_be32bs_readb,
>         .write_l = sdhci_hlwd_writel,
>         .write_w = sdhci_hlwd_writew,
>         .write_b = sdhci_hlwd_writeb,
>         .set_clock = sdhci_set_clock,
>         .set_bus_width = sdhci_set_bus_width,
>         .reset = sdhci_reset,
>         .set_uhs_signaling = sdhci_set_uhs_signaling, };
>
>
> You can copy this method into your own driver.
>
>         Arnd
