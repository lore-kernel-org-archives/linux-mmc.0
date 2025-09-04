Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EFF321F3B
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004008; cv=none; b=OcMKHAU44rq3rHrVSKiLJffAhqPukkrzvO894sMFl44HoMNMCdDxgwM9v0GBw76qTka0AYp5mt8FrwG9qQu06bmafh5bRiWRx8a+PBY2vKRyLfs8ZQVpxMD+xqoOBGVllxc6ucpx2Py9IKHvA1Mzsv7qDe4Cm4dAwy9oyxWzqGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004008; c=relaxed/simple;
	bh=27FWMqFCDTUwpqfJlNc8jFyWyreHhp7HJeUXTzNfhgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mtvy3jHMWvkB7hentYS3GYV11KNGIBk7Q6PM3qOkTEB0GIGTvetVq+3Kd75K5F2K+j/Oafb9PMzMbFS19qpCfvaZ2bcayQ67bdMEUslg4DOuPePSCcvkk/vgY8Xn2hZvoE9B5olFj9vNruF768w6Qv10tmtFkiMGGI3SComxnOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CjiH6mer; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CjiH6mer"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X9Cs013622
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 16:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PBnsv8jIHnwgITCzKC089k9TiBqBMjIPeobN0jq972I=; b=CjiH6merx45R7pQw
	E/yXR046uZfUs/pwpo2Tc5v+ssI3QmcYcpwnz7YXR7mhmGKf++mpfXAJAn+/7rxf
	TcRogn7XQZAbpfd3868VtqvPU/Hb4nhk3h8Njt5SUMLjlKpuDC1nwbVsDokj4wYp
	LmAHXkYRzZAoVEylirfVRY+KZFJUrexiBmMJ9O+zXjwRlnKC95791W00q+tB4CBY
	OK+VdmEjRuTmI5VDZ14eEmYwyn1fFz6ppbUUhK7zeonJnPomYRnHykJE4JgAsjoI
	hAhUyXM2/5BK0fm7FjjlzZSBFvsb/xiAKu74cDRHgwSX2c4/hUbYfgxwfifJqny1
	KsfccA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wyc4kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 16:40:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329ee69e7f1so1057255a91.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 09:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004004; x=1757608804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBnsv8jIHnwgITCzKC089k9TiBqBMjIPeobN0jq972I=;
        b=sNJjYPQlEjkD2IqFeScMsEpfWVzXK9Q94GdLvX0F+6fn8QMwkRrM4aDVraJ+/4ad1u
         zUTV7GW4ez8W+Rz1VVMMaNBKCM51q2r/2Y91wb7eqv3BBX/OU9rJB/1BscToaFSObD1D
         OtO1t2MZsPMmXpDp4K+glmcZylvscbZpS7wdwvaPnQKGuvxKf9F3ozvgWvjH8w7Dv5lx
         8bC2zYHLjiAApVl41R4dHFMfjmy0bWYg0uq5ffDTCW7MPsfgPECbbye46msU9slSwQ1o
         fwIQIpAZpLCll04oEoo4VD3PHPHW3yWtjZu7OFGrqeIplA427yUtUUCWbNqElsMmzG1f
         pboA==
X-Forwarded-Encrypted: i=1; AJvYcCWXTuZS+ZHPlktt+Wn0cWmFy8gvVcqV5MeYNxAWZJbxfVLRx8WUk5++3/C9qnG1HOyddamVUyKSwbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztxQ3CDSoSskyebsKEym2AYbp/bb/jLEoFDWKwABdNDaUf3by9
	av5nIm1PC0F6IZFz/6HM0p6TBYzQBqoJuQCrG0DN7QGFl2v3tHwddXbGhBsL8hB8lezHuYqGFnx
	5YJGfK7AJIPKJL0wLf6GB1q1n974qSITqLw5SXTzasmBjCne7o7+X3ESQUuj83Bw=
X-Gm-Gg: ASbGncvruUai9ZQk0cIkzNzi5InG3Iou81CwI6FdlOrW2ONQjxi8OTuXlmDJBzEp4nP
	wmGLkPNZ22RraN5rkCrFl2ONvYotnc7j0cDT8msaIoCmQD8h7wIjZjo6rY8asEBHgR9rsxiacr7
	KzEgFtdE3+1hp9G/hOuMVtobIjzdpMtMbgWT672IUWAhJbfmpDxq1UBDe6+TnD8Ua5nXqIUif+D
	eF/ztJzaIvMLPrDVZR7k0jdfwXBiD59AdqOhR8cmPCrX0obfCVk78i9JildrsMRLEC1Qqb7buhZ
	dWCGiYoKp077IiOETUVocHuXHFvmN3h20QR2XlHL6YZ8T8tosmnVoyyOMD9abWVoH6Fx
X-Received: by 2002:a17:90b:2790:b0:327:8c05:f89a with SMTP id 98e67ed59e1d1-32815412e9bmr26511491a91.4.1757004004373;
        Thu, 04 Sep 2025 09:40:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETLbiF5LomcDMPddyH+6eJjA8N15yzTu1sZbM/gaEcwfgyKS7gkdIZOV07jqV2Iqp5IGsQEw==
X-Received: by 2002:a17:90b:2790:b0:327:8c05:f89a with SMTP id 98e67ed59e1d1-32815412e9bmr26511431a91.4.1757004003710;
        Thu, 04 Sep 2025 09:40:03 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:40:03 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:05 +0530
Subject: [PATCH v3 09/14] arm64: dts: qcom: lemans-evk: Enable Iris video
 codec support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-9-8bbaac1f25e8@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Vikash Garodia <quic_vgarodia@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=865;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=LoxKYvMXT6w2D33TxA4UNVzhnQ1bXXJVAz3sDICoZRg=;
 b=cn9950aoCKHCLBDJ0YQwZZ3VOYSNkIexa6YkQadyz2LdSJ6QJLVSeQY/Et3Cb+sit9kRExVnW
 ja4vkVqHBA6AP1YylmP9vi7DIKXoFyrKl97WqVPitioS8TxvugA4hap
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b9c0e5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=9guL5b7EFFMc6jyTlUkA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: P332h908RHyna2U9iCEYKvK24aS18Uyp
X-Proofpoint-ORIG-GUID: P332h908RHyna2U9iCEYKvK24aS18Uyp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX8NDTZl1n4yHQ
 453/O+BARxMfZzVV3NOL3JrTzoo4xaSJSrTXcE7hQnAh1ncUXhz8xwCN1VNQdB6h42gJZugl/KD
 x/DC2u047XqiS4yX/3qKIBYycSNg+5DXrlTMPvyCpv28d3SReglnQtEhGbc2cvFM2Y5ZNThValc
 HjPoX3EYSua9KdAPRhtaXuSdGXQCCM6cjvPW6fZgPO2DRzk+QJqQ6zxuaw/3Y4UzlD2V07t+RDR
 ITH4A9qw7G+Rq8kfXZTFlRG2jOUROlUnIZZffMRmp7PGRDx9aVWOah4Bq6e2EPQBU5LeJPBzSxW
 NzSbt6wrGx3N1pCa6hanGtFxA2jjmJndpX9Vl7/3iuhAk4iti72fYEE0ZGTH7kFzs0ZrOiLteEk
 MJ3REmhs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

From: Vikash Garodia <quic_vgarodia@quicinc.com>

Enable the Iris video codec accelerator on the Lemans EVK board
and reference the appropriate firmware required for its operation.
This allows hardware-accelerated video encoding and decoding using
the Iris codec engine.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 1ae3a2a0f6d9..d065528404c0 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -333,6 +333,12 @@ nvmem-layout {
 	};
 };
 
+&iris {
+	firmware-name = "qcom/vpu/vpu30_p4_s6_16mb.mbn";
+
+	status = "okay";
+};
+
 &mdss0 {
 	status = "okay";
 };

-- 
2.51.0

