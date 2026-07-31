Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907BE361953
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 06:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477734; cv=none; b=l/QiDbGmIFX6KxcNtBwpkkDuiFZa0m0cmG1cfbseYJFUR3iXhq2EyuMB5ty2kWUbbotRLOO+hnPBW00YJhxKM9gpjW1b5a3PMAUxtlF+mHDihotua0tgAC+bTk8/qEaIoWW+f5n6ecJ7KsI4NGpeZSCvAMOe220Oh/WZElRJGCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477734; c=relaxed/simple;
	bh=YpgtRJcar+oxR5vBEAm/0t39UJXbaDoA14eKb0ck2OI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YAJxragWZSB5InM8W2v1oCaUg4kaghQ47bXKvm/DKYD/NUubD/wM24D+CpXJkpszeFCLtNuBwiEZb+SPTY64x43EznF1bfC5K62+t5V2FCfhby2NoQi5ANWzrqsZc0vlZ93/EMmE1GnXxos6+sY+aLlq5q3DxaD8+5Kd2+ylaG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ImUqX0he; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ISEw413n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ImUqX0he";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ISEw413n"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5HAkZ3235135
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 06:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tdQJ0UEZ1JX7S0mTRU+fMguZpemOSOkgdQxsHOsSU1w=; b=ImUqX0heQRkF6CCO
	SJHuF9iTdeUPiv6GvvgRv9AuMcXXyuGR6VsHnODelmZo3Z/lWQbtsa+3fecneOF/
	l13zK/uo4hMdruoEPxYP6MYjTUZFWfLpZ5UbxyQ8NJ2mj0TR9ri2a0KgvHj7e1E8
	mcOB3P3EoDuQ4fkvLciL0iDa1DKxgtaJa/d82Dkv7jp8rXtuD6TgnXbjke6hLWTU
	IKNwZ5dg25oXBHUY9YBejgUfF4ly3q0sjunkIu7Y+wT5qOTqqMVQbcDinzAXuXn0
	CxKrWgp7v3ue32ZxMpjVVRYbTXQayEntptnFkIxMJkPNyzCbH2wf0j34SXQxxdLB
	J6JrAg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frne504xw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 06:02:11 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84859a64079so1293596b3a.3
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 23:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785477726; x=1786082526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :subject:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tdQJ0UEZ1JX7S0mTRU+fMguZpemOSOkgdQxsHOsSU1w=;
        b=ISEw413nZaoN9g+Ig7Mzv09K4PSC8jNt5Oc0h+V5cUTIeIT9bxphsPE9hwNIZytvFv
         tx5ZtnN9tEqoI+JpvSATxXAEM++1L57swiRqYkouEmHeymKLegaNLKg9W24Gt8HubD+G
         zn4N6XyxrP92qB/OT+gB9nsdYr9PTmXaOJa0cKk+SZRSgWaI+CCZs/F2AAwMXG0XSQ+a
         +G5pFjhW/dTe1eX3+4JezdqWR+FbrsB9815b5GDqVd3K5Qx2acmmXWCnNqF/KyZjkja4
         irsZRh9RmC5fDV9UjkL114A2VDpwwLLUrOdk2eLXP3hgDLWZOB4wJCJS9VuaQaY1SSnr
         pVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785477726; x=1786082526;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :subject:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tdQJ0UEZ1JX7S0mTRU+fMguZpemOSOkgdQxsHOsSU1w=;
        b=Uiqq1WJ4+DrO/chf6k82iU9UHFu9c4v7QAwzx6reCENsQzvWiLE1eee+ry4T3DPHmM
         O2tVyFi2rplrb6Ml5FRq9GPRFm+DQMtBbDb9aM9F0lkTjAqGuAtkpmr3iTTqa4ReK1wZ
         63JSeRuIfpkWnxHxw+9tUNw/zElGQioWah7ioDHlEECFM7JEijTQFE2usMFK41A6UYek
         5tfn6MQEkyk0uvhP+QR69X2ludviXAOv9viP7xcZTI5wNQ1jkEeSaInFjHN4wDVLXAKr
         12h7kJVNYpb3h9tQQ825ayv/g2zeU8NBRgTJfsXTN68w+6htSXwqAAzW1RtLoRiffGph
         NlZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+NuAIu5AwnxzTe3h2qBuGsn6VVrC1E7nwBxi6rN4M0CQIepgQgJW0yE9lggBYnkuP0R1kuSPGSi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIaxjiNihrg4YatAuOGzDhcv32SFWaa1QMhMLeDe8MBMWKDoDO
	m3g4hhYyT0r1Y3wMZK/QcP/At/IBHJU1R6P16my4aCKVMiPxYrjwbGmAIAZGuQ022EH4SZc2XF8
	OCFv1iKz50ZqzshOzwTtiCcFp0b9Y4GvYmqoZNeZTHUCPMVhLpJLLbfIIQLpWLNU=
X-Gm-Gg: AR+sD10ooJWm21aA+F5CyghEAVNmOP0KvgKwJi/f6UjVgRcBbPmvYAvU0L387Hew+mN
	ZcJSXikU8B25NY/EmeYx1+otFGX38FXhF+6ahFyFnIcp9yzSLfHFR2GHWJN/A1NRL3oQkkL712h
	3pz8mIUh8E2ECEAurgB9v6leTY8tSfW4+9ILhTV0Y3JZtc/2Hq0lYP2GZoORTpO9sewTguyORFS
	rrft9JlLOb9FaSoxT2s0zX6UcUa4qCOATiMv3PjTmn9SzFX0J29LWgJhqid38lc4GWl34/1GooN
	83FByMJmmU0G5Lu+EpVTsPc7ZkzlHOl66Jr05vZkISgdtPXZVQFsc4JlG2uqnVTSwpV/SRP8TLj
	YZrbmiMnb9js88TDtn68FZmBVfps=
X-Received: by 2002:a05:6a00:b48:b0:848:67ca:c03 with SMTP id d2e1a72fcca58-84ed74a0850mr582734b3a.58.1785477726026;
        Thu, 30 Jul 2026 23:02:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:b48:b0:848:67ca:c03 with SMTP id d2e1a72fcca58-84ed74a0850mr582696b3a.58.1785477725431;
        Thu, 30 Jul 2026 23:02:05 -0700 (PDT)
Received: from [10.218.4.105] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ed5dac651sm311587b3a.31.2026.07.30.23.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 23:02:04 -0700 (PDT)
Subject: Re: [PATCH v5 4/4] mmc: mtk-sd: Protect crypto capability with crypto
 config
To: Eric Biggers <ebiggers@kernel.org>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, quic_dmukhopa@quicinc.com,
        quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_gaurkash@quicinc.com, quic_sartgarg@quicinc.com,
        ram.gupta@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
 <20260730140822.1976635-5-neeraj.soni@oss.qualcomm.com>
 <20260730191030.GC3139@sol>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <0d8f8fed-c712-91d8-7ea8-287e5ba4dc6f@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 11:31:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260730191030.GC3139@sol>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ftzsol4f c=1 sm=1 tr=0 ts=6a6c3a63 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8_jnBlR0WWqDQFfpqgYA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAzOSBTYWx0ZWRfX4X5GKawsUdyX
 5A5t5doXjyRyIuyB6S2z0+F2SHX51l86EAejYyT4C2S+vWGmfP2/SMFd+qsgMLGLnIKC4Vl5FL4
 k7PIW62JxG7wexY/8DslDBtP6dVZfBM=
X-Proofpoint-ORIG-GUID: 352vbxya083gpnGCzG7la5GLCegHi2Ec
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAzOSBTYWx0ZWRfX2kmSYwCB7yLG
 TBBsirR/4kRp3+1ZCfd5jTjUAis8ieFnxagktKGuskkYRjygXt1y1YPp4YAFqhTzI9gpvv4gvrU
 pgc/7vMRW24Dj1LUuhuzYYKAwofq4a/kFOOWuVwBNcxxni8BEqmp+puuSUlRcx+xpjbGECMst5h
 dieJd2MqpzIxKLfzC8l1V0Hw2yOQaT8PIHvXcLm2j/t/lKzG4uheWFoszb9T7NIwtv6o/RKXmcV
 M+xLrY7fDpTfwwrEHw8xoOeEkqgf4eKXRLXjzXxcoEdzWES9Dm2EfUprOSWotImF2n372knIt/T
 PYHRnkrQcZi5SL7MIyGUfboqdLRnsKW4gZSpn/wlT8EnP/jw/+1vfzTgWoM+T2s7MTwj+Gx1Xr6
 xJGow8/rFWhb/zWxvOWqWDPENwll/PgBSCppdnlQqJF8Db3Nktbn49/rc85X5f5/hqJaFq+bHY+
 +ZPGUDO0HjkCun4U1kA==
X-Proofpoint-GUID: 352vbxya083gpnGCzG7la5GLCegHi2Ec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310039



On 7/31/2026 12:40 AM, Eric Biggers wrote:
> On Thu, Jul 30, 2026 at 07:38:22PM +0530, Neeraj Soni wrote:
>> Host crypto capability can not be used if CONFIG_MMC_CRYPTO=n.
>> So set MMC_CAP2_CRYPTO in mmc->caps2 only if CONFIG_MMC_CRYPTO=y.
>>
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>> ---
>>  drivers/mmc/host/mtk-sd.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
>> index 01ea3adbdf3b..c415ed97e3c2 100644
>> --- a/drivers/mmc/host/mtk-sd.c
>> +++ b/drivers/mmc/host/mtk-sd.c
>> @@ -3031,7 +3031,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
>>  		if (IS_ERR(host->crypto_clk))
>>  			return PTR_ERR(host->crypto_clk);
>>  		else if (host->crypto_clk)
>> +#ifdef CONFIG_MMC_CRYPTO
>>  			mmc->caps2 |= MMC_CAP2_CRYPTO;
>> +#else
>> +			dev_dbg(host->dev, "Enable necessary crypto config\n");
>> +#endif
> 
> host->dev is still NULL at this point.  So if the log message were to be
> actually reached it would show '(NULL device *)'.
> 
> But the message doesn't seem very useful anyway, especially when it's
> logged only at debug level.  So maybe just drop it.
> 
> Is there a reason to even enable the crypto clock when CONFIG_MMC_CRYPTO
> is disabled?  If no, then the 'if' condition above could just be changed
> to:
> 
>     if (IS_ENABLED(CONFIG_MMC_CRYPTO) && !(mmc->caps2 & MMC_CAP2_NO_MMC)) {
>
We will not need this patch if the i revert the change made around
MMC_CAP2_CRYPTO here https://lore.kernel.org/linux-mmc/20260116121004.1829223-1-neeraj.soni@oss.qualcomm.com/
since that change was not related to this series anyway. Will fix this
in v6.
 
> - Eric
> 
Regards,
Neeraj
