Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B0A3F4DEB
	for <linux-mmc@vger.kernel.org>; Wed, 26 Aug 2026 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737953; cv=none; b=iozeis1qiq1mvxlnpmbj2/jqKTZyg57ufCjd7+RdSbMKfuUkuWZRmGQLF+2lrlxyNdmxMzLhBgnUiA2dENpMLWtdf9P5dNah1isEtIA/Hia1XRu9rk07qtBmOUEo1riq+ghMtdlmU8Ne/C1lpibKeIe2okgWFgio9ksXFxp6zTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737953; c=relaxed/simple;
	bh=adkMKR1iXVx+DwmZ3065YpyXhuugVWY0+cU+LJwva4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IqnDFZ+7a7pxyZJE4iSs0Bkn76k+FDCVqP30R4j4CMnfDm2lSPfywjdcvaMlF17OxEWoaaSJZMDY8Ff1Co2YY0OP8eBUMyQcLC8Oj0DOqOllCODIETwJkPlkFGbHphtPqLePpq6VpUtC0tcCtutNWvi7Yq4W0+8ZxePPdZS3pDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D3cRx8Hn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TWya9nvm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D3cRx8Hn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TWya9nvm"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q9CfVW500922
	for <linux-mmc@vger.kernel.org>; Wed, 26 Aug 2026 09:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rb0nIYYamBu
	gMkUBgoIqbypSuVTrhDhDqU1MT4y2vJo=; b=D3cRx8HniHZnBJj9V9jZT/zl9zl
	0tWvrA41ZOzraB1SrDgT0nPg87/3EUgP0vWISGbdJHIsndFqyyZUQRnhpCtChHaI
	8pwE5ZJdw4NtCvHDlUHixS33rz2wn+sh1Wyh2v+wW9Ik/dciTiC+iH4Z/RfBLJzY
	HN7qo0sa8BUDB0Fze8PhWsScMfQpH824LOho2/fYJeq4tHOWrVTeiClRFTnp5DSx
	29QG02pDi+SNvsLdr+WRQQZNFB72z8o6DOs+ZCwtt7Wfv96uhF450xf5jz8+YRie
	rvaBaJ8w5jwsHG3gafJZxmC+teBLNVrLz5NmG3gcXsniatEH5yejwCmUphg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9g4mu2f6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 26 Aug 2026 09:52:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39533bb224cso1531370a91.3
        for <linux-mmc@vger.kernel.org>; Wed, 26 Aug 2026 02:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787737950; x=1788342750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rb0nIYYamBugMkUBgoIqbypSuVTrhDhDqU1MT4y2vJo=;
        b=TWya9nvmJgB1G4G0T2fqMQOF5HqHPlbhegH0+4UHVdYGSnVM9nMlfcHgnr1KjUbSP7
         aSrNXhnBe4szKa2E14cdn5p1X7MSn0NcTqqsG7Md337Hh+GQxkiRrU99Pa2oPahbIOnJ
         vu+UmpbCzD6uEFL/qmMbfhYmooEaMyTDhbVrDYIXZ8Zz1CRKuHl3lHuDmyHgTlPWglu+
         maaEp2Pue3UX9nHFIwbFYy48VpSbJvz/pgOJOF7PK2cQ0bR+BWCFPoPOPiZA4GIsTTa4
         euFgYhPSsKh+sIkfbfJd9vwP9PfM5rCBhf9x8KRk7G03DPasPR71MFp8o6Y4c/aJxQbM
         wKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787737950; x=1788342750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rb0nIYYamBugMkUBgoIqbypSuVTrhDhDqU1MT4y2vJo=;
        b=pPhTyH60qgVlvm0NPi6Ckf8gFJgm6U1cFD1LkjOKajckfW+XdQPaJ3JGFZgafpQQ11
         MdJCsPEnCzmCRaQ8tMe6nuzk0bXp5D4x0TLz5LxbeMB1Dgf5uf3QvA/aakXEvLyT3DPi
         8iGKdORbW4j+fPHgEfmjjphZydrPzD6GtqdBF+ju8BuFqZrGiatuXldI7OSC2gbuwtUp
         gcmiYhNJ68Ku8QzqnZnqHyFK/ic1c4Cyv0PqH7DJ32y6JnGXVxxTGWubvp78McWXhYlr
         979L6TaP2Bq3KKOzgqD7nN3UqN51R2YIKcfrpdOjBTeu8a2Szs6Xe8mf5D6GNa9KaJ53
         gU6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpdtLrrlbMIAZZIENjQqrqIc1EKoptfcNaAkNjOjjcbKiZfbvbKoqEtcs/EK7ZeEDdNUfs6FxH7j/k=@vger.kernel.org
X-Gm-Message-State: AFuF++l8CXjbr3fx+nj1t8r5WFlfG909Fp+HcKlQzWatqG/9fPBuOTxh
	d722HKJWw79zhZODVPOIY0UXEqkTcGct/UNyie0eae8Tf3P3WSip57ieZAWFrS+tOwQn3ksMyXn
	unK+rt5mdlfmE53vxBMoVvOWzmZj5silT9sZNh2pJOEmWYWH2L9QUh/IQIqerdWuSCk80J5U=
X-Gm-Gg: AR+sD11O/OLqAsR7rqkYoNixC067JAGPhlVPvHVq1zGwbFM5983D12HKKmoPO213wGK
	jd1RqTTD5IIH4t4RFm4pKwLSZXbez6mmHNdgZXbcu+csmY8GJtg4SInkjBYZRjYri0qzAHt3Dok
	5D7Ldt4Nkjpw5jezjmn9tZaLmGUZbU1nogB9I4KWRLk36OAiVTmLJCw8B8dZe4Da7Ow8JVCXuj3
	DlQTfe5taPKNLJCNundXovHNFUsHyjYKSWYQhE/zHDSnxKkZqWfKeEHhgjAw+04kamT7fTAwhq6
	ePDIuXm4Qfc8k5cm1ZAisCzphktk5XG0QqNgiehcRwzhMy9cEWOq2TRp5mvM0idjpOTMnl9SfQd
	BtS9vVD/LfwkLbrAFrenlXmsVxeOd3gA=
X-Received: by 2002:a17:90b:1809:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-3966d199247mr11051973a91.5.1787737950460;
        Wed, 26 Aug 2026 02:52:30 -0700 (PDT)
X-Received: by 2002:a17:90b:1809:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-3966d199247mr11051885a91.5.1787737950031;
        Wed, 26 Aug 2026 02:52:30 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eefd98sm12587158c88.3.2026.08.26.02.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 02:52:29 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ebiggers@kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v8 1/2] mmc: Allow host driver to control the re-programming of crypto keys
Date: Wed, 26 Aug 2026 15:22:16 +0530
Message-Id: <20260826095217.2885229-2-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826095217.2885229-1-neeraj.soni@oss.qualcomm.com>
References: <20260826095217.2885229-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA4MSBTYWx0ZWRfXzSBCZsqtRkFs
 mUCEukQh8RPnqo1O1vM0FYUPGD7nOc8hWbaD8isnHwuoQKriINTst1k0oHzEo2fqaC42XwxlGjK
 eZdEKfvSwbBgjH2ZXkxX5cBYBVS3awc=
X-Proofpoint-ORIG-GUID: BrL4GhGL2JgHGyHEb50piqt-6O7hegU7
X-Authority-Analysis: v=2.4 cv=eYgNubEH c=1 sm=1 tr=0 ts=6a8eb75f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=COk6AnOGAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gPkh30t4SdGlgi7DwewA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA4MSBTYWx0ZWRfXxWn594JpgvC3
 11D6P9HHUvh2NwAcxIOqecI+OcIsqTcY2EmN1vP64f6b8qBJK6BCL4GXoTdR6oCqi9q6Mrs6tW7
 fiGEP9x+fYN1c+BR3VpO9itonFC4WOSIv39SZt+8qK1DVASIrbD/42dzKXw8JuS0hth5AUpEsKT
 wnxa/Vvqj3+z7XJMJvVBxSZo5jN+B6qbkLjuOuVDzz6B3eqREkwNO4GZLgWJJXMcVTDM1HnV+r9
 nGBDUou7BD34rxvMZstYWvyltIfQlsexdD91bLXr3aC3JjPpQkHG0hzqm7mHVVwDGJggnIFm7g5
 85qR235Lg8DfME3rWNIue/5FJYtN8cVyhbR0YJQ6c9cGvmjsnMKCrUCmEK1dlRiiuPFLS8Ikvg4
 HH36k2m2bPevZO9Yse2+4+9JBrzO+sN5+24+AwGQCU+/yFgbR27ti101PuhulJsaTGArqLFJAjy
 4i/xuWW/DuueyANoOpg==
X-Proofpoint-GUID: BrL4GhGL2JgHGyHEb50piqt-6O7hegU7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260081

The register context for the crypto profile belongs to the
sdhci/cqhci host and not the mmc card, hence re-programming should be
managed by the host driver itself.

Add the flag MMC_CAP2_CRYPTO_NO_REPROG as part of host->caps2 to control
reprogramming keys to crypto engine for SoCs which do not require this
feature.

Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---
 drivers/mmc/core/crypto.c | 2 +-
 include/linux/mmc/host.h  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
index fec4fbf16a5b..a5a90bfc634e 100644
--- a/drivers/mmc/core/crypto.c
+++ b/drivers/mmc/core/crypto.c
@@ -15,7 +15,7 @@
 void mmc_crypto_set_initial_state(struct mmc_host *host)
 {
 	/* Reset might clear all keys, so reprogram all the keys. */
-	if (host->caps2 & MMC_CAP2_CRYPTO)
+	if ((host->caps2 & MMC_CAP2_CRYPTO) && !(host->caps2 & MMC_CAP2_CRYPTO_NO_REPROG))
 		blk_crypto_reprogram_all_keys(&host->crypto_profile);
 }
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba84f02c2a10..3c3c45fdf39b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -463,6 +463,7 @@ struct mmc_host {
 #define MMC_CAP2_CRYPTO		0
 #endif
 #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
+#define MMC_CAP2_CRYPTO_NO_REPROG (1 << 29)	/* Host handles inline crypto key reprogramming */
 
 	bool			uhs2_sd_tran;	/* UHS-II flag for SD_TRAN state */
 	bool			uhs2_app_cmd;	/* UHS-II flag for APP command */
-- 
2.34.1

