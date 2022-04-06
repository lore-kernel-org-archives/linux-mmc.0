Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C01EC433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Apr 2022 23:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbiDFXjS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Apr 2022 19:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbiDFXjI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2022 19:39:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04E11FD2E0
        for <linux-mmc@vger.kernel.org>; Wed,  6 Apr 2022 16:37:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w7so3881151pfu.11
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2022 16:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QK8+4fUiKFidFtwDTnzjiT6o2I/M1O28JcVYOpK+fEI=;
        b=yNDw2XDQkg9R8u4+kmc5T2VvUaV+duY5HRN5myxhw0zKpy6MtPhspE1WQr1d8QahFs
         Q7sJGQXnlee6BS84nwIbw1gDVj3fWnja6v7EiC4LlLcfSn/FsF479Ce01jHdnO3YuWbu
         GQ1By+IzCavFFk/c5FKPHY09esq854gQPWQb/HBPkOdro9k28aa+dID/jPvA93rL63KC
         3Jt5+dYwFJcPJ/L9MsU46Uljoi2bAyLEr0wT7Ac9cWx4F3qz7eS1GXr7vCovmDqa8KKw
         OXjbZAmA2V2h9HlwqtOQtwdT5vgwJxdJOqPdB9ll1gIhUU7VT+ymg+ez4NCRiqM92vSr
         d1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QK8+4fUiKFidFtwDTnzjiT6o2I/M1O28JcVYOpK+fEI=;
        b=7xsdewaI+Ib0LMCShbHljFj2ClY5WFm/MnC0JOrqRioun1aVj17eK+HB0t0LgR8JZ9
         YW8jWpklNnGwDPJWrsEbYo/0e1yI7yXy+UeHbFiwngyXcBl3YtLMg52ZawMRspT8+Iq9
         FyPGcVH+8VrbAyRS7xvQXKJQVBiJXldhj2Jf1lc0Nitbaq2Yzw/xSRbe6IgY2O3J4OX1
         QSkkpV2E1fVEgnZb1oaihYnkDKnuClHajFOzzCW5CKHygeZahGYnfI9LBfzdjUftniGJ
         4Fr6sItur6XJGPwN9ZS9icwoqloMFbNY1e5EvxcOD7/2kg96+9cPbVfRfOIhKJgvwuKG
         6+WQ==
X-Gm-Message-State: AOAM5312dU7A2UCvo0pQ0Co/hT2PbfULXxhwAg21ewbWcEYLJeOAnT2r
        b2V0S05jRMnhuu7AirjKe2Fmsw==
X-Google-Smtp-Source: ABdhPJzaezBCtvwGYSV1mX/+b9wnRQsY8UmbEyVes0OC4123FLUN6x1hyG91/ObI3Za45Bldidy0eA==
X-Received: by 2002:a05:6a00:1988:b0:4fa:c15d:190d with SMTP id d8-20020a056a00198800b004fac15d190dmr11020521pfl.44.1649288226244;
        Wed, 06 Apr 2022 16:37:06 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm6903667pjl.39.2022.04.06.16.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:37:05 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] dt-bindings: Add vendor prefix for Pensando Systems
Date:   Wed,  6 Apr 2022 16:36:39 -0700
Message-Id: <20220406233648.21644-3-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406233648.21644-1-brad@pensando.io>
References: <20220406233648.21644-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add vendor prefix for Pensando Systems: https://pensando.io

Signed-off-by: Brad Larson <brad@pensando.io>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 01430973ecec..0ce8f94eab08 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -936,6 +936,8 @@ patternProperties:
     description: Parade Technologies Inc.
   "^parallax,.*":
     description: Parallax Inc.
+  "^pensando,.*":
+    description: Pensando Systems Inc.
   "^pda,.*":
     description: Precision Design Associates, Inc.
   "^pericom,.*":
-- 
2.17.1

