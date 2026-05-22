Received: from sender-pp-o92.zoho.in (sender-pp-o92.zoho.in [103.117.158.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE290421A08;
	Fri, 22 May 2026 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459301; cv=pass; b=XjyfCQzvwdZ9hXuIC3+pXyo0+fUmh3CgWMqArr55VSvClW2RyNfvwLlcY+bB0c2ZFu0Ugzrs/1OIfs+weESrC4ECs+5FZO3CF+XO0ouXD3hwDiLsSF0rTZpOHmXEhrJ44lXpo7o+WdIfNnjWbFaBGfHSC3m9fe/mdViZ3/ExwWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459301; c=relaxed/simple;
	bh=/GdN+Hov+E0JHGC4gwzOEamTamiAAiCE+X9x3KffmdY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=c0oLzdKeG01Xyp2OmBcrfgjOPNCvhymlXbZP2XFT/U2mntUpsHhZkRLrleik6F5EoB/fyZXP9GABPp1k+sI/PPPGF8mjvdCVkImB0Ee0/fGYYmia0R0cAiXM5PbusMNBL0IgPwewN8Wfzx1IwQtda3/aysDszZmH2gvPGI4IppM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b=oFw6aCAl; arc=pass smtp.client-ip=103.117.158.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b="oFw6aCAl"
ARC-Seal: i=1; a=rsa-sha256; t=1779459288; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=XdCW06inFOjwRU4879MEVRNxwBh50w7e0UUFprk3sBnNXvI0SQVeQWjYM/KgRbi35xscGVyHdZiVZdUpRaaaPS4fDQEtDxUL5y831Q7ewjmvtPfX9vJz4vDBtQ6Gj1OUuA+BuUUDkPyWkabRKR5s0WvWtGCIcv1Hz0aNpiJ1q1g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1779459288; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nu+EHuki7/RBRPdPYUfzJTb7Doc+NthJaDSnx91oBp0=; 
	b=agok0P+1dwkskt7HG2dLQ6xjMmYbHnwr6jocEEr5emsJT+Ea14/Ca1qb6ioF5dgrUyoR106jlkEtUdDs8JtCBQEuSz4VMpFju8UgmZ/MxgrKQcDRHn0TmSjohdjDSI9CJB11WxwWD9zn0ujijfZ5ddXJp/6aeeCdlsmqqWHD8sQ=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
	dmarc=pass header.from=<linuxuser509@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779459288;
	s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nu+EHuki7/RBRPdPYUfzJTb7Doc+NthJaDSnx91oBp0=;
	b=oFw6aCAlYn2Oe0s6d8MACe0Vba9BCFNHVjlOX0VQjQ7s0XyPhZaskWddJZFKXS4/
	k5JE5hToZ3jRO93MBDrgC1EKvuElhLNJYO/Dl2/KnrvV0CwH8aRMA+IHZchQi58xBZa
	Hn9hwwqednSmr3lIEggWvMyIGQFy8ZmsSdTKftSw=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1779459283345974.2261139395849; Fri, 22 May 2026 19:44:43 +0530 (IST)
Received: from  [157.35.75.45] by mail.zoho.in
	with HTTP;Fri, 22 May 2026 19:44:43 +0530 (IST)
Date: Fri, 22 May 2026 19:44:43 +0530
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
To: "linux-mmc" <linux-mmc@vger.kernel.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
	"adrianhunter" <adrian.hunter@intel.com>
Message-ID: <19e5009d987.8379fb8938306.7573506608157081813@zohomail.in>
In-Reply-To: 
Subject: [PATCH] mmc: sdhci-pci-gli: Fix GL9767 s0ix sleep blocking
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

From 42b314da9b13f5aad38c7a58bc4191b08d6b2156 Mon Sep 17 00:00:00 2001
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Date: Fri, 22 May 2026 19:39:12 +0530
Subject: [PATCH] mmc: sdhci-pci-gli: Fix GL9767 s0ix sleep blocking

Add missing suspend callback for GL9767 chip. Without this, the
SD card reader remains active during system suspend, preventing
the CPU from entering low-power s0ix states.

Use the same suspend function as GL9763e, which properly powers
down the device during suspend.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219284
Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
---
 drivers/mmc/host/sdhci-pci-gli.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 6e4084407662..b6251cdde228 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -2121,13 +2121,14 @@ static const struct sdhci_ops sdhci_gl9767_ops = {
 };

 const struct sdhci_pci_fixes sdhci_gl9767 = {
-	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
-	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
-	.probe_slot	= gli_probe_slot_gl9767,
-	.add_host	= sdhci_pci_uhs2_add_host,
-	.remove_host	= sdhci_pci_uhs2_remove_host,
-	.ops		= &sdhci_gl9767_ops,
+        .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+        .quirks2        = SDHCI_QUIRK2_BROKEN_DDR50,
+        .probe_slot     = gli_probe_slot_gl9767,
+        .add_host       = sdhci_pci_uhs2_add_host,
+        .remove_host    = sdhci_pci_uhs2_remove_host,
+        .ops            = &sdhci_gl9767_ops,
 #ifdef CONFIG_PM_SLEEP
-	.resume		= sdhci_pci_gli_resume,
+        .suspend        = gl9763e_suspend,
+        .resume         = sdhci_pci_gli_resume,
 #endif
-};
+};
\ No newline at end of file
--
2.43.0


