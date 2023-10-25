Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FB3C0032E
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Oct 2023 08:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjJYI2h (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Oct 2023 04:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjJYI2g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Oct 2023 04:28:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922AAB0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Oct 2023 01:28:34 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507bd644a96so7950511e87.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Oct 2023 01:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698222513; x=1698827313; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x0UwU9wh1C79P1ek4ptmmCsl2nfl4HL7/EfLKynslao=;
        b=JNhdSqTNTcEFEoDRRBXYFVd6N4xXpVA9RrF0LU+GAAvPShyKqq6nyaHwwGD8dO3Vqt
         EopuguSxpQDWtRJ1ojmPpoXnr3F9CB/fwwTTCk7B+WJMX3XpNxtcJlrw+/lsN0rpAdLM
         nxpUiKz/DSfUxsqXpSAuw1NMGTrtfM18BzbvmOp7D3eNZlRmKqqdPG140Y00WE6k6IFp
         dOIUPCLD0Wd2Pct37Cms80p/qIHI85ktyTWXMTd/+sS/3T82MX5oPs/p5tYGvMebuQo1
         vnjNjzhLHct0ef0ud79boaBshZzLvNB6LYvc0WY7RIuoKwyg0aeXNe/0wnMxY/efojyh
         0dTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698222513; x=1698827313;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0UwU9wh1C79P1ek4ptmmCsl2nfl4HL7/EfLKynslao=;
        b=pXd/2BbfTTEoeyxDt2uIYi6/QUbE8UT4RO2QfF4se7cVtuKSwFMU9shMHHgO5Imb5i
         jxahBlglpXKidF/PWSIpYavUYb221PAYw118QtOYLhu0H6ZMOCECxhx9GU26lD7howZ5
         g/GaADWuYyUbhp9LwBrF7CqNEA40IDuV8jg1QBjkr8Exb0K+JmO/00RGxhEpJqVIXZCv
         8j5IoO/JXQ308XJuB5yftlyoFvcbdzUZTQ6SYwl8EVyoGZ0wUKOCRjvZE5vM+JSUeCb6
         +ctQBfRg5cjW/PrYXGvVahF+mFTFI/HW5taWRQPSZi33Tsc4wFt9wjvQld96NuCaGVXz
         u4Jg==
X-Gm-Message-State: AOJu0YwljttamGrHbnJvVgGOHs0Ceuk0XNWlqhYDtfIDL1L6Z2HXi6h4
        gQxhqZCbKybqsjkm65qX5yQ4bA==
X-Google-Smtp-Source: AGHT+IEk50K7fXMN2i5VZRyP0bNSSce/I9RNkOYZVuKWRapansHPv7prIsy9+bmM+zCige1KOleheA==
X-Received: by 2002:ac2:490c:0:b0:501:bd6f:7c1e with SMTP id n12-20020ac2490c000000b00501bd6f7c1emr9786306lfi.33.1698222512686;
        Wed, 25 Oct 2023 01:28:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id x22-20020a05600c189600b004083a105f27sm18433183wmp.26.2023.10.25.01.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 01:28:32 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 10:28:30 +0200
Subject: [PATCH v2] dt-bindings: mmc: sdhci-msm: document the SM8650 SDHCI
 Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-bindings-sdhci-v2-1-0406fca99033@linaro.org>
X-B4-Tracking: v=1; b=H4sIAK3ROGUC/43NTQ6CMBCG4auQrh3TH6DoynsYFrUMMIm2pINEQ
 7i7lXgAl++3+J5VMCZCFudiFQkXYoohhz4Uwo8uDAjU5RZaaqOkqmGOE3ngR1NXEp4TzwndA24
 UOgoDA3ejJzCutL20jbQORb6aEvb02plrm3sknmN67+qivusP0NV/wKJAAdZl6fuTsUary52CS
 /EY0yDabds+jGsiudkAAAA=
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=OL68rEELlTwP2Xhoqpzlb0uingRTSNFDobLzF4y6gWs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlONGvqAaualQiupRqwlEsS+hNp5tmfJoGs7WMlq+p
 oqfSu0WJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjRrwAKCRB33NvayMhJ0XVmD/
 4wPZsxhc1QUlexNaOL93sO44DSFGKl1uMRVukzdlit5xFWeoDbc09SSoHQ0G7p0Wwm5TCkhmP08iTD
 bm+zKhEHREWnku717ChHSU3kGmGcqE22r6hzOvDTy1L1779pUsUAvybVLLTmswqAmiaKE5jbPQaT0s
 Ry2N72hP9L/MpO6e39ryijmL98ersm9+pAv+6eDl4DvbkQTPUpRumRyHV96By9xIrxie4wJ2o3FM1/
 z+7QIeVbD8S+Uo+Av3vp0yPscGFbyMzOnPvuWJGwRl5wlGKyUxSaJo4si54zD/I91ez0MVswFpnERf
 sPaPOFuluf1qlJx1NTp79NjTY4vyLkwYIn+YR1490rQ+O6CxVcgTrHddavPDKgeokvb8FuZbNOfCj2
 hxJ05dTWCgGdAxGvKBMd9glb25DZuxDYh42dQUsJI0hMAi06pjmaoSiNeSIfFcDvdJ8nsnTTQWjB1f
 KhLVATSR6cTBmp2Sj3Qj5lL3ugCOj79V9a+YJ3XdCrWLfyxnMH/ktiAHWaO22eJWmKmZh9z72HQczG
 ndDfPyv43pF7Q+tVKkAJUnPR20CeSUvlBuUFsW6CtSB6g7En0z4YK4yPXpLqeg3sIR9uNlLrqhLmAQ
 1ynNxeyart7BFkkAIjupQ7wNki+vWEMZ/akdgqGRDdmEIPLTlqHG2xpayIVg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document the SDHCI Controller on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
Changes in v2:
- Fixed typo in subject
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-bindings-sdhci-v1-1-e644cf937321@linaro.org
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 69a213965089..86fae733d9a0 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -58,6 +58,7 @@ properties:
               - qcom,sm8350-sdhci
               - qcom,sm8450-sdhci
               - qcom,sm8550-sdhci
+              - qcom,sm8650-sdhci
           - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
 
   reg:

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-sdhci-3a47f07807ae

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

