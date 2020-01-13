Return-Path: <SRS0=rMqt=3C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847DFC33CAF
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59527222C4
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZ5FNozJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAMVIA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:08:00 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40747 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbgAMVH7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2020 16:07:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so5297266pgt.7;
        Mon, 13 Jan 2020 13:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5CAP7vT78sJ7ShUW4RVOxpE+JfJTOO+iEZfiA9Ic9Ok=;
        b=JZ5FNozJHtqB38WQ7SVPzNJy5Il5TQRFnfhZR7yzCDo5bdXPLtP0RUlP6yV7bIzd78
         z1UXKwnP7GfNiP7jt5dAmvY0ZUFg9e4TqhPVx1hO0R2JZE6ZrMtveQCiFJ+7yI/M+gF2
         AM7G9aWjAXLmZIsj4JAxN7LBdrqDyibZW1737i20WPIoQEIfkAUPTlvyMaj1iCkXzxeJ
         8rysh4DomHv8VgdDBWiYQ0dIJhAY9NCwcnd5MxP0aeBeBrT2dHxjTN/n4DrquS/kkj7g
         BxGoxZHBf8JYSH7rAONXfPkZVSK3JebIL7GqtnAtND1EfunK8+4J/Sc5qku+PXA9SLRE
         QU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5CAP7vT78sJ7ShUW4RVOxpE+JfJTOO+iEZfiA9Ic9Ok=;
        b=PceosCUJxPpo4uBW0bN32O2DKA8XvsKiuQIUpurljwX5a43eh/6adr78TdMfWkn7Mn
         RnFx3CpzEHIQjf6PKCA+xCuprqSSdg8Ll5H9ufxfmfDKJyesETX/isfAAFOtjvO1+/dQ
         2UhUsC+Z8horrUNRuI8MFmg5+rkCzD0UF40rwW43mEWlXJwXqBV84SdPvoQuePCBupLy
         iCHS6XzP7lryqU9eDgF8WgCn2SuP6cfuGrFou4Vu0VgY8QKZ1TqMq73I3Km5srVZebEs
         j9xu/qMtuBIgajLfI3Dyxd1FunqmaIzZcPOzdO2pb8fCZ8GsTABVt+7c2IE70ZjntUDN
         sNhA==
X-Gm-Message-State: APjAAAVGW7McbyjIEtGSdfk3UscuVZd0SP9HGZZl43N4/BOjrthpvZl3
        xwzRczplj06LJDHEXHQbiqWW+JgvIMJaag==
X-Google-Smtp-Source: APXvYqwk0d1fEyYVDxkLaN2UU1oTmel6YbkzKPFuVHpnNlXMqHO4ed/D6FyMrUyjKuAJus6QcKitpw==
X-Received: by 2002:a63:6704:: with SMTP id b4mr23575633pgc.424.1578949677899;
        Mon, 13 Jan 2020 13:07:57 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id s1sm14195827pgv.87.2020.01.13.13.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:07:57 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Takao Orito <orito.takao@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 4/6] mmc: sdhci-brcmstb: Add shutdown callback
Date:   Mon, 13 Jan 2020 16:07:04 -0500
Message-Id: <20200113210706.11972-5-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113210706.11972-1-alcooperx@gmail.com>
References: <20200113210706.11972-1-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Shutdown controller and disable it's clocks to insure max power
savings in S5 on systems that leave power on.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 218176b79b6a..7ea426ba5cbc 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -161,6 +161,15 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	return res;
 }
 
+static void sdhci_brcmstb_shutdown(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = sdhci_pltfm_unregister(pdev);
+	if (ret)
+		dev_err(&pdev->dev, "failed to shutdown\n");
+}
+
 MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
 
 static struct platform_driver sdhci_brcmstb_driver = {
@@ -171,6 +180,7 @@ static struct platform_driver sdhci_brcmstb_driver = {
 	},
 	.probe		= sdhci_brcmstb_probe,
 	.remove		= sdhci_pltfm_unregister,
+	.shutdown	= sdhci_brcmstb_shutdown,
 };
 
 module_platform_driver(sdhci_brcmstb_driver);
-- 
2.17.1

