Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489523;
	b=5SkDc1/aeI2afZpRDAuxMohlZdCFUrJ/6KH86pr3fyg63yQogJd/ZalEqOfBTZmpTGke
	 j8/nLzwVTtPikMcGObPsldFc/1Rihyj5FDVEfRHYn5L04/AgTrWlq2sXMRiSRMzRb0oJr
	 DASsPvfPdkEVkYp64zR57nIqHKKSOkuggNLTwtuztcyvOT/aee50Sor7hljo92bofNUl2
	 eVsMWfqf6JwIXwDKBJmhNS8rkbvJJo074EvnCqkEPpkt/xU8kiJ/Lr+glEpQCYzSTfPor
	 BZOrgl2Pupbbs4s83cqBJvbLxBjqpzcElKEuTUCvnNhyOpawFHcxtM8VQgLm3v7SZBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489523;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xDEmza0Qe9pJQ58rhzT7ekkhyxXls7BABB13DbC82WM=;
	b=qs46YkYYoClrAFJeqz2q/s8M8AR+d1mo/vdn/Xc7NAPRyjxn1vK9K4hRCdK5K47E6x1/
	 Pvq1Tpp5bl/Gnb1JlcuYfJVwbyzkSPgiEjKjdsGGypXuV+8BJx9mZ1fhJgztIkQC92hL9
	 9N5dC61ZnDYMTh9MuFyRfKbKGHRhCR4LM3A1CEoh1oq8UZ9/ryQzqSPR2xQoGxuNXEHAr
	 qDqGA2vnWqnZCLO/lYnXbhIbzk5Nr2N8/gxUsWZ/uF2LUTcIUgyqm+u6tX9I2MyfB2bl7
	 nNOgxASRy5d0UeUK7qT1EdCq1/LhfIhYTsW+R9NYSWnClQOU8gvyIYrG+YGlDqM/82Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LffXCecn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SWBDeRP8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF3606A887
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 13:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83FF3606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LffXCecn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SWBDeRP8
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACAfO6x1954149
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 13:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xDEmza0Qe9pJQ58rhzT7ekkhyxXls7BABB13DbC82WM=; b=LffXCecnLuJWqkaX
	PCbiL/5J8Ih6Nxs/UP+CM7vECT9iwbAmKiFfeFPO12z5LGnjJajgdzsk2gtFebYp
	U0rdm6tLuNp5+jMuWyvM4wQYTMiy0pdN827kml8cRdOeY2M4HaymFJvYnogx9amI
	yUDzL5DHjUFd5Qvm/b3LyIQuNrfdBAOar8dQP0FfMRRyNlRDZRQfE2t/ysee8Pu7
	qnnT0TVJhKIItAMCA2/9Hgp5/GYXCUpUs3VXq5EdDQcd6OlUjzbkC1sGOafp6B5w
	Q1bB0vvI7qeP/N9vOvQYfC41VaHS8VgET40kuTx3DRmgDPAcxD+minMxKeXVMO6s
	n3aO7g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbx30gu4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 13:18:42 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36f26e6abe9so6208448eec.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 05:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794489522; x=1795094322; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xDEmza0Qe9pJQ58rhzT7ekkhyxXls7BABB13DbC82WM=;
        b=SWBDeRP8HGmaYKgTOP7Tl/ctYB7/Df/nWGfpcbuwDaChWRnZyRSRVXT2MUj9YFCSxd
         T9cdZcoVwVvGTWAIioje60FrWIJfcG0pob3TPf1Lcba4p/PSFnMiutLPe1Ui7ZgYo70v
         RbK9/MhofnTpQuA/ia0sd+FFvzR825xL58i38TcxDXnzNT3pvI9/pB9Gw0w0EGPwoWVW
         Eif7y0BaPcIqCe3jNnTVIA2jyiKKhmjy3HKhjdFHtc0mnWfhcxom1A13q41uAFIjGGaF
         wV/IrOMsMfrpYdu/IMEaPI7WBWSmF3uqcAL2We5wOFHnU9CpX3ybUVPTnwESH3/Xzu1s
         22zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489522; x=1795094322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDEmza0Qe9pJQ58rhzT7ekkhyxXls7BABB13DbC82WM=;
        b=iqDfrRGRsYx6GtLvNubsutuFUygmMorAnBeyv0gVfdBdd/GRr0KBfxM4vyaKnc0GPB
         d4eWmBU2rihUJHQpqzN5v7JJosE8jg5cLM21UGb9NdIhRzsyKfVXG78RWGpq7Xw6p7EH
         v6RFIRCGUfNiN2zFQIfDo7XDpS3TS+bUOouXA+FH+P2HKQxK7HZYVGxEV5na+ew8djOq
         4W1fRdjrpSHqmGu+lT2QUN3+bS3Z0j9zSshSWVja+xJjgjB6uwgRoKsHNvKGQ8SC3fwZ
         5PafT1iXLfVHBIO+QdrPFBUzjrNkHB/ohz0bYWz4jMGrJ/1CrLY+R+G0gBBfeglKAt3D
         +/cA==
X-Forwarded-Encrypted: i=1; AL+hErHrbP6NnMJc9QI4zmfge6kd1icIu8WWXoY/p5ynL8FvKdhG4cIQ+lIiuFOR3hE/DQLRuMG3njjQc9Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oTIl8xKOrjHxuMjKRH+FC4x/OSKoohV3/5siXp4aZ2sPOenCn
	PrX9B0YnfD/xG0XyPah5t5XfBw8elAK8LvTEQ/j3dAR3oc8mFcLk/aolMjlLf0Dja1t1QnJ+81F
	El3TFk76oMuI0aDZ1Mf2j+lWY9AN4vsbPcSqRo7ed4d2F4mmXM4C1BSE8vWpDq3E=
X-Gm-Gg: AYBFou0tfIneiVlbrJirQLOBzAo29rWMAf8OnwrVT/ak45RvK7RIa5up580EAziJai6
	IGKNng8e1d/69nBaXnhn0WmiBYooh/nk3DO0vIOdszwRwXkR9vvldG9skGYjk83YeNWlUOwe4W1
	JDOq1D+Teho4wvVubDSwIT+wkNd4231LNSrVS3bTcED5wiMvz5rJmOfLnvBdsB8kZNB+YFfDBx4
	YTO9tVpeQ3CFlJQwoWh9ZAfYzcP6WQVHAXJ6O/hqBNwzIrFYH3xibH6bmFH6OL6w4j0MMyUSFVs
	keviNI9sxeo4fHxgjV4zz7nlwObL73le6UsPSnYoNQZfBZKw/22hJQhEprL4fjMSJkQV9TB2tHK
	u+f5y4QROi1xs4zKa3PJOnNf+x7lJc88KbHUUN6HcsBAkp96iRTUbD04Y5vd+80DvjGgRuC0EaQ
	fNuLs0qFo=
X-Received: by 2002:a05:7301:2311:b0:376:19bd:2af9 with SMTP id 5a478bee46e88-376832816ebmr5975405eec.5.1794489522069;
        Thu, 12 Nov 2026 05:18:42 -0800 (PST)
X-Received: by 2002:a05:7301:2311:b0:376:19bd:2af9 with SMTP id 5a478bee46e88-376832816ebmr5975385eec.5.1794489521438;
        Thu, 12 Nov 2026 05:18:41 -0800 (PST)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e7d24sm43798356eec.22.2026.11.12.05.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:18:41 -0800 (PST)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 18:48:17 +0530
Subject: [PATCH v2 1/2] mmc: sdhci-msm: Enable ICE before enabling crypto
 support
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
Message-Id: <20261112-qcom_ice_pm_enable-v2-1-177e454d6f22@oss.qualcomm.com>
References: <20261112-qcom_ice_pm_enable-v2-0-177e454d6f22@oss.qualcomm.com>
In-Reply-To: <20261112-qcom_ice_pm_enable-v2-0-177e454d6f22@oss.qualcomm.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=S+5MU4sP c=1 sm=1 tr=0 ts=6af5bcb2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jhS48lKipzocA6WHYXAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX+PVMdmxJlqeE
 HeAqhBwuBf1P3eFu5hczMSIMD+V7BEFZA0DhBMrf9tfnCIEtXOXOoDoyIDE3Md/7pfhqilfhaGw
 THBg6GkLCSJO+PhZqCqNwklCYpxBU92SpxVBCcgCs0FFelNSYWd9T70DPYmOQg6EVTKOn961Mg4
 Er6lXGA3NY3prcQob2A5C/c6nPkOkVKQ+0K88/fgabPxwTkoSutGUvPAGUl0PmkCL5LuYA+VmUa
 dsCms2xVxpCc0n6+6EoJB0DDc6LY6L30VooLeg3rSm/vyMMgr+c3XSSBTFW+eG8ZXde9Z85oAUT
 qqgna+isu0mBobBdXpdy9Uhasr2YdUAIFKMVuuQgy8O1Jad8lk8z/eGwSrbZCpVSoOgCrT9GJiU
 IaON9L6lU2F6Izgj3gfMnGZydXp1e/HmU1y8MldextKjNFhWDp3hWuSVAy/D/QA0Syqzu+r4mIq
 hU9OkkYHIRGu/VRW5Bw==
X-Proofpoint-ORIG-GUID: NQtSbA4Lt5Q1P5ZYAHwhvlJIpUbzIUSZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX4NamEptFo1fI
 3z5dPRPwIjioDS8Tvz2c+NuVwurKN53BEugSkqo0lwyO2j+48GIWDTosigoy8n09IZ2IuhJ1W95
 SELJZTZ6Ikiu1JLZ0VqZwQh6skJj9nU=
X-Proofpoint-GUID: NQtSbA4Lt5Q1P5ZYAHwhvlJIpUbzIUSZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120052

sdhci-msm currently exposes MMC crypto profile and sets MMC_CAP2_CRYPTO
before enabling ICE. This leaves a window where blk-crypto can issue
keyslot programming calls before sdhci-msm has explicitly enabled ICE.

Enable ICE during the sdhci-msm crypto early init path which ensures ICE
is ready before blk-crypto can issue key programming calls.

Remove ICE enable call from CQE path, since ICE is now enabled
during SDHCI crypto initialization only.

Fixes: c7eed31e235c ("mmc: sdhci-msm: Switch to the new ICE API")
Cc: stable@vger.kernel.org
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 drivers/mmc/host/sdhci-msm.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 32b1bcba47d6..b3e0356a03ff 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1928,6 +1928,12 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 
 	msm_host->ice = ice;
 
+	err = qcom_ice_enable(msm_host->ice);
+	if (err) {
+		dev_err(dev, "%s: failed to enable ICE: %d\n", __func__, err);
+		return err;
+	}
+
 	/* Initialize the blk_crypto_profile */
 
 	caps.reg_val = cpu_to_le32(cqhci_readl(cq_host, CQHCI_CCAP));
@@ -1963,12 +1969,6 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	return 0;
 }
 
-static void sdhci_msm_ice_enable(struct sdhci_msm_host *msm_host)
-{
-	if (msm_host->mmc->caps2 & MMC_CAP2_CRYPTO)
-		qcom_ice_enable(msm_host->ice);
-}
-
 static int sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
 {
 	if (msm_host->mmc->caps2 & MMC_CAP2_CRYPTO)
@@ -2141,10 +2141,6 @@ static inline int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	return 0;
 }
 
-static inline void sdhci_msm_ice_enable(struct sdhci_msm_host *msm_host)
-{
-}
-
 static inline int
 sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
 {
@@ -2182,12 +2178,7 @@ static u32 sdhci_msm_cqe_irq(struct sdhci_host *host, u32 intmask)
 
 static void sdhci_msm_cqe_enable(struct mmc_host *mmc)
 {
-	struct sdhci_host *host = mmc_priv(mmc);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
-
 	sdhci_cqe_enable(mmc);
-	sdhci_msm_ice_enable(msm_host);
 }
 
 static void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)

-- 
2.34.1

