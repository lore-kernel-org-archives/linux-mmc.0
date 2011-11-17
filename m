From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/2] mmc: core: Support packed command for eMMC4.5 device
Date: Thu, 17 Nov 2011 11:02:21 +0900
Message-ID: <004901cca4cc$f18d6180$d4a82480$%jun@samsung.com>
References: <620ec9ffa6bdbba9ae5f76998e36f8dc.squirrel@www.codeaurora.org>
 <001001cca043$395dbfc0$ac193f40$%jun@samsung.com>
 <CANfBPZ-Zn+R4GosEL-RJxh8gduAr8e+qN876uPwDkHfiEpdERw@mail.gmail.com>
 <ea21d88d904af165cb911354e3f51ea6.squirrel@www.codeaurora.org>
 <001e01cca2b2$3b449310$b1cdb930$%jun@samsung.com>
 <faba552e7bd19ee5399c73c2b478a34d.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:11784 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749Ab1KQCCi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2011 21:02:38 -0500
In-reply-to: <faba552e7bd19ee5399c73c2b478a34d.squirrel@www.codeaurora.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: "'S, Venkatraman'" <svenkatr@ti.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com

Maya Erez wrote:
> >> >>> >> >> > + =A0 =A0 =A0 if (rqc)
> >> >>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs =3D mmc_blk_chk_pac=
kable(mq, rqc);
> >> >>>
> >> >>> It would be best to keep all the calls to blk_fetch_request in=
 the
> >> same
> >> >>> location. Therefore, I suggest to move the call to
> >> mmc_blk_chk_packable
> >> >>> to
> >> >>> mmc/card/queue.c after the first request is fetched.
> >> >>
> >> >> At the first time, I considered that way.
> >> >> I'll do more, if possible.
> > I considered more.
> > I think that mmc_blk_chk_packable would rather be called only for r=
/w type
> > than all request type(e.g. discard, flush).
> >
> mmc_blk_chk_packable can check the cmd_flags of the request to verify=
 it's
> not a flush/disacrad etc. In such cases will not pack.
Yes. It must be checked, but omitted.
I already have added this check. It will be applied next.

Thanks,
Seungwon Jeon.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

