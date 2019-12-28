Return-Path: <SRS0=J/iN=2S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE0BC2D0C6
	for <linux-mmc@archiver.kernel.org>; Sat, 28 Dec 2019 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE5821582
	for <linux-mmc@archiver.kernel.org>; Sat, 28 Dec 2019 09:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF2l6vUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfL1JbK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 28 Dec 2019 04:31:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35235 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfL1JbK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 28 Dec 2019 04:31:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so28189184wro.2;
        Sat, 28 Dec 2019 01:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C1Yhclh1rO03TNl8BGVnCeZSpEaHjzvQF/HLnspJXUo=;
        b=UF2l6vUzWgQRLwbEC3+YvM5hGubotXdidH8OdLBgnmTH/RD80HhdZlD88JdaS8GAal
         VtnLyQhrUP6hP/vSyuUkKE/khyWu3nwtzsIbGDp7hzJEFbF1NK/iqDKR0nRSmwBv/AMO
         /6EM7FQBM+l9hk9iFl84STiLVEO7SMKoVzv8o5mrSdKOjfI+yacF3q5eEgZNZ6KbUf7x
         BjqyI/gtQSN0bCjjgnrOsTRtl+HIjZSCxG1ywzPQpJ/DIJ3y55AvvclakTMF0FynwnVV
         fg8B4RVWtVKXnORJHh5oEosm6UZBcRQC1Q5cDdHmxoQZIMAm0q34TUMRj3BnEtzH1MZ1
         XzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C1Yhclh1rO03TNl8BGVnCeZSpEaHjzvQF/HLnspJXUo=;
        b=h1E+Ws1DRQ2hzxla6RKx3tNGGtIZHXnGuBFcap3/7gfMvTRTsIagNEGPMFU1Q+m85X
         elynORpRi1/elNHDOF2Zab77Nw8yzNNbG+wbtl41uGaYadgWTY0IHCZjHa61Zxlnvxy8
         nNPQq3RANSwvS0SGwpuYvFjulA/BlWUlsN+WYGTMO1ub+P3ZBTHAgBHH42mAw8M7ezEz
         weZ9tfYi/AsGW5EzqSs15ne31dXtE/mAUTuQuYVFBrCyEe+2NzX1zB6eAIP6FqjKlNWd
         N6hxQ6rYoygafY7SUC1WZrbBp9ehKKAqBepWCNSFBjTmGWMDgA8Zkhh9XSUH69EuFK0n
         HQMQ==
X-Gm-Message-State: APjAAAXSU/iYCN8semJYWSoGXZdgQhL93Qefz9+tX6e/hML3o2jW636T
        UWgICyU3BbGWtZUvTG/fX7Y=
X-Google-Smtp-Source: APXvYqwlnqVc7lbLCW9DYPOLB9f1dCvRIPPtiRq05ZZxZYuTyAl2jQdy3IZk/NVFYr5tVYuZRLMSgg==
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr53663014wrt.70.1577525468939;
        Sat, 28 Dec 2019 01:31:08 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w20sm13776710wmk.34.2019.12.28.01.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Dec 2019 01:31:08 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     robh+dt@kernel.org
Cc:     mark.rutland@arm.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: mmc: remove identical phrase in disable-wp text
Date:   Sat, 28 Dec 2019 10:30:58 +0100
Message-Id: <20191228093059.2817-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191219145843.3823-1-jbx6244@gmail.com>
References: <20191219145843.3823-1-jbx6244@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There are two identical phrases in the disable-wp text,
so remove one of them.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index b130450c3..d668d0fbe 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -96,8 +96,7 @@ properties:
     description:
       When set, no physical write-protect line is present. This
       property should only be specified when the controller has a
-      dedicated write-protect detection logic. If a GPIO is always
-      used for the write-protect detection. If a GPIO is always used
+      dedicated write-protect detection logic. If a GPIO is always used
       for the write-protect detection logic, it is sufficient to not
       specify the wp-gpios property in the absence of a write-protect
       line.
-- 
2.11.0

