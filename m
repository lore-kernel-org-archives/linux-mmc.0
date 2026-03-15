Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DCF376467
	for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595025; cv=none; b=tUHOqpJnRvlGqer36JQLyXkq2cFtQv4h7xObjmDGzbu11BMOfX6wAgK3bfmMXzapO6DVOVV4Y7grnukItAUAYsJbIcPcQfdASYDXUBt+Qf2DA6QJ2qpe4/pvrC9fq9uh6xH+phv7BEZrI7L3a5nxwq6Q32e1e614E1MpG2FV/cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595025; c=relaxed/simple;
	bh=xR1aQtJyjOGsb3F8bKi8GxD9ZWQvMlCBKAMwTQealv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIIppemsr0YoF+akEeZzsNrHWPsenBG2FTQ58/saxUVr777knU0YZF0FLBbsPjxmJRoyOJqPjQTScpcjGDoQVBz/Q4T36m0bTVjzVWr+Pq2iSmsggFJ0QbJrcphzcaOQB7X6gWqOVCjO2qZlftKnDUUXk9VLTLqhvAYHAtDAUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGDd2s0M; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGDd2s0M"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b2965d4bso2615569f8f.2
        for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595022; x=1774199822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eNrBLnJJHbmPI7WkNJ6vq9A1HMj64DfR2iaRW7E89k=;
        b=LGDd2s0MRWWVzXiLUlhscGY31hZPYrH4KObYvbpf2p9Ur+gOzA6ep5+r+WLKV8QH9/
         +/4S8qNW/piz9OVtsNFhHEK+QQNbGl7USWoD43ej62kuooI1hxOWuwzxxVphv4bNfxHQ
         lXO4IOJsrITQRmID1rAQyjekPiuqPqSvwc5T4DDj6fRl9Xtzu1hn1XkIPKQ+mg0l1olG
         beUUL3G+Tx4LMx1AcTr9YqTznBOAY1nZOpvJ4bwqjGLTvaS4eftDMgtwuDsQsNNh5R5s
         iMDqrGuK+zeWy65nDQLF/OuD9rYse0Giq148n9HjONRPABWI8T8LuwY+JGv5+WGrL3Zr
         RUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595022; x=1774199822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2eNrBLnJJHbmPI7WkNJ6vq9A1HMj64DfR2iaRW7E89k=;
        b=ZGsixi7J29cJROzQgrYztF59sCGdAgXMmFP/OiqLkf8z0ocCyZfhgkzK/W0HqygFJA
         ZzKYFj4lhghzXsufTp+/UOIMt3Ah1WCi/MEhZTRfISO0Zf8H7Q6fZih4ff0UvBKZUVZB
         In1/zghnByDejoXbW5mqHWUaKBcbU0MRNnqzV7mjHvL5+2VxbgMRed4LUQTAkh8Xl4PU
         sN0XNYoXSCMG8AzwAkkBvSxLbtD569nopumRJ8maGKuaPLSGwA9VkwmgIdYnVlPdUsW2
         YrffLFQ3pqA6FsSfBqiZRCejMFL9hnO462iY2XSdYr4aRWNv69VYum5uq6XracYcv9Sg
         9d9A==
X-Forwarded-Encrypted: i=1; AJvYcCWPLGx89NEFR6zsurTv5dhTDAb823GUrK4PdnM21lmJ7mUD9s8eZvUdsiyaoZDDwRy4hEletnbLsBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFjSb0z2+DEwB/4dwR36J73yXPz7jiflJqLznOMadvZmSuc27+
	xOzIUK0zRIQUoaESNgwOa0tLz9HEeri7bO7inQZHrgVdX3hZHywmkaSn
X-Gm-Gg: ATEYQzxJQmbYIvia78GRKvy6PueWzpRfYErimOhQwR4BuNVV0f4U+fSss5bsfYSiZEA
	6ZA20/k7lwbpIrirNIRa1pPxf9hBVgo1ei0OxL3gABQFB6lVuFtTjm8uVJoJkY1N/NwKvvT60dy
	YIq6hiyC3Od/QjKQTSgS5eC+Pa8xuCNdIRU615RHFNFUNUQyWQlG8KFcr3lEnKYVQsHEaTma/5l
	ZLhs1WJnSbE6lTem9QDOkrdmnkD/c9ZXgS1dhrdh4s9MEkHR0FJui5GrBEcME7fQD5wTWIREMNz
	nhHZjZT3CH2PINHiRHk2DnpeEAcmbuVl0fr4l72WF+IsN5ENGMO9KtkPYAsau3NGX4gU8Yp78yw
	ZPt4QkQjfa8Dwn4oIrHe6drmsU6PUSFsQsYuTdpPqRHJXtzrCwgjdikfZgWs/V/lxo0lis/4wWQ
	rpXUZOiTQkiEqWBjbqBhpI6GHUmf02c2wr7Q==
X-Received: by 2002:a5d:5849:0:b0:439:af0e:57a8 with SMTP id ffacd0b85a97d-43a04db7edfmr19896954f8f.33.1773595022342;
        Sun, 15 Mar 2026 10:17:02 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe21b631sm40536429f8f.27.2026.03.15.10.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:17:01 -0700 (PDT)
From: Adrian Garcia Cicuelo <adriangarciacasado42@gmail.com>
X-Google-Original-From: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
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
	Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 3/3] wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity
Date: Sun, 15 Mar 2026 18:16:52 +0100
Message-ID: <20260315171652.269020-4-adriangarciacicuelo@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315171652.269020-1-adriangarciacicuelo@gmail.com>
References: <20260315171652.269020-1-adriangarciacicuelo@gmail.com>
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

