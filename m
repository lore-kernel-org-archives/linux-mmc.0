Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50574D8A7;
	Wed, 30 Oct 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287346; cv=none; b=Npn7Cl3J/LW4B8MkVxjswgIQRIGoKuNt6J2XbD4lmh8/2WzMqSt+MHrxxkQ5TN9+64XIYCsg7x9Rfg+E4P2GNafDLYyNvq/mo/iX21sMzEV7fIe6goxDHN3GwbiG0UV+8bq9CUGkEzHyfuCAvEzsZuVX7DLivA8bH2kic6la2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287346; c=relaxed/simple;
	bh=HoPTHRsvBBB1nq5o9cSeg9KcXnBlUyJAWr01EkE8o9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m34si2kOwCm5bXn4LvxxL/BewSUUn/yceg5+eSYCpUJBPnb39zLwx+BDT8ryIcNRH35PIoPn4fksrDgoAR9Crr3gFhDF8lBHgkdbntCwOAe4rPBX1dkqUHafZhO1iw9iKO0iK5D/h3NPrLwAr43e0jtcKS79XpvAUoJYSZtL04c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2UPjlrD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2UPjlrD"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c714cd9c8so68468345ad.0;
        Wed, 30 Oct 2024 04:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730287344; x=1730892144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yynQzzzxVGBp2IeLk/YFaZitZpg8+Akn63eN9G7YdBY=;
        b=H2UPjlrDnSl80tFp7l7JohD7rghUCbNWoN97tTLLqxOdur+xfHt9V08gVOfx/5neeP
         ROOpapziVRy8dw7c+Aj1eElxykvSjC7SvqPDA3Qznp+UatAv5Agy5SH6iTu+eCfZcAmT
         4G4xa2Ojs9ku5rDUQ4e9cHRJgIcsdvI39IYW8MBjn5cMWQ6a3bs+5yLFqbRvFVtsbJjb
         P8BwA9fC5RZ5Ou8urSISv8En0n9hH2bqcNVAZ1Qi+HZhsVPC2NuSnlR7ElmHP1WxqVu9
         S+LZFLnRofnkDqGPv3hQWxS7IGlRRK7EnDJzrHhqoFbySLjGDtRB5ZdRYimC/g5v7rwN
         2llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287344; x=1730892144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yynQzzzxVGBp2IeLk/YFaZitZpg8+Akn63eN9G7YdBY=;
        b=N3L8vI1iKH5PO8MnyZm2lKsSZ3r42ACzmvyZiWZjStGNP38wOoSN2cZUSC4qbhk4/f
         UErBi7nlBXb1oE1EtlouX1w0iuHQsFNMRV7YGpugqOAn1kXNXHzzH8/au/w8wCo5WmRo
         PLVfOQTXgMopOijJBWAM+7j6tdmDMBzJwHA9+txEt2xCTElVIbOoqyP4hjXvBmDJtxx3
         F1D7T0cqxIa/U4iZP2uitgHnXXxl6siLFhzj+0MVqIuJK+y2YZ7Q9rECR2V4eWfwFHzg
         agikzz6H4KkAB/hzNHFrRujForY3ZMYoC0B8v435w+RyBKVg62XUgiX1r1PaZlnsF32a
         MU9A==
X-Forwarded-Encrypted: i=1; AJvYcCV1E3LuAXpjxigNVBPNRT5y6d8refjwAUvanDGtdzokW+W+IHy0mSwb/mG7ve/ubKPYscXkPYSl2MsyiLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNv+KWV09rMUf0RJZKqGdqDmB9pedMunvjjMGq2RpCxCmahrbs
	ykgrdDgpWHEZlSUz2YHo7IAz4FAvyjXjG8/dsjhs1sV0b5iBrFPj
X-Google-Smtp-Source: AGHT+IF9HDpYcagHO0Qc0OTCwTWawP7GLOQI2jjr2BWAzZ68sJqZghM16DpU8UB4swTH8MNDE+zmeg==
X-Received: by 2002:a17:903:230e:b0:202:13ca:d73e with SMTP id d9443c01a7336-210c69edb0fmr226669965ad.28.1730287343809;
        Wed, 30 Oct 2024 04:22:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:469:ce01:7b68:43c3:e54e:a61f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fabf82asm1402645a91.51.2024.10.30.04.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:22:23 -0700 (PDT)
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
Subject: [PATCH V1] mmc: sdhci-uhs2: correction of incorrect type in argument
Date: Wed, 30 Oct 2024 19:22:15 +0800
Message-Id: <20241030112216.4057-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

There is a type issue in the argument in the __sdhci_uhs2_send_command()
that will generate a warning when building the kernel.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410260525.ZUuPhMJz-lkp@intel.com/
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 43820eb5a7ea..7f41ca67b069 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -649,7 +649,8 @@ static void __sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_comman
 	 * MSB when preparing config read/write commands.
 	 */
 	for (j = 0; j < cmd->uhs2_cmd->payload_len / sizeof(u32); j++) {
-		sdhci_writel(host, *(cmd->uhs2_cmd->payload + j), SDHCI_UHS2_CMD_PACKET + i);
+		sdhci_writel(host, *(__force u32 *)(cmd->uhs2_cmd->payload + j),
+			     SDHCI_UHS2_CMD_PACKET + i);
 		i += 4;
 	}
 
-- 
2.25.1

