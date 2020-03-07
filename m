Return-Path: <SRS0=e4xz=4Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ACDC10F00
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Mar 2020 16:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B2020674
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Mar 2020 16:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY4MKxaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgCGQGG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Mar 2020 11:06:06 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:38305 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgCGQGF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Mar 2020 11:06:05 -0500
Received: by mail-wr1-f41.google.com with SMTP id t11so5878430wrw.5;
        Sat, 07 Mar 2020 08:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iAetEvZraiflUEUc7nvvm8pl55tWCvaIeillv2HHKY4=;
        b=RY4MKxaSmII1woTtclCslMgTGxlofSmYGl3WFzVaIKcUYL1o5RIExjEpCmugp4szQA
         pnSfn6kQwEjA920C4NsfvqYiGQpOeXPVoot14HAWuRIIgHEjyA5f3/vkg+EYGbwD+DI5
         f6ha9Pk8t6NbYSoWJD+Y/9rgfM6ZOdxABsDu6mdEk/wO89+pBZUuL6dCdHCaX3z11lVx
         KNUgvmHmXlbCpOLFpnaN+oK3Ppyjt0Q8YbF9qP1YAOfzMFIlEFr9Ms38QRNxPwdzAkgx
         OE9xcgVoZ+WSzP9c0LDrpQbFUHgoUzCDx6Syr2EdVHdhtMjO+3hcziTkuITm3mF+B9gy
         1LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iAetEvZraiflUEUc7nvvm8pl55tWCvaIeillv2HHKY4=;
        b=I6axj7wXBiRLuBrI9MfVNiNCb9+Z5kRRroFafG4/i7WydmVShVGcdI5FWdkOfdfZPo
         EwvCSGOGGlaWfE+BVywwn/5YVY86VsR6MNsBAVzA87IsUdEl/tzWdKIlINBnr7G4PrpM
         kPRKYk7e5dTXWpwn/7CIumog0l1JTF68TaX5htOSsDwhxLfZbKGxqEoLFhdkTDvh4stC
         +1lo+XGayrcnZrDx4AmkLbTmJOiWFXO5eS6pHW2naJv1+Mn+U31BLd98UwOCV27Lh5kq
         TlKDgB/0Vae4p+a62EOTo+vxp0lT9LvHt9IsYY8+ahs9QPPxiNxfDy4W1b6pr+DB0JYr
         VnFw==
X-Gm-Message-State: ANhLgQ2wbnLmjjRsPXptQe3sz3hojgGH3gPbzbS4vFpiaPLhWDXv/wng
        uff2DK5YQqjZz253WUVzYHQ=
X-Google-Smtp-Source: ADFU+vsORIHVIXY/NGjz0qd0dQ3z+z+LGwdJWHv2GehbGa7/k9ONo/m7C/JJ4CkIdkadrGxj6NNxwQ==
X-Received: by 2002:a5d:550f:: with SMTP id b15mr10220750wrv.19.1583597163324;
        Sat, 07 Mar 2020 08:06:03 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k126sm17555105wme.4.2020.03.07.08.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2020 08:06:02 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     heiko@sntech.de, robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: mmc: synopsys-dw-mshc: fix clock-freq-min-max in example
Date:   Sat,  7 Mar 2020 17:05:56 +0100
Message-Id: <20200307160556.16226-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A test with the command below does not detect all errors
in combination with 'additionalProperties: false' and
allOf:
  - $ref: "synopsys-dw-mshc-common.yaml#"
allOf:
  - $ref: "mmc-controller.yaml#"

'additionalProperties' applies to all properties that are not
accounted-for by 'properties' or 'patternProperties' in
the immediate schema.

First when we combine synopsys-dw-mshc.yaml,
synopsys-dw-mshc-common.yaml and mmc-controller.yaml it gives
this error:

Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.example.dt.yaml:
mmc@12200000: 'clock-freq-min-max' does not match any of the regexes:
'^.*@[0-9]+$', '^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|
uhs-(sdr(12|25|50|104)|ddr50))$', 'pinctrl-[0-9]+'

'clock-freq-min-max' is deprecated, so replace it by 'max-frequency'.

make ARCH=arm dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
index 05f9f36dc..dd2c1b147 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
@@ -62,7 +62,7 @@ examples:
       cap-mmc-highspeed;
       cap-sd-highspeed;
       card-detect-delay = <200>;
-      clock-freq-min-max = <400000 200000000>;
+      max-frequency = <200000000>;
       clock-frequency = <400000000>;
       data-addr = <0x200>;
       fifo-depth = <0x80>;
-- 
2.11.0

