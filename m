Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4BB38836D
	for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775804324; cv=none; b=OqKiON8iOmVCfKnSX16V0gak7VvCZXjz1Xf7ZFQ+ohjhEAbhp/zoieugKxic1EFYWxOnZMqqbRhrhL1AQ5DZ6rjsHQHF1wd9J+Oh4v8cUhQOmjjsy6RmW2hSAyDojrQcjpGi1Z2fOOX6RDaltpna3FmW4MQV3/F6umwy7jK+JKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775804324; c=relaxed/simple;
	bh=hnYKIDCRQOxEBVlFTcHqpJxqYH5vnq7RHHs5Ebb1Ybo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ulPq4SKHTxpkQPvmm2owYSF1LCXMxS/t4vJQHBDtaFF/e4anaUTgNotKTcKZCiKKEwwebufIPw31GAQRXxHJk2XMFAQGb0je0T/xYw5cAjni8OTx00wWkU4wqcFlhVEJ1JLgXPepNxKwB5u40T4g9cn2AATgzFfrY0rAI7Fc1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N639SMMv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XWaOo+qc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N639SMMv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XWaOo+qc"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A24e40115016
	for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 06:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2ga0uhkKrN3dwtYVwyFTuYZAFChPPjjvvUy
	2WCvfTbo=; b=N639SMMvuVPyu68jblqx3MmzfR93mlVCAgzix/ZhfBPdkuJTXux
	0EAzHEw825i/LZSVZRXu8V89eqXbx51YM9ljKz28DePqcNQTOuxCDEBzVnUJy123
	KwrtNpDDvCjovWwF0wt0JlEWjFHePZng+EYlgzdKBLbXaDiVTu2vMSH2M5MIGNiM
	dC5iN7d7ONvrmPxe3e4KQkFg4iFzlmNx23z8UDkg5QvK5tpS+P6mLrmUykfWyaBd
	fIuTm7/Ijk3LZFV6LeIlVxulUDNJV8xHnnkTuELTy7jTTh0J2rNnWBK5Ctd2g4D+
	BfP+tzzZ9kPU96ypO/s1n7DLtPIx1o9p5KQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8xaq38-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 06:58:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b0c30b51bfso30645665ad.0
        for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2026 23:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775804319; x=1776409119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ga0uhkKrN3dwtYVwyFTuYZAFChPPjjvvUy2WCvfTbo=;
        b=XWaOo+qcm7omoH2HLJSv60uO0OsITDx4gyzRcQthk1gUEGTO5LgPkgn8I9L+/60LbM
         ZHnB222E6Q0EnIkIy2DaygErOKRxlhtynz1uau+6MD6MjyfZ17XZBek1JRWIyjBHFe+w
         xxv5uveLi63l25+KERm3BqdbcVZQBAlOSx0c1ozxkvaOCzNXF3i0PXGF3WtLpk61WrvU
         x4MszZ7kfn1mrflXvqfIXHm0HkLXONBqW/Ir4UiyACSgbPvlrLxe9SkmNokeu6/AsSXr
         j76R93KiKHVgTpmcQgf0ZZwW3Q5rjmSOH9RlznyHrqgI8Tr34QvDiA1mceJ9yslSdPtM
         Q8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775804319; x=1776409119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ga0uhkKrN3dwtYVwyFTuYZAFChPPjjvvUy2WCvfTbo=;
        b=P0a3V4EsOsjXjYoqlXbQx0nxb6ESqofeJP2BvKv+nDHYGCF+x3gQx1MAxvwPbcNcR5
         Xa1LZZm/217bEcALU5kZaT++nrnXywMVnZSWUyId9/oxkP3Ri03aY8kW3wd8AN2y0p44
         jOf3kqJ5LfnobsjWMXTfBYrXgqXICcWfKba4tnu0g5IXHCGRKHdahhkOa7AJW8bW9NuT
         +oz+sfTo4JShl6uvK8WKU+tQXE+luUTTyLFeN5xkZzlbJUXFNCHHZAgIgwu8MYlA4+bw
         Q4XHIxekkqwtHTg26ww+Zo8BwU63seXkFhll6QGk8r3wyJoxtI95QWYGYUWAkCu3SETo
         hTYw==
X-Gm-Message-State: AOJu0YyPKyofDQOtGzN4jTDexd4aLOsBbMplhPoLNkNc/9Sy7FaQab32
	alAH20ggvF4FjoMO+cth4f4pm9skTvzV4kUrmvqeYeXpQCSAPiDnoFReeHoTEqdsTGGPupUnKoc
	l6o1kBX4Yz1arQB7jPsLPpCezVgfG5DZdkkFUBr3Z3qlnPUQbvEz2e08fAc3V+Po=
X-Gm-Gg: AeBDievSM+ONlnKJZKR71wvkzryuB51E1qYQn8T1Ip1CQKFHqiOvDpjibJqavRk+nPx
	nh+hSsHnxo1iyq1UKJHBoDr4YRpanBesWnGCIx+PwkQERCQeXR1h/jq1XGw7yzj0DBG7FzxIjUN
	00Mt8eku69vOmJvj+OvMEKbBS5jHYSCrfbrLaMKZJw0X5nGT10ccM8zd3rULThMoMIDxcPwdEEN
	kb/8eR+VSEIvRT2EU7DAvStLuk6jYqM6eoRhKn4NuGfoXVc1GDuLYM+F7cgSiwjipQAENCgOP1W
	nn9WuSV+fuprsjHFhYfQf499ZQua4gtr1B3jqcL52T8apqlMT9rqe66R0UcohWAElUn9cibSYRO
	uv8Zc323oTJ7T1PkVMC/nAq3D6E+4HRflP8i0edjBXqHolrMH2uaJ
X-Received: by 2002:a17:903:1a8f:b0:2b0:7531:b61e with SMTP id d9443c01a7336-2b2d5a64f08mr20389765ad.41.1775804318981;
        Thu, 09 Apr 2026 23:58:38 -0700 (PDT)
X-Received: by 2002:a17:903:1a8f:b0:2b0:7531:b61e with SMTP id d9443c01a7336-2b2d5a64f08mr20389505ad.41.1775804318464;
        Thu, 09 Apr 2026 23:58:38 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f43994sm17645835ad.80.2026.04.09.23.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 23:58:37 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: adrian.hunter@intel.com, ebiggers@kernel.org, abel.vesa@linaro.org,
        ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v2] mmc: host: sdhci-msm: Fix the wrapped key handling
Date: Fri, 10 Apr 2026 12:28:33 +0530
Message-Id: <20260410065833.3189808-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA2MyBTYWx0ZWRfX243CZETpKqTo
 AQ7EvV2ZysZCDBMzVq6sinh37puK/E7HEuQZ19kEXUVjC98kYV40oCGyCebOLdtvukVDPAwOyrC
 Ajdu91kjaKLwkpMYTLXzqbS8nx6rBZTl01r9KFzTfdVp211uVCCOV/aFglLLeLZnZAmh3ugnL8B
 K3bQlmVFfZ/K4h/MAyZW6+kVkoSXLpLDVa0WRVg/yVfwthyifqZhs9a+vaLaNmqdkcR8UE+T6tF
 aymbAVc9k0ejKyoQ2TeJJiqUCsLo+MvL92+09khdlOgIVFpGcUX1h/Ljz7i8IXmlRxuUAnzUYCl
 K3Q1qqlNWNjiMsgnoAAVYzW88fwUdvkVjUeTeexFrtTrFR4lD9ZOgILdhVA0AJCLv3OJ7QF+52l
 a0qRs7PSePTpVK9QJz4UADqM1EB23qNr+qKtG7HVZqWsX9Enxr8SanibQ5h2YMW9YDWkeO3SiTo
 8Nw4lcqhlFa7nYa0Zcw==
X-Proofpoint-GUID: h3HncFUa45kQB6JIcJg4mM2gfFmO3X-a
X-Proofpoint-ORIG-GUID: h3HncFUa45kQB6JIcJg4mM2gfFmO3X-a
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d89fa0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=REOQkW6a7pLLFZWo_7YA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100063

Inline Crypto Engine (ICE) supports wrapped key generation.
While registering crypto profile the supported key types are queried
from ICE driver. So the explicit check for RAW key is not needed.

Fixes: fd78e2b582a0 ("mmc: sdhci-msm: Add support for wrapped keys")
Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>

---
The patch series "mmc: host: sdhci-msm: Add support for wrapped keys"
was originally discussed here: https://lore.kernel.org/all/CAPDyKFqRG1_1aYavfrA0Ss85B0kcTnjVBeqLgq8PUJUcSx5LUg@mail.gmail.com/

Changes in v2:
- Updated the commit message.
- Added the "Fixes:" tag.

Changes in v1:
- Initial changes to fix wrapped key support.
- Link to v1 https://lore.kernel.org/all/20260403105949.1007447-1-neeraj.soni@oss.qualcomm.com/
---
 drivers/mmc/host/sdhci-msm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index da356627d9de..df0a038269d4 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1926,11 +1926,6 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	if (IS_ERR_OR_NULL(ice))
 		return PTR_ERR_OR_ZERO(ice);
 
-	if (qcom_ice_get_supported_key_type(ice) != BLK_CRYPTO_KEY_TYPE_RAW) {
-		dev_warn(dev, "Wrapped keys not supported. Disabling inline encryption support.\n");
-		return 0;
-	}
-
 	msm_host->ice = ice;
 
 	/* Initialize the blk_crypto_profile */
-- 
2.34.1

