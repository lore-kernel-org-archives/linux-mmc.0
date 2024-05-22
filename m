Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369583CCF;
	Wed, 22 May 2024 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376181; cv=none; b=VUxYvXXmW/+ya/Zr73/UW+cFZ3Tx9c0D9DChMQa82pNFIQUgYJjwoO+F+7UKrARTPkDmrQ0JqCWUuD3GebuOMPQJzkdQzaogcuXY7hYmgxbcfH7poKoYTGUjYv+HbB6sIstPsFRc47xCf6q72DzA8kVReBL8QmppXjCthdr8fRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376181; c=relaxed/simple;
	bh=urHhvNgFjlJC0RUvDI1zmMHs1AZTnco7V3JoqsJKmGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T7uOXm3d7aXqs5BKhmVSFE5tsvp1zhp8LW3bfs8bUMvq9aRUOf9/YbEUWID5pRZkNlHBtuBzLhyp4FuRLBXqlXqDjLasL1Dgla1B76xH0A6RoQGqvbUsxuiybrXI+axmYneBRew2JnURS8rwGf/D5wnOSaJMqEWE9596lzS6WwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmFNuqhJ; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmFNuqhJ"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-23d477a1a4fso3274657fac.3;
        Wed, 22 May 2024 04:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716376179; x=1716980979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elnfGKAy/7+HbOAzxPXIpLPWv33SV0UOKZl7RY/LQJw=;
        b=UmFNuqhJe+q0JIaz2iHe0gf2FQQ2ojXUnxg7tIh3BeFIBgI/Kns5Aun86fRVuZwB43
         QSgaNVBjt7fSkMh4LyZRKqKtfgfla5YFFztoxkBrxFL95n9U7kdvJfw55e5s5zCN+380
         tVBoXgpXCWSfR5NoTn6cEUGKCV7TdD26OF0WEdqMAd8wJqnjxLKTCO09f2fAP8UxfcsK
         l8ZYpLkkeKbV2umICGuEKVNItgYaobkj4MeEkjS0PcGN+BQJlywOf4OU8U6bPnLNiaXT
         VXROUETcw+E2bzTPxoURZmuABQ0KGY2ky3hea2KVzXRP2elbRirKlX3kYuMKulun8Qvj
         j2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376179; x=1716980979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elnfGKAy/7+HbOAzxPXIpLPWv33SV0UOKZl7RY/LQJw=;
        b=vmeAfau6HkG67vdWqgKhq14yqz+l4JTZH7+FyTH1C6WRWIbPO6Z69rN/NLQvobwcvv
         eGKc138OkVEQwLhbmz2lae9VLyPajZwMHcEVmxGo81tgYK3PtTi22mSYKDUa+oCEypMx
         LEGMQTDdhsT1cOA+nMqzaORFSRcjCG3PlZH8Vc14yGNpRda7sxYrXO2hSfrYlG7ae101
         /zwpMORoHYOePM2kT5O2yc6M+sZL/rS0ZdXg5kNqI7I+dJL0uQyAPb1jHHceX/Sf+7ne
         vGAG7p+dTFOTc1c2ZiLd8FH3360brMzYIAvHjARmXTJyyz22AvHVd50clM8ZpK5wjimw
         7dqg==
X-Forwarded-Encrypted: i=1; AJvYcCVaAK46dm01vpgfHOK7OG4Z2WZcBStUDPB22N5r0B0eJJR0VHeA3NXgj/Jw/tA9mlNWz3F6VbPjJCDsLWo6zUwiJfYuXeqwXGib6vQd
X-Gm-Message-State: AOJu0YzxuWFBbwndhzLZv/vDY5AVZtSGFwMtYOM1USLMWRALGkhyIFC+
	Dfw4fYuvMnMpCDq14rLJV5cJ6gL46AmaDfXND94YMy8vOGMHbpPn
X-Google-Smtp-Source: AGHT+IG5tQeRGlxt/oRdOlFYhpnVzNioGNlffwhzkkax5fOOq3C8j9Se4HMxcOgcRXkkTvCYD9p7Gw==
X-Received: by 2002:a05:6870:781b:b0:24c:6198:5ff8 with SMTP id 586e51a60fabf-24c68a2a6c1mr2564180fac.4.1716376179526;
        Wed, 22 May 2024 04:09:39 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e283-0474-753d-295c-237e-167b.emome-ip6.hinet.net. [2001:b400:e283:474:753d:295c:237e:167b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm22223760b3a.169.2024.05.22.04.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:09:39 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V16 06/23] mmc: core: Add New function to re-factoring the code
Date: Wed, 22 May 2024 19:08:52 +0800
Message-Id: <20240522110909.10060-7-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522110909.10060-1-victorshihgli@gmail.com>
References: <20240522110909.10060-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Add __mmc_go_idle function to re-factoring mmc_go_idle function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/core/mmc_ops.c | 24 ++++++++++++++++--------
 drivers/mmc/core/mmc_ops.h |  1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 3b3adbddf664..5c8e62e8f331 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -144,10 +144,24 @@ int mmc_set_dsr(struct mmc_host *host)
 	return mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 }
 
+int __mmc_go_idle(struct mmc_host *host)
+{
+	struct mmc_command cmd = {};
+	int err;
+
+	cmd.opcode = MMC_GO_IDLE_STATE;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	mmc_delay(1);
+
+	return err;
+}
+
 int mmc_go_idle(struct mmc_host *host)
 {
 	int err;
-	struct mmc_command cmd = {};
 
 	/*
 	 * Non-SPI hosts need to prevent chipselect going active during
@@ -163,13 +177,7 @@ int mmc_go_idle(struct mmc_host *host)
 		mmc_delay(1);
 	}
 
-	cmd.opcode = MMC_GO_IDLE_STATE;
-	cmd.arg = 0;
-	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
-
-	err = mmc_wait_for_cmd(host, &cmd, 0);
-
-	mmc_delay(1);
+	err = __mmc_go_idle(host);
 
 	if (!mmc_host_is_spi(host)) {
 		mmc_set_chip_select(host, MMC_CS_DONTCARE);
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 92d4194c7893..3eaefe989c80 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -25,6 +25,7 @@ struct mmc_command;
 int mmc_select_card(struct mmc_card *card);
 int mmc_deselect_cards(struct mmc_host *host);
 int mmc_set_dsr(struct mmc_host *host);
+int __mmc_go_idle(struct mmc_host *host);
 int mmc_go_idle(struct mmc_host *host);
 int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_set_relative_addr(struct mmc_card *card);
-- 
2.25.1

