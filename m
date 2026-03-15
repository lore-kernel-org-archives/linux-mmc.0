Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F68371878
	for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595519; cv=none; b=DDzc0tBnknJdqPEk/Eg0DbKoyrgQ5xXldZ2PyTvDSaCUkKSPW+TIYdJs+PXe02Cp2SfwzBxQ5o8Fvh3Zy/yEi5W2yAmTmIq5nA54COvmINrorkT+s3LvYlRqLjp9A3lDjsKZlua3vwreDX2J8iKw5VI1FmJNEN+JJNLXs9V3qzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595519; c=relaxed/simple;
	bh=xR1aQtJyjOGsb3F8bKi8GxD9ZWQvMlCBKAMwTQealv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNdakRhuLtcEAeEbARP7xP5kscXDle2mqT1AZClif6SGt1sEs32fbO0eNh7iw+shLPQwLjNcwP5XMauWQO10AuLNkaDb+DnXHAe+3tTS3PYceBPwihBBsdsPUutVJFHmLDGRrk6X+W1+g/t47aNUT1ksqlbOCRQfxBpan+PS+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrTq3SzD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrTq3SzD"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so3458081f8f.1
        for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595516; x=1774200316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eNrBLnJJHbmPI7WkNJ6vq9A1HMj64DfR2iaRW7E89k=;
        b=DrTq3SzDwgDX0a37RPo6o/lql3oPGAHO2S+yv8kxsp3a6YtYN75Qt4fbVaKpwslDg7
         XGsRTLLBEDbauK8VtRwI19GKKIXr7AEqg0rH0xGIrvLQlgeoH9An9p4PPWi/+1E+NW2w
         NEeBbitW+XIQYxmMZXuZVaJHfZpqwlGf5ug5hWJ205vFrXLIj/SzNOTwIbvYE3z7jccj
         6X45KrVmz9wR1it9QgWo0tzDreXyPaiTcxwYwyUVNbZvs5VhRLcbXLk22emHCdCv4QeB
         s96r9tNhj9S0pMTsijrsq6ZvkTAukUjV5L5R6PLDOSCek9THJr/L2hRqJdyhg8CPwrGB
         80ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595516; x=1774200316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2eNrBLnJJHbmPI7WkNJ6vq9A1HMj64DfR2iaRW7E89k=;
        b=c/Vu6aNTU3w1ZmnVUmyop9rDe1epztnOgmQW4B168wNU9/GolVSBFL/vGZP60ulEOq
         p/d2ZbGYOaWLnoV6gG/atyXMfk3iAmOku+x5xdGJY62HrQM6mQtVRhS+Q9Oa5FJBeEYx
         MfD6Rg75NA03XgioxWRk9nJ8MsDIgTCYf+d1aykupg4myk24TguF7s6TF5HhWtafqIpH
         EZXjqJ3gig5P8+Bk7mJZMgD8zlFs6/GvA4qIKNUaXekH2MAYlxjNhrpiWXaQprnc4/4c
         k1I3y1A48rXa1XzWpzZN2EqZElK4vPLpAMBnPY/QTQ6JP7wHpr+dEc5shbW3DVUrfxee
         Ceaw==
X-Forwarded-Encrypted: i=1; AJvYcCV/AnCQDfeL0N4MhGBVG2P8f0uJqOjvlI7EQdmGSyoSdp4G444G7M9FsMDho9PUvVcCrwnuNF7wuG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzloM2YQUX/6IcsVhtvx02SbH6E9+peGOEilRhfpfxBsft1cUyE
	yBV4rUxAbTD5OUF2hUBb0BLNK3N/kN3Q5MzXWntm0asChZfh8jpu+uyy
X-Gm-Gg: ATEYQzwnw+cFxurBEDezF5C21roxClIud8+qiJMWbJOZwbvyEoAtbdhjuwqLaucMTDH
	VdijAzX2foEfo6N2JKF+aelPmSSlPsH8yB2EEG1CXeWlkqBHh+PELFMjxDG6I8nL1DCR6dmgYpE
	0idPcmomb6Sz36ttm3wmwjQMsNi9uuMBWK+iTZfZCWaQf/RNsnOk4vpUX8J3+gOhqIvH7Qh9om+
	R4FLfbxx3yABDjyy8UZNJ6OHmsBtzhebs6q6SsH/lzNKgF+07LVaVnNe0HWwO496hcibK1rqXMF
	cC0GyWolsy2PRIH30KOS14EqRpGENP2M+8mew9Ydw2Bpxv4D+OWXVizjtNYzt0kbVJeN8ES6hZy
	3rMeLia08vx8aPBPfdPMFxlrG6JJcinjjoCl1iK6qvNTBSDuG8sD+F6Zge+/uL2zgxQaXPJi2Q0
	4206rRKm4XgBHa+jaIS2UcUricKXkaX1EC/pQ=
X-Received: by 2002:a05:600c:8b28:b0:485:3c11:de84 with SMTP id 5b1f17b1804b1-48555b47ac7mr165571005e9.14.1773595515543;
        Sun, 15 Mar 2026 10:25:15 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73easm457168325e9.3.2026.03.15.10.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:25:15 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>,
	Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 1/3] wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity
Date: Sun, 15 Mar 2026 18:25:05 +0100
Message-ID: <20260315172507.270480-2-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315172507.270480-1-adriangarciacasado42@gmail.com>
References: <20260315172507.270480-1-adriangarciacasado42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a balanced RSS queue distribution by skipping CPU0 for
high-rate MSI-X interrupts when multiple CPUs are online. This reduces
contention with system housekeeping tasks on the boot core and improves
overall throughput.

Signed-off-by: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 4560d92d7..87149f29e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -1683,7 +1683,17 @@ static void iwl_pcie_irq_set_affinity(struct iwl_trans *trans,
 		 * Get the cpu prior to the place to search
 		 * (i.e. return will be > i - 1).
 		 */
+		/*
+		 * Balanced distribution: skip CPU0 for high-rate RSS queues
+		 * to avoid contention with system housekeeping.
+		 */
 		cpu = cpumask_next(i - offset, cpu_online_mask);
+		if (cpu >= nr_cpu_ids)
+			cpu = cpumask_first(cpu_online_mask);
+
+		if (cpu == 0 && num_online_cpus() > 1)
+			cpu = cpumask_next(0, cpu_online_mask);
+
 		cpumask_set_cpu(cpu, &trans_pcie->affinity_mask[i]);
 		ret = irq_set_affinity_hint(trans_pcie->msix_entries[i].vector,
 					    &trans_pcie->affinity_mask[i]);
-- 
2.47.3

