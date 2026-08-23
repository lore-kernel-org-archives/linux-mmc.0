Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45693AFCFE
	for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514485; cv=none; b=CQxmeEKsD6/fp+HOPnOw3NS5UafQvwkz7OXbZscgj2oasxUZIEN92MRX2/nwlNoDVLXT+JrU6/HbtxmPZGMSTFXQf2M94peb6nmUqSNJTnGu/WVsC0+WVF0ep1scHydZWNMwYgFsOvNnxVQGEHIhlHo53Bt7OlFYJzFDhfs66w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514485; c=relaxed/simple;
	bh=gWTcQ2XEzDFY0k81S5RiN8Z8bxM3mkFS9yIkZIw67Js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5TOR7B75io9mpS48iXCcvBocWyCZKD4T8sWXAffrMxdkUd3ILtJp1TJRDXY6Dl/zOLYN1sotkBIAtlAwIE6HTXDE9EquHvia/hYiDAqB5Ac6kf/y1Iz7MDWaAr65pZU8u4V2CXhH41rvtd6/rtyGlYRvN409lytYBiO0nSbAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eeVwaun9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FGhhgQhz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eeVwaun9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FGhhgQhz"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67NG6uUE3567875
	for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 19:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LKlVcGWgJkDfbVp+WF3KzIUdL8c8AJrsPsM7RduI1+4=; b=eeVwaun9MIrnVxtv
	ffuENyvCvT5XqyDyy2RK5I4ZHo9Vs7up6lFqVTNVLlMJCSCA+AqBNnFX/j1Lmqum
	Uo5G69F07Zw9R+0KqrUHcF533qhxnF7fWTGEsXLaFF67P/QS0Fs7G0DBEy2VB4me
	ITPufWFzPzVr74YjR4c62APsyFuJcIDI94pFZvOxFnlTgn9Gh7zFtnXOvFieW6dg
	5qOyatLqA+NbStBkGoi7xHzBJi1MI0S9VXMtK5SoqQy4v/7bjmnEJQAhHPjABVGg
	aJHBp8xE7Xk7IYkxR/IJmjcSZ36eElritqUiJkq7fUtFvcT58a5F2Sm4mxSdjElL
	ZJwpqg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g74xhc7g7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 19:47:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbbb9c9bfc3so1917953a12.1
        for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2026 12:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787514478; x=1788119278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LKlVcGWgJkDfbVp+WF3KzIUdL8c8AJrsPsM7RduI1+4=;
        b=FGhhgQhz3FilwCEe/v9LR8c069+xsD6uok1MGVO8hWzQ9buwhU8B20ufUAZXhd+zP2
         DqlrpisDwO+vOi4W+cBnuPtWRvjpdxuwnbyFsRdxkP2VY1ZTwt5kKpVgQCJifO2l5Jrs
         0SaGhCW2kYGL3AFEiE8BVT2RcL+DCnnzZrYlHnpGs5mxeU6jBbLyzQgfn8rfz62O0BmW
         W9z34xHkkxZRi/5VZ6Gbff3VAHgMucLdmkOISGB+2O2vTOrdHkyuuWUGRKo2H5oCYVt3
         pENACDpW6MpEyjEhmLGuwgkwMwKEOgKRUwUssCR2dDpaJTjZ/K9nd/W6U1MBDaqhTOY2
         TKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514478; x=1788119278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LKlVcGWgJkDfbVp+WF3KzIUdL8c8AJrsPsM7RduI1+4=;
        b=T5F6nrMwkfuC9kogk2llsVjMiwkahKsWwC9SJFGBrst3adqcax5CQuY7sZpEXCTuLi
         lW2MUGpArGd5V3tOSwMCpgVPUJt5byirJgQJzaeMSLrIYIsOcLGUUw+oA9Ekt8D2rQso
         Cp3xukrGx1l9cQzupT+HFgmU0eLrbFREMJ9evBVZpKKoldWIQqvMPLQ73QNTTaAvR1Sr
         OduKpgzUVCg8WsSk39tg0I0mmSIR5+FIWWzvK13MUk1YcTY0gu53rGc8VmIoEpOXtl7g
         Cll9P17arCvKdafENFYPoVArOFqg9hxR136NSpZLvzzpUdvhV6AwVOIfsX4YsryizHKb
         YY+Q==
X-Forwarded-Encrypted: i=1; AHgh+Rol/LNXDtBA+Y0Jiqa8TXaTZdCoVGbTXHDLWJnuli5nDr3dUXgQQ0wLyjbo3eiX64+Dya9FLir/zEs=@vger.kernel.org
X-Gm-Message-State: AFuF++lrmsKr8sWsn2V0YNI99sKJferIRIWv9RZdeAwersaSOWDhJXDK
	IdyBVpGCfo9fDfxs+Qa/nY8elbwbmMP78NobNCDt5PoJE8rVH7ZV2rJSG/h/byPhQUR3XkKxkgC
	mg8i3To4xBe60MRkUDa51Dg04iyKfVQQl2oZ1IHzi+UMWTnPiUMx4bfV/dmmel0M=
X-Gm-Gg: AR+sD10Rq5INg39qgnwlCfX/pICATGjRnyQCfUnp9VT22uHIvfdt9zEsurrgPZR7d1/
	gHG6KRVvUccZaRZadYS/FnFUUOSsq2leaQuWSGx5Lkx7lykxTvS9Pb4FuvOW2FflL0SiEDIVaug
	rJXNROYC+g/fq0xsU/AVt90dPqxhACuYBvDgDbiGscRGDrrv27rLiQjbRIf4stKb/ALvmHD5Yud
	3xxYjgJXwi24P8SvL2ka241/JKwpPynvuqsERkym3ph+vgnwjOf84iL1kA878pkQa6FAsZSIz2n
	BOhKNHG+l4kiJRg8moOoVhVw/q4mGBJPiHuQw9tf/JZTf6B2/kuPBV3ttj10T5MwA62VlXpOngT
	wWJiPkxb0nowj8rj31Vive3gL2ydDE//7xZKzWw==
X-Received: by 2002:a05:6a21:710f:b0:3cb:d156:d362 with SMTP id adf61e73a8af0-3cd2fdae771mr40720130637.3.1787514478386;
        Sun, 23 Aug 2026 12:47:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:710f:b0:3cb:d156:d362 with SMTP id adf61e73a8af0-3cd2fdae771mr40720074637.3.1787514477928;
        Sun, 23 Aug 2026 12:47:57 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f925190fsm32321623eec.31.2026.08.23.12.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:47:57 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 01:17:39 +0530
Subject: [PATCH v12 2/6] ufs: host: Add ICE clock scaling during UFS clock
 changes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-enable-ice-clock-scaling-v12-2-09271f583dc6@oss.qualcomm.com>
References: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
In-Reply-To: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: AgVcJ4d6d9xrUbIMdD1GMcA-32WCY_9_
X-Authority-Analysis: v=2.4 cv=GdQnWwXL c=1 sm=1 tr=0 ts=6a8b4e6f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yPCof4ZbAAAA:8 a=4vEl8bdWBwuQafGpEzkA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDE4MSBTYWx0ZWRfXx5K4pIiEwtfs
 gge0aPUq7JaEXP9IkyUb1R2hE2FapsipqfF1KPu25tRQaZIokN4YaelI31uEmA74mYzpvd047U8
 clKYF/jGbYbvFr0jjpPu/4drNgTTmGurYn0ZATm7mwLD3kbL8ZlXV8MuiykQgnCvLbntAV2ZoBm
 ojYFRPO3Vz+5NcmsLpLBX/rVOgR021zGh6Giz3cNCpZ6HHlPWCXrO4n3tyA7WN9Mnyb5i40YqzU
 /FGweCiUAOVy32ZuGtLlpGwMa4EhXc90XgylKiKtWl8U7HAIQDgv6y8/CgJ8tWwekN96MC5cZ9u
 lCgnP7MJiIEABhAlndGxEwnTGxUcyR5HtAV8/vcIuNWubWlAUjm3SdtLlk4iQLaLXEzF4ubS4aJ
 eo/kIDcru61daZZqvynAOpehCZg/LV4hGLUIHh46RHbaTYDOMxXtJ7mMlirntwJKTvUnXIBbOlv
 QWc8r8+t5cguzEB2I6Q==
X-Proofpoint-GUID: AgVcJ4d6d9xrUbIMdD1GMcA-32WCY_9_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDE4MSBTYWx0ZWRfX9mzLj7YYxjOf
 Y68TyRl3GAcPmxhy2X30t2ijR8hRB3L6qkdva4Ez0umlBu6bLC9m99DVcDxAggOndIN70rSEUSi
 7W5FmYmoB9KVvdabVXb4R1QgQf4mjiM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608230181

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
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
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

