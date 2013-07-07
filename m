From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: use for OMAP5 as well
Date: Sun, 7 Jul 2013 17:13:10 -0300
Message-ID: <20130707201309.GA5429@localhost>
References: <1372422894-23729-1-git-send-email-a-bindra@ti.com>
 <51CDB260.8080108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:56534 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab3GGUNH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Jul 2013 16:13:07 -0400
Content-Disposition: inline
In-Reply-To: <51CDB260.8080108@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: a-bindra@ti.com, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, balbi@ti.com, nm@ti.com

Hi guys,

On Fri, Jun 28, 2013 at 09:27:20PM +0530, Balaji T K wrote:
> On Friday 28 June 2013 06:04 PM, a-bindra@ti.com wrote:
> > From: Amarinder Bindra <a-bindra@ti.com>
> >
> > OMAP's hs_mmc driver is also used for OMAP5 MMC controller operatio=
n.
> > Considering that the device tree entries are already there for this=
,
> > allow the driver to be built when only OMAP5 is enabled.
> > This allows MMC root filesystems to be available in "OMAP5 only"
> > configurations.
> >
> > Signed-off-by: Amarinder Bindra <a-bindra@ti.com>
> > Acked-by: Felipe Balbi <balbi@ti.com>
> > Acked-by: Nishanth Menon <nm@ti.com>
>=20
> Looks good to me,
> Acked-by: Balaji T K <balajitk@ti.com>
>=20

I came across this same issue while trying MMC patches on AM3xx,
which is nor OMAP3 neither OMAP4.

Now, looking at the driver I don't see any OMAP-specific bits
(welcome to the multiplatform world ;-) so I think we can just
remove the 'depends' line. Something like this:

---
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 9ab8f8d..bade7f2 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -273,10 +273,9 @@ config MMC_OMAP
=20
 config MMC_OMAP_HS
 	tristate "TI OMAP High Speed Multimedia Card Interface support"
-	depends on SOC_OMAP2430 || ARCH_OMAP3 || ARCH_OMAP4
 	help
 	  This selects the TI OMAP High Speed Multimedia card Interface.
-	  If you have an OMAP2430 or OMAP3 board or OMAP4 board with a
+	  If you have an OMAP2430, OMAP3, OMAP4 or AM3xx board with a
 	  Multimedia Card slot, say Y or M here.
=20
 	  If unsure, say N.

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
