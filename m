From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Boost controller core clock
Date: Fri, 6 Nov 2015 15:39:13 -0800
Message-ID: <20151106233913.GB30882@usrtlx11787.corpusers.net>
References: <1436183618-15330-1-git-send-email-ivan.ivanov@linaro.org>
 <CAJAp7OjdiD_x0aU89HNq8PCiGqs+fvATHuVARxU4gE4yVusRNg@mail.gmail.com>
 <CAPDyKFpQ2oK49ZwaBuk9bUPDEpzSyic2d1L9Qj2t8D1+wmDYtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpQ2oK49ZwaBuk9bUPDEpzSyic2d1L9Qj2t8D1+wmDYtA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bjorn Andersson <bjorn@kryo.se>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri 06 Nov 00:10 PST 2015, Ulf Hansson wrote:

> On 6 November 2015 at 02:42, Bjorn Andersson <bjorn@kryo.se> wrote:
> > On Mon, Jul 6, 2015 at 4:53 AM, Ivan T. Ivanov <ivan.ivanov@linaro.org> wrote:
> >> Ensure SDCC is working with maximum clock otherwise card
> >> detection could be extremely slow, up to 7 seconds.
> >>
> >> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> >> Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>
> >> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> >> ---
> >>
> >> Changes since v0:
> >> - s/falied/failed in warning message.
> >>
> >>  drivers/mmc/host/sdhci-msm.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> >> index 4a09f76..4bcee03 100644
> >> --- a/drivers/mmc/host/sdhci-msm.c
> >> +++ b/drivers/mmc/host/sdhci-msm.c
> >> @@ -489,6 +489,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
> >>                 goto pclk_disable;
> >>         }
> >>
> >> +       /* Vote for maximum clock rate for maximum performance */
> >> +       ret = clk_set_rate(msm_host->clk, INT_MAX);
> >> +       if (ret)
> >> +               dev_warn(&pdev->dev, "core clock boost failed\n");
> >> +
> >
> > On my 8974AC devices this results in GCC_SDCC1_APPS_CLK changing from
> > 100MHz to 200MHz for my eMMC. Unfortunately this results in the
> > following error:
> >
> > [    5.103241] mmcblk0: retrying because a re-tune was needed
> > [    5.109270] mmcblk0: error -84 transferring data, sector 5816322,
> > nr 2, cmd response 0x900, card status 0xc00
> >
> > Looking at the board specification it's stated that these card should
> > run in DDR50, so I've tried specifying "max-frequency" in the dt. I
> > verified in sdhci_set_clock() that we get a divisor of 4, but the
> > result is a repetition of:
> 
> I don't follow. Are you saying that changing the clock frequency to
> 200MHz caused the card to be initialized in HS200 mode instead of
> DDR50?
> 

No, we clock the sdhci block at 100MHz, the host->max_clk is 200MHz and
the divisor in sdhci_set_clock() becomes 1. So if I read this correctly
we're running HS200 at 100MHz.

Bumping the clock rate to 200MHz at the block doesn't affect the max_clk
and hence we're trying to run the bus at 200MHz.

I therefor tried to just set "max-frequency" to 50MHz, getting the
divider to be 4 and the below error.

So I assume it just happened to work at 100MHz, but 200MHz is way off
from the 50MHz the board is designed and tested for.


Unfortunately I don't have the equipment to measure these assumptions :/

> >
> > [    1.702312] mmc1: Switching to 3.3V signalling voltage failed
> > [    1.837987] mmc1: power class selection to bus width 8 ddr 0 failed
> > [    1.846227] mmc1: error -110 whilst initialising MMC card
> > [    1.946303] mmc1: Reset 0x1 never completed.
> >
> > I tried to disable HS200 by specifying SDHCI_QUIRK2_BROKEN_HS200. This
> > makes the card come up nicely again.
> >
> >
> > Is there any other way to force the link to DDR50? Is it acceptable to
> > expose the broken-hs200 quirk in dt so I can use that for now?
> 
> We already have these DT bindings.
> - mmc-ddr-1_8v: eMMC high-speed DDR mode(1.8V I/O) is supported
> - mmc-ddr-1_2v: eMMC high-speed DDR mode(1.2V I/O) is supported
> - mmc-hs200-1_8v: eMMC HS200 mode(1.8V I/O) is supported
> - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
> 
> Can't we use these instead?
> 

These are all additive and the hardware is correctly advertising that
it's capable of supporting SDR104, which implies HS200. Dropping this
assumption (or unsetting these bits) drops us down to the high-speed
rates and things work again.

Regards,
Bjorn
