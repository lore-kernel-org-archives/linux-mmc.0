Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383894;
	b=vlZyT8Rlo0V9g0xV9Bd6Npvf7sdDka7XxQXKM222aqdbB63s2J7A6mv+aVaJlInzf6vy
	 EaIGKMjG/Xb+wPFNWx2XkhX7aTXRHqwW3XjpfuH7zOdPIl36Vo+JQUfAV3P0WJlsPWWPy
	 DpAay8WB3CrrNR3DHyuC3w1ljkYWFxD3oHMmUY91aIWko4+NH3k4kGBEaTa14DvuhmheX
	 2+yE+XwQFgAtpnzdJ1X78UsN7SlaxByAK3HbFTrTU+XluCHlgaywFrtVr6rGWFfkb2IZO
	 6lRx++ttSVDamjAbaiC7L9TWSiL6zYHg+h3eoAasjqtC0edA1ZnHBJPjhst3D0le/8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383894;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=+fmQH2G4+P7KftvrZHK9RuK3II+Le+LmlAkO9aH36u8=;
	b=SOB/UevKZ60yHylhxXnGqdkw6esoTtxX1/Dfjxwd+on0IkTbYBZUtOnIwV8TEIBiBRhe
	 oIWR23eQKmyG13p3hR0RTgjcJ2//6e6oBUVZcBXieZl3LnCBFgYQG7DnoXSR9te1rqAIl
	 Q6cCA6Zp61r6mkAQrRRCYuO30Qtd4myiZm5AbBtsPNWFplhSSsIiMRhNEZsnJr5bpXg+4
	 72q7bK9sMscUNRID9tJMsVmXK/ZYyQuUrw1nZRzY6GDSF2OvGWVnI/FgwIUKrQygxYL6x
	 PRCWc1+vqPaxH7Epwb+dMdFfbnqgn+SXPqFIV81PTGJbc4WTxgLe4qtzvZBOKrNwvJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f1xbbqKr;
	arc=none smtp.remote-ip=209.85.222.97
Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4415660A2601
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 18:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4415660A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f1xbbqKr
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-9828fee1b4bso282026241.3
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793383879; x=1793988679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+fmQH2G4+P7KftvrZHK9RuK3II+Le+LmlAkO9aH36u8=;
        b=vSscSUilS1uqljS8fEQ5BXZbRFMIn19VJuP2ANx5uZyBuup8labwz/eXIrqSlJuQt0
         eVLfWRa5n9v9Ag7hl/ZG0i1z/xLKRrha1xS7zWN0sVaFy6RLbHUemleeR3fHLOAPLlNk
         Ll2PJxoBPENEPXvQ8bT1M4NLAcE+Vzd8HDgcmQQ/HCArujJcQcy32dI3o68V5txSgTUB
         Qwn7fuGq6vGS5NhRaesVmDQ+WkwskvC5w80v+b+EWn+Z8Uf04GlpSUaPphmMwnzWCljl
         xiAhyB5gdzVKOexwTpbGbaaPXYs3jlTSEpbuYeXf/DlNOIuK1NOz1UIuIiFOnMJS8kCi
         4F5g==
X-Gm-Message-State: AFq9FYLCc0Jq/ofdePo7T1ZqInianNkGog8/u1/nq3EEOIqOf1rABkHc
	ow8EhvtskS9DWxAxqTGndo8XXz5nSgnRk1VVynQgBaRsOqpvfgC25a1Et343s4Co4pLBvzVaDV0
	jIUzF9rpFumqP5rSyuJ+w2rpp8Snw3FG7X5hKbdGfW7CUaEPpX5fGGa35Q9ASmyko+gEUBffHHF
	g6HQESimKNCIzG0lm8Vfs2GnFofKkAhg0w5Oy8oJYmg6btYn83ibY0a88+GtRhtzVdVapX3PvfC
	Cm+6f3re+Jz
X-Gm-Gg: AYBFou1B83YKmAQXrnvldO4lwM3tO/KF2st6nz4BKvy+YG0RYrcxWSif8i+JGiNPkpi
	PqKka9mKQQbP9nuwXtdEwOWLhx9dLcZT2tja/Z3A9RuR7RjRpDYjn8ON9LbfN40N2qRJAOzUAKk
	k/id1ZeCZ0yDnT85/NTgkjAwcBuhrSvcJqgQoGHhixKeTzt2cyPjSunRurlPmE5coweWOsCVqVO
	nlNWz5tqLNbTTe9hoks8hLFJj3ZYYyTyjalxztwpK8mJiBZap+hKuyJyfxn4RAAqutE19b8u7Dp
	M53FCCQUK/DV/48vim1Fvjx93JmsyBGwAKRMHY3oGKg/h3SfZeCk5wZYar8W2ROpfHLhcKvrg3N
	q/CnKc3mSJMG+MQnF7otqCy6vdNSkSYd8+GnbCyZT82BX9MrOd+zZwr6ALaYsyOawLdehppMD51
	f3RYGudFFf4rlETYhiUFepNLF6PYXSVnpc
X-Received: by 2002:a05:6102:50a1:b0:7bf:74c1:b606 with SMTP id ada2fe7eead31-7d07269b10cmr1630043137.34.1793383878981;
        Fri, 30 Oct 2026 11:11:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-992ee4186e9sm110500241.12.2026.10.30.11.11.18
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 11:11:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1823503eec.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793383878; x=1793988678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+fmQH2G4+P7KftvrZHK9RuK3II+Le+LmlAkO9aH36u8=;
        b=f1xbbqKrzozmHU/o50WWafFcelqr71majZcEtQY8OBGXLUIQLd/wNgDZlB9xZ1ump9
         NLzQQhGkg58b809MQ5EkxYv6AwxiXF4QY44LL5zm02t+lgB15yQbzjmSATDHTgUKSotJ
         MWQq134951FSrzbh9ij4abDoenkhn+MmM15Xk=
X-Received: by 2002:a05:7022:120c:b0:15a:4155:3d9a with SMTP id a92af1059eb24-1ac609808c6mr3766309c88.47.1793383876245;
        Fri, 30 Oct 2026 11:11:16 -0700 (PDT)
X-Received: by 2002:a05:7022:120c:b0:15a:4155:3d9a with SMTP id a92af1059eb24-1ac609808c6mr3766262c88.47.1793383875256;
        Fri, 30 Oct 2026 11:11:15 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm9974062c88.11.2026.10.30.11.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:11:14 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v11 4/6] mmc: core: Split sdio_set_host_pm_flags()
Date: Fri, 30 Oct 2026 14:10:31 -0400
Message-Id: <20261030181034.3811225-5-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030181034.3811225-1-kamal.dasu@broadcom.com>
References: <20261030181034.3811225-1-kamal.dasu@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>

To prepare for a subsequent change, let's split up sdio_set_host_pm_flags()
allowing the second part of it to be used as an internal function for the
core.

Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/core/core.c    | 10 ++++++++++
 drivers/mmc/core/core.h    |  1 +
 drivers/mmc/core/sdio_io.c |  7 +------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 677e445dc48c..6cbb5ee6200c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1422,6 +1422,16 @@ int mmc_handle_undervoltage(struct mmc_host *host)
 	return host->bus_ops->handle_undervoltage(host);
 }
 
+int mmc_set_host_pm_flags(struct mmc_host *host, mmc_pm_flag_t flags)
+{
+	if (flags & ~host->pm_caps)
+		return -EINVAL;
+
+	/* function suspend methods are serialized, hence no lock needed */
+	host->pm_flags |= flags;
+	return 0;
+}
+
 /*
  * Assign a mmc bus handler to a host. Only one bus handler may control a
  * host at any given time.
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 9be2875608ce..d3a2ff00b18f 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -64,6 +64,7 @@ int mmc_handle_undervoltage(struct mmc_host *host);
 void mmc_regulator_register_undervoltage_notifier(struct mmc_host *host);
 void mmc_regulator_unregister_undervoltage_notifier(struct mmc_host *host);
 void mmc_undervoltage_workfn(struct work_struct *work);
+int mmc_set_host_pm_flags(struct mmc_host *host, mmc_pm_flag_t flags);
 
 static inline void mmc_delay(unsigned int ms)
 {
diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 12716ec0e35d..99f857514b63 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -726,12 +726,7 @@ int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)
 
 	host = func->card->host;
 
-	if (flags & ~host->pm_caps)
-		return -EINVAL;
-
-	/* function suspend methods are serialized, hence no lock needed */
-	host->pm_flags |= flags;
-	return 0;
+	return mmc_set_host_pm_flags(host, flags);
 }
 EXPORT_SYMBOL_GPL(sdio_set_host_pm_flags);
 
-- 
2.34.1

