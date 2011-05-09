From: Greg KH <greg@kroah.com>
Subject: Re: [stable] Patch "mmc: fix all hangs related to mmc/sd card
 insert/removal during suspend/resume" has been added to the 2.6.32-longterm
 tree
Date: Mon, 9 May 2011 13:46:43 -0700
Message-ID: <20110509204643.GD1432@kroah.com>
References: <13046324562530@kroah.org>
 <BANLkTi=gQnAUOGZ-FOxmcyrDaffxUVF9+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:42152 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505Ab1EIUrJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 May 2011 16:47:09 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=gQnAUOGZ-FOxmcyrDaffxUVF9+w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: gregkh@suse.de, maximlevitsky@gmail.com, linux-mmc@vger.kernel.org, david-b@pacbell.net, stern@rowland.harvard.edu, stable-commits@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, stable@kernel.org

On Fri, May 06, 2011 at 09:37:46AM +0300, Ohad Ben-Cohen wrote:
> On Fri, May 6, 2011 at 12:54 AM,  <gregkh@suse.de> wrote:
> >
> > This is a note to let you know that I've just added the patch title=
d
> >
> > =A0 =A0mmc: fix all hangs related to mmc/sd card insert/removal dur=
ing suspend/resume
> >
> > to the 2.6.32-longterm tree
>=20
> That patch introduced a suspend/resume regression, so please also add
> the one that fixed it:
>=20
> commit 1c8cf9c997a4a6b36e907c7ede5f048aeaab1644
> Author: Ohad Ben-Cohen <ohad@wizery.com>
> Date:   Wed Oct 13 09:31:56 2010 +0200
>=20
>     mmc: sdio: fix SDIO suspend/resume regression
>=20
>     Fix SDIO suspend/resume regression introduced by 4c2ef25fe0b "mmc=
: fix
>     all hangs related to mmc/sd card insert/removal during suspend/re=
sume":
>=20
>       PM: Syncing filesystems ... done.
>       Freezing user space processes ... (elapsed 0.01 seconds) done.
>       Freezing remaining freezable tasks ... (elapsed 0.01 seconds) d=
one.
>       Suspending console(s) (use no_console_suspend to debug)
>       pm_op(): platform_pm_suspend+0x0/0x5c returns -38
>       PM: Device pxa2xx-mci.0 failed to suspend: error -38
>       PM: Some devices failed to suspend
>=20
>     4c2ef25fe0b moved the card removal/insertion mechanism out of MMC=
's
>     suspend/resume path and into pm notifiers (mmc_pm_notify), and th=
at
>     broke SDIO's expectation that mmc_suspend_host() will remove the =
card,
>     and squash the error, in case -ENOSYS is returned from the bus su=
spend
>     handler (mmc_sdio_suspend() in this case).
>=20
>     mmc_sdio_suspend() is using this whenever at least one of the car=
d's SDIO
>     function drivers does not have suspend/resume handlers - in that =
case
>     it is agreed to force removal of the entire card.
>=20
>     This patch fixes this regression by trivially bringing back that =
part of
>     mmc_suspend_host(), which was removed by 4c2ef25fe0b.
>=20
>     Reported-and-tested-by: Sven Neumann <s.neumann@raumfeld.com>
>     Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>     Cc: Maxim Levitsky <maximlevitsky@gmail.com>
>     Cc: <stable@kernel.org>
>     Acked-by: Nicolas Pitre <nico@fluxnic.net>
>     Signed-off-by: Chris Ball <cjb@laptop.org>

Now queued up, thanks.

greg k-h
