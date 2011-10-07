From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 1/5] drivercore: add new error value for deferred probe
Date: Fri, 07 Oct 2011 19:28:33 -0400
Message-ID: <32004.1318030113@turing-police.cc.vt.edu>
References: <1317963790-29426-1-git-send-email-manjugk@ti.com>
	<1317963790-29426-2-git-send-email-manjugk@ti.com>
	<20111007064349.GD27508@kroah.com>
	<CACxGe6uOmrLwJSPw4JHuOmt5B2wsukdDgVUr01pryq5Z9BFadw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1636936321=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: Your message of "Fri, 07 Oct 2011 16:12:45 MDT."
	<CACxGe6uOmrLwJSPw4JHuOmt5B2wsukdDgVUr01pryq5Z9BFadw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Dilan Lee <dilee@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Greg KH <greg@kroah.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

--===============1636936321==
Content-Type: multipart/signed; boundary="==_Exmh_1318030113_9306P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1318030113_9306P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 07 Oct 2011 16:12:45 MDT, Grant Likely said:
> On Fri, Oct 7, 2011 at 12:43 AM, Greg KH <greg=40kroah.com> wrote:
> > On Fri, Oct 07, 2011 at 10:33:06AM +0500, G, Manjunath Kondaiah wrote=
:

> >> +=23define EPROBE_DEFER 517 =A0 =A0 /* restart probe again after som=
e time */
> >
> > Can we really do this?

> According to Arnd, yes this is okay.

> > =A0Isn't this some user/kernel api here?

> > What's wrong with just =22overloading=22 on top of an existing error =
code?
> > Surely one of the other 516 types could be used here, right?

> overloading makes it really hard to find the users at a later date.

Would proposing '=23define EPROBE_DEFER EAGAIN' be acceptable to everybod=
y? That
would allow overloading EAGAIN, but still make it easy to tell the usages=
 apart
if we need to separate them later...


--==_Exmh_1318030113_9306P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFOj4shcC3lWbTT17ARAnNnAKDIOtuWic3rV/UGBFdp88UicSvhhQCg7T/R
kVC27cR2/6C01IaIf5qx7UE=
=QBeY
-----END PGP SIGNATURE-----

--==_Exmh_1318030113_9306P--



--===============1636936321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1636936321==--
