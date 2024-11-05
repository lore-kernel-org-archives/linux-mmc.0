Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30721CC881;
	Tue,  5 Nov 2024 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802549; cv=none; b=p89cGkv9iPusOyGs/eXLrHy7TP5tmXUdJ2t8TJ/+egOmJYIxWZKbOC2hgmjcp2xZaVX6hjhWZRn2RTv2WKV/XczkvSR/HQT/EP7hVY/Yz04LoXgzD7sOyMTpGf1AOPCc6CsejshWmyYkqRRcXE9j+sKkn3A03NOGZtdSSkzm1SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802549; c=relaxed/simple;
	bh=U/AuQh6fTYwITGvzMShNl59U4KpKnVd9AmdMYTalOOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RomKeNM7Mg82d04X2r2pdGMux3qtVN0URR0SgKMSSFaHMmTlUlucokR7hLmserITyTN+ufBAnwhgiK6bEeoJsBmb9A27WtAUvHoZYrqYE8M6h5wj0vcOHAUt+QfkEhzW2yFz+cZFZArdFFK0yMSuwSFuagDFYvwQMx0La5nocpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+UekQC4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+UekQC4"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cb47387ceso50288405ad.1;
        Tue, 05 Nov 2024 02:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730802547; x=1731407347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w41KoCTPlUKgW2hOKzdfUNmVKOeFeFhI4YyHSd0RU0g=;
        b=R+UekQC4TJKnw6wTONOBYzb3GChi9ndE5VK9Duwi1hDiMkANGDN2WB3tVJegQPTIp0
         f3sRTxvB9ktZxP3SXtXhY2ly1DtDMIVNi3v/eTju9w8HvNfj2QtgXC68Kn3eE8lhisfD
         3enyGR/7BiL2HOB+ubT5vH07jCWtmsGExNChnL1IOBCQQXIOT/qsjt3ft3fXk8nEGEn3
         278Vlvli3rqO5yJc57GvsgfQck3Hq2MmuNEdc6vTMxv9QwxKVRCnCZhN0YwRuEDPp0Ax
         GdcJw8VhzWLjLOWLARFTfYk3E6PCwWIuhA9TXQ7SduT1d4KMtTI8Exhlh2Werv2ZoDxX
         4LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730802547; x=1731407347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w41KoCTPlUKgW2hOKzdfUNmVKOeFeFhI4YyHSd0RU0g=;
        b=IQrvR5wvYUxlgj7WCNDC3jHnsuIKoCLv8E6GG945W8RG8Y5AXftEMshokAP717wfc6
         VeT68VJHu5iOpXg6lmokshkExBlaTrlroBE0zQPy2SaYo+Ob7W3N0ecd08bKdUFyIHfX
         2bcfnvA26+9Snzp7ZyPkwcgybdLQiK1XqrlwvYRNETsZGs+FIn82s7Ej3eSfUawDyUUi
         QR75NAauoyrOiMxVYOxGINZ/evGL9FsikviHV1IBR1ThYFadTTSWtNKuvCabmXvNhOVo
         D8VXlHQdccL65y1+LdRiKEHT/W8TeIgKND26UHRK36Df29zCZBi+Qkifa+U66U7M2+Oe
         HaLg==
X-Forwarded-Encrypted: i=1; AJvYcCWnDP9auRKVYLNh0DrvLIXkK1HwV+QppLi3UyhGsASXb9E8EIq6P307MCS2Ji1AuaKzF0kKjcZyMubMGYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc0tIItTNbSqMOpKGfLBPldfC1+bjgcP4jj9tEiZZ/YVCsNS8O
	a1wRjgBfrYNbpjCv1VlfoIck5SFJQB7ymc5pm9fN/uloVj9szUe2FgNnLw==
X-Google-Smtp-Source: AGHT+IF5sM7uRGFc2KzxAARgnQAQpfs2QoSI2wNOBNiV4E4MMmkVZWoWE6kEeaL/3kj3zFVqan5iQw==
X-Received: by 2002:a17:903:11cd:b0:20c:f0dd:c408 with SMTP id d9443c01a7336-210c6897f24mr480233115ad.20.1730802547014;
        Tue, 05 Nov 2024 02:29:07 -0800 (PST)
Received: from victorshih.. ([2402:7500:479:4ba:e98e:2f4f:6754:ccee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c0eb9sm74897855ad.226.2024.11.05.02.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 02:29:06 -0800 (PST)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V1] mmc: core: Correction a warning caused by incorrect type in assignment for UHS-II
Date: Tue,  5 Nov 2024 18:29:01 +0800
Message-ID: <20241105102901.351429-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

There is a type issue in the assignment in the sd_uhs2_dev_init()
that will generate a warning when building the kernel.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411051248.wvjHSFNj-lkp@intel.com/
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/core/sd_uhs2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
index c5847a2084d5..1c31d0dfa961 100644
--- a/drivers/mmc/core/sd_uhs2.c
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -181,7 +181,7 @@ static int sd_uhs2_dev_init(struct mmc_host *host)
 			    UHS2_DEV_INIT_COMPLETE_FLAG |
 			    ((gd & 0xF) << 4) |
 			    (gap & 0xF);
-		uhs2_cmd.payload[0] = payload0;
+		uhs2_cmd.payload[0] = (__force __be32)payload0;
 
 		sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_DEV_INIT_PAYLOAD_LEN,
 				     UHS2_DEV_INIT_RESP_LEN);
-- 
2.43.0

