Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110612;
	b=N+poiXnWh5jVX0VLhAUKY12muIuCCIMUHWFfB4nmewhhj3/SDdUhKF4qnLmClVPPgH98
	 4S0qo2txoSjOCTOvH+DCiDIcgEHWPD+HWe+BBST09tR+ntq3lrOe+nPLdDQfqrts5EAbU
	 l/eFdWvt/qFInx2UI8WmNwKeGtshLP4fQf1WMnfG9nzkcXMuLXdJSZFo4E8OXzvucZetl
	 kFRBgRALn7LucWkF+bqKW/q6tkxQO2xiF0Kvib2an3kV5IpV1hSvpa20CSqGevMdir4p5
	 9GDt+wmcEF8DwRPTOwyLeVZMxylzieW2svlf/7fhVnDoarbO19VSOV6o1JxpJKwvF2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+y4Dhz36GBPfKNKm/OZQCyp1F0ego1607MuK1Oaddis=;
	b=n0vMfuYwxnjpLDnc+Mqvb7cKDy1arB0mQ/jvGUQy7g6U62EpPebe6OWVyQdjKmbhcGuA
	 YQnrEgNckz4kZ18uyCLlXRI2NE5c25Wx6tjoamfzu2KAQ6gkRCDPRzzK2R5m0QLFrNOD8
	 zhVdHg/r6j6ckZm3h9D7zg41TZe/A/lWLE15jJuM9pv97yUQwosyeTTMyK+1IfBrpqGY6
	 WDwtskwrbtvOX3KXJUQLFzvyTfE5RVhRlzF0ClNy14dTeCoJau7DWu2wNd/YAN7cypE8j
	 ftmmTmxiY2mazKa0wDbqKR4OpLEErVGSib4LFW6FMlDFVrXvIr9cYM+n3TnfShC2E7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aheymans.xyz;
	spf=pass smtp.mailfrom=aheymans.xyz;
	dkim=pass header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=noXf1rHX;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE9F606A330
	for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 17:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BE9F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=noXf1rHX
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so27641545e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 09:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aheymans-xyz.20260707.gappssmtp.com; s=20260707; t=1795110609; x=1795715409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+y4Dhz36GBPfKNKm/OZQCyp1F0ego1607MuK1Oaddis=;
        b=noXf1rHXHVA5Bo4zBqtRn+YjTYtHNXGVE83xggHGKpOWjneiUdG5LTFmE9tzs3PcFi
         QDgwMI0eZzahFKbbUHQxOzro7v4Hw3kiJ4m3AYRUtEkI7RUatHAETc/wADxUDy48QzWy
         NltjoUQNyPz91+WrQGjtvuHrtGTA7HQakwoozd0ncQc5831PnXftOw4lhkDLw/7sDU2A
         5cF+ssEbbYVFSUwmA53rpP3GVOutHQ/72+f9fJqIRZo1Deuv6sQUSQjSD1ZU8RhziwLX
         M6YNfnpf2S1ZK5CHuPW2PZYCZ/XVkE7wLBdZJYg1Er631mnNtAF3hoy2QVU+0gJo2z8X
         JXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795110609; x=1795715409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+y4Dhz36GBPfKNKm/OZQCyp1F0ego1607MuK1Oaddis=;
        b=XSXVUJf4N3PonBuuwfvk40wRN0bssOWT+pDNfHooSBVB1VxJPUDYFUS7XZzTlSGx1P
         3bVVSKN9nrc0w4Vs2PbJZ2Wd6SwuR0DWIsuR43l2GXZOOrTqnObCE/55o0iQxAJERkDq
         YtQJxFCBSy+sX4nxOCwMEM3Tse/NMhhKieunfy9TwD6w1idHuLVMOv+TGRbmmP44kW3Z
         mDgqk/mpkNo6j1WT8oDjWeaMPFougPFo3zJlhoW1sx+LlvDNL6cEjnrPV0aXb8CILUvW
         2NpSNtxwI6d1MCs8KUV99TZ4w9bA7PPKEajn9aqhUvicc11VwGa4PWe4Roi3E6Tf5IsN
         DXYg==
X-Forwarded-Encrypted: i=1; AL+hErEQZuapyu7ixwwfQoyRKwnM7Eu7wHdadIp/o84Zqn8vSVGGZKdWoy4JS6Ydgm5LhXmyNvTqbtwCn20=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sefiGKULGtcjnZCIA8KAX4rFJ4GQ6FIUDaYpeqn4hR7An7rOs
	YrHpe4F9UADUBSO/Z1Izs/M1kD6h9q/xTK+nvmSZiuP8IuqCvfkWUE4vwyHWOaPbSfE=
X-Gm-Gg: AYBFou3Ifra5A0n3sfPjfc6ykiF+9KXGxoiV6XvrIcajKLSlSBjInNAUtBYy3QfxfRi
	sDJnpgM8jjDp68o1S4FunbgzaraHt2R3dh+SxE7ERiRMpS7HTOdnGHQsa3jOhS6fpkl+fTYnph9
	XatbQN/gm7QhHqNaFPhQWXERbJ+aRnGsCCdIOF6Ac56fjChG4Sq61Q3CEBjsGOIrFK8bB3xgyUy
	QCh3B+KbfJwWr9DOSPeGhVgb1pe+wWLw2aoTwOtV3nA5Sup8JHBxf1vmKmJPUWlNXf+Qo6rGeEI
	ywaGdqHobp5d63SrNKlbfuJIdBve8CFGzT88p0uaDN4+41+gwLQnH+XAOutkoLIiaZFtgN1nOeu
	HXoiKojbExHaln2mu6NHh3BlQ9TfK4agQZS/pFYrN9fjqYO5A2CLGJ/CTNBghFSRbAyT8Tkvjbk
	kzmekv7yMxkT1jQBDoQ8vUEct3sTPPTTRzNtxy5Vy6m0D1piSMuubgsMe/or8Nwlfz8wPGl0xGk
	/93tHBcfqg2PsxLwYB/hNXFh6ti/No0PdCUddQpTMsDE9ZpkVtEAVdBuRdsdJJIR3OAhAedyPGk
	eAcrzjfiZ1MKvuwAQ04EhmqINFgWMOEm0gKpvfuqsDfyne+RHuvaJb++Jb2Li5QUok5Lhtr4/kH
	Tg454VC4NLWiVM+k3x4X/06HIGZbTm5SU5kfUsJhCwydt+ZIfLwaNJQdvG41caZM77JFUb+/u7B
	paQQ==
X-Received: by 2002:a05:600c:6290:b0:4a3:59c9:a743 with SMTP id 5b1f17b1804b1-4bb8882a21amr5216045e9.27.1795110609383;
        Thu, 19 Nov 2026 09:50:09 -0800 (PST)
Received: from localhost (2a02-1810-b422-d400-611-84c9-252f-74ad.ip6.access.telenet.be. [2a02:1810:b422:d400:611:84c9:252f:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e06c73sm90730215e9.2.2026.11.19.09.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:50:09 -0800 (PST)
From: Arthur Heymans <arthur@aheymans.xyz>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	Solomon Peachy <pizza@shaftnet.org>,
	linux-kernel@vger.kernel.org,
	Arthur Heymans <arthur@aheymans.xyz>
Subject: [PATCH wireless-next 01/10] wifi: cw1200: avoid removing the debugfs directory twice
Date: Thu, 19 Nov 2026 18:49:53 +0100
Message-ID: <20261119175002.458988-2-arthur@aheymans.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119175002.458988-1-arthur@aheymans.xyz>
References: <20261119175002.458988-1-arthur@aheymans.xyz>
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

Unregistering the wiphy removes its cw1200 debugfs directory. On SDIO
unbind, cw1200_debug_release() then tries to remove the stale dentry.
Leave directory removal to the wiphy and free the counters as before.

Prepared with OpenAI Codex.

Fixes: fa8eeae10257 ("cw1200: Remove "ITP" debug subsystem.")
Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
---
 drivers/net/wireless/st/cw1200/debug.c | 19 ++++++++-----------
 drivers/net/wireless/st/cw1200/debug.h |  1 -
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/debug.c b/drivers/net/wireless/st/cw1200/debug.c
index 7dad6d3ba239..6b8b6ca35103 100644
--- a/drivers/net/wireless/st/cw1200/debug.c
+++ b/drivers/net/wireless/st/cw1200/debug.c
@@ -359,19 +359,20 @@ static const struct file_operations fops_wsm_dumps = {
 
 int cw1200_debug_init(struct cw1200_common *priv)
 {
+	struct dentry *dir;
 	int ret = -ENOMEM;
 	struct cw1200_debug_priv *d = kzalloc_obj(struct cw1200_debug_priv);
 	priv->debug = d;
 	if (!d)
 		return ret;
 
-	d->debugfs_phy = debugfs_create_dir("cw1200",
-					    priv->hw->wiphy->debugfsdir);
-	debugfs_create_file("status", 0400, d->debugfs_phy, priv,
+	/* wiphy_unregister() removes the whole subtree. */
+	dir = debugfs_create_dir("cw1200", priv->hw->wiphy->debugfsdir);
+	debugfs_create_file("status", 0400, dir, priv,
 			    &cw1200_status_fops);
-	debugfs_create_file("counters", 0400, d->debugfs_phy, priv,
+	debugfs_create_file("counters", 0400, dir, priv,
 			    &cw1200_counters_fops);
-	debugfs_create_file("wsm_dumps", 0200, d->debugfs_phy, priv,
+	debugfs_create_file("wsm_dumps", 0200, dir, priv,
 			    &fops_wsm_dumps);
 
 	return 0;
@@ -379,10 +380,6 @@ int cw1200_debug_init(struct cw1200_common *priv)
 
 void cw1200_debug_release(struct cw1200_common *priv)
 {
-	struct cw1200_debug_priv *d = priv->debug;
-	if (d) {
-		debugfs_remove_recursive(d->debugfs_phy);
-		priv->debug = NULL;
-		kfree(d);
-	}
+	kfree(priv->debug);
+	priv->debug = NULL;
 }
diff --git a/drivers/net/wireless/st/cw1200/debug.h b/drivers/net/wireless/st/cw1200/debug.h
index 80bc1567533a..339a375b4c18 100644
--- a/drivers/net/wireless/st/cw1200/debug.h
+++ b/drivers/net/wireless/st/cw1200/debug.h
@@ -10,7 +10,6 @@
 #define CW1200_DEBUG_H_INCLUDED
 
 struct cw1200_debug_priv {
-	struct dentry *debugfs_phy;
 	int tx;
 	int tx_agg;
 	int rx;
-- 
2.56.0

