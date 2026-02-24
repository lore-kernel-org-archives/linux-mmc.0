Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9121227587D
	for <linux-mmc@vger.kernel.org>; Tue, 24 Feb 2026 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913627; cv=none; b=XtzKTygHl2v9ai5PAXO+AKMbWRDOlJkxXGAH2ZhsOKcysoNV8bj47D05udfQWsnBp327rEeigdEnsneTOSzCY1TIeCvtw140mguVhDeqzl2TOmyJ2pTh8tUiw1mGVumSJd4y1qbJgZtP8qfIg17JKQyvDHXGc0Lda3xxHxagphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913627; c=relaxed/simple;
	bh=UP66ZAAJa6BHp/aVMJvzMBc3hktO+sAwJ59yXee9e+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPPa8K+MyPq5n+6A978AM+j4Y0t3s/lhEauCTezCvFweTpPW2UIJFOlLbJ5xtiRVf0ilFUpGillMslrBTZSVKmKyfAy3oZGhh2Fm8rKPywtv3zC0R8IGt5lrr1mx0ObWCEpQaWtpQ7Y2Elw8O3okUyuRN7PSUkCtxBqICfLU+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6780761b665so2963107eaf.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 22:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913625; x=1772518425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfopHsfGlEfdUUn+Z5Ob2uv5rH6VmacISxBMgn7zNc4=;
        b=h4b6szw2kRZSq3tMOQDdHYeyBfr6fLPo52fCoZ8GAjpZYmTOCz2hzGM0W6gLN59wYE
         3xcP51mThReZThCDp6Xaq+gT3DinKAMhrzTT/uzjVkvxVCVPgQJY2fSgmJK/I64+6xiJ
         I236YQRV6QTro8O5LBNPoNf8WVv6rOpy1ZXqQ/pYpVRI1D/4w4Nh9UGQh+CbxwK42Ekz
         AVd9y2XqW0SsUy/JY3x7mI+irFb1EAU+72xzKvRI4j/UWxMb04j5gZ8FlvqXsniKmmis
         6zog90/RYXN8dFRiHjO1swpVfHcrJtsaCOynz09geZnXqpfT8pD8UISyoRGzO9ULqPY9
         V30A==
X-Forwarded-Encrypted: i=1; AJvYcCWw/s22xj3TbDa+GZYN1sL03Q5sshuhtnWeMZuvFDN5PANX69zu8R45o5dWKGAOG0ziRo7ellkV5kY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3IoVPb6U1ZaFB2bpZ0N0FQanyQJn0A5Qlkqg38gjagiaD7hHF
	kr3pmQ4S+vBbOCfynz6fItrY2hc6iR3+iOG3kY4x2/+fY2A3/SKYH7po
X-Gm-Gg: AZuq6aIALX9KFSIEsTFu/z+g+aO4ZhNWlp4HHKM4KBJBNoAlKZNjm5cwrOtdIDP7UM6
	Tygb/nSChdBDMUX5uCd3cKDwd8DaTKAFrLBx2+UsPR2gbYULnGBHfePEenF8L6n5jaRyZ76pMHC
	7C4d050Ct00HZjr0Moguls9tzMjxzy+bC3XnVX0Gk8SFuwqKOpVe3NanebQaGxErmwGnAbVp+gP
	iWWdwC5XnlBB0rpnrJaCONnXovnUZcL1pl/UdC6Gi1aUsm2v0KNLxYaiEhcBiqNor/X8lGjrm3p
	ux72uA7aiGNXX6TAIfA3iLY0Ary/nnQFJjemyLYLIiY5TjRi4kX3Vh7FHpWthPgXuiy4fnLBKWa
	Ja0bn5cI/d7wNBpbNGh5Av7zkwVsZfgMadDAVAp5h6EV4nftAq/tNG9LgsKH6GWbBvBbosSC1bJ
	9yOwJsT87ghBJ9RWR8xmSV478MG40TNimxhnrHRx/RM6TrzjcRukjE8ZIqrv32jeo=
X-Received: by 2002:a05:6820:61d:b0:679:95da:9752 with SMTP id 006d021491bc7-679c464670dmr6311208eaf.11.1771913625371;
        Mon, 23 Feb 2026 22:13:45 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:8ac2:4fdd:a742:61b8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c56dbde9sm7895306eaf.11.2026.02.23.22.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:13:43 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 1/8] mmc: sdio: add MediaTek MT7902 SDIO device ID
Date: Tue, 24 Feb 2026 00:13:18 -0600
Message-ID: <20260224061325.20189-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Add SDIO device ID (0x790a) for MediaTek MT7902 to sdio_ids.h.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2:
1. Sort the MT7902 SDIO ID definitions.
2. Add Acked-by from Ulf. Ulf mentioned this should go along with the other
patches, so Ulf not picking this via the mmc tree.
---
 include/linux/mmc/sdio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 673cbdf43453..dce89c110691 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -111,6 +111,7 @@
 #define SDIO_VENDOR_ID_MEDIATEK			0x037a
 #define SDIO_DEVICE_ID_MEDIATEK_MT7663		0x7663
 #define SDIO_DEVICE_ID_MEDIATEK_MT7668		0x7668
+#define SDIO_DEVICE_ID_MEDIATEK_MT7902		0x790a
 #define SDIO_DEVICE_ID_MEDIATEK_MT7961		0x7961
 
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
-- 
2.43.0

