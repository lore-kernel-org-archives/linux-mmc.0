Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E576C433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Oct 2021 03:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655D26120F
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Oct 2021 03:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbhJFD6P (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Oct 2021 23:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237824AbhJFD5H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Oct 2021 23:57:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38839C0613A2
        for <linux-mmc@vger.kernel.org>; Tue,  5 Oct 2021 20:54:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r19so4459910lfe.10
        for <linux-mmc@vger.kernel.org>; Tue, 05 Oct 2021 20:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lOnAyrBq8epXVQrN/WDXQeiKNCDBNkNLvVnOhj3ua+A=;
        b=EXdBcPTCi9Pbs0BZua/dU4gI91si5Iub0rrfb+BVmheSvGSqXRSQ1kTj9Kqk/o+YSw
         Sp1PzSb7XxDE6ZWrp4WTBqXtYUK5/iu+ZIPqibNy9cycqyaln2LWVHuzozAYV3rtzlq5
         9JDIe22v3Rl6vzgtu8z/JAtQVwEN+sxrE1TnWj64YrQE2kjXFEYtiB6BN+wWrm+JRh2z
         9/9v8A1FYXQ/r87Ky9Q+TyRfQMzrhSFQ1bsbzanHx72oRBfaCXppxWib6kYzeC6exCA9
         QhKWbm+NHDc5HuI/TPTVgPnlLzD9VM/8PG/YDbKoHhCMtKa7spNdHPUdjZwN94pYp1e4
         Xn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lOnAyrBq8epXVQrN/WDXQeiKNCDBNkNLvVnOhj3ua+A=;
        b=hhzQZwb+0qfl5okjLUrXMWu80M+grFyxp83E+yXPmoH1s4iJ1bVyqdCSSdgLeZgJoB
         u2cD66TBJ8v5Spc3pu+nKD/hTzgI6gp2/Lfe+mJ/me8HQi9Sl7xIjJLvcx2+RbC/UZuY
         AOGO7KX9AK7dqxTX2kofOF8EaFzS/NMfXpI5nwAT6uEMgCqRzLdczSfhOPxjF191bzxK
         KTr1in96IYFH8uXBSuIGsr/CI2T21Fj4kPYkAv6ltpTdaYf38YyvnppPAtTtCZM44Kn3
         CAaJiIBqdNv1Ho5ERn6jcyOmL3RRN7JTR7X2RWhmTHcrAFi3uLnFsOIP8cBEJB1C/z8b
         ZYDA==
X-Gm-Message-State: AOAM531p4o5Q4eTkHz5qzGZbSKS6hst+7ryyDJjgZJpfGxN4/7Wo3jNk
        gHzw4CePysd6UTkPpvIaECVQWw==
X-Google-Smtp-Source: ABdhPJytJDOF+lgU658ts6E88pAfppSJZDYauPQN5bzLfv3wFMtv/ZGbgZCMTKCWUMBONI7iO1qyjQ==
X-Received: by 2002:a2e:812:: with SMTP id 18mr26729407lji.497.1633492463509;
        Tue, 05 Oct 2021 20:54:23 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s4sm2142967lfd.103.2021.10.05.20.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:54:23 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v1 13/15] arm64: dts: qcom: sdm845-db845c: add second channel to qca power sequencer
Date:   Wed,  6 Oct 2021 06:54:05 +0300
Message-Id: <20211006035407.1147909-14-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
References: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On DB845c board WiFi/BT chip can use both RF channels/antennas, so add
vddch1-supply property.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index a6a34a959a91..0f3214c60980 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -342,6 +342,12 @@ vreg_l21a_2p95: ldo21 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l23a_3p3: ldo23 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l24a_3p075: ldo24 {
 			regulator-min-microvolt = <3088000>;
 			regulator-max-microvolt = <3088000>;
@@ -637,6 +643,7 @@ &qca_pwrseq {
 	vddxo-supply = <&vreg_l7a_1p8>;
 	vddrf-supply = <&vreg_l17a_1p3>;
 	vddch0-supply = <&vreg_l25a_3p3>;
+	vddch1-supply = <&vreg_l23a_3p3>;
 };
 
 &sdhc_2 {
-- 
2.33.0

