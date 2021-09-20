Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3915DC4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 02:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D246044F
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 02:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhIUCna (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238896AbhIUCDK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2021 22:03:10 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F78C140932;
        Mon, 20 Sep 2021 11:12:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t10so64979380lfd.8;
        Mon, 20 Sep 2021 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=myD2habKvt7RXAHJbtKPfyU4WLnqnb1bLB54hjelw1E=;
        b=Wwh5Bp61loEgevDUFcsNB1xPMhR1XTpK+N5ivwKy3o+MQreoLkBZiSjBr1jHTPesp/
         y/RfPU1kIhmHBS4vZnv1ofR8MSrfOTaVskrC+CjJ/iyi3SBAtlMhN/5K8QIbifnjOkuu
         Dh97HFATcsIjwx7rWqSro8j+RixDozr05vXauDn4codyUtrpkPAL8OacgXCjMiw9sU6H
         hrJ4bNYPWROFg+PHVRJTKZ6aEWK/3UsIAIkJtdyUrIhQx3KUJx5sHmCOuzEu7Je3Fd8E
         k+UQaoNQXUCMSbxKpQfnFFK1bid7z+ov06RC5SgaW3u6UB/EwwGVRrTWh9dh9YT+vmxe
         5cHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myD2habKvt7RXAHJbtKPfyU4WLnqnb1bLB54hjelw1E=;
        b=ZE4+6GfUTH6mbtgRxt4yXYK6aLBHQuo1VKcYVWzF5uUy0Pu5qo1I3+QYRB1FKSb4/H
         ZpmE83fAm+O/v/KnvPVHR6h6c/PB3vRHo+qnQw+YdIttgkfEk7w1xisS/n3gicr1C2VC
         8P6Xa1XHT0Zv2BLETyff8/feV/3cP8CuBjAkIYvBhAFXlp6yCiSww6e7IryIprfE9Mx3
         68rjoEBHOI9SkIxcJwPDhaG4rJrxdjXzyOHYb/+AioArkC9utjBkF35nKh1skI2JaJR7
         +lBeq+s4kMVkaNjTS4Tv4IuFumC9GewvXXsJ2J4EElgJ5JWYJeHQ16xrbcLocYRKgMF4
         ImIg==
X-Gm-Message-State: AOAM531u63R2miD1fC3yoLlJVHQi7MEghW/Uba1FSmc0nct3UeZEquAf
        TvoyOvJiZwnQ/iuLSH/b0Fg=
X-Google-Smtp-Source: ABdhPJx0jdF0TRfniBGFptMPciVnLNS38vWQMz2X5dyyfZ8CmknMYMYEDaHex2CJkph6/kiivPojgA==
X-Received: by 2002:a2e:2243:: with SMTP id i64mr16693903lji.333.1632161556519;
        Mon, 20 Sep 2021 11:12:36 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id u3sm1775677lju.107.2021.09.20.11.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:12:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v12 29/35] soc/tegra: pmc: Rename core power domain
Date:   Mon, 20 Sep 2021 21:11:39 +0300
Message-Id: <20210920181145.19543-30-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920181145.19543-1-digetx@gmail.com>
References: <20210920181145.19543-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

CORE power domain uses name of device-tree node, which is inconsistent with
the names of PMC domains. Set the name to "core" to make it consistent.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 6759f19b9cd6..3e52ceada60c 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1353,7 +1353,7 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 	if (!genpd)
 		return -ENOMEM;
 
-	genpd->name = np->name;
+	genpd->name = "core";
 	genpd->set_performance_state = tegra_pmc_core_pd_set_performance_state;
 	genpd->opp_to_performance_state = tegra_pmc_core_pd_opp_to_performance_state;
 
-- 
2.32.0

