Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E641A4FF
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785501893; cv=none; b=SsTcKSSTvMl6McmvutYNsQfgh2LU1L3yAhq/Y2EHGJZ9zluPDO75i7BXit4yjzBrj554a/Fw7EYmjRbnwvNqcr+Ls4Tfa84IXItH1EAZzUVQwwHmFeTUCO3SwcO+3/piX1tSR0oZt6TbHx5Qnl8FIq9KpoXnwmw5IGtReoU69aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785501893; c=relaxed/simple;
	bh=X97priWFVd19LqfTh3m73k+VBPwNe9QzrWt7zmZfLa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6USAHWblLsa3jozIX4xQwe2gs+MCC0rKBR8pLwa7vWENNm52UqFkH0G6My0lSuCqGqUMLDvMv+eWK7cu2gEtIxPljve4mYftzZIWHV0R8fFkr2aR/niufCZa3gEiNv1Iqbwv88U+hTX+S6jBHIQoVFWxDQ2827mEaeftDsZ9wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IlmsAnYS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BiD1BR0V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IlmsAnYS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BiD1BR0V"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBa05x3742175
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 12:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e7iwD9P2Zx9P0OLE+pti6an7ZHWAOnzsmQ+vg7bnedc=; b=IlmsAnYSNMVKNJ3Q
	y0To/RPpa2TGkAyVdDn4v8ts8DD7Lau5KPoXfJm7spNupW2WotyNDVqjSO7kVFnC
	5q2i0EZWQap4gAxhbhY7ieRdH8YMP1y1vrme23yGEpN+rdG0qrtJH6hRxnB5SUg5
	bK2Uy7mfdPL9ZPxKCjTtrZtAGC417YKu4xrospVcP1Nh2MBh1rKyP/CibmobZVAS
	h2LpSJFGmerknEnavoXyLDbrojC1iUFWIndzlGj37Oj1vTtTi6U5tqbG0LfAqlQ6
	U0FYJf5++GnPR1rRVRBcH8fCQ6rp+OeTm3rZ00G2lhGB41JIpH6jPl2qOcpjzBKH
	87gh+w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frtyqg7w2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 12:44:50 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca8aee88725so1418839a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785501884; x=1786106684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7iwD9P2Zx9P0OLE+pti6an7ZHWAOnzsmQ+vg7bnedc=;
        b=BiD1BR0VZz2E6d666HzWP/Oxpyv4txXU3Eas/nt7xv5JF83RWsiOb/KvE1+pvonwt3
         rIjOSTGlZ1JbWmFqRhWzHTAfvAtl6b9ZIJ6LuZ7mn4pL/IDaPivLvqpCo/Km8bwu5lND
         9/q25OBr4H/BqKd0EPFHSak9GdEp7p4ZZyBVx14IiQUq8MS75K6x4GLokxUmqUB8yTV8
         egGXk0ZPQXwGN3R+AYpbNi+5oOFZRN31wAcSXnkE+iCGjpExJSa/JKXAyfAI9RGapqkV
         eZHFLxsDFKLIAXMDAhSP8NdYZeHB7GxRvKCTVeNWkwZiasZ7Sb+vSbYHohG0zPBeEDKO
         IZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785501884; x=1786106684;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e7iwD9P2Zx9P0OLE+pti6an7ZHWAOnzsmQ+vg7bnedc=;
        b=W4TmwVgDGlfVlaDRkIsYQnhVR/4+jMR3lOu5sQLE5MHgPZZcpfyKsZ7K38CRGJiCmh
         VEynohMAjH69cYHDEV64h66ysAkPlnwFP9YT+vp7ygUBpugRPlXxTpTpVt2GUuOx1WFN
         3y+GpztNoPNb8DDCnl4Y502V+lq+Qyr3KztAo4xmFkatcTWQnLUTMDzVn3tQEWzKtuXJ
         rlBNMsSBrDuUnIqNc1eLH0p4Re84BDe0E6aW3XbSmUAxYXzPjO3KS5BkykBiCq9lCXmb
         esLG233zbSQ2WJG4YmydJ1UpRKvmn5Mxh+63euc/qkrqA6Zi5qhEALKV0aDZRBRx2/4g
         hCfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYbZ9NSD1nu75uM5wE62PkHQ/zO4NSMTx0WNRLZklOfAnmDT+yGsiDF9sswc/rxyYZYyUNi9gzT0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5jBmoNaKbyHKdwrhASqKCnhRja5y5FuRGFEel3xH8omKDPN7D
	sneHwOufLiJDb4wyZyHcB6gItDlXCG77g5vtb0GjD19kftKG2N+oxz3btrmdNaFdk9Wxqk1u+eC
	HtrpYgNse9ZICf/oHzUR9apAMx+1tBi9zaJq2zb/xbN8YIdXQ8HHyMO23AiwxRQ==
X-Gm-Gg: AR+sD10TLMYROi0tIxOF/OkPqoRrUJ5vckIhUZ6rE0YVjQB5Vf9RwyKSVVoWf0tbJS9
	wRk4NdqjIJvRPaA8IhYY6rrhWC0LZtqjzWyVystCMYgXNqVVlR7xmz0p0EWXVxO/d31hCWQ6N8A
	oQgx+mN7XiAzNCCLYomRp3Hj9SJJXHimJ/llvI8grGQMqdEKNYWBAp0SgbffkDpXt5ZdXbPCP4J
	u5jTJgKLx/4hhxZ6jlch7mKnXPh13V1NDiV/UIksvujC8BAkA7GeWnMXqynJpKlgpRjv+kwEIXS
	lpgHZ+m0nzEjzQUBksbszW5I7YzvUTdMbyq3Ar1JuL0C+fF9vDtUQ0QgH7YKtgucemBgfs3QMK5
	8VgwKrZ7+I1PQCLW+bzXTVYFR3g==
X-Received: by 2002:a05:6a20:7485:b0:3c3:8d86:9856 with SMTP id adf61e73a8af0-3c91b0a96efmr1875051637.14.1785501884509;
        Fri, 31 Jul 2026 05:44:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:7485:b0:3c3:8d86:9856 with SMTP id adf61e73a8af0-3c91b0a96efmr1875021637.14.1785501884079;
        Fri, 31 Jul 2026 05:44:44 -0700 (PDT)
Received: from [192.168.0.203] ([49.204.22.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab050d8csm5503338c88.0.2026.07.31.05.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 05:44:43 -0700 (PDT)
Message-ID: <5af5ea26-9cf6-4cce-8cdf-7b5acb773608@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 18:14:36 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] mmc: sdhci-msm: Reprogram crypto keys during host
 hardware initialization
To: Eric Biggers <ebiggers@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, quic_dmukhopa@quicinc.com,
        quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_gaurkash@quicinc.com, quic_sartgarg@quicinc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
 <20260730140822.1976635-3-neeraj.soni@oss.qualcomm.com>
 <20260730191823.GD3139@sol>
 <6c795412-ab63-22f9-0b64-8bc746fc2773@oss.qualcomm.com>
 <20260731061246.GB57540@sol>
Content-Language: en-US
From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
In-Reply-To: <20260731061246.GB57540@sol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NSBTYWx0ZWRfXwwPYJ9fYhq9V
 lSzpsx8dY5QAi+m6UwbM+Wr7lWsqSl4j/oxcAkReF407GO2Y1GF/y2sTQtZrG9cNd8XTbg9upIw
 xLYjK3GOkBsAYB0mIJCI3tQ2JjcGbIatj5uPrprNFCZ0FJDslJVE4/Pbz8NDvp/btdtWoWif9uc
 KfI/sMixo96koh4IC4sUFXS+lFcFOLzSvyqVKjpEEJGW/UHSfdJgdnV401eYWp3mbQMhwIAhNNK
 jpwOQ0sxIvPnl4M0sHUjhgejrgypHykHidYyz8r0K1fATbonGYdviRTS+7vRVPlPJlVN43ggZko
 j1dhG+eD8ne1epYFq007EdgCuPMIHbvb14o5XedhbNTdBQTCv2gdgA3/XyspYtOh8UsYrDjSaxu
 xqeds/X+c5lu8Br8CHgmyguJqJOMJhwPHomYRzG4xMomHXBkOVjB3udPuexcbc4S1mYgNxsYdiL
 SkaM5Sg1nYcgojwzMCg==
X-Proofpoint-ORIG-GUID: PJIyR_8z1QMvwo6HyygCrwojFG2KJFV5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NSBTYWx0ZWRfXzgu5xrIls5Rg
 i/YYgos26QO4qtm6b9/YUf8W3OVd+pXqt/P7x2jAFRjD7Kf2hGL5ByMQ1p4wuRsUJKvLzyXe7hG
 dWP4ADkg741U6mSUvuRLg2zoJDJ+1ck=
X-Authority-Analysis: v=2.4 cv=YaGNIQRf c=1 sm=1 tr=0 ts=6a6c98c2 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=wB/OwOWguG3OqMiIzyR4iQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=LDBv8-xUAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=F0kIL5trOhMd4AhgnAkA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=DZeXCJrVpAJBw65Qk4Ds:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: PJIyR_8z1QMvwo6HyygCrwojFG2KJFV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310095



On 7/31/2026 11:42 AM, Eric Biggers wrote:
> On Fri, Jul 31, 2026 at 11:37:44AM +0530, Neeraj Soni wrote:
>>
>>
>> On 7/31/2026 12:48 AM, Eric Biggers wrote:
>>> On Thu, Jul 30, 2026 at 07:38:20PM +0530, Neeraj Soni wrote:
>>>> Host looses the Inline Crypto Engine (ICE) keys during hardware reset.
>>>> Re-program the keys while intializing ICE to ensure that ICE is available
>>>> in the same state as before the hardware reset.
>>>>
>>>> Also set MMC_CAP2_CRYPTO_NO_REPROG to indicate that re-program of ICE keys
>>>> is not needed during MMC runtime suspend/resume.
>>>>
>>>> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
>>>> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>>>> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>>>> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>>>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>>>> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
>>>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci-msm.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>>>> index 4aff965f0e2e..7d71dc6f388d 100644
>>>> --- a/drivers/mmc/host/sdhci-msm.c
>>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>>> @@ -1958,7 +1958,10 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>>>>  				cap.sdus_mask * 512;
>>>>  	}
>>>>  
>>>> +	blk_crypto_reprogram_all_keys(&mmc->crypto_profile);
>>>> +
>>>
>>> This still does nothing.  The crypto profile was just initialized, so no
>>> keyslots are in-use and blk_crypto_reprogram_all_keys() does nothing.
>>>
>> This is needed to address those scenarios where device is running in a
>> stable state and only the host hardware goes for a reset, for example,
>> to recover from an error state or stall.
> 
> Nope.  Please check the actual code.  This is called only at driver
> probe time.  Again, the crypto profile was just initialized, and no
> keyslots are in-use.  It is a no-op.  Maybe you intended it to do
> something else, but that is not what it actually does.
> 
> - Eric

Hi Neeraj,

earlier change for blk_crypto_reprogram_all_keys() in sdhci_msm_gcc_reset() was required
when .hw_reset from sdhci_ops was overwritten with sdhi_msm_gcc_reset internally for robust
error recovery but this changed after https://lore.kernel.org/all/20220408080045.6497-4-wsa+renesas@sang-engineering.com/

we plan to rework recovery soon and we will take care of key reprogramming as part of that.
For time being you can drop this, as Eric pointed out, this is redundant.

Thanks,
Ram




