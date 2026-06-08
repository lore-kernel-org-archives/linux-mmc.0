Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015783AFD01
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955323; cv=none; b=Ewq4uKNGAmdTYSYCFY2BsvhxLhd/CWvitxYUcL4v7YhFUKYKfzo7hA8vZ30VNioqA8PF+qHN8MwXO5CIgt+ogCnkIGuAcC9aLjamCcLuF3obzO2SqJusdnnSxFTMthEqTBF+uUPsy19Eiuhb96rKbIhbC6q7dZ6Sb5m53rRIeUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955323; c=relaxed/simple;
	bh=V18lkZ+mYtRW45RZQcZ5zGi4H7dZflBvwdwCuHqEMXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVPdPfxpLgZHBoMBQqjr4Qeu3dz2nbeA7l1FYdIqmQzf+ol8GfxWDybXLiVKprDaRJZ0Yx8fsGMVTC8kSOzBotAyngYR5HJc7XgodPrelC3NoE+QYIhkbnm/vfXhLsfWx3cScqS7q3HA8oA7JYuJKKplnYM6bzJyM8sty+JJFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BJVK7Dj2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FxUiFifv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BJVK7Dj2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FxUiFifv"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658Ix979348816
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 21:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A2btTWcfqlMf79K2ygn2F3WwB6X9SQ/bHFDltKt8bfE=; b=BJVK7Dj20XAZt07t
	qwaKXPK9Tit4+EKS3XvP2r/ubOYWVXrqwZl4Nfon26q3SBcFu3xlskWpP8Qi9yjV
	qCXlHqujpmlXJ6ORrTgpKa338GfwZAyLivf9BrORfjpiY7p9R+cVjsR7I5hdAvS/
	wUu24W/xmS6MyzFAHUelqTbCuyyfFJH7g3mgc4N5jEcockwjHgjCLPooTRoZnoPv
	zb+kxGl/HsPBShKHFxv6qp1NY5FQcjOCO37HgviploNW8pfdo7r1hvSOYBcxIeig
	Vs1gpemk3ojyuJb64fZV074QmC1apzpCao4hlZk9BGTyhNg7MkbIWxPKLLnL0l6N
	kWcRMQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enwsvajr9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 21:48:41 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8423f24dcedso5923396b3a.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780955320; x=1781560120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2btTWcfqlMf79K2ygn2F3WwB6X9SQ/bHFDltKt8bfE=;
        b=FxUiFifvAyuyytvCJyRAoMEn8z0Rw7QgsGngpkzLEd8tGC/zQlolX5e6gh1WF4VVQ4
         rzm/ksGYXHudO5E8xKtYi4pjHK+1UBmSaI2EWJztpZZ9KNvkQIHsgsmoQWDve7RBuVJ6
         WJNz8RDWGbiOwk4A6lt53u3RpJD2/VmMevnTwKLqnfU1IWRHxkcK0+wxW7T/kVsbyT2e
         wkztYNZcF2nbDHGXnaSAlun/DR2tnFv27ztVVieq7gMwM9y1Dg+WgZUPl4GaFGCgkQ8t
         UaWh6Vk/I7yIEpwnJ/KWLn8SfXtcYMTJb79Z+J75HmiJjl+LLVUr9ctzzFSkEACbNm59
         ZooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955320; x=1781560120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A2btTWcfqlMf79K2ygn2F3WwB6X9SQ/bHFDltKt8bfE=;
        b=cWcLQemb93dVkvoTm0iwm1vrhCYByUm+hkkmr5lq+TLSMLy3HL+LZ17LQa/qEgdLEm
         WS54RoMOC8esECpt/1DMH3FoLwbSA1v+O5pFDfTQjVzrRTppei65l3Kqz/kYdWC7oRP8
         laejpPzD9OoIrZPTNkWSUHUM2OTp13TE8tztm1VfKlayN/mjntkfQwcptOR6ZKXO6UZ9
         JWKePFuzwLg4Sjh0pNOtvp3RTLrtseJ37EsOYUIlTMPatVoBUjAtoxIjWmb6EEZbQjlh
         89McCbRWqs6T1JTXg53fBB+yIJmH9P9A3L/eCh4nhwm4Tm5az++kfAR9hBOUCInm03dg
         7fdw==
X-Forwarded-Encrypted: i=1; AFNElJ9iFKAeNKoQHx+WcAWluDZ9i7PiJpnRxgRWdeqZ4s3jCHxKFM/ATXGFssB+Dvgqau0yQaWbGo64Toc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJaupt1ifnA7LBXwBExudRCRWXsyXuZLsHvVjcvkH/+Z8+aNG/
	XWPj4i1HdIef1l0Mezrk9QTaFx6WNF0Qs8tDffUfr3YblqMmO6NtBbNXqIJUaokteeYkjVIPUsU
	bbtU6/dng23BYks3pCGkreFFNXTjD5KsDD3MFnuxCdZDLOb4S71I83Yv3LUCXulQ=
X-Gm-Gg: Acq92OHiZYZbbp2IMO9ZafTVOCGddtlN1sZmPgc3e3NBjuZnF81h9QKboAohN2Kup3W
	MrzBOhwvW5znHdL3rC0RlrHp9GKB787EvcPhxDVj2vNMt8fZIRv0pAqjyd65QFSnnMiMnGtxtlZ
	nV51UWdoHhRQNiLYtmVqjjYFWBoxh0jGiQqcU13lRXQLxX9u6CVp8grt9bC1HnecLYSzMwL0A8e
	Tk8r+jue9aeDiJXBeOtKPJ9z2ocbwLfCAxnJRxj+licbxzse1SwADhfOu2DFpO7L9z6Ec+2b4aT
	eadupuc3g+sef0HCgcdyw/L0rzrV9xi+qCgm3lSoiyQnvixq79DnRPYd+MLLAkne/aIXQgkDnLt
	oVW9dsgkOnmgGgg2EeXSHNZH0QTjJDQQqQlCSd/g66Z5odOCM5fpqL9RPGHe8ytuTxSrzKA==
X-Received: by 2002:a05:6a00:10c4:b0:842:4982:81c with SMTP id d2e1a72fcca58-842b0d5d2e7mr16779878b3a.20.1780955320061;
        Mon, 08 Jun 2026 14:48:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:10c4:b0:842:4982:81c with SMTP id d2e1a72fcca58-842b0d5d2e7mr16779847b3a.20.1780955319634;
        Mon, 08 Jun 2026 14:48:39 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828cf783sm19607485b3a.40.2026.06.08.14.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:48:39 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 03:17:24 +0530
Subject: [PATCH v11 2/6] ufs: host: Add ICE clock scaling during UFS clock
 changes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-enable-ice-clock-scaling-v11-2-1cebc8b3275b@oss.qualcomm.com>
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
In-Reply-To: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: e6dFQYo2bUMrDeindWiSrLI0gTxEY8aS
X-Proofpoint-ORIG-GUID: e6dFQYo2bUMrDeindWiSrLI0gTxEY8aS
X-Authority-Analysis: v=2.4 cv=dIaWXuZb c=1 sm=1 tr=0 ts=6a2738b9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4vEl8bdWBwuQafGpEzkA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE5OSBTYWx0ZWRfX4pcU7LrKAuMR
 nuIcuA6QPwjmk4Gd+jDOAHvL3qUXbalkRCzINhYmS0fXGitGU6+r7YwW00ErPnz9sXV+Cx7KD7W
 /z9EHXx95/dl8ASnqaPQ8uvP93Ys4Qr3RFNxivBSX8SNrFQh9ZPKZsiEmU0ZrdBVzK5zpBO7Hks
 vSWRlh1phicdZ8Y4lcSQQrJ0xyQgnV01he3NCWPjCYtUqe3rzkpNnBzD/1BrTSinI2fC23FnxZL
 BEjWwIbl/HLIKo2dqFcZA/IJulMdOjG8j+63ibQWOEGbbQfirEOEbPWw6T1uGpnUWLig9j7T4RU
 me0m8yX0fAenyaQKBgLzIhf8qVLcEl1uduUZ7BJy0+5CLioCcpwRv/reVQLeYOqxlSe4CNK+Yzu
 17CaVjjeF7zvwulJGnPgi1/zPJwJOPSkxG3TO2L8vhF2lqW+tySMmYDIVEPZZGIdyoR3Rq/k/Z6
 Onzdr0lMYZfGEa9Uwpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080199

Implement ICE (Inline Crypto Engine) clock scaling in sync with
UFS controller clock scaling. This ensures that the ICE operates at
an appropriate frequency when the UFS clocks are scaled up or down,
improving performance and maintaining stability for crypto operations.

For scale_up operation ensure to pass ~round_ceil (round_floor)
and vice-versa for scale_down operations.

In case of OPP scaling is not supported by ICE, ensure to not prevent
devfreq for UFS, as ICE OPP-table is optional.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 drivers/ufs/host/ufs-qcom.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 291c4344876481461ab958f3048db5405bbead62..dc15d7806c7b677d6890cd4b077cae4f4d5c9a41 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -306,6 +306,15 @@ static int ufs_qcom_ice_prepare_key(struct blk_crypto_profile *profile,
 	return qcom_ice_prepare_key(host->ice, lt_key, lt_key_size, eph_key);
 }
 
+static int ufs_qcom_ice_scale_clk(struct ufs_qcom_host *host, unsigned long target_freq,
+				  bool round_ceil)
+{
+	if (host->hba->caps & UFSHCD_CAP_CRYPTO)
+		return qcom_ice_scale_clk(host->ice, target_freq, round_ceil);
+
+	return 0;
+}
+
 static const struct blk_crypto_ll_ops ufs_qcom_crypto_ops = {
 	.keyslot_program	= ufs_qcom_ice_keyslot_program,
 	.keyslot_evict		= ufs_qcom_ice_keyslot_evict,
@@ -340,6 +349,12 @@ static void ufs_qcom_config_ice_allocator(struct ufs_qcom_host *host)
 {
 }
 
+static int ufs_qcom_ice_scale_clk(struct ufs_qcom_host *host, unsigned long target_freq,
+				  bool round_ceil)
+{
+	return 0;
+}
+
 #endif
 
 static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
@@ -1946,6 +1961,12 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba, bool scale_up,
 			return err;
 		}
 
+		err = ufs_qcom_ice_scale_clk(host, target_freq, !scale_up);
+		if (err && err != -EOPNOTSUPP) {
+			ufshcd_uic_hibern8_exit(hba);
+			return err;
+		}
+
 		ufs_qcom_icc_update_bw(host);
 		ufshcd_uic_hibern8_exit(hba);
 	}

-- 
2.34.1

