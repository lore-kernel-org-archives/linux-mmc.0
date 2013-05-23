From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH V3 00/10] mmc_of_parse() adaptations, DT support for
 Sheevaplugs
Date: Thu, 23 May 2013 07:23:35 -0400
Message-ID: <20130523112335.GN31290@titan.lakedaemon.net>
References: <1369090911-1479-1-git-send-email-gmbnomis@gmail.com>
 <20130521131455.GP31290@titan.lakedaemon.net>
 <20130522192501.GC25367@schnuecks.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130522192501.GC25367-2BA9cf72eNkOIzVOb1FTxg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, May 22, 2013 at 09:25:02PM +0200, Simon Baatz wrote:
> Hi Jason,
> 
> On Tue, May 21, 2013 at 09:14:55AM -0400, Jason Cooper wrote:
> > On Tue, May 21, 2013 at 01:01:41AM +0200, Simon Baatz wrote:
> > > Hi,
> > > 
> > > 	V3 changes:
> > > 	- Patch 01/10: Added EPROBE_DEFER case to mmc_of_parse() 
> > > 	- Added Acked-By to (unmodified) patches 02 and 03.
> > > 
> > > 	V2 changes:
> > > 	- Converted mvsdio to use mmc_of_parse()
> > > 	- Adapted DTS files using mvsdio accordingly
> > > 	- Changed mmc_of_parse() to return errors to the caller
> > > 
> > > While adding DT support for the Sheevaplugs by Globalscale Technologies
> > > (Kirkwood), it turned out that the DT binding of mvsdio lacked features to
> > > properly support the hardware (active high/low of CD and WP pins could not
> > > be described in DT).
> > > 
> > > This is standard functionality provided by the mmc_of_parse() helper
> > > function.  However, mmc_of_parse() may allocate GPIO lines.  If the
> > > allocation fails, it outputs an error, but does not return an error to its
> > > caller.  Therefore, a proposal to handle errors in mmc_of_parse() is made.
> > > 
> > > The patch set is structured as follows:
> > > 
> > > 1   Adapt mmc_of_parse() to return errors
> > > 2-6 Handle errors in current drivers using mmc_of_parse() (compile tested
> > >     only)
> > > 7-8 Convert mvsdio and respective dts files to mmc_of_parse() (tested on
> > >     kirkwood)
> > > 9   Add dts files for (eSATA) Sheevaplug
> > > 10  Add DT support for (eSATA) Sheevaplug
> > 
> > Patches 7, 9, and 10 already pulled into mvebu/dt.  You can drop those
> > from this series if you need to do another revision.
> 
> If you don't mind too much, as this crosses two trees, I would prefer
> to keep the series "self-contained" if people want to test.

That's fine, you can host the series in a single branch for folks to
pull and test.  From our side, 7, 9 and 10 need to go through arm-soc,
and the rest need to go through -mmc.  There is _no_ build or merge
dependency between the two.

> Additionally, I have two Acked-bys for 9 and 10 from Andrew that are
> not part of the patches yet.

Yes, I saw those after I sent the PR.  I sent that a little too fast.
I'm developing a new system and still working out the kinks.  Sorry
about that.

> > > I could only test on an eSATA Sheevaplug. I found patches with
> > > different LEDs for the Sheevaplug.  Thus, I would highly appreciate if
> > > someone with the hardware could give this a spin on a non-eSATA
> > > version.  
> > 
> > I happen to have one.  Unfortunately, it is currently my primary email
> > server, dhcp, dns, file server, and a few other irreplaceable things. :(
> > I *really* need to upgrade/reconfigure ...

FYI:

$ uname -r
2.6.30.2

Yikes.  I'm so embarrassed.  :(  However,

$ uptime
 07:16:42 up 251 days, 0 min,...

before that was over 400 days, then I had an ups failure.

> Even without reinstalling, can you please have a look if your
> "plug:green:health" LED is really green (mine is blue)?  And if your
> kernel already has a "plug:red:misc" LED could you verify whether it
> is really there?  Do you happen to know which board revision you
> have?

I have one directory under /sys/class/leds, plug:green:health.  It
controls a *blue* led.  There is also a green led, not enumerated.  I'm
sure the results would be better with a more recent kernel...

thx,

Jason.
