Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F939FCD2
	for <linux-mmc@vger.kernel.org>; Sun,  5 Jul 2026 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783280434; cv=none; b=cC/LiyjKk8eYZYuVQg2+GaIdz3pCNo1AenhASCHgYdxm9Ug7OvnKL8X3FVVnQtzcJodfUof2DMZFo8P4HhC7sbyG7j7xKVBPLaDJtsrhQVUNbQ7ejsxtma6VQAFPqmBQkpGrY0j+DYJmfvn8alEnkkTWTJWWMIHmUzp90Q3AbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783280434; c=relaxed/simple;
	bh=hPzzIh+00z/2sTyljZcHfK6TfnoHNAT4ontX894B59I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxsKvfKockIv8xiJjwZAIqaLaFnf8VfAHdZDb65DL7m+GuLlgwGzo1BaMno+7INWNiIpmeuDMTr+IBByWcPYq1a1ZeK+u+QHG6j+b6rq42PpXrNKXtjs8/OpdxPCykZ6ndRDVhnjegsWul/qEjVYlWY5Uw+s3bPGVyNu9Dw50u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EDqYFdv4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hTA9Hu8K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EDqYFdv4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hTA9Hu8K"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665HiSm02343306
	for <linux-mmc@vger.kernel.org>; Sun, 5 Jul 2026 19:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=03p+FFlmwi4
	5suRC+aZpApiuhNt9KA4gObs4WxBM+z8=; b=EDqYFdv4Pmeqy9IR99dcNiLiDAT
	/yuTE7Ljg9Hev+D7GIua619X8FUaXVlexko06UWo2I1UG1HwTHa/3pcOiO1FNKdk
	YiY1UO4+AP6rm2LO5F78feakLwRgePs5DdWtrzsXwhYCgTfecFqPFRL/MQqcfyO9
	pb9r2UQAkfcA5gru+dfTHa2mdfv7340zDAANejxt7cH1lKuJqEenlOMOzxtkjth3
	hBP3jcZzSc9vRDjWjL0r4gMT/svWmjZh1dvVGSJdpYFTDJ+ZtuRTINMxgHG6Wmig
	3zizUVw2wRtMv7D6VUvWZqVy2hRD9jXlwyfLqvXinpJSMddoU1sfRGdzOYQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvkbtx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 05 Jul 2026 19:40:31 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85a298cd62so1766750a12.0
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jul 2026 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280430; x=1783885230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03p+FFlmwi45suRC+aZpApiuhNt9KA4gObs4WxBM+z8=;
        b=hTA9Hu8KPQHszEz65Og1e9gCQW2eZ/sQXpMHuEmDsIJTuSZhlakz0b6YBehrxZTRsf
         mtBtQ1/+gV5LKqBDYlUXERKyjBDSvb4rzy7nmdLvd6sclFPtLuwfp3MRBLc7J2YLY3e9
         pEs5URSCAJMxiExSa0RQY4a8qSd0whJb1J8VH0KjHnQmoHg/vmWgaOYJdS105iy1dPm9
         wJa1dNDQdLzfCWekV4C4TM3A0PCBkn99UKowiL4UbwzPrzHhmGisse2fAJAgNNMYmFDk
         F0hX0peexMwNXI1r8lREqei+PM259Y70EHyCtHvZeCQ7hx+YgDTdg0tq97sN6IaHtrt8
         7v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280430; x=1783885230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=03p+FFlmwi45suRC+aZpApiuhNt9KA4gObs4WxBM+z8=;
        b=hPy/H4DNEaOqgF4LVSMNSUm1wq5ZzXf+dHt/iwI2/PhDm4cGkF4/MlKi4nlIShCrzI
         W80OmR5DWCO5ovUtQcCau2I1vXYAzNaNEUyH729NtUtDdQqGJ2HnW+xsdNdiLkKXSfxB
         BdvIJjE0oGOt0SU9q8o2MbW/DO/p0I+EjsZwGV50ezgknswEwh2ZkA2l2wKl5x0D1700
         tlfutz/O2TCWSROpDn5qFEUcIZ3cLyboZHIq1krwfdKhmlRdZY0jJdC6ootnHw2OxXxr
         VtVsPWN00vuJij0fqnLUhiSUbySHmWCOjWPxLpclxJ1D4T9XBVEbDypNHAGx7vgFuCAY
         EFLg==
X-Forwarded-Encrypted: i=1; AHgh+RpM1ot3y4wqT2NT5nGRYYbqbvfuW6/mdPBSfwT8J8OJNE5YAc5cQKyC2TzIPDXJzKh054JDRiNDl4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye8uLq81SYx+ifMewoIN8Dwv1YroesTWFHuJOrM3KmUqOQUU/p
	FafKbyTwa3V5iZ3Hg5424mFgYPPSM0ScTlwqpGvoGtJgzH9cOtZW08mTTvmtm9A1XtNqkpbuia8
	+wWeERpZvCsSjiTANMNt9uCX62v3VfSWLY8FI45JmbhGzydc+OXIa5qVV0d5dCaU=
X-Gm-Gg: AfdE7ckfZo4T87S+R/eozdSHX2OcMpVtvfKUAfanLUARp5y5dTiXiZcIoZCV7/0epJQ
	K09Za9jC0fN0yJBcQGtM8Dz33e1m+rdYGJVwsJxanhIsns3y4G8gP7mxbdXONxVR759B8gDqjEY
	fd8d5B43rceNgsl8vkc6e40OWKLbeDVj721ioOcPI9jBDVUv3iS+P+evv4vHCHFTyb5zAtodZem
	MjJQ+Y0FOKNS3PkmF8XbNINY35ln/XqC584Zmdsjy5ufraROn9FEtW4Bh/q6isGSWj3YTCGhGjc
	tMu+s2bcBHpBsjX5D4Tg6LDYyc9gertariAoSaycScwbl0Ov8P38WgK0XLl7H7RmnnXb5H1qiPg
	CaIhRasLqS5ynqCf5e7z5lKvXYLxum1dfmTMPrw==
X-Received: by 2002:a05:6a20:a122:b0:3bf:9944:a8d8 with SMTP id adf61e73a8af0-3c03e3ed638mr7693677637.34.1783280430280;
        Sun, 05 Jul 2026 12:40:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:a122:b0:3bf:9944:a8d8 with SMTP id adf61e73a8af0-3c03e3ed638mr7693658637.34.1783280429779;
        Sun, 05 Jul 2026 12:40:29 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:40:29 -0700 (PDT)
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
Subject: [PATCH 33/42] drm: arcpgu: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:09 +0530
Message-ID: <20260705194019.2565498-1-mukesh.ojha@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4ab32f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=lEtn7xO9CsvGDZioIccA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 3NDi3tcupmQEYWFfLOcx7GObyWWeTzOY
X-Proofpoint-GUID: 3NDi3tcupmQEYWFfLOcx7GObyWWeTzOY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXxi4X+a0F34kI
 aHfOzOQeOFLQEVYXuFEj4YGDGpEuYBpIfBgczgIIChofgDiQTNCJ81uqyJM/+rKaQkP9wo/Y7NL
 Od+vUMgKdAB/5Rv1EA6swh+ggdii3soPL/JTGBtQJJk8HPiNpVN2Yg50BZsUB2X37QdW4qUiCzF
 8KTvx/U+AJw3CTrMUtVKpK+pKxAatnUW+3Szf8bvEn2sST770fD42bmcozo6oaXZLH8y0GAIato
 6og8nEemo1vnpvIkHbJgVxjrgaz/DJoaraCkji/1NiAkiiQONwYxzgrGySRfFaKD27VZxscCnML
 PxbpGwMLUY1764STwFQo0AQE08IWsjQbGbSswBdmpP1seFLYuvEaZGyArPcBuGDbGSRYw4LvPKN
 yjGD7pt0wUunXn9ilHT81+gqTLe7+ID/o/yAEsqqhWIBbCP6jFBc2KWSrzHTXY8FzLjiQcxLrc3
 8VpMcjWV7dDb5NANR0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXwjr1SXX/5hxH
 GMzXHcHlsT3U3HPq+rMS2ROnOa9udfvySBczWMiBNStkaoWMVoKKh6W5jqL853c5KTXz+CK0RII
 AmQPInwssp0+yHzG6vcRZJUbHvdO5uU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the optional reserved memory region is released on device removal,
fixing a missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index c93d61ac0bb7..fa01407570a8 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -278,7 +278,7 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 		 arc_pgu_read(arcpgu, ARCPGU_REG_ID));
 
 	/* Get the optional framebuffer memory resource */
-	ret = of_reserved_mem_device_init(drm->dev);
+	ret = devm_of_reserved_mem_device_init(drm->dev);
 	if (ret && ret != -ENODEV)
 		return ret;
 
-- 
2.53.0

