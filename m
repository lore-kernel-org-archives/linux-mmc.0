Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89698C4345E
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Mar 2021 02:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D0C6194B
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Mar 2021 02:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhC2CAP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 28 Mar 2021 22:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhC2B75 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Mar 2021 21:59:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9627CC0613B6
        for <linux-mmc@vger.kernel.org>; Sun, 28 Mar 2021 18:59:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id m11so8850871pfc.11
        for <linux-mmc@vger.kernel.org>; Sun, 28 Mar 2021 18:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4v8aBx78UIl9kJyUAEU+fhreTJLmflo7CPIF+/o/lfo=;
        b=Tr+1CWmLMakwQlxhNoswu2buyvgjUudoEUlG2okr8+JGP4rXEKwXWRnZ1qz+nYllZ4
         46TFxNerPY3WEoA2o5miu5flNC/sN1W6f2ClG0GxbTTZttO5iHfrDClCB6q2BhOHhTGn
         oiTUDjuPdD6dKrSfMhQtcBmtIxAHNo0h04NbkSHqHVEdOosu/YTpDVWMqdCA3f1EBLdo
         uLnH4jTTeY4MMCL0YZY0IEnsUZIs1GzlZnclqmAQoRoJC49o5+0g+pjD2uwPvuRl9N0U
         1It7VbeDJtk1EJqERhOxRtKHK26xJI1yj5JKACD3lM/4PHrcPEhFD8bH1QmwgvGHx+ND
         hYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4v8aBx78UIl9kJyUAEU+fhreTJLmflo7CPIF+/o/lfo=;
        b=kr3MPllCvYgTh8Czo1yKhb7ZhpyjW6oVLsMhaF/MvUfR1pxj/GePioeGOaeRWC4qTT
         zRciWsZiyo+0Z6uBi4k7+a3Xqy1UoXFqzuKcWJRF5Q6++Be0LcJ9akpG7V7qpqzVZYk1
         S7PpKrl3eWs1I8JRHj92Bf1HhDfGQ1NYymGAmeBPEuLxRn4w0Fw2LPDfWGJbEf/mszqw
         X1ZvZfZbQXHnbHTJLg2dfzbLXuDgOEKUHGn/C3pUM2qq3eNJdhAWRDQ/6Bib0iCWzaEU
         WneQdcP2CcCtOk8pf5J4tewo749W1WIvlhm4up0oX3KKO9QnfWgtFJ+XPypHje+vIL8c
         BsXg==
X-Gm-Message-State: AOAM533rTEuC+kyc0RQXPCmqN5uv10ePnbNaS2D23mLfa5HtHXWYsae8
        a+OOP/gMTPr2mDZbC9Vk6/dgsw==
X-Google-Smtp-Source: ABdhPJw48cz/datRyGFev9rtD2ksuMeSNum0EvrgTUC7185VOSAZOYAli0CmY4fU59gozDw6W7rGGw==
X-Received: by 2002:a62:8c05:0:b029:1d8:7f36:bcd8 with SMTP id m5-20020a628c050000b02901d87f36bcd8mr23211066pfd.43.1616983197090;
        Sun, 28 Mar 2021 18:59:57 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id w37sm14728027pgl.13.2021.03.28.18.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 18:59:56 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] dt-bindings: Add pensando vendor prefix
Date:   Sun, 28 Mar 2021 18:59:33 -0700
Message-Id: <20210329015938.20316-9-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329015938.20316-1-brad@pensando.io>
References: <20210329015938.20316-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add vendor prefix for Pensando Systems, Inc.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f6064d84a424..9a21d780c5e1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -850,6 +850,8 @@ patternProperties:
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

