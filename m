Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157A0C05027
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Feb 2023 23:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjBCXzC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Feb 2023 18:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjBCXzB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2023 18:55:01 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBEC68AF3
        for <linux-mmc@vger.kernel.org>; Fri,  3 Feb 2023 15:55:00 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cw4so6589466edb.13
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2023 15:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjF+AyumbkCroYCpRQKcqM9cxRCnUovfKnLOGpRIN+s=;
        b=FKCCAVUddag1opHQeKvMv4wdWqCwre69SRK8n27XialLZjd8H6hUcOfTvJG1KXcUaA
         tXR6HisbAoAlPxxz2fS6sm2qwptrTYIzVe4K/PVUBSPFHIkrH2P2ASQvlTDxxE4xM5Uy
         Qrx1XfN11zQb0leJtFcptPQYZCHVH1FB4Za8si9DZpFu/S7yOfloqRey3MT7FgMMgiQS
         oci9TUCK2JRiS6IA8gQZDv87KzAhiY7U4kjtAvN4xrkQXybNHqFpWsU/QTPNGwPsgbAd
         G1xUZyDFlms2Sg1jr01BH18ADmhQ2TPgr/9nKkltCMHUKOk1syS7Z9+Fc+Nl+B8eFIOM
         2riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjF+AyumbkCroYCpRQKcqM9cxRCnUovfKnLOGpRIN+s=;
        b=6NChGQQhQt0a1jUBRMri8cMAcsoJ25yX7wKuV+mcifsxeiG4zk8l1/OTHEWyPH3oxV
         JaY1MRhuP+SH/58xzc7LxHLBBE+947dyAq+l9N59DStOsddNgbwNq9hWGiQ/hnqWk2zj
         U18M54EyJ+gf77Wmr74r3Xg9FaPtvWQXAVC1x5GAr1PeiBdBCit0QjRBL6qzWCRxdNbM
         4ilJELOYrD4lHqhHiMj/Oi4c29wpAYKQlBIUknsXUD6DfUbVVDjeFAMyDoh4Ge1+Se3E
         SdhenE+AUA3/wLdvu5ty+4u9Fl++rF3mdSS0DFoWb+HTTzDN1QU+23Veu7zCHCJsjJKt
         FEow==
X-Gm-Message-State: AO0yUKWeK7mEPtli3mqWu3N1DC5ZBcdE3Xha1gXvscUQRkTyfTuh8E2o
        b2Z72MpaDSIlY1Z7HSObPjE=
X-Google-Smtp-Source: AK7set/8EtO/rSBe+ssFcgZE1P/ihXSBguQMxtMY5jcbuGFFuR8NJaiNvM//B+KsvSsAkT7LfrU9FA==
X-Received: by 2002:a50:aacf:0:b0:49c:fdd2:a47d with SMTP id r15-20020a50aacf000000b0049cfdd2a47dmr12624790edc.37.1675468498814;
        Fri, 03 Feb 2023 15:54:58 -0800 (PST)
Received: from ?IPV6:2a01:c23:b81c:5800:95fd:ccbf:6c44:23f7? (dynamic-2a01-0c23-b81c-5800-95fd-ccbf-6c44-23f7.c23.pool.telefonica.de. [2a01:c23:b81c:5800:95fd:ccbf:6c44:23f7])
        by smtp.googlemail.com with ESMTPSA id r17-20020a05640251d100b0046c7c3755a7sm1792895edd.17.2023.02.03.15.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 15:54:58 -0800 (PST)
Message-ID: <6d8f9fdc-7c9e-8e4f-e6ef-5470b971c74e@gmail.com>
Date:   Sat, 4 Feb 2023 00:53:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: [PATCH 1/2] mmc: core: add devm_mmc_alloc_host
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <e7880df5-43ab-d6b5-0ac3-440adfb12808@gmail.com>
In-Reply-To: <e7880df5-43ab-d6b5-0ac3-440adfb12808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a device-managed version of mmc_alloc_host().

The argument order is reversed compared to mmc_alloc_host() because
device-managed functions typically have the device argument first.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/core/host.c  | 26 ++++++++++++++++++++++++++
 include/linux/mmc/host.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index d17eda753..6a7475ad7 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -588,6 +588,32 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 EXPORT_SYMBOL(mmc_alloc_host);
 
+static void devm_mmc_host_release(struct device *dev, void *res)
+{
+	mmc_free_host(*(struct mmc_host **)res);
+}
+
+struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra)
+{
+	struct mmc_host **dr, *host;
+
+	dr = devres_alloc(devm_mmc_host_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return ERR_PTR(-ENOMEM);
+
+	host = mmc_alloc_host(extra, dev);
+	if (IS_ERR(host)) {
+		devres_free(dr);
+		return host;
+	}
+
+	*dr = host;
+	devres_add(dev, dr);
+
+	return host;
+}
+EXPORT_SYMBOL(devm_mmc_alloc_host);
+
 static int mmc_validate_host_caps(struct mmc_host *host)
 {
 	struct device *dev = host->parent;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8fdd3cf97..812e6b583 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -527,6 +527,7 @@ struct mmc_host {
 struct device_node;
 
 struct mmc_host *mmc_alloc_host(int extra, struct device *);
+struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra);
 int mmc_add_host(struct mmc_host *);
 void mmc_remove_host(struct mmc_host *);
 void mmc_free_host(struct mmc_host *);
-- 
2.39.1


