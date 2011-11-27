From: viresh kumar <viresh.linux@gmail.com>
Subject: Re: [PATCH] mmc: convert drivers/mmc/host/* to use module_platform_driver()
Date: Sun, 27 Nov 2011 19:12:51 +0530
Message-ID: <CAOh2x=mF2x+8DG0D2RiEoGsk4kFvi8S5V_MaWYVBP4B5m1sJvQ@mail.gmail.com>
References: <1322283343.14278.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51269 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab1K0Nmx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2011 08:42:53 -0500
In-Reply-To: <1322283343.14278.2.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Micha <mirq-linux@rere.qmqm.pl>, David Brown <davidb@codeaurora.org>, Ben Dooks <ben-linux@fluff.org>, Viresh Kumar <viresh.kumar@st.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Grant Likely <grant.likely@secretlab.ca>, Anton Vorontsov <cbouatmailru@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>

On Sat, Nov 26, 2011 at 10:25 AM, Axel Lin <axel.lin@gmail.com> wrote:
> This patch converts the drivers in drivers/mmc/host/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.
>
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
> ---
> =C2=A0drivers/mmc/host/bfin_sdh.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 12 +-----------
> =C2=A0drivers/mmc/host/cb710-mmc.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 13 +=
------------
> =C2=A0drivers/mmc/host/jz4740_mmc.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 12 +=
-----------
> =C2=A0drivers/mmc/host/msm_sdcc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 13 +------------
> =C2=A0drivers/mmc/host/mxcmmc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 13 +------------
> =C2=A0drivers/mmc/host/mxs-mmc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 13 +------------
> =C2=A0drivers/mmc/host/pxamci.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 13 +------------
> =C2=A0drivers/mmc/host/s3cmci.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 13 +------------
> =C2=A0drivers/mmc/host/sdhci-cns3xxx.c =C2=A0 | =C2=A0 12 +----------=
-
> =C2=A0drivers/mmc/host/sdhci-dove.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 12 +=
-----------
> =C2=A0drivers/mmc/host/sdhci-esdhc-imx.c | =C2=A0 12 +-----------
> =C2=A0drivers/mmc/host/sdhci-of-esdhc.c =C2=A0| =C2=A0 12 +----------=
-
> =C2=A0drivers/mmc/host/sdhci-of-hlwd.c =C2=A0 | =C2=A0 12 +----------=
-
> =C2=A0drivers/mmc/host/sdhci-pxav2.c =C2=A0 =C2=A0 | =C2=A0 12 +-----=
------
> =C2=A0drivers/mmc/host/sdhci-pxav3.c =C2=A0 =C2=A0 | =C2=A0 12 +-----=
------
> =C2=A0drivers/mmc/host/sdhci-s3c.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 13 +=
------------
> =C2=A0drivers/mmc/host/sdhci-spear.c =C2=A0 =C2=A0 | =C2=A0 12 +-----=
------
> =C2=A0drivers/mmc/host/sdhci-tegra.c =C2=A0 =C2=A0 | =C2=A0 12 +-----=
------
> =C2=A0drivers/mmc/host/sh_mmcif.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 14 +-------------
> =C2=A0drivers/mmc/host/sh_mobile_sdhi.c =C2=A0| =C2=A0 13 +----------=
--
> =C2=A0drivers/mmc/host/tmio_mmc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 14 +-------------
> =C2=A021 files changed, 21 insertions(+), 243 deletions(-)
>

> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-=
spear.c
> index dee70b6..883548e 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -320,17 +320,7 @@ static struct platform_driver sdhci_driver =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __=
devexit_p(sdhci_remove),
> =C2=A0};
>
> -static int __init sdhci_init(void)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return platform_driver_register(&sdhci_driver)=
;
> -}
> -module_init(sdhci_init);
> -
> -static void __exit sdhci_exit(void)
> -{
> - =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&sdhci_driver);
> -}
> -module_exit(sdhci_exit);
> +module_platform_driver(sdhci_driver);
>
> =C2=A0MODULE_DESCRIPTION("SPEAr Secure Digital Host Controller Interf=
ace driver");
> =C2=A0MODULE_AUTHOR("Viresh Kumar <viresh.kumar@st.com>");

=46or SPEAr:

Acked-by: Viresh Kumar <viresh.linux@gmail.com>
