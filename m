Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E143E4BA
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420525; cv=none; b=X4Dsy+TY2J+GREVmSWaMLGDnqjsB5LxWwIwgeMRlc/zlvPyvUD3LsLQIWDqtU7/Z/VxF2DKwECjwRYu8dAfixvnuBw4t939ekqFh2cTeuGDgw1Nn2lQw1hh73nsg8GOBUdUXjLCJFlewttASkibt/+Kqy8T+pFf25YfJO/kW1SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420525; c=relaxed/simple;
	bh=0x/ONhsoOOzKRRJYikIViC5SFY1o5Ga4LVrFVxlZo9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ShEYbLxTgacqm3ZRuN2p3+Tg99zz+UJzAM/nRCU535mi5gvSThf0lmyYsWZU3hu3OklnDSUauE1ilxCILjLha13Hf8iHQ1qu70fSWgwYwEcPBMCpjoVfYtVexXB1Vrpyw+TAe7E/CKzc/Yly4C39ooXVxuqQouRlc82p5uJEkq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IwAHQxfq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UUmqIT30; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IwAHQxfq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UUmqIT30"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDtfqn1201870
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 14:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lGn2K7VnHfs
	d5//ZGJYk4SpCsJD0eKIApEU+QqkLx+s=; b=IwAHQxfqG6Ecn4VdEEpiGm09zsL
	/dqKOv97Va1ETxB4V6tfXj/3GXd0crz3Mon3b7iUBhjRkkbzVPCosD7uqP/gNXd5
	+fSx0ChI14ZqWMRwU9YLlxLou5VtBImF9SMfp9hV50xUjXE/izNs2Rxa/V20HHJN
	n5PtccXvk9/8PHksavH32oUc3KofBUE1m1C+h3UlTcm5fl1ZQsdSqtpV4yi5ByZZ
	n2pQ0315Ujpt9zlNF4qZ0cAdGjVqxrzMIcg7dHV6BYuUySkGmR8DF061u90VqEIQ
	lvty00IjSt76o3EXFvYPSXbfuiAN3BwHH276lbxjTuat4OTPS/ddK83KOOw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr7x6829e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 14:08:43 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f45dde7595so24513116d6.3
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785420522; x=1786025322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lGn2K7VnHfsd5//ZGJYk4SpCsJD0eKIApEU+QqkLx+s=;
        b=UUmqIT30NZDtOIKO8n6q6UT9fWtJ5MFOTjaJ0i9TkLHmMR5q3x6VwTs/A7P0bLOMvH
         btIscIK7kyIcrE9BMgu3qZ7Ig515yNZdXVWLGHANj4xL+LCvNcO2dRUiJz7DGIzca0/G
         abPnFi3V7x0WeGytyCmMXCgU+79b937LZ8rTJXZ9gQDuvgVBpjmnsBECbDOClcDh2cX3
         H4grgB1gIPoZ6cJfbBlybxUItxe7J7rF2BU9tpez+//0yGLrBsx/XggikhZOsusjKgGJ
         ke3oSOmDw7j04pWfuHNb2dMZs4Wy4cGrF4WR/p25GSa32uQovFGzj5NEf9XM8LwS7ECE
         QpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785420522; x=1786025322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lGn2K7VnHfsd5//ZGJYk4SpCsJD0eKIApEU+QqkLx+s=;
        b=MwNySVw3HMebhVe/weS8wurnLCoEUIONRmrGyp5h3Bat1nB0pPqWJfst6Y5DxdNcYu
         XScdpVU1WA9cD7o1AJTwq2jjb26ZHiBzIHTJHjfiaHrp94bhQWVizcfP8bG/yr6dVgUu
         NyFn2uzFZCuQcBUn99gJU1rr4b2pMoUtpB6E9vCSrjR8S+FZ95qSSWNSeToUNV12vD66
         Pl0TaxYaIl0CA9WMp3lqFypu/8aspGR2z1sTOumcDl56oIbEBPFdkHxcSO0C16FlbjUO
         n9LemPHZCPgwNhlR5uxspwZ0UMYNhsNM5y2hyCTk+u8rKsnfZqu4/4qN+AebEaSEgVzX
         vo1w==
X-Forwarded-Encrypted: i=1; AHgh+RqR6OLr+yX/J/ANfaCBSA/PT7zVFI/Dq5UoQFbGZyhMzZS6x16RSwoelpe9WV2kiDVSgyfn9anWEZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMKD+g/qPse5GemJp6AHJ7x2woZp59qxdO8+ktcO1q0ZxRQ19K
	pAB6V+EtePusD1oJhhKSo/UPaCvAyJBWaFZEsdqzCS/admzB69Ll30upezKuY1C6E1CUpQ+XOv8
	Th45raN+T9ksCrFZGzZoeCNBtadb9QyIukkrh9KX5ggfnoovGONhdF0gn4U3UsdA=
X-Gm-Gg: AR+sD11lHUQofZXq1lHm0Ifix72qYlwGET2Jx/FvgfEzemEuJhtF8jRYjsXMKbulXsU
	9gVFa0KDARLpjQsQNFsVaY0j0cJerpGnRd35PpXK6pwqwYC6p0mKOvfiePMG+nnyseOTpZjw/lE
	mT7fLT8bHEjlvofc0Ag3r+bVfFC5xNg+ByHyCP5L+hra68q8aT9hU9jNJUYS0b8y/TGGQ5dTDrx
	bM/9+Zv5ZxX+jLeB3dnW2qrRzsAuwMnV3ju/s/M/cakwp2hg38O27B/xxbDNRLNR5Sxpm5kAnoe
	2EHCUfix9NTT13vsCUHP6kjLbiOU4Fstcr7Z6irXqE5y81JSMxV0RDZqeNNqi/pDCqsWcQdERfE
	W9QqYUCPiz9FDQyY8lffNuygUpUUMpbA=
X-Received: by 2002:a05:6214:400a:b0:8ee:cf22:88f1 with SMTP id 6a1803df08f44-908346cf802mr26871296d6.17.1785420522350;
        Thu, 30 Jul 2026 07:08:42 -0700 (PDT)
X-Received: by 2002:a05:6214:400a:b0:8ee:cf22:88f1 with SMTP id 6a1803df08f44-908346cf802mr26870576d6.17.1785420521647;
        Thu, 30 Jul 2026 07:08:41 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908325186b7sm18465826d6.43.2026.07.30.07.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:08:41 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ebiggers@kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v5 2/4] mmc: sdhci-msm: Reprogram crypto keys during host hardware initialization
Date: Thu, 30 Jul 2026 19:38:20 +0530
Message-Id: <20260730140822.1976635-3-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
References: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Or2Ie48j-uNxEkk8GVrcyKMUUGHoUiX1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNyBTYWx0ZWRfX6cow1pBFM9UW
 //3P/0g3+mqHNAr4OgPB/fVojBGyMA0CWYMBh9qw4EMLSX/DaXltl7QI4dsUvexyk/vezufqX3B
 SbvPBUpJzjSk344jJ+Uk9v9KByUDuRnOb0hVKh1IDmivL8pUitoHCM3vHE2egtTm9xwPcCT0z+X
 N0u83T3tJpLVdkDpibfx0rsXIT6Lqk19+6FoNb2JgVPHznUdGNnMV+mlXZCBF0H5IziGFRJW1JF
 hQD/ejAjj97v2o/N/x7v6PTtFNagRTzJ+Z4srcyKrEnVZPuavxa3Y0Zp0x4t5JD7IXrLTFS2k4B
 kszu8QF02Iea5MwoTIdNU30/nN2xh4EALZgrQgszkqhJBKcWqXU+4XF72cy1aFyjdvr84mSkc2+
 eEEmI9GUT943ZrgaaYOpKiDYSmmBvi85WAoyfB4p2kbCCfBKhoat4DERGmW44iL1I8fffbfdWfl
 o32RzMaRuKFD9jRdd4A==
X-Authority-Analysis: v=2.4 cv=cK7QdFeN c=1 sm=1 tr=0 ts=6a6b5aeb cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=INlCos_yAX0xULvCZXIA:9 a=iYH6xdkBrDN1Jqds4HTS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNyBTYWx0ZWRfX8WRLQBZ5Sfmt
 uvb1BMlN/ED5THZq4KBQkevTLGxPuyotR6KGnT0evlrJ7R0EcIhKQdsXrHlDM3SF6QqTztcGSB6
 WrAPEqBOlCIZ4NI7myOA3vzmoYImFIY=
X-Proofpoint-ORIG-GUID: Or2Ie48j-uNxEkk8GVrcyKMUUGHoUiX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300107

Host looses the Inline Crypto Engine (ICE) keys during hardware reset.
Re-program the keys while intializing ICE to ensure that ICE is available
in the same state as before the hardware reset.

Also set MMC_CAP2_CRYPTO_NO_REPROG to indicate that re-program of ICE keys
is not needed during MMC runtime suspend/resume.

Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 drivers/mmc/host/sdhci-msm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4aff965f0e2e..7d71dc6f388d 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1958,7 +1958,10 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 				cap.sdus_mask * 512;
 	}
 
+	blk_crypto_reprogram_all_keys(&mmc->crypto_profile);
+
 	mmc->caps2 |= MMC_CAP2_CRYPTO;
+	mmc->caps2 |= MMC_CAP2_CRYPTO_NO_REPROG;
 	return 0;
 }
 
-- 
2.34.1

