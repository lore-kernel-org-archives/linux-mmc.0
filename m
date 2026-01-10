Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F415B998;
	Sat, 10 Jan 2026 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768056725; cv=none; b=r2fLc7RaSImU6hNwuZAjpOKL7H3JXqWvaoFbQI7hGKD5XIjrpaAezQqNB9B+lByuA5HO4PDPDa8sGU5FGrojQZV67C7dDuqaWuVilhi0/dQdSc7BOHOtkrLMGzzsL0D8QwFBn0V1mY2hzoUVHhht7ogXwBAX+QwhnIwWcvi/N+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768056725; c=relaxed/simple;
	bh=lmdeOPAdLxl9hYWPyGDg/PIbnjoW0gCdtc+iW8opIuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkCzhz9F9DsYmoCRURK78fk/yaswVmxx+wj3EiXqsQpmk9PWWCuTFoa9IND44ZB75+huOKnwZIm54whGIMXYJNa+EQfLpXH1WN67MCI2FbDNwMJO/KvAWEQ34LyZtyLKUZOq3Y4roU2cfK1YRkS9N72yB1SbYYn8tXANdL6Nzus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=P/L+KgRH; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="P/L+KgRH"
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward200b.mail.yandex.net (Yandex) with ESMTPS id F22458172A;
	Sat, 10 Jan 2026 17:45:02 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:2220:0:640:d16f:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 306728046F;
	Sat, 10 Jan 2026 17:44:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id qiRvIkYGsuQ0-3fjOsmnE;
	Sat, 10 Jan 2026 17:44:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1768056294;
	bh=BcSMYG/RMLn9zKorig8n/TyM9L2oo/irKjNGVd375eg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=P/L+KgRHZ7p4NvtQOw5zQsg2I6uhsul/4yLs+eZ7dEmiCb00eohrfknfxy32kOgFb
	 s+3VsAKWKlG9nn3oof/fLatiz98SZo3AiEwjNDiFY6nYWqGzttBEZCxghjqYzSc/v1
	 O1P8xbDNi9iPIMn/cF7y+KEDDgCSy+z7Wh9jxPzc=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH] mmc: pxamci: do not complete requests under host spinlock
Date: Sat, 10 Jan 2026 17:44:32 +0300
Message-ID: <20260110144432.176015-1-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pxamci_dma_irq calls pxamci_data_done while holding host->lock, but
pxamci_data_done is also called from the IRQ handler without the
lock held and completes MMC requests.

Calling into the MMC core under a spinlock breaks the locking contract
and may lead to re-entrancy issues.

Drop the host lock before completing the request in the DMA error path.

Found by Coverity: CID#1658802

Signed-off-by: Ahmet Sezgin Duran <ahmet@sezginduran.net>
---
 drivers/mmc/host/pxamci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index b5ea058ed467..6cf65aca2449 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -551,7 +551,9 @@ static void pxamci_dma_irq(void *param)
 		pr_err("%s: DMA error on %s channel\n", mmc_hostname(host->mmc),
 			host->data->flags & MMC_DATA_READ ? "rx" : "tx");
 		host->data->error = -EIO;
+		spin_unlock_irqrestore(&host->lock, flags);
 		pxamci_data_done(host, 0);
+		return;
 	}
 
 out_unlock:
-- 
2.52.0

