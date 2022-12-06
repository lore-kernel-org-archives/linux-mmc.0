Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AD6C636F9
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Dec 2022 16:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiLFQ7z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiLFQ7x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2022 11:59:53 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA6827DC7;
        Tue,  6 Dec 2022 08:59:52 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id d14so16221473edj.11;
        Tue, 06 Dec 2022 08:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6zeSRGZWdZ7f7QPIFSyHPja8tB8Q9I3UXrRVUkvskA=;
        b=Si9LQmtxXVd4xVbCFzrwpITTbZiXZsxiEYvqVU9vwTwLb1GfpZbv3rschRpsrNTIci
         6ln0au/BZA5BJ2yxlpWyj7s0qgOxsJ7GgQRkK6l0sO+JUr9M/0vs1xo4RmDKFi59y5uB
         P2Fa0NcOQRluAxPTTIfxjIxNYdUygAOEF/VfjeUbUVkOV8NKYPrYrrPBhWmTnPpvLA+Q
         9bg/YTGDkqqoyprIoVi+mHwcVQdlywSlXu7+Hz8xvwNRnXGwABOPEEOovchFWGEyUjdO
         RJ/CvdESeTMWUkiESCoTY80Zu/k5gEkQtIDsDJzpRZId17bo97fdXZimHCZ9/K6mpspt
         q7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6zeSRGZWdZ7f7QPIFSyHPja8tB8Q9I3UXrRVUkvskA=;
        b=rgyHDW5FEOPiuF62Ymm1yNHKBRfKFVwmwCZsdB8yClMwTYPSHGT5l142XT0w3CFo+l
         0+99FgXuPgnH2khRg2Zze69krBwJfSCZMFUqxP83DziOl7Qf2w9fLNfK9F02J090xF+u
         1UKPokW9we0H6rMDhs/HNEHug0DJLScCgukLJF8L/oMrm5HFxdOg3Hx8lThhBMccNVEz
         Zf7GHe+62tgkT64mO54/4sm1bDuywLBVDx0+dbjHq0aVJsIwLrly2XYByfU6otInIzgS
         LH9Evaup/+rv/ZeldqIgvCKORgtlEYmp7kfOEiLveSCxKXcJDyL9cW1TtPCsUEbn7pvJ
         z15Q==
X-Gm-Message-State: ANoB5pn85DIzwgT6CYM5RefCAXgV6YErAIpfKYQTp1I8YDk7vT9OnW8k
        f/2ddwPSYMtCEXhCRnZTL2Q=
X-Google-Smtp-Source: AA0mqf7707fp2kjgiRSjHxsxRsDJw9rz6HYtyiPW+enepsy+W35F4b0ef0VhqG207HOFLTaAyjDTFw==
X-Received: by 2002:aa7:cf0d:0:b0:46c:5109:66fa with SMTP id a13-20020aa7cf0d000000b0046c510966famr14672079edy.309.1670345990769;
        Tue, 06 Dec 2022 08:59:50 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709063e0500b007ae32daf4b9sm6366488eji.106.2022.12.06.08.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:59:50 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v13 2/6] iommu/tegra: Add tegra_dev_iommu_get_stream_id() helper
Date:   Tue,  6 Dec 2022 17:59:41 +0100
Message-Id: <20221206165945.3551774-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206165945.3551774-1-thierry.reding@gmail.com>
References: <20221206165945.3551774-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Access to the internals of struct iommu_fwspec by non-IOMMU drivers is
discouraged. Many drivers for Tegra SoCs, however, need access to their
IOMMU stream IDs so that they can be programmed into various hardware
registers.

Formalize this access into a common helper to make it easier to audit
and maintain.

Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/linux/iommu.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index dc5e6f5c14fc..f0d72acad7db 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1186,4 +1186,25 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
 #endif /* CONFIG_IOMMU_SVA */
 
+/*
+ * Newer generations of Tegra SoCs require devices' stream IDs to be directly programmed into
+ * some registers. These are always paired with a Tegra SMMU or ARM SMMU, for which the contents
+ * of the struct iommu_fwspec are known. Use this helper to formalize access to these internals.
+ */
+#define TEGRA_STREAM_ID_BYPASS 0x7f
+
+static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream_id)
+{
+#ifdef CONFIG_IOMMU_API
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (fwspec && fwspec->num_ids == 1) {
+		*stream_id = fwspec->ids[0] & 0xffff;
+		return true;
+	}
+#endif
+
+	return false;
+}
+
 #endif /* __LINUX_IOMMU_H */
-- 
2.38.1

