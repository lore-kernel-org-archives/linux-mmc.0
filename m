Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515048;
	b=Q8XjPI1VNUtZEL8U3M3yrt13VkopeMEEWkyAoLjk/gmcvHM04kE3CDK0FXSW52LumlwJ
	 iB/iQh8HOHJNr3id6g8px036GLU5KWtebVFdwdWvII3jUCsJxGIQjBmSe7gJyMuzvCTJZ
	 56yqlAOFkvPTYIeCviFmhmbP8G0gxmWwHpR9Z2/HGb9Lv0tGK1HVTgP4Asdzprz2kWANt
	 yna5JULAJMSCZM2BWO7y8zhkIJyOOJLIVEEGxhZ341dRX4t8RhA2aiGxLCsK+PJX8MHWY
	 +XsAsK4v6GuJYhL1v4RpMYvwLugpQtuKLRlQJKXPA8kvoHXgc/6Vpo/5m23DI9SOpKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kaRMUeDRl+naPmm3qUT+oBT7oJDOZeWGKzT1v2c6cow=;
	b=Rv1cJAjha1D4Ow3nj7eH6n68S1LZzrCQAjrRguFM9ItK0i6v4wxVPT3ugQAs0lX40cKA
	 XqWP4/OzzCRwJ/itAQhaGGBYlb7hhTBcr0PXil7xx5AoQpcKqbk8MAzw7Mdf38SF7mh2L
	 JjOnSgO3PYgL2/VtFc7U6ohIgzqPuEWC8c9T4pZaVbQy5HRGWFMZ5aOZ/Tkk4KEuQUwOq
	 pxQ/5Iq4leNHl89mUk6hZW94EO6vJVFNnaCBCsje8AZjT/UQBe1DdpnQAJq2onkAlRGMP
	 GX+iPA7uWNY0bUzc510Ci0QUd1ipJ65XtdJX5kqRP1FZ1vpGnIZqcBwDDoavt6/+CwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0VlN2uOp;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B423606A326
	for <linux-mmc@vger.kernel.org>; Sun,  1 Nov 2026 06:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B423606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0VlN2uOp
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso889396a91.1
        for <linux-mmc@vger.kernel.org>; Sat, 31 Oct 2026 23:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793515047; x=1794119847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kaRMUeDRl+naPmm3qUT+oBT7oJDOZeWGKzT1v2c6cow=;
        b=0VlN2uOpa2rBfHqz+P34UFeI4XmM/oV6fVJXakdvt5wrQMb1FoS5ag3HPzYt85TOH1
         xa6XLyiYexXf+CY0aD+FHXC0HjFxalWv0GNXi8z8taU/5lMat5legdx73GyDwsIa+Wwo
         FG00l+6/zUs0jtBM+nZTM5E9sXDhFmSCCyiIGoMmXxp5ge5Y3T5NAVBs54cjUpiuGSLN
         /W24FxFL7gLyTt5rkjN7e69qdPGzGQe9eTSDW7V3p0qGRYB3Urd3L/wtCdMm51jB8UNO
         w3mruK/a7WrXjU6mIzmjM0EO1DnVVHiyI/VyO3TVlvqWixy4dfvia1QSdhs9MYcJSrM3
         NAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793515047; x=1794119847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kaRMUeDRl+naPmm3qUT+oBT7oJDOZeWGKzT1v2c6cow=;
        b=L7DarIbz+1TlArnwGOh+coaiRpWMgQoFOSmPJBYxHW2oDlXvpjq0gOrNCWzPVTcXRm
         Ot7t5TPH+05ng75IrXVVIq0mDeJwSj3bnA8ngmdimN4NeWM2cLG4Z6hXovYIOR/VS+OX
         xRBc/ENK2IKvvDPwiE5vjgw3mRQUTvQ1mGWPYEQlyNWSiq3lKxuQBlbettVVBnc96UIW
         Q3WbbIq1gh9ZNuf0GCBxWwR4vBlInTvA1og65hYwwA3cu8a0FQD2dYId7DWyFGaEh0j8
         F0nAxrtH7gCtW0toPJ91nym3PZRbn2o+KxO/RK3U8Jw3lS577OSWW9mdud2LZ367vN0r
         jNIg==
X-Gm-Message-State: APuU4Z/RoHhU1Rm2otgk9k/CGam+tQNokELkKbzeSEw8Z5n4XDG+OcRC
	8VAp2FssbqxtcOTt9Z4fL6K/sR/is48d153p+/TVvwBhnSnQ2oTZYOP2
X-Gm-Gg: AYBFou05J4L70mX7UPYK4lCcNIRHrassitqVXJz1MKPCSY2IcyeoRMwgRMEJKKE6TXY
	UilQvPrsqMIWA4DSxmRxPYfXspaSRAWE3u2/eo+eySv6VKz47kn0tnJ4rM2lim5sK5fQ2+jd4U7
	bYxr9SxXJbmMF/KpCWXnmzb6v3cJcegsZK0h/Gbv5FTb88Ds3TpQUEmG1I9/P8JXltvGxWbCzmE
	yE5yzDFUV2dVHkqjhmZ25mSUUBb4WFZngoMwmAApXBl6EcxJhYlKBle4lsNXDMlrZU836ZbDtwZ
	jFg91wZOo/LmCI/VFOV+h5D/w7HisVQTAtnNBDYN7B0whnqC11bplf2LqW68gLSFqcYbKg4yceW
	kdlj+V3IawGf76cd7NlRtSZGcTuhoM1zIy11NmUeGBv1rX1iFAK5X2CjTOI5hvDHJT9gjz1K5s9
	NLBMrppYit06Vu8wTA+Wa0DIdxuh1HaMH3blKmMUAKRcfe+8TKWG1XFrF7NUWcrgH+Wp9Oh+eFh
	fvcYLngZGOTh7+i2DrhPSQNpU0fV30CUPOPYTlMYUtNa2+cCzIwdyYUk77sleS6Hl0wA5mq3vc6
	gVbL+BMhPWHa3nSPEQAXgEmgn0vigRP1aAV2EHE+Kiuasg8=
X-Received: by 2002:a17:90b:268a:b0:3ac:7c52:faeb with SMTP id 98e67ed59e1d1-3ae89769d66mr5583408a91.41.1793515047409;
        Sat, 31 Oct 2026 23:37:27 -0700 (PDT)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f3e087sm5465907a91.1.2026.10.31.23.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 23:37:27 -0700 (PDT)
From: BeaCox <0xbeac@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RFC PATCH] mmc: dw_mmc: disable bh_work and stop timers on remove
Date: Sun,  1 Nov 2026 14:37:19 +0800
Message-ID: <20261101063719.88570-1-0xbeac@gmail.com>
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

dw_mci_remove() does not drain bh_work before the driver core releases
the devm-managed host. The interrupt handler, watchdog, fault-injection
timer and DMA completion path can queue that work, whose callback
accesses the host and MMC request state.

After removing the MMC host and masking controller interrupts, drain
the interrupt handler and disable bh_work synchronously. Disabling the
work also rejects later queue attempts, unlike cancellation alone.
Stop both timers after the work callback has finished so that it cannot
rearm a timer after teardown has cancelled it.

The analysis, patch and validation were assisted by OpenAI Codex.

Fixes: 921c87ba3893 ("mmc: Convert from tasklet to BH workqueue")
Cc: stable@vger.kernel.org
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
Testing: x86_64 object build with gcc 13.3 and W=1, with
CONFIG_FAULT_INJECTION enabled and disabled. A userspace model of the
extracted remove function checks pending work and modeled late IRQ/timer
queue attempts. It is an ordering check, not a kernel reproducer.

No matching hardware, kernel crash trace or demonstrated unprivileged
trigger is available. Please review the MMC shutdown assumptions and
external DMA callback lifetime. This is an RFC for a teardown fix; no
privilege-escalation or CVE eligibility claim is made.

 drivers/mmc/host/dw_mmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ff0b25d287..cc5e163ee7 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3406,6 +3406,12 @@ void dw_mci_remove(struct dw_mci *host)
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
 
+	synchronize_irq(host->irq);
+	/* Stop the work before cancelling timers that it can rearm. */
+	disable_work_sync(&host->bh_work);
+	dw_mci_stop_fault_timer(host);
+	hrtimer_cancel(&host->wd_timer);
+
 	/* disable clock to CIU */
 	mci_writel(host, CLKENA, 0);
 	mci_writel(host, CLKSRC, 0);

base-commit: cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a
-- 
2.43.0

