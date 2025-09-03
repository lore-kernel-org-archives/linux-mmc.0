Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834C2FF652
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900091; cv=none; b=tod+zcYZBE6du++9l8mH9mcc9fg0sciBIG1y2wqUF3awPnwWcUwTnX9vQXJv5I0EWmQ/1ShKJVZ3bs4PsYVi36dsUeREznKlLOtXZb/Ab27ZfrnqNNtHF/74duI3xo+bRxHUghz503DD36rqmNq6wLRcqQ/vIX45rlr5QudxDz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900091; c=relaxed/simple;
	bh=iL/XzmseyPpV8hK/O4kgQg+47B+ikK5yJ0SDgvgg8R4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E7RJGtq018qt/otA6HMjLU1+dg3Ry/urXFqmMRJINGN3Qco0WSrsC3hzB7cV8sUGswnJc65pvtxoyRbAXi+ox8jeAJOnWCqhSbqXHE0hB0W/ZUgdwOSIs+s2pqtLFFqp0+0PrhT6EIpUvZSDeOQS9duLGa707GcVPTMspx5DWso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JC/pRYKb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JC/pRYKb"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BFJFZ010436
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 11:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ptzMoe5mzU7pe9gfLF0XACcwJawnpCLYmxbK3KE0HEw=; b=JC/pRYKbK3k92BXV
	5ieyjJGR9qqYiy+gkh88U9g4nNfZu7a3VAN3jfwXRwRECPXGNv7ZBqbXM/rXtxni
	XJHx06jOf79N1jS6Bd3FeJzQQ6hv0wCgx0VkCFisoZUgtpM3Y1uP1rkJRLKrwqmv
	mS+k/a5MQp1pdznDFX0B6Nn7zoBWSSFyv5oOjDYEdJ9a9acvCu1DaI1iSVYRx1CH
	hjHlh0P382tqnb+7a+kSnrwq/87v5r5XWZBabzacV4sWe6BNrKU7Fek7l8KAq9Rs
	yhoLvW0VErBp3KYDBF0SBypIMvpTZTPn3nwzkUjBsDxZFNTWFoKLF4+JV+uqVv2k
	EJLm0w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8uend-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 11:48:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47174c8fd2so8308213a12.2
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 04:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900087; x=1757504887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptzMoe5mzU7pe9gfLF0XACcwJawnpCLYmxbK3KE0HEw=;
        b=sryrXYjiK2Zw1SYZEogO39ScvL2LokGw8g5rQ2H1eep93oIAuzNsAKqihLJKExjjc5
         rIarjaVK+WdeaJe8xGcmaQ06RMHvXRF1K7MDFfi7CX8QT6v5/d2Co6CMjyHrA7VPGgzD
         lEgZlII93UYeb/fOX73Y63kiMlt0YNxLSfXg0tIth9FybwV5JteqaY6EbQuteczCTnNs
         G/ZzOg+UaP6RtqXvih4tq8VJ0WPeIUaz68LJHq2CdzmPrqL9OBUlHv/dhbzI5qvRkT4s
         zNDLK6Nytaf1aUUEhJQJLPLDfr795GcnnqrmwQXeAANT7EFBAcAhtcZrXOhxdZPsHqRw
         X0kQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+yIwfUGW4Kda2t6e4ZmljjQsN64g2v/CzG47rmJoQDhFsgdjS2+FoYACNYJM1t5crULL9k2NVNro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1ExSV/jq1QIUmABHR6dkdiwK2DfFRxNorR9mP4/pxEpvJuWy
	ccfvzJufEpDggSAK2SUD23Kg0Y7r2UvySeReN6BwPhtjMeNTkj9Lj9DI9VZ1yLCgBEfYRcKgicA
	HVFxULIsqTMKbTpZvEiKZlHTUv2rVuE7mfXbt8vwduD5ah4aACudpcmnh7sdTj5mAfz6hPvo=
X-Gm-Gg: ASbGncv7uqc7S3I4Irt9/iEIy4QJFBRn2r6g/WEvEHjUgemj+Z26VV6N+7C0KcKHEhl
	2z1RAUserNzYkBipkuo73WfoKd4PeDo+W2PHUbMGQG0fISFz35eI/TvtKdsyZshOwRqIY/o4sLz
	zbVzfGCSEvD2cH133l2LaDsXBEWuBzm5uhuTvXun5YXoptLZ9dqOg53UV3nunWp3K729XIFyamf
	Yp/xXciMbA1dvxEpHyH5u2CCKAOzfK+4Hs3P4tFQ+PY1NDYceeQYEANQUBf3MR4aaouUYMeoNLA
	YaDih96wpwPOiZvahYDt44WnEagcmYGZskA3XXk66ENQdV+Kg1NkEmBUF0CsubQfV8bq
X-Received: by 2002:a05:6a20:2e1e:b0:245:fb85:ef69 with SMTP id adf61e73a8af0-245fb85f22fmr6898053637.40.1756900087304;
        Wed, 03 Sep 2025 04:48:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESmO9fuCQGZL0dDqdivH4Yd3OgnaOimF5E4/NDsZ5Ka2qIuzRAwLWEesSF7738knmXbVKR1Q==
X-Received: by 2002:a05:6a20:2e1e:b0:245:fb85:ef69 with SMTP id adf61e73a8af0-245fb85f22fmr6898025637.40.1756900086874;
        Wed, 03 Sep 2025 04:48:06 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:06 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:08 +0530
Subject: [PATCH v2 07/13] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-7-bfa381bf8ba2@oss.qualcomm.com>
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
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=1181;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=iL/XzmseyPpV8hK/O4kgQg+47B+ikK5yJ0SDgvgg8R4=;
 b=ehU7262fiOcOFmjWpHiqhp3CyfXbLbOyDWLLhlZwJMNZYrcsDHNXGKfhHqTPFDGcrJDmqUoZ6
 mp35mSc0QhTArkAIimiorimSB98rb2w81w6HnSuE0LJQC0RT8YEwLK3
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: oyMhul1jCwClJCJ4EdlQhr-T1zLPdZ5D
X-Proofpoint-GUID: oyMhul1jCwClJCJ4EdlQhr-T1zLPdZ5D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXziCaFPUZThHr
 kWdt39h7mb28HOZkD5WM/u24UHPrrxcNNfWeUEI3UI1G+y9k+tS0sZd+C5mzN3E7hTtXQuB2HfL
 yAp9rZmoB6dtAxuNPml1uSgzvQXVFKEdpvITt78Faih+c9qZn3/2qsmIjGJzdzHhp/3foY2jVby
 WBw+I1qk96i801dMCuRQrC3QaT4LGUnODtPyHlA2cdGSdwYliWnx8YYuGMJSuQ7kICvR8j0ZjYm
 PaznYQIcl4GIfx9s/S9e+GxLbLbGUK7o3AlqgIrT99cN3UCZNvWV+clhZVGK6EePA5spy8Y4wv5
 9a4l+4ZbQ+RZyUpewwiEUDAOr262fEiFUTn7gHOaY9Il+2aepYEr8Ca3SYhndcloD7FXcfeiaEY
 4Uk+cixo
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b82af8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=08pr6S3s0jzPFaFj3AwA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

Enable remoteproc subsystems for supported DSPs such as Audio DSP,
Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
firmware.

Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 7528fa1c661a..eb7682fa4057 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -425,6 +425,36 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/sa8775p/adsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp0 {
+	firmware-name = "qcom/sa8775p/cdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp1 {
+	firmware-name = "qcom/sa8775p/cdsp1.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp0 {
+	firmware-name = "qcom/sa8775p/gpdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp1 {
+	firmware-name = "qcom/sa8775p/gpdsp1.mbn";
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };

-- 
2.51.0

