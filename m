From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
 initialization
Date: Wed, 18 Apr 2012 11:19:18 -0700
Message-ID: <20120418181918.GL21106@atomide.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRsg-0004bX-4w@rmk-PC.arm.linux.org.uk>
 <CANrkHUajRzoCp7K8L3cJArWN3xdqpft8L4k-o4gFTRTo8nmhmg@mail.gmail.com>
 <20120418152956.GP25053@n2100.arm.linux.org.uk>
 <CANrkHUYvKdBUZh9UmWcE30ywAAiqhN-KcnSAE2T56WJLFPX1gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANrkHUYvKdBUZh9UmWcE30ywAAiqhN-KcnSAE2T56WJLFPX1gA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* T Krishnamoorthy, Balaji <balajitk@ti.com> [120418 08:39]:
> On Wed, Apr 18, 2012 at 8:59 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Apr 18, 2012 at 08:53:32PM +0530, T Krishnamoorthy, Balaji =
wrote:
> >> Hi,
> >>
> >> drivers/mmc/host/omap.c is also using dma_mask should that also be=
 removed
> >
> > Does this driver make use of this platform data?
> >
> > If so, it needs converting to DMA engine _before_ this patch (which=
 is
> > one reason why its a good idea to do these changes as separate patc=
hes...
> > as I've done.) =C2=A0It means stuff like this can be slotted in as =
necessary
> > in the patch order.

Can't we can just do this in drivers/mmc/host/omap.c:

- host->dev->dma_mask =3D &pdata->dma_mask;
+ host->dev->dma_mask =3D 0xffffffff;

And that way drop it from the platform data. Looks like some omap1
omap_mmc_platform_data don't have it set though, but we do have host->u=
se_dma =3D 1
set anyways in drivers/mmc/host/omap.c.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
