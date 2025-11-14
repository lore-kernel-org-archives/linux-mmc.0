Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71C52FB61D
	for <linux-mmc@vger.kernel.org>; Fri, 14 Nov 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763108924; cv=none; b=M67/7UfU3dqzznWvl15FIra4L/fSIB/4ntP/1hx+ivHfUiDt2h6OXUZRawn6HWOLwxxMRnR2wlwcRR0ipX0LbK/grzvDUMuyoGykrpyqj1bOxfZpgqOiUgmNrg3FDW6EGIekUgmW/iH9+IoL/4fNl9B1oe+hpSiMASkG12NUTlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763108924; c=relaxed/simple;
	bh=AI4KO6aV7yUOTSXbEIrkTgQTAW7EX6hPVYZmqkw3FBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ao7NrTh/Jcc1ZnkgH3pL5M5Rek4b+bRyqUE6K8i0inh2w4gpiJuobCg+g6VbNx5AovNsNyOef8PPAGk8i9DRlbvN/3MkCnliAbup6avx4hor9RfF4nqKvVsdpDd5v9sWLpJW4iPskAGdvhpQdm3PkjqRdjydoUx0crEH82TRxms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DgHLNdtC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NN+QE1zK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DgHLNdtC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NN+QE1zK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADMavI51427247
	for <linux-mmc@vger.kernel.org>; Fri, 14 Nov 2025 08:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=T9lYcon+xXMFEgw5UyE3UtNnlyVIpRVbOX5
	LleJNgHw=; b=DgHLNdtCEEfzIxhEL2i4m0Sg5U2Co+HWBgfzNReRf2hnasA+w2B
	qVXbc7P0D+VpnXjc6MnzJW6DvVFW8M+5n+28pcXFV3n9cRfbCccj+Xf0hSnXQe1T
	EkSUggG9Z+g0A9RGoVbyInpOysB5Of484O9DsZV11CF/DBI95L+3FPDkZY6Mr3Sl
	PVcWUaAsB4rZ0yJ0BuE8F0JoHTwjgY6+Wm61FfNsRJQgH/v5kDICK9MouJY71X+y
	at16vAdcKH7TlXR+I8ZY6nQo4670XSNZRIJm35qI6NXzTARSCyoxjjUH2OstKuMI
	3LNIJ7YQGAVyOIybM1NxQDKQrVIt6zdk4bw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9g1cv9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 14 Nov 2025 08:28:41 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b0007167e5so543239b3a.3
        for <linux-mmc@vger.kernel.org>; Fri, 14 Nov 2025 00:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763108920; x=1763713720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T9lYcon+xXMFEgw5UyE3UtNnlyVIpRVbOX5LleJNgHw=;
        b=NN+QE1zKsGhH41fhAraexwm3WSQ6Q6j+c6cDfg4k6te7nhfmXPR0pSdg8Z+wpQVvfA
         Q4BE5OcMj8Bzsh5ydS23v+2FzpZoySK0B6QjdYwxyQ/m5W5q7jgAOdeMGZJgozkrvFKo
         y6ST71TbnNjkS/ALyGZwiT6zCQvuaUj2hCzOVXBJOwfc5RH7oO2Nn6qAuB9xVsaWm4YL
         pM2jPvVJ3mukty3qaGi6V7eHZ/uO4GtZwamSOE11lOxMR9ReG/v7gUFy3zm9h6DvMg4s
         bsprzCUEYrU8L9au+/zfrwm+MzeaUehQgI/aeubJAIhTQyiaiiBbsEuylz/TdoTl8+4o
         8ecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763108920; x=1763713720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9lYcon+xXMFEgw5UyE3UtNnlyVIpRVbOX5LleJNgHw=;
        b=Kugz7s8HctYcQmhTZI1Eu66FEeLPc0tQuMf14rO2ldX28b6hYHch+ftykxQTwmuxWA
         q9QL2Eu2utQuHK5zQNUW48EFoxMcifwuD9RysIC7u2EjcJYMo/y48QKuLuLhwqcdY0uS
         nwDrwS5yGdFPa43FcRDhCvF8KL5q2WsjibvtRitJ80jOCq4ZWcHnHxz7jTXVpYtMRFaK
         /ha3kS+6Am6ZVF7z8wIwZ7Rau3qOCKsjeCI4as4FOOCBXoEIiCCYT8WCOASRt6NqHB/U
         MNc5FADYi2vXioJjNZtbE7/DTKPy5oWj4vOL5JUDqbIn+y8mGVJqpNBe+lDMjfKLcX6Z
         IEjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4bKOv1B3oxYJrH1gtpHGucOszfO/yG3QbeFaivFzph/v7fITppwZU5XUv2MoR1V1D3bAfU0kS7OM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvn1AQiWg2sCPb/YebavozvhRESQTe82QiSZyFijfBz9L50eGZ
	rmQdu3PzXVnNQtC1feushFXGMy7r1d5mTb+8Ev1CzD14d33Lf/AbsoepnK0EGiSZj49wMbbKM3Q
	J0dwYNYkGbRRMPSzbEdsAVrDS1TX/pwb2y23Z6sFlCGow0UZJDL2NDtIifWHg8g==
X-Gm-Gg: ASbGncuOeOD8z0eXFnJI8BYaAkMA12j7r2PJlOUBLfuJCaPw532UDtCBLPHc/sSyq4M
	kJCkFaK/snIuwGyF3oDAZDDx2ZyZy+9az5dtV2bCfpsVbmtIqM7zLvdUDpHIwJ7ER+RS9lBPTl1
	GbIjXEJgq1K8P8+lKAtX2ed4OGiYIqERWro++IDv7uvTMa88b9HaC2mN02jBYElFUUrkubvPVsM
	6zsapSdQpJEbEduD/NYPVT1Sj0P2pLwE8UtFbg8P3OwqGvD9iIKUFtG+5l7kTs5FQcooBTM0JGQ
	I9LQXm3l2cg7Bsp5l9+T7lk3lI+T33TSin9xRPoEO30cfEp3tcRsAhRz15XDHvQHKbQ7/9FnOJi
	nk0bREujAffCiod+tUQqAyL5Q7Uhns5HGReRn4ELs
X-Received: by 2002:a05:6a00:2e21:b0:7b6:ebcb:63fa with SMTP id d2e1a72fcca58-7ba6b790a4emr1296789b3a.0.1763108920186;
        Fri, 14 Nov 2025 00:28:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYSYA8F1SPeFVBxbuKdJm09PVEUwa31Jjh9DyS8E5KBXBwQeJQ/M8+eje7PDPADKFDSZOS0A==
X-Received: by 2002:a05:6a00:2e21:b0:7b6:ebcb:63fa with SMTP id d2e1a72fcca58-7ba6b790a4emr1296762b3a.0.1763108919589;
        Fri, 14 Nov 2025 00:28:39 -0800 (PST)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927c24254sm4485425b3a.64.2025.11.14.00.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 00:28:39 -0800 (PST)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com,
        Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V2] mmc: sdhci-msm: Avoid early clock doubling during HS400 transition
Date: Fri, 14 Nov 2025 13:58:24 +0530
Message-Id: <20251114082824.3825501-1-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=L+AQguT8 c=1 sm=1 tr=0 ts=6916e839 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ZhLSBf8pC8IsRUYoglEA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA2NSBTYWx0ZWRfX0bbmsR73zjsx
 qkk+2gHuyqjcYh1le3y+4D4gz/OijNtte59lv9MU6qUILXw4sbp+ECONymIGSPt6Sl9InpHghH6
 JUlFam1yZKir1ZGaGsqE293bGjtcUluI5f8jDcqM6YUCotdf5LuVCf1DmoMPmWephPX3f1Y/U2l
 unv9qqiOVkyvoMEHWMjFVI1jxvuyYsspRZzJlDKRkdqEUCVwTdVd9UaFq6ayJ9ZIs6j2kIKqEVU
 b/3dlYy/SNmUElowGt2L6+aCVadlsVsFAsXmpXZdP/xMNhriKya2tNlzJjfTnlmbgxjGzkWFy1Y
 AnYhecbbf/rhYY5SZb/NNRo+rji1TB+vCVNv0y4cahAf8ituh2RgTtd9EkW0brRdtY3+4oyvWmY
 OLoLeYAg+7M4rLKieNgB9zlqBB1Y9w==
X-Proofpoint-ORIG-GUID: LyI83vUpi2QMP4d04marOtHvIxB0U0-V
X-Proofpoint-GUID: LyI83vUpi2QMP4d04marOtHvIxB0U0-V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140065

According to the hardware programming guide, the clock frequency must
remain below 52MHz during the transition to HS400 mode.

However,in the current implementation, the timing is set to HS400 (a
DDR mode) before adjusting the clock. This causes the clock to double
prematurely to 104MHz during the transition phase, violating the
specification and potentially resulting in CRC errors or CMD timeouts.

This change ensures that clock doubling is avoided during intermediate
transitions and is applied only when the card requires a 200MHz clock
for HS400 operation.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
---
 Changes from v1:
 As per Bjorn Andersson's comment :
 - Pass "timing" as an argument to msm_set_clock_rate_for_bus_mode(), and
 then pass host, clock, and timing to msm_get_clock_mult_for_bus_mode() to
 align with the original intent of the prototype.
---
 drivers/mmc/host/sdhci-msm.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4e5edbf2fc9b..3b85233131b3 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -344,41 +344,43 @@ static void sdhci_msm_v5_variant_writel_relaxed(u32 val,
 	writel_relaxed(val, host->ioaddr + offset);
 }
 
-static unsigned int msm_get_clock_mult_for_bus_mode(struct sdhci_host *host)
+static unsigned int msm_get_clock_mult_for_bus_mode(struct sdhci_host *host,
+						    unsigned int clock,
+						    unsigned int timing)
 {
-	struct mmc_ios ios = host->mmc->ios;
 	/*
 	 * The SDHC requires internal clock frequency to be double the
 	 * actual clock that will be set for DDR mode. The controller
 	 * uses the faster clock(100/400MHz) for some of its parts and
 	 * send the actual required clock (50/200MHz) to the card.
 	 */
-	if (ios.timing == MMC_TIMING_UHS_DDR50 ||
-	    ios.timing == MMC_TIMING_MMC_DDR52 ||
-	    ios.timing == MMC_TIMING_MMC_HS400 ||
+	if (timing == MMC_TIMING_UHS_DDR50 ||
+	    timing == MMC_TIMING_MMC_DDR52 ||
+	    (timing == MMC_TIMING_MMC_HS400 &&
+	    clock == MMC_HS200_MAX_DTR) ||
 	    host->flags & SDHCI_HS400_TUNING)
 		return 2;
 	return 1;
 }
 
 static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
-					    unsigned int clock)
+					    unsigned int clock,
+					    unsigned int timing)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
-	struct mmc_ios curr_ios = host->mmc->ios;
 	struct clk *core_clk = msm_host->bulk_clks[0].clk;
 	unsigned long achieved_rate;
 	unsigned int desired_rate;
 	unsigned int mult;
 	int rc;
 
-	mult = msm_get_clock_mult_for_bus_mode(host);
+	mult = msm_get_clock_mult_for_bus_mode(host, clock, timing);
 	desired_rate = clock * mult;
 	rc = dev_pm_opp_set_rate(mmc_dev(host->mmc), desired_rate);
 	if (rc) {
 		pr_err("%s: Failed to set clock at rate %u at timing %d\n",
-		       mmc_hostname(host->mmc), desired_rate, curr_ios.timing);
+		       mmc_hostname(host->mmc), desired_rate, timing);
 		return;
 	}
 
@@ -397,7 +399,7 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
 	msm_host->clk_rate = desired_rate;
 
 	pr_debug("%s: Setting clock at rate %lu at timing %d\n",
-		 mmc_hostname(host->mmc), achieved_rate, curr_ios.timing);
+		 mmc_hostname(host->mmc), achieved_rate, timing);
 }
 
 /* Platform specific tuning */
@@ -1239,7 +1241,7 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 */
 	if (host->flags & SDHCI_HS400_TUNING) {
 		sdhci_msm_hc_select_mode(host);
-		msm_set_clock_rate_for_bus_mode(host, ios.clock);
+		msm_set_clock_rate_for_bus_mode(host, ios.clock, ios.timing);
 		host->flags &= ~SDHCI_HS400_TUNING;
 	}
 
@@ -1864,6 +1866,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_ios ios = host->mmc->ios;
 
 	if (!clock) {
 		host->mmc->actual_clock = msm_host->clk_rate = 0;
@@ -1872,7 +1875,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	sdhci_msm_hc_select_mode(host);
 
-	msm_set_clock_rate_for_bus_mode(host, clock);
+	msm_set_clock_rate_for_bus_mode(host, ios.clock, ios.timing);
 out:
 	__sdhci_msm_set_clock(host, clock);
 }
-- 
2.34.1

