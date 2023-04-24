Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DCFC77B7F
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Apr 2023 12:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjDXMOB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Apr 2023 08:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjDXMOA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Apr 2023 08:14:00 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50761985
        for <linux-mmc@vger.kernel.org>; Mon, 24 Apr 2023 05:13:57 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8bb726210so40916231fa.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Apr 2023 05:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices.com; s=8devices; t=1682338436; x=1684930436;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQtohBky33MWUdeKOY9B0Jdzwvi92+shTR5B/pXImXU=;
        b=hTVanmBkAGPFQtISg9J3XJ+Tlq36EE9E8yJoC4vcotb1vZS68CHyPzfh7MQQ3KWvoY
         iK5E+RDuVKGBgDraT25L+lP6aRY9vY5TBAPhsDMMC5T/sC1GHjJkFsiQKZ13439Hj1c/
         xYsZUD4g6tqsXZc8K7+UatulGP6AAL6GuPw+/HQb5rXNLRGw/XflGuZhZoIrrV2cGmYl
         t2vD/lCz/2DJDSxV0mIGHUpLhappR9I0zILDu+GTu1RHnryQCdbJgr5+nYEqHYU1iJm2
         wfD1i+mIaW7SXYr5NwaXh0u/cMNmHi59PymlPUg3al20pUR48scVRwUajHgsO9E1V2M5
         Vjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682338436; x=1684930436;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQtohBky33MWUdeKOY9B0Jdzwvi92+shTR5B/pXImXU=;
        b=KQSNabRYFqd3wZNj2DaZfeHsjP6VgVY5eUde/c1i7kSR1ApLF0nan1OHcqDKjGZeOP
         bTCQto9gH1ukoofoPvk02d+5/gUwSCmRTfkYwtsgQEEa34wDa4ZiWO6Lo4iZQkk21536
         LjruLZcg3JXZ2OXkmYUVLtxH8It6lzx+U0d0TNppUKJtxN5Xld+8NJsBxccB45JIgk8/
         skfPDaAtPoYbJvrRWhBmzJiee1usSplXCeOJgQh/QS3esGXi1CLnbY6ILqLN1bohS2XM
         OlNLmGCpeXcKTYsaDbpJ8xZhsmlO0y6d3RQOz+VBv5MOToRozdXlLHe/QL9E0G4k6y9J
         /D0w==
X-Gm-Message-State: AAQBX9dQISa5zXvP66mkHS8esMxU789D1iSkc3eVoh4zLr/8H/WKrnBI
        H+qvsTahPGjfUa4jnru5XeWM5Q==
X-Google-Smtp-Source: AKy350akQ8EciT+C0V8pKYtfqBhPEaEv5XPr4eaKZrvmhqi0oiXoFstBdBYa998MK2ui6b6T+gGuMQ==
X-Received: by 2002:a2e:2e0e:0:b0:2a8:d13d:88fb with SMTP id u14-20020a2e2e0e000000b002a8d13d88fbmr2642480lju.11.1682338436147;
        Mon, 24 Apr 2023 05:13:56 -0700 (PDT)
Received: from mantas-MS-7994.8devices.com ([84.15.37.222])
        by smtp.gmail.com with ESMTPSA id x23-20020a2e7c17000000b002a5f554d263sm1732382ljc.46.2023.04.24.05.13.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2023 05:13:55 -0700 (PDT)
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
Subject: [PATCH 1/3] clk: qcom: gcc-ipq6018: Use floor ops for sdcc clocks
Date:   Mon, 24 Apr 2023 15:13:30 +0300
Message-Id: <1682338412-15420-1-git-send-email-mantas@8devices.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SDCC clocks must be rounded down to avoid overclocking the controller.

Fixes: d9db07f088af ("clk: qcom: Add ipq6018 Global Clock Controller support")

Signed-off-by: Mantas Pucka <mantas@8devices.com>
---
 drivers/clk/qcom/gcc-ipq6018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index 3f9c2f61a5d9..5c5d1b04ea7a 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -1654,7 +1654,7 @@ static struct clk_rcg2 sdcc1_apps_clk_src = {
 		.name = "sdcc1_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll2_gpll0_out_main_div2,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
-- 
2.7.4

