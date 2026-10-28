Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191894;
	b=ucQsDtfNk/ukPZaoVIp5hLjLFLSGx1wki9Hzj58x8YO91kjkWK0GnHa46xPBsqAgrzLP
	 Oyx5Z/ayZPMNi9H1fRzblaWY36qOJQeKZLZGVK7ffnU162c59vbUyV6TrwYAmJoL/hfjm
	 3rjp9H4QhPURyC9aTmzDVRqQ97e0tECT0oNaDV+hAXZ7FUoaoFOtdHjftWCgwg9KcBpQt
	 kSNfbCECT1LJ6/KWck/zBNZboEuNi2WiqxJ3vXPDbsaEdbiYKNURKLw/01Xx6PJgFpgxJ
	 7qUaw4VjlBxWD06NAveJ6iOaJWNuUF53A1OpWT3QYXw0T6TCfoAnKTj4OxR3YZ0XrbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=58mU3YE1A8ySMdmeUGmqkV/ZZ/o0/aVwbVzGIHclv1c=;
	b=cKz/K8gMwvuKtWASTX3z2FkT2BKCI89D4NXvDIWtpCcg5lI6m4Kpg1GBm/dqG06PCLiC
	 gFTAgGEoqZsQ/vTn06Rk21TXYeTT1UHq/IvAmsJgznZ8wbC5ipcC+xDH4snBHagpjaTKP
	 T13qC7m+gR0w0/8NgL29RFBEHBsEb9yLx/LEUY3i2oQzrQ9ZIHF9drLeUCgDgARiDXSvX
	 SECz9h1UYtHQuXKRiwtjNAyYAmYlpav4NiOCUw3pOTwrDmDGoBkMg7GKI2wzrhOUe3fs/
	 dIwTd1jx1QOOGQ8FiEToKpUc0V7JbhJDDfWHxd4XIKWJn0ldteHxpXXx7koXCKjbHoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cxv0F5G+;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E376860A5BCF
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 12:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E376860A5BCF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cxv0F5G+
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48dfb76b304so143273f8f.2
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 05:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793191892; x=1793796692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=58mU3YE1A8ySMdmeUGmqkV/ZZ/o0/aVwbVzGIHclv1c=;
        b=Cxv0F5G+jXvHhAayNWRctdZCvgaTHYI7gEQ0bpvPR4tVX0JbRzaa/stQxFjqLVyDZq
         dVq5zYYk67wQJOV4Vm42Ajt0Oq9zH8SAIWqL/DyH8Xz3CsmoYtjnCD4YrUoSiyn3oyQW
         PO/q+P33m3PonZ3LotTCOCRocp1tZWNUdlBUaOYh4vz4pZNr+MYsEkVQ94T6Td7lNSGQ
         Oqg2yXtCOuq6RDfPKelMuVsoEANnthgRjaHoJchsgr/+6fjmTsZhRx03y3qvbUagednU
         tPjRfup1kbyNE7opiQpLOzpFkiQmuILdP2b3BP4dg0FXxoK1f/v4vmzxf4gRnY1HNoaQ
         U8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793191892; x=1793796692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=58mU3YE1A8ySMdmeUGmqkV/ZZ/o0/aVwbVzGIHclv1c=;
        b=PdhGzLdnM7oOPBhqyN5u+4WG+vZliMtWPrF6Ql08fMiBt4dt6uLRgTE1N9/+y00kpU
         Jijul9/+QWlHW1+otfMgIzhPowJeMTSUgNDpnoJdlK3CdaWw69aN8VXwIaXO0rdPT2Eg
         VKH2elnk2wTOgozh0sP0fh19okDhouG3vaSbfO6d0KyHqm+b1f7QTpj4AgWhi/g0qLdF
         tk/Uv0V+UWMxEzQFK8hzf4rXvb591xDw5HwEHM5zKy4s8oCmN5KC2taJk8wGHY3KYOG+
         Q5Myx1608gWMCzBVlMy6vsrnq77uXiZ08u3emE0B4oFLCDjAIwed6WRuo4X8ZwJM8LMl
         WgDA==
X-Gm-Message-State: AFq9FYL7tBh0xrjkCLP5hjHdtvh95ZF8YhdR73gpp/iuhfNef3DhJNfG
	VkGMZJWwU926cIBQ+Vz3YZSL5moctXJ+Nfy1N0SjxCHrYvnfaYijiOyw
X-Gm-Gg: AYBFou3yiTH7yD7QYq2pIWMFFOYIda7jY6t9v/z82sxIC7U/kJkVN27DoXTVpJKkRmf
	AehMBDj4/xlfHMkNtkQXF3Kqu59BF+5HjTR55HxKgQKDlYDQClynx3e1yM3LQ9bbVXQFd4/Rm7X
	4lAWnLJ11VwbVCOcbGzdv9zlVdD3SwgZo7ZVlqK3ctaorkWdKM7LjH4euxjIGEz6KGwVVIvH7qv
	GDBTwD8tKO7Vg6fH6Ec+KOsD9l0XzQ2s/UGGxiklDjUd5g7mS41+tjNmvgwZ/B3Pn78KsI8fOPv
	UN4+BUNy3b33ZpUSBjL9GvWxEzqV/cnrXY3xsBmlw/CoheInf+T7nWhu36OlpqN/cNp/nYVYOwD
	Aro6miueDE0wLJmJolSVm+L1wIXDLYZc/lPjsnLrheJWX+ApxuldvmMsLQrIH0XjuvCWahu/frM
	mOJyHqzrDL3pH3UYCvU1XGxmwAAnGtVukNGnq62YLNyC/Q56BmyCxeX2dWGDo8jPS9S/coQdzBQ
	Sgu5EDEMrG1DRQYcA079Ov5TvRcESFxXZbN/QWp9JuDlJcvWFgqgmpST72wUHrsrzjRdQTXD5W4
	O8FxxeMB2rDZD23wpr2Dk2y5XY4Ay60anj+jfhbMJtTixKonNYAq0rVhq+nhqZrFeBM=
X-Received: by 2002:a05:6000:3102:b0:487:13f:f612 with SMTP id ffacd0b85a97d-48e5d5d802fmr5596555f8f.37.1793191892168;
        Wed, 28 Oct 2026 05:51:32 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6bf5:6c0a:cf99:c9f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39b3sm29275016f8f.10.2026.10.28.05.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 05:51:31 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Wed, 28 Oct 2026 12:51:27 +0000
Subject: [PATCH v25 10/11] mmc: renesas_sdhi: Add write32_hook for
 CTL_SD_CARD_CLK_CTL register writes
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-rzg3l_sdhi-v25-10-57f16691c2ed@bp.renesas.com>
References: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
In-Reply-To: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793191879; l=3693;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=ltWOzQvnXnaIZzBe/fnpRtSR9lOqq9Os7KYKzujgEKw=;
 b=/gBzy0L2P6XiAi0r9ZxYLEERTAZkDff5ULocuimlZsTKkG2n7ba8hs/euuypHKf0FdLK17Omi
 3yeK/f6kiHYCk4b98wHwfG7nArdFyebiNldvD+asBE2Fp3NDdeoVdUB
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

Add a write32_hook, analogous to the existing write16_hook, so that
sd_ctrl_write32() can wait for the SD bus to become idle before
certain 32-bit register writes.

renesas_sdhi_write32_hook() checks whether the target register is
CTL_SD_CARD_CLK_CTL and, if so, waits for TMIO_STAT_SCLKDIVEN via
renesas_sdhi_wait_idle() before the write proceeds. Other registers
are unaffected. As with write16_hook, the write is skipped if the
hook returns a non-zero error.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v24->v25:
 * Updated comit description.
 * Updated tmio_mmc_host_probe() to set write32_hook() to NULL if
   TMIO_MMC_HAS_IDLE_WAIT is not defined.
v23->v24:
 * No change.
v23:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c | 9 +++++++++
 drivers/mmc/host/tmio_mmc.h          | 7 +++++++
 drivers/mmc/host/tmio_mmc_core.c     | 4 +++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index e897328d5b70..cb41f38ec80e 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -965,6 +965,14 @@ static int renesas_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
 	return 0;
 }
 
+static int renesas_sdhi_write32_hook(struct tmio_mmc_host *host, int addr)
+{
+	if (addr == CTL_SD_CARD_CLK_CTL)
+		return renesas_sdhi_wait_idle(host, TMIO_STAT_SCLKDIVEN);
+
+	return 0;
+}
+
 static int renesas_sdhi_multi_io_quirk(struct mmc_card *card,
 				       unsigned int direction, int blk_size)
 {
@@ -1199,6 +1207,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	}
 
 	host->write16_hook = renesas_sdhi_write16_hook;
+	host->write32_hook = renesas_sdhi_write32_hook;
 	host->clk_enable = renesas_sdhi_clk_enable;
 	host->clk_disable = renesas_sdhi_clk_disable;
 	host->set_clock = renesas_sdhi_set_clock;
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 3ab8c0d8a2bd..e29a2fe06ef6 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -189,6 +189,7 @@ struct tmio_mmc_host {
 	int (*multi_io_quirk)(struct mmc_card *card,
 			      unsigned int direction, int blk_size);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
+	int (*write32_hook)(struct tmio_mmc_host *host, int addr);
 	void (*reset)(struct tmio_mmc_host *host, bool preserve);
 	bool (*check_retune)(struct tmio_mmc_host *host, struct mmc_request *mrq);
 	void (*fixup_request)(struct tmio_mmc_host *host, struct mmc_request *mrq);
@@ -283,6 +284,12 @@ static inline void sd_ctrl_write32_as_16_and_16(struct tmio_mmc_host *host,
 
 static inline void sd_ctrl_write32(struct tmio_mmc_host *host, int addr, u32 val)
 {
+	/* If there is a hook and it returns non-zero then there
+	 * is an error and the write should be skipped
+	 */
+	if (host->write32_hook && host->write32_hook(host, addr))
+		return;
+
 	iowrite32(val, host->ctl + (addr << host->bus_shift));
 }
 
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 4116c4d29c63..4fe98b437121 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1169,8 +1169,10 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	if (mmc->f_min == 0)
 		return -EINVAL;
 
-	if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
+	if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT)) {
 		_host->write16_hook = NULL;
+		_host->write32_hook = NULL;
+	}
 
 	if (pdata->flags & TMIO_MMC_USE_BUSY_TIMEOUT && !_host->get_timeout_cycles)
 		_host->get_timeout_cycles = tmio_mmc_get_timeout_cycles;

-- 
2.43.0

