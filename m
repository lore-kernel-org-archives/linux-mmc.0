Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F3238150
	for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767014337; cv=none; b=hgPde8FtXLp9kvcqFGx5u2Dh3bTh0+OvN59B3p8+9arI+haB/gfHrATO+t5LOiHtEnpSiZjschwTLU7csaAFUkYTivGmpM039Dh/0nzyCq+gVVVdVtOEI23qxE0Q9+jDwBaoaKHEBTSyiEU4R87cORdHbTO6J1deZvyoCG6ZP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767014337; c=relaxed/simple;
	bh=XpD7T99QK3bKDNjy2vsjPCbr638faFYz6cZEp0x4Dic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEKVCFYN3XHnDMdnEBohop6a6R6VHduPhRzTX9e5lcNQfTmS06GOKu7Wmg+P2LB4ab4JhMXsdGXSC/xxYDup9N+kAmKRVOQXxD+7ngIZ4WyPaEb4eBBNyySk7bQ7ZpgT5S/GykYrxmmWchCOQ8OqVNPrtL6qeXrhW2rzRF1uTIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JC2NFTGa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j4r78vyx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JC2NFTGa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j4r78vyx"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BTAspcs3840442
	for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 13:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/v/RUGKGn1X+vhYpfh/pCrCiUYLijb3g2R8NqaKVs8E=; b=JC2NFTGaM54DY90s
	D6gv08eDbXkDcQ5BH3H+klKsu11N8Jc7QVqYuOBE8S79yChsRrNu6QpsC15WMeXA
	35E+mVgLjcVdXbQAJqbeMb6qlVkvV4y1CKvD6bnvUdpJyUzz9vaItD2e2VcSbwJi
	OkhaI3mPtJILOTdnXRR/oXu0NCw5YMhTJp4yGjTfm6xvckB1n+CcFUSRuu/dy1PV
	hvW/oH9kT4kK/+hhQJLtVsqmBaJOI6R2G6vkQPbFKUptBtH1hOWAHbTe8ssQH00f
	mIWqT0xsoNWT59aruCEbzE7rhGHMefEfm63dr4T8UbZ9qUTZ29Ow3LMKP3NNgejq
	Y2HbSw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bbc8ysnb5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 13:18:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f34b9ab702so23742931cf.3
        for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 05:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767014334; x=1767619134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/v/RUGKGn1X+vhYpfh/pCrCiUYLijb3g2R8NqaKVs8E=;
        b=j4r78vyxCecR6oFUOJOLCQynCuASv8+wY1ZkqKYtjo9zqzGMDDs3VSjn9soa01TXVC
         YbIxyOoaNx5AY/3U5LpQWqCc5ZaX5c2mJ4AwLUZelzFMZMd/j35NNqQNf7ABHA6Okbc5
         zqA954/1bRxbszxJ5sXwz1VUzwhgqi+km8L/gwdHfsVoAm0bP5LMkExJI/u8KBJOAN+G
         HMYjMrSJoWoSe9nx0QdHHQn5jgsYuB+dd57BJn2KoWCbb9F16Q8MMiz+vSMH/I0+1aZz
         jNVgeOOu6i3gXqZWfDlXVA5oUPHAvyeKqWB2mySqPdDgXjFMUVPL/4s3DO2mglZcoCp3
         AaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767014334; x=1767619134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/v/RUGKGn1X+vhYpfh/pCrCiUYLijb3g2R8NqaKVs8E=;
        b=opTzSABj/LwvIooQTnsNbXhwD200Ov3XO157/n+w/8DOyATvjrm0qLexAlE2cKb4mw
         f44kK55TdJMhGS26WbxsiUo4BldlrEJ39IFrPY/hx3XX+vmrT/yZNsbVTe27B7dQvqft
         fSgmvUyGclhyer8gTlrJzNYF1ESHWQpTYdgVtc4o4eTs/yxTmc8ZqCEFh7QV+YtQrvFw
         HQow8thwTp8XJ+yWgkcX3MChZzfT6Etyv3zcaTTgAyZBLdJZeuM00mDU5IJjg4rbBzso
         eOp8SKQyBDbFqWseMS618ka+UEc6ZWL92D5PcoDRE72mwjw79fLNSKEUA5uKRVYaTygr
         gygg==
X-Gm-Message-State: AOJu0YyYYv91J4jOH99UxHLJiWwg2LMV2OZluCf8rsKRP+k1CuhnrhGS
	vDk8qURaEA3bD/LXXVYKGJS5zjLQEPtJ04JwVbDj1t2jeXzgjFO+82zS2FZpqyb2qcEbX3cns+L
	zeZd32h/DXS5TxCrEUQtNnAj3hSZ8F5iwtCQds7sg1Gum19dpfm7v5P3miZOUgSs=
X-Gm-Gg: AY/fxX4VWHGFW9bYM2v8bz22rfqjONsEBdSfMMiQIjxompva1Q8+I40O+TXnPxlmLvi
	9sJmYuHuyXcx2Rar6qwGoHrGVRovsK+s3y5cH7fwXHUV/dZZiNOaszzyYXZ5nsjxjA8NBX8L0Ck
	VmbDKq54bNCJAIwA2v4aYiY9Qv0Jw/PRLUZFixXoHYGVnWL2N5ZVF8w0mjaBRrO1OhszZL6/JcW
	iyEKCpOB5cWVdXfPl0+gKA8aLHD+S6QSaRqTvMHSo9paZItRacsLKraWrRFUAo1zfnjT7aJoimJ
	urI2T3K0M8zmT72BSvlP/SjO1+bkuPrh7F3edhisYAx2L4AqnUldBv+DxcCWkii8kORyApaxye6
	5QajLBWNka+r2ifQ+V+dwPXMRp9Xg3FnRs17KLyfOqAxrPXYpr+Qgr7YM20llUKW09g==
X-Received: by 2002:ac8:5a46:0:b0:4f1:b580:fba8 with SMTP id d75a77b69052e-4f4abcd86f6mr342183361cf.3.1767014333988;
        Mon, 29 Dec 2025 05:18:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpXqgxRlcmGdra+B/YgHXBjytYW30Ef6ubBa41rl/XtAmpXyGW8yniJTBqIkfK/TboBcBC0w==
X-Received: by 2002:ac8:5a46:0:b0:4f1:b580:fba8 with SMTP id d75a77b69052e-4f4abcd86f6mr342183041cf.3.1767014333563;
        Mon, 29 Dec 2025 05:18:53 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f51a74sm3418949866b.63.2025.12.29.05.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 05:18:53 -0800 (PST)
Message-ID: <cbf3fb8d-1dc9-4c16-9bd6-df45530a025a@oss.qualcomm.com>
Date: Mon, 29 Dec 2025 14:18:51 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: host: sdhci-msm: Add support for wrapped keys
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, ebiggers@kernel.org, abel.vesa@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
References: <20251229070507.3322149-1-neeraj.soni@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251229070507.3322149-1-neeraj.soni@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDEyMyBTYWx0ZWRfX90L0eGGwkiXH
 StNTLVBi7GOHSSIlJdtLEnPQfu1LrUOfPISVw2e5eo+wEFWpN/DJBuGvazt68303jZeBPp65kQf
 9RFWfykme9NcZfwY8TJp3lUGmZ8BYu7jLgTO9MsCxGKgQY5OtYEW3lvd9GtEllVGO47QnKLYYIe
 cn2hU/x2+j13tlFSuO8bbw7kpQ2xwTDvTVf1Qf5f2BnIhxWF5JEWZKMEUV85LfYOk0O/cOmkpw8
 OqXsP8ShNnMjrDHPWa3qkt0+38W/QIWNR8hgoBWt53a25+yTNz1WmG1gyRJUnhVq+u02vnZchOK
 NZX9RSCfnqJB7Ox7l1l5fYxGadhs3c/mRd9wLnBfhF3mQEg9yA/cc8yxxyMsQI7fi3lAnB6Ok5F
 HK0EN7/mlD8Xs75MhH0LXC6eFPyNI2zhkiBv/c80ffMpmTbzoFgAC2E3K9J7JIwY3Xh6fGWp9IS
 4MsvW1P0713SIZhe9fA==
X-Authority-Analysis: v=2.4 cv=cP7tc1eN c=1 sm=1 tr=0 ts=69527fbf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=C6MLRjK8zebgh08ocB0A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Flo1FVBbxOYZOGydVjwUqDJ4P8xH9ka1
X-Proofpoint-GUID: Flo1FVBbxOYZOGydVjwUqDJ4P8xH9ka1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_04,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512290123

On 12/29/25 8:05 AM, Neeraj Soni wrote:
> Add the wrapped key support for sdhci-msm by implementing the needed
> methods in struct blk_crypto_ll_ops and setting the appropriate flag in
> blk_crypto_profile::key_types_supported.
> 
> Tested on SC7280 eMMC variant.

[...]

> +static int sdhci_msm_ice_derive_sw_secret(struct blk_crypto_profile *profile,
> +					  const u8 *eph_key, size_t eph_key_size,
> +					  u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])

These should be aligned, please touch that up

> +{
> +	struct sdhci_msm_host *msm_host =
> +		sdhci_msm_host_from_crypto_profile(profile);

Please feel free to unwrap this line (and its copies)
> +
> +	return qcom_ice_derive_sw_secret(msm_host->ice, eph_key, eph_key_size,
> +					sw_secret);

And this one too

Logic-wise, I don't see anything obviously wrong

Konrad
