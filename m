Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70338441612
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420545; cv=none; b=hK13KoR8FeDEdkGwAcio/KGGfYJ5L1Ix75PlTr7Kn63PriBFbvCzmZwFrqBm00Uf+JCKsbXy0t5h+bOcDm39bHs4XewudDrwTDkT8rUMg/ySWoTJtaOq9kX2byrKfL4Tgw2fNDi4UehVOGeAGH+R1Y+qYAyONGBg7wAn1DNSqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420545; c=relaxed/simple;
	bh=/YRhreB7+8RllpPwMU235VmXR8Hl0KzVLvYw3Tj+GFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=co6ykX0ZRf2EgBY99197cU9XFQll8V9zlvfZX2xRkPHyhY3w8yy6dPydBrLKb0lmgaJHqFa7KkvAx+PfbHGrj09M4npZjZXRLLWNUPiUlnUovheuszs7iMzdHSmlOnRDx2ThyY4OeDZOS/IqY/+jfVtu45vSwL2suX3MWEA/se8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=clwoAZe/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UZRWuLxB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="clwoAZe/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UZRWuLxB"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UE2GJE1482609
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 14:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vWbudVip6tf
	wCXbNl1MoSJC4dGsarPaP6arNMiDp9Rw=; b=clwoAZe/vtpB/JpXzUlm2sYEQR7
	vH0XmOt4ZMUfH34Ls6Wer0be5HioxD+/r3gKvglweMMOTVAjzkS69XaSLg+L+CrD
	d51+++Vkk59OyF1pgIXlTTZ/ekvVAstZyFZwzlMhcSNBtvcLP7Y5voJFXfaw4XLE
	E/fW3lHZPgDCpCCtUGLLCPPox4GT6vkqxI4ufHviGmE6WvjHKuEYezt9w3GSwTuL
	pAdjC7miyul4yUNJdh4c0p8QFl5uk7YnfHBRrvLGUBRprJbOlnRz4O7JZOl+m11P
	r35RXIxSTCcNMEbjTLoHLJr1oWYRjXI1Mhzdh3LvrHKnB48Os/SM01Oga5Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr81581be-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 14:08:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f08560ea44so25409666d6.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785420536; x=1786025336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vWbudVip6tfwCXbNl1MoSJC4dGsarPaP6arNMiDp9Rw=;
        b=UZRWuLxBBXyvXI+C/pmJTZRGcMAktdeW94ogunYlGrSpNd3X+36d4eOVlay+xSorHh
         1vxWvGGcWCIVBQty9ALZA+01AhYK/liMecRnXvpgrurO5RUprDCDIU5HDIaWFMNmw5IP
         6va4UhC+WRL6p3X/LUheh97JB7hQ/6iVSoF+JpmAaWlRL6dkcujyXkS7873//cpuyR9i
         /m5cbdah3WMULH+TknxJZ9noJ4w4ZoM4+Y9O6Xelx6+2GQG2RLAH82VKJ/bOerO9Qczc
         GxF7vwydRgKRdntSgTmYrIXljo8k8GsWKKZA1+9ySKkEMUribrU44XrrTjFmZxwqKAWt
         P07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785420536; x=1786025336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vWbudVip6tfwCXbNl1MoSJC4dGsarPaP6arNMiDp9Rw=;
        b=UaFkZV/O9zClbCluKn9t9aOtjN/bHM58Im7pnTkApt31n/PhrFd80on86U11AxYC12
         jIT/oUsJEwutR3N+81wjpOBz+HkjiQoGCkN/YfKSAIzEFrSjPX7MUVsJtQDXi8bivbW7
         j920sN0I6hf6s1Qrt+lIhVgK7FK4xfqOyrCxl7+5VqQz8ss7YkpIW7QEqXyZ0/vlHsO4
         uVc5xtPT9XBBn2znRZcttd4dPQmnGcddLVDzwK1eZjAPWowRWLpV03iU0qtbddT2ALFR
         tPn7zVkRAJ+TZz5cKTxomK2mJmpxzmpJWYR/CngY9FGY1TPC1IONTjxofRmUUmMrmTH2
         9GPw==
X-Forwarded-Encrypted: i=1; AHgh+Rp3phPGU7AHFcTaJSB/aRL1RMCgeXNfezshACrQ0H/sCax+u9r3f1uWvbJteZ2fLC9YYKIDXxIXfP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjVoA+vhdjJXVvv4bnAvLomTIEGn7Tws1H/iPttKInFsZWbE2D
	sg/FaueC48kiMHy5Tj31S02CL1IbXzpcBGqSbi8cTzeZE3Gw7B+E3ZTCdZlwAFlcTAEf+BrZUGz
	ckPJrf7Oq76slFVAb7hKz+3CeKPQfi1O+TE5EAW4/mVC8UDBNK3Ydl66HBP7mjHk=
X-Gm-Gg: AR+sD11ac/dxXEFTPs1SUflWVQ2RVmMyMh4sLmXRpMfUozXZ/LVc2ga4dQ+qZgc7GV7
	xBGrR/31sPCeVSLVLre+ydAUpNX4vv71Q1Go0nn7yd8n8Ds+cRoPjYNeLMN0EHz5sBduac+G2nW
	L1h2SmtMYqp7VpJfyVB4TjyAgrsw819ZoqAe1VoiGoFaNb1VqwI7zgxNi65jXSyAg68hLKCaXUj
	jvbT7xpnwGQgY5Qngrkd1hyjbpfv7TVBDnlCy7UjE5u9pGYu8iL0N5Cpe2oE45BjirBXpKPIu5U
	h5Z1XKG9l3L4Byr98xIOitLqulY2jpjqLasHGCBMHwU+2+77UTKZ8bUavWL9+1eFceV7RiJxHkV
	7CCuz7NLDyaWAHHk/RSRPrMu15dge4/Q=
X-Received: by 2002:a05:6214:3003:b0:8fd:6df3:b37a with SMTP id 6a1803df08f44-90834808b7dmr26856176d6.62.1785420536109;
        Thu, 30 Jul 2026 07:08:56 -0700 (PDT)
X-Received: by 2002:a05:6214:3003:b0:8fd:6df3:b37a with SMTP id 6a1803df08f44-90834808b7dmr26855526d6.62.1785420535609;
        Thu, 30 Jul 2026 07:08:55 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908325186b7sm18465826d6.43.2026.07.30.07.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:08:54 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ebiggers@kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v5 4/4] mmc: mtk-sd: Protect crypto capability with crypto config
Date: Thu, 30 Jul 2026 19:38:22 +0530
Message-Id: <20260730140822.1976635-5-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
References: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNyBTYWx0ZWRfX1Lk5hNavaaaC
 V6JJNvYKw+mpZr7dDu7eL3KrEEqFLZBzHVbwmJHWwhSZPMqeBIsVa6CbN18+fUfmjMuqm6NM3+f
 mtQPhILWGvYNouJoKB0ZWaq7c3oV6cOXinmxqxJAloSW9yqbbx9uf9RG1HmwfNqn32x3Pj7yzgc
 H2Qnk/uvFtMKonOIHgy39PC9EMOYAPRMg2ZJxNA7AYjce+OTxnU6LyfQrZLQmGnsSl5v18DJhTF
 uz3kOGO6y+toKoX8vKfY+IZ+10deC1SZiQnJiMA3Mp+nccCDjnTg9bGlUneYkpTJgjJzGycPsF5
 ss+M7dzAXYdJ+KP1t4AS+TkDPLeMDop99VVSDd0j43C1YqPYZgyDIZd3UHkee/CneTSZWUgGrGa
 V1iAZgsJ+Ywx/Ri/uHtUp7tQQLTS/AskLc34M8rBSzlhNnBZkWTJkoSYleb4+0YI21O7jQJiXw9
 Mn0bpXFq/i+CQLo/mAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNyBTYWx0ZWRfX7iJFTloEz71c
 nj6R/Q3JTl2m5apCPIbqxD/6oO3sRZozxww382cHqffkUM2A0uGt0AQa/omQ03IRKNuDWTvJQMl
 sClON91R8xIW82loQuguuXLQ1MHWw9Q=
X-Proofpoint-GUID: 31WW3fd6x54RQ8Ed_GcYl7HBtmTpXj9d
X-Authority-Analysis: v=2.4 cv=GN441ONK c=1 sm=1 tr=0 ts=6a6b5af9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=lTvru38uAoNiiYMj3kAA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 31WW3fd6x54RQ8Ed_GcYl7HBtmTpXj9d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300107

Host crypto capability can not be used if CONFIG_MMC_CRYPTO=n.
So set MMC_CAP2_CRYPTO in mmc->caps2 only if CONFIG_MMC_CRYPTO=y.

Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 drivers/mmc/host/mtk-sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 01ea3adbdf3b..c415ed97e3c2 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -3031,7 +3031,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		if (IS_ERR(host->crypto_clk))
 			return PTR_ERR(host->crypto_clk);
 		else if (host->crypto_clk)
+#ifdef CONFIG_MMC_CRYPTO
 			mmc->caps2 |= MMC_CAP2_CRYPTO;
+#else
+			dev_dbg(host->dev, "Enable necessary crypto config\n");
+#endif
 	}
 
 	host->irq = platform_get_irq(pdev, 0);
-- 
2.34.1

