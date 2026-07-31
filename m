Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B158353A92
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 06:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478074; cv=none; b=pM6Qe+5w0+giscUplJ14xTv+bvO9xuaMsSMu5FVwAuF0h5V66BikWuFY4ipSxr12xDmhhoq09ewm3Goye0ubA9LJi8imEWhgZSlMTYa4ismwDLbEgg/gUdnpORTWA6lMj4o9YKNh9gFbi6YOQV4ka/lyEziAAzDvN5vtQJHMsZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478074; c=relaxed/simple;
	bh=NPgDZWp0zjQsX8p2iQgy6uXQRmUxzcpHU0jWoUp+/g0=;
	h=From:Subject:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=N/Tm6Z7kfSadmMpXlRLeKZ38zXBkpyNUTmsqADoqcnYXhG17f8YI20kVs2A6wgKMSLGZoM/RzL8CDKX/yI5ETi3o85k5G8yIs3L8upuDSmURiaGXK1LtWGulJCbxuv86P+mb1YN29qROzucnCq4q9sT/r40oZAPJeqJuLGKkfLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X2WFzYbZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KIY8zlx+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X2WFzYbZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KIY8zlx+"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V4utEV3277936
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 06:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cBTysN2GKJ41mcelD+ifbRYjVUJ9bYWfxCx14PKUL/k=; b=X2WFzYbZrtKhMHY1
	D3Kiba+nZpKXKJ69fDhMCIOxnU5KS7ovHs2+FGhXsCWSons4VNxIw+vO6bdYtwur
	eWusiunQkJxiT5JQ3TW6APSPOGbT/hYceMHFcBHEyLodg+dYX8QdqEzPo6v6nQD3
	2yqFEoJ816vOz89XKQ69unkDZAiPn95CyCe1tBFs0e30nkPBLpxgkkO86OlzW8pJ
	SNgw1p8i6u9UTfjqBKJ7/00IJlvemreRWImrDq5yDuoJaJgwRMfU+Nr4/BAH2XzP
	qKcp/lbTFvLKMKZlE6dsstIcxlD9kn1rzexlNW464KxjeLXqpHbH3Z6llWzstoJw
	m0OpSg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frn0f8868-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 06:07:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so500018a91.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 23:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785478071; x=1786082871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:references:cc:to:subject
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cBTysN2GKJ41mcelD+ifbRYjVUJ9bYWfxCx14PKUL/k=;
        b=KIY8zlx+kmXk7Do9pumkLKR3lti8UiQEXQlE4dY7bOEicsOZtZEShBUzvHinFz4/22
         qJ5SUUsZViBBWDv/a4ub8tXWb+dejjdvVywHg3/fQeYvtM88i/uvTWnM6w9tVquCVSEF
         GU9YtsYHEMLotPjOHtcBkSW3+cfhoOhLU/Cd5AFxluwpV91KJfgTlPYI+1wFzQkuekMV
         8b3s4E+W7opXvoUFSiB0hy64IOiSFjr7WeBTIo3Q/9/8THdiDQJ4IDB3gYwOemiOtYjJ
         qBKPhbZHcQaXAtvF7UW7b9+l6dsSrP+jBCbKavGKQNlVU2scOYl/HzbGR+GX4AfBb8Gj
         x33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785478071; x=1786082871;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:references:cc:to:subject
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cBTysN2GKJ41mcelD+ifbRYjVUJ9bYWfxCx14PKUL/k=;
        b=W7vJtuoS547NG1jzrhLPB54gktabflauf5fYd8cQOEyZgUzIXnfr+nTYSY1Es5AaZL
         zhyskiFZ/Xqu1X39gVzsNGpamALtVf9k5U3A1mGW0HrRyWOxkyBoEOeZxKGkv/SObTP+
         MwEkCQHt6xzJ6ZRQnVl9YkqzU2lKrnZVu7VILy91J89v/tUZoG1E6SRwCNp74NP8ef21
         BoXKh419rxD6IF5FPj7+ziRjm0Gy2KD4JvgIcty1rz3mMGIWgRMvKf4cUJov7+FxZcdu
         U3nGU44z8Ru8ocfhNG6yCQXOGIzrIZofg5tv7ap11DIVuGV+7CWYnDdRW08hOV7KVzgp
         A6xw==
X-Forwarded-Encrypted: i=1; AHgh+RrDBAidB3sCXqIa2WfgacVtKoG+ytLrW40pdq2tHlq4n/rCB9KFFW3cn+q4zel5Cp7bSQokIay8CTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0BsZXVGNRchAX3hC7clJy5ULqN1xmqPvSGyC8OczqBHCTN5/8
	75uz1clJsASAf7JdGa9aZcxJuZ0JNTsmad9mQTukpFbcyNQO4aHVAQW3xfp5kvu3GRZEGICDhvw
	8z0usqy11+7TINwJcfDQjkId1myWAUWalIVoaBCFnbUV39MgAF46K4E19ZDqcACo=
X-Gm-Gg: AR+sD12gtPmN4cSMOsLPaTbOMJ+2ICIXicu1+jRh7TFOpOVFeLkYwCwRXOGsvfdAC4E
	bxURY87td2qMkGp7seEssMIHO7zPA9895E27E8z3CIDVwS8dJF1zlD1N9VUrCXaKzNFOK8lnq8c
	XIGtvWo15g1KrrQWqakHWlM++5zvP9PtKwoK++xTC6luQb8fRxsfNHy989TnYgn7rAUb1BGqXY8
	gLZoyRVH7xJSFxvW5PXnIJOtfnfBaADok5tymJzNayGlRELG7AKMF7V8BIs6N+HX/CCK//SBdQR
	nj2vCEtIaxnUXmNRnzDNNLnmQ7l30J990swNcXpOsl7ySJ3TBD1o1RZg/hyzVf6+/d/2RFrpkYC
	G1W2DirzFqYZ72e7VMYGPzZOEn6k=
X-Received: by 2002:a17:90b:1e41:b0:38f:5869:387a with SMTP id 98e67ed59e1d1-38fb11d7b39mr731138a91.8.1785478070810;
        Thu, 30 Jul 2026 23:07:50 -0700 (PDT)
X-Received: by 2002:a17:90b:1e41:b0:38f:5869:387a with SMTP id 98e67ed59e1d1-38fb11d7b39mr731094a91.8.1785478070245;
        Thu, 30 Jul 2026 23:07:50 -0700 (PDT)
Received: from [10.218.4.105] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2f65459sm210656a91.6.2026.07.30.23.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 23:07:49 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Subject: Re: [PATCH v5 2/4] mmc: sdhci-msm: Reprogram crypto keys during host
 hardware initialization
To: Eric Biggers <ebiggers@kernel.org>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, quic_dmukhopa@quicinc.com,
        quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_gaurkash@quicinc.com, quic_sartgarg@quicinc.com,
        ram.gupta@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
 <20260730140822.1976635-3-neeraj.soni@oss.qualcomm.com>
 <20260730191823.GD3139@sol>
Message-ID: <6c795412-ab63-22f9-0b64-8bc746fc2773@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 11:37:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260730191823.GD3139@sol>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0MCBTYWx0ZWRfXy2527ijPHl/B
 sZdkj1qLritrZg49VX/ktXhi/X5fw0ziICYaA/nI2ArWsxe7Ydfmc7FuXCGUeTgz8+PL+a/kg/s
 6rGjRQ6p2fryJj9HA1FAyi7FNz0K7pc=
X-Authority-Analysis: v=2.4 cv=HJTz0Itv c=1 sm=1 tr=0 ts=6a6c3bb7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=j5mz3ktRbTo_uisptNEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: V0nISMbPArAzyPfM0E-gCBaWgfF838lM
X-Proofpoint-GUID: V0nISMbPArAzyPfM0E-gCBaWgfF838lM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0MCBTYWx0ZWRfXzh6LCQdpPh97
 vo1rjObcR3/tc9OB9BXBCdGQ75HBv7P9O/iBD/v9xE44UulpCrGTo9Y8vj22Tnu+a2T/so2AEY+
 LPtKxUUEdtU0vLINnZRHA1gmlb8KXVgKS1O+anLBDQk7iQ/ElkV3F+S62kIw5PooWZJL5BZWe+D
 3nuzTOk/9+CbB3nJVxVS/Y+5pX2JXB3Lgfqe9wt2XToyqRgxjUYpSHRQZ9+tSkWoeEs+2q5Uvv6
 LeoYBfvq2uRiqJPc4BT9z99GP0UuPpoNnk+2YZClWBrVQaiJO9PshXlGNF3u8gpQq37OHWuvCf1
 yIWsSYDA96AZ8C6J2zLsDjTHlaQAhsx151YhsMxYu23QUfI9no8Z4nL6VweW7mab4PkFow9ESZ+
 2I3i0awrEAlyO06C8TedBFhNThUIunwN6Qz1rpCRF+ocjo8hRlRI+rR7FSQTTr4spJCYbOcoPzb
 4lBTOHTBdjZyTQZrNKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310040



On 7/31/2026 12:48 AM, Eric Biggers wrote:
> On Thu, Jul 30, 2026 at 07:38:20PM +0530, Neeraj Soni wrote:
>> Host looses the Inline Crypto Engine (ICE) keys during hardware reset.
>> Re-program the keys while intializing ICE to ensure that ICE is available
>> in the same state as before the hardware reset.
>>
>> Also set MMC_CAP2_CRYPTO_NO_REPROG to indicate that re-program of ICE keys
>> is not needed during MMC runtime suspend/resume.
>>
>> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
>> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>> ---
>>  drivers/mmc/host/sdhci-msm.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 4aff965f0e2e..7d71dc6f388d 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -1958,7 +1958,10 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>>  				cap.sdus_mask * 512;
>>  	}
>>  
>> +	blk_crypto_reprogram_all_keys(&mmc->crypto_profile);
>> +
> 
> This still does nothing.  The crypto profile was just initialized, so no
> keyslots are in-use and blk_crypto_reprogram_all_keys() does nothing.
> 
This is needed to address those scenarios where device is running in a
stable state and only the host hardware goes for a reset, for example,
to recover from an error state or stall.

>>  	mmc->caps2 |= MMC_CAP2_CRYPTO;
>> +	mmc->caps2 |= MMC_CAP2_CRYPTO_NO_REPROG;
> 
> This seems to be the actual point of the patch, so let's simplify it to
> just this.  However, this is also broken because this is ordered before
> patch 3 that introduces the actually functional key reprogramming.
> Please drop the no-op call to blk_crypto_reprogram_all_keys(), then
> merge patches 2 and 3 into a single one.
> 
The call to blk_crypto_reprogram_all_keys() is not a no-op as clarified
above. Hence the changes were split in two.

> - Eric
> 
Regards,
Neeraj
