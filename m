Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A49C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Nov 2022 18:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbiKQS1g (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbiKQS1b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2022 13:27:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B1B8514F;
        Thu, 17 Nov 2022 10:27:27 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z18so3800349edb.9;
        Thu, 17 Nov 2022 10:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN0Pf/Kjl+6iaPP/MqA8nuRuC5pA+kYilLhV8Jo1Icw=;
        b=VUTYep/y8dV73hoIk8ncAaDTUNNcEhN/XS9CIK8rv8gFEjJim4z4wlTNuSFqNWbxy8
         4GgStA0OdOK6oD4neMSIkV0UjMrp9wgF6/zvrUvfri1EJGeFDDFRyRhLRxVqSprt3llT
         HRWJ8aQrwqvcNtyVoRaFyvzsb9BFVFWXALpQcnwU6g6dvsFn7B+/fb6dmsUTYfHd0pMI
         BgSJTTqelAbFz7eyuGzzbgQrvyl8lJAaSSaIx4tCrd/o5KoNEpxGdo06JIIAgI4xzsRx
         y78+MonNyjUT/7fCpqqfVjShLaqX1U7/NFlFvd6oPALVvH1N6hXQqQfWWURnLlA5XwP/
         Kzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fN0Pf/Kjl+6iaPP/MqA8nuRuC5pA+kYilLhV8Jo1Icw=;
        b=QhZ2NGtPlhy5B0DXSLPQx56hUSQ27E51PJVAPSFxBeQSGLZ0AiZpuxqZl17jlPyd/2
         58y47k0AzdsYzeynd2aEx4Nsu4XZ/PCh1qvSyvkxa1J5HOZ95hnW0aEBbP9z8ieecXTD
         UMeDQkiywwDPXCWte1kCs8ylKl5xO896Fc+DaB+BBb5FI0yB9uuCl368tOo/otN93pNH
         QhJ6zejvqbyGDSLZlJsSfYPy4R2C1qQSBImOdkXRQvYwvhJELz3WzMoMwa+5RQ6YxnH+
         cl8hQUUSbam/f7ojgW1ogVqS0afmEu5sCOkZF1qVN4Ly1J74UBbYKwt1PCBBwsrvN5dV
         EX1g==
X-Gm-Message-State: ANoB5pmCDkv/X5SlAZdRDIyTa5mwpJxxpalZXQvJacep9nLy4hnkv0Lc
        Yc2meQozpwm2crECcYSG/kg=
X-Google-Smtp-Source: AA0mqf7zR0i8sLAdHFWQTrKHmqDUtCnCHKRJ0xwsre9iDZaHLYaQvHEnKqU7ubogXSJLQZ+Is3H1Yw==
X-Received: by 2002:aa7:d7cc:0:b0:45b:4a4b:478c with SMTP id e12-20020aa7d7cc000000b0045b4a4b478cmr3166149eds.317.1668709645912;
        Thu, 17 Nov 2022 10:27:25 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v24-20020a170906859800b00781e7d364ebsm688659ejx.144.2022.11.17.10.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:27:25 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v11 2/6] iommu/tegra: Add tegra_dev_iommu_get_stream_id() helper
Date:   Thu, 17 Nov 2022 19:27:16 +0100
Message-Id: <20221117182720.2290761-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117182720.2290761-1-thierry.reding@gmail.com>
References: <20221117182720.2290761-1-thierry.reding@gmail.com>
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

