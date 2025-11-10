Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560A2E8B71
	for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762756699; cv=none; b=mJbmSmB2DdH5k9/4rjduPEOxCvssfJaBuAY9JKD2i66dmAkFtSUAVGNT7XhzkQZ4H2kxy3Qb9utFhZTHZKx+IWjyoXzcuWwR+x77BQZxKl3oaRsFJJErEvZdQSCOwedSP8M0SchjI3I8Mg8Jlz2MbRJIhop0gsjYXHzPhLFgTeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762756699; c=relaxed/simple;
	bh=q3JNVrxXbb+AXhPvJ9Bpegf2+j2OtGhx+/LfN31RE2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jcEP3DNog5UAm34SBBHywnzKslrDsDoOQJ+RLC/nku7sUTMmWobBaslsoycltyjmo9ltv/WllJPDJcWwUvEC1AhOW4Jea/Ters5/gYmU2R6xCSvaIwHV5uNS1igBSzpnG7GDs/EaZiT+HESB+PBtehues9lOjZ+PmmcFRanLkFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l7eRzVtp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hOjeE5dF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l7eRzVtp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hOjeE5dF"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9FPOsq781886
	for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 06:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=AH4fOfUq2O4PEbyuB9Tb1ekT9XBUf1NjKPE
	/rCkAa+g=; b=l7eRzVtpMJ1IcwyHnm1Ofstsa1RumQPAU7z3DEGFEESuys+oT+J
	fEBJN/2gpik0ffoih0m1UXL54ssIrVh8N9U/L1WbnaQ1JwLwt4a0tfufBcJ6FdrB
	eVT8vwRJGfWMzRVxduWI0LW+xAzLzOQnQ4bKp8V5OxvS1x7tkL89QuanohUsyiEi
	RvSGxuu5m54Ijxw5i/sMFs7RvIOKWCxwovDyI4/Tj1Mna3dFjd+03eB9s3UUukAW
	WIrgp1AcZ6TTtF97mvHNMBJpz4241Cadbz3wkPT2yJoN0MAxVVOMgvWc1hwI72t/
	QgJPlI7wq3ui+cp4taUN7ti2MBiL/TRaZVg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xu9um29-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 06:38:11 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b62e5979d4fso150359a12.0
        for <linux-mmc@vger.kernel.org>; Sun, 09 Nov 2025 22:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762756690; x=1763361490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AH4fOfUq2O4PEbyuB9Tb1ekT9XBUf1NjKPE/rCkAa+g=;
        b=hOjeE5dFLJNhiyWEIGR3tE6NMvXSCrQ86YTprOwKdj9cGa9ac2DWckM0gHGjOBPzQ8
         BZQpO4QWppfsxd27AuEfaoQmvWXv9NxZZ0F9xaW4W7V2hxhkuAwovTH6BjsxUPo2Z8qa
         T85AoDaOe1PT0fuZyaDrkmZDTQfSW5QBhOKLQL3nAltK9gC+3/xg7jSyIrf1e1jRjBJf
         S705BcHb8Abd871OdS18B7h13s8fIXJBLntCUZAeVeVSP27jGYfRdjBP4y9OP6xfpaqs
         OB+dYupIIWoI0Dc4/XeMarhTRyQBXwH8bIREmn6br2HszZ/7ExHWrgoUEzFa4K/G5NpJ
         gC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762756690; x=1763361490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AH4fOfUq2O4PEbyuB9Tb1ekT9XBUf1NjKPE/rCkAa+g=;
        b=bi7jKI74GtCRCrD7qZBa1mhKqijCbbrgMDleTS4yQfU2wdo9o6zwl8rZ/lMZAnVR0d
         2axgIqrksUDHzzXfeHOY6oVK5u8jF6rOCyV9SPJ0GJ+ai6cHNskGs53PV2l6aiVRCYca
         drUfxlhiz9LRL8hj5deP+isvLPfpRkLlpGc5DivEgfh/EBneHx9IUUFsalLgBBf/M1vU
         2jfjbIHP9JvrQCUqWkvnHJeeLMhB73b911JinHJXNSuSjr41kTrwqiJzmiU6ybS2xuCH
         YEdPKGEKAAZZQ8OI0UswwhrV5nH9lr2iAJdcp+ntTMN2EHvKkonGD1ZRogU2aXEOqEGr
         qP9w==
X-Gm-Message-State: AOJu0YzaFp1w43gKNo4BcqH/pD43FK8EEfiKV3YgueYawV5WpnVdo64Z
	WmB7bACoKxBB/+pyRWh5/JvgzVnsTk8r7H72BnMXWSxJokxdbVoFNzoZYJNUUGFHjtwST0wi3Hb
	bg4m+w/zVSvIS3XtMHqzFXj1w3rMi2sijnLtkvk/wkCyq5n9rvnOQ04rVfjQ9dfoF05zqDg==
X-Gm-Gg: ASbGncuR+SKzpDxBiaEyEjyX373TQxqP+GHhlZ9GRiy+mGVZghfqQ/MVxIqgRjEecmj
	li/O2lnfT4MHV+GT2UsxhOZUt6p9I9ueiIFt2DWOPwLp/v1oyULpjZwZlLOTxZokNETdj/hM+rO
	Gj68JaMaWNFsdQieB4rI5tfpsEAGZWBBA+00IG7/BVUd28yYe9fRA+JgCCcyI6OcPBLhVDKaCWj
	VT6gvmfYOzXG+tuD37hweqkLKCq0ltEBPwNEi42+QwGC0NQRymg3riKVDWIJF6TpJkmq9AEtRjz
	xBxKF0/tJSi3ys5Jvo4js8cQUrLIrLAxabFd8JxIXYv4Bg5DRhCFuqunjcIWGX0WSBfhUJ0Ha6n
	eUip73SS+sFPIgyzmRfsaSu8CakXjBQ==
X-Received: by 2002:a05:6a20:729d:b0:353:946f:fd62 with SMTP id adf61e73a8af0-353a2f44127mr4884755637.3.1762756690149;
        Sun, 09 Nov 2025 22:38:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC/4Nsj2pQuLupI3eM2rkx7A3zoslP1yulMykcuUQ5KUIQsaeg/izh0mL76mVc/tBPGwubaw==
X-Received: by 2002:a05:6a20:729d:b0:353:946f:fd62 with SMTP id adf61e73a8af0-353a2f44127mr4884734637.3.1762756689720;
        Sun, 09 Nov 2025 22:38:09 -0800 (PST)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-baa3c2d92a9sm10729797a12.20.2025.11.09.22.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:38:09 -0800 (PST)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com,
        Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V1] mmc: sdhci-msm: Avoid early clock doubling during HS400 transition
Date: Mon, 10 Nov 2025 12:08:01 +0530
Message-Id: <20251110063801.641866-1-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WZyNVRblBACYKYqbnZW54H2ork6jGwhf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA1NiBTYWx0ZWRfX5jEQxEhIlnpq
 qQQp9KxYYQf2i2+DtcvUL1UfPxJfQeBVpWDsXZAi02LCGk2Gu4tu95oz5PDdjrR9AqzBTNKU6MI
 ik9CEASlt0uNzRxmHqjA34JqqcUo5t+81Pekh/OL90cVUArzswTABByjpT1bQRSa+rpshya3Jsu
 TJVI7mTLkgyQfScVnczWlYnnygMT9O5t+lxR1zZX26b/JTi2I0B/xQ1L6ThfhTK2cz2BylAcE/c
 RoLaeVzuAI71nk42myojtWd0oxigThaLgFCVPnVZCg/vlk8TZaMyM4RLIf/D+5VgWMOUTAdZeC2
 iNyQ110yFwPyeOFc/RRKZL94yLftBzp4Um84DaQ4d2GREBPN9W9ew0zPC4JlNjKqub614nxU2Gd
 fsRaVj75PJTfV2bUJrHoLxPsUGz2pg==
X-Authority-Analysis: v=2.4 cv=ZPXaWH7b c=1 sm=1 tr=0 ts=69118853 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=hZQ1MXfSydDMrBGxCwYA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: WZyNVRblBACYKYqbnZW54H2ork6jGwhf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100056

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
 drivers/mmc/host/sdhci-msm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4e5edbf2fc9b..eca6a09a4547 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -355,7 +355,8 @@ static unsigned int msm_get_clock_mult_for_bus_mode(struct sdhci_host *host)
 	 */
 	if (ios.timing == MMC_TIMING_UHS_DDR50 ||
 	    ios.timing == MMC_TIMING_MMC_DDR52 ||
-	    ios.timing == MMC_TIMING_MMC_HS400 ||
+	    (ios.timing == MMC_TIMING_MMC_HS400 &&
+	    ios.clock == MMC_HS200_MAX_DTR) ||
 	    host->flags & SDHCI_HS400_TUNING)
 		return 2;
 	return 1;
-- 
2.34.1

