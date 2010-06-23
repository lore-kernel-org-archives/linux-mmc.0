From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: MMC tree (Was: Re: [PATCH 1/2] MMC: fix all hangs
 related to mmc/sd card insert/removal during suspend/resume.)
Date: Tue, 22 Jun 2010 20:52:23 -0700
Message-ID: <20100622205223.b84736c8.akpm@linux-foundation.org>
References: <1276809695.28201.13.camel@maxim-laptop>
	<201006221119.06210.rjw@sisk.pl>
	<1277241450.10907.4.camel@maxim-laptop>
	<201006222353.21349.rjw@sisk.pl>
	<20100622152006.d0ec0cef.akpm@linux-foundation.org>
	<20100623130837.eaa40f99.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100623130837.eaa40f99.sfr@canb.auug.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Pierre@smtp1.linux-foundation.org, Ossman <drzeus-list@drzeus.cx>, linux-pm <linux-pm@lists.linux-foundation.org>, Philip Langdale <philipl@overt.org>, Adrian Hunter <adrian.hunter@nokia.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 23 Jun 2010 13:08:37 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Andrew,
> 
> On Tue, 22 Jun 2010 15:20:06 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 22 Jun 2010 23:53:21 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > >
> > > Andrew, who's maintaining MMC now?
> > 
> > Pierre stopped doing it, so I'm now pretending to.
> 
> So I guess I should remove the mmc tree (currently empty) from
> linux-next, then?

yup.

> > I actually pretend to maintain a huge number of subsystems and should
> > sprinkle akpms all over MAINTAINERS so stuff doesn't get lost.
> 
> How about splitting these subsystems out of -mm and adding them to
> linux-next?

Sigh.  Need to get onto that.  I suppose you'd prefer something that
actually compiles a bit, too.
