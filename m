From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 23/38] mmc: sdhci: convert sdhci_set_uhs_signaling()
	into a library function
Date: Wed, 18 Jun 2014 00:42:26 +0100
Message-ID: <20140617234226.GP23430@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk> <E1Wd2Wd-0003vp-S2@rmk-PC.arm.linux.org.uk> <20140616104615.GA10701@n2100.arm.linux.org.uk> <CAPDyKFrp8JokqBbo3rg2i6WYykU1C9CuPF0FL7AOHh=Gcp5=hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:33393 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754403AbaFQXml (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jun 2014 19:42:41 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFrp8JokqBbo3rg2i6WYykU1C9CuPF0FL7AOHh=Gcp5=hg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Barry Song <baohua@kernel.org>, spear-devel@list.st.com, Stephen Warren <swarren@wwwdotorg.org>, Anton Vorontsov <anton@enomsg.org>, Michal Simek <michal.simek@xilinx.com>, Thierry Reding <thierry.reding@gmail.com>, Viresh Kumar <viresh.linux@gmail.com>, Ben Dooks <ben-linux@fluff.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jun 16, 2014 at 02:17:30PM +0200, Ulf Hansson wrote:
> On 16 June 2014 12:46, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Wed, Apr 23, 2014 at 08:08:07PM +0100, Russell King wrote:
> >> @@ -1507,25 +1529,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
> >>                       host->ops->set_clock(host, host->clock);
> >>               }
> >>
> >> -             if (host->ops->set_uhs_signaling)
> >> -                     host->ops->set_uhs_signaling(host, ios->timing);
> >> -             else {
> >> -                     ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> >> -                     /* Select Bus Speed Mode for host */
> >> -                     ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
> >> -                     if ((ios->timing == MMC_TIMING_MMC_HS200) ||
> >> -                         (ios->timing == MMC_TIMING_UHS_SDR104))
> >> -                             ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
> >> -                     else if (ios->timing == MMC_TIMING_UHS_SDR12)
> >> -                             ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
> >> -                     else if (ios->timing == MMC_TIMING_UHS_SDR25)
> >> -                             ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
> >> -                     else if (ios->timing == MMC_TIMING_UHS_SDR50)
> >> -                             ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> >> -                     else if (ios->timing == MMC_TIMING_UHS_DDR50)
> >> -                             ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
> >> -                     sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> >> -             }
> >> +             host->ops->set_uhs_signaling(host, ios->timing);
> >>
> >>               if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
> >>                               ((ios->timing == MMC_TIMING_UHS_SDR12) ||
> >
> > Whoever decided to poorly pick these patches up against my will has
> > slightly messed this patch up - whereas my original patch left the
> > code correctly formatted, when whoever applied this patch did so, they
> > left an additional blank line in the above.
> 
> Hi Russell,
> 
> We kindly pinged you several times asking for your state and for the
> PR, but I suppose you were just too busy. Your PR were kind of
> blocking patches for sdhci, if you remember.

I wasn't "too busy".  I had walked away from all kernel maintanence in
disgust at the way many in the ARM community ignores questions, and
ignores patches which need testing - I'm talking there about the L2C
patch series which was extremely poorly tested, and still, to this day,
has questions outstanding.  Yes, the code now produces warnings.  It
produces warnings /because/ people were not willing to help.

Those warnings serve as a reminder that there's still problems which
need solving there, and they're not going to go away until those
problems are solved.

While I don't like pushing unfinished code into mainline, in this case,
others deemed the patch set too important _not_ to go into mainline
even with these problems.

Now, it's been /soo/ long since I worked on that patch set that my
knowledge has now diminished... so it's now going to be _much_ harder
to resolve those issues than it would have been three months ago.

And I'm also holding a grudge, and I bear grudges for a long time, so
expect me to be "difficult" towards Linux stuff for a while yet.

> The mmc people were also very helping in sending patches to fixup
> related regressions, immediately after we merged your patchset. Thus
> together I think we managed to pull it off.

The formatting problem I refer to above is line 1532/1533 in sdhci.c -
there's an additional blank line which somehow got left behind, caused
presumably by insufficient attention paid to cleaning up a conflict
between my original patches and the state of the tree they were
applied to.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
