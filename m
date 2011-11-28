From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mmc: convert drivers/mmc/host/* to use
 module_platform_driver()
Date: Mon, 28 Nov 2011 09:42:36 +0100
Message-ID: <20111128084236.GQ27267@pengutronix.de>
References: <1322283343.14278.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56201 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab1K1Im5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2011 03:42:57 -0500
Content-Disposition: inline
In-Reply-To: <1322283343.14278.2.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Micha <mirq-linux@rere.qmqm.pl>, David Brown <davidb@codeaurora.org>, Ben Dooks <ben-linux@fluff.org>, Viresh Kumar <viresh.kumar@st.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Wolfram Sang <w.sang@pengutronix.de>, Grant Likely <grant.likely@secretlab.ca>, Anton Vorontsov <cbouatmailru@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Sat, Nov 26, 2011 at 12:55:43PM +0800, Axel Lin wrote:
> This patch converts the drivers in drivers/mmc/host/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.
>=20
> Cc: "Micha=C5=82 Miros=C5=82aw" <mirq-linux@rere.qmqm.pl>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Ian Molton <ian@mnementh.co.uk>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Anton Vorontsov <cbouatmailru@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

=46or the mxcmmc driver:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
