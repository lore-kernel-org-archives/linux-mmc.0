Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112072;
	b=El5Q5yeEiZ4mf+NVJTNb5SWnZ17Q13IHpVHUr+hA+EQXu3BE1rYkPhQ0dMv9G/pFk1qf
	 xe83uBpcHuj6HDxMN3IT0OnjoaLrgs8g+Zh+IXs7jbESWAwxqYbXQLV4wEGIgaWf0Cyu1
	 +c37i4FpKOEoOVEtUFhrYOYKReKGAiSCna5DyQ8mLh1hyr28PTccUM+TM99dkwaFPGqni
	 1iqy3HM/ZoxcDCoRDnFfJgRJCFwOxAAUv8XMt1nNyklcNaXjOF7qvoZJ186b6aVoEyEA1
	 M1GU3yJ9KAz8Vmv10d1AZsr36CHUTN+C26DjBVeRI2TDfI4UMWdt691jyeSYcbxuyzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112072;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=I8iY6dctpy08oCwmGsuuZQ8b6LI+xgkWJSZSATy+Ezs=;
	b=YXEitR01u1HyxaPDIIkQYumnmsmD3I1geMZUJsQoxcNiPtcjxY+24ulXlYWMpnRvY69y
	 Liqdyqc0yNaQw0tzMjkWig79wLaecqMp3fCzS4LhvwxGUvgtJ0Xwj2Fmk8uoh4YTJSwAJ
	 r9AaUSglPHVADAaCWhYjkyJVtQ3hZ4Ele8GX9cfsV+1MIvGIfBWawRprZ8JRc2LplqDtD
	 5m28P9XSsIPFyVZQiULlNFyd+OH+DjZqok79HuBh0GlDUjtHwxDnzl7DC944PuDxlPuMH
	 0iaP54nno85EuAzu2vffPQ6LktTu2rNUFDs9OTKVSkMFVpc20RLeX7t9zFPZMepBuSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ThJoftzE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U2er7ncE;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2860A3821
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FE2860A3821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ThJoftzE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U2er7ncE
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoOb62397345
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=I8iY6dctpy0
	8oCwmGsuuZQ8b6LI+xgkWJSZSATy+Ezs=; b=ThJoftzEkcbyirUtFNGV32zIAbQ
	lixWP8AHIYlO2goZbSse+NHuTbKpNkt/qTd24ftjNRZwjm/kTphgz87jLpx7tbgk
	WWtXIQRbnR6R87tsrQkx1FXhJwr+/haUOQ8x7micAgZMkHqyvEwG2ad0mr5xSSkn
	H/nKxTyXyLn0HqjGF+cJFW50z+S/di+IDeJDkAtq2ks4CT2fXBUslPaSZ3JRp81q
	p0Y/rgYmdGkm5IeajiaHFo18rBpnxCbHqtIT9d1hRbKf6YEOpsfnxOW3ZuOqXyCO
	mjMtYYQtPJH159FwCchJBewrPEu36+MCzEmUuoeEPYBZ0TqatdUT2i4gMUw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjst1h3r5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb71b1443so936502285a.2
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793112070; x=1793716870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I8iY6dctpy08oCwmGsuuZQ8b6LI+xgkWJSZSATy+Ezs=;
        b=U2er7ncENVKsyuigarQ6AXOCSyH59HLOZujA52EuvYE5NKHGzYnmrjhIG9DC7jfgiU
         FeYxwv9D0FXR/2C4enCWHLZFDRtQhfi81dhgpfNOluhDjHtC/o5J/SmPBswZBi6TFMRs
         1sOGdk9YrQwsDKVGpXNXYyHVCglTMnXr4oDBVH8FI3fModNzAqonwYfcaY6/WKjf3rAL
         JKIwvqOg0/cigVE71w98oRU1CxTHyLtX3g1Gsxwec1HLmdig+FmG4gwMVtodQliwzwab
         wnHg4UmSl1wZRFa2W4NJbdu7khexoG2t9vjm/cSceYjklmI1ioHT9yB/LMkBzlWkqEYu
         Aacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112070; x=1793716870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I8iY6dctpy08oCwmGsuuZQ8b6LI+xgkWJSZSATy+Ezs=;
        b=Qu6+j+vBwVVJHjMB5d9uB8aarTiSeZwq6LT2Kw15pzcHBcRsBLvHiSkM4Kw7Gueqwi
         FcGuYqgWBOroJNRIkIR0HzP1vgW4OFrNhw6wcoap5vgfEWoiwUgCga3jovlCMLo85+sk
         XsNtRPnFb7llVod9AQzlsJC6+yc/qI4ePVcT7xAj4XmWjQEhMFwbeYlWYI8dJQxs9RB3
         AGW8qNQmX5u5iTmLmiIzjePf4ebXQqDNfrB1EKHyXanxVFK9Dy64JTtgeGtg5TuWzgp/
         CeYlnDf81ZOaJHfH80XMOVUfPVN5Hw4uKlIbUYb0EmGVP78D8kvSF2+g3iVZsd5dLwrC
         HdkA==
X-Gm-Message-State: AFq9FYJ+/pUTDqaCNlSYrwGJWz4Bz5fEPuhiCVz7tmHimgtR3vYzEnRB
	Q6djnnu8ng9G3TNWS0qVa9c7nuh534NJMMq3Ir9rdtoMob1glsaFPqw8jrMBeN/CojtrrAmbLDV
	BmQuf/KjN22aCcKjj0Q5Y/lzMePeccH36vGSHaeklQEzu7PAb1VsXlWQVSYRieO53WIZo/yU=
X-Gm-Gg: AYBFou0bridyK+L6GDCuAMq56IMSPnRYJm9eQiiChuPlBWCUTW8kdfADwGa8ADdKDaO
	NE6mTJ/a4KKKq1g3Hu4IkhxXgYAHupFThlYkAtk9ZLZbVdaSR3aH+/kvbMWYYxTN1tY+WZqbCVY
	HbmF8f9VA9OANAv4xcnXAT3jA9+cvewFuS5v2z41tB+5Wb51UsoiAyDiy7mfs1KfgjG7m7fH8zr
	gxBQoPZ7RXZmGjfNIYC/neX6MDZsZxD3zpbum3KHmJ5nqCwIn0cPOTTjRhB0I3vm4dq2kPb7f/J
	cNeiISvzR7MKw6aTSg+8ILMz8KhO98JHE6L0EMiLpso5Bru4s53MAAJ7g98sKaU6m/uHLWYkakj
	Cd5eoAYjcZaW0yomAVWEIxpYWtRxAbKftMjs6Qb5KUm+ihkPdP0fRM84PbQ==
X-Received: by 2002:a05:620a:4621:b0:93b:e5e9:23d9 with SMTP id af79cd13be357-940ef8bbf77mr1602546185a.23.1793112070384;
        Tue, 27 Oct 2026 07:41:10 -0700 (PDT)
X-Received: by 2002:a05:620a:4621:b0:93b:e5e9:23d9 with SMTP id af79cd13be357-940ef8bbf77mr1602541485a.23.1793112069919;
        Tue, 27 Oct 2026 07:41:09 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66bd3asm468527766b.56.2026.10.27.07.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:41:07 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 3/6] mmc: core: Add option to keep an eMMC powered on at system suspend
Date: Tue, 27 Oct 2026 15:40:41 +0100
Message-ID: <20261027144051.249211-4-ulf.hansson@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=HJ1WhYtv c=1 sm=1 tr=0 ts=6ae0b807 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=wQhRatfwtUYrVbUM:21 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=X-xDrAPhK5RcuPCaiSQA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: exMaEubZQoQ2pKo0-FdrL_riVCTSjoQd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfXyxvbRd+8EDr4
 N+mjdHgscuBPcsOAHHq50UOyFg9NHJYSAth+U/MSm7B3vzK4FYjgs3k5ohEY7OlN3a3mkC0y6qJ
 t+K9yet5G1pWVVhsfXr0KGO3Vb3y+ZU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX6MjUGzYIXsOg
 +OzaMcnYecuVy5NL7Sh4PObcJQasW1W98pDRjZgwOat6OtwxBdQuun4zCv+EDS/To5QggKiceEr
 eEr1baWabcPT7qL/Tay3qj3MkC0DW+XN7lpR88sDZ3G3jpXzwp5JCIEpQB1lyezH6fnnX75ZZzB
 OiRPWbhoaVWE5ZPir90ZRJpT2IxE/VjhjhDti0QX0iI0kh8XzAtCL3F5CwLDVune940m/nUqikJ
 iQ0/nDk81TzISMlnJGalQx+pONY+r0TQ+1qsgQnmj2OCloyCVOqAUgPNPu7otpcSwxiTcAw5ALW
 bK8GLEV7n2r48ZBhfKbXLUOjnsmWHzWmBrwOMryxHsivKoERX6zOEiDV84V3o76NVA+ROOzKRBB
 bStjq5+WUuSyluiJWfxkYjqbJXx0ErQheW/3SoVJ5p6fngRX2k01oR0Mk5HTBlBETkkL97zO3CI
 bY0/mmn/tXjTCx8TPvA==
X-Proofpoint-GUID: exMaEubZQoQ2pKo0-FdrL_riVCTSjoQd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270058

The DT property keep-power-in-suspend, allows us to specify whether the
platform is capable of keeping the power to the card during system suspend.
Up until now, this has been restricted to be used for SDIO cards only, but
let's add the initial support to allow this for eMMC too.

Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
---
 drivers/mmc/core/mmc.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a02b04938e1a..c936272bcd81 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -38,6 +38,7 @@ enum mmc_poweroff_type {
 	MMC_POWEROFF_SHUTDOWN,
 	MMC_POWEROFF_UNDERVOLTAGE,
 	MMC_POWEROFF_UNBIND,
+	MMC_NO_POWEROFF_SUSPEND,
 };
 
 static const unsigned int tran_exp[] = {
@@ -2157,6 +2158,15 @@ static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
 			goto out;
 	}
 
+	if (pm_type == MMC_NO_POWEROFF_SUSPEND) {
+		if (host->retune_period) {
+			mmc_retune_timer_stop(host);
+			mmc_retune_needed(host);
+		}
+		mmc_card_set_suspended(host->card);
+		goto out;
+	}
+
 	if (mmc_card_can_poweroff_notify(host->card) &&
 	    mmc_host_can_poweroff_notify(host, pm_type))
 		err = mmc_poweroff_notify(host->card, notify_type);
@@ -2193,9 +2203,15 @@ static void mmc_remove(struct mmc_host *host)
  */
 static int mmc_suspend(struct mmc_host *host)
 {
+	enum mmc_poweroff_type pm_type = MMC_POWEROFF_SUSPEND;
 	int err;
 
-	err = _mmc_suspend(host, MMC_POWEROFF_SUSPEND);
+	if (mmc_card_keep_power(host)) {
+		pm_runtime_resume(&host->card->dev);
+		pm_type = MMC_NO_POWEROFF_SUSPEND;
+	}
+
+	err = _mmc_suspend(host, pm_type);
 	if (!err) {
 		pm_runtime_disable(&host->card->dev);
 		pm_runtime_set_suspended(&host->card->dev);
@@ -2260,7 +2276,13 @@ static int mmc_shutdown(struct mmc_host *host)
  */
 static int mmc_resume(struct mmc_host *host)
 {
+	if (mmc_card_keep_power(host)) {
+		pm_runtime_set_active(&host->card->dev);
+		mmc_card_clr_suspended(host->card);
+	}
+
 	pm_runtime_enable(&host->card->dev);
+	host->pm_flags &= ~MMC_PM_KEEP_POWER;
 	return 0;
 }
 
-- 
2.43.0

