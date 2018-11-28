From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH V2 7/7] mmc: bcm2835: Properly handle
 dmaengine_prep_slave_sg
Date: Wed, 28 Nov 2018 09:27:24 -0800
Message-ID: <87y39d5czn.fsf@anholt.net>
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
 <1541967839-2847-8-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9070910025585483748=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1541967839-2847-8-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Florian Fainelli <f.fainelli@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Phil Elwell <phil@raspberrypi.org>, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, Michal Suchanek <msuchanek@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

--===============9070910025585483748==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> In case dmaengine_prep_slave_sg fails we need to call dma_unmap_sg.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

This series is:

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlv+z/wACgkQtdYpNtH8
nughvg//VQSvXJEp1w1vBLZoFn8jsQGeAA1yHEJcm1PMWHCIcps1b2HJX2esD6Nd
Ve52aExRAUD9hBY739RrCZStDIlhkl2XerBYcIeZJWD4iI/Ks983qG0FhT4x5Is5
vEzAq0RiqwjoKb0TnmKMaBOeir8JP//60yuKXc28ASW8K0OgIYK5G8JEhrICTg8s
mpMAcHRCIln4IXSijVHXVy9P78eMwsJ5whrX44DPKBizr63IOZ8wyfh3MJi+LeKU
4y0Thx/D7NYAPTleBXHaMRYZFTr51M3CD8hrymMwgmIWTicwDmOuBk+zbpSX2x7n
b1x7qqHWjxt5Fe/FBDmtorZSv5hahMSjLdis7KF+p8NQe2yFaRdLrseV8H8mAaUQ
xp18WTLGI55Bik6IECG4RsLi8c6PjTPnH7QWve75nkpFmMXU/tfk6eIhWlRRVAW0
ENXP3NgRuB1iK40UjC0EXkKs0nViZ3XCx5KbG/aQPUeMX/cXecGYxQmaWsUbqbTi
amCB4iP/MgB0iMZuy345nkdSuLqk2dvm49f1Drfun6YBi8uVzOo+SQ9q9vnEHQAG
NZ5MQhAAZFlvh2rLcMkMoqqkvVHbm9Z97WUEeMHxBPDiq6r9KaL+4+WuS49QVzsp
Yw7cXfsUGE0zqNWfmgt8Q1M4MrRpWRxi48/kVP+YtxmRT2FX6qI=
=BxBP
-----END PGP SIGNATURE-----
--=-=-=--


--===============9070910025585483748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9070910025585483748==--
