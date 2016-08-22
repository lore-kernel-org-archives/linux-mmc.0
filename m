From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 1/2] Documentation: dt: Add new compatible to sunxi
 mmc driver bindings
Date: Mon, 22 Aug 2016 09:58:47 +0200
Message-ID: <20160822075847.GD7104@lukather>
References: <20160801151351.51854-1-icenowy@aosc.xyz>
 <20160801151351.51854-2-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9173572194112743779=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160801151351.51854-2-icenowy@aosc.xyz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Michal Suchanek <hramrach@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============9173572194112743779==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
Content-Disposition: inline


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Icenowy,

On Mon, Aug 01, 2016 at 11:13:50PM +0800, Icenowy Zheng wrote:
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes in v2:
> - Rebased on Hans de Goede's patchset.
>=20
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Docume=
ntation/devicetree/bindings/mmc/sunxi-mmc.txt
> index 904ff9f..55cdd80 100644
> --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> @@ -13,6 +13,7 @@ Required properties:
>     * "allwinner,sun5i-a13-mmc"
>     * "allwinner,sun7i-a20-mmc"
>     * "allwinner,sun9i-a80-mmc"
> +   * "allwinner,sun50i-a64-mmc"
>   - reg : mmc controller base registers
>   - clocks : a list with 4 phandle + clock specifier pairs
>   - clock-names : must contain "ahb", "mmc", "output" and "sample"

You need to document that the output and sample clocks are not
mandatory in the A64 case.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXurC3AAoJEBx+YmzsjxAgnwEQAJP/gnqBrpJLIs4g0sBJfNoT
/m/CCLlJIrlk3KGiJmVbtiq+sMXQthFwzSJUogUduADH8pPBB9hydZHoykkr4PLj
X1A5oy9yfe6+AVJl6FNQyMSEhM6O/2tZLInPqeTXZySUs4WICurIMnhx20eox8EO
HcI21PPFapyT0anu7lw5nB9wyqw+yGdiEX/sivhKJSDIpXl4KArqfQFh6QH8rbQf
RQZ9DE/GUSvxteTsEZ1nGmjco4HnMkD99YqEsAnC1lFpzitVWP4w/MHjWS78YENZ
ByjHT400/zudeapv3hMWFG68j67zIvfgV++6IQPNLXZxmsWF1yfFa4ITHV7ioL6U
fO86u+f8JShcwncyk1pCdiGZoP8YuoHTN3m3NS7h3bjnq9TKa/+7Nh+S7Owj2K74
6juJLJ/RGoOVdtpHbz4N+s3ShMM7Ks1MYYl2/1OxI+PnDbW8Th3WFH9ebUt7s8UH
0Gq6e6pJOU+zgZEZqdSUIndo9ZSLVZP13BrrJY+FFsFwku96vVkY2WyE6rV1zGR0
8jjRNa7/mDgZVUXAsbRtmg+89ixteUowSP4hlK1Jh98sEBGeXyq8+0WokGyqQyMu
U2gnfRHTACMWZBS2XfN/dedSZ46ZUxdJUL2SG96DQ62KGzOGutCBnUp4WbDbJj7t
62i2aBFPZvpwgitftQ3t
=11Vr
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--


--===============9173572194112743779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9173572194112743779==--
