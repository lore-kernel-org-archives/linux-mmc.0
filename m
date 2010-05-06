From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH v8 1/2] sDMA: descriptor autoloading feature
Date: Thu, 6 May 2010 14:29:51 +0530
Message-ID: <s2y618f0c911005060159v4be26a14y85a7548a080ae380@mail.gmail.com>
References: <l2i618f0c911004291035ja334efb0o5016c5cb70c4b5bc@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D1@dbde02.ent.ti.com>
	 <k2l618f0c911005050450t75968621m61e3ff39e90d20ad@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C52D1806@dbde02.ent.ti.com>
	 <i2r618f0c911005050925h253532c7wb758ac7781840b4c@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C538737A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:58315 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab0EFI7w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2010 04:59:52 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C538737A@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, Tony Lindgren <tony@atomide.com>

Shilimkar, Santosh <santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of Ve=
nkatraman S
>> Sent: Wednesday, May 05, 2010 9:56 PM
>> To: Shilimkar, Santosh
>> Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org; linux-arm=
-kernel@lists.infradead.org;
>> Chikkature Rajashekar, Madhusudhan; Adrian Hunter; Tony Lindgren
>> Subject: Re: [PATCH v8 1/2] sDMA: descriptor autoloading feature
>>
>> On Wed, May 5, 2010 at 5:31 PM, Shilimkar, Santosh
>> <santosh.shilimkar@ti.com> wrote:
>> >
>> >
>> >> -----Original Message-----
>> >> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of=
 Venkatraman S
>> >> Sent: Wednesday, May 05, 2010 5:20 PM
>> >> To: Shilimkar, Santosh
>> >> Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org; linux-=
arm-kernel@lists.infradead.org;
>> >> Chikkature Rajashekar, Madhusudhan; Adrian Hunter; Tony Lindgren
>> >> Subject: Re: [PATCH v8 1/2] sDMA: descriptor autoloading feature
>> >>
>> >> [Long sections have been trimmed to the context of the discussion=
]
>> >> On Wed, May 5, 2010 at 3:02 PM, Shilimkar, Santosh
>> >> <santosh.shilimkar@ti.com> wrote:
>> >> >> -----Original Message-----
>> >> >> +static int dma_sglist_set_phy_params(struct omap_dma_sglist_n=
ode *sghead,
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 dma_addr_t phyaddr, int nelem)
>> >> >> +{
>> >> >> + =A0 =A0 struct omap_dma_sglist_node *sgcurr, *sgprev;
>> >> >> + =A0 =A0 dma_addr_t elem_paddr =3D phyaddr;
>> >> >> +
>> >> >> + =A0 =A0 for (sgprev =3D sghead;
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 sgprev < sghead + nelem;
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 sgprev++) {
>> >> >> +
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 sgcurr =3D sgprev + 1;
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 sgprev->next =3D sgcurr;
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 elem_paddr +=3D (int)sizeof(*sgcurr)=
;
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 sgprev->next_desc_add_ptr =3D elem_p=
addr;
>> >> >> +
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 switch (sgcurr->desc_type) {
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE=
1:
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_list_set_nt=
ype(sgprev, 1);
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> >> +
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE=
2a:
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* intentional no break */
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE=
2b:
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_list_set_nt=
ype(sgprev, 2);
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> >> +
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE=
3a:
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* intentional no br=
eak */
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE=
3b:
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_list_set_nt=
ype(sgprev, 3);
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> >> +
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 default:
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> >> >> +
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> > Are we supporting all the descriptor types. I think only type2a=
 is
>> >> > supported. In that case please add FIXME, or WARN message here.
>> >>
>> >> From DMA perspective, all are supported - no restrictions. Only I=
 have
>> >> not figured
>> >> out how to use type 2b and type 3b descriptors. It's not the faul=
t of
>> >> DMA driver or
>> >> specification :-) It's actually upto the client to select the rig=
ht type.
>> > OK. Then the question which I wanted to ask.
>> > For TX, 2b should have been better choice than 2a isn't it?
>>
>> Not much of a difference (as the space allocation is common), but I
>> couldn't get 2b working correctly.
>> Will try that once I get some clarification from hardware team.
> Add a FIXME then with description in the code so that it's not forgot=
ten once the code
> is merged.
OK. I am assuming the FIXME has to be in MMC driver, not here.
