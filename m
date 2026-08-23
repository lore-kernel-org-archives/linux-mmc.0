Received: from stasiak.at (moria.stasiak.at [149.202.190.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118F263F4A;
	Sun, 23 Aug 2026 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.202.190.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787449347; cv=none; b=eh8/zGTnucNnTX5xgeqJ0WdiwP5H4+uZpMbe4FLbGPtoY9XVNwuP3a1Xb/W09dWIpYbmrJQpViv6MS/Kq/pUR5N2vmy3OKWflbV5M8fZXweKw87DtW/svpFGrahgCEq9Nv9fqYZLQ+7OR8QWuliXrayTaZtuaXZ0Y5oG7rTEuOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787449347; c=relaxed/simple;
	bh=UNPT1cWIcJtUEGRdXiwl3pEOBlKppMqmATuTY/IoOS0=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=ufAcZoJWq56CZC6bUL3/6uFQkxGOLJq3z0bOONG0c0a+Hxbv+hePw7HL8dyGPo6/DriqwhswCOFx7/rknSAMnfiQ7aLskDQkf6wNFaeu7XK1FgtEpCsHXC7a1dOxlmqidCNO0/ZVySnVS/oOtunjoDMH7TXXCvzCNMnm5KrrZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stasiak.at; spf=pass smtp.mailfrom=stasiak.at; dkim=pass (1024-bit key) header.d=stasiak.at header.i=jakub@stasiak.at header.b=FSMP8bW8; dkim=permerror (0-bit key) header.d=stasiak.at header.i=jakub@stasiak.at header.b=mtWrikhQ; arc=none smtp.client-ip=149.202.190.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stasiak.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stasiak.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stasiak.at header.i=jakub@stasiak.at header.b="FSMP8bW8";
	dkim=permerror (0-bit key) header.d=stasiak.at header.i=jakub@stasiak.at header.b="mtWrikhQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=stasiak.at;
	 s=dkimrsa; h=To:Cc:Date:Message-Id:Subject:Mime-Version:
	Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rfpK9wR3JknbXtIy96EXdqBy3+L/JujfXfIzVMx7W6A=; i=jakub@stasiak.at;
	t=1787449344; x=1787535744; b=FSMP8bW86QxEd18ua9R+GZCZwT5cHmQ0k66MHH+V8blcfJe
	mPnCUW/G4SWScX/eFp4WmRsasPKkUjMxTg34gZDJpsE22KEBwJad1NPbrkV7MJO/hvuSpB/LR2FCN
	F1wUQ3hQrYYf38qIoduXuRPN2hGhgVAGBfKp9pzxWoXgP54=;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=stasiak.at; s=dkimed25519; h=To:Cc:Date:Message-Id:Subject:Mime-Version:
	Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rfpK9wR3JknbXtIy96EXdqBy3+L/JujfXfIzVMx7W6A=; i=jakub@stasiak.at;
	t=1787449344; x=1787535744; b=mtWrikhQGc+N/m9U5PSfHhRHhPrE/cBXDxplGXXde4tODC+
	MYfi7CO4+wOtfUQo9Kbmm9LbGF3L7ELyIjBb6DQ==;
Received: from [178.217.196.232] (helo=smtpclient.apple)
	by stasiak.at with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <jakub@stasiak.at>)
	id 1wxwuJ-0005Ei-5K; Sun, 23 Aug 2026 01:21:55 +0000
From: Jakub Stasiak <jakub@stasiak.at>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [PATCH] mmc: core: Sanitize CID product names
Message-Id: <90559C11-0553-488B-B3EE-DE769D61847E@stasiak.at>
Date: Sun, 23 Aug 2026 03:21:43 +0200
Cc: linux-kernel@vger.kernel.org
To: linux-mmc@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Some devices return nonprintable or non-ASCII bytes in CID product
names. One example device reports H8G4a followed by 0x92.

This led to downstream problems like in pyparted[1] or systemd[2] where
the consumers assumed the names were effectively ASCII-like.

Commit 3b791214c8bc ("mmc: core: Trim trailing whitespace from card
product names") established parse time normalization for CID names.
Extend that normalization by replacing bytes outside printable ASCII
with a question mark after the existing whitespace trimming.

The raw CID remains untouched. This patch doesn't change the lengths of
the sanitized names.

[1] https://github.com/dcantrell/pyparted/issues/76 (already fixed)
[2] https://github.com/systemd/systemd/issues/42930

Assisted-by: Codex:GPT-5
Signed-off-by: Jakub Stasiak <jakub@stasiak.at>
---
 drivers/mmc/core/core.c | 21 +++++++++++++++++++++
 drivers/mmc/core/core.h |  1 +
 drivers/mmc/core/mmc.c  |  3 +--
 drivers/mmc/core/sd.c   |  3 +--
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 29e80e5f928e..0de2a0133f13 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -8,6 +8,7 @@
  *  MMCv4 support Copyright (C) 2006 Philip Langdale, All Rights =
Reserved.
  */
 #include <linux/module.h>
+#include <linux/ctype.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
@@ -23,6 +24,7 @@
 #include <linux/fault-inject.h>
 #include <linux/random.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/of.h>
=20
 #include <linux/mmc/card.h>
@@ -52,6 +54,25 @@
=20
 static const unsigned freqs[] =3D { 400000, 300000, 200000, 100000 };
=20
+/**
+ * mmc_sanitize_cid_name() - sanitize a CID product name in place
+ * @name: NUL-terminated CID product name to sanitize
+ *
+ * Trim trailing whitespace and replace bytes outside printable ASCII =
with '?'.
+ */
+void mmc_sanitize_cid_name(char *name)
+{
+	char *p;
+
+	/* some product names may include trailing whitespace */
+	strim(name);
+
+	/* Keep product names safe for sysfs and uevent consumers. */
+	for (p =3D name; *p; p++)
+		if (!isascii(*p) || !isprint(*p))
+			*p =3D '?';
+}
+
 /*
  * Enabling software CRCs on the data blocks can be a significant (30%)
  * performance cost, and for other reasons may not always be desired.
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index a028b48be164..0ec5ad66fb7c 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -41,6 +41,7 @@ struct device_node *mmc_of_find_child_device(struct =
mmc_host *host,
 		unsigned func_num);
=20
 void mmc_init_erase(struct mmc_card *card);
+void mmc_sanitize_cid_name(char *name);
=20
 void mmc_set_chip_select(struct mmc_host *host, int mode);
 void mmc_set_clock(struct mmc_host *host, unsigned int hz);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 05444ecf3909..dca76be9f0dd 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -117,8 +117,7 @@ static int mmc_decode_cid(struct mmc_card *card)
 		return -EINVAL;
 	}
=20
-	/* some product names include trailing whitespace */
-	strim(card->cid.prod_name);
+	mmc_sanitize_cid_name(card->cid.prod_name);
=20
 	return 0;
 }
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c763efb10f64..7dc2b791f44c 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -97,8 +97,7 @@ void mmc_decode_cid(struct mmc_card *card)
=20
 	card->cid.year +=3D 2000; /* SD cards year offset */
=20
-	/* some product names may include trailing whitespace */
-	strim(card->cid.prod_name);
+	mmc_sanitize_cid_name(card->cid.prod_name);
 }
=20
 /*
--=20
2.55.0

