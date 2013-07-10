From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2] mmc: omap_hsmmc: use the generic config for omap2plus
 devices
Date: Wed, 10 Jul 2013 19:42:54 -0300
Message-ID: <20130710224253.GA2338@localhost>
References: <1372422894-23729-1-git-send-email-a-bindra@ti.com>
 <1373472384-13067-1-git-send-email-a-bindra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1373472384-13067-1-git-send-email-a-bindra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: a-bindra@ti.com
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 10, 2013 at 09:36:24PM +0530, a-bindra@ti.com wrote:
> From: Amarinder Bindra <a-bindra@ti.com>
>=20
> OMAP's hs_mmc driver is used for MMC controller operation on many
> omap2plus SoCs (OMAP2430, OMAP3, 4, 5 and AM335x).
>=20
> Considering that the device tree entries are already present for thes=
e,
> allow the driver to be built using the config ARCH_OMAP2PLUS rather
> than individually adding a config for each SoC to enable the
> support.
>=20
> Use COMPILE_TEST to enable the build for other platforms.
>=20
> Signed-off-by: Amarinder Bindra <a-bindra@ti.com>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Nishanth Menon <nm@ti.com>

Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
