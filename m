From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH v8 1/2] sDMA: descriptor autoloading feature
Date: Wed, 5 May 2010 17:20:15 +0530
Message-ID: <k2l618f0c911005050450t75968621m61e3ff39e90d20ad@mail.gmail.com>
References: <l2i618f0c911004291035ja334efb0o5016c5cb70c4b5bc@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f203.google.com ([209.85.223.203]:56003 "EHLO
	mail-iw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab0EELuQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 May 2010 07:50:16 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D1@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, Tony Lindgren <tony@atomide.com>

[Long sections have been trimmed to the context of the discussion]
On Wed, May 5, 2010 at 3:02 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> +static int dma_sglist_set_phy_params(struct omap_dma_sglist_node *s=
ghead,
>> + =A0 =A0 =A0 =A0 =A0 =A0 dma_addr_t phyaddr, int nelem)
>> +{
>> + =A0 =A0 struct omap_dma_sglist_node *sgcurr, *sgprev;
>> + =A0 =A0 dma_addr_t elem_paddr =3D phyaddr;
>> +
>> + =A0 =A0 for (sgprev =3D sghead;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sgprev < sghead + nelem;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sgprev++) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 sgcurr =3D sgprev + 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 sgprev->next =3D sgcurr;
>> + =A0 =A0 =A0 =A0 =A0 =A0 elem_paddr +=3D (int)sizeof(*sgcurr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 sgprev->next_desc_add_ptr =3D elem_paddr;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (sgcurr->desc_type) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_list_set_ntype(sg=
prev, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* intentional no break */
>> + =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_list_set_ntype(sg=
prev, 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* intentional no break */
>> + =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_list_set_ntype(sg=
prev, 3);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
> Are we supporting all the descriptor types. I think only type2a is
> supported. In that case please add FIXME, or WARN message here.

=46rom DMA perspective, all are supported - no restrictions. Only I hav=
e
not figured
out how to use type 2b and type 3b descriptors. It's not the fault of
DMA driver or
specification :-) It's actually upto the client to select the right typ=
e.

>> +
>> + =A0 =A0 lcfg->sghead =3D sgparams;
>> + =A0 =A0 lcfg->num_elem =3D nelem;
>> + =A0 =A0 lcfg->sgheadphy =3D padd;
>> + =A0 =A0 lcfg->pausenode =3D -1;
>> +
>> +
>> + =A0 =A0 if (NULL =3D=3D chparams)
> Minute point really. Better readability "ch_params"
OK

>> + =A0 =A0 dma_write(l, CDP(lch));
>> + =A0 =A0 dma_write((lcfg->sgheadphy), CNDP(lch));
>> + =A0 =A0 /**
>> + =A0 =A0 =A0* Barrier needed as writes to the
>> + =A0 =A0 =A0* descriptor memory needs to be flushed
>> + =A0 =A0 =A0* before it's used by DMA controller
>> + =A0 =A0 =A0*/
> Little bit of re-wording if you can.
> Also you don't wanted the double **
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Memory barrier is needed because data may still be
> =A0 =A0 =A0 =A0 * in the write buffer. The barrier drains write buffe=
rs and
> =A0 =A0 =A0 =A0 * ensures that DMA sees correct descriptors
> =A0 =A0 =A0 =A0 */
OK

>> + =A0 =A0 wmb();
>> + =A0 =A0 omap_start_dma(lch);
>> +
>> + =A0 =A0 /* Maintain the pause state in descriptor */
>> + =A0 =A0 omap_set_dma_sglist_pausebit(lcfg, lcfg->pausenode, 0);
>> + =A0 =A0 omap_set_dma_sglist_pausebit(lcfg, pauseafter, 1);
>> +
>> + =A0 =A0 /**
>> + =A0 =A0 =A0* Barrier needed as writes to the
>> + =A0 =A0 =A0* descriptor memory needs to be flushed
>> + =A0 =A0 =A0* before it's used by DMA controller
>> + =A0 =A0 =A0*/
> Description change if possible
OK

>> + =A0 =A0 wmb();
>> +
>> + =A0 =A0 /* Errata i557 - pausebit should be cleared in no standby =
mode */
> This should have been

I couldn't understand this comment.

>> + =A0 =A0 sys_cf =3D dma_read(OCP_SYSCONFIG);
>> + =A0 =A0 l =3D sys_cf;
>> + =A0 =A0 /* Middle mode reg set no Standby */
>> + =A0 =A0 l &=3D ~(BIT(12) | BIT(13));
>> + =A0 =A0 dma_write(l, OCP_SYSCONFIG);
