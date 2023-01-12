Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BE5C5479D
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Jan 2023 02:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbjALCYt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Jan 2023 21:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbjALCYq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2023 21:24:46 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462EC4565B
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2023 18:24:46 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso1446633pjb.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2023 18:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Wi4HXdWl8Al9zdbLRA4NeTDiEhXtpoSSMpcfMYna90=;
        b=ikzDUXFMihwG7MHGSQ4NlPOl0G1rjTkl3EKqq0+KooZ5UqgdakAYTEFUMtvPAR+EDR
         z1UVRiC7BrDOdP46F60EYKrL7SIo/MInDVegJ2ASo948KxGYwO9J95SKQlMVpNvgA8mw
         pb+Kc0D96HJWxUDYDDxBJXRQQ7JO/7HqUA7aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Wi4HXdWl8Al9zdbLRA4NeTDiEhXtpoSSMpcfMYna90=;
        b=AeikAJfOWcF17HIGZGgG7JZzLvwroFGOsiTWgBOX3bXdxrIjXuh9gi1HW2sUVZwLsK
         vnv1H5KVGmDSIc2N3wt2oiUvW4IxC0Qd0kN1ZraQx2BLDSmI6P0ISo/DPk7O4qBqeYt6
         c1neGuDKdxK6Y7rfwliZkleeQW9V8G5H+IZgsrTVZIagvzxUrW8E5ZJIxahMFAXDsZ1i
         EUorgd6iPKYRI0EuHTh41Uh5NhmItUcCgzgDcjMVO3CSykW5dB5lxXPXg2oojdIrxGH1
         CYcnMPvs2pvt9GeQH3Gh4EmYK9REsTDJt5+RUQ8nviPSLCv2RVXUXvv8ySY/VL+V3Kw0
         9c5g==
X-Gm-Message-State: AFqh2koYvRu1Se9VDut8H3cppBpzNAdaiYegKGz8zo1HnxcgJ5xxxmWb
        tU50qHln0PXYScAjunAg7/L7NN4/22nt7CuQ/SvN4Q==
X-Google-Smtp-Source: AMrXdXvlvbSm3toQC4Pc1I7x0mQpboEKoRfHKZ8BtC8TXzCvK77+bNtGDrGgyaVx+HtqDr6JI1Re/g==
X-Received: by 2002:a17:902:ed11:b0:193:38a1:68e4 with SMTP id b17-20020a170902ed1100b0019338a168e4mr9425821pld.0.1673490285692;
        Wed, 11 Jan 2023 18:24:45 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b00193020e8a90sm10759135pln.294.2023.01.11.18.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 18:24:45 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v4 2/8] mmc: sdhci-pxav2: enable CONFIG_MMC_SDHCI_IO_ACCESSORS
Date:   Wed, 11 Jan 2023 18:24:10 -0800
Message-Id: <20230112022416.8474-3-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112022416.8474-1-doug@schmorgal.com>
References: <20230112022416.8474-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Enable CONFIG_MMC_SDHCI_IO_ACCESSORS for the pxav2 driver. The read_w
callback is needed for a silicon bug workaround in the PXA168.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5e19a961c34d..b9e9185c86a6 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -360,6 +360,7 @@ config MMC_SDHCI_PXAV2
 	depends on MMC_SDHCI_PLTFM
 	depends on ARCH_MMP || COMPILE_TEST
 	default CPU_PXA910
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Marvell(R) PXAV2 SD Host Controller.
 	  If you have a PXA9XX platform with SD Host Controller
-- 
2.34.1

