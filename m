Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A042F6596
	for <linux-mmc@vger.kernel.org>; Tue,  9 Jun 2026 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780973710; cv=none; b=JBNA1bqTV8b6UCXbeQqozkrMwhxEBtgCACxTfUAx6toSG86gpWfVJedSaSZ+UlxSBC6BSqsySDDN2iUBtdgzQXXjsgNv+nWoMvZ+dtDv6gqrnLrilNbwlJsnmhEFXUOHZlRJhvQZEiyjd3ct+Od8kSJ8Qfz5tW1M6tAqXsgf/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780973710; c=relaxed/simple;
	bh=uuY1jgwN8xznTomCCr0j0w/za4xP4VVWYhZTGynA3As=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UizafE2/oGcmR6IXrp+RL/UVgWuFoFIrZr7vWVrF2E6JeselyQc6jxx2t324Lk3/M937tSrVgZtzW8vEj+7J2cbnf70hn/4jPRXb3v82PpbDCVJb7/aOSDbBATrn0sON7Sdwi9NGXuU7RGO7Y2GMn5X5cW2eo/9P9ypjbiFG18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLE8dJD+; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLE8dJD+"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-30759632453so7265278eec.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 19:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780973707; x=1781578507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pJI9CahXJjJULtLK0KUB7o46AGmYjVAvw4WBv+i+U6E=;
        b=TLE8dJD+tqFpGYG6rbLYlL2ufeWrVB4XbjptbBxSHaCWTAvz77Wvig0+dzA4PkHum1
         5cdnrLsgr5D915iltoX6H7I+ttCdv/ocWp8WJwoGLxnlPqLNXhducNYn0aNiyLzcgIOd
         1vicq9dr57XIZZpcB4oyceWQTGPeK6inVjelzld6wj7+UoBr8yhZCoFXL1w8U/cwcAF4
         UwkByIi2gfYH6eaH2H4pHA9LfI4DmRELkJs1boqbpgn0CiOmzrD/lQ6cJNQCRez3lo5U
         h0zy6VhmcnGljKP7JpBpfjvoh+ANGI6jm69WsTzTsaW9QZfvWsNMlylcKMxZ9R0Pmu6a
         UQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780973707; x=1781578507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJI9CahXJjJULtLK0KUB7o46AGmYjVAvw4WBv+i+U6E=;
        b=oMfSin3G/XTN7dntLbk1u8BNN2sPdhT9Ja6I5PWSMaTQSIr0jZtzNwcaZAkYw+fh4A
         DMREv9xy5r52oTVwy99R7TXFD+sjl0YoJ+c9UOAWbpeC/1bUXHiOPGZI2o8wRwhnUTaC
         gJp8XS6pXNaUbokX16Hz4ppcH81UyaUcqp1cq4DQh4Y7H9+k0tHinNhLzW4lgElJQ0AV
         oFqq3pEctI8bA/t/zRn/D+k/0uFCscYrUD2sFNUfvq3X9WIsCNdijNYBwmBP3azd2fqw
         BdpHxx/6N08fh/dT68uYHbHnMaTyJUfc8OfdtAGtbHPN4SIAEQUbAugK7alE7kI6Rgig
         xwtw==
X-Forwarded-Encrypted: i=1; AFNElJ8OpsB3NLk8r7R3HON0XwcNQmwHxYDi/PbdS3QeuZHlJCaHedHgffCscNMYgXBHvlYLsA7M7uaDRLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNeiRfMtVR5PjmpUzgXau9eIqXtl/jvJ5rIDOL9R9Xy9aB8I2g
	ciFhJsSZsK20Z5ambA3zXRnA4OsAP0iyHxZ5GOfe64NOqzg2B5I9+eab
X-Gm-Gg: Acq92OGREHJwCMghW1+shWbhOE+udpyj0/0PCZ2Wol242S7kOvBxllWzhppxnZ7MBYS
	sbctxc6FuY//mD8Qr/B6S/wxZRfnqwpt7WPa84S053LKu9gPy0n+LiCzUKHk5od9KXaPwGW5o+b
	wV6dGRqg4oOP2nch5iNHvnuTAa6HR8yj2EkNDd1vn8p90GFl/ayi2E9IDPQR8v2hHvyqqm6EDt1
	XlVtVsk6bELKYZ6uBXpBShClsIGepdthwreWun6Bwi0lj6cfUUb2yfkwqaZhoxJ4huF4NcJDCe6
	fX/nImTDVjqLaotR/yaJNoKPVeAjilq/+tELQsrWe6rgyaf594IB5OGS7fd2da31puGlUgw7hWh
	1cNP5ggWpLzd9nu7Xxxro47YkwSwPWbhhmD8vvPdzSzhKpNkVrj3bjXmUEo7xUWgsqTEpD99M86
	EsEbqlEfsJT6VgmjUW5JjZBJ7ko0/4FC0plkOEzsFJDgF9aJ3rbrufhQXil8TnJjE3LQhRnF+q1
	DVqMxrbeXmlxAIcMibkQDYInY4hWQdyucUfiqB7JPCN5HTQbUxt5hg6sgee0OqgNXpsx9VmuRZ8
	ug3XtpQ+3hYPbf/zPnJII/I4V/MX
X-Received: by 2002:a05:693c:2c01:b0:304:705f:e4e8 with SMTP id 5a478bee46e88-3077b33835bmr11052916eec.32.1780973707366;
        Mon, 08 Jun 2026 19:55:07 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df191d0sm28554855eec.21.2026.06.08.19.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 19:55:07 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Rakuram Eswaran <rakuram.e96@gmail.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Khalid Aziz <khalid@kernel.org>
Subject: [PATCH] ARM: PXA: remove remnants of PXA93x support
Date: Mon,  8 Jun 2026 19:54:51 -0700
Message-ID: <20260609025458.13744-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for PXA93x chips was removed in commit d711b8a2987a ("ARM: pxa:
remove pxa93x support"), but some code to handle them remains. Remove
it.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/mmc/host/pxamci.c   |  3 +-
 include/linux/soc/pxa/cpu.h | 56 -------------------------------------
 2 files changed, 1 insertion(+), 58 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index b5ea058ed467..f8427f071c00 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -43,8 +43,7 @@
 #define NR_SG	1
 #define CLKRT_OFF	(~0)
 
-#define mmc_has_26MHz()		(cpu_is_pxa300() || cpu_is_pxa310() \
-				|| cpu_is_pxa935())
+#define mmc_has_26MHz()		(cpu_is_pxa300() || cpu_is_pxa310())
 
 struct pxamci_host {
 	struct mmc_host		*mmc;
diff --git a/include/linux/soc/pxa/cpu.h b/include/linux/soc/pxa/cpu.h
index 5782450ee45c..38bacdae684f 100644
--- a/include/linux/soc/pxa/cpu.h
+++ b/include/linux/soc/pxa/cpu.h
@@ -46,14 +46,6 @@
  *  PXA31x	A2	0x69056892	0x2E649013
  *  PXA32x	B1	0x69056825	0x5E642013
  *  PXA32x	B2	0x69056826	0x6E642013
- *
- *  PXA930	B0	0x69056835	0x5E643013
- *  PXA930	B1	0x69056837	0x7E643013
- *  PXA930	B2	0x69056838	0x8E643013
- *
- *  PXA935	A0	0x56056931	0x1E653013
- *  PXA935	B0	0x56056936	0x6E653013
- *  PXA935	B1	0x56056938	0x8E653013
  */
 #ifdef CONFIG_PXA25x
 #define __cpu_is_pxa210(id)				\
@@ -126,26 +118,6 @@
 #define __cpu_is_pxa320(id)	(0)
 #endif
 
-#ifdef CONFIG_CPU_PXA930
-#define __cpu_is_pxa930(id)				\
-	({						\
-		unsigned int _id = (id) >> 4 & 0xfff;	\
-		_id == 0x683;				\
-	 })
-#else
-#define __cpu_is_pxa930(id)	(0)
-#endif
-
-#ifdef CONFIG_CPU_PXA935
-#define __cpu_is_pxa935(id)				\
-	({						\
-		unsigned int _id = (id) >> 4 & 0xfff;	\
-		_id == 0x693;				\
-	 })
-#else
-#define __cpu_is_pxa935(id)	(0)
-#endif
-
 #define cpu_is_pxa210()					\
 	({						\
 		__cpu_is_pxa210(read_cpuid_id());	\
@@ -186,18 +158,6 @@
 		__cpu_is_pxa320(read_cpuid_id());	\
 	 })
 
-#define cpu_is_pxa930()					\
-	({						\
-		__cpu_is_pxa930(read_cpuid_id());	\
-	 })
-
-#define cpu_is_pxa935()					\
-	({						\
-		__cpu_is_pxa935(read_cpuid_id());	\
-	 })
-
-
-
 /*
  * CPUID Core Generation Bit
  * <= 0x2 for pxa21x/pxa25x/pxa26x/pxa27x
@@ -218,22 +178,11 @@
 		__cpu_is_pxa300(id)			\
 			|| __cpu_is_pxa310(id)		\
 			|| __cpu_is_pxa320(id)		\
-			|| __cpu_is_pxa93x(id);		\
 	 })
 #else
 #define __cpu_is_pxa3xx(id)	(0)
 #endif
 
-#if defined(CONFIG_CPU_PXA930) || defined(CONFIG_CPU_PXA935)
-#define __cpu_is_pxa93x(id)				\
-	({						\
-		__cpu_is_pxa930(id)			\
-			|| __cpu_is_pxa935(id);		\
-	 })
-#else
-#define __cpu_is_pxa93x(id)	(0)
-#endif
-
 #define cpu_is_pxa2xx()					\
 	({						\
 		__cpu_is_pxa2xx(read_cpuid_id());	\
@@ -244,9 +193,4 @@
 		__cpu_is_pxa3xx(read_cpuid_id());	\
 	 })
 
-#define cpu_is_pxa93x()					\
-	({						\
-		__cpu_is_pxa93x(read_cpuid_id());	\
-	 })
-
 #endif
-- 
2.43.0

