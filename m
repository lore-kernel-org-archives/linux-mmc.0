From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 00/18] ARM: Add minimal Raspberry Pi 4 support
Date: Mon, 22 Jul 2019 11:01:10 -0700
Message-ID: <87a7d6eyop.fsf@anholt.net>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7091143106109168187=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Stefan Wahren <wahrenst@gmx.net>
List-Id: linux-mmc@vger.kernel.org

--===============7091143106109168187==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Stefan Wahren <wahrenst@gmx.net> writes:

> This series adds minimal support for the new Raspberry Pi 4, so we are able
> to login via debug UART.
>
> Patch 1-5:   Prepare platform and DTS for the new SoC BMC2711
> Patch 6-10:  Enable support for emmc2 on BCM2711
> Patch 11-12: Enable pinctrl for BCM2711
> Patch 13-17: Add Raspberry Pi 4 DTS support
> Patch 18:    Update MAINTAINERS
>
> Unfortunately the Raspberry Pi Foundation didn't released a
> peripheral documentation for the new SoC yet. So we only have a preliminary
> datasheet [1] and reduced schematics [2].
>
> Changes since RFC:
> - change BCM2838 -> BCM2711 as discussed in RFC
> - update MAINTAINERS accordingly
> - drop "spi: bcm2835: enable shared interrupt support" from series
> - squash all pinctrl-bcm2835 changes into one patch
> - introduce SoC specific clock registration as suggested by Florian
> - fix watchdog probing for Raspberry Pi 4
> - convert brcm,bcm2835.txt to json-schema
> - move VC4 node to bcm2835-common.dtsi
> - fallback to legacy pull config for Raspberry Pi 4
> - revert unintended change of mailbox in bcm283x.dtsi
> - add reference for arm64


I gave some comments on the bcm2835-common patch, but I think this is a
good start and would be worth merging to start bringing the board up,
even without a respin.

Series is:

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAl01+eYACgkQtdYpNtH8
nuhCnhAAgBRNPAZ35O+bC/XiTCvTUwVxyNmNbtrkztXtBUlmBKrifmsuKEkCbjZb
yMAmwOIMZtwC8HzeH4h4/bTd/l0djswGTPjb5hoko3u0CFfRnZnMgBwyFenfdThc
SCI8/+zNSl8JFnmGKKdARYW2gvm2LySsBYS69YC33IhBCPquSHcBupZ7Y/GJYzt0
KYOGnRglYuUQmJdwBzK/3x9qi4wBaC2wh6X1WRErBrFoY6neodUNT5BAVko4hVXO
aS5Ej5u0Yx+1VNgNx64DfT8S5WRfpy2wmhwujYn04MWt4PcryHKY8HU7T+UW+/tg
PVw+yVnsyC+1ctvmW7qXEDY+41msPKcxUIYMEOskftCKGnM7criZrEp6W8m5dVag
VmlnK/r8JESbAzgBCKE6G0opua0OCGzuOU8GmdFA2eXd6wwwG+uW+SBArjZi7UxF
p2q7YB52eyzNenqn4pYMrmgRFiO2I3Ai4+zHnPM0tWt2pysfW1uG6wqaJlCPiSJj
WbIN9dmcauHFKsiiJs3TUIDkWhEcSA0v95wL3k6ormEn+FtKYFbf90R36lRmK49S
2G70Bd8yGl/kEYAL3+Kb5lBTaqhO8B0uV+M4nN5a73K/LXwQ2kZ/RWsgaQzLPMFa
3C/xv0Ld6qx/gNSWR2bRcV/DydAP1UjfJaidCUE2tnpWJFmQo7U=
=dYeO
-----END PGP SIGNATURE-----
--=-=-=--


--===============7091143106109168187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7091143106109168187==--
