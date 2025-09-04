Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AE2D46AF
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003969; cv=none; b=YPjPATXGbXixQSXQxzK6F/jYCa1NkFXM3HgjORaeMF73R7gJBfNzzzTQ8OkesSDEc8TNpZKEMmynBSah9ExCjW2KWgGD1unNePBEXqyYAwiaoVMpZHMiw+ovsiIzQ2l1ET/hNjFw7owjzN0nPrxSvCSwxDi7/DMEnJFdr+umH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003969; c=relaxed/simple;
	bh=3BT/6suhK8eSmSdIpvmvry+itcjPvXCIyXUxFeuJLYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MT7UAqHxkXyhYgFs/WrrYhY5jHB6DRXTG2BQpQlI3tFPpAnPF7QSp5ojOsDOTbjZVSxk4SlgxQL8bGA7jC9yCT+M/zR01W2O+Hu5J0AQtBjn3XvZlKSFZmBMTQWHmQf5GryXsLFjHKTgmKa8keI+076eJkFOyGGbMA2htf579ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UKd0cMjd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UKd0cMjd"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X7uc003715
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 16:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2CWTa+iMUq/YNjoKRpUPGDy30w7e4E4JjtRdeNVcgm4=; b=UKd0cMjd164/BbZ8
	HNbEVGUdupqCPi+kgq9f5KQ3243KNWrjqAGcZMgH7U7xlTxalBoMek7zG2Wps/8j
	FYZK2LW5PTU6saOXPwYg0Nqfh37cHYr7ya0tFReFTx563LWIN5vu1CWBTKFgho75
	YKEcLWaRPYRNrarwX4Lj5UXKHeRDKUkznQ4C7I8wrOybvQidVUGSkU36Aj3LhQZC
	i0MMlqKmsv8cHxBRMPzoRlDAsOJskmUYH7llehYV6cWW/K9A4yweZmxPIvGsHEWI
	UVVKzDavkZ2uXuh+GQqauG/Mp66oTDal/yXABXWDIC7YsE9yjuX4/Tdjb8YFinNk
	gp4fxQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s88fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 16:39:26 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32bbacf651cso149463a91.0
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 09:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003966; x=1757608766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CWTa+iMUq/YNjoKRpUPGDy30w7e4E4JjtRdeNVcgm4=;
        b=pBNzow1FT56wthbkceC5guLddQDbO4hg4xXY1SPEBYhkC52dvwDK38XKrBPTv5LyUO
         iyDlYUE+PlpVDm3GoUVIxG74ZHMkIiuaEeyBaRidNCqwaFF2cWYBv9sEwGdcAaHgDk9i
         VuIboMIjTSCD3Em8Qn+u+2/Fgok8LR4bOcqlC7lc5o9q1lprpTmAPDhJW6TC0o4TwE2E
         Ep1RuHEIEpl5sZX70OXnFXyc6DSvYP/MvggfzJktuanf4Uc+YnLaBrkDVVvoWiI7rr+2
         lfOZaJQQkZxPFP0PSo/saBs+qkEzWq+/+x5Cp0GpMsEiNQDQGfhFwt8RPidURFNJKjHL
         0drg==
X-Forwarded-Encrypted: i=1; AJvYcCVw08KStjST7rvkkhyZ9N4JiUj9VIhzb/Gjvpo35LxLvhiirDq2i9hB1PbMPV1ilU7B59rkKB47GMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1u0qdPTM9ozPFmHFLnxoonncvgBchbITIJ94ViJEKW69ekBEt
	8XPBumTyl0W5P/EMosybW4S/ir0m2xb0IRLDQyb9hEFZ8ZoL7u99gRRUaM/kM7Oqra1q1T186su
	PuyFmI6AQP1Gunr/F9U3miwyiuvZOkoo93ayJso9cZkd+irVJbT0LD+mvgvJDJuU=
X-Gm-Gg: ASbGnctj+unxBJOKCjt/28a/zvpYk+OtX67OVVL3EmLVxRto7ZrSJ5kPhnbpyNRhg++
	7aHH1rlK+kRtK4X2vQP0eqvfMeZ2sAkT75y6gVxkRYKMz2ct3KALY6C24NTdNFZkWtB9s0broiy
	ooUs9W54c+oxdclgs1FxauaPP100rPh2feAkji0qlSjsbeLxEICzP0AzcillgSV3Ec5Cn6pqCwE
	1mSAcftijRi+ZnUAnoa7q3iIUcE/y3sNo3qfctxXcW6F+dA6gSk52+PsMAphxixc//9LlqucLXQ
	ECTqAbcyvtlyRJ/W6c1yeHjRZpea/MObjdvxbpZ57TqBH939r9hcWli1wD8Ukpp0+ZJ4
X-Received: by 2002:a17:90b:2d8d:b0:32b:baaa:2a93 with SMTP id 98e67ed59e1d1-32bbcb945e0mr293529a91.2.1757003965995;
        Thu, 04 Sep 2025 09:39:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDysS+g0JZmVZmToh9tFIcpTJv8ha6RIvIwKxET4j1oDI7WQvl3Edcqg5NJKS5BBiqkUPp4w==
X-Received: by 2002:a17:90b:2d8d:b0:32b:baaa:2a93 with SMTP id 98e67ed59e1d1-32bbcb945e0mr293495a91.2.1757003965494;
        Thu, 04 Sep 2025 09:39:25 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:39:24 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:08:57 +0530
Subject: [PATCH v3 01/14] dt-bindings: mmc: sdhci-msm: Document the Lemans
 compatible
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-1-8bbaac1f25e8@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=1190;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=z9TI86piqLkEr60N8aHlg5lL/hJiHyO8LgOhxGhTRpk=;
 b=0/sdwS0aEk7K/4iQNj2K6mKUxiyzvbZtRvG2f1VMV2jqu9zimljBsho2c4cnPjvLldMuPOcCn
 oEvvjp4y5DfDAvsR59uCDcgwrwr22Cuau1UH1lvAcXiJstwFS893Dct
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX7vO3Cvqgsd9J
 EKYQWvk/74748wEx1YAw4HRGza07+RFAlUndI1KFQsJWSxQwe9A+9V1rxKcXL5lPWSiHBvCZ1U6
 qdIFJKpwuc+Rf9qzPxP3OKz8pt1wwW5C2CzwOHmARs2Ave+uKH1bBz1aGnaSPbKLX36VEpc1Pfo
 S2tLpLHS18XjTr9cpS1kXXECaPVmu0GsM/LVDpQlclqmCwYT4F010prtwtXoV2i6PjDS26+f5k5
 aBePgFYWh6Ex89Zny631f2/BOD4J2Ood9TQfdx9A/Cu4y+8nOEJcO+pC3idgFaQYYB8BxxCsWo0
 28ns67S6tWWCzVkowf//w/lkpmUQARZdYNjbUhk5Ixbfds3GCq/OM4O3w252s9VJZO9DuLxjM21
 +iWA87MP
X-Proofpoint-GUID: 1PyCmR5TpVYz9r111Rf5BmPi-wEpJcRj
X-Proofpoint-ORIG-GUID: 1PyCmR5TpVYz9r111Rf5BmPi-wEpJcRj
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b9c0bf cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=oyqPBBxx3V5-Y59TF94A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

From: Monish Chunara <quic_mchunara@quicinc.com>

Add the MSM SDHCI compatible name to support both eMMC and SD card for
Lemans, which uses 'sa8775p' as the fallback SoC. Ensure the new
compatible string matches existing Lemans-compatible formats without
introducing a new naming convention.

The SDHCI controller on Lemans is based on MSM SDHCI v5 IP. Hence,
document the compatible with "qcom,sdhci-msm-v5" as the fallback.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 22d1f50c3fd1..594bd174ff21 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -48,6 +48,7 @@ properties:
               - qcom,qcs615-sdhci
               - qcom,qcs8300-sdhci
               - qcom,qdu1000-sdhci
+              - qcom,sa8775p-sdhci
               - qcom,sar2130p-sdhci
               - qcom,sc7180-sdhci
               - qcom,sc7280-sdhci

-- 
2.51.0

