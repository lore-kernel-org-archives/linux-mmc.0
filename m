Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4313C9421
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222411; cv=none; b=dt9wg488bvnQF8dItQ8+3GJMC+Klr2UlNUJp8i2uRb0EGLn2WVWPVyWnBgjK76+tkgpXxjxIrZ5vED7yFOYbMV9WTKq4e1ADVDx0YA+coaD8HM/MeKmgkmrGbdsgjfAzGjrhO8/Sb6+q8rjgUz7AQzF0JoueGsIJY1BAXwaY7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222411; c=relaxed/simple;
	bh=xRVBcUcPQn/3XRwGa/LJ62R3q+1u7kG4HqctFlCN9Kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfKj2Ga9Zwmrn9i5zZtWM6sZDqLj4/JOAbapLCILNs8lQ5n8tQx+sp7zxwzfeyfHdLsHKqlbzZF2EldaNGJf21wi826B8ZCRdxLzgQX6Z3F7HAIWc/4W4NzfsKjk4sLp+BQl8G6DmMv51ttzpaZxnR2Qg2jgzbop3lAH940knI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=plq45vbu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dWlNVzX8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="plq45vbu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dWlNVzX8"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B7rGGD508387
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 09:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GAqPvw1+mNYrygeKcTD6WH5A0ur1DU2x0eDKSc/2zAc=; b=plq45vbuOeZdbTz2
	YBRBl4dde8USmvzjrV0gLoJ9v1z7Yu79CoT6b2Z595ySVwRpzVEn3hx7NL7JDijA
	v/iz3DF2TUus1h+dJPYDBvNJu3qvGWExYrgpaSLNEBaR+XGyZnkDge0V0lVbeAbI
	WoV39tWsTrmMvAEOqXrOykPZ/mcIbGKlSCT9flCiv6LyGsGOgjF9bOI1mLm1oFzH
	B/IM0UEwseJfJvXwUT40BDvg54Y8Vbmr/iLcxeSFz5HYRolVor7rPIAPUzhNx94H
	LeipY2dPqCPRNTxPEOi8OGhv/ZWKopidr/BfmTKKdcnBCyVow/asVBqkCBT1yJf5
	a3FASg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctppak7be-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 09:46:47 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82984468f85so3768119b3a.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773222406; x=1773827206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAqPvw1+mNYrygeKcTD6WH5A0ur1DU2x0eDKSc/2zAc=;
        b=dWlNVzX89bye9ldvn5tmCJDnz2HVD4yiKJrGsbc+HRzI/XJrKHfrc2IcVQwbsgcK+t
         Z0gDCHzDW6y4W1CJf8EopIkS1R6g/hYQvVcouDUjM6MQODmwcGUcQnKpPys91bCsLh6f
         glGDBI936Y7nP5BNsrN9YATTQB0HfMafmvvWPjf1bSTwokrD2DYaxKXFkUKIkFb2M1fQ
         5hITU/nVSydJcrc1Bm2/EKUeFpw4YpQw1GwSILIJDcvLhCWy096VcqUhdd3EHFrLKmxE
         XDTEStdllbJeHkGZckWhwHGC4OhrCdrih6SLAp5N0rQ80/9HRYk65YS9LPiasPGv1f3D
         9W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773222406; x=1773827206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GAqPvw1+mNYrygeKcTD6WH5A0ur1DU2x0eDKSc/2zAc=;
        b=NhKe+XAe6fvBXhizUhQOx77q3guIE5FzuAPkehwqIrCq9iHmetELfBruMGT5+MW+4U
         FeeIK3FCmO/09U8jJYwWfy1u2i1CeS32NzLXRaaEisWeI1zV9BPAi7v7L6XCZhBghm14
         wQg5Vqaa/jsyTS2lwsJhMc+f0GpWFAmegQ3CIEUQguQqdwiRkZjJUWokkKu7g97B2Lit
         +HtIU0Gw2DwzXePtuSgG5T6HQjmb3GZyquW8KhyAzhSpI4ebfdklpeX+3t/BuUtzLz0V
         J9MsYdQRvEPP2mQx32BvMBysz5BsfMIwxIVbQYIamTGn/i0sYY6zDJWnVV3d6MW2mC9P
         817Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLZCeRfOPZpIpyhMNPYcHH5jzQKXJeTOYZBJSQ7jYkDAheuuKU2vyW2cmtjiz7vUSYYFOEy2eBVqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/MrJT1fVYSPQ7C8eV8wTCwMpF//9YJGQxCf0rkpS4zQOpKjPX
	k4BhBHTyJ7TzsFAeaVWujGfOp3wkDFWNcGTsiI2cwUEGGzZjfWFuAUpWgHpoA7/8c14Hjx5VRMB
	Fcn9CP3MjMyN9M28juxlF+A5TiI/JksnGxKVt1UWQYa2Tu+8IVcMBBfmfH7P9ppY=
X-Gm-Gg: ATEYQzyrbR8Q378psy/cL6NJZxm6qyUhRhtlzUoKeTOIjo7a6u85HGzMeY7tZUU9V7p
	bwvt2Fgwaghols43m26G2WZKwL2X+SNvr9jyWBwh0WnQvT4vf9wTmoeazG/Z8Dr1w1k+NhNP8z2
	efE34RmzJQcGPlM01Em7q3kYDG/WJvwQWxCNDc2TnEclR5ESZUjcoyd/B/edEOyMhQiFjF4L4Xa
	YVzuKuRu1+FcYHoUx0KEjZ0g5Xcb6fMeNuMqkHS9tFDCbH0HyQdZc+95pVlhluC/ILadjsljMNu
	yBIE3YDbM9gH1sp/t7eO/biIuw/CrpBj9R+rBOh6k5OQfBm0ntp7FmlOASbTC/Ueyp8XZ4euFWV
	TpiaOSSABrIHpszVtDflxPENROjgOTg8ms39rGe8Bkevb5K7+4DV7PGQE/QCXWY3MKO7l20GfK2
	37SU+PbDyd0ERajGD+uMqlaCfh+awQ8gKGfGARJSkQTp5h/RftyDLirP7V
X-Received: by 2002:a05:6a00:1990:b0:829:800b:9d6 with SMTP id d2e1a72fcca58-829f7250204mr1685289b3a.57.1773222405951;
        Wed, 11 Mar 2026 02:46:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:1990:b0:829:800b:9d6 with SMTP id d2e1a72fcca58-829f7250204mr1685271b3a.57.1773222405481;
        Wed, 11 Mar 2026 02:46:45 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df5ff0sm1677403b3a.21.2026.03.11.02.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:46:45 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 15:15:51 +0530
Subject: [PATCH 9/9] arm64: defconfig: enable IPQ5210 RDP504 base configs
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-ipq5210_boot_to_shell-v1-9-fe857d68d698@oss.qualcomm.com>
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
In-Reply-To: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773222347; l=983;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=xRVBcUcPQn/3XRwGa/LJ62R3q+1u7kG4HqctFlCN9Kw=;
 b=46hwhX6Fzw1ORCbsBk9ce+pweRqE9HfyvYl9JYwhPPyKeDFkwXNmr5mWVbAg+j4pTHJbdVwTT
 qb1r79eB42vDxit17ARd9vUNhYfNk6Kyt+cNm8jnJO4pzFxJlBimfBB
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-GUID: 8qnMFOANnUJnrqBVZ_TrfOp_dmxyGYVY
X-Authority-Analysis: v=2.4 cv=D7BK6/Rj c=1 sm=1 tr=0 ts=69b13a07 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=rO3wVDe-YCVyVCuK1RsA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4MSBTYWx0ZWRfX9rWpqavitxD9
 OjudaOEN4qlzLKvLmfjXyudbH9+jFblYNvPs5vcuMiFABeGoP4SVzHZGm1QPEOs34/LLL+Fsve/
 KXQwZEuCiiTpR8yxHBFo87Y5At3SRHazE5ycTJVyeGxiy9BVoX4sMF0+ArdwcGWk8rwBrro7hOA
 uVAiLTuaw8bgRatuyq0JlRCOnoQpJnntEEPMA42gEimJ91/0/fGRFgKaSK70wNU7epXhL0PRQQi
 H1/A0dMMnr4yqRLBYQ0YA5FZ0Is/V1qC62ZuUsSe31dHylVa3VWo1b2TNKs4PeCk0Ty7NiL0xLS
 6TiUCOB/GOPX3UempOQi2ywqKmWDKl70b7ijg93X+ZYVy5RMQgMMmQjDk+gzRo+Yj91A4JPHUjo
 dIvFpqIjq2SvOyxDv5nm5+uu1JWZh0QVfrKYL0dvXe3upYhvcXtC4AFjYDeFaTeIlt/OIsObI0M
 V81XNGRlXLlyZcsaPIA==
X-Proofpoint-ORIG-GUID: 8qnMFOANnUJnrqBVZ_TrfOp_dmxyGYVY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110081

Enable GCC, Pinctrl for Qualcomm's IPQ5210 SoC which is required to boot
ipq5210-rdp504 board to a console shell.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4ed70ab7ee854038fa7a756d8b650a609258bdb3..59c748efc1ca8d6eb7dca19011d2a31d926a0d43 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -649,6 +649,7 @@ CONFIG_PINCTRL_IMX_SCMI=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_GLYMUR=y
 CONFIG_PINCTRL_IPQ5018=y
+CONFIG_PINCTRL_IPQ5210=y
 CONFIG_PINCTRL_IPQ5332=y
 CONFIG_PINCTRL_IPQ5424=y
 CONFIG_PINCTRL_IPQ8074=y
@@ -1476,6 +1477,7 @@ CONFIG_IPQ_APSS_6018=y
 CONFIG_IPQ_APSS_5018=y
 CONFIG_IPQ_CMN_PLL=m
 CONFIG_IPQ_GCC_5018=y
+CONFIG_IPQ_GCC_5210=y
 CONFIG_IPQ_GCC_5332=y
 CONFIG_IPQ_GCC_5424=y
 CONFIG_IPQ_GCC_6018=y

-- 
2.34.1

