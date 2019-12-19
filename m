Return-Path: <SRS0=Rhqe=2J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7053CC2D0C1
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 14:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4657A206D8
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 14:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwdTe8q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLSO6y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:58:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43406 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfLSO6y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2019 09:58:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so6262862wre.10;
        Thu, 19 Dec 2019 06:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2fgPMrd9C+AKftleHVnn57a7bDx3FxZOsu1zeqIFgxc=;
        b=NwdTe8q2pdyU/zYMroacZdwZE6vgTCjOSl2QT0WdYpudW0Lz6rSolLyAs+63audr8x
         t387tewbV0LhJdqe0ekA1EGpv+q4nFCReTGv81arfQH/qRxAj/nv902BHZAfxQSFP5Ag
         gdZGwrq7X7Tq2YH7d4y6k1HliLLz3kXcnwL74ec7RGddd1Q8/IajfFX162tg/lRj0pzA
         zdvOirkCCuYf0hrxd19ZhXaBOOd/Lz2WrSkOiO+D9twBYD0fMJR1MwL5JYAvwa6LRZnl
         nRqm5sNlgIFP2tCHDh42ECss17vc6LmSX/QvQGpkveYX3cwQEf1Jl8lRuMHh7s++tXRL
         zd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2fgPMrd9C+AKftleHVnn57a7bDx3FxZOsu1zeqIFgxc=;
        b=H2U2TfP0Hok4grpdzBEYw4DzhKDL21BdPh7/bRDuwtQtzWHv+AlcBUtST+KanT/BBz
         yzliVaXO7kX944QEpoPSQcFzJd+x35dNkW2YIYH2v6OdVmPS12Umol2uu210W0s/SyV3
         rY93bKMTNTzP7G/DK3sR2ylirI5Rmsi1RerVVLDb8KSwSgLIIE+j5dORfmtppyNmMlUH
         8XcwNf6UE47ZdHQChr5VWpPUmlhUOdJO0TZcDABTtS7INF2msc2lJUX4y80jt3eFW/S8
         JuxuLnOpI6WFQ0HBp7icctWkaCdqxN8tCz2tZDDeoWxdQ01ePughot6yQ74xV9bngA2E
         et6A==
X-Gm-Message-State: APjAAAW3sWQtVEuaN3cI8XJg1Bgwk4fbxTsA7wwl89EcNwZqPdzgCJ7A
        xVM1XHE4Hk1rccAGm3wmoLc=
X-Google-Smtp-Source: APXvYqwQG+ZpFPzQJF7IasX91H6w8GEyPcnxbOAAQ2nHd6IPilq17lB4KnK481iqBLiq5LMwx/cg1A==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr9652877wro.234.1576767531302;
        Thu, 19 Dec 2019 06:58:51 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id t1sm6457866wma.43.2019.12.19.06.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 06:58:50 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: clarify disable-wp text
Date:   Thu, 19 Dec 2019 15:58:43 +0100
Message-Id: <20191219145843.3823-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Clarify disable-wp text.
Clean up and add that "disable-wp" is not used in combination
with eMMC or SDIO.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index b130450c3..3c0df4016 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -96,11 +96,10 @@ properties:
     description:
       When set, no physical write-protect line is present. This
       property should only be specified when the controller has a
-      dedicated write-protect detection logic. If a GPIO is always
-      used for the write-protect detection. If a GPIO is always used
+      dedicated write-protect detection logic. If a GPIO is always used
       for the write-protect detection logic, it is sufficient to not
       specify the wp-gpios property in the absence of a write-protect
-      line.
+      line. Not used in combination with eMMC or SDIO.
 
   wp-gpios:
     description:
-- 
2.11.0

