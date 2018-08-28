From: Aapo Vienamo <avienamo@nvidia.com>
Subject: Re: [PATCH v2 25/40] mmc: sdhci: Add a quirk to disable card clock
 during tuning
Date: Tue, 28 Aug 2018 18:41:29 +0300
Message-ID: <20180828184129.525439ba@dhcp-10-21-25-168>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
        <1533924522-1037-26-git-send-email-avienamo@nvidia.com>
        <b0b761ac-00fb-5a79-7a38-89b08c620c02@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b0b761ac-00fb-5a79-7a38-89b08c620c02@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 27 Aug 2018 14:25:44 +0300
Adrian Hunter <adrian.hunter@intel.com> wrote:

> On 10/08/18 21:08, Aapo Vienamo wrote:
> > Add a quirk to disable card clock when the tuning command is sent.
> > 
> > This has to be done to prevent the SDHCI controller from hanging on
> > Tegra210. Without the quirk enabled there appears to be around 10%
> > chance that the tuning sequence will fail and time out due to the
> > controller locking up.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >  drivers/mmc/host/sdhci.c | 15 +++++++++++++++
> >  drivers/mmc/host/sdhci.h |  2 ++
> >  2 files changed, 17 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 04dc443..166b16f 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2175,6 +2175,7 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
> >  	struct mmc_request mrq = {};
> >  	unsigned long flags;
> >  	u32 b = host->sdma_boundary;
> > +	u16 clk;
> >  
> >  	spin_lock_irqsave(&host->lock, flags);
> >  
> > @@ -2183,6 +2184,13 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
> >  	cmd.mrq = &mrq;
> >  
> >  	mrq.cmd = &cmd;
> > +
> > +	if (host->quirks2 & SDHCI_QUIRK2_TUNE_DIS_CARD_CLK) {
> > +		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +		clk &= ~SDHCI_CLOCK_CARD_EN;
> > +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);  
> 
> Rather than using a quirk, could you use the sdhci I/O accessors to disable
> the clock before the tuning comment is written, udelay(1), and then enable
> it again?

This was the way it was implemented in the downstream kernel. However,
doing it in the IO accessor when a tuning command is sent seems to work
too.

 -Aapo
