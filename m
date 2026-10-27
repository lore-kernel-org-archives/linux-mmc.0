Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112077;
	b=KavqtEP5XtcbMNA9IL4GtvQddEUzgr97FWyhZqpgBSZkH0Ik0PJsN8fPyI+1x/5pkNBT
	 gSG/S0Axm/3nlTlYpbjRHpLhYE9GYreNY0LOcZv2Cf/8tqREf0u3EdMKCo43g1B8XfO2G
	 myK1ct4mFnYk8iC34XddNIbR/MZnQ+hXGbdb7fWw7nfXJd6IMQ/Y5HFX+ruzSGKTpUttd
	 HCc9aOjOAGXk6HPrSX6b2wc87iJhX5iugv9AEdXlk3mvcS3PbMwen40q2QosOdWOWQUvu
	 mB5zfpzXoMzTcWegGZnRl8y/7zXO+vlLF3TIA0l+FhHebopvmVJLCfRLEEqaovq+hbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112077;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cQEUa1B2hNGvlDMG4Ti6ghl4fU3dN8tetYb72gg/lgw=;
	b=BO38WVdKqJbQN0Y9RCYH1q/A7MIK/p4wd/zzhSS99nYymkycocOGoVAFNSrALFUX8FCz
	 YEkOTQlZpxnkRdy1FQis+12I8GyN/hDxYYUDGvgOrVnDU5Dk351xx1ryvqDWPNUUnQ2uL
	 3Xoc7dOb3yjfG2qxcBU7NYYw2VcBP7Hx5SsQOaEotSmKiY+wysQtdkO2mKVyzKvIjWmfg
	 N7XsmM3hpiVNWT0AK2mN6MxQ0RTjqTuIzvHL1wbZi6StgMMrzn56bOHZ7OcfH2ymfeakx
	 8VFxGvxC4IcjnNXrflVGt/kjvFXdPB5AjIpbhxMyMARq7LbKrXxJujvlb9seO69jPGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f+l4XVio;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UHknH7ir;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B0606A339
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A01B0606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f+l4XVio;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UHknH7ir
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDo0bL3449457
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cQEUa1B2hNG
	vlDMG4Ti6ghl4fU3dN8tetYb72gg/lgw=; b=f+l4XVio3PCmEjCl+DFGlWBzULF
	cIQgUXcU8OwW5ljw1ns6SB6qVrGd1P9XWdsRfCewl2h0/Q0G8hRhIoTy3MOQAZtJ
	0f4DcDF7lX2AXMUTqEx7yPXixe7FL2XdCblF5lwdm2EfUxz/NZCSKP0Qhiw5j1lZ
	mfjHrU2djFcVQG1aqqN2cSw9yHUx8M/4NGsrxVC2qCDgu+eMQ4YrupmA01ogfS0g
	8M+BSkZdojYyGaxLHoBSLEMLPWsDUYGSq8po93ruY6ymD6qR3tfWf5wzP2Ap7gHZ
	zDHAf2b/lx9+s4WdykobfyjdnOjJTpW/3bxKtKs5o91kmLSghIHxDLd74Aw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjh91b0ny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb7f9bb86so839629085a.2
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 07:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793112075; x=1793716875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cQEUa1B2hNGvlDMG4Ti6ghl4fU3dN8tetYb72gg/lgw=;
        b=UHknH7irnuU7LBkGXazSmxLbXXQMy8IGB1A5C/Mt4O9SQSJs2e56VmtPZ1IRqMGnmq
         Iwmf8uYop1OSZumxvPO39g6X7s2cdKS4QUQJaE94dz+6bsRR4zzEQXRNj19fEEHVDj+k
         l0Z3e9GQ1TjCfnOLRGq/RkXJafIOlcJle9RlpJNwETvHuKTENn1FfqI8RiXfSZZEdhtm
         OhN4VOvoo/eALA6YeKJbE6sICPaDdj86TtYbErxDmQhOWvN1u/lWaIU3t2E1xtLAHSzd
         fxgVcxmXleNMnz6KlgwCrO5T27VeOcY3/q0BxPBW7sh1L/GK7PmYQVNveVa+CDBTi0S3
         PHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112075; x=1793716875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cQEUa1B2hNGvlDMG4Ti6ghl4fU3dN8tetYb72gg/lgw=;
        b=J8SN4E4R9FnbiDtOU1WAnQx+A8AsIY3LFbIlp4fviJpeqzhcAT2ngaSxModOHmhZQD
         Qs1wc8pqNIWffbpK6V/gPc9T0uCDDPrK1Ao4uG32SXCo9dECUwADIwqfPxYZgidD51pE
         MssseoXPZeh4W5jz0VKBrLyN5Ev9reL2hDhEmSNSfgBZv2pU8MM/rIr3iz8WqA15P88r
         f11lQZWVDzawgr54VqNl3+B8ouuH26nq6wGAYBQ3hthV4XydBGmrtw+rfX+UvlQH2y27
         UEFVhk3eyNSxoAUnrYenLjYM7TB2TA4ZofAz5lhKroRhFsuGmACPrLXKG3o/9owbQKfa
         cZIg==
X-Gm-Message-State: AFq9FYJwz3EMFT6mZJnde4Q7HVPC1XriPqeaa8UkrjKLTv3FXMBsORQd
	lvgWi7XsqUCIVxhVxN7/IYjiaRr9mX/PT/pA2AeqzBnHotK5NLHwi6wHXyqmZSG7g/aUvq/Hd4u
	I5d2/ewtRsMuPgrQ6z8TWTV+3Ggq9DwocEgE1Ud2fszSBbckjSMC/vyktbYWhei3Rsn+wrB8=
X-Gm-Gg: AYBFou0wpq5QwiKo501Jp+rFsQU0QWVWoNPLY+f/zgnHhJvKs1wbTShLIkMaNE/j+r3
	5F+GYCwVf+jP+0FbHToEda7yyeEQnCrvqoTUfyTh+rQOZtN0YPWmLF/v00+9S7x3Z0LyNU60lCf
	1p1QPtMTVFk0M4vVxzH8W/XcO63ivpq7IHKIlIXCZo1QUi7GyPpa6AGswLembHF/vuWZFeiYVWc
	SK5sQ+NtjiDHXtfWpj0e3j5qDIwah2+woLQXeESPtMY7/eYoc5sNrjlq2y4e7CquYEplqlkjEF5
	a0zko6u6czZfjDYKz87P4A1WKVgRGE121S2t/UUGEm2pkjO8LiAO4OMl4kKwmM+VdK7laSXheTB
	zPD2F3wc3+iRhAP6KX3XMH9v3qtX+pCdtsPyP6u4ZcmK9u5iiZEHhDcIdzg==
X-Received: by 2002:a05:620a:2313:20b0:944:192:85f0 with SMTP id af79cd13be357-944019288bamr96612185a.24.1793112074744;
        Tue, 27 Oct 2026 07:41:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2313:20b0:944:192:85f0 with SMTP id af79cd13be357-944019288bamr96607885a.24.1793112074135;
        Tue, 27 Oct 2026 07:41:14 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66bd3asm468527766b.56.2026.10.27.07.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:41:13 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 5/6] mmc: core: Move reset functions for eMMC
Date: Tue, 27 Oct 2026 15:40:43 +0100
Message-ID: <20261027144051.249211-6-ulf.hansson@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 6xwqYfrv5S2M9fI7vJtIDBdBHFBdZZcY
X-Proofpoint-GUID: 6xwqYfrv5S2M9fI7vJtIDBdBHFBdZZcY
X-Authority-Analysis: v=2.4 cv=TuxzFzXh c=1 sm=1 tr=0 ts=6ae0b80c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=XtTdTuYduaSdZlMxMiEA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX6YchZsnakvlx
 y9jYtDacU+qj2nHAp54t91z+jramwquehXaomk5CpHUjyu5kLwVihXn+ECgxK0z85anr0Z1hIHL
 TIxvYocHl4CrpCrZO/Jmo/KwCAcfdMzXZ3CH8Ht1Fq8QopxaaEo9sUiVL3/Iz/gYhHe53BGoHTZ
 Pmlu6sQJU+Pc4RyjGlZhsRRE0AfI0HIPSgRR+H/birCaPRgNoap5uAH0+yH7i0Ev3rkSv4Bg4HJ
 7UqklDhtcQ01NijcK0lwJOTFAsenL9lJWp2znJOZIhuUagD9bxISI0qByAU+lJjJvjjI5XuSKEB
 xz8mj/CuXP81qNmUJiTZF7u5J6J5cmAEDPLOWv3y6B3hW1UCeNDM1g5/igTwQSD6h84Sp+7M5L0
 ALwdLqv79g8CsReyIlgqMkAPlwRTWjCBnDVE4vYjnvaaOG50W0OadcrC7EO/M7fG8tsQZsMFAdi
 PnP9Do8XD9bfP+uhWcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX0P0tRRW/7I45
 0VrLEF3TthicQwzE4+tWWZ+EKoM04JZrjh2wegy2+f1gQ8cQ+gZo1l97cKxFfZTIoVqaudK7nrM
 c6ajlqnd3zVFsQHB7nSfltvE1h5Pq2I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270058

To prepare for a subsequent change and to simplify review, let's move the
function for resetting the eMMC card a few lines up in the file.

Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
---
 drivers/mmc/core/mmc.c | 66 +++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c936272bcd81..d4bf0f25bd74 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2271,6 +2271,39 @@ static int mmc_shutdown(struct mmc_host *host)
 	return err;
 }
 
+static bool mmc_card_can_reset(struct mmc_card *card)
+{
+	u8 rst_n_function;
+
+	rst_n_function = card->ext_csd.rst_n_function;
+	return ((rst_n_function & EXT_CSD_RST_N_EN_MASK) == EXT_CSD_RST_N_ENABLED);
+}
+
+static int _mmc_hw_reset(struct mmc_host *host)
+{
+	struct mmc_card *card = host->card;
+
+	/*
+	 * In the case of recovery, we can't expect flushing the cache to work
+	 * always, but we have a go and ignore errors.
+	 */
+	_mmc_flush_cache(host);
+
+	if ((host->caps & MMC_CAP_HW_RESET) && host->ops->card_hw_reset &&
+	     mmc_card_can_reset(card)) {
+		/* If the card accept RST_n signal, send it. */
+		mmc_set_clock(host, host->f_init);
+		host->ops->card_hw_reset(host);
+		/* Set initial state and call mmc_set_ios */
+		mmc_set_initial_state(host);
+	} else {
+		/* Do a brute force power cycle */
+		mmc_power_cycle(host, card->ocr);
+		mmc_pwrseq_reset(host);
+	}
+	return mmc_init_card(host, card->ocr, card);
+}
+
 /*
  * Callback for resume.
  */
@@ -2319,39 +2352,6 @@ static int mmc_runtime_resume(struct mmc_host *host)
 	return 0;
 }
 
-static bool mmc_card_can_reset(struct mmc_card *card)
-{
-	u8 rst_n_function;
-
-	rst_n_function = card->ext_csd.rst_n_function;
-	return ((rst_n_function & EXT_CSD_RST_N_EN_MASK) == EXT_CSD_RST_N_ENABLED);
-}
-
-static int _mmc_hw_reset(struct mmc_host *host)
-{
-	struct mmc_card *card = host->card;
-
-	/*
-	 * In the case of recovery, we can't expect flushing the cache to work
-	 * always, but we have a go and ignore errors.
-	 */
-	_mmc_flush_cache(host);
-
-	if ((host->caps & MMC_CAP_HW_RESET) && host->ops->card_hw_reset &&
-	     mmc_card_can_reset(card)) {
-		/* If the card accept RST_n signal, send it. */
-		mmc_set_clock(host, host->f_init);
-		host->ops->card_hw_reset(host);
-		/* Set initial state and call mmc_set_ios */
-		mmc_set_initial_state(host);
-	} else {
-		/* Do a brute force power cycle */
-		mmc_power_cycle(host, card->ocr);
-		mmc_pwrseq_reset(host);
-	}
-	return mmc_init_card(host, card->ocr, card);
-}
-
 /**
  * _mmc_handle_undervoltage - Handle an undervoltage event for MMC/eMMC devices
  * @host: MMC host structure
-- 
2.43.0

