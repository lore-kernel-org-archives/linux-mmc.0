Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3B81E47DA;
	Wed, 30 Oct 2024 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287350; cv=none; b=Y8jRDJkKdLjcMloRzAm1nLrYw/ErziNW/Y2XRf+Zud+8f525Y1F4jU+usOqj6Oih8bbRExWNfpeRKaFyL6YARjHC71VPddDj9H3P7lo67KoitrIhQtGedJhFy46ctzyJ4eR8SFDyE2brT0JApSL8LNpGLLpUUrX8KAs+is83ERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287350; c=relaxed/simple;
	bh=n2iplPjm9XVyYu/bIZQ3GFCLf5aplGAXKvE3gH9GFeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JxdTvuWiaKlc9AfVwjYjlrOHc9eR5ok7rjF9SH1lgsPTGk0FZvahyKRVnA9EV6C7AlppZg0cBlUl9ORl9qfjOmEIsikLjjzqnlZcQw2R5dAWJsGV9N8HQjZ9oJXt/Z5yZA+Xdckdj7xiFPDlqNPVoyW3X0Eb7YLLqWQMQepLJng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7PcodcQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7PcodcQ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e3fca72a41so5255940a91.1;
        Wed, 30 Oct 2024 04:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730287347; x=1730892147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab4y9BHGnfTk1McHTPviZagt9jXM/NpQRi2KPJuE/1c=;
        b=j7PcodcQNTk4Cv/ynSIdyIVRkkUmHXTfS4VHyJwndsTry7qDIJkQhPZiSCh5xAgLwO
         zphRbs4HoVjhjj+U4neXGW1/vx/bD3OLr7gw5zrbB2Pz9/LpdTRTyE0OtXAMB8MuDc0D
         +BAeJKX7MKlU5D1PQI5AUek7Dq7C+/b5gkZFeAolDI2qnvoQBe3IqBMHQE0iFGcpd88P
         6lu0U79PH6A2M0IzSmP52upVdXZoMd8LUXGI6aHETfhj9bjjm7UqqzmGjammY12Kz5gm
         XFexwwE5pLBL2OQlFRNH3zF3W46gsL13XrhcQAhAfMBxagWedJ68mpspFtJL0pI9GRa5
         X8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287347; x=1730892147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab4y9BHGnfTk1McHTPviZagt9jXM/NpQRi2KPJuE/1c=;
        b=dx90A91qd8cjJrX3C9OtM5FSSrmggVcaYTN2tJCFvn/B5Yv8XLw7cNx0vXA5l7Uxkn
         chL9hHWNQKD5Fbv8B4sz9t5ZsIN3TwTaEsY/cbDxt6XASRKCgRCjRr0rt81J5Q/RGGWn
         079Lg9rsiAiuj789a2zlLQAmDSzKfrbdgKoLaYwM+Rbv45I2352he+zRgIoEaNjZNAkw
         3HiAcEiOkNg3PUzirGOzoqFbu7MKBZVtC+nC8rXnUlq0opAYzViiZ55XqipARTjTeWBg
         g3W0KvFlKhoMc4Su2Kqm0QxhvL5Xd6Si3569dqhpW/IZ9yJ88t5hmA//rZdXuS19E9GU
         gpEw==
X-Forwarded-Encrypted: i=1; AJvYcCXd2s1NjJDrqfwDH7gyTz+CMLARZJ7uv3O6NHaW9U8mK0perUFrKbu75/+l5JPa4lCsMXGAR2WN4v+lWoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfl9Ohs9n8CRz9mOjNdv5FCsJU65gkKWx6ELaoUdTX+wCmzR3U
	qI01OPvZ2fZRxeRHS5ZiZtLob92ivOAmdEK/j3PK9rl7d8LYen+C
X-Google-Smtp-Source: AGHT+IG4PXReU9WyKwrfpIjaiKmpV1277h3IlOtoWfo5yG76wSqpq2MHWZGZKS6nYhj86qw9Z2yerQ==
X-Received: by 2002:a17:90a:600e:b0:2d8:840b:9654 with SMTP id 98e67ed59e1d1-2e8f11b96e9mr16972752a91.34.1730287347257;
        Wed, 30 Oct 2024 04:22:27 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:469:ce01:7b68:43c3:e54e:a61f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fabf82asm1402645a91.51.2024.10.30.04.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:22:27 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V1] mmc: sdhci-uhs2: remove unnecessary variables
Date: Wed, 30 Oct 2024 19:22:16 +0800
Message-Id: <20241030112216.4057-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030112216.4057-1-victorshihgli@gmail.com>
References: <20241030112216.4057-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

There are unnecessary variables in the sdhci_uhs2_send_command()
that will generate a warning when building the kernel.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410252107.y9EgrTbA-lkp@intel.com/
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index c488c6d56015..43820eb5a7ea 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -684,7 +684,6 @@ static void __sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_comman
 
 static bool sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
-	int flags;
 	u32 mask;
 	unsigned long timeout;
 
@@ -714,30 +713,6 @@ static bool sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_command
 
 	sdhci_uhs2_set_transfer_mode(host, cmd);
 
-	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
-		WARN_ONCE(1, "Unsupported response type!\n");
-		/*
-		 * This does not happen in practice because 136-bit response
-		 * commands never have busy waiting, so rather than complicate
-		 * the error path, just remove busy waiting and continue.
-		 */
-		cmd->flags &= ~MMC_RSP_BUSY;
-	}
-
-	if (!(cmd->flags & MMC_RSP_PRESENT))
-		flags = SDHCI_CMD_RESP_NONE;
-	else if (cmd->flags & MMC_RSP_136)
-		flags = SDHCI_CMD_RESP_LONG;
-	else if (cmd->flags & MMC_RSP_BUSY)
-		flags = SDHCI_CMD_RESP_SHORT_BUSY;
-	else
-		flags = SDHCI_CMD_RESP_SHORT;
-
-	if (cmd->flags & MMC_RSP_CRC)
-		flags |= SDHCI_CMD_CRC;
-	if (cmd->flags & MMC_RSP_OPCODE)
-		flags |= SDHCI_CMD_INDEX;
-
 	timeout = jiffies;
 	if (host->data_timeout)
 		timeout += nsecs_to_jiffies(host->data_timeout);
-- 
2.25.1

