Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126AE376492
	for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263702; cv=none; b=cDUbwnqUOXYIXMkJVdHHsdyJnSA83ZV+xWTcFnjZFc59gRqqbBISiQ9zcYoGOE7sBmy93Kd4urRCNgJApOZGsGqhRES6w13hzD8y0XIw6opif2dpOp4BdFSWxArGLGtQmBNMD/LcUAmqURlJ0dCJZjtnNQKAxTQJtxNhdeLAdQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263702; c=relaxed/simple;
	bh=aoh+innGstPtXL4+Bt+0lxHkcZ0ylk7ryHmbDhKW6Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CNWKyBmhUiqUJbufqUHqaF0ixg0RnrXZ7Km27iLGGH8StCg0dC+y4uUQmLiQnZ+hfM8U+7VRcb6uiMaqN4j5uJNSEvSMtqG5H606/OqW8UeWv8HD+eJT7NlqiKy2tup0bU/8EZLTl15pT/eYJ8UqT2ZN+M+Sj7yXZBrsvt/B7ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=biiKYnVZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IDDRBtKu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="biiKYnVZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IDDRBtKu"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K6dbkw1237885
	for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 07:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/fhMLuyQzIu5qdG02+whMf2PIVo3KhkuqRW
	4D1KGHH8=; b=biiKYnVZk8i+ZVw2cARiqxTdq+6DzrDKx35mnHxn/O5ZP8YHRfz
	zhApiY0WpmjZmA9lckSbbr75sh8ji191jVvAEf7wZRAxSSpnpWQLpsdLXmRHWtl0
	pIYruWR8lX5HMAR0oswxabvsD8s2cACFOGmzQUtEikKiDc73bBZxHIRKbY2jp5ET
	uEr/bYBpbYPdaPRYLta4XHNYB/jXB60knY2yu1HGCWBybiOkOMZIT/HXQzpf0/FA
	Li5V054hGbxAFU5ZHZVNKbdrcWuK2XP0jNl9B6AgwRPCdm7h9bKOFJiyat0XXQRQ
	w9ddcmNVFVgJzizBueAnj0pGNJq42iGzz+Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3surpf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 07:55:00 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-837c4eb3bdfso2945014b3a.2
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 00:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779263700; x=1779868500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/fhMLuyQzIu5qdG02+whMf2PIVo3KhkuqRW4D1KGHH8=;
        b=IDDRBtKu2MJHWfmCsyEcGPw7rWDoxLqsBk5Q2xVmBvwRUR/JoLjKRVub5fXBpT8uo2
         TQMQeWaOouxJQzYDAJcPcRPmF9xDsmCvYrps9Zc0Xdt0ebn6eQxHVIs3TLqh/C9e3YV6
         JpKg5zhKkp01M5JsuocNhbe1ZCipNuCPGEkD0wqRsMOKDj+TWCS7AfRIf5L9YouWOocb
         IhAKt780vPe2q1QfUt1M42qpN++w68CxtDj5wMgfC7pnbnH98xvqKzJY/N5GBX6zCm5e
         KpG3ya2+ukMPp/7fp+12zufFS6gU8/1TS1NhNyzuAUOaca2hjUS4xAPoSdaIUmYCUfaA
         QrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779263700; x=1779868500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fhMLuyQzIu5qdG02+whMf2PIVo3KhkuqRW4D1KGHH8=;
        b=ksITl8plg/dq2sbF2fQUMsX8NCr9N7Q06aptoyYVm44P2aZLkN6dO0g4UZl72L/5V6
         HibxKPEtBWKXQwxmtqtZ6ZI9q1TluxEAp1TCVJv1M1OpDxUwD8OH6bRHaO/OQHEBu6tM
         1PNQdStVdZG+C6rWRO0ou+Nm9RxkVPFnYNu2oGE3govcX7bDaScuzkQrf6i5E1hfJJYM
         YYukYF5t6hJ3A9pyc5TnMSM4E45TOw+2s2tEUlt2+yCp98p2paiQ5t4MmVCFhAM8lQtj
         WuZONA/sZVbbIfCTl5lEzP2EaTG8P76LpSaHhyu7Ia1+wlKGFaJ5xW/kwmQyx4pdEFaW
         2xuA==
X-Gm-Message-State: AOJu0YxLyQvfPZTHYmZQgglRBFD+nV+7fPS4NcfM/KJeSQbeROlRJdv2
	mXuwNZq7kMR9PJvpGQG7Ju1oteNWsZudUGdHd8dAooG+8ld0V+Iyxvnx03uvrewQu4+9qRku8em
	1RyAvhGSOsKWzg6yE9Agp3A9myD7hDME5RINKNAd5EIv1myiJUOP5XrXRXnaz2O8oS2bCuUY=
X-Gm-Gg: Acq92OFNrg6br6SVVcylbI0z/yyp1sT8tGiUoDz+Xp+j1I+rIhXBoUGPyOfdfMCJ4cj
	kdH221Eqwf4B4cpvMqFniiJ3jejre6m30Wcuz7P0Ce3z0rof3jagLP+xecniK2i6+fXm60/rRQj
	kI8SHyEbzuxdeo1uqPV7XvSUzv73tSkugqbOcMlW9Q7UxTgSCtSU/R0ppyf3JnJHZ/cAbbe/31V
	BAHNQONiBfXFNbFjBTt19Ux+B5duQcobTUYMFQ1Mw7r9G1UfYA8PPN9dKcuS53kno8MW0HEww9H
	hqoZUzb3778Om1+q8C5oksYa+T9fcTIaL8VHqo9utHnUWc7ZUWSs1bCfEjYD0MMQqtGSyvMmQ7P
	kHNNtY0v2Lah9oJ5+2jWV29DJRIPnh0DDu4yQLe5UAU982CAB
X-Received: by 2002:a05:6a00:3028:b0:837:8c8f:8f51 with SMTP id d2e1a72fcca58-83f33db3f0dmr23589486b3a.47.1779263699428;
        Wed, 20 May 2026 00:54:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:3028:b0:837:8c8f:8f51 with SMTP id d2e1a72fcca58-83f33db3f0dmr23589464b3a.47.1779263698940;
        Wed, 20 May 2026 00:54:58 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5b296sm18827998b3a.32.2026.05.20.00.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:54:58 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: mmc: sdhci-msm: qcom: Add Hawi compatible
Date: Wed, 20 May 2026 13:24:45 +0530
Message-ID: <20260520075445.2146152-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6Jjq6EHbM2Btna0nNzIoL0aQAS532KdD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA3NCBTYWx0ZWRfXx00p9XNHDSxZ
 tYEJQ86zLeiElg9xpm2akAaBXygLoEZ5++W0QyrBqfy+X2jWrQR5OfDI7ji06fNOIqtMcPrCpzD
 q0y0uP8DAvD+3SPOnI9z3bHBQg97HfiLlkclxBWEcWGl5cCbSp2WvUmNhf11ZaeQK8+Solren6J
 hnTjuO8zyhpUwRC4HTK5DUad3GujotWcZhBDspvsNFFLmu5c6841blJ7yPA7+ImfGzeC6xCZTLp
 Q2mNgA1ICGp/Mvf1XKzqHGbSNVR5whIUTnKgqv7UuPljQIPW5QeDkhcnNUdHprW5uh0Ruw2mQFV
 3zg6AZ1NcyJqbWfo8NeaMsOwXSqy67i0phrdQRQ+KilrHUJJ7c9Y2Qt7asKBboaR149660dufrx
 UbZsK5vnIzmTDddD4r316Kb1yhgnWnh7Knfz/6xR0njI2vNVy030SmPJS1MV8UQBZAmSTkbj2Tn
 Gh34J2BSILmQR7U49ag==
X-Proofpoint-ORIG-GUID: 6Jjq6EHbM2Btna0nNzIoL0aQAS532KdD
X-Authority-Analysis: v=2.4 cv=SNhykuvH c=1 sm=1 tr=0 ts=6a0d68d4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=2NBLM9u9rd1IYMrnCwYA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200074

From: Nitin Rawat <nitin.rawat@oss.qualcomm.com>

Document the compatible string for the SDHCI controller on the
Qualcomm Hawi platform.

Signed-off-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 695a95e8f35d..acbbbeb2be45 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -37,6 +37,7 @@ properties:
           - const: qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
       - items:
           - enum:
+              - qcom,hawi-sdhci
               - qcom,ipq5018-sdhci
               - qcom,ipq5210-sdhci
               - qcom,ipq5332-sdhci
-- 
2.53.0

