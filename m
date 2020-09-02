Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C67C433E7
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 21:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B90207EA
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 21:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="rHYnDWAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgIBVcj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 17:32:39 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:38076 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIBVcf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Sep 2020 17:32:35 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Bhcbd1b8Vz98;
        Wed,  2 Sep 2020 23:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1599082353; bh=GDacUcTntXycW3HLTxPt24O1o6lCFXAi5egUm6GCp7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rHYnDWANlv95qPZreUCEccYzoc77bbn+WHcWLJBhy6sn2k0K4siHC9hoVsg+/+rOT
         zpJN1ArAy6bRh8O8FYxl6b/YXBF/SfufJWDOIjWLCmRkcKf6/Q198a+VlFWD/9SIEt
         s2A8OY2emLgL0NZ0+IO9zWHcTD2D3VMSd8/XI8WiPTH9wx3s/Ox7PMcYFv7OoKe22G
         CWJfP93yPUm3WmdRyzoWFdXNAQYiefjsgD9XqWJgJpRDrTYgw7/+C1dlKP7E7+IAYp
         QXUAyzBTUSibrhBWvSWkJpT/Y6kx5cNKggPC19kRufrVfbMXvq8l3UrS2OKWbIV5mH
         osyOa4JHgkY6Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Wed, 2 Sep 2020 23:32:27 +0200
From:   =?iso-8859-2?B?TWljaGGzoE1pcm9zs2F3?= <mirq-linux@rere.qmqm.pl>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 11/11] mmc: host: Enable compile testing of multiple
 drivers
Message-ID: <20200902213227.GE1624@qmqm.qmqm.pl>
References: <20200902193658.20539-1-krzk@kernel.org>
 <20200902193658.20539-12-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902193658.20539-12-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Sep 02, 2020 at 09:36:58PM +0200, Krzysztof Kozlowski wrote:
> Multiple MMC host controller driver can be compile tested as they do not
> depend on architecture specific headers.
[...]
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -178,7 +178,7 @@ config MMC_SDHCI_OF_AT91
[...]
>  config MMC_MESON_GX
>  	tristate "Amlogic S905/GX*/AXG SD/MMC Host Controller support"
> -	depends on ARCH_MESON && MMC
> +	depends on MMC
> +	depends on ARCH_MESON|| COMPILE_TEST
[...]
>  config MMC_MOXART
>  	tristate "MOXART SD/MMC Host Controller support"
> -	depends on ARCH_MOXART && MMC
> +	depends on MMC
> +	depends on ARCH_MOXART || COMPILE_TEST
[...]

You can drop 'MMC' from depends as the whole tree is under 'if MMC' already.

Best Regards,
Micha³ Miros³aw
