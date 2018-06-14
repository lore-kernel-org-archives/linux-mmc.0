From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v3 16/27] docs: Fix more broken
 references
Date: Thu, 14 Jun 2018 09:28:52 -0700
Message-ID: <fe2520d95598838cb4fcfca93b635de002cbf68a.camel@intel.com>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <e1bf52a721005b2017434acc54ec5ddc152d6fe4.1528990947.git.mchehab+samsung@kernel.org>
Reply-To: jeffrey.t.kirsher@intel.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1302384617=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <e1bf52a721005b2017434acc54ec5ddc152d6fe4.1528990947.git.mchehab+samsung@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org, linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-fsdevel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============1302384617==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-EsPVn4RCUwsrPVEmUoPX"


--=-EsPVn4RCUwsrPVEmUoPX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-06-14 at 13:09 -0300, Mauro Carvalho Chehab wrote:
> As we move stuff around, some doc references are broken. Fix some of
> them via this script:
>         ./scripts/documentation-file-ref-check --fix
>=20
> Manually checked that produced results are valid.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

For the Intel networking Kconfig changes.

> ---
>  .../devicetree/bindings/clock/st/st,clkgen.txt |  8 ++++----
>  .../devicetree/bindings/clock/ti/gate.txt      |  2 +-
>  .../devicetree/bindings/clock/ti/interface.txt |  2 +-
>  .../bindings/cpufreq/cpufreq-mediatek.txt      |  2 +-
>  .../devicetree/bindings/devfreq/rk3399_dmc.txt |  2 +-
>  .../bindings/gpu/arm,mali-midgard.txt          |  2 +-
>  .../bindings/gpu/arm,mali-utgard.txt           |  2 +-
>  .../devicetree/bindings/mfd/mt6397.txt         |  2 +-
>  .../devicetree/bindings/mfd/sun6i-prcm.txt     |  2 +-
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt |  2 +-
>  .../devicetree/bindings/net/dsa/ksz.txt        |  2 +-
>  .../devicetree/bindings/net/dsa/mt7530.txt     |  2 +-
>  .../devicetree/bindings/power/fsl,imx-gpc.txt  |  2 +-
>  .../bindings/power/wakeup-source.txt           |  2 +-
>  .../devicetree/bindings/usb/rockchip,dwc3.txt  |  2 +-
>  Documentation/hwmon/ina2xx                     |  2 +-
>  Documentation/maintainer/pull-requests.rst     |  2 +-
>  Documentation/translations/ko_KR/howto.rst     |  2 +-
>  MAINTAINERS                                    | 18 +++++++++-------
> --
>  drivers/net/ethernet/intel/Kconfig             |  8 ++++----
>  drivers/soundwire/stream.c                     |  8 ++++----
>  fs/Kconfig.binfmt                              |  2 +-
>  fs/binfmt_misc.c                               |  2 +-
>  23 files changed, 40 insertions(+), 40 deletions(-)

--=-EsPVn4RCUwsrPVEmUoPX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlsil8QACgkQ5W/vlVpL
7c6fBg//Y8A7h4cFk1ok818ypCr+83eIxdf+QFGtiW+7F5i5tuBtttRUgDfEQ2cH
4kYMLgAlHBNirmCkS4sw3RPLY6nx2JOZRoPcqltIpDNDB6adZafoGEC9RCEsLoGD
OcQqMFzLcZbJYZDpNmJO1HmEVoLoc2tS98wCKadC7bTrYYO0awKCiJePSXKLo+lh
tkzN5W227SqWEQ9CW782vEFo3x9nT7UZR2OBU+7aXUJaf8JH/7gBW1pm+wsdYsmY
rmoOYzZoDHJMY8JKz0baukbezWQIBpJV7BGw2qFhOmmDyWigWaAedrhfOng/oSRa
FZjM3WcOso5cucYQ5Xx4n/d5hxQw8S+0nEUfE+fByGofPBZAKmwpOr5kgdsjfKhh
leOB1/eeCl3jLOJ0LFcl2H2XR1uvzDZtkXRt2/LUu/tpn5RgK8LtZaMNmBzWCLHi
/1KniV2BAXuBA3jphpRoxGgSpiIqeVKPvK0cvLBIfryv3R4LsKDmROgBHVrQ7O6D
Kkcs3RFl1eTjX/RCLQUPW1wy6AaPJ0999Cob5arUlbWQZuF0FANdzC71yfs1d1c0
u190osB7AEq14iMmV+5XzUpRzcGW+k96ywye8jmJP/liFw0KOPq6qDg0BkT3Bt57
zxmHQtzIkg6rNMNANeBoW6WxRQt+KcmMyAEvdQ+mEY1vMcNs0w8=
=PJNP
-----END PGP SIGNATURE-----

--=-EsPVn4RCUwsrPVEmUoPX--


--===============1302384617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1302384617==--
