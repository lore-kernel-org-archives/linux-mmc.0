From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 2/9] dt-bindings: mmc: sprd: Add another optional clock documentation
Date: Tue, 4 Jun 2019 10:33:08 +0800
Message-ID: <CAMz4kuK+yX=V2zp-C4Xb-6ZjgLOY+ON2iHZU=HwONeXcJCkk4w@mail.gmail.com>
References: <cover.1558346019.git.baolin.wang@linaro.org> <ee4ad0e7e131e4d639dbf6bd25ad93726648ce1c.1558346019.git.baolin.wang@linaro.org>
 <CAPDyKFrWiG3KJad+L3NOQ-dC2XnBM-8mQGVEsVB_Qg0ACTfVag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrWiG3KJad+L3NOQ-dC2XnBM-8mQGVEsVB_Qg0ACTfVag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Vincent Guittot <vincent.guittot@linaro.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Mon, 3 Jun 2019 at 21:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 20 May 2019 at 12:12, Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > For some Spreadtrum platforms like SC9860 platform, we should enable another
> > gate clock '2x_enable' to make the SD host controller work well. Thus add
> > documentation for this optional clock.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  .../devicetree/bindings/mmc/sdhci-sprd.txt         |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> > index 45c9978..a285c77 100644
> > --- a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> > @@ -14,6 +14,7 @@ Required properties:
> >  - clock-names: Should contain the following:
> >         "sdio" - SDIO source clock (required)
> >         "enable" - gate clock which used for enabling/disabling the device (required)
> > +       "2x_enable" - gate clock controlling the device for some special platforms (optional)
>
> This is a bit vague, could you please elaborate (and fold in that
> information to the doc) on what kind of clock this is?

Sorry for confusing. For some Spreadtrum platfroms like SC9860
platform, we should enable 2 gate clocks to enable SD host controller,
that means we have 2 serialized clock gates. I know that's a little
weird, but that's our clock's design.

-- 
Baolin Wang
Best Regards
