Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DDCC636F8
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 15:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiLBP0y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Dec 2022 10:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiLBP0x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2022 10:26:53 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B841CFE62;
        Fri,  2 Dec 2022 07:26:52 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vv4so12310845ejc.2;
        Fri, 02 Dec 2022 07:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN0Pf/Kjl+6iaPP/MqA8nuRuC5pA+kYilLhV8Jo1Icw=;
        b=eGHB6tdBRBPjrl2PVp3GLnf15MzJQhjBnIOQJObZPmLIKb4TzWTJBJ9GMWEmX5vpo9
         r99zYspTSUndyWjqW+r479cyRrT682YVfiYMbV7A2NxpOmBIcfV6521de2L5qdYvZUYL
         Xsf/S3byP3KKemkRlO0E0qbs0TzzRdJywdZTX2E7HpeJvpEgyPxwT31/l/WDiq94008k
         AmfMTjKG0e1bhd54oMRiRNjNqPqS9rKJXP3ZbqvdGj9o70DPb1S33F1Q/zCtbXOJXKbz
         6BVFVTTMHK36/aLmnSLtWJw5s2iXtdofUe5IUGU1rRiU8TB2wtV84AlrQXZG9EFhinmf
         rXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fN0Pf/Kjl+6iaPP/MqA8nuRuC5pA+kYilLhV8Jo1Icw=;
        b=OAb1BfJhawnPHrkMEK5wtQGRoZqgK6Vz2bPFHXwzcvH0eqma0zYlXqFm17WOlclNXH
         HbF2/re5AOG3zlE4zYaufbrRf4/xp9My26HH3vhwBwy+p+Ubycdh9PVJmIukPRoXsyBw
         v2coQQ0Q3eiX71bKlFqWfajDNdA9PYUvKcPXODzp9gI7tlHybhE9sqIQ5kGe42RRQT6N
         rAWc2NnpLrgwkSmnoWPS3tXOqnf8+ROWouewmNpx8LHV+E5NJRUZ9lH/pTeTsp6YxauE
         dvZb3gKXFAvWD86pOcQTXZEG8hUNhNQc6jdCal7LwGuAB1C+3h8GeOHjiR+lLkuNkwmo
         9U1Q==
X-Gm-Message-State: ANoB5plt+RPjk5AqcoJR396IfFslr9g4O7csV1upAHx00kmAEpoIK2ZY
        Kuxn3qERcdol6FKZX9vCisU=
X-Google-Smtp-Source: AA0mqf7CGmeR68IkFAhvIdJzrxBnPV/WlIzW6f5GgQazUYTy4/IPjmNLCvwKhjXmKX+8OsEartC+eg==
X-Received: by 2002:a17:906:6a0c:b0:7ad:9f03:aa46 with SMTP id qw12-20020a1709066a0c00b007ad9f03aa46mr45647632ejc.175.1669994810368;
        Fri, 02 Dec 2022 07:26:50 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c20-20020a056402159400b0046a0096bfdfsm3057372edv.52.2022.12.02.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 07:26:50 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v12 2/6] iommu/tegra: Add tegra_dev_iommu_get_stream_id() helper
Date:   Fri,  2 Dec 2022 16:26:40 +0100
Message-Id: <20221202152644.29450-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202152644.29450-1-thierry.reding@gmail.com>
References: <20221202152644.29450-1-thierry.reding@gmail.com>
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

