From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v10 01/15] clk: sunxi: factors: automatic
 reparenting support
Date: Tue, 6 May 2014 13:51:31 -0500
Message-ID: <20140506185131.GI9464@lukather>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
 <1399046249-19472-2-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cf0hFtnykp6aONGL"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBDEBUWNQKGQEIZOMHPI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399046249-19472-2-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--cf0hFtnykp6aONGL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Emilio,

On Fri, May 02, 2014 at 05:57:15PM +0200, Hans de Goede wrote:
> From: Emilio L=F3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
>=20
> This commit implements .determine_rate, so that our factor clocks can be
> reparented when needed.
>=20
> Signed-off-by: Emilio L=F3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Any chance you merge this? Since it's pretty consensual, needed by
other drivers, and that you are the author, I can it can go in.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--cf0hFtnykp6aONGL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTaS8zAAoJEBx+YmzsjxAgsOwP/iqhE8iJmvfkD5113qSM9Zik
q2ylAJUohPXZLgHiVgIqMy7mUOyP0mfbRxWMktK/lTBq0pboI5V0VmBXuvLGRli3
yV1Czsa7r04vbKBIYYRh/wsrmjHXsqEPl19dJuYOMzAfMWN/zh6fHkCGP/xRfJqZ
i0CwcnlZqu4lCzdNc7TkNJNzD46bJVa+6kuyWDv+fjlwqDsDdr/KcRSPNXhJEQg0
WkUAfut0FOPbdTqaOikBbmWfQxXYUrqyQZvDODN3AUC9xW6ZAj+OiEkeqjzFRXRH
KgDczpwzlI5439gJ49pvNPiOH+mUGebY5+AIJEvNdA/WBqjofc23TyVBO/LTs8by
vOyUVX/gKaN+VcFcUJnGCX7Jkrtpylb+ZvVrhLBykI4Ws/PR9aCc9YGPnZVXcl1+
iaI2b2QN8VTH4AO414RXp5cxlZN+6DOhRr0+7qg4Dkb/SgLVMXFgO8hrpKblVEZ9
E61QlDy81j+Lv/Kwu4rUCylCPPMbxwE2n7ukGXOiT+G0WQy40dfs95nUpEosZKam
xR7oyVzd21Q4pgS35nB6ZEyGbLJCjypu3iztEORDifUP9vUcrso/TUDn18ilurvC
T1DODk94v6XYfLnWlRAAozNygLxJk5bosch+n53fB0WAmtn5TBzkhHjEJeQkz62L
pOxT+M5LGOW3+kpux+Eo
=uzZF
-----END PGP SIGNATURE-----

--cf0hFtnykp6aONGL--
