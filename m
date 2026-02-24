Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A529BD95
	for <linux-mmc@vger.kernel.org>; Tue, 24 Feb 2026 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913640; cv=none; b=bCoxU0f4Wd8b2VR6jmyC4LHgDrZJzcgH2QTpINkqf5iziRjTe/X94TOOr/eP0MWItw7QbIaZcITf+xQkFz4wpwzXOLranYDGQY3axUpXcm6zcqcXlZSKQg2vSBCFpPyhUaPlOCvwXvmbCh/KZl6Rc/PdUK9HWTGQMKyQ4xxtrpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913640; c=relaxed/simple;
	bh=nZgYslmk3Skkq7Dos3moxWXFnIkhX8JSVheT/WmSuP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWxf9Qjm/SWhtxawTAfNlkBB3RUq+7AuoGTnWpZHPO4d1q1f3Lg2sg7xOPeZBsj1VmKgm3RNj2iX1sYxHEqZlbpKN+mWJvbof7Qxn2FdVUVwTTr19RsLig3fhM2LfzztDL3blWHwGwZHWt9kMD1i8W70MSkbOp05tjCYwJYkWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d4be7c4ebeso3173901a34.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 22:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913638; x=1772518438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KXbMDu4NldZsQWzooZBGPLWKOu0HOKaZs77YpksnpCs=;
        b=nJLI+tiZKbnw6Ab7e2zPhCB8wT2ZjARCaZq1Ot/fiJ62hgm5pKgjwqNgRjJPcA9Lc+
         VqJ1V67MBh/th5dGwZRGJWtnLe0Q3MxGwGw/zRgxgrYuO+8aaro3AhoTsdKVSNgstDXp
         dFcU0zL/b39gOHuMFgApdXef9p3ki+gWjnQ0Xzlz+JTKHybTjvoYU1d2bw8LRTQqYXuM
         cTz5wYZ8tRfOwPbD18bDH7pF92Ed5Xy2nH9Sb5YvUIYDyogh48esbzKnZQ39Xp3sYr/O
         sF7jZsXhgH/Sd9NB0lnBJSjH4cngv6iOY9M0lbiUVDjZA6HeTImZKBF92AbOy6CglVIA
         egIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgzLKwS+/wmf7wNIPBvADdKBDA4FZk8gr7ihR+4Bq13nRWEY0/h1MQuoZP3GhufOGQKRmGG9sa538=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9t00r0px99FjsneTlAEQMEtoh4Upvu3MFBfpTRI8AXe1+Dkdf
	7QZJ4QtYfpJ3t5nQgozSmWrsV9TIyMqWyOtsvvXzAR14dT1QWCKiecvD
X-Gm-Gg: AZuq6aL/vr7Bu+RXrEl55tTYUXtsim1TRayHbxYsXG7OKFhWORJfRXD7rVc2Qjy9hQ+
	ErKFXhiJSGps/RtzSaUhxjDFjXL++0XQ0Eez3qU5VSW4SoPgjn9AUTDmITaIK4lJpXimQBAapjS
	B0klmaxK5FHJdGsI5adDbZ9qXEPN1Q5U2/OD3Md0yMvUXyaYQoEvwLPPblT4wDFGYFnQQuV3Vb3
	OYHkQD0APkp5zsxpw3F5Qrz/zcOEZtMT8s5RFpBOM2MiaCSfVLf0tF1PgFQvCJRfWwMCIw0EMs5
	lPZnP6FJ8ysn35ym0J5zayMBFdXf0rCmtKFU2U81S7u2KUmyBhqH21E4E3QQ90xihCj+pC7nbs4
	S8tT2gvWbKC5VxVkMNPYh0qZprlL5L1Cw6Hmg2v5yLNxwsYnNWHhGYZGWixsA9P/7mz2fwoFvLk
	bXmjYx23q/FEdHrF2JS9rwk4StXe+d5W6mZmSPPP1nwFnWsixKVrFx+EcrtrOGUIw=
X-Received: by 2002:a05:6820:828:b0:674:2eda:cbe7 with SMTP id 006d021491bc7-679c450123amr6421042eaf.52.1771913637860;
        Mon, 23 Feb 2026 22:13:57 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:8ac2:4fdd:a742:61b8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c56dbde9sm7895306eaf.11.2026.02.23.22.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:13:56 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 2/8] Bluetooth: btmtk: add MT7902 MCU support
Date: Tue, 24 Feb 2026 00:13:19 -0600
Message-ID: <20260224061325.20189-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224061325.20189-1-sean.wang@kernel.org>
References: <20260224061325.20189-1-sean.wang@kernel.org>
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
v2: no changes
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

