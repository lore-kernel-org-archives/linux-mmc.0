Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A719335DD1C
	for <linux-mmc@vger.kernel.org>; Sun, 22 Feb 2026 23:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771803587; cv=none; b=uGhTmYQoL1V8uLn19j/TsyZ0Q7lKZ/1H6QTfGJSTyUR66VS7GbfLuU9JAsG/vIh8qEAa75ofz6f0tYEda0tD1y/zJY3/QiYC8g9BAgbwAWOEVkJdt1zsGZjo0rmv3DQGTpXFehobQGouW+b6ejsLhwkcB686iwiYp/fl/R5opEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771803587; c=relaxed/simple;
	bh=ytoTkJ09pUFh138JWDJI9F88mtp0soqz81G6ZEYIKz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Asf4y/9azXU8EbNrheAL/vEbOAZ6aPHH9OQ1yMg36EFa2NkAMkfz0zfHqalSeFhzh5gfnfSnph/swx7UUWjZgEtQZ8iscelxQusgrMNGDqnN3IEBG9wg6YOTWFmd9WUeHrS9eP+VPXLZLNninBe5yBGCTSbpr7c3z19xqk6PgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UkG6bZYw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfDuD2fA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkG6bZYw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfDuD2fA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771803585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZDCTIX5Sg37GXrr7Fijac4ezPx8KVaQ/VWCjCyY7GM=;
	b=UkG6bZYwpkPXlNz4qLNbH83WrhlEBynm55bJFY0us/FSjdpJrh4w9fgPeMtNQ1lZnRd9CS
	SkUu81vcdeLzEHdkYjBGltNcM4GV6rR0JpWkGy1IsSJ0dI+UjCHSwnAkIFdVJykLKxmAWu
	K6D3EwF73PwnwMlC7LPRZrlGFGV3yeo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-Gy2KNgGjO9yN_ls8TfU1xg-1; Sun, 22 Feb 2026 18:39:44 -0500
X-MC-Unique: Gy2KNgGjO9yN_ls8TfU1xg-1
X-Mimecast-MFC-AGG-ID: Gy2KNgGjO9yN_ls8TfU1xg_1771803584
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb3a129cd2so5116593885a.0
        for <linux-mmc@vger.kernel.org>; Sun, 22 Feb 2026 15:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771803584; x=1772408384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZDCTIX5Sg37GXrr7Fijac4ezPx8KVaQ/VWCjCyY7GM=;
        b=PfDuD2fAMrm4pzkKltMCTNymvqaO9tui8XWKmVmG8gX42PUMbzHDxrSmJR8hFdr/gJ
         qxKcSvEWj+72Pa09D+cSeFIPUxoD7IprBT/I9htj+uZljMJdXiaQOGst/PR/1rJH8SFN
         jHUnONO7jSDuAoll/cf0hBYPbmPD85G6vweQIFpS28UhbxjtPC5zAJCfwbSN0HWgitlL
         mNVymle5AbK8AGKzMas/C+OZj/QofMdA6qkeIp8RUELgiiS0TKlKak7mJ65etB0XHiWi
         UksteZL4f1d/yB+FGLK91G5yCcFtwn+eSXVNlnQAwxV+3xp6oGO2zC4s+hq5izYO83ox
         C7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771803584; x=1772408384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aZDCTIX5Sg37GXrr7Fijac4ezPx8KVaQ/VWCjCyY7GM=;
        b=PXKORNBsPGn8FocBmXUCCx0C/0IXSIVGGcsCTsWiMaE2nikRIHNRaULGhokiMyT9sT
         teBBXwIJjfEynhU2g6LFvO5HLqvtfyVY+ssEdHMYet3BoyelQ2SsHbh1OFdBK1lDf9A+
         BvcYhLmdNhjT2tia4PUBYV63Nmx7kN4ndwOt3l4j2bMlDPSopvAE6tW/4Cwjf0/ngexh
         455UdoqijzUu8LWEpVIq0SokJYChKziLLR3TbpRcFRK28Z147Xl1KShrkTWFZ1NCg9le
         sLuikWrLGtJNbMtYGdsp5kX0oMT6X0UO7u9P5KiPSiPsXfOnyADkiWppkUINP9HM9pB7
         Rrvg==
X-Gm-Message-State: AOJu0YwE6B9fq4dCsvLhBzmV19BCpPcsv0qfeo+L23sCeYEKgNu1YV5O
	vj6T9MeeiURJtf6Lq2cVPvy2wYj85qvyRj+MfmaBlOtcy09w3ATD3Zch1gmwjF1Wc2H+/YKD/TX
	gfaOMvm/yMvC7Ye2wzB/2jikVUGZiNT38kIpDO9Aaq6dXjbZGSW18PhtJaHumAA==
X-Gm-Gg: AZuq6aJOlgYTF+tNLhuuWbbMHVPq9em8Fej4NtbyT3MBjnNxnpMr9drSCgWj17XrUGe
	X7G4T9WJj8Dmhse51GrKFPU2lfkTTICUj1W7M3DJkSBXB2+Kie7z6Z11WoqrT6oUvnDZ+d54yxy
	QM3haiw1pxERFMybQobLFJKW6IBQrYOSX3Vlkc9TLxs4BO6AM3FweWneGkRXs5cYQxu3+SYgl+I
	ARbaYyR53KiVRbOcZI7vNrBGoRP5YdQgyVKg1/aIpydSH6QWcB7B5QGKnG7Bd7i/WFujZBCD9NB
	mpHPxiQbFc+XuoZRWteScfDYCeK420RnXObY80dKpSrgtnX3Be3QqktKqPVFivBfncdGu0pdVh4
	ZB4kPzk9mSjtAvxEqNmWbTxAioAqTgHkKM4U09xPe4XdJ7klT1pqecNkHnXts3w==
X-Received: by 2002:a05:620a:4591:b0:8c6:b001:42d4 with SMTP id af79cd13be357-8cb8c634727mr806697885a.24.1771803583956;
        Sun, 22 Feb 2026 15:39:43 -0800 (PST)
X-Received: by 2002:a05:620a:4591:b0:8c6:b001:42d4 with SMTP id af79cd13be357-8cb8c634727mr806695585a.24.1771803583522;
        Sun, 22 Feb 2026 15:39:43 -0800 (PST)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d101ceesm577297285a.34.2026.02.22.15.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 15:39:43 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 22 Feb 2026 18:39:13 -0500
Subject: [PATCH 1/2] mmc: sdhci-pic32: add SPDX license identifier
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260222-mmc-pic32-v1-1-110382af02b0@redhat.com>
References: <20260222-mmc-pic32-v1-0-110382af02b0@redhat.com>
In-Reply-To: <20260222-mmc-pic32-v1-0-110382af02b0@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>, linux-spdx@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=ytoTkJ09pUFh138JWDJI9F88mtp0soqz81G6ZEYIKz4=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJnT961c3sky+QD/3OcPrCsODxjYYWhWeK74DkfK81rb
 m7+xXn0U0cpC4MYF4OsmCLLklyjgojUVbb37miywMxhZQIZwsDFKQATuefP8FdybSvXvji+q4c9
 rL5PnCtYpyWmdKYwkmX5YsOd0k+PNmky/E87Zq4RaaJfushnkfyNGU0un+XFD4dPzlmQvWPay5Y
 HT3gA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Add the missing SPDX license identifier to the top of the file, and drop
the boiler plate license text.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Cc: linux-spdx@vger.kernel.org
---
 drivers/mmc/host/sdhci-pic32.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
index 2cc632e91fe454bf29c1da22e45135d5d0267f54..6899cf6c65e7df2461c9534b51b8edfd0d6bf7d9 100644
--- a/drivers/mmc/host/sdhci-pic32.c
+++ b/drivers/mmc/host/sdhci-pic32.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Support of SDHCI platform devices for Microchip PIC32.
  *
@@ -5,10 +6,6 @@
  * Andrei Pistirica, Paul Thacker
  *
  * Inspired by sdhci-pltfm.c
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/clk.h>

-- 
2.53.0

