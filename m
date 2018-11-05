From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: mmc: sdhci-msm: Add new compatible
 string for SDM845 SOC
Date: Mon, 5 Nov 2018 13:11:31 -0800
Message-ID: <CAD=FV=VitZ4dyYGxinQ=nsrfM+U7duGbxeN3bdbRxfx-2AWxyQ@mail.gmail.com>
References: <1541073999-11752-1-git-send-email-vbadigan@codeaurora.org>
 <1541073999-11752-2-git-send-email-vbadigan@codeaurora.org>
 <CAD=FV=V9AdCgOSonb0tu==DgKRKeZxto+aGwxmdbHAqrmfMrDQ@mail.gmail.com> <20181105203657.GA32282@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105203657.GA32282@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: vbadigan@codeaurora.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Evan Green <evgreen@chromium.org>, Asutosh Das <asutoshd@codeaurora.org>, riteshh@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Nov 5, 2018 at 12:37 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Nov 01, 2018 at 01:29:54PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Nov 1, 2018 at 5:07 AM Veerabhadrarao Badiganti
> > <vbadigan@codeaurora.org> wrote:
> > >
> > > For SDM845 SOC, new compatible string  "qcom,sdm845-sdhci" is added.
> > >
> > > Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> > > ---
> > >  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> > > index 502b3b8..f2ffbeb 100644
> > > --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> > > +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> > > @@ -7,6 +7,7 @@ Required properties:
> > >  - compatible: Should contain:
> > >                 "qcom,sdhci-msm-v4" for sdcc versions less than 5.0
> > >                 "qcom,sdhci-msm-v5" for sdcc versions >= 5.0
> > > +               "qcom,sdm845-sdhci" for sdm845 SOC
> >
> > It's up to Rob of course, but IMO it seems a nicer way forward to
> > include both the SoC-specific string and the "version" string in all
> > cases.  I'd write this for the full text:
>
> Fine by me if you update all the dts files.

Done and done.

https://lkml.kernel.org/r/20181105210921.253707-1-dianders@chromium.org
https://lkml.kernel.org/r/20181105210921.253707-2-dianders@chromium.org


> >  - compatible: Should contain a SoC-specific string and a IP version string:
> >       version strings:
> >            "qcom,sdhci-msm-v4" for sdcc versions less than 5.0
> >            "qcom,sdhci-msm-v5" for sdcc version 5.0
> >       full compatible strings with SoC and version:
> >            "qcom,apq8084", "qcom,sdhci-msm-v4"
> >            "qcom,msm8974", "qcom,sdhci-msm-v4"
> >            "qcom,msm8916", "qcom,sdhci-msm-v4"
> >            "qcom,msm8992", "qcom,sdhci-msm-v4"
> >            "qcom,msm8996", "qcom,sdhci-msm-v4"
>
> I assume you meant to append '-sdhci' here?

Oops, yes!

           "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4"
           "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4"
           "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
           "qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
           "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"

-Doug
