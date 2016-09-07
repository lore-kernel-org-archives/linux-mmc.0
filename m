From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4 3/9] mmc: sdhci-msm: add pltfm_data support to get
 clk-rates from DT
Date: Wed, 7 Sep 2016 09:14:28 -0700
Message-ID: <20160907161428.GY12510@codeaurora.org>
References: <1472033024-14890-1-git-send-email-riteshh@codeaurora.org>
 <1472033024-14890-4-git-send-email-riteshh@codeaurora.org>
 <20160825222747.GU19826@codeaurora.org>
 <1a44bb54-d88c-737d-7fb1-e7c3597ac03b@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1a44bb54-d88c-737d-7fb1-e7c3597ac03b-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 08/30, Ritesh Harjani wrote:
> On 8/26/2016 3:57 AM, Stephen Boyd wrote:
> >On 08/24, Ritesh Harjani wrote:
> >>This adds support for sdhc-msm controllers to get supported
> >>clk-rates from DT. sdhci-msm would need it's own set_clock
> >>ops to be implemented. For this, supported clk-rates needs
> >>to be populated in sdhci_msm_pltfm_data.
> >>
> >>Signed-off-by: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >>---
> >
> >Please include the DT binding review list in binding updates.
> >
> >> .../devicetree/bindings/mmc/sdhci-msm.txt          |  1 +
> >> drivers/mmc/host/sdhci-msm.c                       | 60 ++++++++++++++++++++++
> >> 2 files changed, 61 insertions(+)
> >>
> >>diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >>index 485483a..6a83b38 100644
> >>--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >>+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >>@@ -17,6 +17,7 @@ Required properties:
> >> 	"iface" - Main peripheral bus clock (PCLK/HCLK - AHB Bus clock) (required)
> >> 	"core"	- SDC MMC clock (MCLK) (required)
> >> 	"bus"	- SDCC bus voter clock (optional)
> >>+- clk-rates: Array of supported GCC clock frequencies for sdhc, Units - Hz.
> >>
> >
> >Why not use OPPv2 binding for this? We already have a way to
> >express frequencies for devices with that binding, and we'll need
> >to attach voltages to those frequencies at some point in the
> >future if we want to handle DVFS on these devices.
> >
> OPPv2 may not work out in this case. This was also discussed at [1].
> These clk-rates are not as per voltage points(or any OPP) but as per
> bus speed mode request from higher layer.
> 

That post you link to had a response from Andy that echoed the
same sentiment and then no reply.

Are they a set of frequencies the device can operate at? Yes. Do
they have associated voltages that aren't expressed in this
patch? Yes.

Perhaps I've missed something though and the index of the array
of rates corresponds to some bus speed mode? That isn't clearly
expressed in the binding. Do the frequencies come from some spec
for those bus speed modes? Either way, I'd like to understand why
we need to put frequency tables into DT (hint: the commit text
should explain that).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
