Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4C21C69D
	for <linux-mmc@vger.kernel.org>; Sun, 21 Dec 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766304037; cv=none; b=bNobUuO0pHFvg1uQ3CbgIwPWoD0Or3xur7pOXPo7B4qNc7DZbo0vOmGBwpNlW9nGf6d3DXt1u6ldSB+TeRbFHU63AybnDfSRJGdH0VQ2sXmIMmBWSsi+dvB0nOZxDHvJnkSKAoMkX1EuXZBPHTLupU3uq6k2G24BU7Bb0CKElXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766304037; c=relaxed/simple;
	bh=tfKB4l+34kQ+o4Fz9uVLyei6yRYPA1msX1tY1Slxzxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PKJDdxOL7h/oQ88Ell3mgaM4upfTLu9qVdugiwgoKdnlhZHa7fPMhj2xFjFjL5ZEamJ/XXiHy8W/OFNKdUYPv3+wHmyKcmG+6yeHZQffVBERLbFzdFGeDV2qkcMUWRXW3hXydZMge+n/MpC7Adfs5dxX7eU0S9b1Jk9b0muuJ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0K31dWI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0K31dWI"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso31411055e9.0
        for <linux-mmc@vger.kernel.org>; Sun, 21 Dec 2025 00:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766304034; x=1766908834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z4c0WKRVPOvcLM37PLgn551lJjPcKofNVEhtbTROBg=;
        b=I0K31dWIARSOqKHjIVsNgQ3j5uUWXjDDDoEBV/dKhw3ESVFZwoF86iXu+dpVhs4dVB
         6kr3h89ZWg5jY2KlgvTyIdPxFDbfTqkE0phraRjUqBBmK8TsoGcDHD8bPj/gWRQhIDXz
         knc2K1Wl4oS8+lUxORvzH6KGFm5oO6g4Ml12CXNfljN0moYtxElImj8dgMUq3Cyw4bzk
         AVH+K6jJDWa0iWyG6zDzsy1pwZgV+VuflR6DCr1ffMoXOM5+Dbl2RsMdPnYGVhNR7DR9
         w8Ln1CIE1FFN/n5AmWzWU80SIjHS1wr+B0sAPN0Du6aH1flktwByNAHzhbj78Qx0I2Vd
         kfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766304034; x=1766908834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z4c0WKRVPOvcLM37PLgn551lJjPcKofNVEhtbTROBg=;
        b=H9m80waVTcMJJc3Y1Qm5vetJjwQK+sYlEO5yqks27JgNEYoeCE3eLxPnQmZwS5L6Wv
         tF6TUmnmJjIKbJ8UYH2Zc3jPkL3vXpqD2SRfQurMR4zYyReQMe8duGRfdq3NT14NXAi/
         d4Mh/nb7Wu8HxuDAeO2emvon5XIZoq2xJ/LemESzVMe2IVAw18GLfsl1WgglgN4S9LTE
         3qwHkp/4YVlqHIgtRzoOQDQXLQ4hyI5b8MOBdYLlR0PCKGZsGKTDgkmPqFVQXC6DAGNK
         1E2vcZTJb1CSHMleAdpuQf+DXeLGUvFv5LmfPJNdzfjkHxQssg+ZFvOxNHZQIAbgzv4n
         zSAA==
X-Forwarded-Encrypted: i=1; AJvYcCU7oUj6POI8kC3ebrjgQD1rDhZ1ZYgCYtkzEbLhfkglkJKMcNOC24UkVi+/XdwN/+62TtUakyhiY/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/L8VpmddPlo7eu9aw/Hzdvd7imc05boYNNHD33Z+U7nYK4M1+
	F3A1yICtfknf7foDtUhdv02zBd3OW0ijyXgFYs27tggBzQsV50BBzSK6rc9qeg==
X-Gm-Gg: AY/fxX6QtNc63SXOfHmidGTCTsVRltlKZTpVWBIFEccpBznGam45l7BqKDwtK7Up1Ja
	xBm3HjLYeoH3Z/kq6a33kvtvPPZLVmyhguuDfxg+t2Ud4Sv73FRt5lAvueyGGKyMs5g8vqk0vRy
	ODdFIabsMSBkGqf5uhBfF5Cv00Muy9FxvUPz/inzx/diM5ivBTl+ZPDM/GxtYgg/X6sB7UEWa8W
	lv5cOmDHMyZX7Q5JATrTbb03GgyyWAV6JNSual4BPGsTSO5a4AcVuNyzbHMxBUMYih6um3t3R/p
	C9Wb1UKkMfHP5Zu/8MpWmIupmmTuXZqSyWdqtCX5cFtXBTNeSp1X6u5jGX2VK5ju1FAhOmnsAO4
	GCDg62+GJzOKSgZCYrt38FT0x6/8apCwV6eqO9tLHWwlSULI/vRnilWYybyYYQFY1n2GSYO5m+q
	ShDcWD/p6h1nt/QZSgcQIkd7s2+VF53+MyPW1oZ0zauzzAv2qoNpSdVTqVI1YErvRZEtx7IOhVP
	vG4hj8V9qKd6k6fxBCbjNFENAXJUKmMc0A=
X-Google-Smtp-Source: AGHT+IEAMIUYxtBOYr1CFsasr8OUTCxRxF3aQ/AlZNTueHX/AHG1iimj/bk5onXJVbt8NcS/6xPLHw==
X-Received: by 2002:a05:600c:3b92:b0:477:6d96:b3ca with SMTP id 5b1f17b1804b1-47d1955b7e9mr80967635e9.5.1766304034362;
        Sun, 21 Dec 2025 00:00:34 -0800 (PST)
Received: from avri-office.sdcorp.global.sandisk.com (212-235-122-32.bb.netvision.net.il. [212.235.122.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193621c8sm127174335e9.7.2025.12.21.00.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 00:00:31 -0800 (PST)
From: avri.altman@gmail.com
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 0/2] mmc-utils: lsmmc: Fix Manufacturing Date decoding
Date: Sun, 21 Dec 2025 10:00:18 +0200
Message-Id: <20251221080020.4532-1-avri.altman@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avri Altman <avri.altman@sandisk.com>

This series fixes the decoding of the Manufacturing Date (MDT) field in
the CID register within `lsmmc`.

The MDT year field is a 4-bit value relative to a base year. To determine
the correct base year (1997, 2013, or 2029), the tool must consult the
Extended CSD Revision (EXT_CSD_REV).

Previously, `lsmmc` processed registers in isolation and often lacked
access to the EXT_CSD revision, leading to incorrect dates (e.g.,
interpreting a 2022 card as 2006).

Patch 1 updates the CID printing logic to select the correct base year
based on the cached EXT_CSD revision.

Patch 2 ensures that `lsmmc` successfully retrieves and caches the
EXT_CSD revision.

Avri Altman (2):
  mmc-utils: lsmmc: fix CID manufacturing date decoding
  mmc-utils: lsmmc: cache ext_csd revision for MMC devices

 lsmmc.c    | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 mmc_cmds.c |  2 +-
 mmc_cmds.h |  3 +++
 3 files changed, 62 insertions(+), 3 deletions(-)

-- 
2.34.1

