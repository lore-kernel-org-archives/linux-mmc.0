Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635A8C49EA4
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497356128E
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhFUXzm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhFUXze (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jun 2021 19:55:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ABBC061756
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jun 2021 16:53:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g6so14941173pfq.1
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jun 2021 16:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THKoO1RWudj0KxP+z9XOrOgTVnvtbYYdvVkwmldz9OE=;
        b=DSphfoFZ7DM95K+RvdByDg8W0x0HzT372m/CTEnE3pqPeq323dI65P/rlVSfLPKJQ1
         28O9oN0CLLEtsLKgQ6MlMRXyKqjvpu/VGmk9AAzNr4tU542Ko0Ca8Ro0ReN1BsCsYzhm
         FrHRvl46FXtYmbbghamYqJa+AdyJraOwaTHvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THKoO1RWudj0KxP+z9XOrOgTVnvtbYYdvVkwmldz9OE=;
        b=IRzb1495YYry0I8hyl3NmhVh+MwtGVkNtseG9rm3C7Hn3yVXsj0BtUHZ/xaZKbNDcV
         PS7pYCuLbp4qAJSuscrypRGQV04bqc1sV4Qbra37Dw2iGkQO70ZnEQwRYCDutfqg/c/q
         pik4qK2I96nyUXLY8Ac6Oitq/f0BLdAG2pvQPprrSpDgWUHlEUORIKNTk7Kvk2eAf0m7
         8ala/nDRmMLE4a7thlSXqNQbBGtMwiAiUzbcfZBkzrXFqmequlT6cWiBi8VeOCx62ZEa
         MpsukBqIEPHy5ZFbCzzX3q+ThxZFlGjTl8QqcBKoGQKltCkYxQ+Sr+B0k3+LdnUrRomd
         fOGA==
X-Gm-Message-State: AOAM531+fqNvcYZx7WuG6uVHgC5uyVOsIue6zKCZ4av6TmvOBxJ4U8l4
        rn/7VojJGAX5ynnSpRySnwVJwg==
X-Google-Smtp-Source: ABdhPJxcsyNJ4PVOdLaM5phhP72ONpeV+ZJ8ppg8iQL6bG+AB2umwHT1C064i27TPx/qxhDHxLJD1g==
X-Received: by 2002:a62:1d8c:0:b029:300:73d5:f35f with SMTP id d134-20020a621d8c0000b029030073d5f35fmr723439pfd.36.1624319599173;
        Mon, 21 Jun 2021 16:53:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:bdc1:a4b1:b06e:91d1])
        by smtp.gmail.com with ESMTPSA id s27sm4339663pfg.169.2021.06.21.16.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:53:18 -0700 (PDT)
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
Subject: [PATCH 5/6] iommu: Stop reaching into PCIe devices to decide strict vs. non-strict
Date:   Mon, 21 Jun 2021 16:52:47 -0700
Message-Id: <20210621165230.5.I091ed869d3b324a483a355d873ce6bf1dc2da5ba@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210621235248.2521620-1-dianders@chromium.org>
References: <20210621235248.2521620-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We now have a way for PCIe devices to force iommu.strict through the
"struct device" and that's now hooked up. Let's remove the special
case for PCIe devices.

NOTE: there are still other places in this file that make decisions
based on the PCIe "untrusted" status. This patch only handles removing
the one related to iommu.strict. Removing the other cases is left as
an exercise to the reader.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7bcdd1205535..e50c06ce1a6b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -368,7 +368,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 
-	if (!cookie->fq_domain && (!dev || !dev_is_untrusted(dev)) &&
+	if (!cookie->fq_domain &&
 	    domain->ops->flush_iotlb_all && !iommu_get_dma_strict(domain)) {
 		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
 					  iommu_dma_entry_dtor))
-- 
2.32.0.288.g62a8d224e6-goog

