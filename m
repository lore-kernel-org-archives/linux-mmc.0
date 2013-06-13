From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 06/10] mmc: omap_hsmmc: add support for pbias
 configuration in dt
Date: Thu, 13 Jun 2013 09:29:38 -0700
Message-ID: <20130613162937.GK8164@atomide.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
 <1370546059-24181-7-git-send-email-balajitk@ti.com>
 <CACRpkdZAzAJW0UxGCSj-PWXTSi2Q6T8fqL9SQ+Y-91sELQ3SRQ@mail.gmail.com>
 <20130613095353.GX8164@atomide.com> <51B9DA30.1090308@ti.com>
 <CACRpkdY6cZ+bT-C9Go3sZVw6ErQqTm0m9__uKQrkg4eUU1thHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdY6cZ+bT-C9Go3sZVw6ErQqTm0m9__uKQrkg4eUU1thHA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

* Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [130613 08:35]:
> On Thu, Jun 13, 2013 at 4:41 PM, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org> wrote:
> 
> > You mean regulator via pinctrl APIs, I think It will just move the code
> > from omap_hsmmc to a new regulator file with it own init data for pinctrl.
> 
> No I'm not saying you should use pinctrl as a "back-end" for this.
> I mean you shall instantiate a regulator and let the callback ops
> vtable for that regulator poke these bits.

The interface to omap_hsmmc.c should be the regulator framework. This
is because it allows us to clean up all the messed up before and after
functions that really implement various GPIO regulators etc.

> > It thought pinctrl-single,bits in pinctrl-single.c is introduced
> > precisely for such misc control register which has bit configuration
> > affecting different module i/o pads.
> 
> No. If we go down that road *anything* that is connected to a
> pad becomes part of the pinctrl subsystem, then pinctrl-single
> becomes some kind of hardware abstraction or BIOS, and that
> is *not* the intent. It is only supposed to deal with the bits
> there that are 100% related to what pinctrl does, nothing else.

Sounds like the way to go is to do a standalone regulator driver that
optionally uses pinctrl-single,bits. But only for the bits in the PBIAS
register that are 100% related to pinctrl.

In any case the PBIAS regulator driver should be a separate driver
as it may need to be a child of the SCM driver for PM needs in the
future.

Regards,

Tony
