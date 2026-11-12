Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478493;
	b=q2MqiNPJKhMt4KEBrgC+cgMurSb70HjkJRl1gBsTHgnHEwGQmS2xxnsJsJJf/A+pfN7H
	 4T7BG7WUJ1Z9L5eeYP2C6MVAdFCRlMNaH0/3LtoBkwXG7SCRO6w2fvWUHLitre4R5qwmi
	 CTka/rVUzjmB/xWpccQdbyOIQYdCKweyUVEDDmRVmOeO8lbAcTWqV7bHVIZpT+CiaiBvM
	 cVYat6y2lxHMPCQMFMJS/wI/vzI0fzSCrMw3dj2SiV0CosFeBmuen+lp71PsYpGis3FLp
	 DidQFsEfv+8bQfZStHuM/Q/7zLx2674lsc9cBmAUv7CUmT63VWmkfeM8RLPH600xaGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478493;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qBOR+gFFhPjIkJZAh9FbBz32f5Ed7y+W4HlGKYADqeo=;
	b=O4QalO2rPbY9L/1YmvAIN2Mb0+fibKFZVsOiQe2pMG4xoR/V2ZKGT24CKHqlwjeJ+D0X
	 8zgTet3J4viKIUsqE2cA5mnrs+zck3gNnxndvsrOVZAJC8Qq4MaM0xViYNKV0FAWcOIDu
	 /XUeWK17TWGqJ18ZN9qmWuh74PFVHymh2/340TohIRcQbXXpN8IaEJXn16zRrGfwLeYyn
	 o66OEdJVTKMXJgPcKK2w6VqDWiiVdbBoXm7d9uUHLBZNJpqrsmE3nDrWIvoF+Im+b9F/d
	 NG2O3Re3c7IpK08oVX/foOLX7Y064NTnrpSES5Qzilt6MvnPSM3k5eVaT+UwO/Fu/cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iYswqEQx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U1q+5iXH;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AED606A332
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 10:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3AED606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iYswqEQx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U1q+5iXH
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC98RYQ903602
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 10:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qBOR+gFFhPjIkJZAh9FbBz32f5Ed7y+W4Hl
	GKYADqeo=; b=iYswqEQxaB+KMHSlWhPE/l3KfebpG8whkxNSNhazGOTo77fS8eB
	YULd/gde+N4XjtoypfaMT0eNanhawtTbsL8aHcyhOSOkhaauV/XchGWz+539VjdD
	1gXuPYi8i0vFo48WKGruQuMnst3Lawrw484IsIKAbD0zYRCqp7dSUADl6pd1hYrl
	B9ymJNnXGXYwSot27pvHVywU0HQTk5TiNjSD22J51u/JdkkvbG67RqWjAEh9e7X4
	z0UrVcjuQzKMehqqZK9vPT0DmGJ/IdtvmXK9zZ4gTf3Espxp2rIzlGIn/h5x+lO1
	jDi+49zm8rQAOc6qOwCqywD9QBfGA3nlarw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1uc3wm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 10:14:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9308eafb465so895198385a.2
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 02:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794478491; x=1795083291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qBOR+gFFhPjIkJZAh9FbBz32f5Ed7y+W4HlGKYADqeo=;
        b=U1q+5iXHR3+kWKbhe5vnQW8IGK8Yud7S3BmcPxLadCvlPV7HGDQI2xuuXbgkjAS9As
         oQw1Ra01Uw3JgX6OJprurP6WiFjKuqRnMYuuNX8dUmJsuQqi9RDnlnxChmhWXdWg+6zZ
         szxQ6HzAW80q85++O7IYXCRdiAcSVr2+mtir4lEG3jtcTGaj0LZ1ODaedgnz2C6uI3Sm
         YqjfyauacmXZqb3XPeyZwBl6migeGExixDPBHDX3UQAp8Om5a4bebxBYtPcPIbqx6nxY
         aKh/cY6PvlwUgRsxmimvkSG933uJGs14M/yPzGcv387A2PhIPelwuFDy2VkbkoIU5dKh
         uPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478491; x=1795083291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qBOR+gFFhPjIkJZAh9FbBz32f5Ed7y+W4HlGKYADqeo=;
        b=1kSITYn2Q9IiT9fM+R6ccBHCIKc65J8/ceiPGiMHhT7k8l5H9KSjgWFUs0cowX8GXI
         KTz0kX4yCcJDrWChPKY9HnuIyaFHornrZ8zn4NJ1SW1oVZY9Di5wlf6C2EqJ4vwB0b4P
         G9yTnq/v/87IBHZF3BsMws8Bx7PKC07AVaBNEpY2Ut36l4USG4kczoL5mVdYrM+xdWVd
         66ftXLt90MMOaxuZu5oX4uHJdsQW7HGRrdERVySCnvW9UFaLr4Lk1IyrcImAW8Emcbr6
         JfiOjTzzr7i6ejwibJktU2vFN8BR5ghZo6xiDdEn8CGEj6gwvGZk7kZEp7jFIgM+XRJY
         K9hw==
X-Forwarded-Encrypted: i=1; AL+hErFZXhT3YODSag/VsKb/VlmEbAbWhnmFBV1UMzWTnRavjlCc5hqogiPQieedmQYy+PPnKPGc2/FPXvw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TzGRNo8wrOxxXlt3dL7biLGMhv+58L60A9E0olII3LavipB93
	MD6NrgWKcAZ9BfQs0Ik+9petzH9UH8/OluvPGg0Kt6r36qGSiQ2OQjICuoATa/U6q3AFmQ7zpVe
	ZysUTPZu/lMHx+Oo6J1laXySCob5CbZ2bcCGP4VSXy89wMmip/SJ82Fv4mIhR5RA=
X-Gm-Gg: AYBFou3Jn/GBbDGFMtAyxaRIQBTxx2+6v+hXLjWE0eDPk7o1WrsVMfhs9O9x1+c3CZl
	qkbPL+jN7XJ3TJC03Yv6azh4dVX3871D+35n/UyORoIbnnmxFiuRfJCf0OARK2ESNdVROf8+/ER
	3C0+M3m7V6vVXFbdp46FuZKP+FIy/SGTaxvY6qYxx1WSMndN4CRFLVFcJmdl3iYSpj2CjWOlaMI
	ONiN2T51hJPaSFluP5KbBCdWWdBiUrqAB+T+BPs0ndzFz4+SejoCCWrTAA6IlxReTFUbLi2UcY9
	idnslaADc4RNnVp1rbxW08YwgyHQF4dwXx0uh46iVuBHYYUzrdO/4eGbSEZUDHov4tVP5g1uvlp
	ex7tDsAC54poNPqpSWFXaq7cdzE9PYEJaFFLHz70qeCJfDNInw80gnLl4I2cJ3A==
X-Received: by 2002:a05:620a:199e:b0:943:f31a:c0a8 with SMTP id af79cd13be357-947aff97ab5mr909119185a.17.1794478491121;
        Thu, 12 Nov 2026 02:14:51 -0800 (PST)
X-Received: by 2002:a05:620a:199e:b0:943:f31a:c0a8 with SMTP id af79cd13be357-947aff97ab5mr909115985a.17.1794478490623;
        Thu, 12 Nov 2026 02:14:50 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c30b1sm15933943f8f.46.2026.11.12.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:14:49 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] MAINTAINERS: mmc: Drop Asutosh Das
Date: Thu, 12 Nov 2026 11:14:44 +0100
Message-ID: <20261112101443.62417-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=826; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=zQ4QLbByNXixw4AisNKAoHU6qGobht5gpmvNdOqT+lA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq9ZGTxUwjWfyERB+m7WJU5+unV7Qrluo01Fzpa
 jvcrqO/fWGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavWRkwAKCRDBN2bmhouD
 10s2D/9Mobm3qaOtlZWIt04ssgwrzpmncF0Xf/GHIj9g7RxLWMZgFkf8GqSksBsCaaOQVCEDlqe
 bz0hUVLkZri2clqBwbbomD1rWfdso64UAhQntlK/PfPxXj69UgZCSQauF+XzbV1Q1s54hEM0Oeo
 BvxZ3/EpS0O6lWejiuCSXa7O2ACpPPKsudvNxzpwl//p73opgmOIE2lF44+9RLy3HRqGCXJJB4c
 lxGPpBV67UkZvdEdHQRZIQMnfAydBeW9BPL7jKFfdUMnkV34uaHmmfDnzsjiy5GoNE+wwQVyByz
 v1w4wtNOuIrUE7wHcIYBGCd0EB4Eu3fLKq2UYn0D8/3tflvVKv10a5onJ24gJs7RXbsef9wWE22
 aJFSFnt7HUQCqSn0VH2WraQKUJWgMGvazOEHSQcPA8oYUVw5pgrPkBemcGC6GuJaPM84nYxXvXX
 glNLKz3CufbGL0zqoy+/9NgUfYV7tLK+ULE/NRYzHpT04wBm86DbAonpbGShJjjcaA0aoRensTL
 0EwXKg+DDUGX5oVddr/++nh9vr5TnSNR1hy4B9fISoLWRmMz7FHxbFK6Kp9Fbs9DcwsWe/En5iE
 6cwjpkmPxiuvNLuphXex3IRUoR5X9rXAMvyihCEd+5DaQcm/bv3o0pBps55q/y3Kaia0PlyvTcx Myp32S5oDPlAlbQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfX4qCBZyGSxpZ0
 dMiRQ1oKIkjZYYe3kPuCrIOlfSqwBxLkmTjOfn7iDeBI0BSr6JcAlXwy9Hs6Vm6Vp3BytT1b+7H
 gcf0qv74lc3gLI6UxWSN+eY/fydcTew=
X-Proofpoint-GUID: 97uVo7wSb--aKqEoFKeOlcmnUsnFMczf
X-Proofpoint-ORIG-GUID: 97uVo7wSb--aKqEoFKeOlcmnUsnFMczf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfX/W/CRZvdHqZA
 ddmEQ2REsdQUvqIPRnlpGFyg0bYeg2d/SQ59H8ITMK8WoI9LVhxFZUhhIrkOQVpwvTC1/0eOU8H
 wj70ySFiPFUfQ8kPGI8aENx/kKzxwZmQV15xboQg25G2S8J2Yu3Cy13GVANO2rgjxrf9pBvS0rl
 L8+91xrYFfl14JEOB9VOHDg+y6/ZCHSMmV85QTwmf/wjkq3xNEDGX3nM3OSPfqznjUzpJ7ztJew
 V6FG/8gJvEqOreugKSLAwTYkWZQmwzC6a0hQqU73DV9ZPST0cWJmV0DsHC3dIaSoP18PFusVmK+
 3zhH/Dxg7hBoBThmr/0QNLXv42F4Q0uf0b00esDgc4syXx3HL0mkYzmRB7yYNftDXia+Sk06TJe
 RBELCfH9ZjIA8sooIIMRSVDtR7eKjUMk1lqY3z3kqWEe3Syw+5lllJviWEKhI82ges8bbO/XvwN
 TGMyIlF0UhNxn6lz9dA==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af5919c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=ss8VjldhompejPgElc4A:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120040

Emails to Asutosh Das bounce permanently with 550 code.  quicinc.com
domain was long time ago changed to oss.qualcomm.com and every Qualcomm
maintainer was asked to do the update in maintainers file, thus if that
update did not happen, then maintainer has moved on.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa647f5d37dd..b0ba5fd61b33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9868,7 +9868,6 @@ F:	drivers/media/usb/em28xx/
 
 EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
 M:	Adrian Hunter <adrian.hunter@intel.com>
-M:	Asutosh Das <quic_asutoshd@quicinc.com>
 R:	Ritesh Harjani <ritesh.list@gmail.com>
 L:	linux-mmc@vger.kernel.org
 S:	Supported
-- 
2.53.0

