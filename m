Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEED240F729
	for <linux-mmc@vger.kernel.org>; Mon,  3 Aug 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764922; cv=none; b=Yvbc5Z/KiMROdJwv5wmOd5kk1XJLYb6xV9hyEA6tifpRM8KZNhNaK1RTvEX4fdW0crKjKq6F4XenUcI1XX091/PXyVKpfyEhhFda1uPOvEQ04zd/Ro8QgHHQa9ZlbLCirVGXaiGfVBPWpEwVd5jq4WveuMhKRP2kktgVA++c4+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764922; c=relaxed/simple;
	bh=7HsdpvugL+6rMC9Qu60vJ1TZoeYC4MFXvHaHtLdY6dA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mVKIelcGlxHh1NDb+jmHpo6Mb4oNbVDEUJ6hm82y2Ot3H3ZkfBiZpeli6xobix0sxHgrwz3YiI268mDVeVRT0P5w4O7vUzPXQGdVogzfsosQ/9qspkkNdqL8q1ZSWV9RnIWlQN01nlq6LIX2xBhH/pk+Zb3l2+HZEQz3iNOLmGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y6wfiJn+; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y6wfiJn+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8D0181A13D3;
	Mon,  3 Aug 2026 13:48:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5F8386029B;
	Mon,  3 Aug 2026 13:48:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DED8011C30CE9;
	Mon,  3 Aug 2026 15:48:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785764911; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=d87jDoI5mf8YEsVB3GMXimCdOwrtahguDQZ53OXWn2w=;
	b=Y6wfiJn+bTmp0HSXLs/WlVKQ3RuXobtkF/uOFH5GsDgWZe9PWavSdKSTIESFyNkZdvD9Lr
	0tss0QGWQqd0mASoEhjgII3F4704py8Hw2ITs0vn7/HWbgrL7VJM29gtZpmNHO52Eif54c
	Mzkkb608s6CfZI5GMQhGCyFAP8eWfcEwP05AyNkfZ0rmH10g/7msZ2NcXSivdb0V3diFVC
	tD21QcnySBN7/rGp6Y0ciYMQU8esUfT8cQ/BFRZroIcPeuCXlPbJKpL4rlLxpWi15zTEF6
	8wJNVXILuXjHZ4KETCAKD88AVyHuC+JCxJSo9Zb2KqzNVqWmlikfqdNRqv8EOg==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Mon, 03 Aug 2026 15:47:31 +0200
Subject: [PATCH v2 1/4] mmc: sdhci_am654: Move tuning_loop to local
 variable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-am654-sdhci-v2-1-a5ee5be86133@bootlin.com>
References: <20260803-am654-sdhci-v2-0-a5ee5be86133@bootlin.com>
In-Reply-To: <20260803-am654-sdhci-v2-0-a5ee5be86133@bootlin.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, 
 Faiz Abbas <faiz_abbas@ti.com>, Judith Mendez <jm@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pascal EBERHARD <pascal.eberhard@se.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=7HsdpvugL+6rMC9Qu60vJ1TZoeYC4MFXvHaHtLdY6dA=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqcJwrOzjkVzQScxBP1s/E1dQvv53GCiwWYVJS4
 2nM+59UFJCJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCanCcKwAKCRAGvnxbVl7J
 RUm4D/9fJtcBWRnspSHr5An3hhOnyAERMwvDgJ/z9jfh5GW4tE2keRY8nh3xYbRwU2A9KCffkxI
 DvYPTz0/LGxw1NF6J2njBqOLBFI6H7PgxmtpYcISnEIETnWyYaWD3fTx/BF/nbwQD9+DyqA7Wtl
 zr9iLC7HQZo1Wr0gZxk/KIVsCSbe130kV3eqoROiec5ajUiJH143Jk5/2/2IMUnKCGIfqbe2JRz
 9V90QOF7589vb6qnHVi5cwEQyO3831yrzi/h8OFhwZ306aD8FDAZuo5e92nbyD9/jWjOFyeo9TJ
 YApj7O9ceih3y+2/UsZnWWCgvK6Xg8wDD0na1GZsTKozWSgt068DD4SrusEf/QckAAx/dhN63V7
 KxnPROvNg7qyN3LSohe+Iw1A79P3pOuxhMHTYTuFVgrjzkL/629+H7WxgUlYMnRz175K9Wb75yP
 0XCfOu7fJFFekG+eSH3PJQ8r6eii/8od/xOyrQn7590yISjqGuARdE20nUyFEhdJzt17hAvE7W2
 E8bXi4mMdZ0rFLYB426dlh4BYrjWMzjJSkq3QUSld1Pqnf3IYdaTIYJgv/ID2NAM+KlRcVQx7IL
 K51YgtznY0VFVO8Evl5JRjjneVULp1BhxXM5OfG0JTfH2ZvAwI+ecGRls8NuOaTx+M3Xg8aT72G
 vVwddR6RzVfJYsA==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

The tuning_loop field in struct sdhci_am654_data is only used within
sdhci_am654_platform_execute_tuning() as a loop counter that is
initialized to 0 in sdhci_am654_init(). Since it shouldn't persist across
function calls, otherwise every failure expends its "budget", move it to a
local variable and remove the struct field along with the now-unnecessary
initialization.

Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
---
Changes in v2:
 - New patch suggested by Sashiko
---
 drivers/mmc/host/sdhci_am654.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index d235b0aecfdb..35c3efd92112 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -151,7 +151,6 @@ struct sdhci_am654_data {
 	u32 flags;
 	u32 quirks;
 	bool dll_enable;
-	u32 tuning_loop;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
@@ -576,13 +575,14 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	struct device *dev = mmc_dev(host->mmc);
+	unsigned int tuning_loop = 0;
 	int itapdly;
 
 	do {
 		itapdly = sdhci_am654_do_tuning(host, opcode);
 		if (itapdly >= 0)
 			break;
-	} while (++sdhci_am654->tuning_loop < RETRY_TUNING_MAX);
+	} while (++tuning_loop < RETRY_TUNING_MAX);
 
 	if (itapdly < 0) {
 		dev_err(dev, "Failed to find itapdly, fail tuning\n");
@@ -806,9 +806,6 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	regmap_update_bits(sdhci_am654->base, CTL_CFG_3, TUNINGFORSDR50_MASK,
 			   TUNINGFORSDR50_MASK);
 
-	/* Use to re-execute tuning */
-	sdhci_am654->tuning_loop = 0;
-
 	ret = sdhci_setup_host(host);
 	if (ret)
 		return ret;

-- 
2.55.0

