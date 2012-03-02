From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: hsmmc: add max_freq field
Date: Thu, 1 Mar 2012 16:11:21 -0800
Message-ID: <20120302001121.GE18901@atomide.com>
References: <1323868927-3738-1-git-send-email-zonque@gmail.com>
 <CANrkHUY3Zf4a2K5769Z=7Wng339zB6+z_Tgd4mOPChZ1RvZ=Kw@mail.gmail.com>
 <4EFC6992.4020501@gmail.com>
 <CACTFLAMCoKfQbTe2RLTvi1_CH0nKzAOthAwrifNe2+F2sf3uPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:12448 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650Ab2CBAL0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Mar 2012 19:11:26 -0500
Content-Disposition: inline
In-Reply-To: <CACTFLAMCoKfQbTe2RLTvi1_CH0nKzAOthAwrifNe2+F2sf3uPA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, Rajendra Nayak <rnayak@ti.com>
Cc: "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

* Daniel Mack <zonque@gmail.com> [120217 05:13]:
> ping? Could anyone care for queueing this please?
=20
I suggest Rajendra queue up omap_hsmmc.c patches as he's already
patching it.

Regards,

Tony

=20
> On Thu, Dec 29, 2011 at 2:22 PM, Daniel Mack <zonque@gmail.com> wrote=
:
> > On 12/23/2011 04:40 PM, T Krishnamoorthy, Balaji wrote:
> >> On Wed, Dec 14, 2011 at 6:52 PM, Daniel Mack <zonque@gmail.com> wr=
ote:
> >>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/oma=
p_hsmmc.c
> >>> index 101cd31..8215ef9 100644
> >>> --- a/drivers/mmc/host/omap_hsmmc.c
> >>> +++ b/drivers/mmc/host/omap_hsmmc.c
> >>> @@ -1927,8 +1927,12 @@ static int __init omap_hsmmc_probe(struct =
platform_device *pdev)
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mmc_slot(host).vcc_aux_disable_is_=
sleep)
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_slot(h=
ost).no_off =3D 1;
> >>>
> >>> - =C2=A0 =C2=A0 =C2=A0 mmc->f_min =C2=A0 =C2=A0 =C2=A0=3D OMAP_MM=
C_MIN_CLOCK;
> >>> - =C2=A0 =C2=A0 =C2=A0 mmc->f_max =C2=A0 =C2=A0 =C2=A0=3D OMAP_MM=
C_MAX_CLOCK;
> >>> + =C2=A0 =C2=A0 =C2=A0 mmc->f_min =3D OMAP_MMC_MIN_CLOCK;
> >>
> >> Stray change for f_min ?
> >
> > No, this was intended. The indentation doesn't make sense anymore w=
hen
> > not grouped with the f_max assignment.
> >
> > Other than that, what is necessary to get this picked? Tony? :)
> >
> >
> > Thanks,
> > Daniel
