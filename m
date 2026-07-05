Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F53A6B73
	for <linux-mmc@vger.kernel.org>; Sun,  5 Jul 2026 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783280494; cv=none; b=hKyi2OrLKf0opacr3Pv3/idVz53B/yS/Ac16aGUJezcPfOuI2CWFqwtoEiP0fStp/cLyPzs8uHJujBrfHJRv+QrwgQ8IA/aEMz1rBWiC5XIBhNg9MOotrSYyrS0CFq0i2nNNvS+2jJC0+sgfXibnXzWuMK5uBBMzdDl4+kVWkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783280494; c=relaxed/simple;
	bh=ih+WmqIWK722niQ5u1H1E9UksjJJYkGhr2LClEew4jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6ZZU92k5qDXYDRSH41P1tzL+RUKvyNwg05jXoTkGqB7EPIpputNc7lv3FDwLHjXiFjKKNvrCDB2peGxbeY1MHMsPGd5IE6LYns1SP7w48oCqfzRrxGEmoUu1CSKYmBSWWDYPVdfO7BWdBYOS5+y7HiDd+6sO1bwa7DlqnNx0Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LEH8gBGq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZGUYJzWq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LEH8gBGq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZGUYJzWq"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665HhfA42130955
	for <linux-mmc@vger.kernel.org>; Sun, 5 Jul 2026 19:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	keNlL6A8+I5pnaNawbDLPC3Skjo9l1+hFMmFLmQIfDI=; b=LEH8gBGqre98aZ5S
	R+gXIdM13wWVBKCaHBPzQIy3YO16XtaM2Yeu1rWWcKE8Ahh7phGi5PdgSe6faHYh
	NZ6WuJayU3dm2BjN9bw+VBE+ZM79Gb5/VMy0wrJmVG9PAL4oi/vWr8CCwZvut6LG
	bgx8kYmZdMLIw+hO7G1imKVsWOK46Uaj/pGQFCjPL0CK5llMYjmxUaWFjupRdJAp
	DojiJvRtFxtp1fbC0Y51KdHDxd4iTgLcudGv/2y9joceF7NK21EqPuFhp9vBp/DG
	Mr1h6o1uwl/xqAgXXnlbwqyx/z4fTFXUP1+eeaAFH0RCQyOQiLqKrFrdvXcDdzoo
	l70Dvg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ubgk5dg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 05 Jul 2026 19:41:31 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88ad1558f4so3633432a12.2
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jul 2026 12:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280491; x=1783885291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keNlL6A8+I5pnaNawbDLPC3Skjo9l1+hFMmFLmQIfDI=;
        b=ZGUYJzWqAxIXzMBhph0O6XZxQ2hb7H/KXvng0K9qR4w7d+q3Sv6K+L43GoWU+lC/eB
         zj6lXNOaefif9INP93rxsaXEdR0CjTrKZGapgon6K1xSO1x1etJ4wLJDdM7oKLYC6UTV
         NRA4nTW/+XQn8Szeb4LL6DdMhYo5n4f3YUhH1g0tSK55IgC0QZ2d/TW+BUga2bVWgSEA
         Qhegor/v/kr8DRMoTs6WRi6UxOrDObS923e3toV/e+RGNIb04oCCQKbCOU1ukU392DNe
         Z7aykGAkOON0r4zSU7b3Oha3Nd22etGk3JptUhC4oSp131Bfdcdkyb4mmUdDOJ2HTRDv
         Zu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280491; x=1783885291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=keNlL6A8+I5pnaNawbDLPC3Skjo9l1+hFMmFLmQIfDI=;
        b=QSTjz6Npoa+ZvIUK/bAca+GBUvGAKDmONPuKi/kjwi00vdL3k+OncRm8owtkEr64+1
         KBfNBiVl1xpKuBCRoYhjzYPhIWPoRNdscRssxGYfiRRL88cC6keHy62xDGVzvfFQKgMe
         9ubenAwaz4TPqAd7AgLQLp7CUiHdkrmwpCHWz4dbsZrJOut7wP+5wxZ99jinb7nG9zPa
         eJ9veWTeOPzx9wjODVTtq/5Puq8xBVoXGUasqx/WtRfsRUvPhyUFebKihpLASHAJ8sdv
         vplx0Hs9nTJYtfhwaIR2id8DHphIlUbOKMYi4GLSpMfF/XxlWawTtomqBxdC+5jQUFH8
         pShA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7D4uRuhJ8Mx6zCOY61x7t/AWdK2MqPc4D9mK9kLHW2fahzeiXebYLGymkzhVgDm2kLlyQde5ycmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGbO4YgiE76bFeGVXySQX9VAsBhDI4D9pMWJ3escecxQ8E7SG
	A1cfbR5HSecMztBHhpflfIzjPe6s6UqYUlVgJ44f+/7R7RAVX19QO3mK0pZV/CkWMQrrmqV5ocI
	NnXTJfafInzzu+zkoG7ktOTdU1qIW868Lm88ezEPHWRdImvgmrl0XxCzf5UflWuU=
X-Gm-Gg: AfdE7ckBTQQizb7dDkW34901ym8v5f7PA0Bg2sx8FkCTsjSOpBwjo6PsxrA9RzjTZEv
	PnVVLTpiybpzER5/04nkQscCIJ9q0cuzL4TY4L/3/eDtYm1UYzmMcOGo0ksmZR0zVM+UT3qhKgm
	F1mXu5PISXzmWqsHaxjKrD3PpkykOomO8kKNanbvVc1IxvR5CfN2fYvoAYLBJ4I3fb+ApRPbRWF
	yU2okrFysIYrnLuYxsB1lNDBI1hH6ACHR8WegcPiFWqSHzLIKiqH+TijRMj3M8QeEeA4Z5LjQMM
	MhIVE232exFKhDw02GneWkzX2fQQr5Hb3/m2PJW/a/3K4V+U1R2JCHZ6Vfov8ucHDlWzhOGNHZb
	NAAJ7hjURf6RZNqfnT3aTXTnyy1KAF1oKNCWwiA==
X-Received: by 2002:a05:6a21:4cc6:b0:3bf:a0e5:99a5 with SMTP id adf61e73a8af0-3c03e509089mr7554464637.47.1783280490837;
        Sun, 05 Jul 2026 12:41:30 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc6:b0:3bf:a0e5:99a5 with SMTP id adf61e73a8af0-3c03e509089mr7554455637.47.1783280490326;
        Sun, 05 Jul 2026 12:41:30 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:41:30 -0700 (PDT)
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
Subject: [PATCH 42/42] ASoC: sprd: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:18 +0530
Message-ID: <20260705194019.2565498-10-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX5yfanjpfM71U
 yep5x8D7WQwj5N2cSM1ztHt8ZTvtNf9GlO96Ugx2Bx+83SqQmbjwPBdF/amDAtLAP2MNFuTid0/
 G7Y+gW/QnIyRcU30zBz61E/q20Ix7K4=
X-Proofpoint-ORIG-GUID: XAYQASUXraR2RiVaO5Rm_z_X3NTtuMgA
X-Proofpoint-GUID: XAYQASUXraR2RiVaO5Rm_z_X3NTtuMgA
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a4ab36b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=99hAX-h0IAisWkWT3OgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXynOX3GJGpXCk
 4zfvcpf9dmQqQaHKLjfjIREz8mLjYCRXYuKD0PeiW19RTxKPikVUACFl9TP5REiWtLTvwu3OY0e
 XuLeI9ZcRJf/b4oGworgomY6Qnt7Zt/2y7gfw3w5jmPj21VjEZ8mTxeq9unT1Jb4s3bUkSvwfsA
 tEWth3nkWOU9QIvbJJu0T2uTsVpYURhMqXeiv2j+/ilL25oyXaTTIkqiszT3z8k0Qwb9NCIukEx
 XD9tDCFmnZDSkgy7OzV1FaQBsr4jUenm1DlQbsA/ttaPgxg/Nr5QtszfNg30Cca0aOhEfN/sXYv
 7f9P3hH/TutPPSJudwgqH9u8r7tiEqGxL6u077U2cov0GGxMRPrxi0z29mv8dgmHbiSV+FRo0z9
 oDNMFtNhIzHyKzpJ+g+S4Ftqi2Zi9a5pK7xD5Tpmf59Cp+wfIf7aVMhulOMTV5H7Du6yOURbBoZ
 7Oy1cxRTJoEQn4yRpeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup — the driver has no remove function. Also drop the
now-unused local variable np.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/sprd/sprd-pcm-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.c
index cbf5bf82d96e..220f55d475af 100644
--- a/sound/soc/sprd/sprd-pcm-dma.c
+++ b/sound/soc/sprd/sprd-pcm-dma.c
@@ -459,10 +459,9 @@ static const struct snd_soc_component_driver sprd_soc_component = {
 
 static int sprd_soc_platform_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	ret = of_reserved_mem_device_init_by_idx(&pdev->dev, np, 0);
+	ret = devm_of_reserved_mem_device_init(&pdev->dev);
 	if (ret)
 		dev_warn(&pdev->dev,
 			 "no reserved DMA memory for audio platform device\n");
-- 
2.53.0

