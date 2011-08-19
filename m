From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: sdhi: initialise mmc_data->flags before use
Date: Fri, 19 Aug 2011 09:06:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108190902180.11363@axis700.grange>
References: <1313716027-19470-1-git-send-email-horms@verge.net.au>
 <CANqRtoRx5MC-smUjuYBgpstcm49_PqwXqG=YEe+dkqVte7eQ9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56367 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659Ab1HTSHy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Aug 2011 14:07:54 -0400
In-Reply-To: <CANqRtoRx5MC-smUjuYBgpstcm49_PqwXqG=YEe+dkqVte7eQ9w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Fri, 19 Aug 2011, Magnus Damm wrote:

> On Fri, Aug 19, 2011 at 10:07 AM, Simon Horman <horms@verge.net.au> w=
rote:
> > This corrects a logic error that I introduced in
> > "mmc: sdhi: Add write16_hook"
> >
> > Reported-by: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> > =A0drivers/mmc/host/sh_mobile_sdhi.c | =A0 =A04 ++--
> > =A01 files changed, 2 insertions(+), 2 deletions(-)
>=20
> Hi Simon,
>=20
> Thanks for providing a fix for this issue. Correct me if I'm wrong,
> but I believe this patch is suitable for 3.1-rc. So it would be great
> to have it merged rather soon as a fix instead of delaying it to 3.2.

Indeed:

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Chris, please, push for 3.1.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
