From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC 1/2] mmc: sdhci-msm: Add support for bus bandwidth voting
Date: Thu, 3 Oct 2019 12:00:51 +0200
Message-ID: <CAPDyKFryLhOduNfupF_7WXb93tD26nWeTYKaF60wA3hcCOYy_A@mail.gmail.com>
References: <1567774037-2344-1-git-send-email-ppvk@codeaurora.org>
 <1567774037-2344-2-git-send-email-ppvk@codeaurora.org> <20190912164532.GA8466@tuxbook-pro>
 <1b02d465353e12f47b372a7a240f0838@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1b02d465353e12f47b372a7a240f0838@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ppvk@codeaurora.org
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Asutosh Das <asutoshd@codeaurora.org>, Veerabhadrarao Badiganti <vbadigan@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Sayali Lokhande <sayalil@codeaurora.org>, rampraka@codeaurora.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Subhash Jadavani <subhashj@codeaurora.org>, Andy Gross <agross@kernel.org>, linux-mmc-owner@vger.kernel.org, Georgi Djakov <georgi.djakov@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 25 Sep 2019 at 13:27, <ppvk@codeaurora.org> wrote:
>
> On 2019-09-12 22:15, Bjorn Andersson wrote:
> > On Fri 06 Sep 05:47 PDT 2019, Pradeep P V K wrote:
> >
> >> Vote for the MSM bus bandwidth required by SDHC driver
> >> based on the clock frequency and bus width of the card.
> >> Otherwise,the system clocks may run at minimum clock speed
> >> and thus affecting the performance.
> >>
> >> This change is based on Georgi Djakov [RFC]
> >> (https://lkml.org/lkml/2018/10/11/499)
> >>
> >> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> >> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> >> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> >> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> >
> > This says that Sahitya wrote the patch, then Subhash handled it, then
> > Veerabhadrarao handled it and finally you handled it; but you're at the
> > same time listed as author (by From:).
> >
> > Please see section 12 on Co-Developed-by in submitting-patches.rst
> >
> Thanks Bjorn, i will update this on my next patch set.
> >> ---
> >>  drivers/mmc/host/sdhci-msm.c | 393
> >> ++++++++++++++++++++++++++++++++++++++++++-
> >
> > This patch implements support for requesting bandwidth to the register
> > space and for the controllers access to DDR. To me this seems like
> > common requirements for any mmc controller, can this functionality be
> > provided by the mmc/sdhci common code?
> >
> > Regards,
> > Bjorn
> >
> Yes, this can be provided in common code but the bandwidth calculations
> (arbitrated value or average bandwidth and instantaneous value or peak
> bandwidth) for bus vote will
> consider various parameters like voltage corners, clock domains, clock
> plans etc. which may differ from
> vendor to vendor and target to target. So, these values should be
> updated properly and correctly (considering all the parameters)
> if it brings to common area.
>
> Hence the reason for implementing this in sdhci-msm.c file.
> It would be really helpful if you could suggest your insights on where
> and how exactly this needs to be
> implemented in common code area.
>
> Hi Ulf and Adrian,
>
> Can you please also suggest your recommendations on this ?

I am not sure where to put it at this point. Perhaps we can just start
with making it specific for sdhci-msm, then when new users come into
play, we can consider moving it to a common place.

[...]

Kind regards
Uffe
