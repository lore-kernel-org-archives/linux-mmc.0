Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779662;
	b=2AXHTvhJQcq3yztj0l5+Cmv9LrhEL1uTjRmI4hc7nfRxBP8v4KAxMp/R3DyZyT1gFHUF
	 KQNBtqdfPSFDwXIEQIqlhST0T3Wtpo4vnUXKB5eEurUfPyfYJ1sZ3hg9GFbqxAdYHTegH
	 pyeiFy0XOfVu18SrQWAG3cERcyVugRt2wmraReg6LcjdAA6xwh3zZ/Quh/84mDqLTrcFK
	 eDD72VX72AgIWpsijh5MOa/OB+Bx77ck+pgqWsytGEnEv+i1zABcYcacbeJJ92vacKDSp
	 qq2j1LJi6A34tYuAlce4kUpXKRM2OPJhQ1EEAuHWgljBanne8YDTzWDGPRqnCTdWICA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779662;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=mH56HqaEwD+XdDX+wKUFDeUx3ALtmiaCbYyEE6bI0yM=;
	b=EVbVpPEn8WZ3gfpzICURIA3pUa1QiFEp7Xp4RY0lljEAUyvOj9TmOA4UsKg2MoNSSPvD
	 PT7m7JnCzjvWyVQGKvfEogk8wdsOD5PwvWHgrGx+8ntc4R0Y+cSFnpjrOOIX12a884ask
	 B1S9ek9KdS4f5sFZh2mRGgRA14HRKbjVROKVm6qZFmTEUY+f3BM7U0RQemIetuDpv+5MT
	 Ki9opLCOYV8jUsTzyXMY3nnrsr7qcKIyhrIFAIKZKAP3tByLblRYFiB/xYKEFMVZYY0fg
	 1tNw4BxbDlVgIlNxPEkYsMkWmjh7wCk0qj/pAk+fe+NMtt7zNaOQ0y1V+ooGFVNnQ4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B795F606A330;
	Wed,  4 Nov 2026 08:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B795F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwCXn6e55+pq981pBQ--.3092S2;
	Wed, 04 Nov 2026 16:07:21 +0800 (CST)
Received: from WIN-B62RPRBL2BM.localdomain (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8DwBXS15+pqWnz1AA--.23333S3;
	Wed, 04 Nov 2026 16:07:17 +0800 (CST)
From: Zhu Ling <zhuling2709@phytium.com.cn>
To: ulfh@kernel.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fengjun@phytium.com.cn,
	wangyinfeng@phytium.com.cn,
	Zhu Ling <zhuling2709@phytium.com.cn>
Subject: [PATCH] mmc: block: Mark the end of a truncated scatterlist
Date: Wed,  4 Nov 2026 16:07:05 +0800
Message-ID: <20261104080705.103689-1-zhuling2709@phytium.com.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DwBXS15+pqWnz1AA--.23333S3
X-CM-SenderInfo: x2kxzxlqjsliuz6sx5pwlxzhxfrphubq/1tbiAQAEAWrjns4DngAFsF
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=zhuling270
	9@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7AFWrGw45tr1DGr1UuFy7GFg_yoW8Cr1fpF
	WrK34jvF4DKF1xZa48AF4UWFWjka4fWFWUGryFg3s5Zrs8KFy2v3yvya4YqFyj9rs7WFsa
	vrsIg3yrCFyDZFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

mmc_blk_data_prep() maps the remaining block request before trimming the
scatterlist to the size of the current transfer, for example during
single-block error recovery.

When the transfer needs fewer SG entries, the trimming updates sg_len and
the length of the final retained entry but leaves SG_END on the original
last entry. A host calling sg_last(data->sg, data->sg_len) on this list
will hit its end-marker assertion.

This assertion was reported during read recovery with a Phytium host
driver in a vendor Linux 6.6 kernel. The same trimming logic is present in
mainline.

Mark the final retained entry as the end of the scatterlist. Subsequent
blk_rq_map_sg() calls can still extend the list: blk_next_sg() clears
premature end markers before advancing to the next entry.

Fixes: 6a79e391df29 ("mmc_block: ensure all sectors that do not have errors are read")
Signed-off-by: Zhu Ling <zhuling2709@phytium.com.cn>
---
1. I could not find an MMC-specific statement explicitly permitting an
   unterminated SG prefix. Feedback from MMC maintainers on this
   interpretation would be appreciated.

2. bcm2835_prepare_dma() checks sg_is_last() before dma_map_sg().
   No failure has been reproduced with that driver.

3. A userspace metadata reproducer triggers the sg_last() assertion with
   the original trimming loop. With this change, 120 flat-SG cases and
   36 chained-SG cases pass, including truncation boundaries and rebuilding
   a longer list.

 drivers/mmc/core/block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1506,6 +1506,7 @@
 			data_size -= sg->length;
 			if (data_size <= 0) {
 				sg->length += data_size;
+				sg_mark_end(sg);
 				i++;
 				break;
 			}

