Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3478137F73A;
	Tue, 23 Jun 2026 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223449; cv=none; b=lGhqRJND9lZM/5PegVVRQSQQsZedzjiglF7WQdJb8z2jQZZ57BTh11LgB8UaRvF56zVRvskPtx1P8cw7MALMXfgEXl2NNaEbH7VrEJ98VhbU3g5/+9cWONtfSwQgbNFOMYXwGs5fDfx+tEd6VkDGSAPPsFww5w+NDGHwUI5Gabk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223449; c=relaxed/simple;
	bh=Dr0EfdEIxZqm53EdMvoFdzk5mkc+oPZjPKHCh0bFud0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evyl8+UYTregM59rlrHDqdTmQZBPjyFIhtujDAOH3aw0889vU0r2iUyi+joImZIJHTz0A1BBUcthRXbVSGbLL2FSB/FGFq/d0SJveAfFeNP2kkQ7Fnn7wlaeiGhm1EM5s90ygZbsvc2tvDEmTVieZnLbal/7upvsHzc5A2QMFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAB3zhFRkjpqBmXYFA--.33582S2;
	Tue, 23 Jun 2026 22:04:01 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mmc: cqhci: keep CQE enabled if halt times out
Date: Tue, 23 Jun 2026 22:04:01 +0800
Message-ID: <20260623140401.80963-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3zhFRkjpqBmXYFA--.33582S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW8Xw4DKw18Ww1fCFWruFg_yoW8uw43pa
	n3ta4YkrWqgF1ayF4UGa1jy3s3Xr4kt3y8G3yUGw1fZrZ5urWDurn7CFW0vF1UJFy8Ja4S
	9F4DtryUAw1fAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUnG
	QDUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

cqhci_off() asks the controller to halt before post_disable(), clearing
mmc->cqe_on and freeing CQE resources. If the halt wait times out, the
function still continues through that success path even though the
hardware may still be using the command queue.

Make cqhci_off() report whether the halt completed and leave the CQE
state/resources intact when the controller remains stuck on. This keeps
the existing host-specific ->disable() ordering and is intended as an
RFC patch because the cqe_disable callback itself has no error return.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/mmc/host/cqhci-core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index 178277d90..84846207c 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -372,14 +372,14 @@ static u32 cqhci_read_ctl(struct cqhci_host *cq_host)
 	return cqhci_readl(cq_host, CQHCI_CTL);
 }
 
-static void cqhci_off(struct mmc_host *mmc)
+static bool cqhci_off(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
 	u32 reg;
 	int err;
 
 	if (!cq_host->enabled || !mmc->cqe_on || cq_host->recovery_halt)
-		return;
+		return true;
 
 	if (cq_host->ops->disable)
 		cq_host->ops->disable(mmc, false);
@@ -388,15 +388,19 @@ static void cqhci_off(struct mmc_host *mmc)
 
 	err = readx_poll_timeout(cqhci_read_ctl, cq_host, reg,
 				 reg & CQHCI_HALT, 0, CQHCI_OFF_TIMEOUT);
-	if (err < 0)
+	if (err < 0) {
 		pr_err("%s: cqhci: CQE stuck on\n", mmc_hostname(mmc));
-	else
-		pr_debug("%s: cqhci: CQE off\n", mmc_hostname(mmc));
+		return false;
+	}
+
+	pr_debug("%s: cqhci: CQE off\n", mmc_hostname(mmc));
 
 	if (cq_host->ops->post_disable)
 		cq_host->ops->post_disable(mmc);
 
 	mmc->cqe_on = false;
+
+	return true;
 }
 
 static void cqhci_disable(struct mmc_host *mmc)
@@ -406,7 +410,8 @@ static void cqhci_disable(struct mmc_host *mmc)
 	if (!cq_host->enabled)
 		return;
 
-	cqhci_off(mmc);
+	if (!cqhci_off(mmc))
+		return;
 
 	__cqhci_disable(cq_host);
 
-- 
2.50.1 (Apple Git-155)

