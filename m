From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] mmc: move regulator handling to core
Date: Mon, 14 Dec 2009 21:44:08 -0800
Message-ID: <200912142144.08591.david-b@pacbell.net>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de> <4B181BB4.1020800@nokia.com> <20091204115805.GS14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751974AbZLOFoN@vger.kernel.org>
In-Reply-To: <20091204115805.GS14091@buzzloop.caiaq.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Pierre Ossman <pierre@ossman.eu>, Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>, Eric Miao <eric.y.miao@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Cliff Brake <cbrake@bec-systems.com>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Friday 04 December 2009, Daniel Mack wrote:
> On Thu, Dec 03, 2009 at 10:12:36PM +0200, Adrian Hunter wrote:
> > Daniel Mack wrote:
> > >On Thu, Dec 03, 2009 at 04:27:39PM +0200, Adrian Hunter wrote:
> 
> > >>What about arch/arm/mach-omap2/mmc-twl4030.c ?
> > >
> > >Argh, missed that one. And this particular case doesn't fit to my
> > >modifications. I don't know the code well ...  We would need to
> > >have a struct mmc_host * in all the functions there calling
> > >mmc_regulator_{set,get}_ocr. Any idea how to resolve that?

Finish separating the HSMMC setup from the OMAP2 setup, then the
HSMMC stuff will be a lot easier to cope with.  The HSMMC stuff
is never used with the mfd/menelaus transceiver/slot switch stuff;
including those data structures caused lots of hassles.

The only real issue with the HSMMC stuff is that it's got to continue
working with the many wiring options now in use.


> Moving the regulator handling to the mmc core would require a major
> cleanup to all this code, but I don't have such hardware to test my
> modifications. Can anyone help here?

Simplest to borrow a Beagle.  Make sure whatever you do
can handle both standard SDHC cards, and also 8-bit HSMMC.
Once that works, the rest will fall out pretty easily.

- Dave
