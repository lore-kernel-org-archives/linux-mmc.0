From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: Re: [PATCH] dt-bindings: sdhci-omap: Add properties for using
 external dma
Date: Wed, 23 Jan 2019 10:44:35 +0800
Message-ID: <CAG2=9p-JcAB0Re2hRB6bu_18Z_SJXjrynw2cRSKVFEBnWHPDKg@mail.gmail.com>
References: <20190121232057.GA30919@bogus> <20190122084706.11522-1-zhang.chunyan@linaro.org>
 <7231fba8-de0d-dd22-5ec8-d62d34c6495d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7231fba8-de0d-dd22-5ec8-d62d34c6495d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 22 Jan 2019 at 18:17, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi Chunyan,
>
> +Rob Herring
>
> On 22/01/19 2:17 PM, Chunyan Zhang wrote:
> > sdhci-omap can support both external dma controller via dmaengine
> > framework as well as ADMA which standard SD host controller
> > provides.
> >
> > Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> > Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> > ---
>
> Thanks for fixing this. However, this change should be part of the

Right, I actually used "--in-reply-to" with the parameter of
Message-ID of Rob's mail, but it seems not work as I expected that it
was expected a reply to Rob's mail for review.

> series (with a change log and a version number). I will send this as a
> part of my series after I get some Acks on the driver patches.

Ok, thanks.

Chunyan

>
> Thanks,
> Faiz
