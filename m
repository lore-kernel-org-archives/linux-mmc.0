Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523175;
	b=qNbW3R7J18kpFRahYt9ew9PhoHnnTjOuTP3k2Q0D79wwn9353WUSZdNWEE3BYcQ99z0o
	 KLsNwSnlkCyVT582vazpSC/Xo9v+U5zyo0BLYNMVOf7tQfD48ckbRQYDnb2Rt8QzxJDxi
	 xllAHhNSIUt0pn7LUgjG0/Y68ot1GfVQ2vGY40Ur6RUUww8Ap8YzCpfBmHr6ZdaMIRm5o
	 AzrNLgUq/K7U3O6OS7pU1w/2bhPzqUQ6iipAJ2tW/BPcrqr5xZSQoxG2U2pqwN2+C41Cw
	 9Gz4Mkf6wtcJW2GyO6XN3MtGP2nm0do+O7EcUrfcJa2UOYp4pxSIMp77lxbqovyciOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523175;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yc/mt44iiI3JDnoTa+amNxghgBGpPCt5eP48vxd/muE=;
	b=oU2GDb9LnVksPue0p/xlmFcfX307gJtaWUIkdXZaBNaoQDuZZbCtBTBrmy7JHck/xtxY
	 V1WBjuNykBHwvQdYAFdP201sYBTQ/w6QnJJDOFsUGFWOq6FTZ56E9cjuEOge2FXqeB/vw
	 iTzz5PRXZIMg/pfDPQeOWbxpMsd+tToxp5/AlxbIyWe1RmHxC76wqFHQWZ4W7FD7WcHYa
	 JhhBGprabhv8v4GjmpW+nVVHwGVukfeUV+iib9c5py+18ev8QWAWnET2uNfsO6sUxX4NJ
	 Szlp7Z9vH4/x5jq1iJRfSDvoGsy7EY19tS4AzH0MYo8Vl2Z2qC4DGfERlFSuKTwHwzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dmOBb8rJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="T/HlP/+a";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B460A2610
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 22:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 405B460A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dmOBb8rJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T/HlP/+a
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACJZS821690511
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 22:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yc/mt44iiI3JDnoTa+amNxghgBGpPCt5eP48vxd/muE=; b=dmOBb8rJ9DJUSOlN
	31Fzm000FnyJBj+8QH/DajyZ69iDI04r1LceMymteo4RXucWdvGNTTGt6OAeOnU5
	xbfGLc/WQvzimbrDkwOhWfhf9eMedTZb3eGzgYse0EwgmtqgTYG4ONV46Dwt6DB6
	Uuxui7UGB3YIaQt+2YIEpamngOD8oRw+r7aXK3mYHDarFLSYkKX+kWFpTFR0U1p1
	UByb1YQw3yh/H7r6RX+N0vkofYtgihVgHYGjRyv+OKhEuUZ43evtgFnOgetS32Kt
	7nhEq8sZN+lgxKLIpX2CKj8dLct55F+8dQFiWnmkvStwh5k8RzzMHEU2Jlqa+itd
	63uHSA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgw8hsk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 22:39:34 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1a71dd190b0so765365c88.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 14:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794523173; x=1795127973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yc/mt44iiI3JDnoTa+amNxghgBGpPCt5eP48vxd/muE=;
        b=T/HlP/+ahzjBAHcmMwdp40+2HfWnVY6Wf5oa2Ecpg5OCTvBNoq2Wp/ppBQ+Cmfu8fy
         +UwoNevhqUJ/oiSUhVKINxiFItj5uEPOdpDckgTROpoPzRmxUeezZ2jm9xZOIbecp69d
         xOF8EcAZSdYcegY7k8M5v4U9ngtTxQAPe/MckIjHWHjdW8PjcyrmcNe1l/C8fWGpYw5U
         X7FLRl70rIWK9RaF7Ep8v340ghgNTEoZl+W+yz7TFljxGNwhJ6S85qprmmxPxvvJTAGY
         FFwfb3bzCTgt67nbOheXvh2OXkS0mjjfAfBL6R2GlOxetv/7uC6cftpjihqmPZwW3lgQ
         QcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523173; x=1795127973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yc/mt44iiI3JDnoTa+amNxghgBGpPCt5eP48vxd/muE=;
        b=qKB1rKmH38hqwE4PghmGnxy42dUdxCZ8hC2dHTBYerEf8ifKvsm4ordAcDq3+KOF6T
         Y8ayIVvT1hu7ypHAPrftcdLONoSsS9iSzQQezpDchoBQ7m2nMANqvr3nLFJssBnUn+0Q
         JOAEH4WqUUDMECm2HTv3yA7KipR+iJlmTZKavVffwEETjpVDyAc/uSfiYo2pljQIIWHM
         02Rf+HAb5T9EPGqzEhrEO83xZI1SWvoV8qFcEvyrqxAifYe02X+Pjualf+MgDBNvS8xI
         xm4yLko8eWYi18ZSxqq9elSkF+1ikkt8WLfYV4GQrz6r1wKTh9zcuqt10EOcZW1ogcE9
         t61Q==
X-Forwarded-Encrypted: i=1; AL+hErEJlpmIYQ1u/bd5d+maxV65z5SZmKmjFDAdr9c1c51NRo9h6ioaGI2JOyb2Tgqi0HNU6OOfMKVm0q8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LB09Y7nzTEb4MIKsqGHc7VpAMNs4Oxk5SHjhODUVgl1JOtYr3
	1Vugz+URV+cikCooiJ0A/hjVItbNK7Z0focvI3JoAAnkj+JA7XoIxC+Fv3uYId9N6YEDeYB16RM
	v8VGMn78V1vyOIHGWManxo7EyyLWETBi6/2PwCDD4iup+4BoRchpEPsmERQG2kgI=
X-Gm-Gg: AYBFou3puiiyxag4hAcfCAMKesLM9KnQKe8qKTyUBzJgin+9fINb/xDihW8VRA+9A6Z
	bOhhaoF5ObJUeUg9VmKDKrgD+rLNiIrZDwJnLMKdIel/EoM3mDO4jhLQjCkX1cZ2Co7to2eRchW
	ZeqaClDMTebvMX65O3/eSww9ZajNcDItggpjtWBAEf0duZCEqwB3/urJnrAHLWRZnmmdIrNbX/J
	0jnoWQeIQJySbZ/r68t6HnDmX3Qs5sGWMYhqzBow+mZ7HHYe9xTPaOcwldjLoEtHqc5QbkEWnT4
	LlhTQFWEXzlxGUtWu6rbXRBt5MYoeUzQZfEkjkAZy6adJ0Yl6aVAgGoUCDMS+vCWCM49HOz89u1
	R4vAEQzK5vC37sLBP+75+SmUCNtRX4CiGJGT/5FIRouvyn9V1qimpIAXt72ArJZQRdQro/annuH
	22BR1ZLx5TUg==
X-Received: by 2002:a05:7023:904:b0:195:c6c2:c6b with SMTP id a92af1059eb24-1b50319ce0bmr844408c88.35.1794523173091;
        Thu, 12 Nov 2026 14:39:33 -0800 (PST)
X-Received: by 2002:a05:7023:904:b0:195:c6c2:c6b with SMTP id a92af1059eb24-1b50319ce0bmr844351c88.35.1794523171031;
        Thu, 12 Nov 2026 14:39:31 -0800 (PST)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm2333496c88.5.2026.11.12.14.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:39:30 -0800 (PST)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 04:08:29 +0530
Subject: [PATCH v13 3/6] mmc: sdhci-msm: Set ICE clk to TURBO at sdhci ICE
 init
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-enable-ice-clock-scaling-v13-3-258dc817bd63@oss.qualcomm.com>
References: <20261113-enable-ice-clock-scaling-v13-0-258dc817bd63@oss.qualcomm.com>
In-Reply-To: <20261113-enable-ice-clock-scaling-v13-0-258dc817bd63@oss.qualcomm.com>
To: Abel Vesa <abelvesa@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af64026 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=PzEurhthzZq-M9kHIYIA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: a6Xjwa4wx-iKUHfGExzOIBNbX4VMUha4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA5MCBTYWx0ZWRfX0p9S4b+gtJ5v
 Zm1VlR2FMPGgnnNQTGmka0Z5QJPQXu28+u8PI3dLZu+K+/eH9TLwmYQlmMJmph3nWONlqdqjvNL
 9uGVZ0HRpaKm1fuWWqZX3ZSX7zU6Wg79hUXt4antTvNtTm/C0ntnsFuPBAZD+sBrtHEkDkux7Sm
 dJ+2Aq24A9ccjeDL7/SVKnxGpydV8Wt8s8ChrlntPVQbkeZseZDdxi2vf795ZO1NvPq2m8F147W
 j5/SNnRB1J0a3alYCgXEWqI3Jns8WQWkzuxj7dr3nO1yFNMwxzX84YjURQ27XhQQwV5eoJm0IV6
 dq0EsZG7wuvsSqwMd2oryBwljciuV4EwEppJ8uLN4o9ppATYUmaQH3ZpO/9Wi1PrLLZcKk961gJ
 OfHLAdZcFZsiDb5z81UuTzRCyplBvR5r8TX2hcar8ZI6i2j15pI+fKd03MBptte3tJ08YDGAOul
 c6e4DWUaqboAfm0CDvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA5MCBTYWx0ZWRfX49WF+tUAo5qQ
 YM6na2OAX2MMv7jnRcHbTZvPJ2WEfq+3KB7C3Gqi9Ru3yyahB5KyVbGdzjD2LpBqghwNTDxcCdH
 BRw5/QqAf8rwac5tC3X7WZTfmtlCt/A=
X-Proofpoint-GUID: a6Xjwa4wx-iKUHfGExzOIBNbX4VMUha4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120090

MMC controller lacks a clock scaling mechanism, unlike the UFS
controller. By default, the MMC controller is set to TURBO mode
during probe, but the ICE clock remains at XO frequency,
leading to read/write performance degradation on eMMC.

To address this, set the ICE clock to TURBO during sdhci_msm_ice_init
to align it with the controller clock. This ensures consistent
performance and avoids mismatches between the controller
and ICE clock frequencies.

For platforms where ICE is represented as a separate device,
use the OPP framework to vote for TURBO mode, maintaining
proper voltage and power domain constraints.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 drivers/mmc/host/sdhci-msm.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 32b1bcba47d6b75578f01d8de6ee9beea3b1e080..652c5cfc87bcc3c59b845b9e2fd785bcba197fa0 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1902,6 +1902,16 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 
 static const struct blk_crypto_ll_ops sdhci_msm_crypto_ops; /* forward decl */
 
+static int sdhci_msm_ice_scale_clk(struct sdhci_msm_host *msm_host,
+				   unsigned long target_freq,
+				   bool round_ceil)
+{
+	if (msm_host->mmc->caps2 & MMC_CAP2_CRYPTO)
+		return qcom_ice_scale_clk(msm_host->ice, target_freq, round_ceil);
+
+	return 0;
+}
+
 static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 			      struct cqhci_host *cq_host)
 {
@@ -1960,6 +1970,11 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 
 	mmc->caps2 |= MMC_CAP2_CRYPTO;
 	mmc->caps2 |= MMC_CAP2_CRYPTO_NO_REPROG;
+
+	err = sdhci_msm_ice_scale_clk(msm_host, ULONG_MAX, false);
+	if (err && err != -EOPNOTSUPP)
+		dev_warn(dev, "Unable to boost ICE clock to TURBO\n");
+
 	return 0;
 }
 
@@ -2160,6 +2175,13 @@ sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
 static inline void sdhci_msm_ice_restore(struct sdhci_host *host)
 {
 }
+
+static inline int
+sdhci_msm_ice_scale_clk(struct sdhci_msm_host *msm_host, unsigned long target_freq,
+			bool round_ceil)
+{
+	return 0;
+}
 #endif /* !CONFIG_MMC_CRYPTO */
 
 /*****************************************************************************\

-- 
2.34.1

