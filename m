Return-Path: <SRS0=kdqm=AL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AEDC433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Jun 2020 22:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B737C20771
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Jun 2020 22:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNVFMT2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgF3WhD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgF3WhC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Jun 2020 18:37:02 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B53C061755;
        Tue, 30 Jun 2020 15:37:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 35so9089802ple.0;
        Tue, 30 Jun 2020 15:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=emf+0oLTtvyOulfK2JhXOE8unU2JcKcniORdAnCXj6o=;
        b=sNVFMT2ytjauJk2DF0tK/8/LkvFGvQR2hXkOO36ROKYdgagkauGYiLtLcsqSikeNRn
         VldMK6fH0C9+jisAahsFqdy1UUvOOvaj/sTM7AZFpSzg7H6a4QwINb9gZeR7aqsXL11f
         N5BGG31019YW0dNSxK7LehPGIXs3EVFhNltZ+Kbye4ICwaNQ9cKrjuKSNA0qLXyIVTi9
         gqATypqy+wlDNVuOSJQrZYSrKyv+AWlfkivU/8Yw+SomeA/7IsyvmLGDvcOwMx7dcQ8H
         s+4Q45mlMD3yLAGYRdVjwmADL6MOEBE8HtJwNy5EO97GCdnpTMluuk4+X/uojG5SPNMI
         ii1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=emf+0oLTtvyOulfK2JhXOE8unU2JcKcniORdAnCXj6o=;
        b=f28hVufqPjiPR6n8xbEQ53afP9/LYPT8XHlimOpMCncyFI/re+aggvKRWzi3LPZ5px
         L7Maff73mRAffEkB++db7TCQI0jzWCvBxnK+lSzAJyMzv3qhB/IGBOepV2/kwQa7Iidb
         XXHC7k8163EI6QVyGq4HhtJw4pbY96kCFAv7XjjdYAHtZekj50XtUkgALycRxmn9huvN
         O+bl036K+ebe7zWOxxBLAcAWPC9ZkUYKTH8baMObCtriZBXFrrPHjtbjDRmXmd8cYPrG
         Q2h7K0FzC0ezl7OQq/K0HkRe4d3Vv7YmhHfkYpY52J2dOBoXaADkpgeinvuTdBjJkE8F
         uI6w==
X-Gm-Message-State: AOAM5318aF5FBPHzGqZth1TwcluOjneVhWSex4iSveIwxTHahyo7lOku
        QTybSCfo8T6oYSM1E17AtHA=
X-Google-Smtp-Source: ABdhPJxiJ7bFM2eJcMi0Xr3qA6Rus02W2+d30uR8423ZOrfXPyDeBeS0FJPXy6sJ+slc6RyZtIRVSg==
X-Received: by 2002:a17:902:b716:: with SMTP id d22mr19462455pls.33.1593556621037;
        Tue, 30 Jun 2020 15:37:01 -0700 (PDT)
Received: from localhost.localdomain ([1.240.193.107])
        by smtp.googlemail.com with ESMTPSA id c23sm3137638pfo.32.2020.06.30.15.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 15:37:00 -0700 (PDT)
From:   Kangmin Park <l4stpr0gr4m@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: sdhci-sirf
Date:   Wed,  1 Jul 2020 07:36:55 +0900
Message-Id: <20200630223655.2627-1-l4stpr0gr4m@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix unit address to match the first address specified in the reg
property of the node.

Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-sirf.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt b/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
index dd6ed464bcb8..61185bbfdf9e 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
@@ -11,7 +11,7 @@ Optional properties:
 
 Example:
 
-	sd0: sdhci@56000000 {
+	sd0: sdhci@cd000000 {
 		compatible = "sirf,prima2-sdhc";
 		reg = <0xcd000000 0x100000>;
 		cd-gpios = <&gpio 6 0>;
-- 
2.26.2

