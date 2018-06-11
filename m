From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH V2 2/4] mmc: sdhci-msm: Add msm version specific ops and
 data structures
Date: Mon, 11 Jun 2018 14:23:02 -0700
Message-ID: <CAE=gft41G9tBHORVMeN1PbwLut+E2m2q1wcQ3G5bVHDZnhYXAg@mail.gmail.com>
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
 <1527587561-27448-3-git-send-email-vviswana@codeaurora.org> <e0157064-1dee-e3a6-e4a5-5d5f12d629e8@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e0157064-1dee-e3a6-e4a5-5d5f12d629e8@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com
Cc: vviswana@codeaurora.org, Ulf Hansson <ulf.hansson@linaro.org>, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, Bjorn Andersson <bjorn.andersson@linaro.org>, riteshh@codeaurora.org, vbadigan@codeaurora.org, Doug Anderson <dianders@google.com>, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 5, 2018 at 11:32 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 29/05/18 12:52, Vijay Viswanath wrote:
> > In addition to offsets of certain registers changing, the registers in
> > core_mem have been shifted to HC mem as well. To access these
> > registers, define msm version specific functions. These functions can
> > be loaded into the function pointers at the time of probe based on
> > the msm version detected.
> >
> > Also defind new data structure to hold version specific Ops and
> > register addresses.
> >
> > Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> > Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> > ---
> >  drivers/mmc/host/sdhci-msm.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> > index 4050c99..2a66aa0 100644
> > --- a/drivers/mmc/host/sdhci-msm.c
> > +++ b/drivers/mmc/host/sdhci-msm.c
> > @@ -226,6 +226,24 @@ struct sdhci_msm_offset {
> >       .core_ddr_config_2 = 0x1bc,
> >  };
> >
> > +struct sdhci_msm_variant_ops {
> > +     u8 (*msm_readb_relaxed)(struct sdhci_host *host, u32 offset);
> > +     u32 (*msm_readl_relaxed)(struct sdhci_host *host, u32 offset);
> > +     void (*msm_writeb_relaxed)(u8 val, struct sdhci_host *host, u32 offset);
> > +     void (*msm_writel_relaxed)(u32 val, struct sdhci_host *host,
> > +                     u32 offset);
> > +};

Since you removed the implementations, and these are also trivial to
re-derive, I'd suggest removing msm_readb_relaxed and
msm_writeb_relaxed members from the struct. Other than that, you can
add my Reviewed-by.
-Evan
