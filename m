Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C621AB8EF;
	Thu, 20 Jun 2024 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880317; cv=none; b=XQh3UuV4hu5xj3CpvV+UswCZv6Mb+9wsJimtzgbyvUDbsDMbXnE2e30RyiKWNNmE8lVwq50t5NWpxAEU5OpjdpBn+8e90sqFlHv3kJyclJ1RFEhKY0O1NO305jwjJjZmL/VpiAOG8tkUmoto+OuRBrVcwps0MzLV1yoCMHIRweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880317; c=relaxed/simple;
	bh=urHhvNgFjlJC0RUvDI1zmMHs1AZTnco7V3JoqsJKmGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOuZzuqsxdwlLjx/nx+nAhAT4xYhCou5kJVfxud4yDNywdaVDjyX9bJTS5v8atyQu+AK7Q2rcpxKNMy9mtHQZKBR7CvcKiIeLU1S+CwfPO8cbgj8JwrzHIw1PdKZtFpPyywkTedxOqa4dVSUo1UwWLQoeLfu6rH3ULI8PEIdTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KE2Tqqiy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KE2Tqqiy"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f4c7b022f8so6377925ad.1;
        Thu, 20 Jun 2024 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718880316; x=1719485116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elnfGKAy/7+HbOAzxPXIpLPWv33SV0UOKZl7RY/LQJw=;
        b=KE2TqqiymJXNQqcEe82p283LGwwY9Xd3xaD6mmw94Ia4dP8X4lGP00DDzU6bvx8D5E
         FGGyH6SWPdEOSSr0niq7tRa1Gy7jE7bDLqaXZqbEIetPnysyRill8nCN+isiR8IiQyII
         yr1aoq3K28vail213U/vB+dzwkwcwm2aZpuDTlAIVAb0gBUlnH1lvDX4bUNH8Y3wHJ3z
         T7xCFwJSvIjCglVtxwP75eOR8QxEMEpF/6aRJWpkma2idzDRGZDbwRNGgOocEb0G89Um
         tLU7UHS10I/DW+YiAu3bsUem5B0xzZEE9j/sIM8TSpYcrjqupW8l38tk+JQTI6zDpV8G
         iXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880316; x=1719485116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elnfGKAy/7+HbOAzxPXIpLPWv33SV0UOKZl7RY/LQJw=;
        b=Iu9i9iRoTKfH0s3+ZhZPx4KrGB3esVIQeo4kcVfPccR/OhQC8Z6jvRNJ7+jJgp17RL
         MTV2Fc70+npYMqhYAemeHHGsl6OFs0QAm5vUZTx1DJZtmoF3Xgs6IkBy/uVf7NHQM5Wi
         uO8pmnAygGN10t129TiaA/TaNZ/3aydeye9M7R4R7hsv1HL+HpGL1VgU7pZAlKXsg30t
         cuO/dsZbNWWtDRhy1VTfDHpL0OINHkAAxXPgU8RmKynE5tALn2dI64SOv6bxsRmlhFeW
         vAmIgCQemZX0wN3vtHLLMbPOjoiEQrCrXoC3r+yT6nst0YPJb0v8ggRWpilxgoQk9H1H
         uCPw==
X-Forwarded-Encrypted: i=1; AJvYcCX+hlaAY/VtpSdtkRPFiMaQ9MtgmGla8DxKR8EpRhVb/dUUsu0S8cBIkXhugJXTdwPg+hG3denZQpWpMjUqb36u1mf6OfGTaZV/HMNA
X-Gm-Message-State: AOJu0YxBnidPDbYMTGCxPKnwATazxdGZU+5QY7O/DWhq5EuMUNDEIMxU
	q8CFuvenMl6r0AOUmZiYgMlKSOICzRNY7dnOfBpGryXLI/jQl9iX
X-Google-Smtp-Source: AGHT+IFuoA8zeC88yZWgZQO2lVmNvX+7VJo+JUzABY3BLyDi+V/KKQneuaxrJXVpYYsfgAaFWu6MVg==
X-Received: by 2002:a17:902:d4c3:b0:1f7:174e:354d with SMTP id d9443c01a7336-1f9aa4632b3mr60674945ad.48.1718880315721;
        Thu, 20 Jun 2024 03:45:15 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e28a-abbc-b19b-27f2-8368-202e.emome-ip6.hinet.net. [2001:b400:e28a:abbc:b19b:27f2:8368:202e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55ca1sm134007805ad.49.2024.06.20.03.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:45:15 -0700 (PDT)
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
Subject: [PATCH V17 06/22] mmc: core: Add New function to re-factoring the code
Date: Thu, 20 Jun 2024 18:44:28 +0800
Message-Id: <20240620104444.5862-7-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620104444.5862-1-victorshihgli@gmail.com>
References: <20240620104444.5862-1-victorshihgli@gmail.com>
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

