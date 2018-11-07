From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: Re: [PATCH RFC 2/3] mmc: sdhci-omap: Add using external dma
Date: Wed, 7 Nov 2018 11:00:57 +0800
Message-ID: <CAG2=9p-skR8xqqBrULS6_EWFX0H_mvvOJKDGVfzf026H_dychg@mail.gmail.com>
References: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
 <1541387810-24867-3-git-send-email-zhang.chunyan@linaro.org>
 <be0a18e8-8ee6-4d4e-6dcc-6ba6e39033c9@ti.com> <CAK8P3a2X4tbx_R-5VgfApF-UPmJ_XuzH3hO_uVAfffC6h8WrJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2X4tbx_R-5VgfApF-UPmJ_XuzH3hO_uVAfffC6h8WrJw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Lyra Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, 6 Nov 2018 at 20:51, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On 11/5/18, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > On 05/11/18 8:46 AM, Chunyan Zhang wrote:
> >>
> >> +    sdhci_switch_extdma(host, true);
> >
> > A number of devices using sdhci-omap supports ADMA. So switching to
> > external
> > DMA shouldn't be unconditional.
> >
> > IMHO sdhci.c should see if the device supports ADMA or SDMA. If not it
> > should
> > try switching to external DMA and if external DMA too is not supported, it
> > should use PIO.
>
> What's the reasoning for preferring ADMA/SDMA over external DMA if
> both are supported?
>
> I'd expect that if the external DMA for some reason is worse than
> ADMA, we just wouldn't list it in the DT at all, but if it's listed and
> ADMA also works, then the driver should try to use it before falling
> back to ADMA.

Thanks Arnd and Kishon, let's see what Andrian and Ulf would suggest,
and then I will address in next version of patchset.

Thanks again,
Chunyan

>
>        Arnd
