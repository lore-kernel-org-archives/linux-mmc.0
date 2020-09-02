Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6338BC433E7
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394E22083B
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599075456;
	bh=KnAHsAhCAvOSLEBHOSIHPUitvjNtd94PQrfzNeHigMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dewsa/IixruzcXjxO0GNaZ0ievtceAvUdpcdNRjx591k7PNW8qTUd11J4rpbK3qtv
	 oF52qs7qlBIuk5BAS7IuJZM/NPILwwAPCY5nwY9wj9A8Lp7HnDKMnMXKFO6JmNRwTM
	 tqH+x7bqXVI3YJ7jE4TV80ntMxYc0d2dl1hYmwRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgIBThb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBTha (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Sep 2020 15:37:30 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D7AE20DD4;
        Wed,  2 Sep 2020 19:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599075449;
        bh=KnAHsAhCAvOSLEBHOSIHPUitvjNtd94PQrfzNeHigMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19NPyyAcEVgKpUIQmCzm9NfZXOVi4EvtLXUxhb9JhGvBxUoYLFBw0XhFE+fhf7l/2
         +6GrTOaxG2bbUyo4FaCsAwqxY5x3Tkjsv4OYAnIw4CF70blUiyO4EPix+MupLV/ENG
         xBIIWbitsRGyj0I3mJcl+fyJyRkcboB+HfLj1eWI=
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
Subject: [PATCH 02/11] mmc: davinci: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 21:36:49 +0200
Message-Id: <20200902193658.20539-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902193658.20539-1-krzk@kernel.org>
References: <20200902193658.20539-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/davinci_mmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index e50a08bce7ef..fad1010fb52b 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1240,9 +1240,8 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 		pdev->id_entry = match->data;
 		ret = mmc_of_parse(mmc);
 		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"could not parse of data: %d\n", ret);
+			dev_err_probe(&pdev->dev, ret,
+				      "could not parse of data\n");
 			goto parse_fail;
 		}
 	} else {
-- 
2.17.1

