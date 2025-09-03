Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4DF2FC005
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900077; cv=none; b=gESAj2YZGmZAh23InlHYjNDhhFl+YmXbH+qfG34EwHa7+7P+vFEzPXcPwjIdhW1JFrYyZ4rPja0Q7M7CyHS2c/Kc3PUoMnWGhK+5V0KNwXQ2Hcm0C1fXHcchdeUh9QcVp2ugyJ6dJttX1EPo4cJ+XPcey6bDxQNEfK63IanLewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900077; c=relaxed/simple;
	bh=0FeeJxABc5ZLBzftb3WOCcBqPi06istci6RlquBW6aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UfNYJWoNv6WRlsC65/CWD9xXpI4wB4U3nI+nXM6kvwJ1Wmcd+qHVfCbh9UogifsTlS5rGPnM2j9F8Q0jxS/t9/hVALMaIaLQ7Wn4X/UrjAMWDKFVMbfdaE5Pwnmh7k6zIFpDT+HE/POe5KDXXXif4yHOgQbCiUrGSZrin7gpOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EBhoNwGd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EBhoNwGd"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEteI004887
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 11:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+k/0Y2ctRXhmp0hMCcqdw5HbaI//nig8/AJI492yJs4=; b=EBhoNwGdeNEm/i5O
	XNohHffgz8ceHCtPsZCfFNdGqTZnBSxSE6Vi/5VZgWscHa2l1xWYQuZLJruzo0pG
	Z/ChWHny/hDXbsJ6AWbGVlxO13djEf97JuCE9scY6X8E87xspfInRBD+WpczTOgh
	d4FvtP22IyCNYNTUkB8NSvybHLVx7gWJqhTrIthN5c08ihkwhwuryr/UT+S7R7Ri
	1FJyFrMLp7VxOpK+oOs/HEVX38kE5AMj9udZPILCnYOU2oTJfpCL9nc9+F2PerbE
	3Q9wiZChasVYkZC99SIIk8G8zKzQHVtUC4tHoj0w+6xvLs+7wI5h9MnXMETSc8Qh
	KWEIYg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s3juq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 11:47:55 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3276af4de80so9095272a91.1
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 04:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900075; x=1757504875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+k/0Y2ctRXhmp0hMCcqdw5HbaI//nig8/AJI492yJs4=;
        b=M3Iw1fFop2KvMo4o/NeazQxubG2tE6M5xXj6DL8wl6BDwHJMBKnXES7/QIpx+z5Y8w
         5g5NaooW8HCqlOUOZBX9L35yOWoO/PXy7cPo4USRkhy8zGVq5kCagtC+wbRQmLgx+bUk
         kSXTHZ8QXLIbtvMVagBx6ea9CevTXEcpQKZk8/odvvQTls2r5UFfOEAKdD/lbj1Fueza
         na7gINKYIzqnih1JhVD5PZP5xORD+Df1fsYuMo9ldYsJX829oy7R9s9mH05Gq7xf3b+7
         4i6MlLEVArjvL+9y+GXH4WDZ9J7y4a7QkxYrkvJ8ZZjIp/DJL6eYTFVU+j+PxvK0okYc
         jvAA==
X-Forwarded-Encrypted: i=1; AJvYcCWIuIxVztpUqKFmIRJjx4qzzJXYliHat2KrK8gh7T5+xwodiZ37s9EGfm1nO4idFTx/YNZ4wyfr6LE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7GMxEpkfKuBcuamUpthvTZ7kYS6NYo3f4edJMpwv4ST+QM4LB
	bscmxCO22Qvnb2zazjkpriCacG1u2EPY2wX9NiBiKLz0Oy1sxBI57itI2lCQQPeqzHT4KTZCs3+
	jFaYYHPXXGx8oPH0HtwaqYybHHj3q5oZQRtdVKjCu0pdL7t6UEtV2g4LLWJlWBu6WWJ6ggMA=
X-Gm-Gg: ASbGncvlPCKsYk2ThtHP5uoPw66UouihgBI4B6/BFPgFvwOysb+Wr/Z/6v8UvqNNQMq
	ayABIPqP0+uPs7iPXrvNDekIWsrtJiWGWEgD4ens/UdfxXczczyEV+jFUbgSqE/dD7KwksZ9rUr
	ayod5kxruX8+2G4AQSG/9g13hPIHm50ZEkANQARGCTBcyZn32bESAjUIsezKmU46NqFnO0ZGZiq
	mQA2UNZLsgB+QyCpq7BIHpvCm4TFNNtrMVsGpqCniI6ZK+Rgdc4f/Sq7JqHjlXiNsIwPia694L9
	uTDp32ag6OGEI3Ld6T0wX7BIATdZQ1KUbz65RhGSzPxh8s0wj7dR3ckYgW8dyrBjzjm5
X-Received: by 2002:a17:90b:4f8d:b0:321:87fa:e1ec with SMTP id 98e67ed59e1d1-328156e3ceamr19078458a91.34.1756900074687;
        Wed, 03 Sep 2025 04:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQLTrOKyrlRq8CDwOnFSbZGxeNwIDBVtnsWGyS6oLgPo7rW4Aif07jO0gOfDmSKfPbR/ilJw==
X-Received: by 2002:a17:90b:4f8d:b0:321:87fa:e1ec with SMTP id 98e67ed59e1d1-328156e3ceamr19078422a91.34.1756900074188;
        Wed, 03 Sep 2025 04:47:54 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:47:53 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:05 +0530
Subject: [PATCH v2 04/13] arm64: dts: qcom: lemans-evk: Add nvmem-layout
 for EEPROM
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=958;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=QbgUycV7N8Z7tPsz0CF79+YmFBlWcv+ZbS3a6+NM+KA=;
 b=Gjfy7kML7lZT+3E8qTi21MI1Rf6+I/2U/vEhOXh/btmZHpL7mZGdxI3gE9mqrFW+GjZXeHt5g
 oiAdMlY6GNsAUEFK4+z805a1Asdm7ZvXmmjUaChXVYJkRrbaKVvPYRA
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX1qbL9bn+9sc4
 m8Ohus0TD+HNG7ZIdO+3H3iK1WxgtOCXU3dBG71qcVxrTHWcTzQIhKwGDAmgUzfJVpe2TZEf3uk
 v/ndJfZsPpExCtmXrBLuVnMaFkMVUCFDl6z/23fcStWwl4TpvbrWZyZL4cZV3zU5nfAxeAYlYAp
 Boj3Qgkkcz68ppF1dBAJVMvafIurF01d36Va7bQiUt7hytgpsGDcq1IEmjIMkh/SGNDAL+kWEni
 Tw9e5NgwgPpdWzD1zy2jmaPcdCbf2vLrFkpeDSks1d3iwxhRhxcCTgpalooHCwmqLbohla4zQHr
 Zzbp+uNozjSuLZjiWZ433DBIBWheCcHn1zle6OiHQr5JvTu3txAAkAGDSDht7mHw3adPCsmgfzx
 whDarQQd
X-Proofpoint-GUID: 6bBVMmtdsO5KblYLvI4yChFLH2pDD4JS
X-Proofpoint-ORIG-GUID: 6bBVMmtdsO5KblYLvI4yChFLH2pDD4JS
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b82aeb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=JPxAlOPENmrAts8ssvsA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

From: Monish Chunara <quic_mchunara@quicinc.com>

Define the nvmem layout on the EEPROM connected via I2C to enable
structured storage and access to board-specific configuration data,
such as MAC addresses for Ethernet.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 753c5afc3342..c60629c3369e 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -307,6 +307,18 @@ expander3: gpio@3b {
 		gpio-controller;
 		reg = <0x3b>;
 	};
+
+	eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
 };
 
 &mdss0 {

-- 
2.51.0

