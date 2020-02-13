Return-Path: <SRS0=nQxR=4B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007B1C352A3
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 22:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20862086A
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 22:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9P5Cklo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgBMWNj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:13:39 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51344 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMWNj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2020 17:13:39 -0500
Received: by mail-pj1-f66.google.com with SMTP id fa20so2980213pjb.1
        for <linux-mmc@vger.kernel.org>; Thu, 13 Feb 2020 14:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X4lReZrHRNZcU7TXPUHMFgz8y78N2Sl25kCY1T5wMSo=;
        b=i9P5Cklo8bk+cODxwc+lyyWxg4Oyb10lxwmTMouB5Ri/0DcdHNoDzXKZ2MSDtqkcQB
         Stu/3P9GnhMFOfITgg9OVgnDYHXMomP6WUsyMlowoY8PCCcvn6YiOIwPs5m7MWx7r/Dm
         yXwIeKIwkGnx8tam/zEOObva6WMxBGZBu9c2Rwzfsfkio6p5q3IpgqH/iiRdmCz6HFhI
         a4x4AIP55+/O6B50FPfiUhwHyTx2Mw5JIbFscRTogA3tAIe53goADhilKzM47mawfEdt
         AJUVXBddr2Ky3uwfyNQ1h6m+3Fmw/ch3+0CD6NbkJ7fnq8hWaKa+SrqoilZr/6p8wqLP
         M49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X4lReZrHRNZcU7TXPUHMFgz8y78N2Sl25kCY1T5wMSo=;
        b=fKVwOga1WG4gIPsclJXZ4oNz8qaMIoPR+pcTbmQvcBslciMESGCrhUKf13JZXGGwYl
         9VZXZeM6UTZSMS6wW08H2LVwY2f0vHJK+djswttlm5K3+3sXD17BkoZ9gnlhRN5Wdj0Q
         kzMNWB9z0Q9VaPGEeeJrFNJ878comi4g+W31D8PbJt73+QCe0CCtpAhPnONVLnfwvw89
         70QM7x1/lPCgxYtj4OgQYgHgcg9q+jHQX+XLHrgdu948E1fRNovd9yYgMyqPTP2yhFgU
         y6U9Jym3R6OStFazWzTWCUodBZuPw/A98OLgYCek+cVdGfwrl+3cbN2BO/NMQETS00Aj
         a11Q==
X-Gm-Message-State: APjAAAW6JfCWv7j3SELsSsGzMmxLNMeD2L4nenvjM5kYgdcWp5FIQc2r
        6COvAbzr7+uOsvILy7iSIjTNDa3c
X-Google-Smtp-Source: APXvYqxTrnYFYae/nAAwkk3CoOKvGZ2m1TwAfYI2dL26jFYf0FBi8iyCWQKFAE8Vv/fOPKHFDBw4SA==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr43911plb.129.1581632018204;
        Thu, 13 Feb 2020 14:13:38 -0800 (PST)
Received: from gtr.motec.com.au (motec5.motec.com.au. [115.70.189.242])
        by smtp.gmail.com with ESMTPSA id o12sm4123421pgk.35.2020.02.13.14.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 14:13:37 -0800 (PST)
From:   patrick.oppenlander@gmail.com
To:     linux-mmc@vger.kernel.org
Cc:     Patrick Oppenlander <patrick.oppenlander@gmail.com>
Subject: [PATCH] mmc-utils: Fix scaling of cache size
Date:   Fri, 14 Feb 2020 09:13:32 +1100
Message-Id: <20200213221332.2228810-1-patrick.oppenlander@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Patrick Oppenlander <patrick.oppenlander@gmail.com>

JESD84-B51 7.4.30 CACHE_SIZE [252:249] states that "the size is
indicated as multiple of kilobits". This is also supported by Table 39,
"e.MMC internal sizes and related Units / Granularities" which lists
"32Kb (=4KB)" as the cache size granularity for 4KiB native devices.

Signed-off-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>
---
 mmc_cmds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index fb37189..a1b1d75 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1419,8 +1419,8 @@ int do_read_extcsd(int nargs, char **argv)
 		printf("Power off notification [POWER_OFF_LONG_TIME: 0x%02x]\n",
 			ext_csd[247]);
 		printf("Cache Size [CACHE_SIZE] is %d KiB\n",
-			ext_csd[249] << 0 | (ext_csd[250] << 8) |
-			(ext_csd[251] << 16) | (ext_csd[252] << 24));
+			(ext_csd[249] << 0 | (ext_csd[250] << 8) |
+			(ext_csd[251] << 16) | (ext_csd[252] << 24)) / 8);
 	}
 
 	/* A441: Reserved [501:247]
-- 
2.25.0

