Return-Path: <SRS0=Rn8H=CN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F7BC43461
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Sep 2020 08:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C580020791
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Sep 2020 08:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BBvwVZVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgIDIJK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:09:10 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:30821 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgIDIJH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Sep 2020 04:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1599206946; x=1630742946;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version:content-transfer-encoding;
  bh=8kg7NVGvA/Y4ravBA+Ck9g+ekPrMr/sJwXHN4ceS2DY=;
  b=BBvwVZVA5EyI70ql0luan7uUrbQjOW9SWdfqJNCAQkQSKVmq+Ay0idPf
   Ee50RPVHTkouPwJr5cWSL0a9hxC6DqV/7ps2eqGXnpXLP21QWSOAjXJKa
   ZcM9Zwfj7Ydzj7hU78ohR2BWuojh+ITMtkNcTAyQwZ3UoVrejJ5LzHFUG
   Fb9+F0KqZA3G/2HHlaOHcfIyh+RaEo3LW2HVmV4lLQNtGnIOYDFwCxKHI
   4uQMcyptwlWsLKXk33HTU4cLNhqrcPdH/yKy9enHrIPsSGi+l4JmtQG/I
   3LfL0lnLStkBHaX2eIWzkijQXnZyOSW1Kyt+gnPd15a5BQRrYlC63vOJH
   g==;
IronPort-SDR: gFJOOhxnbMekT+gVguHT6+Xjx6sB8n0ubMR5otjKsB+saYnGsOOppBCh+Fj0+R+9J65PTYV2wf
 dGSvHGIUiWDX8mmGYWMD9l5tHBxzEVhOzHkD0xk0VJAyFaqkKnXGuLkFAquFe8OYNFzYg5us/O
 5hPW1xnCuOFYZvDMcr+oFh27Ht4NZ8KdA2fEMvQdWVpXfGghpUjg9s+QOe53DLcVCB3Wk62jPv
 FRF6/hiBOfsRphm+lo3KYSbpidZ+5L8BTG4RFT/HBis8Eclgsv7eK/7BIThzFeFJvMZn81bb0k
 0Ec=
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="90544258"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Sep 2020 01:09:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 4 Sep 2020 01:08:54 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Fri, 4 Sep 2020 01:08:04 -0700
References: <20200902193658.20539-1-krzk@kernel.org> <20200902193658.20539-11-krzk@kernel.org>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "Steen Hegelund" <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 10/11] mmc: sdhci-of-sparx5: Use proper printk format for dma_addr_t
In-Reply-To: <20200902193658.20539-11-krzk@kernel.org>
Date:   Fri, 4 Sep 2020 10:08:48 +0200
Message-ID: <87zh66vu9b.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


Krzysztof Kozlowski writes:

> dma_addr_t size varies between architectures so use dedicated printk
> format to fix compile testing warning (e.g. on 32-bit MIPS):
>
>   drivers/mmc/host/sdhci-of-sparx5.c:63:11: warning:
>     format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘dma_addr_t {aka unsigned int}’ [-Wformat=]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mmc/host/sdhci-of-sparx5.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
> index 14b5dad6575a..747f108a0ace 100644
> --- a/drivers/mmc/host/sdhci-of-sparx5.c
> +++ b/drivers/mmc/host/sdhci-of-sparx5.c
> @@ -60,8 +60,8 @@ static void sdhci_sparx5_adma_write_desc(struct sdhci_host *host, void **desc,
>                 return;
>         }
>
> -       pr_debug("%s: write_desc: splitting dma len %d, offset 0x%0llx\n",
> -                mmc_hostname(host->mmc), len, addr);
> +       pr_debug("%s: write_desc: splitting dma len %d, offset %pad\n",
> +                mmc_hostname(host->mmc), len, &addr);
>
>         offset = addr & (SZ_128M - 1);
>         tmplen = SZ_128M - offset;

Acked-by: Lars Povlsen <larc.povlsen@microchip.com>

-- 
Lars Povlsen,
Microchip
