Return-Path: <SRS0=J/iN=2S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29858C2D0C6
	for <linux-mmc@archiver.kernel.org>; Sat, 28 Dec 2019 09:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E7F207E0
	for <linux-mmc@archiver.kernel.org>; Sat, 28 Dec 2019 09:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0Fg+5oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfL1JbM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 28 Dec 2019 04:31:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39459 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfL1JbL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 28 Dec 2019 04:31:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so28192930wrt.6;
        Sat, 28 Dec 2019 01:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o9uPVfods/TVOloLC6n+hV7w8ZRoPGnL5hHWUQYyLUc=;
        b=o0Fg+5oi5HSyrmfBEZQq8OyJEp0SmiMuZ0A6ig6Fmmz+gqe/bQgTgSi1lLY7NsLW7T
         m4uuidhPQuD611jssxsFee3aPyYuQ92haXXnqhqFFk0cp3aaDtkfwev12eSX5kSCkc1D
         IbpnolD1qExRXPokhFofQYFRO2h8yKPLDkj0nQ3rMe84NhDLSjigtjHPkUS8khMPg/U3
         Moud9sMPQuEtJ2sULFizndLerwDI/znaFA77AvVMSKq2QjPpQS2qJ4nRTpfR8VERWFL0
         0V3gezJUiyS3z9M1TcwjB+KkGgnrAD0qH39jhJJnrKTT09RqWej37cbHZ8mAGMXi1f5R
         6aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o9uPVfods/TVOloLC6n+hV7w8ZRoPGnL5hHWUQYyLUc=;
        b=BBxseyhe6tjCc36Tj7egsU2X0wL/KYl+AeZROKNlPlu/5MU3kwL5zr4h4T1Qd5un8e
         14Ri1I9Ia3kVDjWSTibQltajo7I7kYIfihuWyNXLTpt4SuyOwFwamwsmgrmHpKxakJtK
         nLOJBIXRDeS+KM7xZuyaT4qUU0yJRORIpw+1G7RU2TqKsBuW1XPuF4zqJ1IfDarqUCvL
         XyL1PnjvhGsb45xyT46vO96em5J/gG+fQNjmXLlDUAqT9n50dOuYSSSTUq4OyQH2ebs5
         waW4BRHL3reKydmhP0HT8ByM2q8jtlcJ8GQJG3DZ4U2FzKtCwqUHog2cBJMqbpJwsDuW
         MEWA==
X-Gm-Message-State: APjAAAUSnS28xbyerRp8gsTLpfvepH8y/DQgcVGn7p21G+L4hzQq5ALI
        IXiZL9E2+kNjNAR1wTtabHA=
X-Google-Smtp-Source: APXvYqxwhzxrrXhowjx87gKHx7n+poe0jh8A6oRsexhxdA6dIFus+27xymrwqEZwbLBvIWQomfISXQ==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr54555918wrs.11.1577525469686;
        Sat, 28 Dec 2019 01:31:09 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w20sm13776710wmk.34.2019.12.28.01.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Dec 2019 01:31:09 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     robh+dt@kernel.org
Cc:     mark.rutland@arm.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: mmc: clarify disable-wp text
Date:   Sat, 28 Dec 2019 10:30:59 +0100
Message-Id: <20191228093059.2817-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191228093059.2817-1-jbx6244@gmail.com>
References: <20191219145843.3823-1-jbx6244@gmail.com>
 <20191228093059.2817-1-jbx6244@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

"disable-wp" has been removed from all Rockchip eMMC and SDIO dts nodes,
but people still continue to submit new patches with "disable-wp" added
to other nodes then for the SD card slot,
what it was designed for in the first place.
So clarify the "disable-wp" text by adding that this option should
not be used in combination with eMMC or SDIO.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index d668d0fbe..3c0df4016 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -99,7 +99,7 @@ properties:
       dedicated write-protect detection logic. If a GPIO is always used
       for the write-protect detection logic, it is sufficient to not
       specify the wp-gpios property in the absence of a write-protect
-      line.
+      line. Not used in combination with eMMC or SDIO.
 
   wp-gpios:
     description:
-- 
2.11.0

