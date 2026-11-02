Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793586574;
	b=Ef00Tj9DITPDZ7Kk9qofJg1mQ4Yr1YlnbbpVLQ2oGawZHp4y1RQq1oUEIPG77iVKGzYv
	 +7jFh/vPpwGSvgEq3BNlqnoXCCHAyNx1hizGi5PwVnjtkHNS/xyor9PYV31Cc/jxBc5cb
	 fJsjuMqpRau1UgEZdzxw0GpMp4J0fXgoS54ClyYR2tFmR8kiAvL8HZLJpcET8BA9FHP7X
	 ulr3rJEDcOvpAxTSWWW7J7ETCl7kCG2ZwKbcH1NXq/OMY5QnViAaQMkGNSRKV026+fQn9
	 J/uxnHWNOAVUIoDCnx2alOZy+lQZM5weSwsGEGoHa2COZ/zWvG7OY4x1Xyw5vrvKjWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oraj5/DBEjTdYiHJqe6PkDC0IxB+a0MZ66ytJCd3wwk=;
	b=DwaT0i8el5ZXGv+MChxqvB+DM9HP/4/j9xLxN/GPl+Njqnhqpw9bbHahSyjT3ruGXIfo
	 lllFx1jQ9Z2t3MySMUPbcuskE6Ye3psh9k+yJhotxaxRZzB1UyMa0lwyOMCJop5HlQEcS
	 Tcz5+4BhEQY9GN3MoZzHZ2irJDnFIlXuVI5PZ2Rgx+WTAH9/pRzlnTxazokOGW5FP9/D2
	 uXPghvQCDpx7VHi+uBvYV3yxL0MXarQsjIlATjzHwLqGfpcjHiadTmhp3jWUjE1lnBeeg
	 MnkGjRgg98sY5PTlE2wiiPSnQpvG/H1EUN9/KC8+zC+FCroSOGO6xzFuOe0MWXwF6Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQ8lJ33v;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2063C606A331
	for <linux-mmc@vger.kernel.org>; Mon,  2 Nov 2026 02:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2063C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQ8lJ33v
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a05b210703so807625b3a.0
        for <linux-mmc@vger.kernel.org>; Sun, 01 Nov 2026 18:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793586572; x=1794191372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oraj5/DBEjTdYiHJqe6PkDC0IxB+a0MZ66ytJCd3wwk=;
        b=EQ8lJ33v7UtNQ/YwA2kxe3xxDCiwk80K412vJUCrTthmQsBrqkZSzWKZ9oKB2s7R9V
         teVYNZXd4NoqJpVQduLK70fSd3jCQUNBtNx0kNSUBPYyxzc9UbykHjjObkXy6QhnW9Aa
         FtzblfKdGoL4GIi71DsGkWXz0IUY5fC/SWrNCJm8CbI36SMWxaY0z1JOk1N2J6qEw36L
         Pp2Q0mzA7I43JL7lRiKpuMo2fFbjI4EHIj4WvhYUG7zfBO81vTkABTimOh4DUdfIIxMr
         8RiLDBoGePM/JR70Z/ywBjHMgBGGOeSxHw+pnERNhtFqIFmFbqX2m8HsucVbN0xoy/Py
         MhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793586572; x=1794191372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oraj5/DBEjTdYiHJqe6PkDC0IxB+a0MZ66ytJCd3wwk=;
        b=wHTv8hsMh05my8lOCKqF3DUjLBcC2VQoKs6ZzWudnWuFETQvFMgGOg9BCtX5ZwXdnV
         HApvJeykixbyqVOeLsG4tpf5kTrTbNo1mkanULFLnKL2xRE2uGHET8o8ZOaVCOD2ewUG
         0PwKPP7Inj89kvH65Tn7x4qQwuLlU/iYR7CtZMlnP2NKDQjOFWXBbA5QFApCy3fTZvDt
         40DwU1uuitjGWa0sUUWBbWn4c4sQCyAH7KDto7TUzgP5OqVWeJZlHzoLVBETDiNEXoka
         fwABGe1a5B6zCgvHtNWYDatNJpdWxrYHAzoctr1u2oU7cGdfh8QNSYar0/5fLPwf1y1G
         2j2Q==
X-Gm-Message-State: AFq9FYKZRswFsTbeWHtcHKt0JBXo2d/pESqefLG86DwmMjOR1o/8tU5j
	iH8ZoZcn9j2RPpqLLmZVBIWIk9QIYSeWNYNAz4w6oMGmc5AQBmaSTAV0
X-Gm-Gg: AYBFou1L7GWx5dSfmECKCV/GV6+kut59t4rW4TXXF0sDPPeSlZBWHUQJ2VcYhWTHD7r
	v0qhxF+8dA07Dj8z46aCCT9Oelv1gxKFDUMZ306xiCL2FClEoe9HdlltJCl7QiIzNedRrAkuN1r
	8hcnfmiM8OUL89T0ZuU9pjj8I8GQndHaP0k2zHhl5S6u3KGVagLS5RonZjoMJstCZ8E1qYnozmi
	O8thhYLfXvWMqBnHJ+kuu1bE9Gx1r2ZdkT/fitny32IXhpgKQbDs3SetVpMkJo4U2Wi3H36ZzRU
	y04tsbzzDB6BBTUfivbPwz17mD8uRAOilo22e+wQ0og7xWarC6S/Tjm3OsoRAkX3C3TxpxKhLkM
	lAqZOqEvlvHHh2w/vWGTOJq/EWPTPlL1aKrj4bUYwAzNAfY5ShQ2q9BJux+d/Le6F2K8k0Bd8Sv
	P+emI9xuXGiR2ytdkTIKVvb5Yzp+HCHEt56cnneTWvSRx0XvoHxjZpyUxbCCFE91+VOfAmkD6kq
	BDoZjTlZFenaPvCy0W4l17aZWRI+Q9OZ/DBmU9ezSGa2pyXsi74+2AqLIFq4z/nJO+tXunliFGN
	d9IrsEEPnw9uOD2NtTApiFRnnlq+ONV22hO7Rq+lg2cUpHUQuoSa1FNUn3S0c/RCCk6e
X-Received: by 2002:a05:6a21:7988:b0:3dd:85aa:452a with SMTP id adf61e73a8af0-3e928dc794cmr5954941637.37.1793586572482;
        Sun, 01 Nov 2026 18:29:32 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb09814cb9sm2441382a12.24.2026.11.01.18.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:29:31 -0800 (PST)
From: BeaCox <0xbeac@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	BeaCox <0xbeac@gmail.com>,
	stable@vger.kernel.org
Subject: [RFC PATCH v2 1/2] mmc: dw_mmc: drain bh_work on host removal
Date: Mon,  2 Nov 2026 10:29:23 +0800
Message-ID: <20261102022924.51343-2-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102022924.51343-1-0xbeac@gmail.com>
References: <20261101063719.88570-1-0xbeac@gmail.com>
 <20261102022924.51343-1-0xbeac@gmail.com>
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

dw_mci_remove() does not drain bh_work before the driver core releases
the devm-managed host.  The interrupt handler, the fault-injection timer
and the DMA completion path can queue that work, and its callback
accesses the host and MMC request state.  A work item that is still
pending or running after remove returns dereferences freed memory.

This is not a regression from the tasklet-to-BH-workqueue conversion.
The tasklet that bh_work replaced was never killed in dw_mci_remove()
either, going back to the original driver.  Commit 921c87ba3893
("mmc: Convert from tasklet to BH workqueue") only replaced
tasklet_schedule() with queue_work().

After removing the MMC host and masking controller interrupts, drain
the interrupt handler and disable the work synchronously.  Disabling
the work also rejects later queue attempts, unlike cancellation alone.
Stop the fault-injection timer after the work callback has finished so
that it cannot rearm the timer after teardown has cancelled it.

Fixes: f95f3850f7a9 ("mmc: dw_mmc: Add Synopsys DesignWare mmc host driver")
Cc: stable@vger.kernel.org # 6.11+
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
 drivers/mmc/host/dw_mmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ff0b25d..5b47643 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3406,6 +3406,11 @@ void dw_mci_remove(struct dw_mci *host)
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
 
+	synchronize_irq(host->irq);
+	/* Stop the work before the timer that it can rearm. */
+	disable_work_sync(&host->bh_work);
+	dw_mci_stop_fault_timer(host);
+
 	/* disable clock to CIU */
 	mci_writel(host, CLKENA, 0);
 	mci_writel(host, CLKSRC, 0);
-- 
2.43.0

