Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835C2367A2
	for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761477515; cv=none; b=kWKX17lyOiRcVEq0iEJ6lH/HLiUxmWXaSx+p++DnXqOrJ7/qZ+IKQ8QyDeXKj/9g77ITLP6YQSAZt00Fn3CaQQh2thu87AVpz4CJmz9h6CzsCEelu48XXixRyMm4p/fCqpCyrHoQEw0ZIvkJfD2L7uil1o8F7CnTVgyOTAKQUfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761477515; c=relaxed/simple;
	bh=/5tkY59HXh8B8aDdyVmmItvuIc+g3lCV6AksjjSsun0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJKKnmLUJaJ7uuDjMELGHC9JQJbscB/eW31WMPikuSU64/4rIms3gVeffvmWPdGl8AvtcURebb3KyhhOIpsbqkQ1EFjYRUKTWKqbPtM2OUfJJourFrTeC7gjk4ok0Gjny7jtuI9Gd40tEaE+rW4I7E5naETaf4H4DvE14J3arI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iuFGb4wn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iuFGb4wn"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QAluYj3758310
	for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 11:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=orf99F9rIUd
	Vj3nTu8FkMX0cNvOcZ2dsYnrafF4Soko=; b=iuFGb4wnZRTxfqpFu4ioIOxnmfC
	EJ9UgF3cuqo/M3qL2v/CrxQ3PlrUWRhVTtu2Zan4fUfVprPX6jpaOvQUnQQD4wuN
	Ru+MCNNGiIfYSE4Thjmb7aeQyK+5m/0yNbP8dkMTftbJoRhlFRu8+scXO9aObiKI
	ENlK2okkRbqg5rk8F9qFYZ+SN1W/+SFP7xUsJKDUV0jlEhs2J8YgRCP4sWhrhlII
	kyGuiCvlVRlr/mhnbNa/rD5FW88+Z6+faphAa+B1Bu8EtZlMCtyQtpWhgodiO67M
	37g2smx4NIud51ZPme/qafh0mHeYsd3xXgu1LzTi34VeN2S+IcIajo3GKNg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0pmqhxka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 11:18:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33b52a16294so1229072a91.2
        for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 04:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761477511; x=1762082311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orf99F9rIUdVj3nTu8FkMX0cNvOcZ2dsYnrafF4Soko=;
        b=b8Hb0a3W2T6CuSq2k0K+ytS4McEAF7J2c92qSSFMRq/Ld2nCq4RZoDg+EKGsscm6Hc
         t8g6lk/BU3ubRQdco0hAUSfDIyXbbGib58TrLqHfKy9ZItosmBjo2L9N29LYIE9iCBCo
         PclqZs75UbRUPzwM3EKDwqMLNlr5YmceIw2NWpF5MrOVeOO6ncx0+8drLII38/IXW9n7
         iwgWlg6kpmI8KZ4t3oE4IBxkX6v0jD3W2OphShbKCN/N+4WPAP38YQe5e8VlryKslHCM
         K8vcTEsyOPmDPYWisBqI6u1mGUuWUiqWa2mBa5OpIPdhlg6sPNfvFitpgvoE0s3VC6S6
         5hwA==
X-Gm-Message-State: AOJu0Yxph+9FPf0CsSmdpo5KNvDg9SFLnQFms40SIw6sqejrWEFimlUQ
	pO/qq6Gc1noB25ZWfWGSIO+TisKV80a3TV8Q/6VrQyfxjmdp4BDtK13HntQsD8thqIje0/sC2y5
	FWhiVrd4KIi4PvOd08FHd4ra1HiRkK/nLldDY3MeyxQGGOXRybPLyRrA9ekAiWQ==
X-Gm-Gg: ASbGncscx/gK2MAVsPvRfAw8V0VUz853sDPAeHg/dYfg/WzE6pW78Aopo31A6EZ7bpa
	Bko7g4w1LM2n43PxgKn6RkzTZCTwmDZy5PYaMv9Jn0o6ZJB03pv3yMYzcvrLkviB2Pfqfc5aTCF
	35+GeI/G2B/oa232WOeLXyr1GNp0xuTqRNz+pAiGHH4Ij06bsZ+rDB+rEoWF+irM6bhg503eCwL
	ZsxyJsbU1GCDyqZBlBMT/1BQCbZxH9/wewqGpBwS1t1FPdd7DZEy+XBg58TGYSIwW9QRuGuPKC5
	YOu3H5wT7fpMv8d/H4KwKDWAeGsu8Bw6qB56/YonGXqBChupAJ5U6pU7WUcGdddYBjzkHYQdxF9
	6umNA2X4FT7DZQ4mElesfTQ5cjaZhtw==
X-Received: by 2002:a17:90b:1e07:b0:330:7fd8:9b05 with SMTP id 98e67ed59e1d1-33dfab84b06mr12871766a91.3.1761477511148;
        Sun, 26 Oct 2025 04:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0zlO8ZyzF/mK+UtlqGE2zq64/vgrPf3aWsH3pYbKg+KXxudz8b5pvQbKCX53QRCjaE86Ukg==
X-Received: by 2002:a17:90b:1e07:b0:330:7fd8:9b05 with SMTP id 98e67ed59e1d1-33dfab84b06mr12871745a91.3.1761477510670;
        Sun, 26 Oct 2025 04:18:30 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140301f7sm4707829b3a.19.2025.10.26.04.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 04:18:30 -0700 (PDT)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH V3 4/4] arm64: dts: qcom: sm8750-qrd: Add SDC2 node for sm8750 qrd board
Date: Sun, 26 Oct 2025 16:47:46 +0530
Message-Id: <20251026111746.3195861-5-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
References: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mP9uutXdK4HkPpkDdtYyLTf0ZCjC3dOd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI2MDEwNyBTYWx0ZWRfX5Q0nSaLwS1bx
 QWjq6cDG3xVKtAP90Ixs2hphK98lpdl4TL2E/U57t9R9r66SmwOWQCbWBw+N57NxT0trHOZnmk+
 CazPreff69lVI5RnMLh0XtfGPygw1VUOdvhyi/XGC64CJ2K+a+8IUe33ZeGA/9F0LvW5koY/8/N
 FPdoLv74Y9UwmB4kQMVo4sp2KK0JmlYIrU9Yz1Bl5gZmOxmeSbp7KNTQuaS8VvmuJnGkerXKamE
 KdD7aEhS/nU9hxn+E879KLDIw7oJcSceZkClmAPa3DC05onkF/so7uJFULJadIWyxomwVYKVsDe
 9/L63lDTvFM2s5Qn2M/N80kse7eojC0X1K2KoOPgHA0c32hJeBHix7vg5N5C3mD1QtrboMmgw82
 w1m02/WEpiENanRg1jfve3ASTqn+0g==
X-Authority-Analysis: v=2.4 cv=Vf76/Vp9 c=1 sm=1 tr=0 ts=68fe0388 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=Fl7qsps3WXD_dGGssnYA:9 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mP9uutXdK4HkPpkDdtYyLTf0ZCjC3dOd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-26_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510260107

Enable SD Card host controller for sm8750 qrd board.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 13c7b9664c89..c2ab39744a0c 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -1031,6 +1031,29 @@ wcd_default: wcd-reset-n-active-state {
 		bias-disable;
 		output-low;
 	};
+
+	sdc2_card_det_n: sd-card-det-n-state {
+		pins = "gpio55";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&sdhc_2 {
+	cd-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
+
+	vmmc-supply = <&vreg_l9b_2p9>;
+	vqmmc-supply = <&vreg_l8b_1p8>;
+
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
 };
 
 &uart7 {
-- 
2.34.1

