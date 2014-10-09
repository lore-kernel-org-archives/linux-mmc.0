From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: eMMC and "mkfs.ext3" hangs without "-E nodiscard"
Date: Thu, 9 Oct 2014 20:44:06 +0200
Message-ID: <20141009184406.GA30071@pengutronix.de>
References: <CAOpc7mF+9DgEeikB-gjGphPnsC_Ku+9=AtdGUaQEZYK6Jm77vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36310 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaJISoL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Oct 2014 14:44:11 -0400
Content-Disposition: inline
In-Reply-To: <CAOpc7mF+9DgEeikB-gjGphPnsC_Ku+9=AtdGUaQEZYK6Jm77vA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Holger Schurig <holgerschurig@gmail.com>, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-mmc@vger.kernel.org

Hello,

On Mon, Sep 29, 2014 at 03:46:10PM +0200, Holger Schurig wrote:
> on kernel 3.16.3 running on an i.MX6 with an eMMC card formatting a
> partition won't work, it hangs. With an added -v the last thing it
> spit out is "Discarding device blocks: 4096/196608".
>=20
> When I run mkfs with "-E nodiscard", formatting & booting works.
I had the exact same issue on an i.MX6 machine (via amos820) with
mkfs.ext2.  When cross checking on a different i.MX6 machine the proble=
m
didn't happen there. It seems it didn't try to discard blocks, at least
it didn't say something about "Discarding device blocks:".

I tried to understand how mkfs.ext* decides if it can/should try to
discard blocks, but failed to do so. Theodore: Maybe you can help out
here? The relevant line seems to be:

	discard =3D get_bool_from_profile(fs_types, "discard" , discard);

Unfortunately I don't have access to the failing machine anymore, still
it would be great to understand the problem.

Apart from that even if the block device somehow announces that it can
or cannot discard blocks, the process doing it anyhow shouldn't hang.
(For me it wasn't interruptible by Ctrl-C, so probably hung in a system
call.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
