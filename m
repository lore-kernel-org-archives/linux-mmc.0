Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCF9C433E2
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC28220C56
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599075929;
	bh=+D+HnNz+VrpzF30cgOx0/44g3rIEaRFahWzOaAq0owE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YWdUqxQODdRNeLzPL3k2yMh0zZOeMYY9Krrbr2ffGA5iR/jULWeryPJV4sJ4EfIpn
	 26p2D3ps04EsFTmJGXoVyUCeqTcLHVOCbawIFRVzNsEepV78GWAZeiG9lp9+DG37aq
	 nQtqe0h+IwJFaKstExl+n8c3NBMar+3kBUha3H8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIBTp2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBTp1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Sep 2020 15:45:27 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C98D20773;
        Wed,  2 Sep 2020 19:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599075435;
        bh=+D+HnNz+VrpzF30cgOx0/44g3rIEaRFahWzOaAq0owE=;
        h=From:To:Cc:Subject:Date:From;
        b=1SQS24JOeFsx1iasRvSrQ65PxPvLq6dmxeYcepsSK8GUZGbyMelZlNIuhySqBfDi1
         bZnWylzcAirhjbBZDld4bG3srPaamgSu01Z9UN63UVkQ+oyD8xxZqDnIHmEKgpQ6sm
         zRt4WFNvhEsJP72JojS+Lha8JOjX4CQ66Zr6jp9Y=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
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
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 00/11] mmc: Minor cleanups and compile test
Date:   Wed,  2 Sep 2020 21:36:47 +0200
Message-Id: <20200902193658.20539-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

Set of minor cleanups.  Patches requiring more attention:
 - 6/11: Testing and review would be appreciated,
 - 11/11: I build tested multiple architectures but not all and
   definitely no all possible configs. This one could sit on the lists
   for few days so 0-day would try it.

Best regards,
Krzysztof

Krzysztof Kozlowski (11):
  mmc: bcm2835: Simplify with dev_err_probe()
  mmc: davinci: Simplify with dev_err_probe()
  mmc: dw_mmc-zx: Simplify with dev_err_probe()
  mmc: jz4740: Simplify with dev_err_probe()
  mmc: meson: Simplify with dev_err_probe()
  mmc: sdhci-brcmstb: Simplify with optional clock and dev_err_probe()
  mmc: sdhci-of-arasan: Simplify with dev_err_probe()
  mmc: sdhci-tegra: Simplify with dev_err_probe()
  mmc: dw_mmc: Simplify with dev_err_probe()
  mmc: sdhci-of-sparx5: Use proper printk format for dma_addr_t
  mmc: host: Enable compile testing of multiple drivers

 drivers/mmc/host/Kconfig           | 42 ++++++++++++++++--------------
 drivers/mmc/host/bcm2835.c         |  4 +--
 drivers/mmc/host/davinci_mmc.c     |  5 ++--
 drivers/mmc/host/dw_mmc-zx.c       | 11 +++-----
 drivers/mmc/host/dw_mmc.c          |  9 +++----
 drivers/mmc/host/jz4740_mmc.c      |  5 ++--
 drivers/mmc/host/meson-gx-mmc.c    | 16 ++++--------
 drivers/mmc/host/sdhci-brcmstb.c   | 12 ++++-----
 drivers/mmc/host/sdhci-of-arasan.c |  7 +++--
 drivers/mmc/host/sdhci-of-sparx5.c |  4 +--
 drivers/mmc/host/sdhci-tegra.c     |  7 ++---
 11 files changed, 51 insertions(+), 71 deletions(-)

-- 
2.17.1

