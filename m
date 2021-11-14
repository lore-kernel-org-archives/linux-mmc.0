Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBE2C433F5
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Nov 2021 20:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323576112E
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Nov 2021 20:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbhKNUqw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 Nov 2021 15:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbhKNUqk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Nov 2021 15:46:40 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6898FC061766;
        Sun, 14 Nov 2021 12:43:44 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso14163479wmc.2;
        Sun, 14 Nov 2021 12:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t59DxpPWwMue5RvBJJrR6c6rMf+S15IuR0boHpCGISA=;
        b=cn37UUnd7mty4NkCYRYIU//vLJq1dSG3j7qZ96s7YdtNV7vRNjxw0F9QcEcB85JoNH
         tC1vVd3eOBLoyXqYVRIlAvGamCjJirmU7NIrBqOIHQvAOVGjwOvUS7aGtgNjq1faboqw
         nLE/O8oVh+23c65OsIzJIMiV4hFychbMO2tyosHj8RlpHj4BlXQ9PWDnoRQ4myGtt98o
         VHMbl2WrKOKLFGIR7hTsX01LSlVWR6qLytbZ8p73xI+Yq8FpZykoWhfcDjVvNDef6PqD
         VJ4pWGUM3FQNnITEDjBfimHvJ1x8u3Vh6sEU9KKsAGO874s2u+C6ryXQWJMi5N86K0rj
         YtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t59DxpPWwMue5RvBJJrR6c6rMf+S15IuR0boHpCGISA=;
        b=LFbd67ICr1e0k8lEREcIuT+tLm6g+VF9kWVCEYnVSfzbfAMOuN2eOIpgxcskwYGEGm
         Who1nVfJkem9ZloADDMaK/4xWBkiSPH5nD1PJILyRPT3lSZytvNlSR2te7rYYxJq8iM6
         kC5p2hEmNNVcvkDCJf+K8QRKs8Z5aJKciqVnTt0XcPD63vuqrC7QBPITdco4iJf1Fn8e
         0FIMFSJZMdzIxPoJLJ2wYxAIa3//pBsFnrcOnzS2NLuu5EBQWucpnek/hzlXWdcot6m6
         upzX6fUdEg9iX9pCAq2/0QwnbEG0tHwHPD5FYvDAxAB0mDPOzPlA31icAv2xp829EN0S
         RCgg==
X-Gm-Message-State: AOAM531lO0NKHmrjotKfTZrnkiDuxmSoIe1Aj9b4IADB0Vh6ZsJB4XRk
        kKZkLbNVhVZFhZyTaoCdi3t2klw0/BEKGKcs
X-Google-Smtp-Source: ABdhPJxxIBImxTmgseQ+6VqtwL3Fb0QWxrp5KN8gOzH9i1PhXGIzrVNDfbAiXDoJv3QZsLH6GEucPQ==
X-Received: by 2002:a05:600c:299:: with SMTP id 25mr5940634wmk.77.1636922623126;
        Sun, 14 Nov 2021 12:43:43 -0800 (PST)
Received: from ubuntu-laptop.speedport.ip (p200300e94719c9aa03f58ab728c81581.dip0.t-ipconnect.de. [2003:e9:4719:c9aa:3f5:8ab7:28c8:1581])
        by smtp.gmail.com with ESMTPSA id m14sm16673630wrp.28.2021.11.14.12.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 12:43:42 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH v1 2/2] mmc-utils: Add note for CMDQ_MODE_EN runtime value
Date:   Sun, 14 Nov 2021 21:43:31 +0100
Message-Id: <20211114204331.39555-3-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211114204331.39555-1-huobean@gmail.com>
References: <20211114204331.39555-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Since the Linux kernel commit 70b52f090805 ("mmc: block: Disable CMDQ on
the ioctl path"), CMDQ in CMDQ_MODE_EN[15] is disabled before reading EXT_CSD.
Therefore, it is more accurate to use sysfs node to check CMDQ_MODE_EN value.
Add a note print to highlight.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc_cmds.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index ecbde3937c81..46c5f5faae02 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1885,6 +1885,8 @@ int do_read_extcsd(int nargs, char **argv)
 		       (ext_csd[EXT_CSD_CMDQ_DEPTH] & 0x1f) + 1);
 		printf("Command Enabled [CMDQ_MODE_EN]: 0x%02x\n",
 		       ext_csd[EXT_CSD_CMDQ_MODE_EN]);
+		printf("Note: CMDQ_MODE_EN may not indicate the runtime CMDQ ON or OFF.\n"
+		       "Please check sysfs node '/sys/devices/.../mmc_host/mmcX/mmcX:XXXX/cmdq_en'\n");
 	}
 out_free:
 	return ret;
-- 
2.25.1

