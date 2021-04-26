Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A463C433B4
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 17:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C8E613B3
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 17:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbhDZR4t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbhDZR4s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Apr 2021 13:56:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30064C061574
        for <linux-mmc@vger.kernel.org>; Mon, 26 Apr 2021 10:56:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f15-20020a05600c4e8fb029013f5599b8a9so3595557wmq.1
        for <linux-mmc@vger.kernel.org>; Mon, 26 Apr 2021 10:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5ky3C278fTyj7xzurTFg57gY5CqNWeI5tQJtroGglE=;
        b=hxhNDOS+yXCfKTmokgJ5ZlsmPx0RcbLFa/82e9gLxFOGzyHSTEw9/FIFrKI7qZ9OBN
         FyrlM646/u5pYH6pjPhPXj+d/PS6Cs9ITo9KTY3FzCnZ92Cm9qo5bXht8fB8MvbbDNON
         CtEE3HvZYtw8MYPE8Hzq9KbjcXWfSpKW0Tc2Z8lPY+q+Bq4v4fpJZ2IW/PQyG/U+Bwm1
         P5kh09lPxpBBD1rf4PQq1Lsycc/LkoQdA3fYeWmc38KCmmM6UtClI4uAVYDU+6L3NFdI
         jpJWeCJJtuwNJyHj1DDMarggDO112TZugQ1seVmvH0U/DXU7Xg3hL07dHpNdSy0aTEvS
         pmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5ky3C278fTyj7xzurTFg57gY5CqNWeI5tQJtroGglE=;
        b=NS/sosISqjycEJIfDQwmSVZidU8O48dh/39EDmIyJpRYCxVRF4bd8Hjy0l9ey5OSPm
         AnqXA1TJ89MNfJ2wWlEW8qGJnjnK2vSO90JFum/Mo++3S1afuHw09AxgJ/MPIPhqTlCe
         hT56bcM1aSC+4vPA0DxFc4VW/Dc82uMRtyZOeIew3yzb3XpB8Io/U0BXER6d8BJAggoa
         EY9rJLNmfbqrSmjmS2FCIfJMQo5o2TvBQm4AxidFG44UYIAD701x187pU18effmegvVX
         Bm2XdZPeSiOwSFl6LFsIiam+rYVMgwXLT/Y3rTMmwi63wmO+eB3jdr11IlNhr08yLo12
         EOhg==
X-Gm-Message-State: AOAM530ihHsgy4oFYAJBpzr7P7bb0Wun59YitwC2StMI8WyhDpo5Sb9t
        5bGn7SCjVHOHd8AzVVL1MTQxhQ==
X-Google-Smtp-Source: ABdhPJxOEf5WrroQm4+6ywa4UClWp0/lOaQSNgKwiy7DDgNpk9QkOesL9yO1Ur5kkX5LmPKDQE6LgA==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr231005wml.79.1619459763236;
        Mon, 26 Apr 2021 10:56:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:b76e:7362:77c0:ddc3])
        by smtp.gmail.com with ESMTPSA id l5sm18001806wmh.0.2021.04.26.10.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 10:56:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, khilman@baylibre.com
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] mmc: meson-gx: make replace WARN_ONCE with dev_warn_once about scatterlist offset alignment
Date:   Mon, 26 Apr 2021 19:55:58 +0200
Message-Id: <20210426175559.3110575-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=D4BnzQN4yovLOupJGSNrbWTUPYCcxuBJZXJ1F8kaNeI=; m=ygoCLhKf/v/HVpjA/Pa8YJvQeeXyjQkv6fyzRtAwrHw=; p=XuOMdYKhwBPfihg5inLCFiEtpgUiSKXZkxwW0eW2eX0=; g=dafaad0776a887f410e5d3ec6e08cf89118507a5
X-Patch-Sig: m=pgp; i=narmstrong@baylibre.com; s=0xA4CFF8AE; b=iQIzBAABCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmCG/pEACgkQd9zb2sjISdENlBAAgUb Vjq5e1kby6MqtJS5HtnydgaMwvUs/tVSnyZGjwrspH/tuRQo6VtgxCDgW7bG5W2Gp3pnXauXLIzer jXQoBjFRLNt5rtwRg0bZPnBVIkt+8eXUtO57on+PrNCY3K04QL5A9iWYavQGEzWo+fTXzHwU7Kuwa QNNojZU8fL7umEGvgeI/AhIu4/gmYtpQ2EMnumkvoXM/UNBua/bMQb3gDXlHbfsiIhsDA0et/Z/QB OyPpiJnncBU1CvXxQ0g/3bqtZo40MvNb4Gmc1IxSM0cxUS97BLk38nnBFlSF59T7k1iUTAkSjDLLo f44Gmrf79q0nJR4aTbNVuCqeQuU8pWF9xnOn1cuM5aij7tphWCWR6IMxru9VJsptExir7P8cHD6sN noZL8hhK/wUF2lq5jYwTZGQLejK/nP7G40ZyfJTy+lkotMlwd3+PDT69az3no+qweFQu3PQvDJbSW IMXO+V+9OvVXCYKYmgY5Aqyr1rt7sevV6ziOpGb6oQceqBuPDRA41NQdmARoXec1x/k0qTqCykmN6 G+dsLxrbs97zTDf1snjcKBaZPjFUqtaJ4EgqmJ7V3EHvzmyGfpeJJppigVbbDbWq9Y3vRwDepFzf9 C8Sxu3hz0Hmy7CDTDHR/zsRR7L2VgOmvbKg6v7I8cNkT1Jpl4dEdci/x2/2xuDLE=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some drivers like ath10k can sometimg give an sg buffer with an offset whose alignment
is not compatible with the Amlogic DMA descriptor engine requirements.

Simply replace with dev_warn_once() to inform user this should be fixed to avoid
degraded performance.

This should be ultimately fixed in ath10k, but since it's only a performance issue
the warning should be removed.

Fixes: 79ed05e329c3 ("mmc: meson-gx: add support for descriptor chain mode")
Reported-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index b8b771b643cc..1c61f0f24c09 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -258,7 +258,9 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
 	for_each_sg(data->sg, sg, data->sg_len, i) {
 		/* check for 8 byte alignment */
 		if (sg->offset % 8) {
-			WARN_ONCE(1, "unaligned scatterlist buffer\n");
+			dev_warn_once(mmc_dev(mmc),
+				      "unaligned sg offset %u, disabling descriptor DMA for transfer\n",
+				      sg->offset);
 			return;
 		}
 	}
-- 
2.25.1

