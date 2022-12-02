Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7ACC4321E
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 15:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiLBP0w (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Dec 2022 10:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiLBP0w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2022 10:26:52 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31F7CFE63;
        Fri,  2 Dec 2022 07:26:50 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id vp12so12321471ejc.8;
        Fri, 02 Dec 2022 07:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e14vmcIMdCGeDCCsvjNA18WeSIg6j6mtLwuur7IIU+k=;
        b=Wo285BO/721PWAYj15qfo9b13dYOBqV9yq7NYdJJqZddw7cnvioHdb9vWP8jeJ9hY5
         xfU1KLLgs6Ojb0fOkkDHyZrRPyemn58ZScZ4bw6NEUzIMN5o8/gYbpnCSwPV1QGHzGWG
         nmu3gtwSINzDiYpB/zMksVpjStsSU+k7twwQaTc9HOPcKnlNlBJ0lMSll4qEJUpfJ1eo
         MUJ6QjfhC+ecaeNx3rbrlSK1fouQ17H1FvcEyzDBfpZcMV5Q88ZP/3oL8Asw7y1ElRAz
         xLJ33C67xggzDGikUCOitCRaZDBrF8j56M1hk1kQgS+pdT4XJubUVKAvbZ0EX5tfx5zU
         1gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e14vmcIMdCGeDCCsvjNA18WeSIg6j6mtLwuur7IIU+k=;
        b=RCP7HGZQteNX+D1+9DjGbWc96DeA7PDOB9/DWn3m8nqfsboCjLhalvXiiTcZPrDOYk
         Gc4Qx/0anSIxWxbscfb4huJ8gUv/og6PnOTJYlvjSp6dhPeOhnfN6LtMTuDoaEsgyFhF
         MApaX94inZxXugcLhPMH0lKGVgSlzVqM32IcF7ylPtBE2IV5Z6vPmSag69S0pcgqdaAK
         DsGuOmWVX+/nzrQ1VIfIOwRZFcEQAXEpwSZH5O5k4qGWZ+wHYgE7+SAplOYrPefUPKBZ
         f2otpkcdoe490rNWAVInm5V44KflE/nyTU5hvnLdJz302vrCcN1kkSgdLGXnc/68Uq0/
         QvBg==
X-Gm-Message-State: ANoB5plCi7eL8KSLPJnp9JSkpjr+ueavYsJRf9raeC7KAHI0hCjmFb5j
        YHxEsZOAXWiMbgYH/P9cgUw=
X-Google-Smtp-Source: AA0mqf6oCzTeSo7xY47G/Tjr3MvqWWirxM+oqGCDmV+NBKOJ3PloaH8CuQ1sZ7WtYu1sZIVw1lIGTw==
X-Received: by 2002:a17:906:c40b:b0:7ae:1e53:95b2 with SMTP id u11-20020a170906c40b00b007ae1e5395b2mr59446368ejz.333.1669994809240;
        Fri, 02 Dec 2022 07:26:49 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ta17-20020a1709078c1100b007ae035374a0sm3164454ejc.214.2022.12.02.07.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 07:26:48 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v12 1/6] iommu: Add note about struct iommu_fwspec usage
Date:   Fri,  2 Dec 2022 16:26:39 +0100
Message-Id: <20221202152644.29450-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202152644.29450-1-thierry.reding@gmail.com>
References: <20221202152644.29450-1-thierry.reding@gmail.com>
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

