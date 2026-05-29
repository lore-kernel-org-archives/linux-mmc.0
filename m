Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6043CF952
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050967; cv=none; b=KuNWheb47SH9IsrUe7e2Azb2lTu6w8A/jS0+E/838uGFx+EWH0dkZenTioF4vbY10oyLbGB319N+LUD0k32Mq29oYiaTd6NR3V0vFXiU/Vg5bq7Fz0sOnJ9i+ABembXI747YQK3H616UOtdtfcj8hYDikhwoU1OGqc5paxtktAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050967; c=relaxed/simple;
	bh=+9rpX/DFxVHZeYFPP3+WLKNg/YmvRkw2TGkdsj27Rfw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S44tNJ+g2Z45BzQroBQldZbCgYjuRGuLCLyatW5eMtVPRDb4heoUQd7sdYhfIn1Cdo54nwkKnp3v+puKi6kJ0HFSvt1aQZfOgmULWty9Fv4glyAq4Y4Kc4I8EbjBB5ixxDwbAWBUI4zYE3TA0FDS9+CWLBgmNgRCe38XZX1XTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U0ab7liH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AYZFlikT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U0ab7liH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AYZFlikT"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T7W8s12255453
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 10:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wRJVV/3vf2KXL9Zksz8u3vSgFjyxnFTSi1sl5HNmlWw=; b=U0ab7liHAi9gYGXR
	RyeT+fGAHqfIMsBw02GGTcKmMq/z9F3srBjZWLriOkJa680ZOeoUjmX3zOgnvYw2
	/35nMySicYQSUFTKjESEpuEtdmEwsS/pByqNGrBOb4SVcAI1QSzHU4zxzWW7k4hG
	afN8M6k6Ep+LQPafKe9AGfG7nMNxMvRgg5LQKqqvEXd/JVGnmTYKchh1w432vno2
	jWZrGOECH08xK8BDyHDnvKYkv6BbogDVnO8jWyXsUt+4R3S/Edkuk1yQWItYWUrt
	8wVDkW+w9k7r5fQinotWoBrUH//+I98+KUttnpcS6OW6TTuS/sgpXiDT/7WitAJD
	xSa12Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety53n32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 10:36:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36b7c55406bso1536683a91.2
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780050959; x=1780655759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRJVV/3vf2KXL9Zksz8u3vSgFjyxnFTSi1sl5HNmlWw=;
        b=AYZFlikT8EqrfN9EpXfxrocePMp4NsmqOkV+CAamrhvmVrNNrvlBKHmbsbVgw7P7AR
         34sQybl0UrD9n8cb06zvDPIumcVyD1lGhfVvwqdq677q/eh4eM45K6ukRixnbb6+3lPz
         KRdpplntnVxvAsSC+7YTxx96oBClcOELcBWhWW8KO/74hAKBWnD8LUH1FFuxA3/qHHL9
         4Px90sXuAijU+RA/4LROIZcj8UD8ipGJj8UhkSee7qzyWcOUudfvTYGcpTCHIHe6mep4
         q1BQjTeHpgWE4neqHk+hRTqAFefhkhMDPUScMZvd1g6MSBG0Mx6VbpuaVP9WSiQtGjXw
         WOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780050959; x=1780655759;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRJVV/3vf2KXL9Zksz8u3vSgFjyxnFTSi1sl5HNmlWw=;
        b=lWPzI3Mhqfw2izfp0HDZPONuwNOpUgBDWrILD0oDu1yGUSRyLKotWqQHoNzZrswyxG
         TWZlaSxjT9f+MzfrCicuw1vA2IVcCGE6dikZhm8OPJhgqaZNRqU3H8kLT/NOQMtflmD7
         BvXJT3j1ZVTDdNuVsYdZ6E4pEV0AK4NbhVlNpyyrgsfqcKreatusLPD3VlqY3xB/lfJ3
         S6D9FROAFXQtxSt5UuKcfxcbjn7+1nVyIgdM5OWJGZMgdWDdERU8jhsAAwbbjG7EXbSA
         8tUT+B0/flZnIe9RQqF9w97dTOD5RxEUJyA02GBK9noBhEIbzWAeWrEtmpvRQDLSBePg
         rkRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OlKtBBRVYDCu/wHJ9F5CpN0AgsTG9XKc2n1QizfRCW6ctHHVrTAQTOSGENMvRIE8koLMC88VH9T8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz+PEvHqKay6sdNUOHJRopOxtzoPLucf0VLeuJQ+SwcRd29EyN
	p0uWXUHCTbcN3pdPM7LmmlC/VunFOFhG8cmzjzbLBH8wJrnlrMwDfFpExrd7g/ryMyr/LxRRBA7
	sm+Iy6MuIoicpmkNJyXm2Zt1L9S0JgOzvf+OtB3n4zv9Nzllr/0JDmDT6sOR0jHY=
X-Gm-Gg: Acq92OFf/wskqbyxzhdkr/oTOYWUF3+wVNl0imj8gtYgx38frpbgxZpr4tRhTt950ie
	rBbXGCrVXcIYzg/jaTdwFdTqTMTOZR7I2C46a3pJ81chzdlULtnlFr6GdqOZRsPu79Z/nr8krlS
	ZbKYBsgxoEIYAfppud8PFC4LYQI58f9PEyy3Oy1ao0+e4O2DKrGKCnsBt/D7Njy3BlnR/bjgjeE
	ykYUTztlrCT+NwHX/LaoDnpRhXrQH+kTCMKE5T7mKvm9fw3vHTW0g0vIf+6iRl3eTestYNi+Ltp
	VCwAof4m0vnr1b++eYA25fE0rucRsd2URg9m14xAGfGHpZ3I58cE0RqdUh1rxVZdV/n9H3r02+V
	7Qa8xjLfSQz9FNxSay5sDhhNUAbxt9qKm7mOS18Lrw0uJrJXrTQQTDVlWXHlf
X-Received: by 2002:a05:6a20:9e0f:b0:3a3:171f:6aff with SMTP id adf61e73a8af0-3b41208495cmr2710173637.2.1780050958932;
        Fri, 29 May 2026 03:35:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:9e0f:b0:3a3:171f:6aff with SMTP id adf61e73a8af0-3b41208495cmr2710126637.2.1780050958362;
        Fri, 29 May 2026 03:35:58 -0700 (PDT)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8577299738sm1296707a12.18.2026.05.29.03.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 03:35:58 -0700 (PDT)
Subject: Re: [PATCH RESEND v4] mmc: Avoid reprogram all keys to Inline Crypto
 Engine for MMC runtime suspend resume
To: Jie Gan <jie.gan@oss.qualcomm.com>, ebiggers@kernel.org,
        ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260529092612.1749752-1-neeraj.soni@oss.qualcomm.com>
 <e9cdf8dc-40ea-49f2-a655-b99ed0707a8c@oss.qualcomm.com>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <66caaafd-cea4-b624-57a1-f2cd04d109b9@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:05:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e9cdf8dc-40ea-49f2-a655-b99ed0707a8c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwNCBTYWx0ZWRfX25lQAnSYdtyB
 nVMwDrFLo/cqN6uWsLiwbPSnyHRQiotPzVfVKVr5lO0hD+cJncgnqAjf2IzoO/hXW9IpNrpeRYq
 zZE5gooSUJErnvMGbeRJ6DORuh53SYR4KGWnMBoRHxW7DHqqdzgKmj2fMGaQBujEi88VmoUebX4
 KQcH/TkhQ7xpGO1CupHXeNz6gVUFBjTbh/WY+my+pvUbtRpznjGHbEW529okActUDWKd63LgGlT
 kwJeEspu6hzEigm46NHhEElUQF/moS4jdevwWSh9Lpr6VuDH3dgb80NGt/aLJYbXOt7ob4A0jMj
 +KbmxM3sKZxP9TOd0x4v2yBW0EPwYilsdt/TX4orazLStQm8r5tRiPwnuLija7G5qn36xD6yr9+
 o/kO5qsfsw6SLJ7ejQ+K3LW54Lnae3Le6DxQGAmcWZLeUZYQKOB17b5IoXDtW0t0jmw7lxnfquG
 AbTN5WQnWplec/cazUw==
X-Proofpoint-GUID: _mxrBi5X8Nm_7wpCruHsvEO-uvlF84Vt
X-Authority-Analysis: v=2.4 cv=WaM8rUhX c=1 sm=1 tr=0 ts=6a196c10 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8
 a=W7MggzNdEW2vEdTu41UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _mxrBi5X8Nm_7wpCruHsvEO-uvlF84Vt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290104



On 5/29/2026 3:49 PM, Jie Gan wrote:
> 
> 
> On 5/29/2026 5:26 PM, Neeraj Soni wrote:
>> From: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
>>
>> Crypto reprogram all keys is called for each MMC runtime
>> suspend/resume in current upstream design. If this is implemented
>> as a non-interruptible call to TEE for security, the cpu core is
>> blocked for execution while this call executes although the crypto
>> engine already has the keys. For example, glitches in audio/video
>> streaming applications have been observed due to this. Add the flag
>> MMC_CAP2_CRYPTO_NO_REPROG as part of host->caps2 to control reprogramming
>> keys to crypto engine for socs which dont require this feature.
>>
>> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
>> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>> Link: https://lore.kernel.org/r/20260116121004.1829223-1-neeraj.soni@oss.qualcomm.com
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>> ---
>>   drivers/mmc/core/crypto.c    | 2 +-
>>   drivers/mmc/host/sdhci-msm.c | 6 ++++++
>>   include/linux/mmc/host.h     | 5 +----
>>   3 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
>> index fec4fbf16a5b..a5a90bfc634e 100644
>> --- a/drivers/mmc/core/crypto.c
>> +++ b/drivers/mmc/core/crypto.c
>> @@ -15,7 +15,7 @@
>>   void mmc_crypto_set_initial_state(struct mmc_host *host)
>>   {
>>       /* Reset might clear all keys, so reprogram all the keys. */
>> -    if (host->caps2 & MMC_CAP2_CRYPTO)
>> +    if ((host->caps2 & MMC_CAP2_CRYPTO) && !(host->caps2 & MMC_CAP2_CRYPTO_NO_REPROG))
>>           blk_crypto_reprogram_all_keys(&host->crypto_profile);
>>   }
>>   diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 4e5edbf2fc9b..2ccb63dde9c1 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -1949,6 +1949,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>>       }
>>         mmc->caps2 |= MMC_CAP2_CRYPTO;
>> +    mmc->caps2 |= MMC_CAP2_CRYPTO_NO_REPROG;
>>       return 0;
>>   }
>>   @@ -2526,6 +2527,11 @@ static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
>>       usleep_range(200, 210);
>>       reset_control_put(reset);
>>   +#ifdef CONFIG_MMC_CRYPTO
>> +    if (host->mmc->caps2 & MMC_CAP2_CRYPTO)
> 
> Always false at this point. The first set of the host->mmc->caps2 is later in the sdhci_msm_cqe_add_host.
> 
Yes for cold boot this is true and Crypto reprogram is not needed. This patch addreses the use cases like
runtime suspend resume, deep sleep / Quick boot (DS/QB) and suspend to disk (aka hibernation) use cases
where the runtime context is preserved either in dynamic memory (DS/QB) or in secondry memory (hibernation).
This is tested internally on SAR1250P chipset for hibernation and DS/QB.
 
> Thanks,
> Jie
> 
>> +        blk_crypto_reprogram_all_keys(&host->mmc->crypto_profile);
>> +#endif
>> +
>>       return ret;
>>   }
>>   diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index e0e2c265e5d1..2fd76f966e24 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -457,12 +457,9 @@ struct mmc_host {
>>   #define MMC_CAP2_CQE_DCMD    (1 << 24)    /* CQE can issue a direct command */
>>   #define MMC_CAP2_AVOID_3_3V    (1 << 25)    /* Host must negotiate down from 3.3V */
>>   #define MMC_CAP2_MERGE_CAPABLE    (1 << 26)    /* Host can merge a segment over the segment size */
>> -#ifdef CONFIG_MMC_CRYPTO
>>   #define MMC_CAP2_CRYPTO        (1 << 27)    /* Host supports inline encryption */
>> -#else
>> -#define MMC_CAP2_CRYPTO        0
>> -#endif
>>   #define MMC_CAP2_ALT_GPT_TEGRA    (1 << 28)    /* Host with eMMC that has GPT entry at a non-standard location */
>> +#define MMC_CAP2_CRYPTO_NO_REPROG (1 << 29)    /* Host handles inline crypto key reprogramming */
>>         bool            uhs2_sd_tran;    /* UHS-II flag for SD_TRAN state */
>>       bool            uhs2_app_cmd;    /* UHS-II flag for APP command */
> 

Regards
Neeraj
