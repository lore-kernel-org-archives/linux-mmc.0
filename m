From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 5/8] mmc: dw_mmc: dt-binding: Add tuning related things
Date: Wed, 02 Sep 2015 09:41:27 +0200
Message-ID: <2716742.hZCgYT9c9i@phil>
References: <1441045446-30858-1-git-send-email-heiko@sntech.de>
 <1441045446-30858-6-git-send-email-heiko@sntech.de>
 <55E682C0.6050204@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <55E682C0.6050204-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Alexandru M Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Jaehoon,

Am Mittwoch, 2. September 2015, 14:01:52 schrieb Jaehoon Chung:
> Hi, Heiko.
> 
> On 09/01/2015 03:24 AM, Heiko Stuebner wrote:
> > From: Alexandru M Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > 
> > Add ciu_drv, ciu_sample clocks and default-sample-phase. This will later
> > be used by tuning code.
> 
> As i know, ciu_drv and ciu_sample clocks are generated with "ciu" clock.
> But in these patch-set, ciu_drv and ciu_sample are controlled by clock
> framework. It's a little strange.
> Are there ciu_drv and ciu_sample clock on Rockchip?

Yes on Rockchip SoCs the drv and sample clock registers are residing inside 
the clock controller and not in the dw_mmc block.

See drivers/clk/rockchip/clk-mmcphase.c and clk-rk3288.c around line 490 .


Heiko

> > We do not touch ciu_drive (and by extension define default-drive-phase).
> > Drive phase is mostly used to define minimum hold times, while one could
> > write some code to determine what phase meets the minimum hold time
> > (ex 10 degrees) this will not work with the current clock phase framework
> > (which floors angles, so we'll get 0 deg, and there's no way to know what
> > resolution the floors happen at). We assume that the default drive angles
> > set by the hardware are good enough.
> > 
> > Signed-off-by: Alexandru M Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> > ---
> > 
> >  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 14
> >  ++++++++++---- 1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> > b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt index
> > 346c609..5edadc2 100644
> > --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> > 
> > @@ -42,11 +42,13 @@ Optional properties:
> >  * clocks: from common clock binding: handle to biu and ciu clocks for the
> >  
> >    bus interface unit clock and the card interface unit clock.
> > 
> > -* clock-names: from common clock binding: Shall be "biu" and "ciu".
> > -  If the biu clock is missing we'll simply skip enabling it.  If the
> > -  ciu clock is missing we'll just assume that the clock is running at
> > +* clock-names: from common clock binding: Shall be "biu", "ciu",
> > "ciu_drv" and +  "ciu_sample".  If the biu clock is missing we'll simply
> > skip enabling it. +  If the ciu clock is missing we'll just assume that
> > the clock is running at> 
> >    clock-frequency.  It is an error to omit both the ciu clock and the
> > 
> > -  clock-frequency.
> > +  clock-frequency.  "ciu_drv" and "ciu_sample" are used to control the
> > clock +  phases, "ciu_sample" is required for tuning high speed modes (if
> > no other +  custom tuning method is defined).
> > 
> >  * clock-frequency: should be the frequency (in Hz) of the ciu clock.  If
> >  this>  
> >    is specified and the ciu clock is specified then we'll try to set the
> >    ciu
> > 
> > @@ -75,6 +77,10 @@ Optional properties:
> >  * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
> >  
> >    specified we'll defer probe until we can find this regulator.
> > 
> > +* default-sample-phase: The default phase to set ciu_sample at probing,
> > low +  speeds or in case where all phases work at tuning time. If not
> > specified +  0 deg will be used.
> > +
> > 
> >  Aliases:
> >  
> >  - All the MSHC controller nodes should be represented in the aliases node
> >  using
