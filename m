From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V4 1/3] mmc: sdhci: add support for using external DMA devices
Date: Thu, 27 Dec 2018 16:02:59 +0800
Message-ID: <CAAfSe-tHu5m3Of6=KBCxBBH1T8=4tgN8aZP_7QaGERctECZPoQ@mail.gmail.com>
References: <1544519572-21921-1-git-send-email-zhang.chunyan@linaro.org>
 <1544519572-21921-2-git-send-email-zhang.chunyan@linaro.org> <0e683aef-383c-8200-0059-44a9abb654b8@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0e683aef-383c-8200-0059-44a9abb654b8@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Faiz Abbas <faiz_abbas@ti.com>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, 27 Dec 2018 at 15:44, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 11/12/18 11:12 AM, Chunyan Zhang wrote:
> > Some standard SD host controllers can support both external dma
> > controllers as well as ADMA/SDMA in which the SD host controller
> > acts as DMA master. TI's omap controller is the case as an example.
> >
> > Currently the generic SDHCI code supports ADMA/SDMA integrated in
> > the host controller but does not have any support for external DMA
> > controllers implemented using dmaengine, meaning that custom code is
> > needed for any systems that use an external DMA controller with SDHCI.
> >
> > Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>
> FYI, I am waiting on successful testing before reviewing these patches again.

Yeah, that makes sense, thanks Adrian!

I intend to send out another new patchset after the holidays.
After had another look at omap_hsmmc, I knew something need to be
modified (emailed Faiz about this privately), but I was still not sure
if it can fix the problem Faiz found.

Happy new year to all,
Chunyan
