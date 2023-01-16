Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34860C54EBE
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 19:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjAPToe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 14:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjAPToc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 14:44:32 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E52B2CC55
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:44:32 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id bj3so26893238pjb.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Wi4HXdWl8Al9zdbLRA4NeTDiEhXtpoSSMpcfMYna90=;
        b=XmeOYStYca7sVmV9F1A8yeAePT8b6Q8i3Oc7gOtEMiPBNDQA92AK0uJhI6IBwCkG3u
         HhaFUqO+cicO9t83/B3I6Gs5DEO5tbv7N+WN4BdGVSUTCGlcsoO5vENysIRigQcCP5bm
         JMubIZoCt/jb0rcxmhM4FQjMgFMXfwTzijX2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Wi4HXdWl8Al9zdbLRA4NeTDiEhXtpoSSMpcfMYna90=;
        b=uqj9R8YkG/PUqVC0a9uhgQciuCoahRDMrriNZmp8Bh3vCEGnF8qYPsL9h0GlnIpAWj
         lE4RULoqoGliMr5wt3LA6NjB20lt59HB2ueU/jb4eOGcKO/LwF4eNf1n3kV+SZUcBN8a
         LjM8lSnfwfAtiOzdeB1HetCctKVXJCFPdhcvZ2ePZc7plWszGXCz5Hzfd9wt7e3Yzg9M
         eCK74a7/sXXVIeBC05zGRDHEUJbQY+q0xbeQj/6Y1Af9kdeYrcInwLO7xptzg4CVEjhL
         5z+NIU0H6/80Ack6miUMg6JfV/MWHklWuXUgYrjPz+q+pVDLntJlLp7VlGqdGl7Nd5rB
         WNCQ==
X-Gm-Message-State: AFqh2kohqBH8LZEZvco9b6ATDgP6Q3CSWU1AvdXv0UDBGwPHm0zyeNtT
        BzTPFQNY0ax50kzt07eMTN+y0Q==
X-Google-Smtp-Source: AMrXdXuzuSFP2cb1AOrdgnbHtLmgMCMk7+mhii1aaBpsAgzjDZLKE3LusqKK/Z7F898mZLNsCd2hoQ==
X-Received: by 2002:a05:6a20:8e0a:b0:b8:7b63:252a with SMTP id y10-20020a056a208e0a00b000b87b63252amr8112807pzj.51.1673898271699;
        Mon, 16 Jan 2023 11:44:31 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902b20d00b001926a76e8absm19734663plr.114.2023.01.16.11.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 11:44:31 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v5 2/8] mmc: sdhci-pxav2: enable CONFIG_MMC_SDHCI_IO_ACCESSORS
Date:   Mon, 16 Jan 2023 11:43:55 -0800
Message-Id: <20230116194401.20372-3-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116194401.20372-1-doug@schmorgal.com>
References: <20230116194401.20372-1-doug@schmorgal.com>
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

