Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BD346A18
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786436347; cv=none; b=PdrU3ubh57kMFehek7gozmZ3m6M/Ryq8FsKY8wltXEBNADD2PF9WYpvd8/PybLTuqCq26GrZjJmLqvgGLWv2PWlkYAF8tKOKERXFPBpUahuCS7crxLFJ50oe7QSBqzgO9Q7XcYUUlf2UrZVfGCEV+rGZO9oyo2iRFaXipYFVpYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786436347; c=relaxed/simple;
	bh=9WYPjPnSCqTOYaZfKb+Y6giAEZRt89I5Sq58ekgoyL8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S+PLbfxFE81UH3YAcNVY3h6JkdPEbiqOWE7Z0oAV2MTpyx6IHfL9tPvQC20n9qt2P8PIwjjmGI6+o1unwoLvpZ3sSvfZGNxgMYoDIm6QwRnCelaLgo/XztQR9Qf2hWWdfCu1/zej6gJ8HhHcbs06lkoObhzlutYSYViN1wu1eGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PMRSjrn7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U8dRe8iY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PMRSjrn7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U8dRe8iY"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B7Cbia2253080
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 08:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xuTk3uba3lRMIgMoGuctkRArsnjSUfXH8lZvrtACOT8=; b=PMRSjrn7JsGkMM3A
	cZHzTJh5xWAihqPjFetT90F51SYklRkXgsPLNPU3PenvZatA7Xx//rzZetkTeowH
	Q/U3xnTnV5osqz2SanZ6tJ4FKwcwFqq4KXUdEKThPn8H2oEwVhXw4UEZk/KrwSf0
	TVKp+5IyukowhiAYCI/Y7dR4zuBBUjSFLS62D9nE5QP8c6wt/hFtu4fwHn7tXr3Z
	0A9X7lGmnlH3/EYGkg6BcjQjyJF3iURZWw7wKDK0kzkRBJKF8SRfIQd/FUJzzrFc
	8eD+6ySrQ4rmhMFMEyohi43JAXnOuE+TJhWRSPnJm/L7x01e5O83w1ngubIuI/uZ
	6lWI6g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk7b5uk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 08:19:04 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8488ac68185so7488214b3a.2
        for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 01:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786436344; x=1787041144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :subject:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xuTk3uba3lRMIgMoGuctkRArsnjSUfXH8lZvrtACOT8=;
        b=U8dRe8iYJHopWh/9YI8SRGHaIw/A+nhhTzXx9Q2oh7eTW0SqaqA0UBUTNLq1wtLmmV
         N0DE2RCes/SojJmqtofv92WODwJdIOwuSfE6UKfDp1JwfqPD6sGgPzBxKqVohYRXFUKr
         9puLY1CvMcPVQgWmRdN/IEXKWGfn8I+8KtWTuSNCkvG6IVvQznAGZoqQtWvKIezr53sw
         DTB/V+lNPetWSC8FvaRv3KiZSeTcadkChdIPGLCIEzeTDpFCG9xyGrHSKqBbalicdpjo
         YhnPYEAxarqi6BRjqHI2xuJAJjZZ1PDlbClhRn2HWIImCyY8ZjZn5xoAhXcrMPoI2So3
         pDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786436344; x=1787041144;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :subject:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xuTk3uba3lRMIgMoGuctkRArsnjSUfXH8lZvrtACOT8=;
        b=qLGP6iSC/qJChg3NKyvqiYXpOzldhPXwKrAyRKFumznBFR1RnfybUVFgNsSHZ2KBCm
         nOdOoGjwsq9NEMt1DO3zAglKTR1qUh/IdJHNrhb2VDjALxpwUz/Wgg7Mk3a5Zu/xzRy6
         bCV0bcm4T3/XDjumwnUSidZx0/NwUIPCP72OYbMnHyHhT+D7Qr8u9Gf1FFNMpKlpEtYZ
         LxeKgI1FNNnVbgdXQ4FfUncRJV2J/i8xocDF99WeZN7gSx+BmyFFlqcdrIb8ujuCvC8h
         q3yoeqsN6HzvwNUiLvWGSCVEtNa/x6apcgbWY4466m7SE79jcJxdsREJ19R4re9b08e4
         sJ4A==
X-Forwarded-Encrypted: i=1; AHgh+Rq8SwQnle/HBKSAtTK+UpQ8udWj4yuL3URNRiiwyN1KtXbWpR7Yq8CH8XdqBe8aRbWOVzJttvLTjZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQAdRa8n1SRiiH/6CC+JOsT/uqdT+B0z5K0FT8vnWzwXax7Ze7
	z/kYVM6aRTGqVzQ4BAKAtS0aniEgG+jbQwWPvaIVGpofTH96Z6r9CM0U7XC90jwAXt7xdkioJt9
	oNbgTA5+JJYsd/zNlzUzD/lxQmAUWFf2vEEHM7XcxJf9lPNYmwr12r5INc97aTJg=
X-Gm-Gg: AR+sD10S/6O1Ztou6jXyPuWjj5RymsY+dTat1WiLdiuPgYiOulNsLIrXkebGy8kTDAI
	oRJhCmFhAVcAF88RrDiUaxgcivsS1V82DURIWuvfDec9YBzMtrHO4tfw5+ECzuXO4VDeMJ8oxfI
	VMBYTYeBliDFBfOdSwTcsY027GjPLjUebQZvMsaN/Kndbt4JmkJBhWwxBOE8xoLndvbS03qakC1
	gFXbxgNbsua0zWAYwkMCb8oFZnLit45EGpK/RJqrQ27HYJkdcx/R2VGbnpK8Zn3jx0VVLUb0/64
	i/ZY73LFVjtTMQan4E3YB880zMrAQvemV5P6f6Cg1H5tJoV+57XRg+k1KWoxlhX9o2FUTu5ulp5
	99MvSa7pVBgQpSpt1nK8mjtRnPdw=
X-Received: by 2002:a05:6a00:27a0:b0:848:469b:3d19 with SMTP id d2e1a72fcca58-84fa8862242mr1174662b3a.29.1786436344001;
        Tue, 11 Aug 2026 01:19:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:27a0:b0:848:469b:3d19 with SMTP id d2e1a72fcca58-84fa8862242mr1174623b3a.29.1786436343523;
        Tue, 11 Aug 2026 01:19:03 -0700 (PDT)
Received: from [10.218.4.105] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa919482esm319894b3a.12.2026.08.11.01.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 01:19:02 -0700 (PDT)
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
 <abe31a1b-e34c-d5b6-4bc4-3733acc56e98@oss.qualcomm.com>
 <20260807170007.GA1172969@google.com>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <e8e3a6fe-debc-d412-08fa-04ff000455b6@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 13:48:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260807170007.GA1172969@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yus/gYYX c=1 sm=1 tr=0 ts=6a7adaf8 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=brWs0jRP4jXds20Wf4MA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ckwtBcQquGZuVV3NwGirSjyP4vDqGHVk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA2OCBTYWx0ZWRfX5ByjCaI9tcfx
 RqX+dhYxLIsSEwGmggVWsF9E9vNjs0XdA56KU7FygoVs/p+dBASQ1R9dwxaFDJNnbUWP7KiozbH
 j9YvEifjf76cH6EgpWybMTGFgCAZlcUirnH64Z2Z7LP4jF2R1pV5hCmvsnPB31JkH4/jQX3NFoj
 fZhhyPH9/7O6G5A11pBEWWLv6qzDdzLT0XAgaFJB75aEm3a2pWbTXu0JCHpRiwdYSUVyvRdn3sM
 5KxkVHsrwczF2kkgKGZjkupqD9zNkb91fCvCHX+pbtsiVqeE7ipLj7tqhau5fb9Mi1mjOEHXT6a
 g1HO5Ls+vGf1jDgKLi4gqFs/j/hgWwCvxqfikI5D82krZJ73brM6d8pPbOi1V9gpBfVOIJvYCDn
 HX2t44QxLqHDhztIX0lGULp7TE5ZKeuDU3GjDlyLnNQezpwwPnN/g396HAJeX77QcR5XeIg8TZ0
 wGKOTiXSabwGe3GdpZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA2OCBTYWx0ZWRfX18JoHrpmF/kz
 EcGaNy44E4ZqY23rUGQQECWHZClzUdne3GBTq5YdDY13p8uBrcDIwD5dFBHit7J0LVRGnau8n46
 bkVsJ8QGF7lfG1kwr+U2xk+GMspj/1U=
X-Proofpoint-GUID: ckwtBcQquGZuVV3NwGirSjyP4vDqGHVk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110068



On 8/7/2026 10:30 PM, Eric Biggers wrote:
> On Fri, Aug 07, 2026 at 07:49:24PM +0530, Neeraj Soni wrote:
>>
>>
>> On 8/4/2026 1:48 AM, Eric Biggers wrote:
>>> On Mon, Aug 03, 2026 at 10:01:23PM +0530, Neeraj Soni wrote:
>>>> From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
>>>>
>>>> Inline Crypto Engine (ICE) keys are lost after hibernation entry and this
>>>> needs to be restored when hibernation exits. ICE keys are re-programmed
>>>> during sdhci_msm_ice_init() but it may not cover cases where the
>>>> hibernation image is already restored.
>>>>
>>>> Unwrap the pm ops and use directly in driver to add the call to restore
>>>> Inline Crypto Engine (ICE) keys. This ensures that ICE is brought into
>>>> same state as before hibernation.
>>>>
>>>> Also set MMC_CAP2_CRYPTO_NO_REPROG to indicate that re-programming of ICE
>>>> keys is not needed during MMC runtime suspend/resume.
>>>>
>>>> Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
>>>> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
>>>> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>>>> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>>>> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>>>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>>>> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
>>>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci-msm.c | 23 ++++++++++++++++++++++-
>>>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>>>> index 4aff965f0e2e..f64788a70309 100644
>>>> --- a/drivers/mmc/host/sdhci-msm.c
>>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>>> @@ -1959,6 +1959,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>>>>  	}
>>>>  
>>>>  	mmc->caps2 |= MMC_CAP2_CRYPTO;
>>>> +	mmc->caps2 |= MMC_CAP2_CRYPTO_NO_REPROG;
>>>>  	return 0;
>>>>  }
>>>>  
>>>> @@ -2983,9 +2984,29 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>>>>  	return ret;
>>>>  }
>>>>  
>>>> +static int sdhci_msm_restore(struct device *dev)
>>>> +{
>>>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>>>> +	int ret;
>>>> +
>>>> +	ret = pm_runtime_force_resume(dev);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (host->mmc->caps2 & MMC_CAP2_CRYPTO)
>>>> +		blk_crypto_reprogram_all_keys(&host->mmc->crypto_profile);
>>>> +
>>>> +	return ret;
>>>> +}
>>>
>>> Sorry, it looks like this actually does need an #ifdef because the
>>> crypto_profile field is conditional.  It doesn't need to be a new #ifdef
>>> though, as you could add a function sdhci_msm_ice_restore() within the
>>> existing CONFIG_MMC_CRYPTO section of this file (along with a no-op stub
>>> in the !CONFIG_MMC_CRYPTO section), then call it from here.  Similar to
>>> how the existing sdhci_msm_ice_resume() works, for example.
>>>
>> But MMC_CPA2_CRYPTO=0 if !CONFIG_MMC_CRYPTO so crypto_profile field is
>> not accessed if !CONFIG_MMC_CRYPTO. Does it need encapsulation?
> 
> Yes, because 'if (a & 0)' just makes the code under it be optimized out
> and able to "use" undefined symbols.  It still otherwise has to be valid
> code and refer to declared symbols and fields.  See my suggestion above.
> 
Ack. Will fix in v7.

> - Eric
> 
Regards
Neeraj
