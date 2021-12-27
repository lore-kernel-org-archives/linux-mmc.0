Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F289BC433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Dec 2021 13:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbhL0NgJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Dec 2021 08:36:09 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39588
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234268AbhL0NgG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Dec 2021 08:36:06 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CB5A93F32C
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 13:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612165;
        bh=WfhTTV0Y1eE7nwdIxKma7kRI9gj0CY3EEbVZ0tpJfUg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=IFpnmxbGFbtDN07vJgOejAu58F45qJuOLNd4UZQ05QWeUyya/HbrP29z+YiJY1xMz
         b9/YZcZPzKEs8pDnlbTdFYKi26mxxTetIuPbZtkFFK34KvdAcdKRRCz079UVoM3bEj
         386d4xDhL5T8ccS2nA+0COjWKnnsIGRpPcaVu57v6ukRmRC1KHkVesoHKsP+SsFXvQ
         72C2QaBDnK5Qp+rV1WRzyaOf9iicP6w35gQoEpa2vVRurR/cZPXf0u6xPZmWcHkFqU
         bBZ3KZGo71F/wyJN+Dk2BwdrF7yJq55CFE7fsFl8jgNn152ACdXdE90b4H7WuYcHpr
         Ukuppgz3LuFhQ==
Received: by mail-lj1-f199.google.com with SMTP id u8-20020a05651c130800b0022d6dad0418so4973180lja.11
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 05:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfhTTV0Y1eE7nwdIxKma7kRI9gj0CY3EEbVZ0tpJfUg=;
        b=duKJAp766kxz78RI9h+yXea7Esp0YeLP4hohevC+83vO5deF17HeXA7+ArYIvJ42y3
         qZy/+2aMc2ihQYOK1UNW9niRRmlQCDMN0ZABoebB+zC449wDSRAY91yYM/UjH6s+YB46
         CvAdKe5uFYAl7YF6r3YMhEqQv2hNVcV1PfSYY2/ojWSQO/YM0mZ8a+/yGDJhb+ykczmN
         3H9w7/NPOMYvjQ2Vm8/j5A+3yXUvDWrf0FN7ZwrQpThwV+p71hQkBlYilikZKirTm+7z
         Abh1oTmcwg2Gix5GKkpj14HXU3xi3P3G3ljUCkiIW5A8oM8a9O157P2b/kKjGiDbdh8J
         /2Jg==
X-Gm-Message-State: AOAM533+EKd/pj9/KMoodFgmbJvHKRCn/9jm5Fhwld8Hh8bn2PDWgt5U
        CTo/dHs/fuQPjFYiVuWAV7A6sWyA+Rf8gaS3IR25SQbcJvMVzqH56GsciRoqv6/9GvRfFryaMTP
        FV5RDx353hqUFUFxzZ9a9QB8J+xHGQ8SPiA941w==
X-Received: by 2002:a19:6502:: with SMTP id z2mr15579096lfb.151.1640612165309;
        Mon, 27 Dec 2021 05:36:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy38iR16DrL9VfxBjC243Im/jp4zdjU6XJ5h3h1PY0QPqf2vwc+9AKP2xWJxPjm2ge92SselA==
X-Received: by 2002:a19:6502:: with SMTP id z2mr15579082lfb.151.1640612165142;
        Mon, 27 Dec 2021 05:36:05 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 10/19] ARM: dts: arria5: add board compatible for SoCFPGA DK
Date:   Mon, 27 Dec 2021 14:35:49 +0100
Message-Id: <20211227133558.135185-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Altera SoCFPGA Arria V SoC Development Kit is a board with Arria 5,
so it needs its own compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/socfpga_arria5_socdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_arria5_socdk.dts b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
index 1b02d46496a8..0e03011d0247 100644
--- a/arch/arm/boot/dts/socfpga_arria5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
@@ -7,7 +7,7 @@
 
 / {
 	model = "Altera SOCFPGA Arria V SoC Development Kit";
-	compatible = "altr,socfpga-arria5", "altr,socfpga";
+	compatible = "altr,socfpga-arria5-socdk", "altr,socfpga-arria5", "altr,socfpga";
 
 	chosen {
 		bootargs = "earlyprintk";
-- 
2.32.0

