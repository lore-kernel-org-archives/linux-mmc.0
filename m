Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D292E37F008
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773389756; cv=none; b=VT5H2tByO6tKcLrQLPSskvtnjTl/Gh34mL8T9oRmsT1AXPYBTecARy4RMpo3uGmBZ75HD1a/2FLrSRThuEBcrFDWmezmCcZV4J+cycPtlABDTXLzldDTkrIE1V96XLU3tZURMVCUHDJkmKnJ2thmeGZ3sFon7/ltd27518/7tzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773389756; c=relaxed/simple;
	bh=HtZ7UHaIZ5d4GpPFkpIcr7qnrP+FXUHAis/ov3Tet4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=El5RPN9YoAkm0vACmyeNFUrrgSX1sPY56AbpihPbREpPhcWxIksIwDjv9LfCMNiyaAeb6fl3J0zSTmA7wU0UREe0yHfYxTxq6ZNShywnlUqWeMus7pr59I/VL4SJQadvLEXjHtBMVsJu8CX0V50EumML9LFWFnr7TXkKvgWmVKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n+sZ2bp7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GQtrihuX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n+sZ2bp7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GQtrihuX"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D6oXIM793612
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 08:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xfR7KDCiWXdpXvk8xsnZ6c1wZFLaqKZZVra
	zB8UN08k=; b=n+sZ2bp7B4KzaAUFuTWXGLZRjpqBmhZsyq2vzha5b1j/z9DMLpZ
	0z/WBPFv9K72gqpJ35bBeEP0zg6svVS8K/q5q8hCE0gcWcxY8eeL0rMhSlx2O1lp
	1kQiRTygCWX8sGSGe9JVLAlfDEEVN/no69V2AuRsMvCKUy1/yvGn0xvRTCVtTt/c
	xEYjEpJciziCpsjuXsM1AUkWjVGQe8SYcpV0iBZnEwx4UoCl0cqepy3Yd3SQMF4n
	XfC2DyVJvjabuNdWw499Zt3LR0VpPvfxmrfJbmQdSMkGWjIaFSVT8q38bjleqDXc
	l3Z2MYkWwmVwVsG5dVcFfF2W1utSV4P0NaA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvdnt0apm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 08:15:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-359fe4e9ea7so1668714a91.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773389753; x=1773994553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xfR7KDCiWXdpXvk8xsnZ6c1wZFLaqKZZVrazB8UN08k=;
        b=GQtrihuX4cwCEi9al412MtoV8DuUZ8B1R9l/AOrbapcCQxKRfuwoxNXhvqHuohJ56D
         c7XHk4dbbo9F1B7/ZugkX6wfqSGMB2XA85w4j33gT2nNoZvi9b3FZs54o9N5dEBmJGVc
         zeOTsYlX4ZqMiiewtE4TW5I4H/AlD/rxt+DrhBt6o/mB8HjM15W1GqdWsBgH6E8XSDBb
         Uk5FqMLh+R6fydz4WzfEO0nUE7LNyCJLOWAsmovEVwE35+8oOX7bcgzTl7Nh3k3NTQwK
         JujJ4gmJPQjpL2Pym6wl72wp5YfGQ89JxfK6RPe13XYfWjbINeXJ8plSCDN9jQlG+/Lz
         ZjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773389753; x=1773994553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfR7KDCiWXdpXvk8xsnZ6c1wZFLaqKZZVrazB8UN08k=;
        b=ppwZPYppA/XBUz/pN0WwbrB8i3xrxMYz1tye+VZX2ReZJ3j/YePhh19mtpzDIMU+5C
         /ooJkX3kdPIfc96k7AsYJ5cUwpYc9O+DejTi0laabXS8b87mFPtZQMiybsCsqa4JLS+j
         8SfZaEl3ZVgBRBYHK8qXDk6tXwrnQu+dMxDldHKKj03P1aGdc/DokCxAnMQw45rsxT+N
         olFskxCCHm7+FM61SQSAXyajRKWDft6D3fZA+M05UKKA1li+m5PBXtzL0zDm0w/T9KU7
         zxdCV2/zJv0j033pznECoCY7csHWXBWmDoJoyettBRFcLLqTTh7cfoKZBK92AnDymuS/
         sDTg==
X-Gm-Message-State: AOJu0YzzCv5/3Zcui549fc9m3F86Ur08unK2OkGhTPcQVXWXxE/aED6B
	9dY+O3+JMLibqOg5P46PbzpHtlkcggiQXBACYZhouczUBZKtZoYZuXKHWecpUQ4oKekijwnghEx
	MxfxGwk5ZeZhhN8f9piJZs9UUaMs8v5zyHkeqrTG7bq+RnmAEFQCVni7IySq0NGQ=
X-Gm-Gg: ATEYQzxDJMs/x1Z4oNU/e8HxjFMuhaxUv16SEVioOxuxvUyN0FMYJykFN2oft6OauFD
	5duO1ymxJfKT/OhwtW3wQR/OyEyQpdriZuZ4DsjDDuz898V1zmNOO7E6FTVwsAiNV544Aj779XQ
	XL5y6gtXTNTxSFu+5tVnuUTs9Ofba/fjimaQ81o+mUrlzcY3/IoN2Jagde4YWQAVHdRK7a0Dxll
	PSzreqoEbLdgH+0WdzpptcsumLiP+Jv8EP1lYHPFAmeXGAZ9jkxZjvD9N14K8NxXZSbLYNQwDPF
	0PrQ2P4vAEoYgEfaYoXCapeIdGKigVS+Oovt0t2i512ddHBWjdtjxuCPUFFieQu3vbwHTaB8YkZ
	69UM6Yg9UKyUxOgH018VQHkKYscRjj1AIUbCf6AXOgvrVjz9h+dXv
X-Received: by 2002:a17:90b:2e45:b0:356:2fc5:30e5 with SMTP id 98e67ed59e1d1-35a21fc20e7mr2198964a91.21.1773389753278;
        Fri, 13 Mar 2026 01:15:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2e45:b0:356:2fc5:30e5 with SMTP id 98e67ed59e1d1-35a21fc20e7mr2198944a91.21.1773389752817;
        Fri, 13 Mar 2026 01:15:52 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e9861csm8039046a91.8.2026.03.13.01.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 01:15:52 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, ebiggers@kernel.org,
        abel.vesa@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com,
        wenjia.zhang@oss.qualcomm.com
Subject: [PATCH v5] mmc: host: sdhci-msm: Add support for wrapped keys
Date: Fri, 13 Mar 2026 13:45:48 +0530
Message-Id: <20260313081548.3556577-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KZrfcAYD c=1 sm=1 tr=0 ts=69b3c7ba cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
 a=qqNy_vziDfUGqepx9HcA:9 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 1LliuvSxoWwBbthT00-1EpRz_kZHVucd
X-Proofpoint-ORIG-GUID: 1LliuvSxoWwBbthT00-1EpRz_kZHVucd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA2MyBTYWx0ZWRfX/16x+7iAA1he
 MPJUH9k3t7F9mCIbcLKg9ufOp8K8rl2fAPd8NPp2fX3EVbb5OttUXwyUumC0osO4HvKYKNPuWrX
 nlj043eCkEvtlTUZt7BY6SmJfUl8ll5l3U+l+yuWgP05sQBK89Zt1aNG1Zl7nLszuA2PL9uLti3
 bTRLkDV9zHoQtrCJjIvwJhzkYcSwjZOQhFUvxEfxsmuThV2A4phHFOaFi5pTclzghAiomtZBbn8
 +aFBUU5ZOLZmh4/uTUzQmGHY4pinFAgAy6WWeQUeQjVDMfcDMwSHAvxQ1OxwQfA/ljbMIDgSmba
 3iLMXc21T6BlaQhBFRm1/tCR0LqsxjLPgAmZawnDxJvv4U6oy1N1/D5oFpfNCU4Yydcciypx+fU
 3IlARdxxtidsD1r3VSlU+zqEU7q2mY5x/p5Aultmmh1IG7Y3O9e5w+Osd7VcXJf4mEuHP2AsKTP
 sn/GHkiwoJEWRLvE8LQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130063

Add the wrapped key support for sdhci-msm by implementing the needed
methods in struct blk_crypto_ll_ops and setting the appropriate flag in
blk_crypto_profile::key_types_supported.

Tested on SC7280 eMMC variant.

How to test:

Use the "v1.3.0" tag from https://github.com/google/fscryptctl and build
fscryptctl that supports generating wrapped keys.

Enable the following config options:
CONFIG_BLK_INLINE_ENCRYPTION=y
CONFIG_QCOM_INLINE_CRYPTO_ENGINE=y
CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
CONFIG_MMC_CRYPTO=y

Enable "qcom_ice.use_wrapped_keys" via kernel command line.

$ mkfs.ext4 -F -O encrypt,stable_inodes /dev/disk/by-partlabel/vm-data
$ mount /dev/disk/by-partlabel/vm-data -o inlinecrypt /mnt
$ fscryptctl generate_hw_wrapped_key /dev/disk/by-partlabel/vm-data > /mnt/key.longterm
$ fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/vm-data < /mnt/key.longterm > /tmp/key.ephemeral
$ KEYID=$(fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt)
$ rm -rf /mnt/dir
$ mkdir /mnt/dir
$ fscryptctl set_policy --iv-ino-lblk-32 "$KEYID" /mnt/dir
$ dmesg > /mnt/dir/test.txt
$ sync

Reboot the board

$ mount /dev/disk/by-partlabel/vm-data -o inlinecrypt /mnt
$ ls /mnt/dir # File should be encrypted
$ fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/vm-data < /mnt/key.longterm > /tmp/key.ephemeral
$ KEYID=$(fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt)
$ fscryptctl set_policy --iv-ino-lblk-32 "$KEYID" /mnt/dir
$ cat /mnt/dir/test.txt # File should now be decrypted

Tested-by: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>

---
This is a reworked version of the patchset
https://lore.kernel.org/all/20241101031539.13285-1-quic_spuppala@quicinc.com/
that was sent by Seshu Madhavi Puppala.

My changes rebase it to use the custom crypto profile support.

Changes in v5:
- Rebased on mmc-next.

Changes in v4:
- Updated the link for fscryptctl tool in commit message to "https://github.com/google/fscryptctl".
- Aligned the indentation at few places.
- Unwrapped few lines of code.

Changes in v3:
- Updated commit message with test details and moved "Signed-off-by" above the
  scissors line.

Changes in v2:
- Updated commit message for clarity.

Changes in v1:
- Added initial support for wrapped keys.
---
 drivers/mmc/host/sdhci-msm.c | 42 +++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index da356627d9de..b4131b12df56 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1944,7 +1944,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 
 	profile->ll_ops = sdhci_msm_crypto_ops;
 	profile->max_dun_bytes_supported = 4;
-	profile->key_types_supported = BLK_CRYPTO_KEY_TYPE_RAW;
+	profile->key_types_supported = qcom_ice_get_supported_key_type(ice);
 	profile->dev = dev;
 
 	/*
@@ -2024,6 +2024,42 @@ static int sdhci_msm_ice_keyslot_evict(struct blk_crypto_profile *profile,
 	return qcom_ice_evict_key(msm_host->ice, slot);
 }
 
+static int sdhci_msm_ice_derive_sw_secret(struct blk_crypto_profile *profile,
+					  const u8 *eph_key, size_t eph_key_size,
+					  u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	struct sdhci_msm_host *msm_host = sdhci_msm_host_from_crypto_profile(profile);
+
+	return qcom_ice_derive_sw_secret(msm_host->ice, eph_key, eph_key_size,
+					 sw_secret);
+}
+
+static int sdhci_msm_ice_import_key(struct blk_crypto_profile *profile,
+				    const u8 *raw_key, size_t raw_key_size,
+				    u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct sdhci_msm_host *msm_host = sdhci_msm_host_from_crypto_profile(profile);
+
+	return qcom_ice_import_key(msm_host->ice, raw_key, raw_key_size, lt_key);
+}
+
+static int sdhci_msm_ice_generate_key(struct blk_crypto_profile *profile,
+				      u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct sdhci_msm_host *msm_host = sdhci_msm_host_from_crypto_profile(profile);
+
+	return qcom_ice_generate_key(msm_host->ice, lt_key);
+}
+
+static int sdhci_msm_ice_prepare_key(struct blk_crypto_profile *profile,
+				     const u8 *lt_key, size_t lt_key_size,
+				     u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct sdhci_msm_host *msm_host = sdhci_msm_host_from_crypto_profile(profile);
+
+	return qcom_ice_prepare_key(msm_host->ice, lt_key, lt_key_size, eph_key);
+}
+
 static void sdhci_msm_non_cqe_ice_init(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -2089,6 +2125,10 @@ static void sdhci_msm_request(struct mmc_host *mmc, struct mmc_request *mrq)
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

