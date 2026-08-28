Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D03A838A;
	Fri, 28 Aug 2026 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787888689; cv=none; b=Px87sAlE50rIMyMD+c6Kfjj9djZyxuo+V7SmnW47sA2dd08x90gcwo3l+avjFulW9xDi+tkiO2cBGAeeCXTYDgOiws9I7t4bUxKiw2J0KQrPL6l23IGXeTHC6+I8A3oUiqqtRYanloXnEYGEOW3SsiQtiWFo76sl/PRaYMp/x4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787888689; c=relaxed/simple;
	bh=Ll5/+6PMcj1HWlCXwLxWXiDksPF+IwYuNg0HMK1kf7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWfrL+W5G9zF0bnD9jbsUs1bVOi86vQi0pI3iX/k1ia9e+OZMkq8vGn9XbWhzc5CD9FYNEUWjWNVXjdAb8ZRcPzY/BnXdNbZsyDH9qRkmEJpe9e5eK+6XIla4tna9AdrFXUWevltbXoTg6NoFN2EeSBXF0kbkMcWsAe6ftqtOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S.localdomain (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABHUD4qBJFqiW1wBg--.8165S2;
	Fri, 28 Aug 2026 11:44:42 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: maximlevitsky@gmail.com,
	oakad@yahoo.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] memstick: ms_block: Fix memcmp() size in msb_resume card validation
Date: Fri, 28 Aug 2026 11:44:13 +0800
Message-ID: <20260828034413.26115-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHUD4qBJFqiW1wBg--.8165S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cryktr17Kw4kGw15AFy3CFg_yoW8Gr1DpF
	srJFyUGws5Wa4jvFn7Z3Z5XFZxuay8GFW5KrZ8K3srZwsFyF13CFWktas8Jr4qvFZ7Jrnr
	Zr13KryjkF48X3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbdWrJ
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwQNA2qQunj4+wAAs2

In msb_resume(), the LBA-to-PBA table comparison passes
the entry count msb->logical_block_count directly to memcmp().
Since msb->lba_to_pba_table is an array of u16, only half
of the table is compared, so a replaced or changed card whose
mapping differs only in the latter entries can be wrongly
treated as the same card, keeping stale cache/FTL state.

Change the memcmp() size argument to msb->logical_block_count *
sizeof(*msb->lba_to_pba_table) so that the full table
is compared.

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/memstick/core/ms_block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 1af157ce0a63..589ee2eb1a60 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2246,7 +2246,7 @@ static int msb_resume(struct memstick_dev *card)
 
 	if (msb->logical_block_count != new_msb->logical_block_count ||
 		memcmp(msb->lba_to_pba_table, new_msb->lba_to_pba_table,
-						msb->logical_block_count))
+			msb->logical_block_count * sizeof(*msb->lba_to_pba_table)))
 		goto out;
 
 	if (msb->block_count != new_msb->block_count ||
-- 
2.43.0

