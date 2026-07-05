Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14C39FCD2
	for <linux-mmc@vger.kernel.org>; Sun,  5 Jul 2026 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783280449; cv=none; b=EZsu9qevdCZuWfP9P/rPiPBOkJcLYOuJNFov+dXOM4RI34rBrt7GilIgbbsup1PkpU10Re6shCeVoTx+xcV0h7yFmRoea/rRS+jqViBWTYNpKlCj9IgSFgU8PeV2XwGXh+rEDrbdZiljxvIZ9l3RISDmAYc3vn6qbKxAQGoZluM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783280449; c=relaxed/simple;
	bh=uWGYzLdeRrzr6t0aAVNStOMdR0p2+G904nfPHoPwpPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aj6CjiKWa1krt66XFCulTfzDDbrGwBQzhYhyFOieHaitre4AZEA/HQHbMQnIommVPpzkoskPl46KYExUgun/MitVHtq5l8P4CdLBTRAMta5pb+isV3nlLv6EBbxsVikWSvTumAhGU47qeuuBYDh2COzybZN2eNsuYIXRIrhUzSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lc/WGFTE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gKDe1OP2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lc/WGFTE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gKDe1OP2"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665Hj9cl2317389
	for <linux-mmc@vger.kernel.org>; Sun, 5 Jul 2026 19:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7OthzF5yzbE
	g8KQGkSEAgoedjCLI4POQTlWuL9KBHJU=; b=Lc/WGFTEsBR6FyBf8pb2q2cTo/S
	IRTkAnMpy4BZluObjv10Ds1+8wWUnkRZLMFnZfxn4lwUf9wNpTCxvblYHfxq/YKl
	Ovc/Cj5jLSEuk8ulecmXZk1CDgTUxGIQtjZKnuWR+K1jUu+ftDDZonwnoZEjSzlk
	ct1xTk+NVIo42IekyeGwdAr5vq+YHarJ6RB16P36dz97W6pvhWCceSyR2czSTYp6
	hSXnIp2oW/ZkZTxzubwpV++50pKMPkSorshnXRFfqderNm50KPgm9F/0EgLX4x+X
	hMm6Gy4Wmztc6y63i7GrlHroXX0TGdaLddDcR9h9VbzCKd2rrL7p6658Gqg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6t8uk9sv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 05 Jul 2026 19:40:46 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8895156101so3284162a12.1
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jul 2026 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280446; x=1783885246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OthzF5yzbEg8KQGkSEAgoedjCLI4POQTlWuL9KBHJU=;
        b=gKDe1OP2VeZBHb29Tyhk0spYB0JmIjlaM0WTmBM1yBJQhBOf9aEAfK2exn1LVOPmEW
         t4kJI5JbWvo7DnSp0hgIRl4RWIqkD9+3U5qVshADpK4OTBL9FHpl2bQOdUEXUgeyPqdr
         8kPKsWQfcJxQQOftnOh2eJtuGQQ31071Y2jn62GkaOy1+vlsou3sABX4caEqGuvHzOKW
         ns2kVtK4ktPvEWHke6Rx7gSE/FRUcNMXW9zs8/1IZh4kAyQ7Pu6TNfQpy3Hq/ARbyQqK
         EmfE87yx1Oi4kvZWhENXHgShyz/hVyxit+9LLPZMP5iWFa9ik3Bh5lE/KP9OAvYmxxsT
         xdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280446; x=1783885246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7OthzF5yzbEg8KQGkSEAgoedjCLI4POQTlWuL9KBHJU=;
        b=I/cBzwMKWeMhzzIcb8BYPEXiX6B8E1D/CIh2jhHnyXbqzv/16I6Wr8R+ekuW0NIDrk
         6tgOHTqFZCc2AY8AccincAT/5RCmooA0L+YPwXLDzdq9sFRHT+dJOpQdcDdNhtQAPZE9
         q/jWikDYMgOHM2cHspLGrKmm3bwKMlXzyqZPCmBMR/Q5GWMqBFUw+25K2hfXI5IjHPPJ
         1sSUTmJBu8psTzPybvY8jfHH4cSeXqjQJc+JULa4b9hiWwTJrXe5E0QCkvjYVnMQaFxy
         pNktWEWQqeSvR+ern82zA8qR9U5Kc7mAUSzsRlf/fczagA97T0uB1zns1OQt7MS06AYo
         LEXw==
X-Forwarded-Encrypted: i=1; AHgh+RoACFIgxbTXzZYhn5EsexUu7GJ5DuR1gR0HRf6c6N+Tkok5dRBEbHoPV/wgvqcDWsR5qkRRfbx9BfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIwBib1WcljMf5hpsw8r4uDODmskPhMW7M5symzD3LtrSQ2bhU
	im9vaPco/qr1h+WsUHKdFAYpmknZV5CvRDDFMs73hxGAQLId4j+UIrNQlJJ42GpWVtUJOa1H31N
	TyqsQ5y9aAMNxTzDrLnsP94bXVP3D8KDdwJJDlSAkXTMU42wNntREy6plzlFN8xw=
X-Gm-Gg: AfdE7cnGDCgSdT9N/SNgqHDejyPKJC5a09djD+Wv3mgLi/9CylSVZ6hnavAlyypn66l
	x9sd8X2Tq7mrn3ERvrPqRf4WLETKbw0dXI/c8T5qlWsPDXfINb8TykIREsFm+RY7tHYNaCeX41k
	5LIfGq9x/uNxyl1KPM8LMlJfwLyF3PX/SKe6fdtpff1y8xdTifh/3KXxay/5odoUF/QozZtTRzp
	lUGm4IDd5dugeRnOOZVkGSDMOV4Ijn1/es7fSncUIG6YoZ9XD5NbDnq2F/BrCxGm0U8Uegsd0YS
	GvOi6NXaCDwrvWzv2Hw1yrvDgiRwtpA4/hswGdq81QqQcWj8xjmqj5i+6/3aNFTp3GUFLTmjBZ0
	EtMtt+E1C48UR01/s7wyzPwyTq4uDyg/KedIgBA==
X-Received: by 2002:a05:6300:2211:b0:3bf:6c08:fb8c with SMTP id adf61e73a8af0-3c03e521435mr7049939637.60.1783280445928;
        Sun, 05 Jul 2026 12:40:45 -0700 (PDT)
X-Received: by 2002:a05:6300:2211:b0:3bf:6c08:fb8c with SMTP id adf61e73a8af0-3c03e521435mr7049907637.60.1783280445455;
        Sun, 05 Jul 2026 12:40:45 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:40:45 -0700 (PDT)
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
Subject: [PATCH 35/42] ASoC: mediatek: mt8186: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:11 +0530
Message-ID: <20260705194019.2565498-3-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lUTMt-AT8hxX_Fg90L8m2BRPbnBqxB3q
X-Proofpoint-GUID: lUTMt-AT8hxX_Fg90L8m2BRPbnBqxB3q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX/6AG4GdJOTXp
 lcS3hyNc13qWc2ECotnps5Dj3sgAJ1j4RlslJeRMwlOzsMEj5ukbnyGrFt0XlnNaydi5/08OFyL
 RzbpmXhLlvoc+KGY5w0p++7HH5OfBXQ=
X-Authority-Analysis: v=2.4 cv=MZxcfZ/f c=1 sm=1 tr=0 ts=6a4ab33f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=YxFYfaw6DuWYmsw8bRUA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX5Js+wiiJ9M8n
 ETzRnAjGsvGXPto7t/gqe5HFge/W+GRCvSzXeG5gz+FDU79IkAm1xbiLu/dtQmFGVqXephO0Srb
 mPxGBSra13hvwgYO4cAg1yI3DY9UcEq5gcuUpX1X64vphPB6KuNW1pNXnVZ9DyD5q8xgpp4UtFb
 KuPKkdjYLI24G024bzImez1KZxb8Z0tXSAGX+5orEWCRdYZES6pfZW1NsrhmLgzIn+2/qCXKxdC
 JGVonrkUpIN3HIwTQAvfE8zaqEqFu86OvicjZUxiDc6YxX5kkhH08sMOeXPqcYOX3gvzJ8kNE7/
 CGztRC4FZZh0ir3Qs8AUQEF7rL9z1N3Vqq9G8nSu0Dwd3etYizK9pIZ3S356JleSTyTA6oLDQnz
 iNimLYVuPs4AWyhmDyLHOjEu4QBpXnGvDuO/XDeZGck0pchhIPJkyG3CS4fwjOFvJwjcU21ipC1
 rLH5uRSfWGPd8JKBrAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
index 44a521c3a610..60576f885acd 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
@@ -2836,7 +2836,7 @@ static int mt8186_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe_priv = afe->platform_priv;
 	afe->dev = &pdev->dev;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret) {
 		dev_info(dev, "no reserved memory found, pre-allocating buffers instead\n");
 		afe->preallocate_buffers = true;
-- 
2.53.0

