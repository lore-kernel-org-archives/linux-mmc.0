Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAB021A453
	for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766991917; cv=none; b=M0VFMCLhpbcE2Zv/7KCbJ7kCjhAuGcTu2ZCbdm/2Pb6nED7yXyzXJQIaOSYfzRglPZQxmFNnVqJFgSLxZi3jIFI62sA+mSWNNISAtJakzdVTq+4byZ0xjHJwjQw2rYJfMS388CDCU5QwtMjel9i0bRObiQERZ6s+43ukxEU9sdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766991917; c=relaxed/simple;
	bh=tsFztX9gEc2qYYeX49Q49L1uZ0Dxc78+olPK+fSrLzo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uk2wYiF4S++Nl2laLhdfcP0Gjj57aoYBdHsWPYKOUm5Y2V8H35qMHUL1dLoXDSrHZjN6OEJ+lqp7rJ2S56ErUPQPT8XfOiUC4F7BAgS44yEwNwbh4T5MyK0v6n2ircHIeXtjBD1GfqD0IPrJUYsnt+uaKi08Lw8zq+MlfNIvKT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OyXjwZbA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F1OaOWXa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OyXjwZbA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F1OaOWXa"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSM1Fo2132659
	for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 07:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gBg+vwS6bT/IKJzeZSsPQYKE/6StGzo+IKI
	7p0hUxe8=; b=OyXjwZbA99cxIhCncjnzzuL0k3+TwtvYv4n3p1tacf3RIJc0WqJ
	vNt35RbBauDxRb2xbtMhJRs0Z70dVCHbsyUe5HvCyMIgfX5Nayoo127JzQppXoi7
	/kZiT3+6gjQcWduFPueyaKywhvXU3P6cESo0HuUP5zQ2XcxUuaC1Yfj2+cB834Bb
	iuDYDbfg9kk7r7jIie8y4uz5tki/2528S03BPTeBOpHSA2kJP8vTAQMuI8+X4JfF
	dgJctZS5pM5MUroMLSTEOFfm4fXVseHNj6FOKA7+2Lb6Netutu+0uWNdkwciyvEz
	gFBpVe0FAn3ZBqWssSuUJs0RiaLVzE1tycw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bbc9v0vxj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 07:05:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0f4822f77so248731395ad.2
        for <linux-mmc@vger.kernel.org>; Sun, 28 Dec 2025 23:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766991913; x=1767596713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gBg+vwS6bT/IKJzeZSsPQYKE/6StGzo+IKI7p0hUxe8=;
        b=F1OaOWXa5F0DznORg0joXSnHNgtq9g11c+q/Jx6lJE2Tpw8/ZTpssE9uYIVBZNjfB/
         g2b54AJbUvDLYAVIyTvnYs8JEeyAyINvFQz5P7g2Btqrdpb505SWWcZem5amjOP2kHtV
         QifYDq0GdoMlbUL6Oix29PP//HFLS5b3d2/RmRgua+Oy7STK5lqhuBqTEZnHMB6yyDP1
         voMHl+H+Nh4BPzg54zSCsowEixFrSbO6gtNh5vwni/n7sV0rNu/VSgwtCGUVBGMe/3j3
         PyBhfuuzX5T5dDpTuC9uftw+1eKAPXzrIlt9ibbEFsAHOSUjT2N4m7KJg3aWWgYFD5no
         Km+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766991913; x=1767596713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBg+vwS6bT/IKJzeZSsPQYKE/6StGzo+IKI7p0hUxe8=;
        b=cbKG6WtZ7nTD23R/JcJUjwPyERzpq6FnIRxjlWHAEpZyui7SZpnrRao0BB6Qu27GNJ
         61uDCtqDeOlrYNEuSk6QqwvLXbIljR7pT53c9h5QfnvmpBjP4HLBAV+yt4R+k06dPhiT
         qm3dePEPy0FLg2NNzk+o/8w0h8P4bv7Z72ZY5mkHYU3n3AIIfy8Q5FfX3i37PMgI+LKQ
         eNNRHEbUGPSWfUtFmgE55799EyiptzoWJGkfrr9zKrVfXUEJ2N4eFAU+mnLOvW8rP0DV
         nW8K+6H8RD0xQ8KWwTbjza6Eqp1X0n79gLAk4URZkgUnpayCDCbLNtv8rGpy8YXP2W6I
         bKpQ==
X-Gm-Message-State: AOJu0Yw5RVt6nilmD94umKkIJW0SZ2kOimRQj8d3iXHcFUrtZNCAxsSY
	9wjX+MDtSpouCHbpSfwCWPG51vz5rYlzGLYoDzA6DkvdZY5X8P00ah+2T9a+eHOZ37kS8gqEPk+
	zaOyGBISCCjfBo2LhiKhOh5NitWR4tjydtG3YvcoI1ioDApVV3SRmp7wvNZEGSB0=
X-Gm-Gg: AY/fxX4QUVbQ0TITwfbdrwwwEiwHracfytgelDlcJ02dxxs5yURHEF+IIsITsT/UaMW
	k7MQuoLLxhMIWV6G6Ak3GftQkAHQDTamYdpP8pZuohT+W99AEhdsqoBbquXkndoKw3nYmnYGU1W
	bQqd+J2kpzBXMgGzuq0eaSC7sejOQM11Pa9U1W+v7xytMjH6DkLcnr+grglDXjEwl+uL8GHT8TO
	Ja2r0ff4Qem5hSHyOXpSxfIFq9pv2ZV2M5gSc2dLgAeA4FusvfirtTt1y0nhdxbrGBEgcjmdAbo
	VmxKwnZMKTPPHVgByTFLPs9v9Xfxu8AioRXHNqhrvf8KVOEdGbWYB7PKBmfM2Mti2JJyeODoR72
	He90j2oQl2rBP6MCmFSmRXkT66r/DsvOlTK2AyJr9
X-Received: by 2002:a05:6a21:6da9:b0:364:13e1:10f0 with SMTP id adf61e73a8af0-376aa4fa119mr28148885637.48.1766991913305;
        Sun, 28 Dec 2025 23:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0oUR2/eXukUaxEYuosMuR3RS3KAnsf8lMAv8AIZf3UkcmEgDx4FB2klCF4eSXw1j7Gwo8ig==
X-Received: by 2002:a05:6a21:6da9:b0:364:13e1:10f0 with SMTP id adf61e73a8af0-376aa4fa119mr28148872637.48.1766991912821;
        Sun, 28 Dec 2025 23:05:12 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c5307c7sm24736860a12.28.2025.12.28.23.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 23:05:12 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, ebiggers@kernel.org,
        abel.vesa@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com,
        Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
Subject: [PATCH v3] mmc: host: sdhci-msm: Add support for wrapped keys
Date: Mon, 29 Dec 2025 12:35:07 +0530
Message-Id: <20251229070507.3322149-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Cgt5ivNtFteBx0IWctfuBEBjlN1aNiPA
X-Authority-Analysis: v=2.4 cv=R/sO2NRX c=1 sm=1 tr=0 ts=6952282a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=qqNy_vziDfUGqepx9HcA:9 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA2MyBTYWx0ZWRfX0Nu1um5Xe9zE
 eU+q8ooiGbPxH/iiP0Fzw0IZD15YiVp+zoIEMjRXxdSR3oge5NVjJq0OQq+DjK9F/UmaxUb9INY
 f0KyonuPOo8KINeSlMUgqoWqBkral1Ik9jClXQP7pimE6t70WL7jQir32mWlgKbYWeuDbUHxX0C
 lC0cq9bZYExOa8q4Tuwek1L7knPolV39Nuth/kyNqMTYEwt8Tq4xKFQxIxoK4CtwiEbQ09kBaes
 7hTz9izFB4PeHeDHVu9730PU3pbr+spywyaQV70AjzXXQQ5IqkT6CoA7PEaavb9w01jse9uyZLQ
 0i9hnQFgxwE6Plt2hheDwyF9sZjT17uU4ZsScYkZ6PtmGjtdfmdvDoGvChQfMILqcn5p+pl3n+H
 Fh3q8pO/0ZNc8zBDawHqbmNOYpiWkPdN07v8NtFMCC7jLoh4fhcDxD9zHhQYM3UnwXgZj5TW79K
 Z4J7ymGKMexeq8KhhyQ==
X-Proofpoint-ORIG-GUID: Cgt5ivNtFteBx0IWctfuBEBjlN1aNiPA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_02,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290063

Add the wrapped key support for sdhci-msm by implementing the needed
methods in struct blk_crypto_ll_ops and setting the appropriate flag in
blk_crypto_profile::key_types_supported.

Tested on SC7280 eMMC variant.

How to test:

Use the "wip-wrapped-keys-2024-12-09" tag from https://github.com/ebiggers/fscryptctl
and build fscryptctl that supports generating wrapped keys.

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

---
This is a reworked version of the patchset
https://lore.kernel.org/all/20241101031539.13285-1-quic_spuppala@quicinc.com/
that was sent by Seshu Madhavi Puppala.

My changes rebase it to use the custom crypto profile support.

Changes in v3:
- Updated commit message with test details and moved "Signed-off-by" above the
  scissors line.

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

