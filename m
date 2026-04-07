Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6357224B04;
	Tue,  7 Apr 2026 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526063; cv=none; b=HwNAJK88Y04hnBlb99U1QGnH8HtLLFJQKR3rSJEl1iDt5bCnzmSTHqeTLQKxDiDKIUsMH5s/mDfLt9l9JOLrUDFMP+4WIiQF9vB8ihC00ZVDzOsKuRJQ+maiY5JnW0PWMNxZvI40Bwr3cZllfhVqJETMuoCR/8n8tPEx3D+U6tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526063; c=relaxed/simple;
	bh=UKh6pj5AdMxjbMIdFIxpkHtNaISYhJ7QGVGUvatPUzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H8hUevygiuWR2horLUWi0QuJdCxbAPMq09WYTTuoTFBV5aqSul/OxlX5xK2wyyuyAlURIYxO8sqs//6vIjdiGSNZwiOUYlbGkV+fruvmA2AwcnlVGzeouecGlpyOesJnMkCOUgoGf75TqK3973mhS/pJTf0wgcZi8d/sjwUqVF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OWSi2ics; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OWSi2ics"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=K+
	NQ8DXMCLE22E6rvta2MJs0/mEjvtRhSz7t8Z521/8=; b=OWSi2icsBAX/f2EWON
	lFDP0AnioInUGCbrYp+rRvDq/nlkHCkzJhSGQXzsCpsRCiTi4YOiVDYnB5VvZyZk
	qaar/FOmLdrzk62G4zVTqhAGzWmMi09XnZxlnDG1XOU+gNJj3lPUfq9uBhwLijDJ
	6ZAWOqU3gdf6TZzIgfP7LM9ko=
Received: from Precision-7960.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHWrGWYNRp9L+JVA--.25039S2;
	Tue, 07 Apr 2026 09:40:41 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] mmc: Simplify with scoped for each OF child loop
Date: Tue,  7 Apr 2026 09:40:33 +0800
Message-Id: <20260407014033.1305033-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDHWrGWYNRp9L+JVA--.25039S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1kCr4fKw15Kry8WF18AFb_yoWkXrX_CF
	yrWasrArWrur93CrsIvr4fur90gFsF9wn5ur4ktay3J39Fvry5WFZ7Jr9xX345urZIkFW3
	GwsrAr4jqF4UGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_qjg5UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxnNcWnUYJnsWwAA3V

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/mmc/core/quirks.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c417ed34c057..93bf79d79cec 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -213,14 +213,9 @@ static const struct mmc_fixup __maybe_unused sdio_card_init_methods[] = {
 static inline bool mmc_fixup_of_compatible_match(struct mmc_card *card,
 						 const char *compatible)
 {
-	struct device_node *np;
-
-	for_each_child_of_node(mmc_dev(card->host)->of_node, np) {
-		if (of_device_is_compatible(np, compatible)) {
-			of_node_put(np);
+	for_each_child_of_node_scoped(mmc_dev(card->host)->of_node, np)
+		if (of_device_is_compatible(np, compatible))
 			return true;
-		}
-	}
 
 	return false;
 }

base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
prerequisite-patch-id: fcb16f319f35ddb88e1668bbe7a8811d88235672
-- 
2.34.1

