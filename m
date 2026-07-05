Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB323A453F
	for <linux-mmc@vger.kernel.org>; Sun,  5 Jul 2026 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783280463; cv=none; b=tULMEVoGHuBq/oddzs13WCgFl6PqHWWkqCP5UYuwSflLrkEphsKxa+ClMlQhR5EblumTwIFciLa9HlUz/jDj0qe+A6YjJx8g74HBy50Zo/phz2rFfkXV2dW3w3bJ1nZDo6qCW2F59qTyhY+MMuo4JRYI5lccdTDDEGFpAN7gBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783280463; c=relaxed/simple;
	bh=v3ifKCsrwDtuvCvlwDYadGM1Uonf2WH1mckdOsVySyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gh0m4yXU+hBpny5W+GLiavz3sO5V5QAhBGWjfBMrWY4Z8gta76ZDUG4phQTrDcocKbbWwMdYcanmx2Sla/Fr6vT9bK745wH1zBJA9R5otgUCjL+vZZ/Hk72M2/zBJQ/Bg4hnFJ8lK28x2Kus+xpNz0A2q3ji8K0wjj6TuyBXMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPcw2XE0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ki4huXFc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPcw2XE0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ki4huXFc"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665HhwQO2168647
	for <linux-mmc@vger.kernel.org>; Sun, 5 Jul 2026 19:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3J7+oNMk7WM
	Q4KOiVM1+PpfhqlleI9nCGCg735LegyU=; b=hPcw2XE00hJiXGUlPJdzgAHVQzT
	3IKBxTpsdM3YltXY0Gb00tp8cyyqr2jLji+CKNDBWau5JTu+BreuyR01af4GFyfv
	ngpGWe//C62ZWMgkGJk4zSl0S0wOJ9lpQw3JAKnLg2fIs5pZCB7N4aamjssEjqJr
	56eMgt2RR1Wu9uGyx458onBujfZX4GqD+UxQKYZvfMFk6K6CooiLxTXLejKO9W0R
	0jkXD7cR55aEXj06BsfreVAtJNhMuxZgvDsgw5Rbn8a2yz3zzklaCOw3S6PIDyNi
	LSZAc2ZKjYucaa8JgIZQNxudHkYVpBDXyT4e5CmqkA1zH01od7f0TWn9fNw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6tj8k8t2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 05 Jul 2026 19:40:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so1029495ad.1
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jul 2026 12:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280459; x=1783885259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3J7+oNMk7WMQ4KOiVM1+PpfhqlleI9nCGCg735LegyU=;
        b=Ki4huXFcopiUnCi55PmHll9dN0enRKHhl3SR+texrrDbfxFUA7YcAbqswPPFZUR5Hu
         trTCi/r+LieHmgndCX+yybgp2kntxcI/sTt9zQ0ci3nSkdKplKgU8nMY9wZZH+RQmkkM
         6pQz1v/onmqnWmZ4W/bUhgIHDYJkAXQIDT/f9/fFD9fFly0DZVgxPG/UmzOjzRmybFIl
         6uk0k/wuONSStO8paHob0mxdQ2hOXYbS2j+Wm7AJArNYgZEV3n6JEZ260E4SB54cpCRV
         H6T1VsK/F9uPAAeOpQVxJTA8I3T0zjEUsZsjjr6xqBs/3Ljk03DYGzkvU0NwQxWZz/dh
         7itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280459; x=1783885259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3J7+oNMk7WMQ4KOiVM1+PpfhqlleI9nCGCg735LegyU=;
        b=hshbAkLDsCfDG19KbjpAiTqN190MJ9coGhU0jYKYx1cW3zNOltgqSBSn7cGNSiuk5b
         dV4kp/PQVIUAUvulQHQf4GrAdcs4fAk3r90ggV+9LfsynAjFaFuw38u8RlHm4n+1Rvw3
         RutEABrc7SsLLAtUhQhEk4pMg3xta7RWnWPNCSaoXtF64N3SF7mmuIS3jvxuic7piZlA
         80Gj87EdkJbr0rY/mdpo6ak904ojndBxzsr06P3VQzJ2/V+4M1Ossh+BDTKi1mttV8zp
         arU9JqfpjpbYQIcnXNam1TBv+w6Z8/CRSKBtUs+eYdN2jARpZMl8wBrKSM/IRlV8SjA+
         2EvQ==
X-Forwarded-Encrypted: i=1; AHgh+RoNzwY/BWFIq2rWvIGftVDpJ4SSeZg4kFi3fK2QRokEkqXNSDyz+e5tjCbWLXiEXWTWe3UO0nKLzYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxbWE9fhn7bieFag2b77oNh/HNGTLO/xoUlL0SwCIDXEczyi3
	xXc+my3G1FwzOq8v1njBV9+xlBfFxuor15PWr1EHSMK9U3XMYpji96wZxIMTAxEmIu5BdhHE50a
	vgLeJA1MmZGqz0NUvY4cY3w7Exl6G34Vrfu2zgkD2PeqWJYlDhe59uJSAYe++XqM=
X-Gm-Gg: AfdE7cnNWyb652MyyRHphVatKD34h2v+Shj4YVQUw1HlxHzSziP1lakF5MrQ0Zj1e71
	U57eXYypNSmGa49f5nYrvARHv19z4DBB7m5lj5sxmJ8lbiTIqjiwNboldJjjpS9bHmkwptHbtZR
	8NEZilAvcJ/+/eDeF46zGdNrKLPV+kfhnkHQRn3vQCo+QxMV2LWnMwVR4CYfGLrKy/9rJRNm4Uu
	ZCLpP3OaFzEqBJPWWiDEIRnj/vExkcm2Sb+Z62aD4mmOTY4CUrFIjRHtBsmS6fRslBc0825IjhN
	a2mQx3UkX1/WSyA5GMibtknXInkIlNa+2x2ymQ3CnXyOOtzMe34urNx5DNuRrXUt08yQGT9yvKL
	p3NOEd6ef1peXMzKlgbQ4NfQVV3hEUeBTKJNNUQ==
X-Received: by 2002:a17:902:db05:b0:2c8:1f1e:6922 with SMTP id d9443c01a7336-2cbb9ee11admr72369345ad.37.1783280458791;
        Sun, 05 Jul 2026 12:40:58 -0700 (PDT)
X-Received: by 2002:a17:902:db05:b0:2c8:1f1e:6922 with SMTP id d9443c01a7336-2cbb9ee11admr72369145ad.37.1783280458256;
        Sun, 05 Jul 2026 12:40:58 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:40:58 -0700 (PDT)
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
Subject: [PATCH 37/42] ASoC: mediatek: mt8195: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:13 +0530
Message-ID: <20260705194019.2565498-5-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXy9xLAirEaPKi
 T04P1qy1yyFQ9q7M2r9Y0jC7yNt5Q7PIWdMk2429dbvB/OZ+ERXweBcn5sJB/zP0FXinkDewpuV
 KB4z8oBBmsqfrdIanZ1O24Ch+YCHnfB6G/LOLV4Z1/U31dkQG4L3HcYYYPwLUWDvdTt9REjdyau
 r007efz7WisB3MYLEsDmLRXDV+3mzPYZT7AOOntMkhNfYm/SWQ3Kzcb/4elulRJ/1uVVKOkidbH
 d/X2lJ0XujLJrAPucdJdbsaMWP6vSEDU0nZR6OQDhG0mQkVIONmwQm9eotR6FJTW27Guk+RbtzZ
 CR65oxHwzl3NM4F+caUBekL/2fj8MlPBCGNiTy4d4tS9Ukq7mARrDcLHbHZX/atPQqcUe9cxpUF
 f/u9TnkJ0mcYtSGGumLbyVKM6Ksl8VaOoUobjYusiA4jczsxPwqFmQB9WGYSPWS/SyC8DEmz7PW
 K7eqpehr5Q5nlgBj50Q==
X-Proofpoint-ORIG-GUID: av1Dg7mo-7S0fzXeVkeepWJ1I2bkI0Cd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX4pVluQf2c/Ou
 h/MwYsn97VsUfnplhQXkpF5Jzi57I5MI7e/ncrIf6n3Mi6vntjqhujSJ8OOz0iSlmwlzuguECk6
 ZN5xTrBLoFwtLbc3AIT7P+G82MG6YkQ=
X-Proofpoint-GUID: av1Dg7mo-7S0fzXeVkeepWJ1I2bkI0Cd
X-Authority-Analysis: v=2.4 cv=H6TrBeYi c=1 sm=1 tr=0 ts=6a4ab34b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=FVZLpNCcgjzkSGVc8gUA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index bc0a63457cd7..52c3381e6766 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -3013,7 +3013,7 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 	struct reset_control *rstc;
 	int i, irq_id, ret;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to assign memory region\n");
 
-- 
2.53.0

