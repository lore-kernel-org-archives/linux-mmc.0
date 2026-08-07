Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98F33191D6
	for <linux-mmc@vger.kernel.org>; Fri,  7 Aug 2026 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112375; cv=none; b=iK82KvffYw2j5hQgthfSN44egdusAG4GEQYqHDd4lNnvZtjwiGZAJg5VagbqcY3zjYcCMCX7SWKf684gUHB+m57WRUkGGDG1TXQYIKEsS8VguGErd8bb78PG807gD6Xg2d7YpY5DYIT53jJNRhb61XrlAkF9+FL5VnMKwNX4Fs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112375; c=relaxed/simple;
	bh=PjbNBERILRijrbzsMu7kjL97HuY7hwy+CNHDBDLch4Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pLxqhYaqekNzIAdFVhp9J/kBzwZli6i7uy3+5vdn4SonsKNXuHRad73ixHt7wtZJ1XimO9WRcpNVWXzOTNHbANoMrfHSq0GjHpwSPb8AXhezbT5eydWird8a6c9ldoweJtEJ+nKvSYVygblmRcbyVH8twqg3CD4lf0Mn/Ywq7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BP37Ror+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jH5Xl7Q9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BP37Ror+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jH5Xl7Q9"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CgWjZ1295464
	for <linux-mmc@vger.kernel.org>; Fri, 7 Aug 2026 14:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xDURwZe3kjAfzG+fLE3IYK+o3OP/hS+nN6qrRLsGiL0=; b=BP37Ror+k0+XhrSI
	pnbj0RNIm0rG6zC/DgrQebpzUu3qq0RsaRc6SdahGscQYGdicvdcP49JiAIa1Pcx
	etduJmOb9Mz7I3sNuAjkdWlCq7erjyNBTUpMwyOEPE1g6vd26My8bK3S0DpU4MSs
	+IznEJrIHMRqirX5dGvzCadfRhm9sXgDQ43NG3MMC2YRLcU8ZqElg5CK9SYPqdsc
	VauHYzD5spHxQDQbCtIYyKEjEdKrJU9KUvabulWybNc4pPWfA+eORjayzLWE9lnu
	pcw07YL3H1EQ1F3RbtPxnsZJ7354pvDKdBc6U/9OxyDUiy4KTh99ZmJlNaP4AC0w
	1sscPQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gvcdc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 07 Aug 2026 14:19:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cec4226c70so56473955ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 07 Aug 2026 07:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786112371; x=1786717171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :subject:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xDURwZe3kjAfzG+fLE3IYK+o3OP/hS+nN6qrRLsGiL0=;
        b=jH5Xl7Q9qXRnxYKMlcIrjZ86ymTSP5hHATQ2Llpl/XoslQ44Qf3qjMxwhvR5YoHQ3L
         Gh/aZIqNy5VAlbnltV2tlzHSaClSGRYEexxh5h9yFqcisEfPYj74QCaa0KJBi8FPtcG2
         C9fiXk/+Ub7R3vX4HyMubguCKlWcG1WoLsApLprNM/aT8/9THXAEoPBKDHai4gsr4jZL
         SxsOiDp5XaulNG6QOdnIMZEDtwGUKl3vRQi7YX5XBR9l0JNBqVOIsLAUZ+Fx6mEJJopb
         5as1ZFmPgSqpVfCKK/xVKRPrTHURcoRXohEln06M/c5ZifwpXbB56KFTDF5jP9usm5YY
         uT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786112371; x=1786717171;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :subject:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xDURwZe3kjAfzG+fLE3IYK+o3OP/hS+nN6qrRLsGiL0=;
        b=F8FiafsfEyk5SAJtqlIlC801Bdo7pxa6/oigAFaN+ZBTE88pFuTe2RV9WudZb9SxVm
         2yWbQWVBpG4+EXMFTHk/XIv8YFqEWi4801T3OH9+5cu5gVT9snjKU8LA2AoUzoeBkrFL
         jlNHSt1nbVmFg0ffZdQ+pF3PqBO+G0XDrkbQfpJjLhfipHk/xclviYV/Wbjo0yzjGk4S
         MnOWrvJiTdZxVzW3oveSY7VZreBcfCHGUSAFCZD1xJiXxbi/1rEue3LivAh/ezHv4hhG
         9+DhLwsYnKR5JeP5pVuamEwv8wnzVnASftfPSAGpW9g7RtcqE2EXeFFtYXnNe7hIEUKy
         4M9A==
X-Forwarded-Encrypted: i=1; AHgh+RqmaKVh58YjR+j9pVFSQpR0sKCfGs5zd4NuIv0QBgboNnvt6WXxvTQqZpYvYHXzxEM/8ARb3P0cP4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIN013+pUP9dIn5MNXAt6D7V4kyK/oPwt8/NLJvA4e3kQUKgnM
	PUXHg5X9t1v+SgemE/eoQDcqcVWdcrR7bgYR0/rZ+c6V8RcvpY5eIw7kIAYW63HtmBBYaq1UUhv
	eIMioZtEv8yZ+SE7EvIC9az+dF7SD8OJrkZEzwM7/4G9m/rXOqJSsMPHDg82VoyA=
X-Gm-Gg: AR+sD11UmUlXzJ4/lqAP6HZETrUD+VZTgr09wLVCPX9EFpIW5Ay54bQJaxnV9dG4uV1
	vMG+UOe81+HBif9VSJo8juKh6E2ULgTJaPI8LGq4yesQ3jsT0BrgJFMlYPPJR4WemEe2cm1BuR0
	wJtgjJzM+5hX4LGxlCn3Dlpcp3zoE7b3hb5FNtI3Zofpzdw9/n8GDC3N/K/vyoy0Cy/jy0QCilw
	6xnl7vICQvR9tAsw7Y6+Gh2zHVgA0f3nxkSVqXj+9Rp1Ihv9bxgeqX9t3w3aNjpDjpPtYk8FDRy
	OBAGteLurabYLEvHWoVnd0H2MuR/Am/o3o86PEzJDWy6vTZdeU+pUi0nNucgyY6harusHk3Krrp
	m27Fhj9WtjuGR86GdqyL6d7cCfN0grg==
X-Received: by 2002:a17:903:19e6:b0:2c8:25c8:85a6 with SMTP id d9443c01a7336-2d0ca712e35mr274620015ad.2.1786112371513;
        Fri, 07 Aug 2026 07:19:31 -0700 (PDT)
X-Received: by 2002:a17:903:19e6:b0:2c8:25c8:85a6 with SMTP id d9443c01a7336-2d0ca712e35mr274619315ad.2.1786112371033;
        Fri, 07 Aug 2026 07:19:31 -0700 (PDT)
Received: from [192.168.29.77] ([49.43.219.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4e1182sm9997055ad.72.2026.08.07.07.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 07:19:30 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] mmc: sdhci-msm: Use pm ops instead of macro to
 restore crypto keys
To: Eric Biggers <ebiggers@kernel.org>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, quic_dmukhopa@quicinc.com,
        quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_gaurkash@quicinc.com, quic_sartgarg@quicinc.com,
        ram.gupta@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260803163123.1802005-1-neeraj.soni@oss.qualcomm.com>
 <20260803163123.1802005-3-neeraj.soni@oss.qualcomm.com>
 <20260803201803.GB63318@quark>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <abe31a1b-e34c-d5b6-4bc4-3733acc56e98@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 19:49:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260803201803.GB63318@quark>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a75e974 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=1azyIadIo70wB74QPeCPrg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=TGiO4TNcOHy51iCl_lMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: XfzgqpW9EaAvPTxEUluSw0mkHJM13ZLJ
X-Proofpoint-GUID: XfzgqpW9EaAvPTxEUluSw0mkHJM13ZLJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX+N0jQyuuqvCn
 /iK/Wnaqazp4LwnjUl0juWwLuxHy9/PW54z6luAZjP4EJrVWjBveIiBL7bz3NrKSzAjVmhfn3PL
 rhwXjLFCM3oXYUlPKnd89KC9qbTYmSc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX9hNmm1UQPXah
 kYDA3pO8HbmG0kqCPU5CpSDdja9ZB4aGgZrKZWE3uz9VXp+6XUJS2P0oIoMioB36xNdUeOIGsnj
 Xnpsk3LXzkMsWco5eHGOlTSgjCwFc5uXpj1enapKF3JsRhC4+8OsJR9+9gwL8JNU5GVmlW/NdRE
 lyCW0jUb8W3w1eYyJJ1aYTWT1YeYAqxNSX3QGrrUrtBVizvaHxqjSFbwfN2kJf2T2BUuyCb0A4w
 j+v+0007LArBFqwVEuYSCyJO3aQ0xYRanMIDhiPI9pFF2DgnWwDm4txjhoTb9MYYrLxiu8ZyBP1
 7UPIyiGhnPOubZMAT6+2SxPCURxbOUJFyCaLjOmhpgTaBKcAHUSpIdXEitcA7pl1QtVPr4aR/9l
 vJ6hfZSxxDJQFXiOOwqD108OyunqhSfsNNFKJkD30n50K9pp9BwI9cgDMobt0sdK2wPAOqQrMjs
 BGYkzQRskHEU8lurKHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070112



On 8/4/2026 1:48 AM, Eric Biggers wrote:
> On Mon, Aug 03, 2026 at 10:01:23PM +0530, Neeraj Soni wrote:
>> From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
>>
>> Inline Crypto Engine (ICE) keys are lost after hibernation entry and this
>> needs to be restored when hibernation exits. ICE keys are re-programmed
>> during sdhci_msm_ice_init() but it may not cover cases where the
>> hibernation image is already restored.
>>
>> Unwrap the pm ops and use directly in driver to add the call to restore
>> Inline Crypto Engine (ICE) keys. This ensures that ICE is brought into
>> same state as before hibernation.
>>
>> Also set MMC_CAP2_CRYPTO_NO_REPROG to indicate that re-programming of ICE
>> keys is not needed during MMC runtime suspend/resume.
>>
>> Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
>> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
>> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>> ---
>>  drivers/mmc/host/sdhci-msm.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 4aff965f0e2e..f64788a70309 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -1959,6 +1959,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>>  	}
>>  
>>  	mmc->caps2 |= MMC_CAP2_CRYPTO;
>> +	mmc->caps2 |= MMC_CAP2_CRYPTO_NO_REPROG;
>>  	return 0;
>>  }
>>  
>> @@ -2983,9 +2984,29 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>>  	return ret;
>>  }
>>  
>> +static int sdhci_msm_restore(struct device *dev)
>> +{
>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = pm_runtime_force_resume(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (host->mmc->caps2 & MMC_CAP2_CRYPTO)
>> +		blk_crypto_reprogram_all_keys(&host->mmc->crypto_profile);
>> +
>> +	return ret;
>> +}
> 
> Sorry, it looks like this actually does need an #ifdef because the
> crypto_profile field is conditional.  It doesn't need to be a new #ifdef
> though, as you could add a function sdhci_msm_ice_restore() within the
> existing CONFIG_MMC_CRYPTO section of this file (along with a no-op stub
> in the !CONFIG_MMC_CRYPTO section), then call it from here.  Similar to
> how the existing sdhci_msm_ice_resume() works, for example.
>
But MMC_CPA2_CRYPTO=0 if !CONFIG_MMC_CRYPTO so crypto_profile field is
not accessed if !CONFIG_MMC_CRYPTO. Does it need encapsulation?
 
>>  static const struct dev_pm_ops sdhci_msm_pm_ops = {
>> -	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
>>  	RUNTIME_PM_OPS(sdhci_msm_runtime_suspend, sdhci_msm_runtime_resume, NULL)
>> +	.suspend	= pm_runtime_force_suspend,
>> +	.resume		= pm_runtime_force_resume,
>> +	.freeze		= pm_runtime_force_suspend,
>> +	.restore	= sdhci_msm_restore,
>> +	.thaw		= pm_runtime_force_resume,
>> +	.poweroff	= pm_runtime_force_suspend,
> 
> Should these use pm_sleep_ptr() to allow dead code elimination when
> !CONFIG_PM_SLEEP?
>
Ram can you please check this. Looks valid to me. 
 
> - Eric
> 
Regards
Neeraj
