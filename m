Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FA7C49EAB
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08C0611C1
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhFUXze (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhFUXzb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jun 2021 19:55:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ABFC06175F
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jun 2021 16:53:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h16so10927925pjv.2
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jun 2021 16:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hap5rrkK42QaF5phRIGliKevrZCv+fxjBjTLJ/pE7w=;
        b=SaTkql2WXjMyJO6whWG9JyCnglGg6faOh30E8Lhu9SgvFGWDGvulc9SplCY+Wx4hJB
         DCYHUv1GwmTka12BMkZes72rKui1uDoY0LzvsieTa2ZmIrnL4mVCj5E9Nvn0LnsgSd9a
         klTw+FraV7UJBMyr3e/hUg0h10KaCLpg93/bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hap5rrkK42QaF5phRIGliKevrZCv+fxjBjTLJ/pE7w=;
        b=G3tg1Fmaxx19bozHN8GUZsi1tNBjeyXJERrG5UZsq9Q7Z+hujSdBNzXXAszBNrfABN
         pzRbsfr2cndafmUUPqlBRCycuaZWeB0bu5dVIdJbTEnd99O+HlSZX2uQSwmGUl8b6gdr
         0gXVlCh4/njPGvLuq2k3P4av0tnLFKIw1abOoJ4llgVbChvXOf1DFhjJ1yXe4mCX8zq9
         /yWOoy3SgExacvI10XqSU8cp0zSlysG1jWDNBfOlA49tGLWpC0XF6sEp8BgWfVsfE1Fc
         qbol7GdC0hACdSybZwA0Gt0KZveSOhKA2NE4t4A2j6yDRf4QRyKK8dsgwhtW+K57QdTI
         iQAQ==
X-Gm-Message-State: AOAM533LdtX9A7Dzg6/h0Ql9NysUuCsu/yIos008CJqxpj2p+WG1hYxr
        8ppkIrpMzcZyqErvwfipX5Dn+w==
X-Google-Smtp-Source: ABdhPJwXH5vi0Xs9ZIXNanUJNzJ2JIBdTlSTrxUumm5ORFc6vCcYGBtgB9XO+d3fthNCPEvr8XR/lA==
X-Received: by 2002:a17:90a:6be6:: with SMTP id w93mr598015pjj.171.1624319595138;
        Mon, 21 Jun 2021 16:53:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:bdc1:a4b1:b06e:91d1])
        by smtp.gmail.com with ESMTPSA id s27sm4339663pfg.169.2021.06.21.16.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:53:14 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        bhelgaas@google.com
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_c_gdjako@quicinc.com,
        iommu@lists.linux-foundation.org, sonnyrao@chromium.org,
        saiprakash.ranjan@codeaurora.org, linux-mmc@vger.kernel.org,
        vbadigan@codeaurora.org, rajatja@google.com, saravanak@google.com,
        joel@joelfernandes.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] PCI: Indicate that we want to force strict DMA for untrusted devices
Date:   Mon, 21 Jun 2021 16:52:45 -0700
Message-Id: <20210621165230.3.I7accc008905590bb2b46f40f91a4aeda5b378007@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210621235248.2521620-1-dianders@chromium.org>
References: <20210621235248.2521620-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

At the moment the generic IOMMU framework reaches into the PCIe device
to check the "untrusted" state and uses this information to figure out
if it should be running the IOMMU in strict or non-strict mode. Let's
instead set the new boolean in "struct device" to indicate when we
want forced strictness.

NOTE: we still continue to set the "untrusted" bit in PCIe since that
apparently is used for more than just IOMMU strictness. It probably
makes sense for a later patchset to clarify all of the other needs we
have for "untrusted" PCIe devices (perhaps add more booleans into the
"struct device") so we can fully eliminate the need for the IOMMU
framework to reach into a PCIe device.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/pci/probe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 275204646c68..8d81f0fb3e50 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1572,8 +1572,10 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 	 * untrusted as well.
 	 */
 	parent = pci_upstream_bridge(dev);
-	if (parent && (parent->untrusted || parent->external_facing))
+	if (parent && (parent->untrusted || parent->external_facing)) {
 		dev->untrusted = true;
+		dev->dev.force_strict_iommu = true;
+	}
 }
 
 /**
-- 
2.32.0.288.g62a8d224e6-goog

