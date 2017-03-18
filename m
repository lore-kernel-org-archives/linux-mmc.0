From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v4 5/7] arm64: set CONFIG_MMC_BCM2835=y in defconfig
Date: Fri, 17 Mar 2017 17:07:17 -0700
Message-ID: <874lyrjvm2.fsf@eliezer.anholt.net>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com> <1488964751-22763-10-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488964751-22763-10-git-send-email-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lee@kernel.org, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>
List-Id: linux-mmc@vger.kernel.org

--=-=-=
Content-Type: text/plain

Gerd Hoffmann <kraxel@redhat.com> writes:

> We need to enable this controller so that we can switch the SD card's
> pinmux over to it by default, which will improve storage performance.
>
> Read access (dd with 64k blocks on rpi2):
>   CONFIG_MMC_SDHCI_IPROC: 11-12 MB/s
>   CONFIG_MMC_BCM2835:     19-20 MB/s
>
> Differences on write access are pretty much in the noise.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Now that the driver has been merged, I've merged the platform patches up
to this point.

Unfortunately, sending PRs to arm-soc that merge in branches from other
trees has failed in the past, so I won't be able to merge 6 and 7 for
4.12.  That said, it's a whole lot less that the various downstream
kernels will need to pull for the Pi3 than they've been carrying around
until now :)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAljMejUACgkQtdYpNtH8
nuiLghAAhh7Kv9RWBDFZPP0Ey8kT2ejm0hnr4heoTUSl7qdmgFIyxZW+Gx0XRl/Z
WVqUxWPI1jsGLpl3xggnbfDyxw+Xt9iRzTQss472ilC5wm4goXw1nqtfnR9G/flC
4FMzehABwWsIsG6Dkny8z6YlUq6khVl4R5UcK7t+qXpNrK1Oh22dhBZBIJFfR1cq
8cqaYvofFWN8pvJPIOroubO2lUOroRPwXaP4AD/LVNwyg0KwKL0bkkACSd+Aq2z9
6DG1G/PO/mu2x/gPa3ZJPWDlXVs6MNHl2re+5xIqXJbUMQKiQs4gN4jCvd4SyY+5
IUzaA1Cmio7jsqnMzllY2LAlGXVGqsWk3KiWTgJt3R9PgRa4yWvoL43RCCZA+RU0
145bkOLP/dRjAnxKYq7T7BWp4wZVBjzxVkx0wbRCBFDvoE1+/z+QmwV0e1MKaRdh
Rx85+4tTBmncuAO6yr1mu3B1K+OoBtw+jlArBjVrFITsDHm35amfbBQgCizvCBe3
MiFNNkIRRt0cPPjH2SysiJs8J1qDO10Aqw6lxPUGwlCPzGDJDBfoWMB6o3n4O1Vl
tDEjm6LZ6fm981MDDeM38CzZI9X+XJOIGxTeICgIAIQFYNh40RsMOZB5mFnyYdaW
grLYolPvVrq6FxTyG4kqR1QmkhM07hwK25x5bMHNdSv6CBfunU0=
=SdMv
-----END PGP SIGNATURE-----
--=-=-=--
