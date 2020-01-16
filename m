Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BDAC33CB8
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 15:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB3121582
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 15:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzs8yVan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAPPWm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:22:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34894 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgAPPWm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 10:22:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so19540802wro.2;
        Thu, 16 Jan 2020 07:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vZZ9VyOzV34iQ0VxY5F4QTnc79//k1XDbodGn0X9/BI=;
        b=lzs8yVanbsLsplmx8X5y+FC2PfGxjVxhWovxdAuhr5n1AMnQj6FcgATftk365XldMm
         Pg6rwZzsLrHwxedRZIpfDWG/kaEmH8p0mtVGeojY0qDZ+y6XV7YD7HJH4dR1T3CBYmMb
         2tYs6RM1uClP+oESBKqqsYBi0AuGK+VvDstUPSvOSGhh20BlPZLlOLZIOQujpc4oOABC
         1n18InsiE7iRJBH9QmX9lArDfeWyw+pPptGBBQqd0sROgz27kBLzU3XclzaECs4Zh0US
         fCgktVQY7pHYg4Gl+nQB1JrW4X5QP68n0p1NKuKLr63K1TdzapLQMdjWztcHHYHWhzVO
         WYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vZZ9VyOzV34iQ0VxY5F4QTnc79//k1XDbodGn0X9/BI=;
        b=d9kWdoelTVc4HCL4+H8pSg3wHmUhAOEEnqSMHIke6BlfbN3TjEovtgV+Y1mhqiTlMW
         QthLJbnP3/RgyFCsJD8fUmYP/kg36S9hUS91vwH9FR1BuuiKR2zLn2qy8D/X6EqSSvDf
         0Ch7kTtufCCcxPpiFIpTepOUePDkYkxuKU5OfqMqk6uPgaH5tlabuUtzan4CM1zDo5vI
         w2rXr/5a2n93+H6OrqNVzDs1mib0jmUKByfsBjmzjJh1Vb2ncHm3W3qUWYIW3O01Euu2
         V0CsmdSWOQ5tZ0IOhtabRiWH+BiecqS6qDef6aFLGTLOLvmDPpy545EFU7kDvZU1OPW6
         PAyg==
X-Gm-Message-State: APjAAAVa9FrpEVYC3b2gc+kMfnxB+jJ4AEAx9xSv1YafT4DGoO+fH/L5
        e8HRZcBCDsrBwtjjMQw1XG0=
X-Google-Smtp-Source: APXvYqyuFSu4gLbVEvoyKNl3FBhw734PapU1CBJhHea/vYM4blIBscvJQWf3mxNqEwlCKpMp0wwGYg==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr3735432wrw.255.1579188160843;
        Thu, 16 Jan 2020 07:22:40 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w8sm18193wmd.2.2020.01.16.07.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2020 07:22:40 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 3/3] dt-bindings: mmc: rockchip-dw-mshc: add description for rk3308
Date:   Thu, 16 Jan 2020 16:22:30 +0100
Message-Id: <20200116152230.29831-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200116152230.29831-1-jbx6244@gmail.com>
References: <20200116152230.29831-1-jbx6244@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The description below is already in use for rk3308.dtsi,
but was somehow never added to a document, so add
"rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc"
for mmc nodes on a rk3308 platform to rockchip-dw-mshc.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index 2f70f5ef0..89c3edd6a 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -35,6 +35,8 @@ properties:
             - rockchip,rk3036-dw-mshc
             # for Rockchip RK322x
             - rockchip,rk3228-dw-mshc
+            # for Rockchip RK3308
+            - rockchip,rk3308-dw-mshc
             # for Rockchip RK3328
             - rockchip,rk3328-dw-mshc
             # for Rockchip RK3368
-- 
2.11.0

