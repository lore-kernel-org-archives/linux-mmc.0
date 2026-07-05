Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF953A6B82
	for <linux-mmc@vger.kernel.org>; Sun,  5 Jul 2026 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783280487; cv=none; b=KjsHcSHVTro1+q1mE7pmFipadNBR31mkXirEzVBG0XZZMwyDzYkj0EPj956u8EMsSaS+HqKTjZL7YeNDa7NvH+HCJLeJg8v/t36WJ8BQ9TrmXwaRNg5bkrFGr1YqHZc0giNqbPbPeu4YpBVSzoYMnEDc8TRJUkt5cp3wCbJojrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783280487; c=relaxed/simple;
	bh=GVKkJosfWbaAfOvliUHFeY44e0c1PSKKGH2GQjW/JNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyMfValYAHYjuhUDVjURcdhLE3/ZZUtei9uwhKSAch4d+1Vm4zl1tTv7sXVLbMbfErLSzkpgc/oD34jpwRlSEgdtYCQyyoQzGGGstTLPSkXOqscdDkIHCNJPtfwnKm1xNVbsKaLSbMEv5NVfCWSo7RhFOwQDHSv/P4uCYilUUYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TLn6zhut; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IZG58Ff4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TLn6zhut";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IZG58Ff4"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665HjO0X2193576
	for <linux-mmc@vger.kernel.org>; Sun, 5 Jul 2026 19:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NGgGvwnqAVQQEeBPG1kTtk7oaNyoX+6Tcm1yJclm2Pw=; b=TLn6zhutzCtePBXP
	eApN5L/sdm3XfMAHOZhP82YsbqE0e2xRcEAFk/+OzouZNGNfc26qhw5knDcbPcel
	BP5iZZDUvJOH4Kdt2QhgKPJOeoScqNJcXRyWCHIYBBbsIEBD0ZiVVQvHgMHBpB06
	KDdBLLvkRr12JNjMqEtNLmZCzmB3HEASAP+zwk9LWIkse6JF6XJ5aE2oTFOlREXB
	HWsjh1ZGAPgsRx3a1N+Une0Zk6nBS+M8q7Nzxb/+beCfZqlUhL0J/8be0mCDgioR
	WDJzt0GGrulk/kLFg2I0CGVxAo6WNnObMHMMKTDfE+fIZHUMdON7dtl7vgqPIl6I
	fMEfTw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf8359u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 05 Jul 2026 19:41:25 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so1421995a12.1
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jul 2026 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280485; x=1783885285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NGgGvwnqAVQQEeBPG1kTtk7oaNyoX+6Tcm1yJclm2Pw=;
        b=IZG58Ff4FSz0xPAqXt1O0zOxFaAtOJZN9IWe92nAwZiPZFjlqg1nbrFbHttEcUNU9h
         6jNoGhV+J/yNfrzUEPILSBDguBszwwFjfNnFc9A2XxM81pxpNopJp3YJAf1MD5JDgCEA
         qc9jZ3IetpNBJ5FteRGNGtBCi7ieYp/p7vcP9Djop8UiiDtew+Pqv+RLVKdAcanrSLVR
         ax8sD6c2p2BPl/cpPFDBJPPaEdKa1ueytlXTK7L3e0Rs0hjwC/qmQzpwmotWY1vX3x27
         L3Y9n969UKSZ9fVEaC9VZjmXEyIueej8S7mRzFuGwKDKJW5BD0apojcOkpFjRLvynm0X
         Hudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280485; x=1783885285;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NGgGvwnqAVQQEeBPG1kTtk7oaNyoX+6Tcm1yJclm2Pw=;
        b=biwua6qub5T6XWtA2pVIE8HCyweUW9F+QyE1RGRZoRn7HHd7AJQDzCCzIwPZNHRds2
         LPgEWHvg0GdhowqDJH0VmvP8xLscQgAp8ZJTyDmUL69K176Rz/bShE2S6XfCNuAEe9F/
         fjNOeDhQgFw5bEJYD9P+k2kzs4u8RDofesad1/3xRiWmHgAaZ/Lwu11jookA8YyO19C0
         tvWFWvn53GCuBB2wV3WWj9TTbHoMtWMmZFHf6J4FW5giPacdT+Mk8dc1vjTCEaN5scqO
         hOUhdEX7Q++yiJAy5UDcY0hu9d83dyN9rwQOhV0Fgtjm7mnM6xZJE+vH9/wJiZ3CRvL2
         cVqw==
X-Forwarded-Encrypted: i=1; AHgh+RoPBcY/2j2P+rc2TaiOoJ1aHnEbozoRKaHHNXLWdhPVaUpsdWv/VPMIHa5quoYi7AyLaaAxcuwVHZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4KYg8Ymz8bcr5HrnBJEXtODMPFZciCW3BrFVJLfXb4FPSOKmZ
	L53E+tgFSBzrhsTSvf1z/dRzNs3cAOfa7xn7pDkdq+EyUwvEWnYx2XHe4uJtk1vWOBU46XZizo0
	0ZeLErF03uMwsa1arSMko8RQGIpebxv43qGUWEsjbwCMNEjH0IkXJpnFjkSwHF9w=
X-Gm-Gg: AfdE7ck4i82p9RLb2OnMvc6yap+fJSaYPPxNPSnBbJYN9cSx2NyMr46ARxXyMrCQhC1
	iplDOumXp899dj+Y+FMIneum2DaQhLLGygQiNcAhpLZotuHsj9nePP2WHP4copKLQiNc38C/ym6
	Ug+U05+IGlajuz3gwjuiNbYaW9PhR42VUX0+qYS8OFCWe3FDgGLkImLRdQ0Z0C0kPpfBYgW8FvP
	hVI0vXOKTbv9adWAEuZJ/EEIJrEp2jDXBZos2ROqWNxkmz3h0jdOp/KsPvszhBlT9CPAkGm/uRp
	wh05iDvjwDEY59rzD9wYxUz9ik0oYpPJf6gwva+XVT97AsztwsGKabLgGwS3bcvD30NV96WT8OF
	0YvF4Lmulq/w1qfbHWHubmFwkcEZSG91ofntKxw==
X-Received: by 2002:a05:6a20:43a9:b0:3bf:9e25:1a13 with SMTP id adf61e73a8af0-3c03e26ff8cmr8745237637.15.1783280484468;
        Sun, 05 Jul 2026 12:41:24 -0700 (PDT)
X-Received: by 2002:a05:6a20:43a9:b0:3bf:9e25:1a13 with SMTP id adf61e73a8af0-3c03e26ff8cmr8745209637.15.1783280483924;
        Sun, 05 Jul 2026 12:41:23 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:41:23 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, sound-open-firmware@alsa-project.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 41/42] ASoC: fsl: imx-rpmsg: Use devm_of_reserved_mem_device_init_by_idx()
Date: Mon,  6 Jul 2026 01:10:17 +0530
Message-ID: <20260705194019.2565498-9-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vnOq-Vv3oG_Ohx-4bRgIMVAvxTOD0zfb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX87GcP/09jgYM
 LcuP5OcoLNkQCC6Fv/KqPrK9WsqXcX6t4cMezay199aGqVmA3aMGF0z5oMNuVo88Ak7UPfoVrDS
 okqnQwsyKzQzpWAgh71LdLaoRzFdI9g=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a4ab365 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=dtkDxOtodmQ1SLiiO2kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: vnOq-Vv3oG_Ohx-4bRgIMVAvxTOD0zfb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX79FE4eta17JA
 mn52nGUezK0m1FdvzTpSe/vgkCfpHLqgylPqth0VkNrKLMPIb+UHREEjyiffMaA5oIbOC7SA39g
 fCfvxs7Gdls4lLQuyKEhi4PyFUEel3HVrdtAP0t7hGQj/oz/QXzTuS/WUeUkhQOzg1aiWjrm18Z
 eD3vxwJZkbQc2ifOij+LJeL5EhwY2QrZddRTRsUkpdiIbcsaw95am8E/IETdv8dnOyOnJwLrstc
 7j3j815lLscEy4cL6Es9VDOP7ajJ3LiTfpOeWlUHT8s29mUxsg8MQRqA5R7lHsFePo4vgYJSOgI
 o2Kwzfo+eGNHXhkuPNOsHJoQ123BQH8u8TxO9IZ0Q9AIrL1pdO0lu02ClWgqVojnZgUi0+0DoIl
 sMV4o1XOYuMBQOVVPwDNl5sQ13mALeiacsN1hvg887HweHMIXlJJnvcIje6qSpIrS7Ck4yrpOBV
 uhk6U6z4zbPbrBi4Neg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init_by_idx() to
ensure the reserved memory region is released on device removal, fixing
a missing cleanup — the driver has no remove function.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/fsl/imx-rpmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-rpmsg.c b/sound/soc/fsl/imx-rpmsg.c
index 5f1af258caf2..f504d94c4f68 100644
--- a/sound/soc/fsl/imx-rpmsg.c
+++ b/sound/soc/fsl/imx-rpmsg.c
@@ -199,7 +199,7 @@ static int imx_rpmsg_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	ret = of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
+	ret = devm_of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
 	if (ret)
 		dev_warn(&pdev->dev, "no reserved DMA memory\n");
 
-- 
2.53.0

