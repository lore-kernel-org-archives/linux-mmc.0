Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D2731DDB7
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004003; cv=none; b=DB1vTdTfZBgQmojy0+CUB939uOp2UkO5eiUiNiborFM0UY6zbvj8i3RemCaZZ+Dmwyq3D/eRR8VM2by+f2zMq7NIAtmWAeeR+bP1lt0O1AFO6ccMlvsULKsnmLG0teE5V9dUJfyVwaw9dC+A7Cr6QB9ZUf2/seZXx50LvzSfrFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004003; c=relaxed/simple;
	bh=Z17R4uxUgU+bBwcNXl4EOOFcTTKHC04Ru6ei0RAupaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7nnzjjxTkWnC3uMiCU5tsVBiPKorY+6AoG3XfSZaPKsNvuqYF0xvCZxowbZklgLLtsGHP1M/6jDOAjAdpHiygr/wAXgpcAKIl5EJ68IyiBoR9J5Xcvou2zVfcCBab21mKjijRPOAFAUfNRGm+iptlcqb39fuLBgHy+ZzGO0zvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cQykeKbh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cQykeKbh"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X90t007619
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 16:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ykjIJ/h7cv7PVigxcwlijPGxTqDBl4Xmlevg1Vg/7XY=; b=cQykeKbhoL0yn21P
	Y8X/m1b4TwbKZOf7eFDv/XelBpBXiwG7rnOpPr7ecnqd/c/OjGZ2spiz+Ort8Qm7
	3oOqcIPMP23f0RM7EB8F6cy9tnZtocGFKtuyZRJm9E38I7uo2QreUwLcmcwHNcio
	lRqFldMUnMj4J3LHHJyZ70GlVI5hRweA7WkUm8SBfSt/xoB1nNphYCVNZzdRCAFT
	890K9Q6FXcW07BmKd4cJMk56I9VLUKgC+cc+HlzB+kV0KhBA3l9ErhjcWovRLE8D
	WoYecHq5mMPuOLg4LPBhqUHZ1RrNKcNJGWzmGvRZtBvLxEIWxos80ui/4bx8Gz8e
	bvFZ8A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura90409-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 16:40:00 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso1365790b3a.2
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 09:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003999; x=1757608799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykjIJ/h7cv7PVigxcwlijPGxTqDBl4Xmlevg1Vg/7XY=;
        b=kQwwBEoiBbuLge8xFdi0zX3ggFLp+OtRr3yQvSJBBW7EpHxK2973amyfuBla+wqYzJ
         HPvGjKDVkR/kWUyzz6y9aAFi4yQej5rpi/ACMDwMeOEJo35rNAXHU4DLvuxMifmiaD8U
         TEi8KMJ63z8bLmFLZRouYAQYzJ/t7c+C2tpnjGOX4oejZiTqqHlT9Eco76ZGJ6lZ/j2f
         bl25+soo/R1Z4LXlpC0QmnkpFQa6t7AdtaDPNFUka0b5ervLEr02aKca5jzdkMRYtAyh
         4/2ob93Cj/F2opvIZhw3IMopQPhdKWeXFsX4w1t2AEEpPvXMVqRXi7LjX7zzhc/tGL7l
         xVKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWorQScWeXsbTEQYYP+Dv54JuH5VP1gQxTVkYkCVIjbtOhzp53gBqXpo9ijAvScUB5femlaHlJiLnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpFNapbV56Dbd7jHbJoVFPpaCAze/gunzLCla2B/G/ryoGVNz9
	U3Z39WtbJwHCkTe91QRXLjoQ1GxMwfKBFlTV3v99a/4yTEFhaQG2ol3aJb5m8nwWWp3WSYd7e4p
	MtkFQB7zNMPgfqPOhQCtqINB/I2T+to26lz8I9pBVqm7Z8xv9oYf3sokLz7FtXMI=
X-Gm-Gg: ASbGnctICpo+XcRbsZ02CIZ54YM3Kle0YUgL4fRVZy0j2bs+YV7tQIsIKQzq1dLtQdb
	MC30SAXmqperJIecnoXefLMORym+5cutqQY+vbjCk6jL0XkYuUI+pm2/K4uqg/xLBnjReOvRlUH
	trMuT7BIfVnTR6/LojGQMXuwceMg/qvKB/GK+rvWUkLi4BK//HKieHQ2VTm4lM1lXqYOGG6yP8O
	EGcOOsy6eiCQPdi0eFxmnL/0uRwGkSicqFqjh12sjz+0VYsZ0yoRC3hJ57LnTtiI3NsCzRfHgRM
	q0bmNWGs7nsn6DaCbTC7ZIW5Lx/JqCH9BYxuGAnOfc1LHAump/dd17nLB4ETIono7KDM
X-Received: by 2002:a05:6a20:38a0:b0:245:fbee:52e2 with SMTP id adf61e73a8af0-245fbee5703mr12170842637.36.1757003999309;
        Thu, 04 Sep 2025 09:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3yfPjFoXT4zW9IB0D+yJDheXIOMZ6xE5nc9ficLH7236+y8wL6rRb8AwET6KzJXDdeLk4+w==
X-Received: by 2002:a05:6a20:38a0:b0:245:fbee:52e2 with SMTP id adf61e73a8af0-245fbee5703mr12170806637.36.1757003998820;
        Thu, 04 Sep 2025 09:39:58 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:39:58 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:04 +0530
Subject: [PATCH v3 08/14] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-8-8bbaac1f25e8@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=1181;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=Z17R4uxUgU+bBwcNXl4EOOFcTTKHC04Ru6ei0RAupaI=;
 b=6wJJPLyeumdxPLCldgh1JOuob6GxTwr8kMoGGD6GLMkZW8vNN/3nshAnmnbA3DbR+4Ey8ngm9
 kyFXXI26djnAJbLFGIm4NztHyRSyViW35R1jwZLpy2wWw1zo5nKNT6O
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: GYBLytAhN-wnkzUacbDecoSWuUW6C_8c
X-Proofpoint-GUID: GYBLytAhN-wnkzUacbDecoSWuUW6C_8c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX3/BARKGPBSmP
 nc84YuC0F6H4x5sGA/acPy5x9g6BMngk9n6/Gxrf3dn/MMmSY7E3IAwDpcAL+FV1d5a/JMJZHA0
 O7Xl/NtpMPS/KoyvqJ632ceZ94KLxE+u7KVPggcGnen80RITjHLDr9hpdJHxnpEnPezivtjwDsQ
 akb0jpP4mNpUERLhifoUBwbyL7KpwGILQqE3dWQnPpwZze+3UFHr9hkYdh5817UXRSMfwECklGH
 bf1OS5gN2A/600bKXwItHHaEDfRVxbErmShyHaWimxSXUxSND4KJbbfqb61UIv/hfRsF5SBaBlA
 3Orh3nFSU9NlFNNN5Gjbm3ZqoeRybo/T1G/n/HY8Dixbg4AjBzWx5bg3aCCyVecRA1YKFZxwlrC
 lgZI8qAl
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b9c0e0 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=08pr6S3s0jzPFaFj3AwA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
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
index 17ba3ee99494..1ae3a2a0f6d9 100644
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

