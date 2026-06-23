Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F86540D59E;
	Tue, 23 Jun 2026 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223333; cv=none; b=ZGHoaIgkE3Y92fVguvP/JWTta496LPPIUDVIsQ6rxNtEj7l+RIJ5F9YopMAQJA/DLJSsxrSUzAFcFD4lZasir7VuU3g1FPklt3/DffcMr+lqHqWfRCpctvaTo+aPKyLZtv/iobsgVzkOyJLcWSLpPJ7rLMAwMh3d/J6l0t5t2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223333; c=relaxed/simple;
	bh=MSNUg1Mm/0TRdBWZaA0kFzmKhZ6wBBZ7HpARXiOYRco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPoZgpqq3nQ22d+2SW7xnROo/CuD0c2vwGgsrFj/QwbHsIfPNDXDOYA1/LBC+yL11cVlhp1POMhyAySLGL7lt3tlgVZ6nmm/IOYn22hcIo1O0fKhsFThDhhWqgd1H/th8Tjzad06usq5zRLE9ja4ZvNMp7lLstZBDKb8/w/v1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowABHntHekTpqWFnYFA--.9103S2;
	Tue, 23 Jun 2026 22:02:06 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mmc: sdhci: return generic tuning failures
Date: Tue, 23 Jun 2026 22:02:06 +0800
Message-ID: <20260623140206.73221-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHntHekTpqWFnYFA--.9103S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrW3Xw45Cr18tw1xtFWUJwb_yoWkGrX_CF
	4rJ3s3Gr4vyr9xZw1kKFy3ZFWYkr9I9r1kXw48KFW5u3sYvr18G3ZavrZxJF1UWr9F9Fy3
	Cry2qr1IqrW7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU2Q6
	JUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

__sdhci_execute_tuning() returns tuning errors such as -ETIMEDOUT and
-EAGAIN. The generic sdhci_execute_tuning() path stores that value in
host->tuning_err, but keeps its public return variable at zero, so
callers see success even when generic tuning failed.

Return the generic tuning result while still preserving
host->tuning_err. This is intended as an RFC patch because some users
may rely on the historical fixed-clock fallback behavior.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e3bf901b1..a90e48383 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2967,7 +2967,8 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	sdhci_start_tuning(host);
 
-	host->tuning_err = __sdhci_execute_tuning(host, opcode);
+	err = __sdhci_execute_tuning(host, opcode);
+	host->tuning_err = err;
 
 	sdhci_end_tuning(host);
 out:
-- 
2.50.1 (Apple Git-155)

