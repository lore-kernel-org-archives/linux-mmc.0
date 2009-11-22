From: Wouter van Heyst <larstiq@larstiq.dyndns.org>
Subject: Bug#504391: [PATCH] mmc: add module parameter to set whether cards are assumed removable
Date: Sun, 22 Nov 2009 12:42:35 +0100
Message-ID: <20091122114234.GA28590@one.lan>
References: <1257914676.2237.57.camel@localhost> <20091116122329.847916b6.akpm@linux-foundation.org> <1258410709.2792.9.camel@localhost>
Reply-To: Wouter van Heyst <larstiq@larstiq.dyndns.org>, 504391@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.504391.B504391.125889018218827@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <1258410709.2792.9.camel@localhost>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 504391@bugs.debian.org, Pierre Ossman <pierre@ossman.eu>
List-Id: linux-mmc@vger.kernel.org

On Mon, Nov 16, 2009 at 10:31:49PM +0000, Ben Hutchings wrote:
> On Mon, 2009-11-16 at 12:23 -0800, Andrew Morton wrote:
> > On Wed, 11 Nov 2009 04:44:36 +0000
> > Ben Hutchings <ben@decadent.org.uk> wrote:
> > 
> > > Some people run general-purpose distribution kernels on netbooks with
> > > a card that is physically non-removable or logically non-removable
> > > (e.g. used for /home) and cannot be cleanly unmounted during suspend.
> > > Add a module parameter to set whether cards are assumed removable or
> > > non-removable, with the default set by CONFIG_MMC_UNSAFE_RESUME.
> > > 
> > 
> > The description really doesn't give me enough info to work out what's
> > happening here and why this is being proposed.  But it smells nasty.
> 
> In general, it is not possible to tell whether a card present in an MMC
> slot after resume is the same that was there before suspend.  So there
> are two possible behaviours, each of which will cause data loss in some
> cases:
> 
> CONFIG_MMC_UNSAFE_RESUME=n (default): Cards are assumed to be removed
> during suspend.  Any filesystem on them must be unmounted before
> suspend; otherwise, buffered writes will be lost.
> 
> CONFIG_MMC_UNSAFE_RESUME=y: Cards are assumed to remain present during
> suspend.  They must not be swapped during suspend; otherwise, buffered
> writes will be flushed to the wrong card.
> 
> Currently the choice is made at compile time and this allows that to be
> overridden at module load time.

I'm running 2.6.32-rc7 with this patch applied and CONFIG_MMC_UNSAFE_RESUME=y
That works as desired for my non-removable case. Is it desired that I
test if 'removable=1' will thrash my filesystem?

Wouter van Heyst
