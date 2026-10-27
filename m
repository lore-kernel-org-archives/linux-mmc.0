Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112075;
	b=yynztsJrc0EUlT65JXTmePOi2zyLoZLZJhA2TmQ1/kEJhIl9UzRckVbr3sjDUh2fC26e
	 MSChYnablBRIdHDeBEsEUS+jPn/lcWabnuS0fSHT7khZ+937P/7fBNFcyGavZdhCXqyN6
	 q9iH6YRkfHBBRAYnSfoBWJxgw0zOcoaixVGgeYwYVsr1Smn3LO7lYLA0dzHWUUuzBa6UX
	 4wnO/vumOqY834/KFUUmEcXi7a0IVhn9PU2tG8SRNqNIf2HsII69BxV6MH6U4+YGQ6NGv
	 35BX+trdbRPhRA9GzLGtth8mhhvHtOsAxTd2xL3NjjBDKHO90rDLRhXkcW+jX4LiKiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112075;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sNQrFSxkwb67TfqeaBXfew762KaolB4SZFqEO292Eew=;
	b=MgimuExt29ILQRcCt2prbwhoLE7jdIaYw9eb+dc4qZ8IuvGz4BbRMYtATAKn8ueLtI+r
	 fY2Tvf2yYx3s2m53+qnjJL+KpSi/D6kKuBWgBcXWTtK9VfIP1SP239NI4gHta+4jawiJ2
	 VGpoy3zseNtS7WxIMjMVDmXT+PH/uQippFvu02KpmC9UQ8WTYetKMJyq+BKp5/qHYCpQs
	 00CnWPzq0EaUVu5rbjq/rwWIIr+AVYEmBX5ABkGxbJ2wdn6o0PTmwGfmqWR5WqGm/KaT6
	 /WqT1CElsS1bxBK+Yo1l2ojNSyzd2tcAEZlzvwthN8oNhmmpgOC2JdpmqYIzcQwEDHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=izDmuO17;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G8dBbJLB;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E3060A3831
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2E3060A3831
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=izDmuO17;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G8dBbJLB
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDo0eJ2344188
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sNQrFSxkwb6
	7TfqeaBXfew762KaolB4SZFqEO292Eew=; b=izDmuO17AwPsHeD7MyLx1exD3hk
	xKne7S5232ZqgYfC9W5U7AimIwxH18lWNkFy9HscrsSftu62DNLCYs8uqaJCR15F
	92QJfZn4kZujDqFMucTPDNL2C8joNXHyJotJZ54g6nSgPRBIj+D3sTBCj84Z4x6Y
	nYxc/AFcgFPh3OCRtSL9kjbkIgg7y97OQI29odGPG0WHIy9RN79kfXqHqdw3vFIQ
	FpfxMZ+qpsnRcbsz7vWqIgYYc00aSW306ym6C+sxf5F7JTQvwQ7t+6F+a6MdYQy5
	t2ejaRstQXfFkeFkWf/VORH8CUeKj2rnRJbiCdITRXl1+oStK0VvztiRbSw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq69dpc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f322ef7d3so913767385a.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 07:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793112073; x=1793716873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sNQrFSxkwb67TfqeaBXfew762KaolB4SZFqEO292Eew=;
        b=G8dBbJLBQGHbb/5ZGioW3IsRwJ2MlLlswnWj24TMNWIperXhNJJ2ML2z3rf25opar2
         2eNXagIMop4VAioLdeW9RhHmg6CARmj0liCMVPUvtpH5horJeMmFhL1JY2hGlZSuawmR
         EEQyjb80WqDOc1LLhPI9dG4u1uJw9Sh5GR6AeeD1gb0g8eM8foGHioOuhEcaqv609bJF
         gjX/dKUaYUHV+/3dNhxaud6wLhOF4V1uayZtrSZao7wyYjNVbLMUMNrg6McDi7UovXLW
         mRBuGAE1UVWHkP/o4ZgoUahJTRXwsqqbIAy0GylH8L0yn8E/k7KyyxcuGbTlqpGGKanV
         8LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112073; x=1793716873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sNQrFSxkwb67TfqeaBXfew762KaolB4SZFqEO292Eew=;
        b=iVSf1KVwbkcc75W20px4cnMOJko+zXsW8AtoFytgotyyFYAoeC31yOrY6W9xo0pA+P
         +l2Rw2wyXWUz7j5bv7UVlLtdlVkhKgar/rsgzVAfGDN3aLLXocV8XMLo1o7YSZE+/x5r
         dd4/y5CxRaHCM8cbHLVdxnqLOb/Z4UymBr0VdNWtjIHZebm9cMojoeE3Nb9He2BUyOwn
         BmbejsL43KVTDtqZ0SmtGsYYMsAXlewhx8WJfP06JveE0CNl4NsVPLIHmApjcaRVT5sP
         LUmT1saXpWOTOf6hw3X26JFeO+enEpy77LMgIdlpToMjBwcXmNZva+SdaQQrg+i5pwwu
         7/UQ==
X-Gm-Message-State: AFq9FYJ+SnQGQKwxhz5neGIYweU6xBaTmMFe0VxuYDJ+i850ww2MRoal
	pMdwvd21m7Tm/tfMnSNkAke/XokP3buyFpSzp4iKdZbrUmn9H6A8e2sVou4F/OAzK83+TBppN66
	yd6uJB3YAnNCilenPG/UhN8xnfvXcLvBaSkl7JoULDrL1bsJan6HRK/anGk2sedX4yZN/UHQ=
X-Gm-Gg: AYBFou1PhJf6s5yux9b6IGX7ngSwkrT0BDi62QyD9GWwgSAYdtBpRS1oShRXGgJOSA+
	GG/ADzhfs9sKvMW/egyUgNUVXD6i/ikfxHezJLxLDCsaMdvs+GF3pDZBHku8IyqKKNc+01o5P+v
	+vdybDDQrp7ZD3atPCD1o9WulgQI4+z2OgIMEbiSDYW0g0yqDfEOIvhUq18u9RhvOwl+WD0nb0n
	WoIPwZVaRj5FdnNBZ6V7i5SQAxFMJXqU2zL9x0iT9KL5NlP8zCNrboVKyYzOWj7BE3I/WWqp4Ki
	O4AlQTRz9mO/QI0kLZipyEf9xawVX0dQkkaSMIk27A7dPWcW1PV/fXwAqzXmTwT+mEYMlHONfQQ
	y9aMh+uWxpeJ5V9rnx+Jm1npA8vW09aqXxswD3p5BHbzJbXI9CaYKGdBP3Q==
X-Received: by 2002:a05:620a:40c3:b0:93f:4d4e:ff66 with SMTP id af79cd13be357-940ef7d522emr1513747285a.5.1793112072687;
        Tue, 27 Oct 2026 07:41:12 -0700 (PDT)
X-Received: by 2002:a05:620a:40c3:b0:93f:4d4e:ff66 with SMTP id af79cd13be357-940ef7d522emr1513742185a.5.1793112072192;
        Tue, 27 Oct 2026 07:41:12 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66bd3asm468527766b.56.2026.10.27.07.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:41:11 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 4/6] mmc: core: Split sdio_set_host_pm_flags()
Date: Tue, 27 Oct 2026 15:40:42 +0100
Message-ID: <20261027144051.249211-5-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0b809 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=IhfIabCZ21jgF8dh9BQA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: T-0-Nt1uO5h2Z66qpzPDURg-pYJZ1mzT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX1ksOJjKDqGVS
 n6xtU2AibqTG2RP1XiFJ5ksN9lCdjvyENKeKkaFOE+BFjbd2gX0H71kS75fkT6Zzi4cdlpw4kK9
 zmBJXVLKXKBb1TmuSt4nouvjng8dcPI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX5G7PB9jXwLxA
 cztieNbBC6tlDiVZtHHx7Thn96TwmxN3K4+OXZ2TBecsBKSQfYF1GMGKDjwe38P2mxyzjx9DDhK
 Nn35GmVEfhPWyDasz2rCVyzsq1hkW1K20SC3yyAFZnxx67oDkKFVSj93VndJ9vO9mnoDNj9uZoG
 5DqsL9mkLhOf/hluUE2lJUMVp3zd5klluoyUfnyk888yZjrgcnaLUSQIp6NvoZGIrx8qXJTJfGw
 aLgF9+n3iuDkm3bhjY8CHC28+JKGUA1QGjRSokeHuCccJntJ3ZKjSmv2uED9fgHmZM03Eteutqt
 /vd1UGXyDHwATHsEzBSnSIT4ERx33BTN0KhJgNE8YL6tq7DtU7NuwvSPudZah2PA+6PUtPvsid3
 X+k0OXi2BSWfTkVl8usTKd1bPKqzN1UYWUUkjRCzuqd0Wa4YKn6JlPbLBPQThVK2kmzcgsdIJzg
 3CUCpcGXDzLpXsPd5WQ==
X-Proofpoint-ORIG-GUID: T-0-Nt1uO5h2Z66qpzPDURg-pYJZ1mzT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270058

To prepare for a subsequent change, let's split up sdio_set_host_pm_flags()
allowing the second part of it to be used as an internal function for the
core.

Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
---
 drivers/mmc/core/core.c    | 9 +++++++++
 drivers/mmc/core/core.h    | 1 +
 drivers/mmc/core/sdio_io.c | 7 +------
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 677e445dc48c..49c0494932cc 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1422,6 +1422,15 @@ int mmc_handle_undervoltage(struct mmc_host *host)
 	return host->bus_ops->handle_undervoltage(host);
 }
 
+int mmc_set_host_pm_flags(struct mmc_host *host, mmc_pm_flag_t flags)
+{
+	if (flags & ~host->pm_caps)
+		return -EINVAL;
+
+	host->pm_flags |= flags;
+	return 0;
+}
+
 /*
  * Assign a mmc bus handler to a host. Only one bus handler may control a
  * host at any given time.
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 9be2875608ce..d3a2ff00b18f 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -64,6 +64,7 @@ int mmc_handle_undervoltage(struct mmc_host *host);
 void mmc_regulator_register_undervoltage_notifier(struct mmc_host *host);
 void mmc_regulator_unregister_undervoltage_notifier(struct mmc_host *host);
 void mmc_undervoltage_workfn(struct work_struct *work);
+int mmc_set_host_pm_flags(struct mmc_host *host, mmc_pm_flag_t flags);
 
 static inline void mmc_delay(unsigned int ms)
 {
diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 12716ec0e35d..99f857514b63 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -726,12 +726,7 @@ int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)
 
 	host = func->card->host;
 
-	if (flags & ~host->pm_caps)
-		return -EINVAL;
-
-	/* function suspend methods are serialized, hence no lock needed */
-	host->pm_flags |= flags;
-	return 0;
+	return mmc_set_host_pm_flags(host, flags);
 }
 EXPORT_SYMBOL_GPL(sdio_set_host_pm_flags);
 
-- 
2.43.0

