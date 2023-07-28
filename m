Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96CFC04FDF
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Jul 2023 13:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbjG1NW6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Jul 2023 09:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236594AbjG1NW5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Jul 2023 09:22:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610083AA8
        for <linux-mmc@vger.kernel.org>; Fri, 28 Jul 2023 06:22:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe110de3b6so3169615e9.1
        for <linux-mmc@vger.kernel.org>; Fri, 28 Jul 2023 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690550573; x=1691155373;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t86fEk1B48Jhf5PGXA8uJZQumipRoCPOJsUE1d8YRCM=;
        b=I5pAB+18R2+dx1wq/ZGauDPjeDbH0NfpPC5bHPSwYGWvSKcCsgREL+dEaLCCscjJfX
         faKocywBv3vgb/20PmviQnUnE8DF4z3yPJmwjGLszgYFmNSSAxqx4DYhC112fmIYJZSJ
         50bigVm9HhJcF9S1kJJaI4DQqkjLhamBTF0ndwqDaTie7cYu+eLJ4lQCm5t7wVN52jeH
         fTMla8zNu0rKI1FL4cD88rY/VUEspZp9wIL0U4L6CwzU3cw7+MNy4OA/MgNFK/5AKiD/
         9FGB0CxuLDbUYogCp5O9jmTd2+rW1yzlE06cvKtjGe76zsFSi9Cx2+I5wFaQEHsRMihe
         a3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690550573; x=1691155373;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t86fEk1B48Jhf5PGXA8uJZQumipRoCPOJsUE1d8YRCM=;
        b=EY+VThb/wMAKtoFgk43wD1Tr1V6g98uSS0adaE4HLy8kQ4iro2f4t0PmOfhg0gRaYy
         gouIL2nhUBoQwE2SwrzDiwPLCG+omBBw8OtpUSnh8HWTQDahipGIdnkUeZnInZe7vimW
         pY5QIKdv9oYUecpZ+dspmTIPAGoA5e9khaPwGzFQmQM5Cpf1SCPgsQ+f5+7e3xRnDOxJ
         w9vIQGGTyExoNSdo5BSzTeg5iFWLBrRDjPD5Bvbz8/F20Yy3Ht800Jq/EbB5UMLnzKFr
         VubboKqn9T4F2QG5HubxBT+wJ00EE1Uvy3XsT+SR0SDACTg/p5y7kMCvAO4yt0rxribD
         Nosw==
X-Gm-Message-State: ABy/qLakbasZbg4cCyst9+on0sS/FHFjd0TQYEhUtZh5dBZfq485UR7D
        NjoK8GlATQF6mhyjjt9UGo1Efw==
X-Google-Smtp-Source: APBJJlHImMAVgco6lnO2EZ30XvL84WDSKwCfHrqNfAxxnVJY79gWRp11k/XtM/0DucWy4yuI+ySlKg==
X-Received: by 2002:a05:600c:82c7:b0:3fa:821e:1fb5 with SMTP id eo7-20020a05600c82c700b003fa821e1fb5mr5010086wmb.5.1690550572892;
        Fri, 28 Jul 2023 06:22:52 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c240900b003fa98908014sm7009317wmp.8.2023.07.28.06.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 06:22:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
Subject: Re: (subset) [PATCH 0/6] QCM2290 compatibles
Message-Id: <169055057157.6557.3890207774670962574.b4-ty@linaro.org>
Date:   Fri, 28 Jul 2023 14:22:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Tue, 14 Mar 2023 13:52:55 +0100, Konrad Dybcio wrote:
> Document a couple of compatibles for IPs found on the QCM2290 that don't
> require any specific driver changes
> 
> 

Applied, thanks!

[3/6] dt-bindings: nvmem: Add compatible for QCM2290
      commit: 4b71b2a44d7d692ae681961a9b2865724652d1f6

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

