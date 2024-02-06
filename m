Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B2B6FAF;
	Tue,  6 Feb 2024 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239570; cv=none; b=doRQgumW99kqRMteTRXI1+ojBrnsgYqBZPxss2dz/74Vft7wG9yK3hSoP851tt7czTHrpLOvzlp4nPKqk5LW1f08MzLvZqxxv9gOJBB+Lw6rY1HBx3LXegLMo+/ff5iXLgjcxCEq9BFOtnqAf2y2kRp4oxkfgo6AlN5sNcjAJbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239570; c=relaxed/simple;
	bh=ksg4WMyY8esF3lNgudgjGgk56jtQMale8LRV8KAHV5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Af4p3Lf5E9MuNvOKFx4s0UMXmtxremrtQhLmMq/G65zV30549HhwVEmdsu5O7NdSOoatnEhiVmOqxKKBW6vxgXB6MJxqAbTG420WoqScrTWCNEyWn2WjUOurydPobRqSYGPpZRn85rnKw8wUUMFhhQ99MNVVJH6BvFqPnFmgtmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmIQYJk/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmIQYJk/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fe3244bc6so7266345e9.1;
        Tue, 06 Feb 2024 09:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707239567; x=1707844367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqPn0nFoSPDjgsadt9DpbqXfJ4Exx8BrE7XSJYRmqgo=;
        b=CmIQYJk/qSHdr27KKygeI+XiYW5mgNiVkiNFbsvnJIBxgMBnZ3FpMG/Oc0Rq8X2nZZ
         +x9hBCfuCYurpheOaPMJa66KExEoE4AiGow3gXUT67XK8orj6jd1dze14PSJMtqWdh6r
         fK9E34yiUhJRcJhpa+Yawajl1i3W5RKKqo355PmYdlm5EOABdOLTKmT3lagcOmUQ/SxG
         BVrWCVkwC9lT1P9XHYKCI10QjhY5DKE60gLb66ijskNJVq1pATIpL1yiC774WcWL0fgX
         6BTjGxJKL2T90L0elbZe7lKxpENnwU7IoH6NAuOyl2xjwoNQWunDespwjhZP4/huL7Rc
         EuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707239567; x=1707844367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqPn0nFoSPDjgsadt9DpbqXfJ4Exx8BrE7XSJYRmqgo=;
        b=NiD7FxEdkdN+0SUO9SOYYWf3caCV04fdQ5kB28OvPg2J0iaQooti7mB0L6GTY5T/ej
         C8rkrU8QCixi8xJCGFF6k1YKN+7iIK68Lq+nVI0YzVdZNNguaeMDGKz1DlZ5/P53FPni
         ooJ5Gfa9SSkaQml9ocZOtYY6rZm8bSG0DUQo27kvnnKEqKKHWFle9vwFVF7CM/hmyzB6
         w5ywAYIdubPv5Vk4034PTYPNPppmbdvOnDfHCPxlqVJnjRM7PhH6F+DeVBIzPhAuFyKP
         RY3ZEVLEj4FsTCf2Y3xX9rokqt13QiauenDPlWqMEWeiI5/zXvfXXQYNs3tWGwhDLJRQ
         L1aA==
X-Gm-Message-State: AOJu0YzIfuOf9vUvJZ1ltwKjD3rX63yVD2BN7Y6fw1+W9J2mnNX4PLA1
	4UImHECQ7dViYCP6f6UVuthcFiEZIg4YGST6AMismnRsgfEZBIol
X-Google-Smtp-Source: AGHT+IFwqUOfydjRHUBeY68/xKML3nndXPNluhsgDuru1L48AbA5vdEEJbwAHx3brFHByQer0cYbLA==
X-Received: by 2002:a05:600c:46ca:b0:40f:ddc2:7260 with SMTP id q10-20020a05600c46ca00b0040fddc27260mr2559093wmo.36.1707239566557;
        Tue, 06 Feb 2024 09:12:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVqjvw+VH1irtaYPvA0qVl2i592O5s8s5OVX5eANUQJFIyOVjVkSAVzAqwqZr3lm8Q/TmR1yWnG6AceygBA2EmjKhSb5RK3Zjrne+ixss8lENlJHmXX4Hfjq+HgTkzMsM8J6Ey0+FsEtg3zdG+WeiH3iMa9XZkyU1wTMgcQ7qfRCU0FYKycTL7/D2XoYg==
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d4523000000b0033b17880eacsm2546609wra.56.2024.02.06.09.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:12:46 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Pierre Ossman <pierre@ossman.eu>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
Subject: [PATCH][next][V2] mmc: wbsd: remove redundant assignment to variable id and id check
Date: Tue,  6 Feb 2024 17:12:45 +0000
Message-Id: <20240206171245.2421538-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable id is being initialized with a value that is never
read, it is being re-assigned later on. The initialization is
redundant and can be removed.

As noted by Ulf Hansson the unknown hardware check id != 0xFFFF
is also redundant and can be removed too.

Cleans up clang scan build warning:
drivers/mmc/host/wbsd.c:1287:4: warning: Value stored to 'id'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
V2: As suggested by Ulf Hansson, also remove the redundant
    hardware check for id != 0xFFFF.
---
 drivers/mmc/host/wbsd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 001a468bc149..4b32421d9f6d 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1284,8 +1284,6 @@ static int wbsd_scan(struct wbsd_host *host)
 			continue;
 
 		for (j = 0; j < ARRAY_SIZE(unlock_codes); j++) {
-			id = 0xFFFF;
-
 			host->config = config_ports[i];
 			host->unlock_code = unlock_codes[j];
 
@@ -1306,11 +1304,6 @@ static int wbsd_scan(struct wbsd_host *host)
 					return 0;
 				}
 			}
-
-			if (id != 0xFFFF) {
-				DBG("Unknown hardware (id %x) found at %x\n",
-					id, config_ports[i]);
-			}
 		}
 
 		release_region(config_ports[i], 2);
-- 
2.39.2

