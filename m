From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
Date: Wed, 19 Jun 2019 15:38:47 +0200
Message-ID: <CAPDyKFqb3uRU1XbrioSw6UZ5atZ8WwZNhQ_yq2+3JfxXZCxr7g@mail.gmail.com>
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
 <5feac3fb-bef3-b7d1-57d6-81e115e1f555@xilinx.com> <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
 <MN2PR02MB6029DB87CEE32655B0F1E794C1E50@MN2PR02MB6029.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MN2PR02MB6029DB87CEE32655B0F1E794C1E50@MN2PR02MB6029.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Manish Narani <MNARANI@xilinx.com>
Cc: Michal Simek <michals@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>, Nava kishore Manne <navam@xilinx.com>, Olof Johansson <olof@lixom.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 19 Jun 2019 at 10:40, Manish Narani <MNARANI@xilinx.com> wrote:
>
> Hi Uffe,
>
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Monday, June 17, 2019 5:51 PM
> [...]
> >
> > The "const struct zynqmp_eemi_ops *eemi_ops; should then be moved into
> > a clock provider specific struct, which is assigned when calling
> > sdhci_arasan_register_sdclk. I understand that all the clock data is
> > folded into struct sdhci_arasan_data today, but I think that should be
> > moved into a "sub-struct" for the clock specifics.
> >
> > Moreover, when registering the clock, we should convert from using
> > devm_clk_register() into devm_clk_hw_register() as the first one is
> > now deprecated.
>
> Just a query here:
> When we switch to using devm_clk_hw_register() here, it will register the clk_hw and return int.
> Is there a way we can get the clk (related to the clk_hw registered) from the
> clock framework?
> I am asking this because we will need that clk pointer while calling clk_set_phase() function.

I assume devm_clk_get() should work fine?

Kind regards
Uffe
