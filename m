Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ADC315D2B
	for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2025 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228658; cv=none; b=fz1YToASTU9US0r02LigIZwo4MYhNkoFPdT4gk6SqFX81DmoXVqZxSVKCgxAJi8CRiPTOS9sWVdNplIFNU06IFouVYwPPRZUb3saMOGq/WKamKxWFqQ17YPCZEa2mNu32xwB/dhYyh32VCfbtzMKbY4W9c+VvMYdLWP6gerrnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228658; c=relaxed/simple;
	bh=/HqXxzUq6RnJYu48ZoJP0fcWuWCt+4vybB3tnbONtlE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wj7go46J59TwY8Hv77gqEgm+3qv1CBe4IrKuLrCUSDsHuNX7zz4LoiZJ5SiQkykWiBlvhWyxEmuYgDs25/o68HrpvvxHf/0bxvQQkvHXoAlgUNfadoAWhHB7Tb7q2Yh6L39zgbuzHmg24YXOprjdL1Pk3fDPYA9LE73aR4eQFno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VVtmayMz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rv1XXYjR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VVtmayMz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rv1XXYjR"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR24rAV3840085
	for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2025 07:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oqFyPtIZkLJnIdiBLjjAW8uXCSO1QldO+0G
	b72ywrxM=; b=VVtmayMzHr6xessuybatzysEI6SlKlmrCykGiPEwq0jMfjSEjvN
	rAuopbAu+HyVOthoc+SxeGyjiMn9zhUqB2Q2O0Gvh9ePDbxrVVYj5xMiiNLXZyOI
	pf3XIaf7CQY+h5u0yyW2WA0gf+QPgo46XRNr0fsUj2kUVWn84Gu3H2E2O1SqMRD5
	hkVMS7F+ygi706WTSBpQjHNwvlSJx+h4uLX0obiWhEPnndCQ1RxygaDO0Btx/Q++
	KJcT6rtzO6Kewr2ESZ993jNpAV8EM1cpyUdD6LULLWcYLaXrZ46dvCcnvJp0NM7I
	Wi3z+OqwKY3FxyzALlCABhGUjU5EUz+m6Qw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apdj08rsh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2025 07:30:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297dde580c8so18103415ad.1
        for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 23:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764228654; x=1764833454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oqFyPtIZkLJnIdiBLjjAW8uXCSO1QldO+0Gb72ywrxM=;
        b=Rv1XXYjR4JXMxzrRMNmQwPB+PL6+Pl2zexkU/4HlIlAlgrMrppwzE0aoVTzhop4lvK
         U0FNgKYGiF3XvH/kjl82lcEy7lCrhKIBzzaqFNAJ7CUpOJ7MQtRRqbWb27Yp62REulL/
         F9axvOC8VLISenDwEAPUZ9tQd33c0+6R6cTGQYlLedRkd9HzGWZyIKkgeQmBXfpCJ5cj
         +bCdpB1Dvf25ogzv7tjS4jAOJ794bHZYw+U7FqsEHlemboOt4MwpbxIpErn1HssI/NEj
         jYpIm8Z5LnLRDZP1g+jdaPeYZUBl4xGmV2Kp1msmw4pyCHENxRUE980+p1Sk3rNmqInX
         jr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764228654; x=1764833454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqFyPtIZkLJnIdiBLjjAW8uXCSO1QldO+0Gb72ywrxM=;
        b=q7EcGGzvLcH7HYbptFYZ8Iyu3N5Uus6KHcmu1lNoNRbFHowoYfdCron1uTg7qcLfZy
         i/JoeMbW9iNYyMg1OEykzVwyQLSU/Mnyyi2xo3+1priSBTkqTNG8iNeNLWte5/Z14eRV
         Qid5MESQ9LXrLS+IhYIgWcihZbX2DMwCtWsJgB3PgWn4VbCF1WEpOrWAooJxnelFIjzT
         V3bHI5i497Ls5HT9ctT/FthqQDRVg3RBL/tlXuQ/bInosWU3CYoXw9yy0RdroA8C5fx4
         XnuS9jVdKhcrvlp8+D74ez8IHvKNr/tYmsdOLuZIgrqV9WCvHJb9VnWZc2BAKzujBFju
         tHmQ==
X-Gm-Message-State: AOJu0Yz1s+Yy6mZMRvO3tJxQiXn92FSIKLGfoaqp9coShyIaeL9+DD9a
	N5v+ijBQG0GwwX8UYPfVPwGf+wAmJXZvO6bNjt6v7HaVUAGKMkObIYuvi0pfae5LUov/8ZPvPO9
	FaFXFLCPhQoGEVIt8Dqxvg1MScI0cro6HP4Ci5D6qDzfoIbcDxhR6dlM3MSC/RG0=
X-Gm-Gg: ASbGncsy7bZThQi+UduYIsru8Ma4/Hea+bvf0u4Sjp1jmY5t+pThrRoIBm7L3amP+JT
	zvgpHh63iwyf260MnVWBT/8I6fHJchXud/LD3faLSQwAo3DRmsQW81xny9eo2lRyDPZ0qRJvv0V
	n+VkhaRpy/fW5bmXQuU48Oy/RizQ4dNIjW9z//M23Zb4crP99Nt9kUKU8ix8K1oUZc1N/j37n0z
	vMkhyPg/GfoZp5CmArcx6L39ov3fGXo+ddXedCRv3wBmgM49KxZtx1IT3dyXDRWz2WkVw+MdKqk
	3XnIokWbbleJCTdfPbjdcnetzb1PN04V6HGgBEhHjv00yUay7gP/0InjXsUGewKy7FbzkMG6czU
	4CSj1kHSgoNDzqiXPvsZl77AwSP5FBSnDqCYB1zfc
X-Received: by 2002:a17:903:3b86:b0:297:e59c:63cc with SMTP id d9443c01a7336-29bab148c59mr115917805ad.35.1764228653629;
        Wed, 26 Nov 2025 23:30:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3AgkPTp+z2F6CoIMkOpiaOZow5qFjiecrr/JEgR34HUl/1xnIxTVopp+SGDfG6wqyDb46rg==
X-Received: by 2002:a17:903:3b86:b0:297:e59c:63cc with SMTP id d9443c01a7336-29bab148c59mr115917545ad.35.1764228653128;
        Wed, 26 Nov 2025 23:30:53 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb7d4f4sm7621775ad.101.2025.11.26.23.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:30:52 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, ebiggers@kernel.org,
        abel.vesa@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v2] mmc: host: sdhci-msm: Add support for wrapped keys
Date: Thu, 27 Nov 2025 13:00:48 +0530
Message-Id: <20251127073048.2759159-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDA1MyBTYWx0ZWRfX9jL9Gu4z7FRz
 K4rvPtEEuo62SqbRJ70xWeiire4/ejdCUlPYj1d16Va63f/40GcGaPlF+zzNQzvwKIAhIkeNdJ4
 tyScFg7OrdAtocwlP11+jYt6W4ayM3ZnT+22AMTNY00BEAvPSpm8dRfI3rQtI5kNFvjC/S3B1r5
 5aLrf8F/4dn4vi2XsZbyiTRFSHFyJBnw+ghKmjz1/ji5FAX6Ci8GIDMJqclRCbDmsqsDjbQrK11
 O9sWfrGgtAjHIXKXxtisbPIq0sMd+5olgxgpA8DExXE16A+cwkfJ+AYjVn5JFeAIMtGJg19A3E6
 uzhrxCOB7onrSEiUH4wg3dtakJzTCEwGzvJUEJnJqRO3it4QurdcYrw3EUb7dql9UcuJ1Zl/W0C
 Y1oY39KV7bdIpWRgzX0vm6sbuvhUBw==
X-Proofpoint-GUID: VuK9FjoUBdC2ZV9moxhaPV4nE8BMQRmE
X-Proofpoint-ORIG-GUID: VuK9FjoUBdC2ZV9moxhaPV4nE8BMQRmE
X-Authority-Analysis: v=2.4 cv=PJoCOPqC c=1 sm=1 tr=0 ts=6927fe2f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ZyxRHT4sbPtUm1NgsYkA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270053

Add the wrapped key support for sdhci-msm by implementing the needed
methods in struct blk_crypto_ll_ops and setting the appropriate flag in
blk_crypto_profile::key_types_supported.

---
This is a reworked version of the patchset
https://lore.kernel.org/all/20241101031539.13285-1-quic_spuppala@quicinc.com/
that was sent by Seshu Madhavi Puppala.

My changes rebase it to use the custom crypto profile support.

Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---

Changes in v2:
- Updated commit message for clarity.

Changes in v1:
- Added initial support for wrapped keys.
---
 drivers/mmc/host/sdhci-msm.c | 51 +++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4e5edbf2fc9b..351f2a77068b 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1911,11 +1911,6 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	if (IS_ERR_OR_NULL(ice))
 		return PTR_ERR_OR_ZERO(ice);
 
-	if (qcom_ice_get_supported_key_type(ice) != BLK_CRYPTO_KEY_TYPE_RAW) {
-		dev_warn(dev, "Wrapped keys not supported. Disabling inline encryption support.\n");
-		return 0;
-	}
-
 	msm_host->ice = ice;
 
 	/* Initialize the blk_crypto_profile */
@@ -1929,7 +1924,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 
 	profile->ll_ops = sdhci_msm_crypto_ops;
 	profile->max_dun_bytes_supported = 4;
-	profile->key_types_supported = BLK_CRYPTO_KEY_TYPE_RAW;
+	profile->key_types_supported = qcom_ice_get_supported_key_type(ice);
 	profile->dev = dev;
 
 	/*
@@ -2009,9 +2004,53 @@ static int sdhci_msm_ice_keyslot_evict(struct blk_crypto_profile *profile,
 	return qcom_ice_evict_key(msm_host->ice, slot);
 }
 
+static int sdhci_msm_ice_derive_sw_secret(struct blk_crypto_profile *profile,
+					  const u8 *eph_key, size_t eph_key_size,
+					  u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	struct sdhci_msm_host *msm_host =
+		sdhci_msm_host_from_crypto_profile(profile);
+
+	return qcom_ice_derive_sw_secret(msm_host->ice, eph_key, eph_key_size,
+					sw_secret);
+}
+
+static int sdhci_msm_ice_import_key(struct blk_crypto_profile *profile,
+				    const u8 *raw_key, size_t raw_key_size,
+				    u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct sdhci_msm_host *msm_host =
+		sdhci_msm_host_from_crypto_profile(profile);
+
+	return qcom_ice_import_key(msm_host->ice, raw_key, raw_key_size, lt_key);
+}
+
+static int sdhci_msm_ice_generate_key(struct blk_crypto_profile *profile,
+				      u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct sdhci_msm_host *msm_host =
+		sdhci_msm_host_from_crypto_profile(profile);
+
+	return qcom_ice_generate_key(msm_host->ice, lt_key);
+}
+
+static int sdhci_msm_ice_prepare_key(struct blk_crypto_profile *profile,
+				     const u8 *lt_key, size_t lt_key_size,
+				     u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct sdhci_msm_host *msm_host =
+		sdhci_msm_host_from_crypto_profile(profile);
+
+	return qcom_ice_prepare_key(msm_host->ice, lt_key, lt_key_size, eph_key);
+}
+
 static const struct blk_crypto_ll_ops sdhci_msm_crypto_ops = {
 	.keyslot_program	= sdhci_msm_ice_keyslot_program,
 	.keyslot_evict		= sdhci_msm_ice_keyslot_evict,
+	.derive_sw_secret	= sdhci_msm_ice_derive_sw_secret,
+	.import_key		= sdhci_msm_ice_import_key,
+	.generate_key		= sdhci_msm_ice_generate_key,
+	.prepare_key		= sdhci_msm_ice_prepare_key,
 };
 
 #else /* CONFIG_MMC_CRYPTO */
-- 
2.34.1

