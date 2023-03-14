Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5387BC6FD1C
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Mar 2023 13:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjCNNKt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Mar 2023 09:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjCNNKY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2023 09:10:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773B43B0EC
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 06:07:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x13so14460588edd.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 06:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678799225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oc/yTtxpfi/cx0O/ciOGYJj7wULj4xSmUjomTMHGaJ0=;
        b=u6HYfX69IbkWqXpI8TVD5GgvO7RxEF4ChsNuwFkTXBvjIFB31nMniWTHEQ1y7tbynB
         WpjxgZFqW4acFlvF1b1PM3lLbrFXFnSDYSd/pypnRUTk9Hv01jpT513B/xxaRIWW9XLh
         t8l9ipnhqwuOeJYB8921+pPWCCqtjcMEn7gozr+AxtyBDE/pXtcFMh9j4GPI32oHv0+i
         jhuK7awd8DgKs0hRKHZk6FgauFBXEjJli+LkAe3gxl9Z64QYUdodmqElI9+q1PaN49fg
         VQQLFb4QzZwZ6AYAJ3oiMnROc5+vIwlPQlF5I/CzJQdYk+7lNdqSbJBJuy22ppqvTrky
         VjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678799225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oc/yTtxpfi/cx0O/ciOGYJj7wULj4xSmUjomTMHGaJ0=;
        b=bsGf28ddbKDLqX3RDpF4ZeOHhu523PWzsEt2Nev0louReoB5K+fcdpwqIAkevsmPII
         xIJKsO0e1IGhfh4V7MGtcuLUbqK0VfoiTJG/3JE5DWQvL8K4NI7BCo8nUQ6KRQuVF38g
         mRRZJubK/gpRc8DIbyfEGxdWzL+5TSrRCuvZyZMzG+QhiVdORLm63fFvktQkHUad55n/
         Nh3rJ2/qQRzfI//yGHLRDge+kJaQNlF24uFcleG2YYvWMhfIxnSK/1X/2lOejgyeLcLc
         ZCSDK9Ca0Xzy43KHl0YqkPFy7ln2RookaX9wFXFkmVCdQGI1DeKcI4VU7z3abKbFly/3
         ynEQ==
X-Gm-Message-State: AO0yUKVTE865c+q/QkzYiHuNzh6PizGDoXdQa3goU0mK+SXIW+Pr/YpB
        flm5nwX1uURNiKT3yu9tvw5SGZzz/DF6K+/U3g4=
X-Google-Smtp-Source: AK7set/cA5JzNq58dSwBAkLHZCu0RayEc27uAlLkeTiHXGkrsrtUKK6Xmh8rmkhOulNKQc/fzE5z3w==
X-Received: by 2002:ac2:4c29:0:b0:4e8:49ff:8df8 with SMTP id u9-20020ac24c29000000b004e849ff8df8mr770470lfq.61.1678798393458;
        Tue, 14 Mar 2023 05:53:13 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b004dda74eccafsm395374lfd.68.2023.03.14.05.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:53:13 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 13:52:58 +0100
Subject: [PATCH 3/6] dt-bindings: nvmem: Add compatible for QCM2290
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-topic-2290_compats-v1-3-47e26c3c0365@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678798384; l=777;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hWgvEppu/A1SXLKMMX+IVEfzPX58BD27JWEng55RY7w=;
 b=Ef0WrVrVXlVDBJBByuHYfJlJ7lKiC4VKDD9vte3q6X/PFMC2o+9sSEcy8IVuH2VILi/qU5aK+BY5
 Ts3tc5KED8ipFSTE15LUOfkLBF7qH00cFE3ULYIfdjVnID+Jp6zW
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Docuemnt the QFPROM on QCM2290.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 2173fe82317d..1bd213f9eb38 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -25,6 +25,7 @@ properties:
           - qcom,msm8976-qfprom
           - qcom,msm8996-qfprom
           - qcom,msm8998-qfprom
+          - qcom,qcm2290-qfprom
           - qcom,qcs404-qfprom
           - qcom,sc7180-qfprom
           - qcom,sc7280-qfprom

-- 
2.39.2

