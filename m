From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 4/5] mmc: sunxi: sun4i / sun5i do not have sample clocks
Date: Sat, 30 Jul 2016 17:15:20 +0200
Message-ID: <20160730151520.GQ6215@lukather>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-5-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3463218180384612574=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1469888748-26085-5-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: devicetree <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.xyz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============3463218180384612574==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tuFXEhzhBeitrIAu"
Content-Disposition: inline


--tuFXEhzhBeitrIAu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 30, 2016 at 04:25:47PM +0200, Hans de Goede wrote:
> It turns out that sun4i (A10) and sun5i (A13 & co) do not have sample
> clocks, so add a new sun7i-a20-mmc compatible and do not try to use
> sample clocks on sun4i / sun5i.
>=20
> Since sun4i / sun5i do not have sample clocks, they cannot (reliably) do
> DDR rates, so only set MMC_CAP_1_8V_DDR when we do have sample clks.
>=20
> Note this patch leaves the clk_prepare_enable() / clk_disable_unprepare()
> calls to the sample clks as-is, without adding checks for them being
> NULL. All the clk_foo calls accept a NULL clk and will return success when
> called with a NULL clk.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--tuFXEhzhBeitrIAu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXnMSIAAoJEBx+YmzsjxAg2ZgP/0XfVju152k1rmWeDsL+9WSk
PCPqNNTUObKjNDx2QwyTD945nW7T+EtuTubyswTkMBoXvqxLQGSEF7FUT509GSK0
Y3RHS/8+TuKGwq0pQAHLfHO7zm2PSaV14pYbHCg7hKZSSxpfdivcZwoZTJdExwtN
04TRwv43LOWWwfOSCIQJZQbNn8F/unVdq66SRoTKiYWcINKp6TBYroSbTJDh/Bdo
IQNRvye7HEMJzA4ndxTopre2FzibPJc8+p7C6mgH3Z+ckjLB5xAyMHB1DPc96/GK
a4m4AHbbvQfGJytMLxfNMH4zOn3goGVTpEubkPAK5j+C9+1YzAgvFoNkNCe7gYmR
EXrrzJJzwqU+gXbPYZxvvCNU8o8GEbyxEUdm4Qj+4ZaNvk+pIaukKNPePLllkdHE
G2g0ydoJ8Nf3kdM8VuVZXMX5nERnXLSyeoxEehDb8DkRjH4It7is6vWDoPxPrX4k
dWVTkopdi2+1H2tdPo41Bhzxn76s1P0LVGM2ljxjrKfbENPTZAwjPYRiaGjoG8SO
m1uypSROJEzCLWz62f1xsLH1F18L60RqCotk1vF60vxI/O0JsbS9MTXXD1JM64ml
9ZNo/yGGBwUimCm7vjOx859nS2JqfwdzZijn5EUVgRg7flSgU+eZlfehGCn0ESyu
vSekLAyG97e3PL6qBebj
=luCO
-----END PGP SIGNATURE-----

--tuFXEhzhBeitrIAu--


--===============3463218180384612574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3463218180384612574==--
