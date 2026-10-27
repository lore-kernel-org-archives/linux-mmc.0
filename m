Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112067;
	b=W0STAZJGjv+qMfiTz1NByGi9ifYc9T8sKVvBZf2hM5wm8wBoGBi9FB3EqPaz7ZMi7oL6
	 JmZwCwYkPIcSX49rZr3VgTJXcKbAULwMMSj6lijniZvG9tEeff+f09DXBXYPR0jKOjpcf
	 G4xF2jHHILJS2wVn3c9/OAC3bZ2dg1CXL0l3R+05dgInaaxz8JCUu/E75+Jl8OsrzhKfS
	 qU1YtDZb67adyWoEcjPYbijGZXdYhLiTb8BuKZTzrAgHcAenl0CnZP6zCIq1WhP7EY9+g
	 n4g/S555iu5+2Tt38GhFaOW441QN2NLPw8j9ajzI3wQ5IbUKDPm1HDCcjLGBBNdr3Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112067;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tJ+CL/5XQ31zB1tm/a6298VKrPjYPjRATx64g2n2nTk=;
	b=pAPk2hrLs8OVwZliodT3GzeShIf1kRUvhZEBpZLc4gZJk/jzvrJn8hjQ0PiOBJvffm3T
	 Y9t5gDxbjfhe/nAHvP3/aoyT10vK40iC3d9v3GK4mZY2uOeEMwhSbMYmuDL+LQP8JvdZr
	 RUWp8iCmhw4Krd4abUwwbx+nKbxPmxqmA4VzftUoSQRxEPZUXpBhH3LrhbA4J6bVIM7GC
	 2zjSWBWwxPDb045fGem2DY0Amn7juAQ9kKFEIkSqTFz3f8Xd1/bOSQ6/q31IXPxyM562e
	 bLb1dDR31Kt4iJ7x6nx8NP7T6y4iU0ec5tC78lmy2BWdVDfSWQai4cOuLyWvoimVsEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZQ0U9vEk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AS3+P9LS;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDEF60A2615
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FDEF60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZQ0U9vEk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AS3+P9LS
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoLVm858496
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tJ+CL/5XQ31
	zB1tm/a6298VKrPjYPjRATx64g2n2nTk=; b=ZQ0U9vEk14c7EmZYSr11cqlADsK
	D+wsHP1D7lrAejlMV4UVVHVXN1Oyenpv13BN6aan5MHS0v+4DdZJ0tUtfcwyFzaJ
	9KZgozSntZqiORHdogvHQn+cJX6ef0zD8Z3KBgY9MCosBJrX1Jebzs0Aurq89JV0
	nYYyQKf8w/yghXAZ9V6LQ0RgdhnKXAnIkZQN9vt0u+o+J6COHMwGFDVLnVcYQVKa
	qyI/o8OXIA2R+6AoEj6I9BONZTvkChPugBdVQGGRb4W+o3pEqyZMjEOse805Qs6Q
	knW/81J6lrqdNX5vdG14939kXEkRs4GdVbPvwybxa8PdnRumZd7AC9XElOg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54mbcu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f26dd2165so1169059985a.3
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 07:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793112065; x=1793716865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJ+CL/5XQ31zB1tm/a6298VKrPjYPjRATx64g2n2nTk=;
        b=AS3+P9LSI5sC3BxITxLic6pg+tWnh94nMtnrppXd4aALuQyXPFL7kw4zgpQKy/jO2p
         s3EUnhX+Vgj+vgGmW5rbEAQtYNI5qj2h+ncgk+64Xniqzz3RBFxsVFKm/Tr0T/N2n3hF
         wooDVX5DMyAyv2a88IsEHmvRaG0Ozle3wBRgPILxrvZH71HhKL42Vt8bGpBx9zLumM2W
         NLR5XJ1kmYBqRiDKHpQK3S/ZKhSjr1JN27ekmygm+kmtgwqx4RGTyOTuBq9kaZA/X36Q
         kL3CAqLATR/41U0fl7oLkFrCme6tMYtfTOo7Tagfe2Jnttx4f/G9f+LI1f/+3aLtMlOJ
         yMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112065; x=1793716865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tJ+CL/5XQ31zB1tm/a6298VKrPjYPjRATx64g2n2nTk=;
        b=nc715RIK4gwHCR3sZrOKwioYQZvNXP0cn72dr6Go7QvyEyknA6AupG2evoWf7hlPfB
         XON7HqMEKvY9fPsGfsTQNyps/9+Ur9hkxoQbS7oItE4OpOQvmxZRMUOsuNug5iffn1rE
         qBbPVOQvJYqplzY3oBvEWZyYUdzL1cggosDMYQ4bHQ6sg+sTWxJWk53rDAVfDQCI0SFs
         kRoyMjj/xNUAstWLz3zmmozGZpIDqJ9ofjee/biPkBrIfaVQA0JIXVZzpiAmAX/Gz1I9
         4eYlRo4aTTYgfflLzyC805O5iSstFIAyOb+4xeLeERoVan5d3tXtFAOtTdKrgxS/0lvB
         BaOw==
X-Gm-Message-State: AFq9FYLrJCJRPTOPLymuwywVkbVCbrQgtAfGWSHWBELlPcxLr2SfIPpA
	XfmX9rfW2OKzjroB0H2Mgm5+RjNpFbmHA3YdXsuqHEIp0Kv9TMssbtf1sZfaWZvcgK9rFJtDskH
	Wq6EHyTr8Y5CCtnPa5m38pwsTdkiQFT/RpAtZ2PqHy9eRWHir689Wsy1pi73otfqT5iwi63w=
X-Gm-Gg: AYBFou2ii6SCcB8iaFtHC95KN06rGjr8aLWgHDQKUgiI3x2VhKDuZFkrqnaiYrmEVSu
	L99lKuXwwYxf8qX+2FHzouxtCElQkXWxN+g1J63Igs637QAGUpP+qeGxdiNcoFxGRG+OgvwLjNZ
	cT72QT0ihC5htFK+HrlJKuG5Ya8yVxGorEAWTyu7xj3i94Fsi34kJv9lJUhpuNt685aGhbE5tJS
	TFD3vUP8yXd2o15oIz34OODi8rO2VfPj/8xI34Xw4mJBWRZa0UGlMeBCraVBo+RLs9fWlv8gj+/
	9qrC7d/K0FPptR9z0NUX1Ldn5fsp6n1Vi74GdjdvAZcZjwT/pb1bXbFgabChJijby3+EpAg1x9I
	SbOzEGnuEiXq11dq1gC5F17G8TYl4JHhrte78kUfT6g2cYV7v0K+P6MYHSQ==
X-Received: by 2002:a05:620a:4592:b0:93e:bcbf:4ad with SMTP id af79cd13be357-940ef8d9147mr1725355185a.33.1793112065152;
        Tue, 27 Oct 2026 07:41:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4592:b0:93e:bcbf:4ad with SMTP id af79cd13be357-940ef8d9147mr1725349285a.33.1793112064681;
        Tue, 27 Oct 2026 07:41:04 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66bd3asm468527766b.56.2026.10.27.07.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:41:03 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v10 1/6] dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
Date: Tue, 27 Oct 2026 15:40:39 +0100
Message-ID: <20261027144051.249211-2-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfXwl4mpwvY3ptd
 uV0IRfFlH65EkNcctH/wcDFhRRnMQtq+BSHYA7m+EgP458prsqccXs7iOaM56s2SA6tICIXUIRJ
 DHpo0pJOQGfZFraByWFJG6GauMjGlEs=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6ae0b802 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Q-fNiiVtAAAA:8
 a=EUspDBNiAAAA:8 a=Bwok4HuJcqyDF73gS4AA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: M0P3s777FxoHsk9hlIyQlYtHABvuwunx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX/rsv6ny0UYuv
 OLKVyvzs5Oxc7mWhKUuLQ8onZAhV33bJ3LzJMfmw6hTN+vKxfVIXFtaE+ypOrNM7Cigj9/f9TOs
 iO+2QpbACUVPIerls6vf5ykS6AaI1kJ1G8BD+cYn4mP0EToOaTRGPWt6KCXtnzaqZTB2vIWkGVe
 lKeYwoUKO42ILmJhkZ+P31p2Ay1y2I4fy9fbzopE9JUvOohCrFyK/NGAf4ZyOi7qZEzkmVmowz/
 Y6jRSV32aIjTFtfjppMy72PVfr0BPTNo2M30dSllhsTYKTzFu+1uk9jzLaqfzPTVZ5EJiDZFL8t
 ej24NHyS1bc5K/HjGPZtIitgdO/kdXaNX7aBq3mv/fUE0f5XmWxNUZqhp+ERXrbx6WqqNbj/LUF
 3yXmmI4RG81eP1dJ3Mx2ctWMi3xnqxDn6HA19ogtlFQ7hya6ZeWi+UOSvC/5cSKJWncLcQaTxat
 DEKKrl229pC17DBeuog==
X-Proofpoint-GUID: M0P3s777FxoHsk9hlIyQlYtHABvuwunx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270058

From: Kamal Dasu <kamal.dasu@broadcom.com>

keep-power-in-suspend is currently documented as SDIO-only, but the
requirement it describes -- preserving card power across a
suspend/resume cycle -- applies just as well to any card type. Drop
the SDIO-only restriction so eMMC and SD platforms can use it too.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-controller-common.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 8b9b3b036129..2fc8e06d5ec9 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -301,7 +301,7 @@ properties:
   keep-power-in-suspend:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-      SDIO only. Preserves card power during a suspend/resume cycle.
+      Preserves card power during a suspend/resume cycle.
 
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.43.0

