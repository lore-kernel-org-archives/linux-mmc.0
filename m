Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C427C433EF
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Nov 2021 20:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4664660FE8
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Nov 2021 20:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbhKNUq4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 Nov 2021 15:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbhKNUqk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Nov 2021 15:46:40 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DCAC061746;
        Sun, 14 Nov 2021 12:43:43 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id y196so12157753wmc.3;
        Sun, 14 Nov 2021 12:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kP3xYHTgf3xiqvDKR6oSKFaK/9w+EGSR3L/Lkf7VsQI=;
        b=lAzy2bWFZq2Zin54Yg0kAwXMjeDJEtweIebrF0xO0GOO5NkHV9312Jc288Cwori1Zy
         w4/jfkpbR4SokHguodLQe/jJanwzQcFAiCtkdUBCYp/PaSjfSWD6Dgz4CdLiBu+BUmpC
         MjfM9w37cJxk69Aj08wuJt3vvrgR2iOL2jUKUsw636ECbOuuvNX/pVc8BTPMDaQoHfEr
         smeftQSGueZY3A3eAsZW948Ljshe+dMcHL9qrPLCXVkySn2o+pDpZK2CqxwlIi16bdAl
         04t3eLPDXEHJN5n4Ikwsgton6LveXaEgb6SmSWaxn3WrUdZ6OdlfVbG78Mr0RocCc57K
         fU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kP3xYHTgf3xiqvDKR6oSKFaK/9w+EGSR3L/Lkf7VsQI=;
        b=Kovgo+VgIoH/GfJWec7wEsQqo/ZRv6GiJAV19I5PTSqZbcO31wCqLTwWh9NI6/YlzD
         LgW9cqX3b7RB6WapUgIMuGqHFTsa/7bRMNBa68kkCqrWMRuIDctvERZPfzvKHY+M4gl1
         12IyyaIN0y737HVCuC4+iP0XDgppO5XUPT8flUFDnKMh8sP9515ZzCLqToIeb+/jQmMW
         iFZkxmpXYQa9slbY4XDAc2US8B3ic8IVoBiks4V/Egesjl4C7VFu8c4ZHj4Akm7RHk2s
         7eBqvaDQkEs+oCHEElKYh1meWlXcULJ2ySBrhIPxma797cx0DeQ8e8KKN6GUiTIQE/66
         LYzQ==
X-Gm-Message-State: AOAM531WV2/qcSov8X1x/GRT7cZTEwchnymUIVbw/3Ek+pEBbDXMooeN
        qnvvGpUqqptDoCPreYZcuSA=
X-Google-Smtp-Source: ABdhPJxeTDf5dBMTjMgL/1GC8axroAWjiyIS35II9SYiAeyu3WJ3ec4+ujpo1+0qwcLPOUbFyQFNog==
X-Received: by 2002:a7b:c2a1:: with SMTP id c1mr5103680wmk.112.1636922622505;
        Sun, 14 Nov 2021 12:43:42 -0800 (PST)
Received: from ubuntu-laptop.speedport.ip (p200300e94719c9aa03f58ab728c81581.dip0.t-ipconnect.de. [2003:e9:4719:c9aa:3f5:8ab7:28c8:1581])
        by smtp.gmail.com with ESMTPSA id m14sm16673630wrp.28.2021.11.14.12.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 12:43:42 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH v1 1/2] mmc-utils: Use memcpy instead of strncpy
Date:   Sun, 14 Nov 2021 21:43:30 +0100
Message-Id: <20211114204331.39555-2-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211114204331.39555-1-huobean@gmail.com>
References: <20211114204331.39555-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

The -Wstringop-truncation warning added in GCC 8.0:
    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82944

If you use the GCC > v8.0, you probably will get this compilation error:

error: ‘__builtin_strncpy’ output may be truncated copying 8
bytes from a string of length 511 [-Werror=stringop-truncation]

Use memcpy instead of strncpy to avoid this compilation error.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc_cmds.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 205e6e5b89f9..ecbde3937c81 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1835,7 +1835,8 @@ int do_read_extcsd(int nargs, char **argv)
 
 	if (ext_csd_rev >= 7) {
                 memset(lbuf, 0, sizeof(lbuf));
-		strncpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
+		memcpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
+		lbuf[8] = '\0';
 		printf("eMMC Firmware Version: %s\n", lbuf);
 		printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
-- 
2.25.1

