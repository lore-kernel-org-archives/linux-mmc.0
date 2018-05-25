From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH V1 2/3] mmc: sdhci-msm: Add msm version specific ops and
 data structures
Date: Fri, 25 May 2018 13:45:27 -0700
Message-ID: <CAE=gft5ZeSJwDHme7xb8Uotm9-Eed01JaxDrCX_+SER+j71OTQ@mail.gmail.com>
References: <1526552938-21292-1-git-send-email-vviswana@codeaurora.org>
 <1526552938-21292-3-git-send-email-vviswana@codeaurora.org>
 <CAE=gft4ZQ34QankD_S5y_KjoZG8rxQkEfPo7vZsJTUB387P6dQ@mail.gmail.com> <85d7d14c-fd1c-92af-4605-3441649c9fcd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <85d7d14c-fd1c-92af-4605-3441649c9fcd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vviswana@codeaurora.org
Cc: adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, Bjorn Andersson <bjorn.andersson@linaro.org>, riteshh@codeaurora.org, vbadigan@codeaurora.org, Doug Anderson <dianders@google.com>, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On Thu, May 24, 2018 at 5:35 AM Vijay Viswanath <vviswana@codeaurora.org>
wrote:



> On 5/22/2018 11:40 PM, Evan Green wrote:
> > On Thu, May 17, 2018 at 3:30 AM Vijay Viswanath <vviswana@codeaurora.org

> > wrote:
> >
> >> In addition to offsets of certain registers changing, the registers in
> >> core_mem have been shifted to HC mem as well. To access these
registers,
> >> define msm version specific functions. These functions can be loaded
> >> into the function pointers at the time of probe based on the msm
version
> >> detected.
> >
> >> Also defind new data structure to hold version specific Ops and
register
> >> addresses.
> >
> >> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> >> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> >> ---
> >>    drivers/mmc/host/sdhci-msm.c | 112
> > +++++++++++++++++++++++++++++++++++++++++++
> >>    1 file changed, 112 insertions(+)
> >
> >> diff --git a/drivers/mmc/host/sdhci-msm.c
b/drivers/mmc/host/sdhci-msm.c
> >> index 2524455..bb2bb59 100644
> >> --- a/drivers/mmc/host/sdhci-msm.c
> >> +++ b/drivers/mmc/host/sdhci-msm.c
> >> @@ -226,6 +226,25 @@ struct sdhci_msm_offset {
> >>           .core_ddr_config_2 = 0x1BC,
> >>    };
> >
> >> +struct sdhci_msm_variant_ops {
> >> +       u8 (*msm_readb_relaxed)(struct sdhci_host *host, u32 offset);
> >
> > I don't see any uses of msm_readb_relaxed or msm_writeb_relaxed in this
> > patch or the next one. Are these needed?

> They are not used as of now. Kept them since they can have use later.
> Felt it better to define base functions and addresses now itself.


I think we should remove these, unless you have an imminent patch queued up
where you're about to use them. The register definitions in patch 1 are one
thing, as those were nice info to have and difficult to derive later
without certain documents. But these byte functions could be easily added
again by anyone if they're needed. So I don't think they have value now.

-Evan
