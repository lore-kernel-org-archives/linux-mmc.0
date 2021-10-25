Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD45C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Oct 2021 01:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9919A61002
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Oct 2021 01:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhJYByc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 24 Oct 2021 21:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbhJYByb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Oct 2021 21:54:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A90C061764
        for <linux-mmc@vger.kernel.org>; Sun, 24 Oct 2021 18:52:09 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 187so9190471pfc.10
        for <linux-mmc@vger.kernel.org>; Sun, 24 Oct 2021 18:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=75BUDHsCAc/I/IWJxwpyHr24/zOyWSJ/QNW0ySt+dfg=;
        b=My3P6rOTPOzPfq2Fz7QDcal86fAyuhU8/JKHhqJv7jrknvkIQmnVXKHgwK4tKxoEgz
         ZmXcMbqZ5IIOZ0//lm868qZBOcLS9yPL+6eD7T1OQkS8aJ+5lJBgSvduEIV2Ddgjn7b8
         Qf4y3fALRYTCynERow8urdMsyKBZLDrtAjPAnriaaBOJOFYvyxlwwhUABqym3Ws5TPwO
         Vi4uP97+R7kn0beA7wSefc8JdEnAyiuPUb3ia4PdaahZY7ght4IP2vmRjdl5Jg56Vfny
         wUaKWkb5jEQCZYwLG91Q5R+T+WP1i3DsIfpWFxyTa6eMC4Lv6s8MltzP6/kpGzBj/AF2
         xxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=75BUDHsCAc/I/IWJxwpyHr24/zOyWSJ/QNW0ySt+dfg=;
        b=AVCuxQROGsOKhERFm76QtQIHvLTLqMLjQ1WQGSfuS7xkCZHVkAjCP1nzDr5S1ybPeT
         xtI3OkYn5gA7mEnV2/nXESUilbwMoyzA9fLSDJ+r4/7OHrApPqvYa52taCMWZra60tOc
         B9VvZL4yndrUbogxwuzEmPpNo5OnO8O41mm3GSo8+7qTWXMM/B/+w/3Ep9IiMjmMaFqJ
         Vwgo1yIUwDlwQuzQtJyjKkqo3N4y2hV8DEQfsS4ZX1bWhCzE5Nr9xOIn7pvfuDv4Y+5Q
         EZxhJKhVxbQKINm2O5bi8pkag5M5dWJgz5UbboeUeZwsZ9YxyOPFJCUklhX4zUY4x3z+
         pQxQ==
X-Gm-Message-State: AOAM5304aIzlBrw093Xea7hYzIO9iyyax0JrtcUAuYoWNJddqPcDhn6m
        Ak/0ZT9Pq0WAERjeDhbOLnsSXA==
X-Google-Smtp-Source: ABdhPJwvmW2dIpmUc08158xMNoS8xGPlQCmkSKopRGJtMHLYtsb/gmoEYjt0Fag/88VD9XPgJuUUHQ==
X-Received: by 2002:a63:7142:: with SMTP id b2mr11127879pgn.433.1635126729456;
        Sun, 24 Oct 2021 18:52:09 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q10sm14855225pgn.31.2021.10.24.18.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 18:52:09 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/11] dt-bindings: Add vendor prefix for Pensando Systems
Date:   Sun, 24 Oct 2021 18:51:47 -0700
Message-Id: <20211025015156.33133-3-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025015156.33133-1-brad@pensando.io>
References: <20211025015156.33133-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add vendor prefix for Pensando Systems: https://pensando.io

Signed-off-by: Brad Larson <brad@pensando.io>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a867f7102c35..4d3d29490a12 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -880,6 +880,8 @@ patternProperties:
     description: Parallax Inc.
   "^pda,.*":
     description: Precision Design Associates, Inc.
+  "^pensando,.*":
+    description: Pensando Systems Inc.
   "^pericom,.*":
     description: Pericom Technology Inc.
   "^pervasive,.*":
-- 
2.17.1

