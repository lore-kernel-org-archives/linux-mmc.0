Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795334299;
	b=NArN/7YPUZoU5q9ESmcokYkTKcjtLGQ3sXWmuwBDcpo8CXSLC3BnEUUEcaoGB+DA56ri
	 LPjeIgK6nspiVSgiX3q2E/r7Hq3Tc+aC3H6liD+H1nNGQ/HTXaL/qA9+KO8rYrNrv3rhT
	 Y/zYR5CRbaIdlFRHKU8Vne0Sm5VrTBpNWH3P+QHOL27Ea2BNw8Umlzp8lM9vEvh0LzKVF
	 j9Z5RK/zgvFWaOdVTCO7UB3dzBiwMo09URgfiWvHk1iXU0eOB7nth7o76QxpkMiah4qBJ
	 pChBgAHjK9e3UIOaDl/yQ45Mt2YDrJnwQZq6Cavl+7NQmV294kNAOdhjUcz8MTxaD6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795334299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UnoQBYDYgrvm0uzeAP1oNmC1dNptSUJaGHHy2JIxghI=;
	b=5TGM/4Icdl0BFlnhz2p78dGAe8O/skeNUAXDLiy/fjgDbQfrAGkGagg+sweWHUPo7ddX
	 gmo9erEIl2Y6WlzwymIw1QoWY+C1kWPa91N9BBSsC3vYKejNk8aVErek9alpLl3I8wZ6d
	 lcwIG43VWQC+tJqPEF3HAKasX3Jh+WS9x492qtdfPNfj3Xj/lDu/wi+3WiX5ibe3mFqFR
	 xQJv9CHMhpE3DIhnKA3S/qP/BuekdeLvQvqF84QqMoGOJ9XopNgF1tIATkJQGpNUOMccm
	 W0rWJCayutS9jVyVkpvTV2KmIcsalnXpFNw3JS9m2MxO6YmzNqIrrPKuyTt6hIz40ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qyIKhO20;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD53606A320
	for <linux-mmc@vger.kernel.org>; Sun, 22 Nov 2026 07:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AD53606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qyIKhO20
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f03f3631b2so12483155ad.2
        for <linux-mmc@vger.kernel.org>; Sat, 21 Nov 2026 23:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795334299; x=1795939099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UnoQBYDYgrvm0uzeAP1oNmC1dNptSUJaGHHy2JIxghI=;
        b=qyIKhO20R2acwAcSaA06FY18AX3CzMC18uDNE+ayVo8/OfN77xppBG0l+8MRa9HQ3v
         poXtKNQM5zgCZZrYtkoxn77uG0TVfpieLQpmQZiTCpY/7sxV1+SKIbXPNpFAq1qyEdEK
         PQxeSRlH/MTXXDAe/YIAcSU3MmCYg0Va0wPFqiqugTxuZA8seY4RT8xtG0/BSEw55YL9
         tAwkHDdPvHrEaFYXpZWKSuHyofB3mJJnu5wqk8rQC5H9+tvEk+zcEkYGKA76cuBWyDIs
         XnByscisXM1RMMlBON8A7IlB+Fs9ODcIdaezRXHpkl6T6kkDnj5tmWizk0JUDqY0YW2/
         FhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795334299; x=1795939099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UnoQBYDYgrvm0uzeAP1oNmC1dNptSUJaGHHy2JIxghI=;
        b=W4lG5xLJLtpIePVIlL+yTaOtpMrDqyOdi6fxeE/0+b++yRGMFuJ9GOur+cH9J+0qL3
         QZ5280JIhhTuZGc0t2ohX2LXa5RxE6aVExL0j1FXdPvvivff1DIkvjVPMsvGaSqpqVkV
         PLDL1nl8qTy/5N49JkbGGW6CpVe/6W+U8xHso7xMe/V9P0KW5OpUA9daLFNwZv9WB+zV
         s4dgbWBIz2wh51RKvB3ceJ/VYhHoOENLca2uBV7wmlXQsckQx7Oyz5E1FQ6XKpIhECu7
         XRhCPqbK7AL5XjDz9Kti82AHIC/2UWIH9yRSljgzk7DNP28DvjXJiEVNMdqEGdXlvvwo
         +Jgw==
X-Forwarded-Encrypted: i=1; AL+hErFpCVCUVFM60MVdpyBtWSdWvO++LqEjZ/ucmmXI+K9MjSbi0bGzoUcD7aXQctKCngKx6/uj/BZ1xGk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EpTrd2s3qVGRy2aacTsPH6MQIZZgbvOmu2AnIZYSKMjBFKspp
	ZKekV+dhIz2ilz1zS1D8c3lUL5BSne2cMAJAedOumTDFqY5CbVVcw0zW
X-Gm-Gg: AZFdTZfKLYzUiVEzUkdRCU0aQBRSjGe4Kk/TJZnogclmEXh4QGXU4407naXIlN/mU1k
	b92UIceVXbOYAD92b4ul/YQyhJsyVERMkLQt4KsfbHvw3+qOjknAR24GEVScAZYclakwGUO6cvX
	J0wCEhVSAuQxHnu0FGtko1iowdcrgtNcMT5TUbAUaztnLvCFhWpCcW0ijY+jR9XuCiELtOJ4WRI
	GcrZHISrsLt2LjMD9QiBKLRkq6W3Hq3OA0zqqWAEKP5sS7IU3Ti6K8OL4Bi6/ZUPO0i+63oz6+V
	wbOAnBUKUu9MutY5zEZo40dq0LZOu+9eya1qa7G32EqGEIOu5zRJj8quMpZFaLo6bTlDF48JqZm
	n4zKYLaynE77Z5ZhdjhAFWAtXxPl6BCh+rFvl7gPDieusBNxDE7fS6C9pJ+lZdP1XwS3Yzm+arU
	hn4luWxE7NhN7ZtEb/yrs6WaQ/9g11vF9S6JVDD6pi90OtqWmPQKztui1W+mMfg8ygUOGUzyFn9
	lNQC0J1fTeJOKVgrQOkur+LEI+plSXBFg6hyuoiDaSOyZh8/X0JYwFZFKXKL797E8tN44MqtES5
	uNy5ga52CE9bOSj7wedQPB7z8p3ksOw4A0vrI5mbmEEBYVp6Fg==
X-Received: by 2002:a17:90b:1fc4:b0:3b0:9e2c:9b60 with SMTP id 98e67ed59e1d1-3b41c98a145mr7001710a91.21.1795334298573;
        Sat, 21 Nov 2026 23:58:18 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a34asm11570028a91.3.2026.11.21.23.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 23:58:18 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: wahrenst@gmx.net
Cc: bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	hemanth.selam@gmail.com,
	john.garry@linux.dev,
	kraxel@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	ulfh@kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v2] mmc: bcm2835: restore scatterlist after DMA setup failure
Date: Sun, 22 Nov 2026 01:58:14 -0600
Message-ID: <20261122075814.162099-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <fcfc5d38-2755-445c-8444-bd4c5b9c524f@gmx.net>
References: <fcfc5d38-2755-445c-8444-bd4c5b9c524f@gmx.net>
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

The DMA preparation path shortens the final scatterlist entry
to reserve space for FIFO drain words.

If DMA mapping or descriptor preparation fails, the request
falls back to PIO, but the shortened scatterlist entry is left
unchanged. As a result, the PIO transfer may omit part of the
data, potentially causing corrupted or incomplete I/O.

Restore the entry's original length and clear drain_words
before returning to the fallback path.

This issue was found while investigating a kernel panic on
my Raspberry Pi server.

Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 drivers/mmc/host/bcm2835.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index efd1903c3ccd..49a975e984df 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -449,6 +449,8 @@ static
 void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 {
 	int sg_len, dir_data, dir_slave;
+	struct scatterlist *trimmed_sg = NULL;
+	unsigned int original_len = 0;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct dma_chan *dma_chan;
 
@@ -480,6 +482,8 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 		for_each_sg(data->sg, sg, data->sg_len, i) {
 			if (sg_is_last(sg)) {
 				WARN_ON(sg->length < len);
+				trimmed_sg = sg;
+				original_len = sg->length;
 				sg->length -= len;
 				host->drain_page = sg_page(sg);
 				host->drain_offset = sg->offset + sg->length;
@@ -495,14 +499,21 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 				     &host->dma_cfg_tx);
 
 	sg_len = dma_map_sg(host->dma_dev, data->sg, data->sg_len, dir_data);
-	if (!sg_len)
+	if (!sg_len) {
+		if (trimmed_sg)
+			trimmed_sg->length = original_len;
+		host->drain_words = 0;
 		return;
+	}
 
 	desc = dmaengine_prep_slave_sg(dma_chan, data->sg, sg_len, dir_slave,
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
 	if (!desc) {
 		dma_unmap_sg(host->dma_dev, data->sg, data->sg_len, dir_data);
+		if (trimmed_sg)
+			trimmed_sg->length = original_len;
+		host->drain_words = 0;
 		return;
 	}
 
-- 
2.56.1

