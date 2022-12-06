Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FA0C4708C
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Dec 2022 16:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiLFQ7y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiLFQ7w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2022 11:59:52 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5336F28E10;
        Tue,  6 Dec 2022 08:59:51 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id x22so7665394ejs.11;
        Tue, 06 Dec 2022 08:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e14vmcIMdCGeDCCsvjNA18WeSIg6j6mtLwuur7IIU+k=;
        b=DasL6y4z17a3uCFNx/cpZaEtMZGDNHEyM17c4YaJ1ardVx4EFQl7yvG6zHcy7yj99w
         5EaWyeDNAMzT9ODA06f75MsG1tj4rNaPk6hZsbcBd4WVvlEi/5nT+UPUEw2sEP7BMNrE
         qpvLhLLfk31orZWq2rSDPDMq0AQ6Z5PWdbVzMzj+J8o04wDhqRyFyHSOl0bYv/0uLI4I
         0i1KVGGsjIm1W8OXlgoDmK/ZwBdoCylj9p8JNlNojX5JTmTiuNXVMO5yhdlf7kRMslQH
         5pPAj8zYlXyNyNIACxF+QvssYTqX97TR0oz+3LyBnRRO+rqqB1AUyPwgA1eY+PJdg4pA
         8Bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e14vmcIMdCGeDCCsvjNA18WeSIg6j6mtLwuur7IIU+k=;
        b=VwZ7QjAPKtl5M5tkJMtVcoN1fIZMadTgWDJ0afYhEeyTNTQk+RMKGoAvUdHZ0GFYUf
         kqqU1nEpWckw6UZIb03dyZ7C6QFROgUCi7kmYag9WlZVLYumeWoMA8Qe2o3Cxa4vdw6z
         4vpDypiTk8CY0/WKdVE1Txsu9Lj3s5YY3L+UR2uZMx3OrP2ZHUBQEGdpc9Xkm9OsgSBg
         a6IgKGYkEjLalX/UApLXm4slgoor1slEuGME9pP3zuIueLMRVGCLD+QIsM8OyPp1g3kF
         //ytcXLFQzG6OBSD4SeX+rOEimexgVzr9djvNJAa7FjG7OW6jfOxdTVw+u7TqeaE7hFW
         Xg0w==
X-Gm-Message-State: ANoB5pnYzRksKT7bFIXq7QMdG4IC/tUiQxEboHrvks78hNNJqzjo6wWV
        uDU7lnzGKtbvQXIzQ0lCWBc=
X-Google-Smtp-Source: AA0mqf6wKnK8iPkkvl/9lYVOalcWQ2P+mF4+su10vJeBJqLrURueKFlLqp6gapxn8M1H0kpE6fmixA==
X-Received: by 2002:a17:907:c242:b0:7c0:b44d:92b2 with SMTP id tj2-20020a170907c24200b007c0b44d92b2mr19536028ejc.754.1670345989874;
        Tue, 06 Dec 2022 08:59:49 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906300700b007812ba2a360sm7621230ejz.149.2022.12.06.08.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:59:49 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v13 1/6] iommu: Add note about struct iommu_fwspec usage
Date:   Tue,  6 Dec 2022 17:59:40 +0100
Message-Id: <20221206165945.3551774-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206165945.3551774-1-thierry.reding@gmail.com>
References: <20221206165945.3551774-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

This structure is to be considered private to the IOMMU API. Except for
very few exceptions, IOMMU consumer drivers should treat this as opaque
data.

Acked-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/linux/iommu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1690c334e516..dc5e6f5c14fc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -641,6 +641,10 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * @flags: IOMMU_FWSPEC_* flags
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
+ *
+ * Note that the IDs (and any other information, really) stored in this structure should be
+ * considered private to the IOMMU device driver and are not to be used directly by IOMMU
+ * consumers.
  */
 struct iommu_fwspec {
 	const struct iommu_ops	*ops;
-- 
2.38.1

