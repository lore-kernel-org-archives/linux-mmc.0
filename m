From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/8] mmc: omap_hsmmc: release correct resource
Date: Sat, 21 Apr 2012 10:48:49 +0100
Message-ID: <20120421094849.GZ25053@n2100.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk> <E1SKRrh-0004bL-3j@rmk-PC.arm.linux.org.uk> <20120420222305.GI21106@atomide.com> <878vhqggbc.fsf@laptop.org> <871unhhkvk.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871unhhkvk.fsf@laptop.org>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Apr 20, 2012 at 10:35:59PM -0400, Chris Ball wrote:
> Hi,
> 
> On Fri, Apr 20 2012, Chris Ball wrote:
> > On Fri, Apr 20 2012, Tony Lindgren wrote:
> >> * Russell King <rmk+kernel@arm.linux.org.uk> [120418 03:15]:
> >>> res can be one of several resources, as this variable is re-used several
> >>> times during probe.  This can cause the wrong resource parameters to be
> >>> passed to release_mem_region().
> >>> 
> >>> Get the original memory resource before calling release_mem_region().
> >>> 
> >>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >>
> >> Acked-by: Tony Lindgren <tony@atomide.com>
> >
> > Thanks, pushed to mmc-next for 3.4.
> 
> (Actually, that's premature of me, sorry -- just noticed that this
> is part of an RFC patchset.  I'll wait for the rest of the patches.)

It was previously posted as an entirely separate patch - the reason its
part of this RFC is because I needed the patch while developing this
series.  So please go ahead and take _this_ patch.
