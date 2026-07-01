Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E81849253B
	for <linux-mmc@vger.kernel.org>; Wed,  1 Jul 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921645; cv=none; b=e5+LeS4SD11wNfKBr86L/rEwv0puBDnBtL5erJsLDP79orRkI8Z7Eeg9goCMrNqzYGQM4OFgB7U82Q+l9BOSqTY43XOfJqEkiz22Y8h43IDGi64ejEpXnbX+hjwQsGIr6Pi2vlY+GJDvkkV9MLAoEP2F259bxrVt/vuChwefkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921645; c=relaxed/simple;
	bh=g/kZEO26OX4smC+wgpc8bkbcZi84SL0SycYp6R1V6Wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uOBLtYFPNZJNaIAiKl3aebMMjtwaGQFh8e6ddhY1a0EwDRkXfoZPDKm+APD3bjblLlt0vdmUZgONyhSDqPUqqkQ7w7NPkV4dP6H5HVywgc2rS0HOw3mjX72M/mB9/dUt4NslZ2ZkBjUhg5BDfeIcwBcFtTmbE29AQK/KZESIahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RYgaxU/5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZJvtjfFF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RYgaxU/5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZJvtjfFF"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoAXf1546126
	for <linux-mmc@vger.kernel.org>; Wed, 1 Jul 2026 16:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=; b=RYgaxU/5XUemkleJ
	+rGnL5+wvDRn3jX+6HhlJkaAfVY+AZvzcQXBWB4qc1A05Oz36348cY8xMTbV4J6n
	JLqnk+nD1Q34IFDibZp0WwG5205v1LtKlJtv/2Fk8XjVYR7e9Acw7hFPrSFGxPT8
	rjfGdLGJMMhP9QFUdk/CIxmQuESLSAwZhrETYVqDodpraqRtS12dzEEvLh00MwUG
	4nEj88OiIxNp4nt9yl0YqBzukogbPHUP9ZdfWnv2wzhc4wA5GsgwqtKGg5/0Ah6k
	SlnJUuDDe0qqPs5NziuQNYsdKov2JzdJLN+0gIrDakdbISMtCviZ233f9L39FB4Q
	I3KTCA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sqshjk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 16:00:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e695a3b28so251550785a.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921636; x=1783526436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=;
        b=ZJvtjfFFce9KbkQ9KHi8RxSpUhje27VdjU4yIhiNpmNv0BzGyQ24P+HloP4KbRpHCd
         rDvRZyFibrSzx6NXomDwBobTS1zA/4J4OFr4kM7MDrVTdi7VMdEhn1w0uLPFfnpAYdN9
         twcGVnh/VFUAHHSjGtYOXJVVZ6EuZTBJqQWbskzySHHO6Kj2Dexfgjzdz9EjnYIPXbpj
         3/NI2z/umA8Pn0TjNsje/HRYezEA2Y0jiB0En9lTVwr3/65oFpGp4eC4vOtUFY//nL67
         GgWSIAR2aQwQmH+UIMygyoOsVhxYVydceaJmCGTTAKAhWu46skE8bipjkZL6tAr4XP67
         KIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921636; x=1783526436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=;
        b=eECtOeiPUFjR31FGJUsdGW522SA6JJNNtms1MEL2aHSAdv9zAYbqT/5BEJy79SZsom
         SencpVg2bqmOKwyg5xNpRwT5iOtMr6ce52936XAv/jJ/foeli4liJX1UFKou4U35nHsu
         LurY23vpbA2FbPvoXOklqDoflZuutMiGJAhb87Xl5K5wNe7Mgi3QzaXLN7lA/p/761RW
         Vna/ZYQUew9d37XF8RtDnS0Qwx2uCHnCsldByAyH/55Xop//mg+RrMlcoC82Uz/HWLvW
         IKD0IRh7EwDq6oqx8zKgaZUz2USNqIHubHqajk5pA+QMKrZsjLkDNpwX78haX3XP02PE
         qX0w==
X-Gm-Message-State: AOJu0YxTIHwNtKOUnIwCLRbPBrmpYHtQu2OAtW7z96DzYpAPjjlqwVIK
	XdO4OsvWRdgSoAEDbBv2JuuO9D4jqQD7Lo1A/pvq4O+k5gPgYBaIejXjIrTdlTyZds7Eojq7pZs
	8kVYRXjbql1vVjQhY2YAANdhr3gNsEV22191nDbd5TWGlYaSJJR4Y1hewSibTdr0=
X-Gm-Gg: AfdE7clBzJPJ13+Tb6qV7x+1aM38c+9gGF39MIYRYFyf44cWHaO3aTB9n8MkAcOvNq6
	AC3tLvV7VuAjFkjdcePwjt9X8k5yaZklhCNIJC36hPpburekvQvhyyyQEDhT69JbXXbeqH0Xzpc
	e+LN1X5CSQF4ZHgmV80KiS2/Jagrko5DII5Q5hvY7oMt4uTpmTsTyGxNz0jMQoSKDh3Y5kGpabd
	d/1nSuKb0r4gCIMvjjuT+EFK38WoMDU2vCtQnXKTSaIDbeQRsR9UXFcdm7UUYmBjdYBgNx2xKBX
	gIzt6acuP1uRnXMQJRH2F2syc7xvMFyZCpPP49Qx+vJTkXsBloabAX2JKSmPHOx3IOn/25kHT71
	kR1dXcnU8f1Q8zJITFQ1ul/y/nHyh+gyfbnaDRjxiCJFam70YwQBEs6UQAyBUkHYKRpHUc6ESH4
	UflY+pCn/TK9DsItqUjW5ab9/rvK6aLmP0W3GLptWaTTDbemwiNyaguLOilNNOOx0=
X-Received: by 2002:a05:620a:4381:b0:915:29cd:306c with SMTP id af79cd13be357-92e696ad1f6mr886597385a.9.1782921635984;
        Wed, 01 Jul 2026 09:00:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4381:b0:915:29cd:306c with SMTP id af79cd13be357-92e696ad1f6mr886542085a.9.1782921633251;
        Wed, 01 Jul 2026 09:00:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:25 +0200
Subject: [PATCH v7 1/9] dt-bindings: mmc: Document fixed-layout NVMEM
 provider support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-1-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: kUITkcVH0m4by83ovk_ftwHM6PBAEaxO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX0VEfpNsnmNra
 tl5sFSWrPeth0noN+r7v4T3/9reXj9CY5r7JzX/FNHHlem8+Xp6czKRP/kCWExEEwgMNIOFB2rS
 CymwM9mCVqL8/OmIVB0rX+uFIMDai68=
X-Proofpoint-ORIG-GUID: kUITkcVH0m4by83ovk_ftwHM6PBAEaxO
X-Authority-Analysis: v=2.4 cv=ceHiaHDM c=1 sm=1 tr=0 ts=6a4539a4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX7V5dSjC4JeY6
 RJYi+3X1ioTtwVbwoZa9dGIBg0V3CYKHJq3K71LaLmI7OB752wgam8i6KG5cEb+ThU7cBhCvnVR
 lGcKKfeN7jqhnbHtqj8Z+XZ3xsm+8YyVrwzLy9USKvf5r0KSk9QCUBlT8qqVSwHzbffWK7oDqAm
 oOWiKGk4V69Ltu92KYB5l6Jzb5vE9Ph6/eaE2iu0eYFzyhrRx7lEcRCobPRfLcprGyy+bIjn+xL
 rN9Qu8cLyjXFXR8YEtgwmCLyeY8hBQabr3BikruZz4MrufSTr6Lq2ay+IebCuHByljJ3uG2DPfF
 sPd+JDd25tB2ZwmSQkDSXBcaGMFtXdXH6TkLUw7F9jezrHWby2jBkullGYESp7/9UJvFMeS9zBq
 oHdqy1b/AgBTjLxvuPnd74UvCBO5Jpsf2eaoqhXw1rAoA8yXx3nlXJLa+hMINjtfYx/jl8eHJq1
 ZJ0OzhTpXm/wBwIoARQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

Allow an eMMC hardware partition node to describe an NVMEM layout so the
partition can be exposed as an NVMEM provider. This lets a partition
(e.g. an eMMC boot partition) store device-specific information such as a
WiFi MAC address or a Bluetooth BD address and reference it through NVMEM
cells.

Accept "fixed-layout" as the partition node compatible, in addition to
"fixed-partitions", so the layout can be described directly on the
partition node.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..0422894508478c8d0ca68292b58a5fdbee218358 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -38,7 +38,9 @@ patternProperties:
     properties:
       compatible:
         contains:
-          const: fixed-partitions
+          enum:
+            - fixed-partitions
+            - fixed-layout
 
 required:
   - compatible
@@ -86,6 +88,25 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
+                compatible = "fixed-layout";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                mac-addr@4400 {
+                    compatible = "mac-base";
+                    reg = <0x4400 0x6>;
+                    #nvmem-cell-cells = <1>;
+                };
+
+                bd-addr@5400 {
+                    compatible = "mac-base";
+                    reg = <0x5400 0x6>;
+                    #nvmem-cell-cells = <1>;
+                };
+            };
         };
     };
 

-- 
2.34.1

