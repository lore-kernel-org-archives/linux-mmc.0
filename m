Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C439A814
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713591; cv=none; b=P4GBwkGPFk0cj1FCBcgPVGFO4AaIvhvtr0LY03+jvx/zY7HIDX3IPuT6Jqa/0BMZucGq7SJsBUfkTmXunEz2wE+KNpbDZ7Z8f0zuoU3Nhj4yuZWSgyeQbCQdhKW3viYSJKxMMA2uFVLhuBxi3PfQxxBX/fuaHXZyx5m2eL6T9KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713591; c=relaxed/simple;
	bh=kpjPMYMBsv97u3/tbcolK24rHjVtIahubTAGspC+juA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efPYQSZBA2blsTaqPGGzVWwERb6Q1ySkNrZwj9QJAcLLogy+YHY8sMSI18BQKJI2ET6Mdc5RSXF7TaTafO4gahVqvInPRNr34YsNfehxegKC79jpqs9OHSdLnkhQWsML34gDNM0XsWEwAraZrtG179jBkDp5otmBeQINCjfYFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZWDgGwTQ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZWDgGwTQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772713588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g33veHKocJMh5UeL9VPE3UkZAZfuA4UT1g7mVEhBQeo=;
	b=ZWDgGwTQMU6FWjN/I9j+3Xs9YcvyGGlYsAcyDdWLEAQOHiQV7SfJIFnd4XVPGSUPVSSX5Q
	3tjPdJMZhpHfXSvy8pPRl0s9JcTNnlRQC6aRiX4f8fEfiFZzZL67/TDvhs5jaH8oOeMdqA
	ti/9S5LI3XwGt9dJB/cw3D2Vg142KQA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: tifm_sd: Use min3() to simplify tifm_sd_transfer_data()
Date: Thu,  5 Mar 2026 13:25:49 +0100
Message-ID: <20260305122553.249058-2-thorsten.blum@linux.dev>
In-Reply-To: <20260305122553.249058-1-thorsten.blum@linux.dev>
References: <20260305122553.249058-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use min3() to simplify tifm_sd_transfer_data().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/mmc/host/tifm_sd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index 2cd69c9e9571..c1f7d5b37911 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -193,9 +193,7 @@ static void tifm_sd_transfer_data(struct tifm_sd *host)
 
 		pg = sg_page(&sg[host->sg_pos]) + (off >> PAGE_SHIFT);
 		p_off = offset_in_page(off);
-		p_cnt = PAGE_SIZE - p_off;
-		p_cnt = min(p_cnt, cnt);
-		p_cnt = min(p_cnt, t_size);
+		p_cnt = min3(PAGE_SIZE - p_off, cnt, t_size);
 
 		if (r_data->flags & MMC_DATA_READ)
 			tifm_sd_read_fifo(host, pg, p_off, p_cnt);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

