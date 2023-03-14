Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0389DC74A5B
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Mar 2023 13:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCNNHG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Mar 2023 09:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjCNNGo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2023 09:06:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F364746EB
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 06:03:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t11so19931622lfr.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678799007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqZsJOX1El+luUmSocWq2Ruds493hltfIeGTUI/M7s0=;
        b=TGn7ls7MWG+2Ew4kv5lx+56ihCiq6eQmL1TTbCzZDMNUlwe1LutJD6AEMC0Gz5uzl9
         h8Q1qoVZa9mzdVDsSHaAqTl7zXcQOrRsfXDsW4tsDBhzVhDCWkokZNrK+h/kXAWxq2Zb
         DllThjaa0IT3jJO/eam8UQKona/54t2iIfBajxgTxOPonBtZLBlH+fzxRYVS1hTX+VXu
         QjVukkrzktwVXAc8dIM50DTtA6/AepSUiSu3gsprj58Bm9m9nv1mNRFYd5HLyYkZJr97
         jUlBy0EZJpA5fl2Am5UKTLwqqWYoypgTmwTTgUkTpUr8+EWw1Bcjqt0t4PdLQz7zUAMn
         zeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678799007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqZsJOX1El+luUmSocWq2Ruds493hltfIeGTUI/M7s0=;
        b=yckupPlBQK53H2iLSHnQTKJBOhf19jF3Eswb4yOLwV2PgxihkV3AzsP8FkGF3LKx97
         iYJiqkVsB47lJ0tbajbGG3UMlyMqHL2u+vmI6lFn/LYA0PbpIdxa8PDvDkCbjXSkRCNM
         9+3daLiqldbotnTTP7RPf1cpF+2rUDxuUExDk869TuBlpWo72yPURdQdk6P4eos1sr4F
         +xHyNDn2tPDsUnMtAEDckW6mITEJu02Vjh22C4HG+jtOK9PSlzDmO4XVPb+ZMBLmnmIP
         Ct7VbM9J1w0CcBeRzhMy5QVPmwqa1v5KaPYIyxtNsxEOrTdJcdp+UYdEmieHNsAhMhuh
         6nkA==
X-Gm-Message-State: AO0yUKXjw7Wjo7iLV1mBqfsQF+x7pMVRt2tUP75gBtEPquz5z1T+j/gK
        17j/2pwRn38Fm6q9qjR7hG/OkX1LVNF1UXbh6RU=
X-Google-Smtp-Source: AK7set9qOvhwQgOeP4U1McR7yj1LUoKO8eAR6fKuhFRTzvH3/lO2wA88LCnFpHmHEttF3cZT0GEPtg==
X-Received: by 2002:ac2:5a11:0:b0:4dd:afb4:26b3 with SMTP id q17-20020ac25a11000000b004ddafb426b3mr768141lfn.16.1678798391245;
        Tue, 14 Mar 2023 05:53:11 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b004dda74eccafsm395374lfd.68.2023.03.14.05.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:53:10 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 13:52:57 +0100
Subject: [PATCH 2/6] dt-bindings: dmaengine: qcom: gpi: Add QCM2290 GPI DMA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-topic-2290_compats-v1-2-47e26c3c0365@linaro.org>
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678798384; l=817;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9mAqu5IGrrdUOaP0PlfWAkH94BH0kiBbnQ1iZWRCDUM=;
 b=Sh44OBUk8yAs+WqMAoK2kFFPM3jib6rHQJUJlUycILo2oU82/iPMiKJDnydXvXJL+YhzIpMEFN+N
 sGnknaghBoSI8VGUuzX1St9M1lXVjwwnkKWcthQp66XIHR9eCzzo
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a compatible for the single GPI DMA controller on QCM2290. It uses
the same 0x10000 offset as SM6350.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index fc5de7b6f19e..f61145c91b6d 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,sm6350-gpi-dma
       - items:
           - enum:
+              - qcom,qcm2290-gpi-dma
               - qcom,qdu1000-gpi-dma
               - qcom,sc7280-gpi-dma
               - qcom,sm6115-gpi-dma

-- 
2.39.2

