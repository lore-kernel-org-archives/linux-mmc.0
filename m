From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v8 1/2] sDMA: descriptor autoloading feature
Date: Thu, 6 May 2010 13:21:49 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C538737A@dbde02.ent.ti.com>
References: <l2i618f0c911004291035ja334efb0o5016c5cb70c4b5bc@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D1@dbde02.ent.ti.com>
	 <k2l618f0c911005050450t75968621m61e3ff39e90d20ad@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C52D1806@dbde02.ent.ti.com>
 <i2r618f0c911005050925h253532c7wb758ac7781840b4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <i2r618f0c911005050925h253532c7wb758ac7781840b4c@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of Ven=
katraman S
> Sent: Wednesday, May 05, 2010 9:56 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org; linux-arm-=
kernel@lists.infradead.org;
> Chikkature Rajashekar, Madhusudhan; Adrian Hunter; Tony Lindgren
> Subject: Re: [PATCH v8 1/2] sDMA: descriptor autoloading feature
>=20
> On Wed, May 5, 2010 at 5:31 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of =
Venkatraman S
> >> Sent: Wednesday, May 05, 2010 5:20 PM
> >> To: Shilimkar, Santosh
> >> Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org; linux-a=
rm-kernel@lists.infradead.org;
> >> Chikkature Rajashekar, Madhusudhan; Adrian Hunter; Tony Lindgren
> >> Subject: Re: [PATCH v8 1/2] sDMA: descriptor autoloading feature
> >>
> >> [Long sections have been trimmed to the context of the discussion]
> >> On Wed, May 5, 2010 at 3:02 PM, Shilimkar, Santosh
> >> <santosh.shilimkar@ti.com> wrote:
> >> >> -----Original Message-----
> >> >> +static int dma_sglist_set_phy_params(struct omap_dma_sglist_no=
de *sghead,
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 dma_addr_t phyaddr, int nelem)
> >> >> +{
> >> >> + =A0 =A0 struct omap_dma_sglist_node *sgcurr, *sgprev;
> >> >> + =A0 =A0 dma_addr_t elem_paddr =3D phyaddr;
> >> >> +
> >> >> + =A0 =A0 for (sgprev =3D sghead;
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 sgprev < sghead + nelem;
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 sgprev++) {
> >> >> +
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 sgcurr =3D sgprev + 1;
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 sgprev->next =3D sgcurr;
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 elem_paddr +=3D (int)sizeof(*sgcurr);
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 sgprev->next_desc_add_ptr =3D elem_pa=
ddr;
> >> >> +
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 switch (sgcurr->desc_type) {
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1=
:
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_list_set_nty=
pe(sgprev, 1);
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> +
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2=
a:
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* intentional no break */
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2=
b:
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_list_set_nty=
pe(sgprev, 2);
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> +
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3=
a:
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* intentional no bre=
ak */
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3=
b:
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_list_set_nty=
pe(sgprev, 3);
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> +
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 default:
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> >> +
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > Are we supporting all the descriptor types. I think only type2a =
is
> >> > supported. In that case please add FIXME, or WARN message here.
> >>
> >> From DMA perspective, all are supported - no restrictions. Only I =
have
> >> not figured
> >> out how to use type 2b and type 3b descriptors. It's not the fault=
 of
> >> DMA driver or
> >> specification :-) It's actually upto the client to select the righ=
t type.
> > OK. Then the question which I wanted to ask.
> > For TX, 2b should have been better choice than 2a isn't it?
>=20
> Not much of a difference (as the space allocation is common), but I
> couldn't get 2b working correctly.
> Will try that once I get some clarification from hardware team.
Add a FIXME then with description in the code so that it's not forgotte=
n once the code
is merged.
>=20
> >>
> >> >> +
> >> >> + =A0 =A0 lcfg->sghead =3D sgparams;
> >> >> + =A0 =A0 lcfg->num_elem =3D nelem;
> >> >> + =A0 =A0 lcfg->sgheadphy =3D padd;
> >> >> + =A0 =A0 lcfg->pausenode =3D -1;
> >> >> +
> >> >> +
> >> >> + =A0 =A0 if (NULL =3D=3D chparams)
> >> > Minute point really. Better readability "ch_params"
> >> OK
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
