Return-Path: <SRS0=Rn8H=CN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF644C433E2
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Sep 2020 08:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F00206B8
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Sep 2020 08:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pcRvcBUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIDIOh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:14:37 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:13762 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgIDIOg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Sep 2020 04:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1599207276; x=1630743276;
  h=references:from:to:cc:subject:message-id:in-reply-to:
   date:mime-version;
  bh=C+bBXo0rf5HHX2D82rfzwmnGYsZpnmPVAqTS90P4am0=;
  b=pcRvcBUqHdlNCEP+t1VZnniPGamW6WX7EnuqYI7Bl7Y0efdw0QRverRr
   kW4VRxL0b2hh9m2sDjX6065afA5bLOcbEHQsXXr++eK0Ntge4Z3P9D8fS
   rEY7X6ns+JkKU+jyWkn6ktjp8n5OYLWwTDsFtld8zuHhvjLWkst4/pFab
   iVDiqlaWcQ9r7LUzO8djT2+nBHpXs5aDs4Rxl2we1GvRQIJP0VxMguaVs
   VolIIU2zGSCGGWQcU/paU+WXNsjA274rsrc7pML7U/hL6MJBz8cJFcma5
   YdeWsoUPwDyFvFMUVV8Q2HtS2bAPqoSytlkhtu0y232oqNUVGIeYA0rHN
   w==;
IronPort-SDR: 8nv+Um/Ajp+8yrHw100jjMRAOk4Jxm6ZdpjZuFbSFSqzSHVNfarzUTxB4U/zHleMXwKqeSV43E
 nPBHsUvfd8GH4ukaL7bmc21hsu8jj78TFnNccjxmDAJggvvVjdKuxZTG8Z1mZPuOjbMJ9sEhts
 AGUYa4FtxwdKyya67QIctsoP6Sy9a6tLX6b96xzX/ULE3qrv5lpEP10xP5SCsNCbwZy/31TiMl
 lKOqpWkVpu+zgj1+DCdXM8Huxgb0GC19DjdqLZn6dkM/iDU+Dr6VMlGJdc8JpNvqQUdoiZwVpQ
 28w=
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="25333146"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Sep 2020 01:14:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 4 Sep 2020 01:14:33 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Fri, 4 Sep 2020 01:13:42 -0700
References: <20200903232441.2694866-1-dianders@chromium.org> <20200903162412.6.Ib121debfb18e5f923a3cd38fe9c36aa086c650c5@changeid>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Douglas Anderson <dianders@chromium.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>, <swboyd@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "Lars Povlsen" <lars.povlsen@microchip.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 6/6] mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that are newer than 5.4
Message-ID: <87y2lqvu0m.fsf@soft-dev15.microsemi.net>
In-Reply-To: <20200903162412.6.Ib121debfb18e5f923a3cd38fe9c36aa086c650c5@changeid>
Date:   Fri, 4 Sep 2020 10:14:29 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


Douglas Anderson writes:

> This is like commit 3d3451124f3d ("mmc: sdhci-msm: Prefer asynchronous
> probe") but applied to a whole pile of drivers.  This batch converts
> the drivers that appeared to have been added after kernel 5.4.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/mmc/host/meson-mx-sdhc-mmc.c | 1 +
>  drivers/mmc/host/owl-mmc.c           | 1 +
>  drivers/mmc/host/sdhci-esdhc-mcf.c   | 1 +
>  drivers/mmc/host/sdhci-milbeaut.c    | 1 +
>  drivers/mmc/host/sdhci-of-sparx5.c   | 1 +
>  5 files changed, 5 insertions(+)
>

[snip]

> diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
> index 747f108a0ace..28e4ee69e100 100644
> --- a/drivers/mmc/host/sdhci-of-sparx5.c
> +++ b/drivers/mmc/host/sdhci-of-sparx5.c
> @@ -255,6 +255,7 @@ MODULE_DEVICE_TABLE(of, sdhci_sparx5_of_match);
>  static struct platform_driver sdhci_sparx5_driver = {
>         .driver = {
>                 .name = "sdhci-sparx5",
> +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>                 .of_match_table = sdhci_sparx5_of_match,
>                 .pm = &sdhci_pltfm_pmops,
>         },

Acked-by: Lars Povlsen <lars.povlsen@microchip.com>

-- 
Lars Povlsen,
Microchip
