Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD4296BC8
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817969; cv=none; b=jna73/gbtiDaI2TeHj8CtkrK6ezFHPzxfQwAH53mczsVAqRx80BgfVbgs/WZSYYpWmyKO7RiKoWeTKQ2r3IZLBv90WIB/OO93ScHftZxOtrQgzWU2HVCMBZLeh31UYPBsDeznRxkW0/j2N3gmSGV4o4AxOaa6nDB857e8gGRds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817969; c=relaxed/simple;
	bh=HukoZ0sxKRcUqWtfECh8yaNdQo0JysxAGRwHzeV630Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bXWcuMuzLwG9jaDaRrcVll0HmGO3CXC74gD0Vfp37L9vkXUTbJxEy7vJ1LychUFVdMfDLkMzOjuFil7ltaBvptJxDC6lVnXcCoPOYQzuh7k5PpbSbG6wO7UUHiLbSgtdd8b9uMovikxVm7gMi2yMrLj765Hjzeayl7/6SaNRuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I0ykjyZS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iv54GRGS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I0ykjyZS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iv54GRGS"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JA7VSb597677
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 10:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q269Adi+iglW7urX1zCjMdU0Oa+mDnNzX7NUDDZoNTU=; b=I0ykjyZSI8kx9IaN
	DHeMBTPXkUzSNGmAOvL1oiwwqiQVQKC8gRwdG7E9bIzhfP3Q9k9yIt8QK2T9e1i9
	irVBq3gQ2timqU8NjAxxFhoChzIO/X8IcfICcKy6DNpZ0aYRKJ1iVBMn+Gb8ECcJ
	o36pvnLjxv/nzbrtm0ttNhPHZzpPqHcGnGwexpwUoRVmm5Y73mOlb4xow+FS6C4x
	BwXOQBqkBlO0KXhCV5bNahbvliqZpeKKos0A6S0BTR8HC5F+gwWRsYSQlRoQqD3r
	lOGfuT/gkZNg2Y+P5Q+F/Cnd0tJMfffDzUpaDjJ2NSl8inkgjWdRMK4bMjPb5Pt6
	l6gKbw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsjk7g17q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 10:19:24 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81c765b9b03so4551493b3a.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 02:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768817964; x=1769422764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q269Adi+iglW7urX1zCjMdU0Oa+mDnNzX7NUDDZoNTU=;
        b=iv54GRGSP3jT0AeTDBx4TeulqwD+2N/+od5NANNAk05CMZfOQpeqbvwpOOucndcbzR
         QyOs5S4fs3DUWtymmYPd8Jqx3CZLPw8jH1hoprVwEmTg9yt6Lqs6Wd6ECV1YNaXQw9RM
         Rkxa0nQ+kb/9bw7YEqxCz9rjSAsXmS/Cs9m9RQZ+DpNz5fX8gcCIcWkq+KmK/3cHeSAI
         02JTA4MG4xyGv35oE5vP5TdCJ5IJcEOG1w3XC4irAldkMCHr4z1E4qqkFKHSwLo3vLXe
         N63Yh+KPdr7XUcZ55NOzVRpqBEz2zjSljbWQTanVtJ46xdx96RIRxn0pk3KzS+6Af1YN
         mFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817964; x=1769422764;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q269Adi+iglW7urX1zCjMdU0Oa+mDnNzX7NUDDZoNTU=;
        b=Q8FsOpKC7fe9qTm5jJYNEoG7B8LZcGmKkrNOkaWd59jrFoaz5j3WVqVE3rmMsc03nM
         bYsmOEB8TF2KOn7lsN8VUPpoRviSAGjoWMASuAzfppz6Xi90TpHM6lzMcEsR6AvDakAR
         b60FacC+bEuyUXOT58QHDYGX4e7Z1GqWYGjCk1rYD6BIwQ+XPHMuxv5DdwiTnKco/iav
         TSsfd2I8yFSrHAjQ8FijT3ZIlNiX5UecIWkGoVg9D7EVuBcfk7vZ0fQk0pf2QCV9iudR
         jHR5yB8yQfzCT90nct/ZuQvZX3uZEvTNTLckU8NyVMGbBKUuyObPiUsY/9yX23EgSbUQ
         prSA==
X-Gm-Message-State: AOJu0YyBBfl0DemFZkmX1HnJv+JXliM1UF4zGECX7hDhl0OiCHUqk0KH
	m5VoC+VKF1B8f8Jm3gxZviR8ayRKLPVKZEuaWa3hJJSQo7c3jd918IUFLMZJwyXYFJPwQVpn1uG
	saf9S20kALJFIWu1qBSX5kChyth/2QKj4imbIOHJ9QsbAXY6Z37h9rSG4uMOr0Mk=
X-Gm-Gg: AY/fxX5P0qBEPc6WT/J2YgQn8554P7t7ZQUsDHb3+XYrfYohxbOG+F7Hyyng7iuPBEn
	gRUiC7a7UwZ4zeb7iXOD8A58pRsiIOtl5L8hVzUGEXJcDxBqMbp5LHS7m4anfb8ayxmeua1uEZk
	Or8IicThpFOoVOIlHwwtFBbUCImNsZDf1sY1P/l9nQdVPhtjh2fLloWciD6yS8nJG2u9neHb/9k
	c+WjwGhz3KDBLfA1NUii5uwkRPRQ2lcIrSt5QZW8FuDAXcSUpMkxAg54NL8qDRHvbuiloQQMrqT
	8HcDXdl+Mj4pjaLemRLml6DP96zVXOHUdiuVXS/QOxTZ+8aO4lwv6DxLoJtY2t8IGiMcAEBZJ3d
	Z5aJp7w6Z+XmfLZZOQnSk+E4cziKy+RIe/xmlP04=
X-Received: by 2002:a05:6a00:1144:b0:81f:3c34:fa73 with SMTP id d2e1a72fcca58-81fa07579b7mr10011706b3a.34.1768817963640;
        Mon, 19 Jan 2026 02:19:23 -0800 (PST)
X-Received: by 2002:a05:6a00:1144:b0:81f:3c34:fa73 with SMTP id d2e1a72fcca58-81fa07579b7mr10011675b3a.34.1768817963123;
        Mon, 19 Jan 2026 02:19:23 -0800 (PST)
Received: from [10.217.223.153] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12779desm5799756b3a.39.2026.01.19.02.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 02:19:22 -0800 (PST)
Subject: Re: [PATCH v4] mmc: host: sdhci-msm: Add support for wrapped keys
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        ebiggers@kernel.org, abel.vesa@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
References: <20260102124018.3643243-1-neeraj.soni@oss.qualcomm.com>
 <3a93822a-6ca1-4cc1-be12-38b2b04704da@intel.com>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <23c9f3b9-f575-5bc6-e7f0-46238c26a7e5@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 15:49:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3a93822a-6ca1-4cc1-be12-38b2b04704da@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA4NCBTYWx0ZWRfXyI82s2wrAD2q
 CcTFuZNuLO2srlRVMy1rlOfQkGLd9eHZXWX8kbIwc18N9B+q45bNrC+Lhv/MTkegjQFyba3sDhW
 B2EGv5doF+4BtCGFJMRRGN3IgmExFxTigYOnZQXS8IQThREEL5g0SABPaVQqKf5zYrbdnjeeFkd
 T11cT+YQfW7m1f6CgwnDtUA46+zB/KCKgiqbN3XmgpOLLGej+AFsDg9u5ryJasr51ByzH0ybLB4
 aOwxy3wTPy7nQpnI/1ygGUQ3xLD6Tf9t83o9bxBpT9IQa1I52d/qJOgoqNDyb6DfaXEIZf4oGSh
 c4SOuedbCfxQUJ06UGmxJ9ucHeb1Gyt2evk83Q47MCktnNUG+L21Pru8hwkcc4eukCgnlyn/hc7
 8O74dSJhaBXErSKT1jrbIKBPBfthv/kjemzLKpwnvegsAAoHtg+Za+Hk4IeS5B02BVLB4ULau34
 5Nwoc76F0GsVI9kFM1w==
X-Proofpoint-ORIG-GUID: UBCPH5Ktygy_rPgulflIBxI8nO7qAKwV
X-Authority-Analysis: v=2.4 cv=WoAm8Nfv c=1 sm=1 tr=0 ts=696e052c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=VVF-A7Ca6zvItOv6IJYA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: UBCPH5Ktygy_rPgulflIBxI8nO7qAKwV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190084

Hi,

On 1/12/2026 12:35 PM, Adrian Hunter wrote:
> On 02/01/2026 14:40, Neeraj Soni wrote:
>> Add the wrapped key support for sdhci-msm by implementing the needed
>> methods in struct blk_crypto_ll_ops and setting the appropriate flag in
>> blk_crypto_profile::key_types_supported.
>>
>> Tested on SC7280 eMMC variant.
>>
>> How to test:
>>
>> Use the "v1.3.0" tag from https://github.com/google/fscryptctl and build
>> fscryptctl that supports generating wrapped keys.
>>
>> Enable the following config options:
>> CONFIG_BLK_INLINE_ENCRYPTION=y
>> CONFIG_QCOM_INLINE_CRYPTO_ENGINE=y
>> CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
>> CONFIG_MMC_CRYPTO=y
>>
>> Enable "qcom_ice.use_wrapped_keys" via kernel command line.
>>
>> $ mkfs.ext4 -F -O encrypt,stable_inodes /dev/disk/by-partlabel/vm-data
>> $ mount /dev/disk/by-partlabel/vm-data -o inlinecrypt /mnt
>> $ fscryptctl generate_hw_wrapped_key /dev/disk/by-partlabel/vm-data > /mnt/key.longterm
>> $ fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/vm-data < /mnt/key.longterm > /tmp/key.ephemeral
>> $ KEYID=$(fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt)
>> $ rm -rf /mnt/dir
>> $ mkdir /mnt/dir
>> $ fscryptctl set_policy --iv-ino-lblk-32 "$KEYID" /mnt/dir
>> $ dmesg > /mnt/dir/test.txt
>> $ sync
>>
>> Reboot the board
>>
>> $ mount /dev/disk/by-partlabel/vm-data -o inlinecrypt /mnt
>> $ ls /mnt/dir # File should be encrypted
>> $ fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/vm-data < /mnt/key.longterm > /tmp/key.ephemeral
>> $ KEYID=$(fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt)
>> $ fscryptctl set_policy --iv-ino-lblk-32 "$KEYID" /mnt/dir
>> $ cat /mnt/dir/test.txt # File should now be decrypted
>>
>> Tested-by: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> 
> Doesn't apply cleanly to mmc next.  Otherwise:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
Is this a blocker for the patch to get merged? I will anyway see why it is not applying cleanly on mmc next
but wanted to know if this is necessary to resolve for these chagnes to get merged in Linux-next?

>>
>> ---
>> This is a reworked version of the patchset
>> https://lore.kernel.org/all/20241101031539.13285-1-quic_spuppala@quicinc.com/
>> that was sent by Seshu Madhavi Puppala.
>>
>> My changes rebase it to use the custom crypto profile support.
>>
>> Changes in v4:
>> - Updated the link for fscryptctl tool in commit message to "https://github.com/google/fscryptctl".
>> - Aligned the indentation at few places.
>> - Unwrapped few lines of code.
>>
>> Changes in v3:
>> - Updated commit message with test details and moved "Signed-off-by" above the
>>   scissors line.
>>
>> Changes in v2:
>> - Updated commit message for clarity.
>>
>> Changes in v1:
>> - Added initial support for wrapped keys.
>> ---
>>  drivers/mmc/host/sdhci-msm.c | 47 +++++++++++++++++++++++++++++++-----
>>  1 file changed, 41 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 4e5edbf2fc9b..8ac4aee2cb3b 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -1911,11 +1911,6 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>>  	if (IS_ERR_OR_NULL(ice))
>>  		return PTR_ERR_OR_ZERO(ice);
>>  
>> -	if (qcom_ice_get_supported_key_type(ice) != BLK_CRYPTO_KEY_TYPE_RAW) {
>> -		dev_warn(dev, "Wrapped keys not supported. Disabling inline encryption support.\n");
>> -		return 0;
>> -	}
>> -
>>  	msm_host->ice = ice;
>>  
>>  	/* Initialize the blk_crypto_profile */
>> @@ -1929,7 +1924,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>>  
>>  	profile->ll_ops = sdhci_msm_crypto_ops;
>>  	profile->max_dun_bytes_supported = 4;
>> -	profile->key_types_supported = BLK_CRYPTO_KEY_TYPE_RAW;
>> +	profile->key_types_supported = qcom_ice_get_supported_key_type(ice);
>>  	profile->dev = dev;
>>  
>>  	/*
>> @@ -2009,9 +2004,49 @@ static int sdhci_msm_ice_keyslot_evict(struct blk_crypto_profile *profile,
>>  	return qcom_ice_evict_key(msm_host->ice, slot);
>>  }
>>  
>> +static int sdhci_msm_ice_derive_sw_secret(struct blk_crypto_profile *profile,
>> +					  const u8 *eph_key, size_t eph_key_size,
>> +					  u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
>> +{
>> +	struct sdhci_msm_host *msm_host = sdhci_msm_host_from_crypto_profile(profile);
>> +
>> +	return qcom_ice_derive_sw_secret(msm_host->ice, eph_key, eph_key_size,
>> +					 sw_secret);
>> +}
>> +
>> +static int sdhci_msm_ice_import_key(struct blk_crypto_profile *profile,
>> +				    const u8 *raw_key, size_t raw_key_size,
>> +				    u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
>> +{
>> +	struct sdhci_msm_host *msm_host = sdhci_msm_host_from_crypto_profile(profile);
>> +
>> +	return qcom_ice_import_key(msm_host->ice, raw_key, raw_key_size, lt_key);
>> +}
>> +
>> +static int sdhci_msm_ice_generate_key(struct blk_crypto_profile *profile,
>> +				      u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
>> +{
>> +	struct sdhci_msm_host *msm_host = sdhci_msm_host_from_crypto_profile(profile);
>> +
>> +	return qcom_ice_generate_key(msm_host->ice, lt_key);
>> +}
>> +
>> +static int sdhci_msm_ice_prepare_key(struct blk_crypto_profile *profile,
>> +				     const u8 *lt_key, size_t lt_key_size,
>> +				     u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
>> +{
>> +	struct sdhci_msm_host *msm_host = sdhci_msm_host_from_crypto_profile(profile);
>> +
>> +	return qcom_ice_prepare_key(msm_host->ice, lt_key, lt_key_size, eph_key);
>> +}
>> +
>>  static const struct blk_crypto_ll_ops sdhci_msm_crypto_ops = {
>>  	.keyslot_program	= sdhci_msm_ice_keyslot_program,
>>  	.keyslot_evict		= sdhci_msm_ice_keyslot_evict,
>> +	.derive_sw_secret	= sdhci_msm_ice_derive_sw_secret,
>> +	.import_key		= sdhci_msm_ice_import_key,
>> +	.generate_key		= sdhci_msm_ice_generate_key,
>> +	.prepare_key		= sdhci_msm_ice_prepare_key,
>>  };
>>  
>>  #else /* CONFIG_MMC_CRYPTO */
> 
Regards
Neeraj
