Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED129824AA;
	Wed, 22 May 2024 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376189; cv=none; b=I240yZdG5Xoa0Tr5hPZhzc2j7/PXCAJaSwr+LAUfzM+a6D31jmB33YFK3C3EKsL+7ZD46NL78fxb4owHm4wOp+ohPSvPIVfm0k0CRJ8A3hNgd3LlIOI7kyAK1hRI8zEBVcxK5naXgncta32k1cfAApjzsqiO8XmMsS8mtNfEgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376189; c=relaxed/simple;
	bh=XbMppYWqei3ntHpC2M1bryFTRxP+I03U0NwuW06rk1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nHAU3nstgfqwk9ug0CZRwrejCI5RNEedOfYEc/+ABYfvBphQRLBhhHfyKYJ8+KRmCWASR5Zoo/9oZuuMmj6nkHcpQENqjx44Zd2ILRmAWVv5XaYT5A7kYN7KQ/Qerl5CkT5GcAfu8IjpQY+4aDLE8u7QdUsRg1FQT3K3Pd38bIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+crYTKW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+crYTKW"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f693fb0ad4so1636740b3a.1;
        Wed, 22 May 2024 04:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716376187; x=1716980987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jofDjvsJdQ6Rl2ylJznTQba/8DtZDqhiHl4osnY4Mo=;
        b=B+crYTKWvXrYNTIEVhXiRMRmYZY+8jmQBNOSyX9QKsReJbBkPpOqkEUWb8MIXi4P1H
         G9zmO5qvzf+EXTwNoFZmuOUknfSNxX81rm/CItXpXSiGS6BuDdIYaOu87hT7Qyn0yq7x
         veDOnxdLZL5Q8/IA/HiU/HMLy+ppUPG9z17Bzzfj0MrAxlCZzjL+lZYzzUy7InYWFX4J
         gsPz6BHJRBSRcGq7e661DUzCAzCagqfP2K6BHhWctkv6+VsmYeqdaWZpQ24enIR3HEiF
         5XXchsif73p17MKFQDZtINV/O5JnqIfI0kAulShujNrcbUtJ32LQZClsMAHVD/pzl2Ht
         BqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376187; x=1716980987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jofDjvsJdQ6Rl2ylJznTQba/8DtZDqhiHl4osnY4Mo=;
        b=ZD4hbJ8zryzkjXCy+G6/QjJliFl3zsZzwzAn5PpuwolfvsjyWvuOMPN2EqIO0UG3/m
         +jcvw9kDfyavVFp2FvAou4JGxWy1jYloU7Id6Nm2XfowNBmuOsw+3Xm7L9f1ovvFgFJ+
         srHnBDG83/6cwRgPYRYDisEIE4PYsqXha5C70c/bVkaAKTAyyYl11BayJTdyDX2VePeK
         e5Co0/wrKxoLGTbywiudovbgRKEs893mHMRThm4DVJw0o+6rpyWY//xiyIjulm1o6b7Z
         jHet8GYCTGVhXb7ypahmtakXqoDyezEw3E4AUlCzUzR+3ylrufHb4YpLvKA5uFyGI1U2
         Ahgw==
X-Forwarded-Encrypted: i=1; AJvYcCU1Wbr0U3g0Mq0evmh8n5GpKPgq8ZQ1ITeLDG881iwx3s3WXS/io+6V7c9iQYA0LL626vPClg6++DBCjqNdjVEWFAd/PTgG0tcJhlgB
X-Gm-Message-State: AOJu0Yw5y9k4fUZS9p5/ujqCIFYl60+F/FO5dBHEvCxxYa18RGRaoV9p
	jhckqvdPjPYhS547YGzfXMhazmnTBhM1u6xkXrsFnap6Dcgx6IP/
X-Google-Smtp-Source: AGHT+IHnZMcvHklNi6zJw0GRC85ydccrjO9ehSXHsWJ4IPGTKLs5jTONNLSQstlXBBFeLsDpxZRWgw==
X-Received: by 2002:a05:6a00:4608:b0:6e6:5396:ce43 with SMTP id d2e1a72fcca58-6f6d5ffc55cmr1696757b3a.7.1716376187288;
        Wed, 22 May 2024 04:09:47 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e283-0474-753d-295c-237e-167b.emome-ip6.hinet.net. [2001:b400:e283:474:753d:295c:237e:167b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm22223760b3a.169.2024.05.22.04.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:09:46 -0700 (PDT)
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
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V16 08/23] mmc: core: Support UHS-II Auto Command Error Recovery
Date: Wed, 22 May 2024 19:08:54 +0800
Message-Id: <20240522110909.10060-9-victorshihgli@gmail.com>
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

Add UHS-II Auto Command Error Recovery functionality
into the MMC request processing flow.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V16:
 - Separate the Error Recovery mechanism from patch#7 to patch#8.

---

 drivers/mmc/core/core.c    |  4 ++
 drivers/mmc/core/core.h    |  1 +
 drivers/mmc/core/sd_uhs2.c | 80 ++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h   |  6 +++
 4 files changed, 91 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 68496c51a521..18642afc405f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -403,6 +403,10 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 	while (1) {
 		wait_for_completion(&mrq->completion);
 
+		if (host->ops->get_cd(host))
+			if (mrq->cmd->error || (mrq->data && mrq->data->error))
+				mmc_sd_uhs2_error_recovery(host, mrq);
+
 		cmd = mrq->cmd;
 
 		if (!cmd->error || !cmd->retries ||
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 920323faa834..259d47c8bb19 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -82,6 +82,7 @@ int mmc_attach_mmc(struct mmc_host *host);
 int mmc_attach_sd(struct mmc_host *host);
 int mmc_attach_sdio(struct mmc_host *host);
 int mmc_attach_sd_uhs2(struct mmc_host *host);
+void mmc_sd_uhs2_error_recovery(struct mmc_host *mmc, struct mmc_request *mrq);
 
 /* Module parameters */
 extern bool use_spi_crc;
diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
index 85939a2582dc..d5acb4e6ccac 100644
--- a/drivers/mmc/core/sd_uhs2.c
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -1324,3 +1324,83 @@ int mmc_attach_sd_uhs2(struct mmc_host *host)
 
 	return err;
 }
+
+static void sd_uhs2_abort_trans(struct mmc_host *mmc)
+{
+	struct mmc_request mrq = {};
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	int err;
+
+	mrq.cmd = &cmd;
+	mmc->ongoing_mrq = &mrq;
+
+	uhs2_cmd.header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD |
+			  mmc->card->uhs2_config.node_id;
+	uhs2_cmd.arg = ((UHS2_DEV_CMD_TRANS_ABORT & 0xFF) << 8) |
+			UHS2_NATIVE_CMD_WRITE |
+			(UHS2_DEV_CMD_TRANS_ABORT >> 8);
+
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
+	err = mmc_wait_for_cmd(mmc, &cmd, 0);
+
+	if (err)
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(mmc), __func__, err);
+}
+
+static void sd_uhs2_abort_status_read(struct mmc_host *mmc)
+{
+	struct mmc_request mrq = {};
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	int err;
+
+	mrq.cmd = &cmd;
+	mmc->ongoing_mrq = &mrq;
+
+	uhs2_cmd.header = UHS2_NATIVE_PACKET |
+			  UHS2_PACKET_TYPE_CCMD |
+			  mmc->card->uhs2_config.node_id;
+	uhs2_cmd.arg = ((UHS2_DEV_STATUS_REG & 0xFF) << 8) |
+			UHS2_NATIVE_CMD_READ |
+			UHS2_NATIVE_CMD_PLEN_4B |
+			(UHS2_DEV_STATUS_REG >> 8);
+
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
+	err = mmc_wait_for_cmd(mmc, &cmd, 0);
+
+	if (err)
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(mmc), __func__, err);
+}
+
+void mmc_sd_uhs2_error_recovery(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	mmc->ops->uhs2_reset_cmd_data(mmc);
+
+	if (mrq->data) {
+		if (mrq->data->error && mmc_card_uhs2(mmc)) {
+			if (mrq->cmd) {
+				switch (mrq->cmd->error) {
+				case ETIMEDOUT:
+				case EILSEQ:
+				case EIO:
+					sd_uhs2_abort_trans(mmc);
+					sd_uhs2_abort_status_read(mmc);
+					break;
+				default:
+					break;
+				}
+			}
+		}
+	} else {
+		if (mrq->cmd) {
+			switch (mrq->cmd->error) {
+			case ETIMEDOUT:
+				sd_uhs2_abort_trans(mmc);
+				break;
+			}
+		}
+	}
+}
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index fc9520b3bfa4..c914a58f7e1e 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -271,6 +271,12 @@ struct mmc_host_ops {
 	 * negative errno in case of a failure or zero for success.
 	 */
 	int	(*uhs2_control)(struct mmc_host *host, enum sd_uhs2_operation op);
+
+	/*
+	 * The uhs2_reset_cmd_data callback is used to excute reset
+	 * when a auto command error occurs.
+	 */
+	void 	(*uhs2_reset_cmd_data)(struct mmc_host *host);
 };
 
 struct mmc_cqe_ops {
-- 
2.25.1

