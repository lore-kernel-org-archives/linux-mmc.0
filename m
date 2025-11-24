Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69F20468E
	for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983162; cv=none; b=CFHvwN28vfPYhI+s3ezXA8Duv388J4dWrqM2E3rV6xU5LsT+ZEFbwKXeVffSYgEsdrwKAr063q7voH87tVNE7P2EqdZTC+5VQkGVAErRrfa3Xe3xbNNC5uL6za2h1DbqUOCuC+JR+c1E2EKD1SDBlRA41S9wF3JSuQqHK5CwwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983162; c=relaxed/simple;
	bh=A1OzAYdvgc9RjdmSke7QhThevoP5kSZuGzJW5TfJ8wM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g1WrSNAavJpq8DDwxToadqZZjEfvkY1HkOG0CwxUUGX9aeCpZHxb2Vms8YTFH9IyVaD0qbCyQeiHG6AJS4fUX/LigZqVxiVgxo0/hCneq0pNGV89pKOioH/WCI+olyXP2ykAWmktNeZjjzsiCyP69wC2fNIlbONBUrGFI7BPtsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PdrE/N+j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PjqFxbmO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PdrE/N+j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PjqFxbmO"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO8U9aJ2282482
	for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 11:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=PKUXTfAuA1RceafhmYaH5E6j9u3nCyXoSEU
	a0Yo4Bos=; b=PdrE/N+j1Ogbww5744r27n86fgvaqFg79pjlUU02XNdXHa2Vdx6
	Pp6iX819p+TLfLjQcpqX6+MK+5u4HBXPN6ZADYY6iEG5rM3x/LjrW4ehVAu4DXJu
	U4JnCMVQPekx46XKZ1CA8At544ISyUrvxCqJlS9LJBRiskEXRZLWURZgD/97cQh+
	J22B3sGZfy29QVrrvh+ztQpYUaIHFLDWSzWwYzykTOTrJCKPZK7ckAFbSzyNASQc
	50G4zxMAiZOQ5dhyTjSNw3pRB3ZQR6rFYLEZ7lWi+lbZtbntJS6hx+JTSCkIrmG0
	UUO+Ohp5FTgl05169G8IYYf1RFJGUuxnDJg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak68dvs1e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 11:19:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2956a694b47so63608545ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2025 03:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763983160; x=1764587960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PKUXTfAuA1RceafhmYaH5E6j9u3nCyXoSEUa0Yo4Bos=;
        b=PjqFxbmO6RYT1mWZzNOES4UhTqT1XygU2YfsU7SHSMPeAe+5wc4bllhjXdR2BVSWXf
         QH8lxUfZtNCR1e/2Zb+oIgVZwu6vRt3CEtygHOrEJorJRpMTeTg1xZAbFl/aeZF6BIwy
         o/kcj7dU5HNj4A5FIJIUjUHmZZb5zl6nom43/3JIAxSJ2SkksUI+HZGFHPHvFvnmXfkI
         kdhnLBggjEsjKy9DFcEPSj0skdnuIco84wceJ0KObVF0B1w6Iw5q3EyRFpv8re4zXt/0
         q4kKlLhmrXV/pG5Wo78VE8tnNVra9DimddAwgHrAyA2BuTRHluXv+mBLpe+aBxUxi9UG
         525A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763983160; x=1764587960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKUXTfAuA1RceafhmYaH5E6j9u3nCyXoSEUa0Yo4Bos=;
        b=vwuclnSAIoxohh96ynzjQWVobBfepMj2ONrEs401uowPoNoN+bXc4+1rxPske/tiBa
         j9lUkmtmmkXHU7ftH7HMruVq1D2dQOR+R9YknVRVLVVqL80mtJoICLV30irJ+KUnh3Ag
         Gi1RbmQrudfRGzZqDabchamE4rGnNb2ks+0FRzLtQY+bXMfiiM3Gukyw6VZbb/hOd3gO
         VSuD8v2CmfY2yhcXVl43nGSsg6prg+6jK20XQWdLJaqsRmEj2bf1EhXs03bTAB+loyJI
         7KLb9Tv746C5IH1J5ALy+sl2w5mxxsuwoZQI04igNF4XdAddHLQQFKHTzRXg8y1Bc/Qt
         ybSw==
X-Gm-Message-State: AOJu0YwOt06NrzNftufHsBRYNNotF22IKgdrDXYn2eTWCXcdtyUuOreZ
	V+tHSiNveimz1nPZd9CrSVAWQHtUfbAqJ9sr+w/jLz9PhEDRxKXQgLUnT8RCGtHi8JK1YT3nnH7
	s4g6BNllwqmkFuxPYz3dUTH9ncCqqXd095OJqnJFhrejsyu6/P2bW3g26nqCsVZE=
X-Gm-Gg: ASbGncuSWh7N0/zCJQGe8tWAUVC8RKFx0nirwmvAM4lcMWJF3R2T6T6guhh4prlGP4E
	F1iUn4WM9b+dzgZUPegcnwLbAJizMU7G29NKAI8OBy6r95cnOkTwFDuSMsA6QpwEZdo/tuZikOk
	8UaaW4fyboPQoHVR8zDbO13J5xVodWlOfS6XZoLLKwgAVlkQeGhbRt4sL2JcWuo14h1SaX6zMWw
	aj6084iGy5v0p8DIcGke2SKZlmSzQtICo0kRdq6PzWSlAPrbZEzNgxgmnYiJKlAaZShBc6y2ZKe
	zKCCpAIq+z5rW9k08XJLLVUUN6ItYtz6dn5WJOW2+gUoaKP6nbfyTkYUPhzjL2YwZ5tEXh1EtrC
	PZ3aBp4FFXUM1Luv8j/aku0LRx7ihmCKXkhis6SrM
X-Received: by 2002:a17:903:1746:b0:298:3a2f:2333 with SMTP id d9443c01a7336-29b6bf37ef0mr124716495ad.31.1763983160114;
        Mon, 24 Nov 2025 03:19:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS1SSMFGCqXJSIY5ZUv6ehozkXPjEbUv6YVzBln35SekyMx4VqIvEIr5Axt+7AuVfrf6C1EQ==
X-Received: by 2002:a17:903:1746:b0:298:3a2f:2333 with SMTP id d9443c01a7336-29b6bf37ef0mr124716215ad.31.1763983159627;
        Mon, 24 Nov 2025 03:19:19 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b15b851sm130313165ad.43.2025.11.24.03.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:19:19 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH 0/2] Enable Inline crypto engine for kodiak
Date: Mon, 24 Nov 2025 16:49:12 +0530
Message-Id: <20251124111914.3187803-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEwMCBTYWx0ZWRfX9TYpeORVKmGZ
 n24beuYggbORfCsyPaUmmFI879IwGTBB4Nc4/2uU4OUwYzrbA9J4qGFucXu8piY+y09VF6qnVRj
 FkBCoiL3FSpBEVmwkmGER17inNpYPRSLp44lHlI/j+ZxQmDQ+I/hvLlrUyvCyXOcvx4FxUuiut5
 i+ln1sY5J1R0idTPiORLCUqV8XNxXqZgkzvuA63Rbqr5x6UCSwFPuJK0FbxnZJt/Qe3zyz5ylHb
 2RjqHB41hFKcn8Vyob2DSr8EM78C31c5mD8MSr0nTtDveLZmCnE0U45cFlLGzRRj5y9sqkZTJWN
 GOuSOkHGnJcFEbw7xvoQml+NtqJL8BZ2apTpB3Mo+R+PWeVvob22BoE/ghceO3pSzwZbHYFlLce
 uPXBcJN85nPywv8fD6nuNSRmSGO8Eg==
X-Proofpoint-GUID: EsFjFm5Dox1tC-0n4I1h3h6KLK5LW1yI
X-Proofpoint-ORIG-GUID: EsFjFm5Dox1tC-0n4I1h3h6KLK5LW1yI
X-Authority-Analysis: v=2.4 cv=UsBu9uwB c=1 sm=1 tr=0 ts=69243f38 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8COUXyv7-X0OEXxtQ2MA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240100

Document Inline Crypto Engine (ICE) handle for SDHC and add its device-tree
node to enable it for kodiak.

Neeraj Soni (2):
  dt-bindings: mmc: sdhci-msm: Add ICE phandle
  arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC

 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 38 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/kodiak.dtsi          |  9 +++++
 2 files changed, 47 insertions(+)

-- 
2.34.1

