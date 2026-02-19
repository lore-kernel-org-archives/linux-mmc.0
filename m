Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8635C2E7BB4
	for <linux-mmc@vger.kernel.org>; Thu, 19 Feb 2026 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771542996; cv=none; b=odRwtL8hm5YeIMveT0iNeZBaCEqZnviGO4IgJFrjBIaSjT8L9ZlEE/vExwtWCapIoG6YFwjG7x6wUjm6TaYz/hZF1VH6IOupIrqK3MPDv8wQMSV03pTawnJoKaBXQ4FuY3CobKvlbKrabekdROtfNy22Dbc12NWFYG2iABu2W6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771542996; c=relaxed/simple;
	bh=TT2KfFnQtzKOEbg8zbkMHf8b13f8CSixpl51XFpRQhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qa1Y/+o/+lqggpGOhmKAuCPb8ILoLRFsv87tDQBrvfAxpcwJ5ClI0lvdZT/K4+cqgJ5/S2J+lk3vylChirdIfLtnroOCH95C4Vkb2i9z1iYuMkv1QlD/Iin6NB7yWi3b+FibeT7hU/u995Gq69MKsbsJoniveELf3j6OstGGDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6726f320b54so832151eaf.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Feb 2026 15:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771542994; x=1772147794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZV3jSXI5ldR4jveK2PsLzkMeIX1O0Q5JVn7RfzOo4go=;
        b=CmU7oM/kL4APB79O+14dRzqvqsPJCialwi/dxHIEt+XoUKPw97YGu6Jal8H/HeTiL9
         jIA9Ri9ol7mf9frL+Sd6IE9MdDNLyN44bAAy2Trc9nbdylvEmzCYBzenxYpwg1Pa7Zp+
         ywWFwziK4PWYf7blit7P4RgZfU8JSiNWH9ROuhzUpKvRmd0ucFtCoaYnHyoY9VYDf7bW
         MA0yCHULH5DiKv+Eq19RTvCCs478VwD2DkFig2t7M+IGBh4yo6zOTkEpekUs0TdddZoR
         rCZ8QLABHTRc7r1BjSrv4Qc5BJ7CbWCektPRjS3t6d3DbhqOR0hGNgLy4Os0yrrBjKMw
         XSvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfbV7ydx56OUapO6sX6LpAF9gTmVNy5UCt16sSgaehQtzXDB1kzTUTntF7dI93wUD0fzmbrAQ3Bcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPsFwUFtUaDAs/CE54yA143v8ljuKCGCW1dclPAWec4YmHVkkf
	Wqx87WnBeP+HwTiKYULEyFAOCtP/8yHfnLhatxiJKHnrHT2dKEVAht7l
X-Gm-Gg: AZuq6aIAMMksTBQJu6J5ddDBJBCZ3pdMniIA5zphY2jRUQWqlBjyLTWLwgdBsbu3sO5
	brilCv0SSoW2N6ztA+1NiZMTcN1BYpc3WF/gXpyiRFvuqtjqID3HC1HL68orNMHYPH3X9QrJwET
	Gh/gfHKu5IeaYWGPHoXfu/vVvVPJptmHBH1HY/0LwHf03ptcnbkWnAl5YN39flVkFHnz9PLra8M
	wMC/keY2ThuMlisZXeJJi95EPwBiD++8RqjiIlfU4TacAkWqLFPDkzEEXXBqnEjhEYjoYA975vp
	goWtL0AnUomFZ8s3103uBi+1WYT24caBKtQXJmOjKRg9kgvZS3fWVtTUnAyxvp3jB4MvWrj+8V0
	pvlbVYwEEtpXHev8xkRkEGvqozwme1fGEnCoHHog8Gi0aiQM5n2WioJZZ26qWw5gqLLb02KHa8s
	4kACqG287JVdiKVRxYmVImqm4KWkHeh8/jZmF5o1cJyReHfoM=
X-Received: by 2002:a05:6820:a07:b0:674:5dbd:7859 with SMTP id 006d021491bc7-679a74430b4mr3886891eaf.55.1771542994551;
        Thu, 19 Feb 2026 15:16:34 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaee45d12sm26719644fac.1.2026.02.19.15.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 15:16:34 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 2/4] Bluetooth: btmtk: add MT7902 MCU support
Date: Thu, 19 Feb 2026 17:16:22 -0600
Message-ID: <20260219231624.8226-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219231624.8226-1-sean.wang@kernel.org>
References: <20260219231624.8226-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Add MT7902 device ID and firmware filename to enable MCU firmware
loading.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 1 +
 drivers/bluetooth/btmtk.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 14e2f4100806..2507d587f28a 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1338,6 +1338,7 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 	case 0x7922:
 	case 0x7925:
 	case 0x7961:
+	case 0x7902:
 		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
 				      fw_version, fw_flavor);
 
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index b9df2b8f0627..adaf385626ee 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -5,6 +5,7 @@
 #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
 #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
 #define FIRMWARE_MT7922		"mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
+#define FIRMWARE_MT7902		"mediatek/BT_RAM_CODE_MT7902_1_1_hdr.bin"
 #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
 #define FIRMWARE_MT7925		"mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin"
 
-- 
2.43.0

