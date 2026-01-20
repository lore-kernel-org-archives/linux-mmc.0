Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E7513635E;
	Tue, 20 Jan 2026 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914358; cv=none; b=UZe8fvX+trv6VpKnxX7gzGFVEqFIEgQrjzy4i3/XKn9/26zKdiQZcCFzYJSoBAEENL7YWQ7kkxz1g6aJ+MCgI9GJx4Xh6pxGJOqiT1qenoGSDidZXdbWvGvYeaA4cQiX16jFvpmc0VGBcSxFi0S40YAO00Davh32CJOqoZpF+Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914358; c=relaxed/simple;
	bh=Zpm5bBaitIAgJU+txNqeMnHS453WDQeF8ltBkZFe68g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lxtGZAEtcNitqb0KWNdG3qgCZ7UeazDK33Xmouvxn5gltyF174Lzh6s9dbnQxSF0/thbTS0Wf+Ll4LC/b/MzToi700xIu4ZBO/e5vjy8sEQFkHwgZQ+vh/N+38LeZ1VPB58lCbeg6VTfRGr165C2QZSFYsuXKmiwBFK34q2RmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TceWSheC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TceWSheC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB24DC16AAE;
	Tue, 20 Jan 2026 13:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768914357;
	bh=Zpm5bBaitIAgJU+txNqeMnHS453WDQeF8ltBkZFe68g=;
	h=From:Date:Subject:To:Cc:From;
	b=TceWSheCy5bEE1q2PFdiRkPXQqHwo8aFrU49ADJdYxrj3vPKy9Im2go/QUg8NP2He
	 kM6iPC0XSohcBCmi+JVd4/QyNPRMYFytSDkkw/n+RdE7Qlbjiw2juZ0tVKd4CjZt/v
	 SbVrzW4PWFqbELNXd7oSx1P+cYq+4Fjl+iObQM6mSD7ygSqijyI23ftC6wTIjn2rQU
	 Yw4jXVzaEevclUH7ORqIHJmX0L6Z1kwppF69xWW19/oLBGzXz97rpvgqVMhw/9a7hd
	 wSUa4sCwkX5JAxH2OZELa6f23355foSVOgja4WQqk6lNsi1seJLHpDB0d+nUkGlDnf
	 4LIs/ANb6FhgA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 20 Jan 2026 14:05:50 +0100
Subject: [PATCH v3] mmc: sdhci: Stop advertising the driver in dmesg
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-mmc-no-advert-v3-1-1c7a6a55ef9c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMQQ7CIBQFr9KwFgNIkbryHsZFC5/2JxYaaIim6
 d2lXamJbzcvmVlIgoiQyKVaSISMCYMvcDpUxAyt74GiLUwEEzVn7EzH0VAfaGszxJlqVyupjJT
 WKlKcKYLD59673QsPmOYQX3s+8+39V8qccsqAq0Y3Vmhw1wf6NoZjiD3ZUll86vpXF0WXdWdYm
 XKd+NLXdX0DZ0d5/uoAAAA=
X-Change-ID: 20251007-mmc-no-advert-8f5646c44dd6
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.3

From: Linus Walleij <linus.walleij@linaro.org>

As much as we have grown used to seeing this message on
every kernel boot, it does not add any technical value.

Drop all messages from sdhci_drv_init(), and drop the
module_init() and module_exit() calls as well since they
now become empty.

The modules becomes a pure library module, meaning it will
get pulled in by modprobe() when the symbols inside it
are needed, or compiled in if any users are compiled in.
Kconfig already makes sure this module is compiled in
the users are compiled in.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Rebased on v6.19-rc1
- Link to v2: https://lore.kernel.org/r/20251008-mmc-no-advert-v2-1-45bc00006fb2@linaro.org

Changes in v2:
- Drop all the messages instead of demoting.
- Link to v1: https://lore.kernel.org/r/20251007-mmc-no-advert-v1-1-0e16989d28ef@linaro.org
---
 drivers/mmc/host/sdhci.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ac7e11f37af7..1ff15fa9b042 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4997,22 +4997,6 @@ EXPORT_SYMBOL_GPL(sdhci_remove_host);
  *                                                                           *
 \*****************************************************************************/
 
-static int __init sdhci_drv_init(void)
-{
-	pr_info(DRIVER_NAME
-		": Secure Digital Host Controller Interface driver\n");
-	pr_info(DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
-
-	return 0;
-}
-
-static void __exit sdhci_drv_exit(void)
-{
-}
-
-module_init(sdhci_drv_init);
-module_exit(sdhci_drv_exit);
-
 module_param(debug_quirks, uint, 0444);
 module_param(debug_quirks2, uint, 0444);
 

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251007-mmc-no-advert-8f5646c44dd6

Best regards,
-- 
Linus Walleij <linusw@kernel.org>

