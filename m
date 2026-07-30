Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13672443A9D
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427249; cv=none; b=sL4jQdlCp23f/3kxmunIbwDkzpNWMDM9uC+s4PGJS+cuIbNAN3K0Znq9OxYAXi1h+sh0xeamyQ4+Zha5qSWFFrQrc7e2la7rb1DgaUdyWaL+JVr9iWK4uBxohmEbBX/H+nJY5ndrJNj7ZeUwN9GMqSA1rB1PAUehp8M4hAXKO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427249; c=relaxed/simple;
	bh=rFLR77CJJYP1sKLFQ6gl8hLWfcBFJvASp2MjESWcdt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NIU0jaEEnxcVuapIGn9RcQyN9tgnE0ncYQyMbdXwsSDTKFMcFjeceAaEO6dLWJ3+jB4Yom3oRu4LzKp8kR95Feyk7dyUOOzt1xa50UgVdY1OXigi8tiLMSs3GwiWbXvt7yxQg8Zi5sFiu89e4LsQ6/0IIZU9Sq8rT/GkfOSwFk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dv93W4+k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hq5GYknx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dv93W4+k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hq5GYknx"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQjvS1414014
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 16:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=; b=dv93W4+kq74ezcsn
	PoGGxoSG5/baz/ImVuFoETwH6zagLZ5tCc+ntmZUwNhu9mrDn5l/aWdX+3RqR09k
	+qqDCr4MUFHFy2rPZp8wG4vW3hoQDx59OoBFCBpp69kYIrO8bHxv/0uRi1U5GXdv
	Ugw5LFDYcP/hHdAAxrIGONk2mCitPtV6mJXd0G5bL21EoMh6yhU+rkt+32uAL3GO
	Dx7bQgk3HLRrtq7QxCpVI8QG6nyEWp9k4X+OwJ5slZ3KmwCUAiAv1GCKNM0WAkR7
	cis9ttgsPcKrpB3KBWV4g004u3i7whUdRwaCue7TVmdnnOT+NKRa3xMNbpUtrbcO
	bY0fdg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr891gj97-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 16:00:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c12e43b98so24604311cf.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427246; x=1786032046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=;
        b=Hq5GYknxpa+8WbZbhELHY424WQqiH3+vUO7yuuKM3WLmFaiokAlCBEMxXaX/EQB2Ev
         u5WVd68noRRoYJqDEbZ2Ga4lJwJDbPQ+mDRRoBzHAiL07aHB9APbUTyboQmfUNhOL110
         B1C5cF5I4Bt0E2uquFgyxvj5y3nvJKU3Z9EMu48l2GunuPKeqDCjjuEtDNgirStQJ7Yf
         G5ArPKpQb4u+S8bmo6SQ/h81ZgpoZR9mN9XkjnzeMQs1Ji13CJan4q+xX8u7b/uXlBza
         W8SvN8SXio/4Un3nqo72OwrDZ49Pg22EBAbkCxjTQZQwGf6dvv37RzJ23xVOGL3OE28e
         K+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427246; x=1786032046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=;
        b=C5azCb/PdBZ6aBVt+ts741maKnwg8Zaps73EuVwjT9chC0mFyeidqfKjI+eLDe0D+R
         dqZcFGzRQ48+H8yk3wUJ8bmSGolSNr5sem4KxKqF6CQL0eEeVeal/j47FrdHkl5xEfjE
         qrykxMuA6tkfQITLNJzPOu768tHm4MPZ8xdIZ+q/4sr3EPbUhVwc9uIQXfWzng586csl
         WcFuLK/sLAa/qCWUlVj4z9SVN5pD0k9+jbKFn7PsWDLWrUNmLypLmUH8y6HiDk7UJ7lL
         hU7KQpkePq/Dlya3Iyiv2F3otXiXKtU9f/tFOSQJ3HbhFWomFLBI5SZS5ftlGnMPC85S
         iTwQ==
X-Gm-Message-State: AOJu0Ywh6ct/IrS3yALbkQeW1Gwf8yY+HzivfUhOioYQuduZ/dQbaAV0
	kkLUyXp5sxfjrZo5To1fmayyF4ZymCGUJHABf6PrXvS/pUzckpaGVX1D5/SfRNr+s4h7iV+1xuk
	s+8nlPHYJh98YPzGZjoTMfwqwenbaRqaEO3PbTeU2JBnFnVV6ZUYtRuBeulnm4Yw=
X-Gm-Gg: AR+sD13EMbTndlFqKGb4j6M3hgeiT5eFnEJ/x9+rkPYrU1Tt8RWOEKJFFds4PB9QjZd
	6Yh4OIUp5O2cjLitLEihaDgADQ/QSJu/T9bTXhnD624FB5qT3WuVs+g7PXA4jPEiWGQgNQQQIZA
	fnwWy8KIAHRMm0mJ4P9vxlzAtP0VSUe+WIghEm9my6eA9EfD/OcSmPIJZgsKig1KSXjrta+ntrM
	4Ab34ECWA5a4SBIMEZqChO4Bd2htY3D9CR1TrLjZpyNyjqgAPAp8EHx1k0+YHgRzbU1cztgblGL
	utsLHTEiEuL//RHe2VCFhei+XJhzcfaqSNwuCBMwOWAOzzyvME45W6gjpdXcAkGHJwJnwdstm99
	ESjKY+cbvRMQv4Wb8mHUgG1vx1skCzBr+djw9KHpAiXZgKDEsXwDzdfS2DnzsmRyK+u0EMgEqa3
	tSQr666Wt/nOKp/PUiFX6eFfYZntq4+n6VBZAdSE+dShmJowqtkrvI
X-Received: by 2002:a05:622a:511:b0:527:6d4a:192d with SMTP id d75a77b69052e-52b42cba100mr8220241cf.68.1785427245986;
        Thu, 30 Jul 2026 09:00:45 -0700 (PDT)
X-Received: by 2002:a05:622a:511:b0:527:6d4a:192d with SMTP id d75a77b69052e-52b42cba100mr8218291cf.68.1785427244656;
        Thu, 30 Jul 2026 09:00:44 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:43 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:32 +0200
Subject: [PATCH v9 02/10] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-2-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX/PM8JPJ1anIE
 nOdeHjPpPAGrIPTPnuz33DSn6NHmzKt06kXDUrYnnWz63klbrvIso7d3twVDrIPuDf7ehGvaatN
 rmkm9MANEZ6Cch3f6xjtJt2Kzr4L7JLXG401DaUCwufO/vEVezl9xSCr3tkXcNluNNBrzHFCGE9
 leyrQr1tx6V+ClkKdICKuq8Ld7r2ZX0A+YUroGS6NR2G4oUgH3wptGz5/acaXnWQ82XBm59qg93
 xrVdaI2jg+WsmUhr9QKM+Zf63Bd3ZvCtt5VorBiLda4W1zg3pKUoYn37vY3sJvyhOZ8aFwmyQHt
 Tx5yAuqyC3BxulcSmvUhCrgwhDFGcZslKLe3Zrxr/O4rHj6t+KET1w872OopgOCNrq3BKWUJUFl
 iqAxalMw6+lKEoKu0W92iZV2RyoP/1oHRwmR/e6qkFfnZZZy2wpynp8RZTNPbdknY/ShgP1fBYg
 XiWTQe6Wweg47A8wvTw==
X-Proofpoint-ORIG-GUID: hisqtNRUe2wME0srmReAgAQBo6tvAcin
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXy7bisbIbVzEW
 1pIicUh76G+3ffJ8QVL8tBjO4uRHKdpOVGp2wWbIal8eksUcKI2+lnnOUbtkEoZp4o2nAvTcarw
 YQiY0Cmts+7uZvJtIaMXqtuTXI38JOM=
X-Authority-Analysis: v=2.4 cv=PdzPQChd c=1 sm=1 tr=0 ts=6a6b752f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: hisqtNRUe2wME0srmReAgAQBo6tvAcin
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Since such data may also originate from chipset OTP or be supplied
via other device tree structures. All of these cells are optional
and can be provided independently, in any combination.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index d4f4d72ee0d388f43437fc5a3047f90b464a5274..7f9d16cb7c14330e11ce7d567d585b5e47793bd8 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description:
+      References to nvmem cells for MAC address and/or calibration data.
+      Supported cell names are mac-address, calibration, and pre-calibration.
+
+  nvmem-cell-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - mac-address
+        - calibration
+        - pre-calibration
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1

