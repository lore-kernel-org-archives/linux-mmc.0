From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: sdhi: initialise mmc_data->flags before use
Date: Fri, 19 Aug 2011 12:26:55 +0900
Message-ID: <20110819032648.GA12106@verge.net.au>
References: <1313716027-19470-1-git-send-email-horms@verge.net.au>
 <CANqRtoRx5MC-smUjuYBgpstcm49_PqwXqG=YEe+dkqVte7eQ9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:42721 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab1HSD1C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Aug 2011 23:27:02 -0400
Content-Disposition: inline
In-Reply-To: <CANqRtoRx5MC-smUjuYBgpstcm49_PqwXqG=YEe+dkqVte7eQ9w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Fri, Aug 19, 2011 at 12:04:06PM +0900, Magnus Damm wrote:
> On Fri, Aug 19, 2011 at 10:07 AM, Simon Horman <horms@verge.net.au> w=
rote:
> > This corrects a logic error that I introduced in
> > "mmc: sdhi: Add write16_hook"
> >
> > Reported-by: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> > =C2=A0drivers/mmc/host/sh_mobile_sdhi.c | =C2=A0 =C2=A04 ++--
> > =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>=20
> Hi Simon,
>=20
> Thanks for providing a fix for this issue. Correct me if I'm wrong,
> but I believe this patch is suitable for 3.1-rc. So it would be great
> to have it merged rather soon as a fix instead of delaying it to 3.2.

Yes, I agree.
