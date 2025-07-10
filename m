Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E02550D8
	for <linux-mmc@vger.kernel.org>; Thu, 10 Jul 2025 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148640; cv=none; b=IWvLMlHpdLEW58/ycaTCvnHfRBuR1R5jhf1kg+FhWD3ESnYX3tJs0N8+R1wTkvTJ0Ed8AXBi2BUJOm8XqkrGMuEmmkEhI4+Oa0mhuKd0whO44X2XB82Dx9GxDJGtTVAJZZn6PRqu/uedKqLlCEf4KBmHMQAsY8CinddJe9IYOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148640; c=relaxed/simple;
	bh=hC+I/qxnsicGhBSjNc6oecVaLe+pdSOSn9hwoAhWqNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBlp1/RU71yuHL8A7bnZMN0lMW2zPZGZm3cC8hB2s9Wy1xrV2JQauLzB3EvUPkS8vCp+cD5o9sD7BGjroei9C1XH/nCA7ycGUbg0nEZ7ueazoohBm42Dfv4hPzh1+2NYMpVDpCLZb0QoXgpMd+NFy+i2CErS0BQjne8Z2yb5Rx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnE+d+1C; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnE+d+1C"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a54700a463so526708f8f.1
        for <linux-mmc@vger.kernel.org>; Thu, 10 Jul 2025 04:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752148637; x=1752753437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeK52PiS/yxpaDzArE+1uChD/RqPmmTZ71OWYsGexe4=;
        b=jnE+d+1CS+AkUvXNl/yc4GoeyPzBhSkrIwCQv+5wvRYD7Jv4J+WhSGReRDR71nIwTI
         vzS4ctdERQbWPQLSWB3V0tX9gxN0EHNwB7yNxrJnep1TdP1j8irInKomLrYx3+pIIL1W
         oRSMGljAIZu7e4EPDQdDnUyY/1irpiaFB39++0SR0TDJ8g8wDuoogfubPjj1mNvdcTIA
         2HEaO5xOmRhzKU458EEOLC91zYuTBURG2lpTRt7PFV3uIOYzN5W8u9Jc4+WRJPAQ+qru
         feKU2p3h/XgUYbU5LQlLWVcTbB9dlu9xhAIQLCcJl3fDgOLLCDNZJgN3+uv5TgfhMYRR
         owfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752148637; x=1752753437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeK52PiS/yxpaDzArE+1uChD/RqPmmTZ71OWYsGexe4=;
        b=dMnqKCdU7LmUwX1UnK506CkCsfWwGjfl3mSP2yCD6YquIESg20xYzP6fP/mBVC5nbu
         8DjbiWmGEgRDgHBimJM6/s/DOa3lk7V6hVPGMkz25piM33cJeuG3Yx1RB5018uJ+CUEl
         DBnpi3JqU4Tz0RUVywLvapzT8S1qZVhRfA3iuWBy3VgJ8uory01cHc7+j2D31/wp/lfZ
         JJZBlRQ0Qvp7DPgP0N56PrO9vQvnGH0UYfSW+l+NSBU0eXAOYlUzMj89zC5qaKKFrAVE
         i5vxLXFT0VbLb3fed1QYoRKYsveEQKk+3OEtLVDu4PDEVXOnb2CBetEFCtkCzxrKI1FU
         mnng==
X-Gm-Message-State: AOJu0YxmRFOvLc7UR7TL2dMB6+zAil58DuQMoS7WvCKiO8+FUEdyQ/Pr
	G4e++3m5om53C3wUwOvM3L0zV7jrJhlpbqL3ujT/d2/FpVR8HnslDawu7XyfYg==
X-Gm-Gg: ASbGncvi0ogjGQvPEPEySEEbZSIGC87eJBBIqDKZusWWqBPbHlXOiGbQW00K2weTT0N
	cKU9+ck/9XZVn41efYfd2NVaRFwR9VXhQsHBLB5jMw8Xw5GqYbKvOdsafL4jGU/3UcPp9sehg4x
	Rz/JrahXmysvCPpiGQdX/E7vx8PBAoZSVd1YxzSYOY3bN/VkSJkDnodR8gUtOaf73AKZ7CRl+N5
	QMLOXDrItehTg8roNL/7gQE+MkxXYca8N/Xfjs8pu8WFHBxJMSpSSnAVbbNPNrpQXs+uR3VCWEB
	2+vpFFpMJEBXBbbGUEHlk12k5Y0iFXbDQeiqe4iiokPIr6qp9ydkerb39svHbFv+f66B5LLhGBJ
	NtWSCf3akbB1xYhL958j3K1CUFvp8gRGBmhL35q93bzY=
X-Google-Smtp-Source: AGHT+IHzFOB0Dx2xQdTOBBrJF4gY1ac50whH9AMWiMQW5GFZmmNRoFzyRZY3EUYhHTRLi0ypZNMTKA==
X-Received: by 2002:a05:6000:4703:b0:3a6:d95e:f37c with SMTP id ffacd0b85a97d-3b5e7f0fb1amr2706494f8f.2.1752148637107;
        Thu, 10 Jul 2025 04:57:17 -0700 (PDT)
Received: from mdionisio-OptiPlex-7070.powersoft.it (srvsp.powersoft.it. [93.146.228.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e2747fsm1652622f8f.100.2025.07.10.04.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:57:16 -0700 (PDT)
From: Michele Dionisio <michele.dionisio@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	Michele Dionisio <michele.dionisio@gmail.com>
Subject: [PATCH 2/3] mmc-utils: 1 parameter is the required number not the minimum
Date: Thu, 10 Jul 2025 13:56:33 +0200
Message-ID: <20250710115653.2808619-3-michele.dionisio@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710115653.2808619-1-michele.dionisio@gmail.com>
References: <PH7PR16MB6196D50A37E3A318ED6B98BEE54EA@PH7PR16MB6196.namprd16.prod.outlook.com>
 <20250710115653.2808619-1-michele.dionisio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
---
 mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mmc.c b/mmc.c
index 6770a45..7433755 100644
--- a/mmc.c
+++ b/mmc.c
@@ -221,12 +221,12 @@ static struct Command commands[] = {
 		  "or read without verification\n"
 		  "  $ mmc rpmb secure-wp-en-read /dev/mmcblk0 /dev/mmcblk0rpmb",
 	},
-	{ do_cache_en, -1,
+	{ do_cache_en, 1,
 	  "cache enable", "<device>\n"
 		"Enable the eMMC cache feature on <device>.\n"
 		"NOTE! The cache is an optional feature on devices >= eMMC4.5.",
 	},
-	{ do_cache_dis, -1,
+	{ do_cache_dis, 1,
 	  "cache disable", "<device>\n"
 		"Disable the eMMC cache feature on <device>.\n"
 		"NOTE! The cache is an optional feature on devices >= eMMC4.5.",
-- 
2.43.0

