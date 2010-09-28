From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/6] mmc: sdhci-pltfm: Add structure for host-specific
 data
Date: Tue, 28 Sep 2010 16:49:58 +0200
Message-ID: <20100928144958.GI4441@pengutronix.de>
References: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de>
 <1285677406-3359-2-git-send-email-w.sang@pengutronix.de>
 <48641052-49AF-4A24-9C8C-42E59791D6A7@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WHz+neNWvhIGAO8A"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37366 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756608Ab0I1Ot7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 10:49:59 -0400
Content-Disposition: inline
In-Reply-To: <48641052-49AF-4A24-9C8C-42E59791D6A7@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: linux-mmc@vger.kernel.org


--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 28, 2010 at 06:54:47AM -0700, Philip Rakity wrote:

> taking this off line for a bit (if you don't mind)

Actually, I do. Going back to the list.

> I really like what you are doing but it does not go far enough.  The
> controller I work on is somewhat funny and broken.  It needs to do
> either pre or post processing for some of the calls.

I never claimed that my current patchset should solve all issues. It
deals with some issues I encountered (and then some more, because there
were similar issues on the list), and tries to push things in the right
direction. Most of us are just working on one specific driver, so we
have to live with a slow, step-by-step procedure. I tried to get some
funding for general, large scale cleanup work, but did not get any
response, so far.

> For reset for example --- I need to check if the reset is RESET_DAT
> and handle that differently then RESET_CMD.  If RESET_ALL I need to do
> post processing to restore the controller private registers.

I know the reset-routine probably needs another hook. I think it was
Alan who also mentioned some requirements for it. But besides this, I am
not going to dive deeply into that topic (at least for now). It is too
specific for me at the moment.

Quite frankly, I am a bit overwhelmed by the massive request of guidance
for pltfm-specific drivers and I cannot provide this anymore at this
level as long as I have other work to do (which allows me to buy the
bread). As a result, I will continue reviewing and such but it will take
longer.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WHz+neNWvhIGAO8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyiAJYACgkQD27XaX1/VRueOQCgtrtL8bjxuOFkyi2WgsQJ4ODG
KFcAninHr+59yXSWb/9fJUrX6druMTEi
=a043
-----END PGP SIGNATURE-----

--WHz+neNWvhIGAO8A--
