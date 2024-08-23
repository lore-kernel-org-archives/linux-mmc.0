Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7D1195
	for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2024 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453973; cv=none; b=QnncYVzRs/XpUn9+a0jjWsFkE/G6vY+fjOYHAHXJx8dgBf7wgkJ81sbiHUha3ueZ2flwIKM70Zn2Zx7bgtjMzz694wFTw4euI2zqssrqmq2wu/vHpwq1WxUElWOUPhrLh9gs3MT+yYYAS7wxgdAS6/AZoWlCL8/bcU5g/ix/UA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453973; c=relaxed/simple;
	bh=DAwuQD6g0FEnAtIfzL8gqpFnaT6RQ4762pmnu9tmjDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dn0/eqiCJ4eUFxBQhCGchZCjV79Jk+vcofzx1YCfr5E0RM7NrTXuLfTlZlQHE6RH3c6+HaoFM/fWaoQfyqLOQvffX8Vq/mWupu1wlgmy4ouZT8HJhd7DtL0Ky9/LVMPds197hV6i/avDzXU0eYSdB+jwts87/JaQe/3UGXnymNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a/bbT3Qq; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/bbT3Qq"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f402830d19so3965241fa.0
        for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2024 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724453970; x=1725058770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cG1jaCotG4tiQAZrWKuoJsqJjXXS0R7KCH2OwILQsRY=;
        b=a/bbT3QqLiLi/vCbd5k0+LBM/hzREiK5Gwnoda9abLC72IwVdBIurDekbz0ES1Bwa3
         XkR3aHQSnixzYk6fEdDoWZ+q5HQL5SilKwhf4Oe92wZXLHDAzXxelhZd0bpXMYgfv5oB
         TvhDmk6zixa/HTiGyz7jtOIrnGfH/fTkyRzD4uxX1Bkozm8wv5MRqa9vNL3U7IaANMJn
         dEdwlFJQZkRsU/wPbIF5DrPCQtItjWLam/OVnUsHFyiGB/REX00eRuvAW585wYn6zOwe
         6s7ys+zBPDgy25j7E54qouML2PmWdaKzsfs1F/8fKl4aXFzkKPyWfDIwQnkYjEIlc5xS
         SIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724453970; x=1725058770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cG1jaCotG4tiQAZrWKuoJsqJjXXS0R7KCH2OwILQsRY=;
        b=h+MioJsrb+hi1PQgLFJKTiTk6QCEKhMwXNehRlfASvtPbf1+pYWc8wsx3RG9P9u5QP
         6Tf+sBatai200caHpqfZDZsLJx3ogTi7ensFdUJtptz/pByyphuIq62gNNUbU/Qou9gF
         4Xe/WDgkT/S9Hfwz9wYHFOuYUNsCClKVQLz297ohy8DJ0W2KAPePjjmxKxk62Anm4ZbE
         Ngj6m0xtinxxF7281Kxz5zunLXASEEEiAohYuDj4ISTtJAUt36E6RJ78vgTxI7oZxE6W
         6cvMJKNLo0h6RUtF26GA/mIZNTMVpDyDa236BwCgQ52ESa+2oFE95Ql6xSK6sPnxDOYT
         zGCg==
X-Gm-Message-State: AOJu0YwZanDdI1aAdJui/+yppZXcoxTG5dX9YRvRURMjf79SEsEIxL+M
	eYTJ9AAspdgeCpeV+q42UfCayetiSgkcvDenBSlWAmXJv3BILhk0BJpq8exsZdo=
X-Google-Smtp-Source: AGHT+IFIFb1DJqSrlsysQsCcTB7Cgl0kQyEkdfFKWea+iiiB2+DQ7rV8DH8HIvDuuQh3IJMafup23Q==
X-Received: by 2002:a05:6512:3b0b:b0:52e:ccf5:7c40 with SMTP id 2adb3069b0e04-534387c4084mr1522155e87.9.1724453969802;
        Fri, 23 Aug 2024 15:59:29 -0700 (PDT)
Received: from localhost.localdomain (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea8996asm680034e87.291.2024.08.23.15.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 15:59:29 -0700 (PDT)
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: core: remove left-over data structure declarations
Date: Sat, 24 Aug 2024 01:59:17 +0300
Message-ID: <20240823225917.2826156-1-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last users of 'enum mmc_blk_status' and 'struct mmc_async_req'
were removed by commit 126b62700386 ("mmc: core: Remove code no longer
needed after the switch to blk-mq") in 2017, remove these two left-over
data structures.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
Build-tested only.

 include/linux/mmc/core.h | 12 ------------
 include/linux/mmc/host.h | 10 ----------
 2 files changed, 22 deletions(-)

diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 2c7928a50907..f0ac2e469b32 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -11,18 +11,6 @@
 struct mmc_data;
 struct mmc_request;
 
-enum mmc_blk_status {
-	MMC_BLK_SUCCESS = 0,
-	MMC_BLK_PARTIAL,
-	MMC_BLK_CMD_ERR,
-	MMC_BLK_RETRY,
-	MMC_BLK_ABORT,
-	MMC_BLK_DATA_ERR,
-	MMC_BLK_ECC_ERR,
-	MMC_BLK_NOMEDIUM,
-	MMC_BLK_NEW_REQUEST,
-};
-
 struct mmc_command {
 	u32			opcode;
 	u32			arg;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 88c6a76042ee..21e5534ddbe6 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -264,16 +264,6 @@ struct mmc_cqe_ops {
 	void	(*cqe_recovery_finish)(struct mmc_host *host);
 };
 
-struct mmc_async_req {
-	/* active mmc request */
-	struct mmc_request	*mrq;
-	/*
-	 * Check error status of completed mmc request.
-	 * Returns 0 if success otherwise non zero.
-	 */
-	enum mmc_blk_status (*err_check)(struct mmc_card *, struct mmc_async_req *);
-};
-
 /**
  * struct mmc_slot - MMC slot functions
  *
-- 
2.45.2

