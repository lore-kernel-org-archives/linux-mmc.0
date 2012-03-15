From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND 3/8] mmc: omap: use runtime put sync in probe
 error patch
Date: Thu, 15 Mar 2012 16:58:53 +0200
Message-ID: <20120315145853.GR28447@arwen.pp.htv.fi>
References: <y>
 <1331822022-26714-1-git-send-email-svenkatr@ti.com>
 <1331822022-26714-4-git-send-email-svenkatr@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="chReQkDOePndSGWY"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:34097 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965152Ab2COO7D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 10:59:03 -0400
Received: by mail-lpp01m010-f44.google.com with SMTP id j5so2432526lag.3
        for <linux-mmc@vger.kernel.org>; Thu, 15 Mar 2012 07:59:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1331822022-26714-4-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balajitk@ti.com, balbi@ti.com


--chReQkDOePndSGWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2012 at 08:03:37PM +0530, Venkatraman S wrote:
> From: Balaji T K <balajitk@ti.com>
>=20
> pm_runtime_put_sync instead of autosuspend pm runtime API
> because iounmap(host->base) follows immediately.
>=20
> Reported-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Balaji T K <balajitk@ti.com>

should this one go to stable too ?

--=20
balbi

--chReQkDOePndSGWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYgOtAAoJEIaOsuA1yqREOygP/2l/gSRbQboxuyM0mwFPcdHF
f13Ta6aaIGFeBZD8Mn4btVkqE00tgfdtMvpj3CFQdg4pB3lGGacEMIFIV+OGhoZ/
pIoyw0RVYrehYrZJ1MdZIj33hTcZO8vJZDr6SoeMyFRt7/ZoMJkit1a+nQeD2Yak
4OvejWJ/DkrVJ2IwiyyMFTOLSh+FTO/TOT9K2/1dFmbRtStgJ5Ov46E0zd4m6hkR
n3EJcwStmWV3xNTvhEw5KYQtb9EPDHV+oUdwsThPxDqmuYBEHPDtppPTob5/UX3b
5WtXzAd479+7PzuIuTHjtyRDuAzbfdkhITZ/+cr5KjMTWheOzIiVJtnyu82Eate5
WnAUOO0vZEIdz5Pu/l7d+nsU9fKhZ7LgrLjBiaqBg1sBERROQ5Up4IxdPE/MoDst
BYKu703/HZyski1eW5nsZLdNDxmEpzRZj4uQH1RfwOgWgZzkzbBhwx8lVjxWs413
DzpH3SbHntB51F1pC/MBU2DFFUzicfeKyssZH7WLN50K+wk85BYIJnzwR0LS5wHX
c/jqTGOYe/azhYEV/86zkJzgPqTEyHdmwwY+g0zznrP2wIYTeD+RWV8hr53/EA6l
GuWm4BDbw+8Swn6H61svGbjlexLZHjZxXklavtPSSPlQN4hiRvw7k8ivTxkdr01b
66h5A3guBgqDWjY5DV9t
=misb
-----END PGP SIGNATURE-----

--chReQkDOePndSGWY--
