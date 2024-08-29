Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5E18E039;
	Thu, 29 Aug 2024 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926561; cv=none; b=JaFZYZYCT7l5VVkYPVAZc2BwcLBRQY6fi2TtJBJC8Dq32MhhtGN/p1UzoqrqY1Gk4yFiSJW7myKesbuQWo9xORgsfm6YrPkipI6mruga5JPzY/fUqYvp7agvHCLSIrUukqlFeOom3K2se2InYxn0jHpCB1lU8STf2aXQbm0Ldlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926561; c=relaxed/simple;
	bh=PVrK0VFTJqByC3mUhmsQBu6v11LBo1c9OFvZ82I1WRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQ8vpXOiYRWgRDeKPLUwYriVtf/2KKLb7D62ztYQ8iDov/osGzETUfFy/nw4SIUV/f71cW2jA8Saq1wIUb5ht13/NgcDQefBAIIZTjZUZaFUWsm+VvtwYUGsyUMYnfgjFlEolAUO4xr+dd/KywXbHqKN8NxPjstAi5Z9nKbAHjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNEd+Iq0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNEd+Iq0"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-715e64ea7d1so343814b3a.0;
        Thu, 29 Aug 2024 03:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724926559; x=1725531359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TrpyIAEGDaFFQVVSFkXqSI/1a9uIARtI8iOYlGVZKw=;
        b=YNEd+Iq0O2EBfkVLJQcYgOcl8ucI6rUY4LrTtIF65+F+l+ipxkTAyyqItql4NhgpzK
         5wACLCGDgDv5hUJzxYWVciSch12X1WAvPfqFkiqG0mUZXe/jX7+zjdcPtsPzXfRsCwqn
         HQa8ScKv9uDgeBttzS2PC3E9V4ahi5BsEKss0ZlKgAdSWf2dsRiX/FSVxT0QU3oX7QD7
         f6aLe4ZiYTxhgvuWGRFkMALsxqpwHmRaNM1O3hupi1VjsWsjT9DsKJJDqYzry3a2F7mR
         8LWbMDrt8y/yf5NkyuH+DDtz8UZK5rDyPUB6Ki+G2tJq1VVD5CZVx7jQLS4xUxGHiEMt
         Upiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926559; x=1725531359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TrpyIAEGDaFFQVVSFkXqSI/1a9uIARtI8iOYlGVZKw=;
        b=CnqqlzT44lGLbg6MI0KFbxQx5ysTyL3F/8S3wP4i2YCNROkVBOBT5w1hLfHUddY9bq
         9r5kaxErr07bJ2NEqDF7+VVbV6pmXR5+GxEF0gAP2cf3ucE91CZC6Wkdy2lEr1neSmvO
         7j0yHDKFQPjdvvHhS1Ic+Se/XEDrE0sSsSF/dwPf94DGjaxfh/owLBJdaRPH5sv9Ree6
         8aEg6dgXXEbxUbgyWIFD+tyFk5JcLVBG+DWTTni9JdMQEnj5ilbPD72lxiez+Xbizl82
         LgymgAzdlaNdMnCIyRE1Kmn4T/+KhrZxZ61TttSbjboasSxsADRVn6lKjsXdeMIQZOBe
         fbZw==
X-Forwarded-Encrypted: i=1; AJvYcCVD+MkaWRsLW7rg6JTYK1CwngVjpvMXqpC4NiPTLh713s9keQboJXEq2sunI/UJPF/d0MXdW9nEBgmQ9c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNSIHcLFwxc7xRz1ZobiMiA8kZUOD16JwKHS2gDi7CL4JoPcDd
	G69OmB1iVl/enIJsCZSiPfgedwWaxJupln39sOmZYQNK5aE8P3Fe
X-Google-Smtp-Source: AGHT+IGyJihBrKdgZwhelzgbfjsiU8SrJ+xYOwcHoh6rvE2sIhvIJ+TMU0ZOiggqWUzo9S8bAhV87w==
X-Received: by 2002:a05:6a00:2d90:b0:70d:21d9:e2ae with SMTP id d2e1a72fcca58-715dfaed107mr2486982b3a.6.1724926559049;
        Thu, 29 Aug 2024 03:15:59 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:a52:632f:b914:4ddf:273])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d77eesm816577b3a.153.2024.08.29.03.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:15:58 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V19 03/22] mmc: core: Announce successful insertion of an SD UHS-II card
Date: Thu, 29 Aug 2024 18:15:20 +0800
Message-Id: <20240829101539.5058-4-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829101539.5058-1-victorshihgli@gmail.com>
References: <20240829101539.5058-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ulf Hansson <ulf.hansson@linaro.org>

To inform the users about SD UHS-II cards, let's extend the print at card
insertion with a "UHS-II" substring. Within this change, it seems
reasonable to convert from using "ultra high speed" into "UHS-I speed", for
the UHS-I type, as it should makes it more clear.

Note that, the new print for UHS-II cards doesn't include the actual
selected speed mode. Instead, this is going to be added from subsequent
change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Updates in V14:
 - Move mmc_card_uhs2() to include/linux/mmc/host.h, so that
   mmc_card_uhs2() can be available for host drivers.

Updates in V10:
 - Modify the commit message.

Updates in V7:
 - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A in
   mmc_card_uhs2 function.

Updates in V4:
 - Make mmc_card_uhs2() take struct mmc_host* as in-param.

---

 drivers/mmc/core/bus.c   | 4 +++-
 include/linux/mmc/host.h | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 6731b46e855f..f9a67beb68f0 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -344,7 +344,9 @@ int mmc_add_card(struct mmc_card *card)
 	if (mmc_card_hs(card))
 		speed_mode = "high speed ";
 	else if (mmc_card_uhs(card))
-		speed_mode = "ultra high speed ";
+		speed_mode = "UHS-I speed ";
+	else if (mmc_card_uhs2(card->host))
+		speed_mode = "UHS-II speed ";
 	else if	(mmc_card_ddr52(card))
 		speed_mode = "high speed DDR ";
 	else if (mmc_card_hs200(card))
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8c533503dcce..ca67b086684f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -637,6 +637,14 @@ static inline int mmc_card_uhs(struct mmc_card *card)
 		card->host->ios.timing <= MMC_TIMING_UHS_DDR50;
 }
 
+static inline bool mmc_card_uhs2(struct mmc_host *host)
+{
+	return host->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD;
+}
+
 void mmc_retune_timer_stop(struct mmc_host *host);
 
 static inline void mmc_retune_needed(struct mmc_host *host)
-- 
2.25.1

