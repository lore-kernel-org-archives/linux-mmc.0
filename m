From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH 2/3] mmc: Add APM X-Gene SoC SDHC controller support to
 Arasan SDHCI driver
Date: Thu, 29 May 2014 11:45:40 -0700
Message-ID: <CAPw-ZTmBVFk=k9uhqtW7gBq6V09x6KTe75bo7dQFr3O5wcaMAQ@mail.gmail.com>
References: <1400398918-1502-1-git-send-email-lho@apm.com>
	<1400398918-1502-2-git-send-email-lho@apm.com>
	<1400398918-1502-3-git-send-email-lho@apm.com>
	<5286335.Al3nIKDAQo@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og101.obsmtp.com ([64.18.0.141]:46989 "HELO
	exprod5og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753940AbaE2Spl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 May 2014 14:45:41 -0400
Received: by mail-qg0-f50.google.com with SMTP id z60so2215225qgd.37
        for <linux-mmc@vger.kernel.org>; Thu, 29 May 2014 11:45:40 -0700 (PDT)
In-Reply-To: <5286335.Al3nIKDAQo@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, chris@printf.net, Ulf Hansson <ulf.hansson@linaro.org>, michal.simek@xilinx.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mmc@vger.kernel.org, "patches@apm.com" <patches@apm.com>, Jon Masters <jcm@redhat.com>

Hi Arnd,

> > +static void sdhci_arasan_writel(struct sdhci_host *host, u32 val, int reg)
> > +{
> > +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +     struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
> > +
> > +     if (reg == SDHCI_DMA_ADDRESS) {
> > +             if (sdhci_arasan->ahb_ops && sdhci_arasan->ahb_ops->xlat_addr)
> > +                     sdhci_arasan->ahb_ops->xlat_addr(sdhci_arasan,
> > +                             sg_dma_address(host->data->sg));
> > +     }
> > +     writel(val, host->ioaddr + reg);
> > +}
> > +
> >  static struct sdhci_ops sdhci_arasan_ops = {
> > +     .write_l = sdhci_arasan_writel,
> >       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> >       .get_timeout_clock = sdhci_arasan_get_timeout_clock,
> >  };
>
> This looks like you are doing it at the wrong place. From what I understand,
> you are using the AHB inbound window as a minimal IOMMU. Why don't you make
> this a proper IOMMU driver instead and leave the SDHCI driver unchanged?


I looked at the existent iommu driver. It seems like one can install
an IO MMU. The question that I have is what happen when we enable the
actual IO mmu? Would this be an issue if both existed as there is only
one pointer in the bus_type structure?

-Loc
