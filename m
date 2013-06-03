From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 02/10] clocksource: dw_apb_timer_of: add clock-handling
Date: Mon, 3 Jun 2013 09:51:08 +0200
Message-ID: <201306030951.09468.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de>
 <201306030056.37724.heiko@sntech.de> <20130603032219.GM11798@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130603032219.GM11798@tarshish>
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
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Am Montag, 3. Juni 2013, 05:22:19 schrieb Baruch Siach:
> Hi Heiko,
> =

> On Mon, Jun 03, 2013 at 12:56:37AM +0200, Heiko St=FCbner wrote:
> > Add the possibility to get the clock-frequency from a timer clock inste=
ad
> > of specifying it as dt property. Additionally also add the possibility
> > to also define a controlling periphal clock for the timer block.
> > =

> > The clock-frequency property is kept to act as fallback if no clocks
> > are specified.
> > =

> > Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> > ---
> > =

> >  Documentation/devicetree/bindings/rtc/dw-apb.txt |   19 ++++++++++++++=
++
> >  drivers/clocksource/dw_apb_timer_of.c            |   26
> >  +++++++++++++++++++++- 2 files changed, 44 insertions(+), 1
> >  deletions(-)
> > =

> > diff --git a/Documentation/devicetree/bindings/rtc/dw-apb.txt
> > b/Documentation/devicetree/bindings/rtc/dw-apb.txt index
> > 93e2b0f..80ab1c1 100644
> > --- a/Documentation/devicetree/bindings/rtc/dw-apb.txt
> > +++ b/Documentation/devicetree/bindings/rtc/dw-apb.txt
> > =

> > @@ -5,9 +5,20 @@ Required properties:
> >  - reg: physical base address of the controller and length of memory
> >  mapped
> >  =

> >    region.
> >  =

> >  - interrupts: IRQ line for the timer.
> > =

> > +- either clocks+clock-names or clock-frequency properties
> > +
> > +Optional properties:
> > +- clocks	: list of clock specifiers, corresponding to entries in
> > +		  the clock-names property;
> > +- clock-names	: should contain "timer and "pclk" entries, matching
> > entries
> =

> Missing closing quotes around "timer".

thanks for finding ... will fix in the next run
