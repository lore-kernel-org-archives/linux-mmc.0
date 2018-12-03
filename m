From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: Re: [PATCH v2 1/3] mmc: sdhci: add support for using external DMA devices
Date: Mon, 3 Dec 2018 18:47:27 +0800
Message-ID: <CAG2=9p-aBuiimuPR3qv43UKJCe2wQqb4Q_ZqcpF-dK4=5XQCxA@mail.gmail.com>
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
 <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
 <84836600-c705-9ac3-297e-bb67a611daca@intel.com> <CAAfSe-us5aKOv9F6KHwvJR_cMAF8KFo6W1Gs_B3zBiNOuD10Qg@mail.gmail.com>
 <f78de042-69cf-5345-f16f-236d04d57051@intel.com> <CAAfSe-sfe5A7b_8iBiUmvi_mo1zRZ_Oh0yu-uwXo8Hv+WBftWQ@mail.gmail.com>
 <22591bc4-ea34-dcc6-a3d5-8a75e890ff2b@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <22591bc4-ea34-dcc6-a3d5-8a75e890ff2b@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lyra Zhang <zhang.lyra@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, 30 Nov 2018 at 09:15, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> On 2018/11/29 17:59, Chunyan Zhang wrote:
> > Hi Adrian,
> >
> > On Thu, 29 Nov 2018 at 15:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 29/11/18 8:22 AM, Chunyan Zhang wrote:
> >>> On Tue, 20 Nov 2018 at 21:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>
> >>>> On 12/11/18 9:26 AM, Chunyan Zhang wrote:
> >>>>> Some standard SD host controllers can support both external dma
> >>>>> controllers as well as ADMA/SDMA in which the SD host controller
> >>>>> acts as DMA master. TI's omap controller is the case as an example.
> >>>>>
> >>>>> Currently the generic SDHCI code supports ADMA/SDMA integrated in
> >>>>> the host controller but does not have any support for external DMA
> >>>>> controllers implemented using dmaengine, meaning that custom code is
> >>>>> needed for any systems that use an external DMA controller with SDHCI.
> >>>>
> >>>> I still think you probably need to reset the DMA if there are transfer
> >>>> errors - perhaps you could comment on that.  Also there are some comments below.
> >>>
> >>> With regard to "transfer error", do you mean if
> >>> sdhci_external_dma_setup() failed?
> >>
> >> No, I mean any error interrupt that can leave the DMA uncompleted.  For
> >> SDHCI, resetting the data circuit cleans that up, but presumably something
> >> is needed for external DMA?
> >
> > Yes, it should need a dmaengine_terminate_all().
> >
>
> No, dmaengine_terminate_all is deprecated for quite a long time.
> Please use dmaengine_terminate_{async, sync}() instead.
>
> See Documentation/dmaengine/client.txt

Ok, thanks for the comments.
Chunyan

>
>
> > How about adding that at here (I will wrap it up of course):
> > https://elixir.bootlin.com/linux/v4.19.5/source/drivers/mmc/host/sdhci.c#L2553
> >
> > Is there somewhere else I'm missing?
> >
> > Thanks,
> > Chunyan
> >
> >
>
