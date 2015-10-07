From: Tony Lindgren <tony@atomide.com>
Subject: Re: All OMAP platforms: MMC is broken
Date: Wed, 7 Oct 2015 06:26:42 -0700
Message-ID: <20151007132642.GV23801@atomide.com>
References: <20151005112304.GZ23801@atomide.com>
 <20151005143532.GA23801@atomide.com>
 <20151005145127.GB23801@atomide.com>
 <20151005171155.GF23801@atomide.com>
 <20151005183813.GD21626@n2100.arm.linux.org.uk>
 <20151006090015.GE21626@n2100.arm.linux.org.uk>
 <20151006094425.GM23801@atomide.com>
 <20151006150009.GF21626@n2100.arm.linux.org.uk>
 <20151006153710.GS23801@atomide.com>
 <20151007124551.GI21626@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151007124551.GI21626@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, "arm@kernel.org" <arm@kernel.org>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [151007 05:50]:
> On Tue, Oct 06, 2015 at 08:37:11AM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [151006 08:04]:
> > > On Tue, Oct 06, 2015 at 02:44:25AM -0700, Tony Lindgren wrote:
> > > > 
> > > > Hmm DT-based boot finds the MMC card for LDP, dmesg below from DT boot [1].
> > > > Looks like you're on on -rc4 and not -rc3. My guess is that MMC is not
> > > > working for you with DT-based booting because you don't seem to have
> > > > CONFIG_REGULATOR_PBIAS in your seed config for. Care to try enabling that
> > > > for both your omap3 and omap4 seed config files?
> > > 
> > > This is precisely the kind of crap I'm objecting to.  New kernel versions
> > > come along, and things break because people add extra Kconfig symbols that
> > > previous versions did not rely upon - and there's no communication of
> > > what's required for new kernel versions.
> > > 
> > > This stuff needs documenting, so that people are aware what changes they
> > > need to make - please put something in Documentation/arm/OMAP which
> > > tracks what new additions are required to the Kconfig to keep things
> > > working.
> > 
> > Good idea, how about something like the following? AFAIK that's the
> > only .config option needed as MFD_SYSCON is selected by Kconfig
> > already.
> 
> Right, that resolves the issue.  Now, what's the story on the revert
> and the other patch - have they already been taken for -rc kernels?

Not yet, I was waiting for the confirmation from you. I've now posted the
revert with proper description and the fix so Ulf can pick them up and
merged as regression fixes for the -rc series:

http://marc.info/?l=linux-omap&m=144422416621373&w=2
http://marc.info/?l=linux-omap&m=144422416921375&w=2

Regards,

Tony
