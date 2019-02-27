From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: mmci: add quirk property to add stm32 transfer mode
Date: Wed, 27 Feb 2019 10:11:17 +0100
Message-ID: <CAPDyKFpgvLdcmpFkhAm8vPNZruF9e6GT8wnhpLQYsG9L=h_5Cg@mail.gmail.com>
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
 <20190221102739.cc37au6elqu6gvfe@shell.armlinux.org.uk> <20190221103049.tspc5igoe6wmt3jd@shell.armlinux.org.uk>
 <a736b773-d6e6-eb81-90d6-ebeab7b401cb@st.com> <20190221140300.y3tunrvsh3gyig5f@shell.armlinux.org.uk>
 <9c88d76c-2080-71b1-c9c6-c24d0f0aeb91@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9c88d76c-2080-71b1-c9c6-c24d0f0aeb91@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic BARRE <ludovic.barre@st.com>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>, DTML <devicetree@vger.kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 25 Feb 2019 at 11:49, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Russell & Ulf
>
> On 2/21/19 3:03 PM, Russell King - ARM Linux admin wrote:
> > On Thu, Feb 21, 2019 at 02:38:36PM +0100, Ludovic BARRE wrote:
> >> hi Russell & Ulf
> >>
> >> On 2/21/19 11:30 AM, Russell King - ARM Linux admin wrote:
> >>> On Thu, Feb 21, 2019 at 10:27:39AM +0000, Russell King - ARM Linux admin wrote:
> >>>> On Thu, Feb 21, 2019 at 11:10:49AM +0100, Ludovic Barre wrote:
> >>>>> From: Ludovic Barre <ludovic.barre@st.com>
> >>>>>
> >>>>> This patch series introduces a bitmap of hardware quirks that require
> >>>>> some special action. This should reduce the number of boolean
> >>>>> into variant structure.
> >>>>> And adds quirk bit to define sdmmc specific transfer modes.
> >>>>
> >>>> Please find some other way to deal with these differences.  As far as
> >>>> I'm concerned, introducing a quirk bitmask such as what was done in
> >>>> sdhci is a complete disaster and leads to long-term maintanability
> >>>> problems.
> >>>>
> >>>> We already have a way to deal with variants in mmci.
> >>>
> >>> ... to finish what I was saying ...
> >>>
> >>> and I think that:
> >>>
> >>>           if (variant->blksz_datactrl16)
> >>>                   datactrl = variant->datactrl_dpsm_enable | (data->blksz << 16);
> >>>           else if (variant->blksz_datactrl4)
> >>>                   datactrl = variant->datactrl_dpsm_enable | (data->blksz << 4);
> >>>           else
> >>>                   datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
> >>>
> >>> ought to become a variant function call which returns the appropriate
> >>> datactrl value.  This would shrink the amount of variant testing in this
> >>> path, and also means that going forward we aren't facing an endlessly
> >>> increasing number of tests here.
> >>
> >> For blksz_datactrl case:
> >> We could create an inline function for datactrl16 and blksz_datactrl4
> >> which returns the appropriate datactrl value (specific for ux500v2 and
> >> qcom). This function could be register in mmci_host_ops structure.
> >
> > Yes, this is what I'm proposing (except for the "inline" bit which
> > seems meaningless if it's called via the mmci_host_ops structure.)
> > I'm also proposing that it shouldn't just be the blksz that's
> > returned but anything that the variant needs to take account of,
> > including the stm transfer mode.
>
> Ulf, are you alright with this callback approach (just to be sure that
> every body is align, before send a patch)?

Go ahead, let's see how it looks!

>
> This mmci_host_ops callback could return datactrl config to
> start data (defined by variant).

Yes.

[...]

Kind regards
Uffe
