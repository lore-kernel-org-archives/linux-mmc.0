From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 06/15] omap zoom2: wlan board muxing
Date: Thu, 8 Jul 2010 23:12:53 +0300
Message-ID: <AANLkTikHwy5d1-Wamt-dmjPRlrwyzuKw_9eJEN01SvBE@mail.gmail.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-7-git-send-email-ohad@wizery.com> <2A3DCF3DA181AD40BDE86A3150B27B6B030E10C9B3@dbde02.ent.ti.com>
	<20100708094548.GB1920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100708094548.GB1920@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Luciano Coelho <luciano.coelho@nokia.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, San Mehat <san@google.com>, "Ben-cohen, Ohad" <ohadb@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jul 8, 2010 at 12:45 PM, Tony Lindgren <tony@atomide.com> wrote=
:
>
> * Ghorai, Sukumar <s-ghorai@ti.com> [100708 06:34]:
> > > @@ -71,6 +71,21 @@ static struct twl4030_platform_data zoom2_twld=
ata =3D {
> > >
> > > =A0#ifdef CONFIG_OMAP_MUX
> > > =A0static struct omap_board_mux board_mux[] __initdata =3D {
> > > +#ifdef CONFIG_OMAP_ZOOM_WLAN
> >
> > [Ghorai] This is zoom board specific file, So why need this additio=
nal flag?
>
> Good point, the ifdef is unnecessary in for both zoom2 and zoom3.
> Will update in my queue to remove the ifdefs.

Thanks a lot, Tony.

>
> Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
