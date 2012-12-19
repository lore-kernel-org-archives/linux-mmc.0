From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: 32kHz clock removal causes problems omap_hsmmc
Date: Wed, 19 Dec 2012 12:00:34 +0100
Message-ID: <50D19E52.9030003@ti.com>
References: <1352968293.10872.51.camel@cumari.coelho.fi>  <20121218095450.GB27751@arwen.pp.htv.fi>  <20121219094552.GN4985@opensource.wolfsonmicro.com>  <50D19040.5090404@ti.com>  <20121219100909.GO4985@opensource.wolfsonmicro.com>  <50D19463.5010605@ti.com>  <20121219103206.GQ4985@opensource.wolfsonmicro.com> <1355913954.5273.21.camel@cumari.coelho.fi> <50D19D54.2000307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52979 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922Ab2LSLAk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Dec 2012 06:00:40 -0500
In-Reply-To: <50D19D54.2000307@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Felipe Balbi <balbi@ti.com>, svenkatr@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, lrg@ti.com, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 12/19/2012 11:56 AM, Peter Ujfalusi wrote:
> BTW: have you happened to ubdate u-boot recently? There is a nice eas=
ter egg
> added there:
> f3f98bb ARM: OMAP4/5: Do not configure non essential pads, clocks, dp=
lls.
>=20
> Which means that _essential_ clocks and pads are no longer configured=
=2E

Meanwhile you can try to hack the u-boot to enable the 32k from there. =
It is
going to stay up since we do not have code to control it in the kernel =
anymore.

Also do something like this at the same time to get things working:
diff --git a/include/configs/omap4_common.h b/include/configs/omap4_com=
mon.h
index cbc9bdb..b0ff1ec 100644
--- a/include/configs/omap4_common.h
+++ b/include/configs/omap4_common.h
@@ -271,4 +271,8 @@

 #define CONFIG_SYS_THUMB_BUILD

+/* Configure all pins and clocks */
+#define CONFIG_SYS_ENABLE_PADS_ALL
+#define CONFIG_SYS_CLOCKS_ENABLE_ALL
+
 #endif /* __CONFIG_OMAP4_COMMON_H */

--=20
P=C3=A9ter
