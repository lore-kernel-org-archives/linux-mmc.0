Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ADCCCA483
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jun 2022 20:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiF1UX0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Jun 2022 16:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiF1UVy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jun 2022 16:21:54 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12249E0D9
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jun 2022 13:19:45 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w193so18738647oie.5
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jun 2022 13:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L7X1tSt2iJ6DktLCRmPmCKw+/uL8cAeokrUaFc2RJPI=;
        b=actnBH/LAbmAGmzjAjA8870t8pTv0++Ozgzd1b8av4QHdzi0Sdb2uSzk7UPp4Ps9W0
         QpDYq+X8y9S53gjHtePp+LZQAN/MnSlmKdLkOy7gx3dj8SgiSl1rTSdznrxBPFt2/wRk
         JvrPD4y6S4dGNjQdq9wkciNMfUdYb/iGsvbCGp+hqzJYKjqklN1w/WhDkJ7AoAjDf/9X
         xnFWoBDTCSJ0nq/EQrtmMqAyS4UXDCaP18Jgq25spIEBe23YW/JhnplHURLHc6uLDBdV
         KpkhTJi3KPWcDCNFSDsM7sGWHAqY/HIlM6X7tBVCBZbhziD9xUSFzkItAuHB9FINhbr3
         Tzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L7X1tSt2iJ6DktLCRmPmCKw+/uL8cAeokrUaFc2RJPI=;
        b=s9L8u6WbR4y/NX9peUf1MYTdNwpG6MVFwwVNhoKjDGms6dknAjeBp5G8Iw9wysvfEN
         M4SDY8IRyGsfhca5j+X6nY8LScq7PJcKRx1YNEs4RQtR3E41zYsI5Xoq+swxTViTRJb/
         6B6h+wXqKdLBkiJzqYcXSlncB84lSILIPQDCp0qHoxYLp4ky760KDZevDORnDQremTGq
         KRAHaQpoBKWsSdkMQTcEivT991/JogdV6mP80SYB3CxM90XIVJwZmSfE9uxArV+HADej
         uMgcK6DRziOZbxMW2YIhTqzlwNdQw+MJROycqGnTRcsdJcSzL9atT4RPEBQOXSz88FRR
         YjQg==
X-Gm-Message-State: AJIora/PmISn6qk2YUDSodCugIM1ShRqqZ/2xzM616awy7jTA9LDvC1a
        CwEGLw2bCZTJNpUSM3FnE4X3eg==
X-Google-Smtp-Source: AGRyM1udZl9cYOZCTVRx2dP4aQ65DPh7kIknOz2yVcCQK0jjiEHNvsMvE3gxfKUp/+0eGVjssG4YBg==
X-Received: by 2002:aca:abc9:0:b0:335:796f:abba with SMTP id u192-20020acaabc9000000b00335796fabbamr920913oie.35.1656447584789;
        Tue, 28 Jun 2022 13:19:44 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a12-20020a056870d60c00b000f30837129esm9536923oaq.55.2022.06.28.13.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:19:43 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     will@kernel.org, Rohit Agarwal <quic_rohiagar@quicinc.com>,
        robh+dt@kernel.org, adrian.hunter@intel.com,
        bhupesh.sharma@linaro.org, joro@8bytes.org, ulf.hansson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robin.murphy@arm.com,
        agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: (subset) [PATCH 4/4] ARM: dts: qcom: sdx65: Add Shared memory manager support
Date:   Tue, 28 Jun 2022 15:19:11 -0500
Message-Id: <165644753307.10525.4712451269370492524.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1651480665-14978-5-git-send-email-quic_rohiagar@quicinc.com>
References: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com> <1651480665-14978-5-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 2 May 2022 14:07:45 +0530, Rohit Agarwal wrote:
> Add smem node to support shared memory manager on SDX65 platform.
> 
> 

Applied, thanks!

[4/4] ARM: dts: qcom: sdx65: Add Shared memory manager support
      commit: e378b965330d99e8622eb369021d0dac01591046

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
