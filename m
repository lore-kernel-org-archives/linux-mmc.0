From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH v2 0/3] Add support for using external dma in SDHCI
Date: Thu, 29 Nov 2018 14:14:16 +0800
Message-ID: <CAAfSe-svPfr5SL4WHUUgt4+eB026HYkpG=bwOManZ52+KzWpnw@mail.gmail.com>
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
 <fb8a9eb6-82a1-1299-489f-9fed4ee48a02@ti.com> <5a45f520-03b0-3679-2175-a19681062bf6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5a45f520-03b0-3679-2175-a19681062bf6@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: faiz_abbas@ti.com
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, kishon@ti.com, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi Faiz,

Many thanks for testing this.

On Thu, 29 Nov 2018 at 00:59, Rizvi, Mohammad Faiz Abbas
<faiz_abbas@ti.com> wrote:
>
> + Mark Brown
>
> Chunyan,
>
> On 11/21/2018 5:17 PM, Faiz Abbas wrote:
> > Hi Chunyan,
> >
> > On 12/11/18 12:56 PM, Chunyan Zhang wrote:
> >> Currently the generic SDHCI code in the Linux kernel supports the SD
> >> standard DMA integrated into the host controller but does not have any
> >> support for external DMA controllers implemented using dmaengine meaning
> >> that custom code is needed for any systems that use a generic DMA
> >> controller with SDHCI which in practice means any SDHCI controller that
> >> doesn't have an integrated DMA controller so we should have this as a
> >> generic feature.
> >>
> >> There are already a number of controller specific drivers that have dmaengine
> >> code, and some could use sdhci.c actually, but needed to implement mmc_ops->request()
> >> in their specific driver for sending command with external dma using dmaengine
> >> framework, with this patchset, them will take advantage of the generic support.
> >> TI's omap controller is the case as an example.
> >>
> >> Any comments are very appreciated.
> >>
> >
> > This is great. It helps us move am335x and am43xx platforms to
> > sdhci-omap. What platforms have you tested this on?
> >
>
> Gentle ping on this. I tried testing these with an am335x-evm board. In
> their current condition, the card fails to enumerate altogether. The
> changes suggested by Adrian should fix this. Let me know when you post a v3.

I addressed Adrian's comments, and posted a new patch under 1/3 of the
last patch series, if this patch can be verified workable, I will send
another new patchset also add your tested-by.

Thanks,
Chunyan

>
> Thanks,
> Faiz
