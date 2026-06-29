Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5143F927E
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723339; cv=none; b=VPqKUY0SXVFKlEEVQNHQjv87V73ddOoE+rwjCJHEZNsPQNVFy8ZHgmrcVyT8CNOUb1Fh0d2gSYMW5uM+Q6f2eXIuT1QbzGs0AC1mzTw/nYC3nFiBsOo3HDB2mC9AFiXy25Qnen3+/ZImPCxV5vIxRZfS01rqHAsKEq/SQ5Y8z+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723339; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eD+0dRqX+QUYVLjQx55kx85UL5Sd+JxLyn7ls29SXftmlQsA47hBMDCGClimgcZNIwR96NEa+c6UXbBXtqnvHc4eughJNTgHts0NRz2l4fAuQQhluh5izZal3yyR9oiamPc008S7w0NaJZuuYtyyxAQKu96AxtcB5yzd44sLLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F1Fcs9z1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AOBEQBjK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F1Fcs9z1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AOBEQBjK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8OC662348499
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=F1Fcs9z1Aw6XRZTs
	Um7fEWGgX5KMk8DW9SYSLWVtVnGWMJoda5P8TBu5fBZ3dVMgwzv6NR9VP+2jTMO9
	F9h+ZjaDO9PlssYceWEKHXRrKeR2KStUYV7d4vpowsopRKjKBUAzdLPtVtLtWLbY
	fDxJri626kkWHDHjJmKmv+ksfmW5/EqibfVeuYrF/4mLCNM4Ot4/R1kY5GmT0knZ
	E8//UYQO8q/RRHP/sc38FkSY62FIrSbjWcgouKPze7dsixwql/LsXLDVr0HdN0Fd
	qeQ/zpD0gUl6oTpQwEdeGYE4Ew8MW6Hsq1+kAIhSwnMR5g7MaLJRA0WXT+K+2U/K
	0tmChg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s04n9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:37 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5ab02fb3054so2539404e0c.0
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723336; x=1783328136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=AOBEQBjKIgTnXwJxyvX7rCT6xzjLuyp80J8/Vs3oqHsJBHrG2y0KRGA2YEtOpOS8vt
         JKrtwBT+mhW1wkE15eEQ+mAcCo1Q55vq/npwcu2Fr8qUMzkSvW4Uc1cTfVxbSwsc6pKV
         ceVvKjgUGZjr+k4I9USXnZ8GYs0G5NJioLGrvM4apFa+4lcwFDIzSFUf1oU0sANNeIaj
         DGDi63ucVzCqndpqirmAtu3S6tTrBFiOS/sGM+IHFz5IfWvoUty8zOuP0Qvam0MozNcY
         4o/o8ImtsDLLcyOijuP3I+TlQ2iRO+lG2AlTvA3x758nGQWkk3t4A+sAigeXxqU0HGEA
         5uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723336; x=1783328136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=aj/RCb3n/qTMrlMe8b3UtxTA7ssixbYsKvADRzZ8HbdtmfuicK7hpq/AG2s1o0T32G
         YtSV7HlZ2fCHoN50XxQiHsxXnwEDgMOzpUETjqwd2gsuFT1eRHK7UgyOH9gPDdBnBhJC
         FRs00H6rR2gBcrDG4tiN7bpoZEncAL52JLaSVlz3C/n+XUO9zfIB6HBhzIuRTTLR5FDE
         j3Fc/azeB/RotIdgiYZY3ogGnn++t160TWSekA69Pg0KL7xtVawGVuxVKrE0BkWPd7RC
         4DFu66ZJTsis4QMc0MDaYJkFFv8EOMS342AIUq++6lJpFUM6Ri/fox+K2nbrphaOOxCf
         7mtg==
X-Gm-Message-State: AOJu0Yws8ilClv794V51mmNphrkgw7yNEBLMt03Zl5PilVGYk+kDRKa9
	X3vQUXm1waYjB7XXkyzZCTaN6y1GJAKoKIcYK+20HTLQ72wB+NqTE2/jBAMuBh/RmbQycm5hDwp
	fWmnjVU5tURFVs6fmYrSkWAogw6zChtaAxdMfzTvd0UM9LkMlcjyi+Q73SQhmvyk=
X-Gm-Gg: AfdE7ckzSy4/SxQnz/F6Yk0nPjvylhZFdSy17q7emE79HQ3SxVtnVhPtI38DpIObacX
	h1U1P68nG/+KumF+xS20dG/f6lYoFZpGyiB6a79g4OgW6qgKbg8IS7l/VtlWM91M5pRbXlOp3as
	JP+Dcf47RP5RfDDIqlqbCj+biIkZdOR8ePwfPFyHvwmzpjMbwxGHHwv4xmkwm+48QAkuoTouGJX
	lkMyaceN+hSMx+cSalY4pUHqLB1R0uy/YNe0rzR+h2pw0brPsYTVQG6T18djyQUS4qAWbsNEXJt
	K/9Gg4Caadzned3w36YrpO1ROMcRcNgjBV5dAVYP5fH9wPYPn4gPLhrF6UzApAlrx6TzAvKw/Ll
	jcwMT7nMV4OD0X3kjgcyZUQeFtJP2b2Vvewu2UpFiB2h2lDfaXA5tmpgHjuMgKAu/qd3o1qV5Xa
	ynbO/h96YhVnx1WiSXyb9+wRa2w1TYm1GOGoz+zGwaJFqtVnOlQU/s9mo32+8nen6AKXYjq7Yi2
	A4d+2tFzNYpOF6oITwn
X-Received: by 2002:a05:6122:3123:b0:5a4:6680:64f0 with SMTP id 71dfb90a1353d-5bd69cc1bf6mr6342999e0c.4.1782723336537;
        Mon, 29 Jun 2026 01:55:36 -0700 (PDT)
X-Received: by 2002:a05:6122:3123:b0:5a4:6680:64f0 with SMTP id 71dfb90a1353d-5bd69cc1bf6mr6342973e0c.4.1782723336048;
        Mon, 29 Jun 2026 01:55:36 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:35 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:23 +0200
Subject: [PATCH v6 4/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-4-f02513dcd46d@oss.qualcomm.com>
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
In-Reply-To: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX2Ty9WtLInI8J
 bAE2bKQ87WdHCRQVEjt5ocFkeGFeGj3bTLJAM7SJtwrT8xEmqfy4bnGgoQlhKjXGX06Vo18ZRlQ
 bimbBhWRy92PLEHppu4wVI3dxkf4nkE=
X-Proofpoint-ORIG-GUID: VB3_DhATJMmzuO90LfKQSYwKXPobBGT8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfXw4MaNXXE9tVo
 dNix3OChFgRBI38uVaoK6bgcT+hsLN0zRfB4e1Z18PmrvM9DpSonT6j1TyPGHVt5HsGzWnspzUm
 1eP/AWFK8aVFTC/tOp0bUKuNuqgqo/O02wl6B/TqIAyww56OHxEFkCxm6lfVrLvK7qpRcp3GAEF
 v8TQVobfa8bkR18P+V0FMGkjo+hum9jPUTWDJadZNrAz5eZE8fnyRRequqq2s3KtQQoQJNX8hK2
 k7k8X0krtD4NdrnP4QT8mskpIa7KZgYHePNpOA8S/1ePjU6M31WdTTs/gt41CbhTaOciGMbpEKv
 ZK503EUNVy5ON/LmSUb2bW6DcET9KaK7+tw/BbbnQAfuUkMTApgORmW7o3+eYPG1+HkAtsLkUJE
 AuY01CF08wUepGd28NI2OSf66apwcJgtzsE/ZYyKNTFcPKgjF4Q4WC5QriGP5myyOTs67pMYBo4
 QhNSNSQKR/6pkJ/Epfg==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a423309 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: VB3_DhATJMmzuO90LfKQSYwKXPobBGT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290071

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,13 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1

