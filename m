Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702983;
	b=MxYt+HUwgz+x6pNoGYIYLnIUdUiOROWoI+eUjZobG5bUinm53YEycHIwzxFp7lS5K/1K
	 5+Y4/lmBhuICu0Azfz2qOZqbSVP6FzSO+qZTQJWT7RiAyExeqFFab06iTDzwx3IftOuo6
	 r36v8C39+9BWS/HxSlB9eEF/1RURsWYzw2+l88yj12lzdcDoHMsDGA5vtRQWfa/5qJNOQ
	 uKygC497Z/Piog38I/A7PqK2a9aFfWc+0MgF0Lvtjq+vPP1kNLQonOINGJpD097UoDdPE
	 bsRFQk3pjgSDQEJdihX+NbWHHebVU/gSwGuIsbTQgChvLIXkSxwSnWapBV8+W90boFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702983;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=i4Is8dhLzB0RM0C72WiR4TBH/SBKDIS5u+uM9POXKDs=;
	b=srpz+HNIToFMY84wdc1LNEgrbvdyQvVNTkxcReJ6JHRaN/lEDCOqH7sW8WZP29dvpszo
	 pQ75mWdbg/Ag1q/DXkA4257i5zrUa+vKlVYm8lXFslbw3lno+NYLDdqwj/7FdYxDk4e0I
	 qC5w5Lp6x19ncEGF5k/Sr6bP/3K4LPkMdl/el0GRSM++XIyim8yusbwwwqO4DJIXtg7Ho
	 7VT3nmSeqNfiG5hHu7E2wWdxMvaQopCUy3ZHbvM5/Ll46Item1KHS6jP37AobluYY044K
	 xh0qy11goEq86PVuafZXBzYHF4ipE9GE4jzBI/NQIdHWSrvWb+8eTPcDWG5CE7tVejA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oDk3D2yf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DEBEue6V;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61116606A33A
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 14:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61116606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oDk3D2yf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DEBEue6V
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVORB3177375
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 14:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i4Is8dhLzB0RM0C72WiR4TBH/SBKDIS5u+uM9POXKDs=; b=oDk3D2yfb5PYVxpM
	nJFid7gT7XrHliooiSDwTKNXKJGaf8DNzGNmJhsLwRLJQtjji3Pyb+9RRvgg0rTx
	83j61SEjWZZd+EG9TE6FAWwDNACQjG4UXYxPTfC8zDG1DBY8csl7j1zrhKWG7rrx
	8WFPgnIXp+9Y79urnktTk4gH8m+KVxzZLwMTw47PKN/ZH7D2IIh2KB6ORacmsqs6
	BBhMWCIuWvuIe2fd08PPrUFNWdjby7hxqXSQOwmNbMw5CRDFLqyiRUpQ30+vWhgH
	mzR5Ja0GSJdFM2EFhQ1jxy5U1WxDqEl58Tu0A4qUvm1bUqEocYcSrZADAJrkwcck
	fYOKLw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662sbfvx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 14:23:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-54e4ecd1b4cso15982691cf.0
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 06:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795702980; x=1796307780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i4Is8dhLzB0RM0C72WiR4TBH/SBKDIS5u+uM9POXKDs=;
        b=DEBEue6Vw+DmgzdkjBT9e8BDSIw0UE+rNFyKMyVkHiFrD1SsOu+QdjJXPe2S62au99
         4oGd6SEcnixW5wtcUoEc8+q0ar3MQA7GtDcaIRmXxbDAhHscPWbGm/aTfUm4BC5QS3si
         LqOOxaIq6PsLGVpst5PQjnqcyMv3fbAunWZEG4ubXGQie5yulUW+NKenNg4X2F/cQTME
         b+maseUk8QFnjWpSeYkagCAC4dTBZNt66u35IwdELST8JjcoeML7f/XkVjW1txJCfgLn
         P2dPTveoZbqseVV4/NsGMoWrGBeZqkOWXOD3WtgBjGWpH3nHTwldIsw8bp0QyOIfwnLX
         Qmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702980; x=1796307780;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i4Is8dhLzB0RM0C72WiR4TBH/SBKDIS5u+uM9POXKDs=;
        b=xFUxlTggqzLuJrsUsiyXqriSAWwprSnNaEeesxPmBn3lvucZLOckO4W6GLRwS6o5p3
         Baaop+4qleyJyX9TBuPydoO3KNSYo6lKdYJ3DuQmja1HGOAsA4O0+0SbOKCPPJB5DyRV
         TM0ZxlO9bueltn2OEG5qtDbop7ae8hp/en7VO4yUtN/UnZSlqftZU3+YFW7JLqaGHK4R
         zV+/DL6eHv2zZiapXZCAPyu7nfnHtLpvzmdBsJqCa1eiUzoct+aAVPMQJE1MF+voh6D/
         5uHysiOfCcQL0KEJKsvAeWypEkEnbQW9jomKMehj5I5MhrAfanh3yJNVCn7QeXU9mWTf
         psMA==
X-Forwarded-Encrypted: i=1; AL+hErH5W7SxjxOpTKAvki6kohBx/sn+7MzkQu9TLYz0UeUOyIsC2BVM1mz4arum4SuyzW1Ly2GPyXwbY4A=@vger.kernel.org
X-Gm-Message-State: APuU4Z90M84w+0oa2AF82JR+klYp/e1+mjbPECaeLLnSAHf/ALyBJhB8
	JSqFgr9DPjLZfuoUu1n88EIb3p24WUOVXVzFTjF3bAitQ4L0O5t9tDzCVXuBe/ryZZ6vlyVqzO3
	kLI4KGSuiFld/ZINyEAxVtkFU7FXUqABYOWtrLqLiZr5Ha9s10EdbE4GNjPSTqUG67FXmf4w=
X-Gm-Gg: AZFdTZdRglGh0KbM1ufzjHIpJLnKd3CmxvwVC+iVINFF+2DbKK30189nZI2NbmRTkQ1
	1ubwUgLOo2Vu1AtYVPXkq0qT4undMJR3Ba32zVtCcel3JpSGfS69bT7mtJaRlSMJelvCIRx18a1
	7TTaHYjucFv5BijsMN+0Lk5O/6zoT5oQifuGL6lQTLOgHI64aKBzSUSfNXKqNUIa2lQjTfQr7p/
	5sR+kD3bm9vi2Mi5enT5qtXvkrgjHhm7LH1i0bhlbgYw46raSgX4uPeuPVk3iHQNy0RyWhIxuap
	rq3UfVJutON3mppL9qrG0mYkUIB8pFe6n8RkPCu2n8ALloA+D2ZRyHRm8MUnh+9J5077qlHL0nI
	cYXLaJCz+4qji7UhdLA72p4fEwlLg3FWqPWR6dhkOf/9haYn0ikPD6i6J7S00w5rRp8HeQDQ=
X-Received: by 2002:a05:620a:870d:10b0:949:b7fe:6e47 with SMTP id af79cd13be357-949ba81fda1mr3561490885a.1.1795702980633;
        Thu, 26 Nov 2026 06:23:00 -0800 (PST)
X-Received: by 2002:a05:620a:870d:10b0:949:b7fe:6e47 with SMTP id af79cd13be357-949ba81fda1mr3561486985a.1.1795702980158;
        Thu, 26 Nov 2026 06:23:00 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba37108c8esm9816240a12.31.2026.11.26.06.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 06:22:59 -0800 (PST)
Message-ID: <2af8f98b-56e1-4cf3-afff-37a59586a68b@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:22:57 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-msm: Disable clocks when runtime resume fails
To: shyckless@gmail.com, ulfh@kernel.org, adrian.hunter@intel.com
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261124-sdhci-msm-v1-1-75c70ed6569f@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261124-sdhci-msm-v1-1-75c70ed6569f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6b0840c5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=PR8Mj0BxCgJnN8q3-T0A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 9zoHfYkQZPzoKRoxRDeUuJB5uUVCorRr
X-Proofpoint-ORIG-GUID: 9zoHfYkQZPzoKRoxRDeUuJB5uUVCorRr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfX5l/dXvYpV/ZV
 ciie+9iAiSbJt4boXDjr9oxosojg6ceVKIB2EqJU9BVwN0UCGnMwMuWzl1Oo3dTCuyPm9iwgXX+
 j+0IetzslFBGcnMjdq3NWOueIofzkM//8IHSPBp1Qr2Q/oSTFSlBkimBVhvfyBRpl7c8ovTO0UJ
 g/lLoK7wwwAQKjT2Te374WJ7k9t+wzv/C2TmVGWA3viSTUWmdKK8cUF2oOe40W/bEnDYLevaF2P
 s6hZPBu2dS238U/8/huLizo5Ul2jVO8zhJyB4fg/u0GTZmiEdlek1/qC3opOhDsAXBlew0VTrsX
 E1x+Uvtk17frkOI0MyU8xJMdfOQFhW8g6L6aqn4UgEAMCrS3RfGqPcB1ppzKb+RuvvhsBoPa2/C
 JHDdCbIT1wDfPF25k9lXzds49d1LIUGXphw95Pyn3c+ZOqLc1VegKuSliIz3JSPj7vRr2+eilDW
 7Arm+MtzCaNbQHlQcjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfX25qZ4bVyVTwY
 Ifj9ntO62X+e2bCFT/jve+nq/4AOW/11WBDwZuKyAPKH9NnJEPG/E4HkADoEHDkIyHvWNc+9216
 TtR07+gP3ITsZrcqOzMQswC7zN3+Eu0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260056

On 11/24/26 5:31 AM, Suyuan Wang via B4 Relay wrote:
> From: Suyuan Wang <stevewong@hust.edu.cn>
> 
> sdhci_msm_runtime_resume() enables the bulk clocks first. If restoring
> the SDR DLL config or resuming the ICE fails after the clocks have been
> enabled, the callback returns the error without undoing the clock
> enable. On the ICE error path the OPP performance vote also stays in
> place.
> 
> The PM core then keeps the device in the suspended state, so
> sdhci_msm_runtime_suspend() does not run and nothing drops the vote or
> disables the clocks.
> 
> Undo these steps on the error paths, in the same order that
> sdhci_msm_runtime_suspend() uses.
> 
> Found with a static analysis tool and checked by hand.
> 
> Fixes: 21f1e2d457ce ("mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically")
> Fixes: c93767cf64eb ("mmc: sdhci-msm: add Inline Crypto Engine support")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
> ---
> Compile tested on arm64 (W=1). I don't have the hardware.
> ---
>  drivers/mmc/host/sdhci-msm.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 32b1bcba47d6..39db20ce5bb7 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2978,20 +2978,27 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>  	if (msm_host->restore_dll_config && msm_host->clk_rate) {
>  		ret = sdhci_msm_restore_sdr_dll_config(host);
>  		if (ret)
> -			return ret;
> +			goto err_disable_clks;
>  	}
>  
>  	dev_pm_opp_set_rate(dev, msm_host->clk_rate);
>  
>  	ret = sdhci_msm_ice_resume(msm_host);
>  	if (ret)
> -		return ret;
> +		goto err_drop_vote;
>  
>  	spin_lock_irqsave(&host->lock, flags);
>  	host->runtime_suspended = false;
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
>  	return ret;
> +
> +err_drop_vote:
> +	dev_pm_opp_set_rate(dev, 0);

This is not right, it doesn't do anything with the clock and
introduces another point in time where the clock is running with
the power pulled from under its feet. Instead, we should kill the
clock first and then do dev_pm_opp_set_opp(dev, NULL); (notice
it's a different function)

Konrad
