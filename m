Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7657FC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 20:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F96461241
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 20:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243199AbhIWUcf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 16:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243192AbhIWUce (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 16:32:34 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDA4C061756
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 13:31:02 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id a3so11428864oid.6
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KfgAPoqNGuGt4SJWxFhDYx6cCrPZC3ApVgwyVQdWxZM=;
        b=ChnyOEHaPJ/TAR3ZO07ITYZC4dk5cWTX5CBxf2SKvotJ87MuYQxnsdyR18WVvEE9Th
         xPVsA7CaQS+LgHHk9HKRqKp8G4wSZgdIYqoyU3hpoQ9oPA8fZfZm052PHIFBMfK68cvH
         o1KDHflaL6+bP6jA3y+obR9KV/z2auTeSasdCQNKP7KBrDtJYxluXhr6uiy2NPkbtN4A
         0sfAo6J8Tx+lQGBz7615tJZwXNIU2FYrG+bIo7uY6qIp4FJlJd6W1xDVD/1t3/zuC5yc
         IczFJOvaSfuSAT6sW2My5SNi5J8QyQ1SXBQXDQbuBpY5oICzeC0bWGnX1KPx/nLjAvbo
         +AKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KfgAPoqNGuGt4SJWxFhDYx6cCrPZC3ApVgwyVQdWxZM=;
        b=57zVfnC74t91EZzXR4rfqxtqm2qzXE68dldJYlwDZ9wMeDN5kGbp2YPb+ylndkayzC
         PoLM9DaFA8n0rfECiDGhk27UseOchQWhj0H6ByYW7sQQr4xPOMO2ZNEvqWzTckDZ3t/J
         iZHOaN/3JWMFt4l24FcajgIOaE2UAtnyAZhzhKq05LBNFh1zkrhgjU9TzRfw4cyGDdgn
         DWDZaJKauyorMYEWHJ7SBayhaX5ac/V5yabZjHkC8KLvrN4bVLAbid8QCSjosKdM4347
         i2p/U2PFpeomMksVOJYEew4z2r7ZL1n4nvb/IdcWQlm+Ed9fgQv1XYVDLE9oVlYZClTf
         qzYQ==
X-Gm-Message-State: AOAM5309WuX0EywvDB9Sq0FHLO7OqhyXuVLw7AU9SM9q2UBQyrmU2bAC
        odQuZI2SBJ//h/g1qX/CumJEPA==
X-Google-Smtp-Source: ABdhPJxWTm6CaT1ND6bGaFNTSAKpnrLv00eqNbrx0WnULUxuw/bK1fjd8KciNlyMULO9ikiI352lKQ==
X-Received: by 2002:a05:6808:138c:: with SMTP id c12mr13956146oiw.34.1632429061671;
        Thu, 23 Sep 2021 13:31:01 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i1sm1583036ooo.15.2021.09.23.13.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 13:31:01 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, robh+dt@kernel.org
Cc:     rampraka@codeaurora.org, sartgarg@codeaurora.org,
        nitirawa@codeaurora.org, sayalil@codeaurora.org,
        cang@codeaurora.org, linux-mmc@vger.kernel.org, agross@kernel.org,
        devicetree@vger.kernel.org, stummala@codeaurora.org,
        pragalla@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org
Subject: Re: (subset) [PATCH V1] arm64: dts: qcom: sc7180: Use maximum drive strength values for eMMC
Date:   Thu, 23 Sep 2021 15:30:59 -0500
Message-Id: <163242893971.825761.9292228692666120286.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1629132650-26277-1-git-send-email-sbhanu@codeaurora.org>
References: <1629132650-26277-1-git-send-email-sbhanu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Aug 2021 22:20:50 +0530, Shaik Sajida Bhanu wrote:
> The current drive strength values are not sufficient on non discrete
> boards and this leads to CRC errors during switching to HS400 enhanced
> strobe mode.
> 
> Hardware simulation results on non discrete boards shows up that use the
> maximum drive strength values for data and command lines could helps
> in avoiding these CRC errors.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7180: Use maximum drive strength values for eMMC
      commit: 752432e40e8f0d02d0af07cce2d6d4b250be11ef

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
