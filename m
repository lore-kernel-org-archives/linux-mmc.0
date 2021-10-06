Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7629C433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Oct 2021 03:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0011611C1
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Oct 2021 03:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbhJFD6v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Oct 2021 23:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbhJFD5e (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Oct 2021 23:57:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02A7C0613AE
        for <linux-mmc@vger.kernel.org>; Tue,  5 Oct 2021 20:54:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y23so4777479lfb.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 Oct 2021 20:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZOpdA3eYjpudg4OpQFFkH8jLHw3BxsNdxzTMff7kgw=;
        b=Vqowca4UgiaC+fBXqBcu/uY1PBquzcLUSNLvI4m85X7UrokO3SMSU2VjgjwlLvMQmh
         qsx0PVYwuS97nctSczbW0/EPVJ0QBpI8npXxHwrFMaNxAVtaIlRSrtfDr/01lMkJFIzk
         NeLaREUo2x9NAHKctYTeKFJdcbLKG3DGrW4TE6vnxKsvxVRzGpwnzWZPAhbV6qTOP1TZ
         8albRcafCq9VIoNGF5i1EtEgCzTR7YeJxiTMPsw8rZxBFCSGpBQwXD+jrBjbyyQnVjnb
         ujZ8iI+IoHoh/d/5ZhPx+FNiAsGnS4MzGWDOWNQ3qbBfyZhavzipupkGO+MkveylWsCR
         B8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZOpdA3eYjpudg4OpQFFkH8jLHw3BxsNdxzTMff7kgw=;
        b=J115y31RrxZMal7f1W93cji7CaEdEUxw/TCSRp04RKdaXm7Y5ezDrWbwepu1ABg9OB
         E4Bp7hdphKdidzM3Mf4WaXmZdW+OLidmNlkpvsRyLe/tFBvB9COfP1BtKyySsDj5VJqH
         xawTf2Q2j0ho/+MNvIj0pG+E2Hbwe54rzQEkP2cycxW211/AgDRZRdtVtxk2EUYZT1J2
         24UiroV2g8Aoyrh0k3bnJsZt7H7ID3iQsTNT8yXoiUB/bkzMQ9tEzhNgVm2JwB/WTQI4
         n7vPJNpMfntM+w8mYJlO397d4APkQcEl/LHITy8mEy2Lho9tbuVGvQcpsXhfi718AANx
         l5lw==
X-Gm-Message-State: AOAM5330Qmd+1YU56CPngtd/jq7AmLf+cVu+aN5xls1ydykFbQB9nsrv
        cUqWCtAswGJMaANcZEptxYSgAA==
X-Google-Smtp-Source: ABdhPJzAuciR0Bs89UsVK2ICmqc78PA7gPD8wfVqylDag0DqJdI3Y1HguWHKaOEbTu8SD0HZCDgojQ==
X-Received: by 2002:a2e:480a:: with SMTP id v10mr25910067lja.268.1633492465108;
        Tue, 05 Oct 2021 20:54:25 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s4sm2142967lfd.103.2021.10.05.20.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:54:24 -0700 (PDT)
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
Subject: [PATCH v1 15/15] WIP: arm64: dts: qcom: qrb5165-rb5: add bus-pwrseq property to pcie0
Date:   Wed,  6 Oct 2021 06:54:07 +0300
Message-Id: <20211006035407.1147909-16-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
References: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 326330f528fc..0c347cb6f8e0 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -689,6 +689,7 @@ wifi-therm@1 {
 
 &pcie0 {
 	status = "okay";
+	bus-pwrseq = <&qca_pwrseq 0>;
 };
 
 &pcie0_phy {
-- 
2.33.0

