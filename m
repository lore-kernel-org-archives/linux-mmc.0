From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] sdhci-of-esdhc: Support 8BIT bus width.
Date: Tue, 5 May 2015 12:11:31 +0200
Message-ID: <CAPDyKFo-j-9SCH+EBqqgCaRpDcHsNp3s_hOL7aAuUMiVmBe-ig@mail.gmail.com>
References: <1429564296-30396-1-git-send-email-joakim.tjernlund@transmode.se>
	<CAPDyKFpQuLDafARu6=5XqxPsShRzcC__ZFgjE1yUrP4SobFjGQ@mail.gmail.com>
	<1430816674.27859.71.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36071 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757522AbbEEKLc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 06:11:32 -0400
Received: by qku63 with SMTP id 63so101851923qku.3
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 03:11:31 -0700 (PDT)
In-Reply-To: <1430816674.27859.71.camel@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 5 May 2015 at 11:04, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> On Tue, 2015-05-05 at 10:34 +0200, Ulf Hansson wrote:
>> On 20 April 2015 at 23:11, Joakim Tjernlund
>> <joakim.tjernlund@transmode.se> wrote:
>> > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
>>
>> Thanks, applied.
>>
>> Kind regards
>> Uffe
>
> Argh, I just learned that this patch is buggy. Please "unapply"
>
>  Jocke
>

Done!

Kind regards
Uffe

>>
>>
>> > ---
>> >  drivers/mmc/host/sdhci-of-esdhc.c | 10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> >
>> > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
>> > index 22e9111..7130130 100644
>> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
>> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
>> > @@ -82,6 +82,10 @@ static u8 esdhc_readb(struct sdhci_host *host, int reg)
>> >                 /* fixup the result */
>> >                 ret &= ~SDHCI_CTRL_DMA_MASK;
>> >                 ret |= dma_bits;
>> > +
>> > +               /* 8BIT is bit 29 in Control register */
>> > +               ret |= ((ret << 3) & SDHCI_CTRL_8BITBUS);
>> > +               ret &= ~(SDHCI_CTRL_8BITBUS >> 3);
>> >         }
>> >
>> >         return ret;
>> > @@ -134,6 +138,10 @@ static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
>> >                         dma_bits);
>> >                 val &= ~SDHCI_CTRL_DMA_MASK;
>> >                 val |= in_be32(host->ioaddr + reg) & SDHCI_CTRL_DMA_MASK;
>> > +
>> > +               /* 8BIT is bit 29 in Control register */
>> > +               val |= ((val & SDHCI_CTRL_8BITBUS) >> 3);
>> > +               val = (val & ~SDHCI_CTRL_8BITBUS);
>> >         }
>> >
>> >         /* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
>> > @@ -252,6 +260,8 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
>> >
>> >         if (vvn > VENDOR_V_22)
>> >                 host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
>> > +
>> > +       host->mmc->caps |= MMC_CAP_8_BIT_DATA;
>> >  }
>> >
>> >  static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
>
