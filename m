Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79EFC77B61
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Apr 2023 12:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjDXMOI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Apr 2023 08:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjDXMOH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Apr 2023 08:14:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93F446BF
        for <linux-mmc@vger.kernel.org>; Mon, 24 Apr 2023 05:14:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4edc63c82d1so4439546e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 24 Apr 2023 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices.com; s=8devices; t=1682338443; x=1684930443;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X71BZlzH90rNXlr22ACggW+3L7xadD0OTppCpzd2JQ8=;
        b=LuKlJ1GsF4/Tm3XEdWCx1kDw43SLE8w98Y2BhJfs1wCcIo4QWQrp7Y3KkUQj0YaCA2
         AHRWo0FI+4mJ00cZXqs6cvsAv8XNDKUXTYHrVMMDGVQRfflQuaxWNZRSscKwv33LhL96
         lUcxDwbOrGwBoDrYVrM9Rj1DkDrTWB+kBi/a81GPt3KXNKmvlCLQpQXuYdMEmILmOW6U
         epZNSIexP0zGjHM2iS2S7TIdE2fBgthFGczavpU5IOJW2pPKNKAPpP34Blsm8Z1CoJiT
         dkRbKV5L4Dr04/Y/zsaP4v0+4uieOYV3c18hEaT15Emakr0Ark5ktNhw0bveSy7xaFQ9
         3zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682338443; x=1684930443;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X71BZlzH90rNXlr22ACggW+3L7xadD0OTppCpzd2JQ8=;
        b=UPdXQZgZcRfEBR5OVBl74VYRLXQ08ZsgO1fbXbHbEWjiO7D/abiMjbSvtGMVXbXUzj
         hjipmvPSDQqR3odWmyj5tft3NaBRD2bL9fOB238wMoNomYMCo51U/rqUfqEoKfeAlPeS
         wexdMFdORmuZ/pCA0eZHQA/JDv/qaiaPhdys+ONMr7nZk/UEdx50y0TwEVtbYLjDymK7
         /Gei9fXg//HijQzuih1/r4SqDGSNo8nKRk13me8Vu+tAmyGpvsvY5hpa1b6NZO/D46+h
         RZR3fahZp4ySBknQLGCFFtr1VU2VdNT2VG9C9KvNzBHUfD4IpbNBPK85AD5ZkpFVeqmw
         pyWA==
X-Gm-Message-State: AAQBX9fErj1vL0GEI10iD7MtDWtuAujWoB4OdRja6v4iKd6JiADQna84
        WtYu/8h0hZytbHx5wMD7/luAQw==
X-Google-Smtp-Source: AKy350ZIKHke2Bo4P+2J1KIAdimioXIF5VL+jfMeT4TVxnIYW3hRTri+yaxbnDftQxPFIzCtbx/e7g==
X-Received: by 2002:ac2:5443:0:b0:4ea:f8f0:545f with SMTP id d3-20020ac25443000000b004eaf8f0545fmr3385023lfn.52.1682338443057;
        Mon, 24 Apr 2023 05:14:03 -0700 (PDT)
Received: from mantas-MS-7994.8devices.com ([84.15.37.222])
        by smtp.gmail.com with ESMTPSA id x23-20020a2e7c17000000b002a5f554d263sm1732382ljc.46.2023.04.24.05.14.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2023 05:14:02 -0700 (PDT)
From:   Mantas Pucka <mantas@8devices.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Abhishek Sahu <absahu@codeaurora.org>,
        Anusha Canchi Ramachandra Rao <anusharao@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, Mantas Pucka <mantas@8devices.com>
Subject: [PATCH 2/3] dt-bindings: mmc: sdhci-msm: add IPQ6018 compatible
Date:   Mon, 24 Apr 2023 15:13:31 +0300
Message-Id: <1682338412-15420-2-git-send-email-mantas@8devices.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1682338412-15420-1-git-send-email-mantas@8devices.com>
References: <1682338412-15420-1-git-send-email-mantas@8devices.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

IPQ6018 has a sdhci-msm compatible MMC controller. Add the appropriate
compatible to the documentation.

Signed-off-by: Mantas Pucka <mantas@8devices.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 4f2d9e8127dd..5ad846b724f3 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -36,6 +36,7 @@ properties:
           - enum:
               - qcom,ipq5018-sdhci
               - qcom,ipq5332-sdhci
+              - qcom,ipq6018-sdhci
               - qcom,ipq9574-sdhci
               - qcom,qcm2290-sdhci
               - qcom,qcs404-sdhci
-- 
2.7.4

