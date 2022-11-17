Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A79DC433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Nov 2022 18:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiKQS1e (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiKQS1a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2022 13:27:30 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE148514D;
        Thu, 17 Nov 2022 10:27:26 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x102so3884919ede.0;
        Thu, 17 Nov 2022 10:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1L0qaHuxayV/ztjPJq7L3ZiA0tKeU5Nhm4CRbNrcJc=;
        b=DRZKblD/AehKJ3v1u5i7DYUgaW5+LHwWGH8MbIZgJg08pr/r6Ovc/9ynwmb/Hx4za9
         uQelGbeUTs2vsU9I4/1KtC+CVFV3qeHq5Bk5OIvQN/sUWwfIf3Dx95LndHb5nQsV3Qa8
         T24n3wPnqATzR4oY/a3MMoaxQfdBQkW8ARzBxICmD1Py1idUZc3nhyFla/ms6r39Hdc0
         44kAsB/U78Pbz8GxnvAWbgxpz+y4IVHTIkkBdtlyyuwQtQ6Oy5LZyu3Qtjgzr1zgbO0q
         UEkanpXCZ7rfEV/o8N0+f6Gu79J0pddjzdVV9QcexOenwrjKm0+qyzOE8j67x4ytjuKB
         XXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1L0qaHuxayV/ztjPJq7L3ZiA0tKeU5Nhm4CRbNrcJc=;
        b=fD+thj++UeU7qKIKcgBvg8IglNe995YAmVs2bRcqUBtOox0jM5EIGJUNGq43chbsf2
         XGgXREtYrVuZ7yVN/UFWOzjvNUI5mXkNTgN3rsZpr28Sq5U9MmZS305Oa7/c44A5BXWU
         XOj7kwZaZNG5QRWvHii8djeY7V15wtZ3oobvcMph3tYLEBnc3tcs8ST1kUz3nw1INqqV
         Eot79qxhqYpIeGpdY1MqfIh8OBQW2ZO5Xm9B5SlMumvOcknDUtSznHvAqrEZZRIsLStZ
         RhKL8SgmV2tomzo5mQuiIXct243U5qR/T5IdwmMkp+XlchIRjBh6ls76vKe7uzh/cz7X
         ZwRg==
X-Gm-Message-State: ANoB5plIF55QXWeaMtbNgDKPZ7CmViFYGoFMy7tqcVHZTZVdwdVQeY9d
        ZchTTjyr0JLnNSRJHUfcfDk=
X-Google-Smtp-Source: AA0mqf6mPgyMVUXQazAevVXoyoFrwVmk70vCWSLCnaVMiGRePK+KhynHTf5qCNauoFibO4k/HwXp1w==
X-Received: by 2002:a05:6402:180d:b0:469:58:b18b with SMTP id g13-20020a056402180d00b004690058b18bmr730928edy.240.1668709644867;
        Thu, 17 Nov 2022 10:27:24 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a14-20020a170906684e00b007acc5a42e77sm681845ejs.88.2022.11.17.10.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:27:24 -0800 (PST)
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
Subject: [PATCH v11 1/6] iommu: Add note about struct iommu_fwspec usage
Date:   Thu, 17 Nov 2022 19:27:15 +0100
Message-Id: <20221117182720.2290761-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117182720.2290761-1-thierry.reding@gmail.com>
References: <20221117182720.2290761-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

This structure is to be considered private to the IOMMU API. Except for
very few exceptions, IOMMU consumer drivers should treat this as opaque
data.

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

