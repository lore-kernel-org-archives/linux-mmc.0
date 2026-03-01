Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9C823DD
	for <linux-mmc@vger.kernel.org>; Sun,  1 Mar 2026 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772351615; cv=none; b=nPpc/zZiGbBfvBfTgGDRw43Qx7/gwDbVy3spCBu7MVSZkSKwE9ta95izu8qOlG5bkLjwD6tjecM3VSJPfnxZv0NAijY2JL0Q4Oo0fpAYHxKtDk/dNeXvMzPEnkBSwZh3Biq67jwDQhjX/dceijFHjyodAbwivhYnnf3KUvO7LgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772351615; c=relaxed/simple;
	bh=GLqdJ8P4hnRg5xWVxei1kADlcf95wZLXVGRFECegirs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Mcg+NTE6QEbEuMjFr1RGlO+GZRBACP4tkaQXY0OGfNVwJfslisvXB/rEGeSDcYYawDjac3p37GaIBGrE651FcTkAxxvsAIC8NmR+D4GGaXvBDijNIGtX0RJl16H7kRwtPEDmcDUI1icVgKvFZpY3VLfnA4j6DtDN9ac74xio+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsemnX/x; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsemnX/x"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aadc18f230so23445995ad.3
        for <linux-mmc@vger.kernel.org>; Sat, 28 Feb 2026 23:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772351614; x=1772956414; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1y12jkKvqEPCOLPo3R+Q3mFyBRLHL7GmyTtHyjpWdEc=;
        b=TsemnX/xPvSvqb3GuWFPfBPdpQpPTGHZfOV4vDhZP/TaZ9Zhf+AkTb1a5hTEvCUBkQ
         Yxpg0XP3M2kwhSAWs7uMhbF/rtXpNQmLCb13Uy5/Kv8n/3qEzu9lV7cPrgSgLWdhAaGc
         rvy08hUj4B3J9YsDo+kG/1TrvruEI7iyjKh0qb4+H7IZIx3FRFyGSTtk1djOlnaa6AaB
         4n4WNCxlJ9+BsD2UY1NSvZJB+M0aLvK3QToJyg2THkKhMK+IN45VxSgvGikVZQAXKeom
         KsJmD658i3Ljbf6LaWPfdkI29zljnG5fbV1r6+EVbxYQrsqcdtP7ixLonfXMwIed9f22
         PfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772351614; x=1772956414;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1y12jkKvqEPCOLPo3R+Q3mFyBRLHL7GmyTtHyjpWdEc=;
        b=EJoLxRdutLX6FiRkNC85WkGAlX2wxEVRqWH+Rv5N2K5NtHi4W57F+fX4mbhkjrlfGl
         c7gVESu4PSK72YVdAPeRbp9nkYs4EJSOU/d44VdnFGGXKuepOOQw/PF+2o69pYQ8mSei
         +J+nwnnLmx9Qx7EPYBUKp9rYgM95COxs9fpi8linIqVgtTYthOs7Osw2CoWc2l5rM6CD
         j4BX4vZqRdh56nBKBqfb1PnBaPDwGZYTLV5gxYdyCjS+bBalWfM10HChxgymyxYc2P4y
         in3kDSkZz5iiq6g1XBlyiVXEisAbr/qqb77Krm4oDUhQ60OA5gA7PbF4MynnsR9nXhzu
         jaBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2ywYtAYfIolmhipdxTvIJqhgEBgNc/vgUZMG0AZXjmUJnePiWZopSb1uw6g1MmQPZuY2etHtQ9X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRvTrcqnFoP71mo+wFvwhCC2PmcNW6Qw5u+1S+Mguf4ySfSKQ
	dK4gdq4QE1cWwTq/5WIIgH2koeoFVKOdGwwokqE71XP7k6qDsdlbo1vT
X-Gm-Gg: ATEYQzxSAabTN+w6gHpj/oUOIdILteqL3Cbkds+QVaeOJHRLkNA2SeIYOH+vhgKGKxk
	7aJCiKbo+C/Nq9bdxIw4FMEfAKN0qqidjwFkULiP/TuoptvD8HOUBwg6xts7cMJGurR41iWc/fC
	XgGmYG0RVrW64eUgQxDme+SRGmuCzF4XNjIF0kRcKDppxlOm5s3hWlsm/hfgLs/egKtgTlHZKEu
	UJsmbSv3A11wGpW+WvEriitFEGlhSgrL1mEWdYk7jbMxSdXZJQfDp2vpYv8UjggVovTdWlJ4l5l
	2yk5JFu51tItO9/gMSuPqkiqhw1PU5LfNrw5/f/nYFP8bkSXSrbPytkjGofzWrco3cYc8oMNRRc
	GGbil8RuhYkF9QTczWAOBugTeVwjb5vB9/un90aR0jngus1WxWcxFXApxXj3iD5Acp4ODLg7otw
	2tYeJHXV+9H5/5CjjGfc2BP5n+15KPNbtY3IpA
X-Received: by 2002:a17:902:da8f:b0:2a9:3396:738 with SMTP id d9443c01a7336-2ae2e4bb21emr91976115ad.44.1772351613828;
        Sat, 28 Feb 2026 23:53:33 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:fcc8:844a:f21c:8d7f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4802645bsm13880405ad.12.2026.02.28.23.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 23:53:33 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 01 Mar 2026 15:53:30 +0800
Subject: [PATCH] mmc: sdhci-of-bst: Fix memory leak in
 sdhci_bst_alloc_bounce_buffer()
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260301-bst-v1-1-ddbc22ec3ed9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHnwo2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwND3aTiEl1zs6Qk82SzFHNLY0MloMqCotS0zAqwKdGxtbUAngFKnFU
 AAAA=
X-Change-ID: 20260301-bst-76bb7c6d7931
To: Adrian Hunter <adrian.hunter@intel.com>, Ge Gordon <gordon.ge@bst.ai>, 
 BST Linux Kernel Upstream Group <bst-upstream@bstai.top>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Albert Yang <yangzh0906@thundersoft.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772351611; l=1293;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=GLqdJ8P4hnRg5xWVxei1kADlcf95wZLXVGRFECegirs=;
 b=nI+wepdJSqBs2819GnK68eBfJYYFxHgaxoTIcEXYEiaBLm88VbliuCG45Uer5NNESZdCpZr1v
 0BjLo7aGC7ADEyjGCLkyl1oGy8Lhmz8eMKT/wU6M6HbMOaCWIV9SlZw
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In sdhci_bst_alloc_bounce_buffer(), if dma_alloc_coherent() fails, the
function immediately returns -ENOMEM without releasing the reserved
memory, which results in a memory leak.

Add the missing of_reserved_mem_device_release() call before returning
-ENOMEM to properly clean up the reserved memory.

Fixes: 695824f45629 ("mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/mmc/host/sdhci-of-bst.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-bst.c b/drivers/mmc/host/sdhci-of-bst.c
index c124990a64f4..79c945f4858e 100644
--- a/drivers/mmc/host/sdhci-of-bst.c
+++ b/drivers/mmc/host/sdhci-of-bst.c
@@ -425,8 +425,10 @@ static int sdhci_bst_alloc_bounce_buffer(struct sdhci_host *host)
 
 	host->bounce_buffer = dma_alloc_coherent(mmc_dev(mmc), bounce_size,
 						 &host->bounce_addr, GFP_KERNEL);
-	if (!host->bounce_buffer)
+	if (!host->bounce_buffer) {
+		of_reserved_mem_device_release(mmc_dev(host->mmc));
 		return -ENOMEM;
+	}
 
 	host->bounce_buffer_size = bounce_size;
 

---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260301-bst-76bb7c6d7931

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

