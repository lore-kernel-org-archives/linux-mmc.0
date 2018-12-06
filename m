From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V3 1/3] mmc: sdhci: add support for using external DMA devices
Date: Thu, 6 Dec 2018 14:18:19 +0800
Message-ID: <CAAfSe-vnwOG+CjGdU-2jauv=XXy3Ao+u3GRww11dEbukggpwWA@mail.gmail.com>
References: <1543908270-13953-1-git-send-email-zhang.chunyan@linaro.org>
 <1543908270-13953-2-git-send-email-zhang.chunyan@linaro.org> <5167ffb5-77f8-ab66-2eca-602df5f4e3e8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5167ffb5-77f8-ab66-2eca-602df5f4e3e8@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: faiz_abbas@ti.com
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, kishon@ti.com, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

On Tue, 4 Dec 2018 at 18:38, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi,
>
> On 04/12/18 12:54 PM, Chunyan Zhang wrote:
> > Some standard SD host controllers can support both external dma
> > controllers as well as ADMA/SDMA in which the SD host controller
> > acts as DMA master. TI's omap controller is the case as an example.
> >
> > Currently the generic SDHCI code supports ADMA/SDMA integrated in
> > the host controller but does not have any support for external DMA
> > controllers implemented using dmaengine, meaning that custom code is
> > needed for any systems that use an external DMA controller with SDHCI.
> >
> ...
>
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index b001cf4..8e50a97 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -475,6 +475,7 @@ struct sdhci_host {
> >
> >       int irq;                /* Device IRQ */
> >       void __iomem *ioaddr;   /* Mapped address */
> > +     phys_addr_t mapbase;    /* physical address base */
> >       char *bounce_buffer;    /* For packing SDMA reads/writes */
> >       dma_addr_t bounce_addr;
> >       unsigned int bounce_buffer_size;
> > @@ -524,6 +525,7 @@ struct sdhci_host {
> >       bool pending_reset;     /* Cmd/data reset is pending */
> >       bool irq_wake_enabled;  /* IRQ wakeup is enabled */
> >       bool v4_mode;           /* Host Version 4 Enable */
> > +     bool use_external_dma;
> >
> >       struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];  /* Requests done */
> >       struct mmc_command *cmd;        /* Current command */
> > @@ -552,6 +554,11 @@ struct sdhci_host {
> >       struct timer_list timer;        /* Timer for timeouts */
> >       struct timer_list data_timer;   /* Timer for data timeouts */
> >
> > +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> > +     struct dma_chan *rx_chan;
> > +     struct dma_chan *tx_chan;
> > +#endif
> > +
> >       u32 caps;               /* CAPABILITY_0 */
> >       u32 caps1;              /* CAPABILITY_1 */
> >       bool read_caps;         /* Capability flags have been read */
> > @@ -785,5 +792,6 @@ void sdhci_start_tuning(struct sdhci_host *host);
> >  void sdhci_end_tuning(struct sdhci_host *host);
> >  void sdhci_reset_tuning(struct sdhci_host *host);
> >  void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
> > +void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
> >
>
> Can you also add a new attribute in sdhci_host->flags for external dma
> in this file? The log still shows
>
> [    3.675028] mmc2: SDHCI controller on 4809c000.mmc [4809c000.mmc]
> using ADMA

Ok, will try to add.

Thanks for your test and review.

Chunyan

>
> when using external dma.
>
> Thanks,
> Faiz
