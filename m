Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0943C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 26 May 2022 01:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345888AbiEZBAt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 May 2022 21:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345851AbiEZBAm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2022 21:00:42 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C1769CE2
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 18:00:41 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id g13-20020a9d6b0d000000b0060b13026e0dso76556otp.8
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 18:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGGE4GSLzv/x2NVEP5VDn0MYogt70lpacaTHKc36GnM=;
        b=OPNyDbMFiCOxSOKUVFNiP2Xoe0C6vCV1hSktwWcV73Rf18SmV7fQ+oqLeRNRhIHCVE
         3D57AM6o70rradX7QkbWw433Syz/vteOX7kQZDTIh/HvEoRgDR7sAPQoCNeWD0sajEeE
         4Eyy1dmN3Hvi9A2M73zLoIA/KMaCmCZRaOFGsQuLEtTeU4niiU05rcKLMY9aVD6KGiGE
         b5ZX9ELyS/X995zhPUraplMFPJ3Sb7zKhHrNVTesoVyc/VMAFJ+ArIBQFEhPfDvcyXCm
         bwE08KmYFfQxulej82LWbWj8kYZgA9QIte70t9wIrH0tvUt3RE3ezl8THRZoOe21pQ/s
         U6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGGE4GSLzv/x2NVEP5VDn0MYogt70lpacaTHKc36GnM=;
        b=eyr6AO7ydNFifaFZb8WoAuvrCQw63OoHiATfsmGYfadrftSAGdhx3nnMBP//WNslha
         mW6xnr1k+Zs5nq4YhXG9HpOnab/f6/Z3pjarQK+eHWbi0bAHVlzQOHvXJ0CsnWbjQvtC
         dx/qlTd/xmc2A2HpAbKExxJZuJic9uXrMqzkyg1RktomspoHe4WvhDbGIsrRglw9lunl
         4QwWBd+P7bhGhytFmf1oOCT2eG6h/06CRLrmvhvQUoWMx0qmy4QZuRl6bCDzJtDTch+w
         MuID9l0jCF26rDMA1rKSjhzmi/n1iHLJls3MxgmiC850YLewgZY9UqKfQV7W/iOhKjth
         yzpg==
X-Gm-Message-State: AOAM532/jaFUzP6AAwD7jnu2opyFAVnFh0G0FQKPkGaG2Y9G8mt5yQjf
        unWyJSlW5WN7pO9Ay2gwiPI=
X-Google-Smtp-Source: ABdhPJxx366v+Tcf+t+rY0777L6XKeOP8+joRMdH00R4wCn6ThYavcpjewfNe13SoM3sdIzADA1W/Q==
X-Received: by 2002:a05:6830:22d6:b0:60b:1af5:2751 with SMTP id q22-20020a05683022d600b0060b1af52751mr6379015otc.39.1653526840340;
        Wed, 25 May 2022 18:00:40 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:485:4b69:8e74:fc8e:b11f:9d42])
        by smtp.gmail.com with ESMTPSA id p43-20020a0568708a2b00b000f2bcd8757fsm114202oaq.57.2022.05.25.18.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 18:00:39 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     nathan@kernel.org, linux-mmc@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mmc: mxc: Silence a clang warning
Date:   Wed, 25 May 2022 22:00:22 -0300
Message-Id: <20220526010022.1163483-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Change the of_device_get_match_data() cast to (uintptr_t)
to silence the following clang warning:

drivers/mmc/host/mxcmmc.c:1028:18: warning: cast to smaller integer type 'enum mxcmci_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 8223e885e74b ("mmc: mxc: Convert the driver to DT-only")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/mmc/host/mxcmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index de04b5afef2e..613f13306433 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1025,7 +1025,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_seg_size = mmc->max_req_size;
 
-	host->devtype = (enum mxcmci_type)of_device_get_match_data(&pdev->dev);
+	host->devtype = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
 	/* adjust max_segs after devtype detection */
 	if (!is_mpc512x_mmc(host))
-- 
2.25.1

