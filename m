Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05CF322B7B
	for <linux-mmc@vger.kernel.org>; Mon,  6 Apr 2026 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775460593; cv=none; b=airR7I9Eyb5A13UH23WxakZ++exUGKsoKIQnW43uzA3rr2kuOLS1dWP/aG6llOvNmzBPHHkA0fWoo4akDV+/qgGVxAy/Ccgzg4LskFxIVCAj4s2d1q6FK6jlONvKJ6B+ZLN+kMZ82rmjy3ztyTtap55RWNB+3vCsf4h8gPM9a24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775460593; c=relaxed/simple;
	bh=QN5KldYd1+uFod0woVvjfeFZ8kyDw7udiJjsHsGxIlU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fMnJLJ6E4DakaGLdT7ExE6mQ1vNCDcWNQWzp1PNEt0K+v/wItYlCS5gxKaajBpAnZK8SnvdMs3nP9Ntv5KKgfrKTXHc8dW/BljzC1TYNP3EvJKB+9zZAAYa+bq8Y/1DiOV56OSRWThl67wovPScgqxjT59gKaQ6VuhfN+VYxXmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DyQWfkVD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DmM6ysUY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DyQWfkVD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DmM6ysUY"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6366Sl2W3379880
	for <linux-mmc@vger.kernel.org>; Mon, 6 Apr 2026 07:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G80EJy28BYwA6nOEe/oB2Z2qDbtqNvwKYFonsnpZaRc=; b=DyQWfkVDsqqkZ5en
	e0RGDHs7955n4mQY5R8aeMJNerMpRSjvFXpQP+FCLmV2H+zXMU1F2wdSrFl0jn8p
	v1cbLYw6F1at06DL6S6JgaORnlSnpP+9O8FilmVXnZtxZBFtizgnYcLeQkYNjHqU
	GfYG3iSY8pudAlElFYyhlsiQqiLfnhZcB4EmVFDMSsbTwYuM6PUAnR+UXV1c79Nd
	K5URqptdWxHfCRzw0XxOfKthu3kiAYoEVQF/Cilg3hSMNbZVmciiAGSo3R1wpb1S
	xydqhqnW8H+FoOcfcFseAegVN4VH3QevKTdJjN1xmkXcrvR+G2/XGe/j94MqRNi9
	JOL8SQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4datqsm9jr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Apr 2026 07:29:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b242cbb97aso29534375ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Apr 2026 00:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775460588; x=1776065388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G80EJy28BYwA6nOEe/oB2Z2qDbtqNvwKYFonsnpZaRc=;
        b=DmM6ysUYwDV+Iwp7MaEuJlU4HsG/96gxfBB1bW7C04r/QKH43UErLhdSMwL6gLh5Zh
         1608eiZmyy1VeZ0Nqn6WPtn0X32o4vMr2WDkO9ndpJm6G7PQBM2dqzDF8R6RG2un7oWa
         /jeKxgUV/z1c22XGCTsXG8c9RcXxrMNAn+7o8dO9GNCb45l0gZkG7GL7EpHq14Vr/kbM
         zuw3acmp37rLpQcZlHA+hJOejIukmz64WeCUXJ9PmP3ccTQTCJQpynoRXwUFC7Lljm4D
         3GZrmniQr3lwpnwf/eHy2rQGMbdgk77S4WCE3kSFVie7fAH1gEJOQEqi5S1/3CT/UQLG
         0EkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775460588; x=1776065388;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G80EJy28BYwA6nOEe/oB2Z2qDbtqNvwKYFonsnpZaRc=;
        b=OQbUL7DdWFi05eXvqccPgtbwqSGRWGmp1nXJDjkd3wxCUQ2eO4GSQGhLSgjCMMC367
         D3CL7e5t9EV0Zm3aW+L2gRC9to/Jvmqe0D5jUjXFnGyPP7XaSY2dRl0FtQ3SBdUKM7yb
         XuaCE3pG2N8uwpl44+r2IGDbUF/NFh6aZek0xAgtWgu48//ANAaNrbC4c8DDOwM2qtuj
         NnPEnhuYJ/r3TkRin2ebiwj54rRXXoJS6TsG1Kas60AQA8Wi85mufUho5Ao1IyS6W3T3
         0/Gz2lSBkSoBQQYJprZv3EvRtwddoLY06WIyW8un+Z2P3bUVbfl59qxbJ4VUDAGdATCk
         KCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcnQpJ0oI58SuYFrIMSUxSeRVDe44ayaATpIAgIQz+z274/+RQDEc98bxRJI/Jsd1FqnBmhT0MXpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1qNBoCQj3FY+ttzYRYjp6WZkGVa+vmlSCsVm6AhTY1J6nrA8J
	/mED72wEr7y75N4ZZev/XPqwelC3oQ1H4kBlNDGKU9ZGGgPbfFVidbWp0FerIP2QxWJx273zdnd
	jAp/t8QOOYewOOkgtJ6ZHEFZo4yJ9GgG5YUmNnXocnsTN7Hwz1V4OHlLuh0zkbiH+r0wEhk0=
X-Gm-Gg: AeBDievHhZUdn9Ijs24beDMu3KKF/oUaz7woigWJcrHx6T5ogBuf4FPCu47k2eT5g8A
	0ALmytMoXDRX4D62wIQBAeRqpmsAg92HomuB3lL8sTcPPJjXb2m68Bie1sQr/wgAuvwz55GrBi9
	GvHKqxu+7bGfNn04GiCMq4cHKLKHzeRWE5Jug6dCH+aUC080aJ2W/oEEzwVC9WdzBbLWStH/TZ/
	6StZ4IhvdQlGjzLniDBBLyP1vwSpMqFsCyrgdAl93bvdlyQF/aAiuj6+GMUnB8A0tjXzPcss0x+
	TvZBBb0ZMLKmoEJqCX0SKU6lgShjFovofVj7dtDyMqrqBAw0IWtBZ7NgphxgC5mfdXWpv9dA1az
	ES8g9n4AKM2wyMtfHvSeE8RZ4NcYGgUnrPR9mq92xsdNdmXeFFQ==
X-Received: by 2002:a17:902:e845:b0:2ae:54b2:27c7 with SMTP id d9443c01a7336-2b28186dd62mr122048385ad.39.1775460588270;
        Mon, 06 Apr 2026 00:29:48 -0700 (PDT)
X-Received: by 2002:a17:902:e845:b0:2ae:54b2:27c7 with SMTP id d9443c01a7336-2b28186dd62mr122048245ad.39.1775460587778;
        Mon, 06 Apr 2026 00:29:47 -0700 (PDT)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2a488caa2sm17627745ad.14.2026.04.06.00.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 00:29:47 -0700 (PDT)
Subject: Re: [PATCH] mmc: host: sdhci-msm: Fix the wrapped key handling
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: adrian.hunter@intel.com, ebiggers@kernel.org, abel.vesa@linaro.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260403105949.1007447-1-neeraj.soni@oss.qualcomm.com>
 <x2mmttyg5t5qjo2tyrwqbynqylqqlulu7fhoyxl7vd54geubqx@qna6vzzr765y>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <dd2c0522-91bf-5375-f5b6-7c9ff5304fe7@oss.qualcomm.com>
Date: Mon, 6 Apr 2026 12:59:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <x2mmttyg5t5qjo2tyrwqbynqylqqlulu7fhoyxl7vd54geubqx@qna6vzzr765y>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ari/yCZV c=1 sm=1 tr=0 ts=69d360ed cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=8ToHcDrqECIu-RMY5UQA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: r3KyewJPquo0_s8bW1d5r-dzg5DEZytt
X-Proofpoint-GUID: r3KyewJPquo0_s8bW1d5r-dzg5DEZytt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA3MCBTYWx0ZWRfX2o42MVP9zGcI
 5bYQcCB89SzoqgXHrX3XgqADqzgFSayLju+S1YB7Vf6aHMgchTWvzhPeVeUis+FyYaIv085HvTD
 2i6UV1SuC6JWpViHdAcSsCXs1ayUWLYOqu3tZybkRAwsoSuLm+YMaxWumQdQ7IR7fIW1PscPPsY
 0etLsR3Us4FjgAJR3+wuiL5Ja0qQKh74sHv5TyD3lhnrD2h8pY7UcT4bcsGqGjrGavhfu821m2K
 KoiNENs67iLZlWebbaxzlXDGD9JHmr29JtP5/hDTi2gXW0R2JiljoQCWex6qmV1efq67JQf9Swx
 kQ/gonBJYOTG5faYO+3b2W4JWRdzg0p9UxdGMJnyc02p+v4rX3gSfvNKa1zSID7ERoa08UqKHKx
 sCEfPZKhbK65KONhSNXrbEnvqFL7fiAwEkT2TxYlZVOrs2jjUS07q0e9i0lBceCYyppRWF+k8pq
 vVEV5NrTdpuqDIpo8Xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060070



On 4/4/2026 1:30 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 03, 2026 at 04:29:49PM +0530, Neeraj Soni wrote:
>> This change was originally intended to land with the patch series:
>> "mmc: host: sdhci-msm: Add support for wrapped keys". The fix was present
>> till v4 but was accidentally dropped in v5 while rebasing.
> 
> Don't describe what is being changed or what was intended. Please
> describe, why you are performing the change. I.e. what is broken.
> 
Ack.

> Also, likely you missed the Fixes tag.
>
The SHA-1 ID for "mmc: host: sdhci-msm: Add support for wrapped keys"
is not yet available in tree so i did not add the "Fixes:" tag:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-changes

>>
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>>
>> ---
>> The patch serirs "mmc: host: sdhci-msm: Add support for wrapped keys"
>> was originally discussed here: https://lore.kernel.org/all/CAPDyKFqRG1_1aYavfrA0Ss85B0kcTnjVBeqLgq8PUJUcSx5LUg@mail.gmail.com/
>> ---
>>  drivers/mmc/host/sdhci-msm.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index da356627d9de..df0a038269d4 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -1926,11 +1926,6 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
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
>> -- 
>> 2.34.1
>>
> 
Regards,
Neeraj
