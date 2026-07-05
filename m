Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51E3A2544
	for <linux-mmc@vger.kernel.org>; Sun,  5 Jul 2026 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783280469; cv=none; b=SS3BOIJgbMSe/EFeT7eDABkcOYbyY51n/WoHMzQSkN2paoBZDCbFg+A3YUDFA1LJLtmrPTqsPZXL875nwM2/N49HsWI6zwWCc45mx09cn5700o6o3DlTdpY3o0/AySEBqXSgwf7ZYcT/I+IBvcFDBmhEHk+TO88tkAdj8iP6Zsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783280469; c=relaxed/simple;
	bh=aDbMtkb7vLXS6gEaXl0MiYPwbTWQdGwMD5R/KH8kYUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMkxierkbGehOmPF+7EYa5AjfPFUvNfb2Q2xmTcmURk8n/TCVuFjtgMV+K5FXlP2brbHXM203fgZRoaIMAcngWglDcPNmGZUC8625H04jCK5m/1L6Qbmy/whA+rOEE3xOB1zZhRTukVadDXUsTssiiqV1oCtjHn0DJuq1iKFE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gu2AUpMP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T8Pl1BcH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gu2AUpMP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T8Pl1BcH"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665Hi3BJ2353124
	for <linux-mmc@vger.kernel.org>; Sun, 5 Jul 2026 19:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YE6y7UueLsf
	6Wosu2MYgZO8ntkoAFUpog26frL0IVlI=; b=Gu2AUpMPsdWihBeIKFaHZTQdE6w
	3hlEj5FaB6LO25HrrwgnnnhbotR4nd9Z4wSGwf4UfkCGQV/6ByGXzYxc9t77t1UR
	KxydvfiZRzO7LVQt12P9iUwRudBr1BpCa8xRlWA11APsaC65cFh9VkqkdXLfhVEu
	RS7FUpWGXF4DoGxxuONB7a1iHQSW5kUybFXNTGlhVzncQd/ITVBR3Qzh2FEbhv44
	Ssss7TOOyxh8WnUK7ITPBb/1fcoeLek05gTbaYXanK/TXcrfcsX30aor/3gRRzD7
	xH/7V5eC+aAPsHQJS4BlpVVOM2yO5umWhzidCMbdBGwQ6NruQAfsY+kAKHw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4sudvd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 05 Jul 2026 19:41:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c8018f11fbso24015235ad.3
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jul 2026 12:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280465; x=1783885265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YE6y7UueLsf6Wosu2MYgZO8ntkoAFUpog26frL0IVlI=;
        b=T8Pl1BcHV82RNdBhjv/YnnFJMx2PfKDW5ali50O2AuxJ+wFsHHtCe9sQA7Jl4J8V5P
         7Sfx5/Z3iYr87U3fToEpecY9nTGwkS5LuNuPJE7XZnPMR+QFDzqzu/S+2toH3N3ACjOC
         ov/rVrjS9zsB+0+wR1t4Fbu/gqGr6U+MFivmHAi/A6j/xaLPzVm4uQyDjXILKDG5ErxQ
         wCghV6hgJMk1/bOaG+Kbhg96dIIGv8C+5JlWtE+gc5YhG3rek5F5EtpOrDYYpU/XURNz
         veuIPckjfa1XWXIhyV6MWcEzzJ7CCOkwnn0ZQJF++6PDjZKd0MVVabY6iqb5kVozPzxB
         XwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280465; x=1783885265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YE6y7UueLsf6Wosu2MYgZO8ntkoAFUpog26frL0IVlI=;
        b=dzNXfvF9EY2P8olepdZnPawOKIHP4TnAT1uilXnN7G4phITBfNc9dAjUdRNgDY1tl4
         8ZW7U3MhNESF5IkLK949tyGKv4NAk0Eq3Ta47KOnk5tluKYmxKdekBnQoM3ew3g2wgNa
         zO1QyMLCY2Sna6Q8qjOPn93eToaNe4Zok4l5zeUVv2wNdMIBO3BT0Wypuale0WFdHrIa
         ctA+R1i3UQ7Wve+WhvzzB9EJjrO29Nq0mMTQABYMv0Hf9GYjsgc3ZeOBb/CEhFusOQ+P
         vmoit9J7OfCnAoPbtuohevllRuz7AlU5UuLUhWrrElYN6i4IkadFXF/DNoR21GUd/83T
         KYAA==
X-Forwarded-Encrypted: i=1; AHgh+RrLZYrFKaTB/75JQqtP7Ykix3y32IljEewwCG48nAIdV9MwAPsc+z70tlwGQjzG08k0pGnkZou/3zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOvqzMO8nohi8qGFDc+wQXbhTNK4Nk2nd8ZOPok+JGWrrio4ri
	QQ83qETPTAP3wWUyubhlHR3uaJ5aCiXhGsMzU0StXDvwcYhNZFrZmv0IP76NDe4aEtsRsn5YOCX
	zxcPq1GbY+1FerPdGzu0FYF1XuObtqjjSSRlOHwndPkDFB/GZ95KOeFnvrHoUHls=
X-Gm-Gg: AfdE7cn0WMVWkH1nsUSLrRzmYqoATfg8Bi3KC7FqSQdxMoDJmLQrcHiZHMmQ5NKe1Tx
	0o5BFf2P0AKqTsgj7FdwCGCwMGLzS7p71bLrBgrY2PUG0JQ4mdyZ/6kifRJutGHW4rJ+FtGsSw9
	zfNibdvlHA6nDNqYCqRHtX3NFGwUTXVNaw5DocoEqUiuzNiP4OkHxM/FPtSHWFWwA+hMFeq/DuC
	c0jy6cgDhYN+tno94Wp9x3uTasACX3UFbzD/d6CdiGS0zFiAcHGJ82XDPLPkJCpWgpLrKfnWOSa
	v3CSdNRXgZOetmFE9gYao0x1u6Gh6FT8llyNsLSxNC8VgtpovarWvCBKI2pdjJSKbvgWbNzBiNA
	KYnjyxqYdreRKje/Wq+4kq+iQgukRFB/q+WDOFQ==
X-Received: by 2002:a17:902:f60a:b0:2c7:f12d:5d37 with SMTP id d9443c01a7336-2cbb9e264d9mr68673685ad.17.1783280465199;
        Sun, 05 Jul 2026 12:41:05 -0700 (PDT)
X-Received: by 2002:a17:902:f60a:b0:2c7:f12d:5d37 with SMTP id d9443c01a7336-2cbb9e264d9mr68673415ad.17.1783280464710;
        Sun, 05 Jul 2026 12:41:04 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:41:04 -0700 (PDT)
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
Subject: [PATCH 38/42] ASoC: SOF: mediatek: mt8186: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:14 +0530
Message-ID: <20260705194019.2565498-6-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX14ikd+8DE0YX
 eGDi7vLK06+670zB2AbUHRFmK7PCXHLgYQ+vdEpuZB0c9Vg+isKhQ+44NwRuj7RMoHBlIQBAB27
 IVY/badyDqRy8m02U4KNggHG64r6IEA=
X-Proofpoint-ORIG-GUID: k9A8puFzTNs8PbKA8Uxg4Hr1uYrLwZMY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX9+HmGat6TVpd
 eZZCCrIa56zTleTuIz6XTSFsiI7PHujnduXyqqO+qTFdZ9Az0MEOVOkOqNIGwhpGmNM1IHV3uns
 s7bU/6Uo6olaVhQOleo+bWV/gyFaVwcL7jSFpdhzd4NxM5dsLNn/MBBL8Xr8dZd2we1yg1aAFyg
 DfsontpN3mzfT29knEdCnEngoBnneYWAqBGMX3Ug6amJG7A8Lz2oH/To8TMbwBPnj/YYyeFPk0p
 imQZXAegx/9Dr3PKHJC2nb5iZj+KnkkiRlcInGkpiESfPCeFBADoRtI3jfWovYzZrAaUX8K+bIE
 MQUfP1ibr7TtspfRwNEEGyeb5iXRT4sjbgoFCYrzhw2AupA9cNX5nKidrMk7ux7+8EyUDT0MlOp
 XWCOhmXxgVxuttAv6p6GLc4G3JE7pKt5TDViUSm3YyWt8a2hCTvF1soluvjlhOuJSescu63fI11
 MKHUjeVwQms1DEZiTmA==
X-Proofpoint-GUID: k9A8puFzTNs8PbKA8Uxg4Hr1uYrLwZMY
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4ab352 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=YxFYfaw6DuWYmsw8bRUA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/sof/mediatek/mt8186/mt8186.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
index c1bea967737d..a5ccee87e684 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -49,7 +49,7 @@ static int platform_parse_resource(struct platform_device *pdev, void *data)
 	struct mtk_adsp_chip_info *adsp = data;
 	int ret;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret) {
 		dev_err(dev, "of_reserved_mem_device_init failed\n");
 		return ret;
-- 
2.53.0

