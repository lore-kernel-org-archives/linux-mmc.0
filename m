Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C83FFF92;
	Tue,  9 Jun 2026 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015499; cv=none; b=I9hEv0nWte/CMICxUo2KuqKFUQGzFiZxC8NhZ462d9thibPwiVmZ0MKhWrxZ6p3WCm7IOOJzzC3d4G6ZchOoyDrpDIoz7xeChIG6GTyuiSD6FTMZGrB4MTMj8sWdkV4MZHbcbZEWxtyrB1acikfJzhljDuI9Y3AVdObUIVA1iuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015499; c=relaxed/simple;
	bh=Pw9+4Mrp9WsQ7Y6Tm5fYDG9zf9NzBasMKVvWut0G1s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7Ay2MM9QDSW9mtzddooywHsxwB+B9MmX0BP35Up0K9sHmeEXvV/fc1u1Fmqb9SUEYsw1YSGf0jtKoNLwaK4p0ObCnKJuTEMENSXK3PBMYgK07vK7vbAleT7gyFQcWqwThLQpdoZRwcsi+3aFZpbNb68vkORlkXfF08wKBsF/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbLl1CPO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbLl1CPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2601F0089B;
	Tue,  9 Jun 2026 14:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781015497;
	bh=wnHCt9onRqoY+cbLWgHyZIs8YweKMqJpPWB0NBmJh2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hbLl1CPOPdBa9wwSIomEqpEB19Sog2GlcWZzvi+192TOFGd0tHaqnXzjO+ttFDkBS
	 qh+Q846IKjyEOyPDlo7AXxgSfRr5icx44xSRVQP7idXOk99r3eLnqU9bvVlGDiWp00
	 /0fIEkM3abVn/YnOuToHmxTRG6DfTH5Lhzqkhw9EU8jsltzWfMiGaR0PogWTxQabwJ
	 DbL+jxATM1WTbDBOyEKFFcUHwtNNDQpPsK7HGx41pXyVsTfzyR1JG+GnmXINndd3mY
	 RUTPXeg7chvWQZN5Fzpa/QwzmKLbY8m90ELYKTX4vZTBj2etG/4Xj+Ic+B9MtrbGDB
	 H56uWIZ+5hvmA==
Message-ID: <490153c1-b6e4-4933-99e6-0f0ee96bb500@kernel.org>
Date: Wed, 10 Jun 2026 00:31:33 +1000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/4] mmc: sdhci-esdhc-mcf: do not use readl()/writel() on
 ColdFire
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 arnd@kernel.org, Greg Ungerer <gerg@linux-m68k.org>,
 adureghello@baylibre.com, linux-mmc@vger.kernel.org
References: <20260506142644.3234270-2-gerg@kernel.org>
 <20260506142644.3234270-6-gerg@kernel.org>
 <CAPDyKFpZ3h7Kx845K+f1EZs2ijgjBmKsLOX8GCuP=C5WV-d8KQ@mail.gmail.com>
Content-Language: en-US
From: Greg Ungerer <gerg@kernel.org>
In-Reply-To: <CAPDyKFpZ3h7Kx845K+f1EZs2ijgjBmKsLOX8GCuP=C5WV-d8KQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/5/26 01:11, Ulf Hansson wrote:
> On Wed, 6 May 2026 at 16:34, Greg Ungerer <gerg@kernel.org> wrote:
>>
>> From: Greg Ungerer <gerg@linux-m68k.org>
>>
>> The implementation of the readX() and writeX() family of IO access
>> functions is non-standard on ColdFire platforms. They check the supplied
>> IO address and will return either big or little endian results based on
>> that check. This is non-standard, they are expected to always return
>> little-endian byte ordered data. Unfortunately this behavior also means
>> that ioreadX()/iowroteX() and their big-endian counter parts
>> ioreadXbe()/iowriteXbe() are wrong. This is now in the process of being
>> cleaned up and fixed.
>>
>> Change the use of the readX() and writeX() access functions in this driver
>> to use the recently defined specific ColdFire internal SoC hardware IO
>> access functions mcf_read8()/mcf_read16()/mcf_read32() and
>> mcf_write8()/mcf_write16()/mcf_write32().
>>
>> There is no functional change to the driver. Though it does have the
>> effect of making the IO access slightly more efficient, since there is
>> no longer a need to do the address check at every register access.
>>
>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
>> ---
>>   drivers/mmc/host/sdhci-esdhc-mcf.c | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> Note that the patches to introduce mcf_readX() and mcf_writeX functions
>> are not in mainline yet. They are currently in the m68knommu git tree
>> for-next branch, and so should also be in linux-next.
> 
> Okay, so please resubmit the $subject patch when the mcf_readX|writeX
> functions are available in a v7.x-rc so I can pick it up.
> 
> Another option is if someone can host an immutable branch for me to
> pull in the changes for mcf_readX|writeX.

Those changes are now on an immutable branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
cf-internal-io branch

I will follow up after 7.2-rc1 is out with this patch set as well.

Regards
Greg



     

> Kind regards
> Uffe
> 
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
>> index 375fce5639d7..6853521e8b2c 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
>> @@ -55,7 +55,7 @@ static inline void esdhc_clrset_be(struct sdhci_host *host,
>>          if (reg == SDHCI_HOST_CONTROL)
>>                  val |= ESDHC_PROCTL_D3CD;
>>
>> -       writel((readl(base) & ~mask) | val, base);
>> +       mcf_write32((mcf_read32(base) & ~mask) | val, base);
>>   }
>>
>>   /*
>> @@ -71,7 +71,7 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
>>          if (reg == SDHCI_HOST_CONTROL) {
>>                  u32 host_ctrl = ESDHC_DEFAULT_HOST_CONTROL;
>>                  u8 dma_bits = (val & SDHCI_CTRL_DMA_MASK) >> 3;
>> -               u8 tmp = readb(host->ioaddr + SDHCI_HOST_CONTROL + 1);
>> +               u8 tmp = mcf_read8(host->ioaddr + SDHCI_HOST_CONTROL + 1);
>>
>>                  tmp &= ~0x03;
>>                  tmp |= dma_bits;
>> @@ -82,12 +82,12 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
>>                   */
>>                  host_ctrl |= val;
>>                  host_ctrl |= (dma_bits << 8);
>> -               writel(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
>> +               mcf_write32(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
>>
>>                  return;
>>          }
>>
>> -       writel((readl(base) & mask) | (val << shift), base);
>> +       mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>>   }
>>
>>   static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
>> @@ -110,24 +110,24 @@ static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
>>                   * As for the fsl driver,
>>                   * we have to set the mode in a single write here.
>>                   */
>> -               writel(val << 16 | mcf_data->aside,
>> +               mcf_write32(val << 16 | mcf_data->aside,
>>                         host->ioaddr + SDHCI_TRANSFER_MODE);
>>                  return;
>>          }
>>
>> -       writel((readl(base) & mask) | (val << shift), base);
>> +       mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>>   }
>>
>>   static void esdhc_mcf_writel_be(struct sdhci_host *host, u32 val, int reg)
>>   {
>> -       writel(val, host->ioaddr + reg);
>> +       mcf_write32(val, host->ioaddr + reg);
>>   }
>>
>>   static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
>>   {
>>          if (reg == SDHCI_HOST_CONTROL) {
>>                  u8 __iomem *base = host->ioaddr + (reg & ~3);
>> -               u16 val = readw(base + 2);
>> +               u16 val = mcf_read16(base + 2);
>>                  u8 dma_bits = (val >> 5) & SDHCI_CTRL_DMA_MASK;
>>                  u8 host_ctrl = val & 0xff;
>>
>> @@ -137,7 +137,7 @@ static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
>>                  return host_ctrl;
>>          }
>>
>> -       return readb(host->ioaddr + (reg ^ 0x3));
>> +       return mcf_read8(host->ioaddr + (reg ^ 0x3));
>>   }
>>
>>   static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
>> @@ -149,14 +149,14 @@ static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
>>          if (reg == SDHCI_HOST_VERSION)
>>                  reg -= 2;
>>
>> -       return readw(host->ioaddr + (reg ^ 0x2));
>> +       return mcf_read16(host->ioaddr + (reg ^ 0x2));
>>   }
>>
>>   static u32 esdhc_mcf_readl_be(struct sdhci_host *host, int reg)
>>   {
>>          u32 val;
>>
>> -       val = readl(host->ioaddr + reg);
>> +       val = mcf_read32(host->ioaddr + reg);
>>
>>          /*
>>           * RM (25.3.9) sd pin clock must never exceed 25Mhz.
>> @@ -245,7 +245,7 @@ static void esdhc_mcf_pltfm_set_clock(struct sdhci_host *host,
>>           * fvco = fsys * outdvi1 + 1
>>           * fshdc = fvco / outdiv3 + 1
>>           */
>> -       temp = readl(pll_dr);
>> +       temp = mcf_read32(pll_dr);
>>          fsys = pltfm_host->clock;
>>          fvco = fsys * ((temp & 0x1f) + 1);
>>          fesdhc = fvco / (((temp >> 10) & 0x1f) + 1);
>> --
>> 2.54.0
>>
>>
> 

