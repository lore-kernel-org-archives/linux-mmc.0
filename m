Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6055DCCA47F
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jul 2022 02:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbiGGCbw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Jul 2022 22:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiGGCbq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2022 22:31:46 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBA32F3B0
        for <linux-mmc@vger.kernel.org>; Wed,  6 Jul 2022 19:31:44 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-fe023ab520so23650144fac.10
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2022 19:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=D+S6dx9ymKesv8vcL4EfSnsMhXh2ERT9o+gEy/mb8XQ=;
        b=KdHKUBw9rcNLrg28C0yLUofxQFbPnP8OErmkZL4BHjE30as12h6/lD+e42D8mEcJ6V
         RdXOnsH0/WBgkVkMio6oHd8FKOJf4qWFC0CjKn0skEvfy+/s6Kod42ADnEI1xOReVcpZ
         HhrNy6Zpil1DoBlklsAYL4FsoFVYY4exeq5mM/yJwbvB/V6j68n6Ym+sPEMHfigkEe4s
         X23fn14vucwBGCJWtyAGF1dxAr1N4qD4gDkHfNPD7Qfh86+TbF0PXKjMxMlnUXqyc6dt
         PD92St8J9ea+ieHkaXbZ5jjYdQ/BUB+79HkFAF12MUo1WKZQybRbqR0eeNStUvLtYHEh
         jZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D+S6dx9ymKesv8vcL4EfSnsMhXh2ERT9o+gEy/mb8XQ=;
        b=NCIJHyvX1YRQg2sBcZM6L9M/QqGeFhYJqJ4FGXN9mogNpfQ59H39QYTE5s9Px5mFiK
         oAVBaNVmkZCkHVBSJdYcEeaNU3iZ4EH2rnFjUnTMNkEWNEmJStyOVmQEyOgR3eNZuYnn
         X/jrHZ+FqtFK+sxlJyn2MQosbTfxeQXkuI0EzRWOHDsamSbOKFHclywMOyuRN4rSO6bu
         XGtnpnnpXAKCo70rgyj49nVfY1X5rkEtSVfZv6h2C3+Xvie1m1w33HHf+aD3d1ksJGWS
         dhipiXkxop8W6gQh+HWPaODuWA3qrIVOp7jZl4HRXXtGOlTaJXFAYEZnvDJbUYqhcMvd
         3NQg==
X-Gm-Message-State: AJIora+kfoPnPecu2wVZJVQuqCEI0Q9cVgW6Hge265vQSCaHcFisZ+YH
        25CF1V22Rk+Es9W3DW913+JjmQ==
X-Google-Smtp-Source: AGRyM1tPnl5aAODSDTTA2p1GEeTnUNtXNTQzoZIOArSy6h/gQxxg4dfJykNV776lDkIy0+w02vW70A==
X-Received: by 2002:a05:6870:430d:b0:102:572e:ffb with SMTP id w13-20020a056870430d00b00102572e0ffbmr1245068oah.232.1657161104289;
        Wed, 06 Jul 2022 19:31:44 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x48-20020a056830247000b006168c71ca4asm17024469otr.56.2022.07.06.19.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 19:31:43 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org, bhupesh.sharma@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        Robert Marko <robimarko@gmail.com>, robh+dt@kernel.org,
        agross@kernel.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 2/2] arm64: dts: ipq8074: add reset to SDHCI
Date:   Wed,  6 Jul 2022 21:31:21 -0500
Message-Id: <165716107315.864223.2452970591910564452.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220704143554.1180927-2-robimarko@gmail.com>
References: <20220704143554.1180927-1-robimarko@gmail.com> <20220704143554.1180927-2-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 4 Jul 2022 16:35:54 +0200, Robert Marko wrote:
> Add reset to SDHCI controller so it can be reset to avoid timeout issues
> after software reset due to bootloader set configuration.
> 
> 

Applied, thanks!

[2/2] arm64: dts: ipq8074: add reset to SDHCI
      commit: 730d55d861c63647df3cc9f77904a01c6719201b

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
