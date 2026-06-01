Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246FA3803C3
	for <linux-mmc@vger.kernel.org>; Mon,  1 Jun 2026 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296751; cv=none; b=tm1Zz3mNrB9baBOiAhjf60WkO9XjOR72kG16/KvDQUVNWUhn4iWtyT1yl+Vv0FebgWKPodFwgjIVP3Ku3L9k/6yu0s3xTiidORqM7RuPdoNx3yhg6N0nmROg81gtVswFMg6DcWMSF3qjpUODs4kDmGdcBDBzM5uiB6UM8KoYdUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296751; c=relaxed/simple;
	bh=XZpXct3qr36dcgHjb2/rqDwDBavphiOSG42YiqiT71A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWWQwGVh/INicRFeuIAxlW1br4xEXk42nPnX53mUctaP/BgwvOExX/hZva8CgWYvCW+UfAmd92S3ZbXVsueHMTRWrbSyk8fcYX2CARqsiF8TDigciZ8cCiGyXBHaGkiZcEuwGwKoE/gExL+8zW5RJJKjfdxJUda0jaJMlbAHP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jo0Lzogy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aMeGbOuV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jo0Lzogy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aMeGbOuV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6516qBSn2767785
	for <linux-mmc@vger.kernel.org>; Mon, 1 Jun 2026 06:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Iyou3X5eHXmwONgdpxt9PcO5bf2Dompms35djagGuVM=; b=Jo0LzogyHkUG0B30
	j+53Q2rYx2xRzmSddxgDAxAFVah7jcfmEzEnxfiuqqvLbhgb3tkOYuxdmKOpBrK/
	8yUjcFdifWXzL7sE/ajeDXsrv/xNBNx/jwVfQDKkZ4mcYYNeZgyaY4mu2VhTA91N
	sPmC7pzTCT2UzBicIeGr63WfdD4S9C2VpQj3nAWatavKUp0DkuLRLcyEqntEL3QB
	uqWizwKTNTJ1epDWuqs7+UoJxuIjvLi++HQueheh17ptPN39wTZGR+5gsXsAIsgO
	GJsxefdlA5qEOPD0SoPEdqo12SrnmgmtGvF68FeAwJ7YboraUzTZYOABMhDYFAFW
	lMM3sQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7fe963-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 01 Jun 2026 06:52:27 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-842208d5b0eso1422817b3a.3
        for <linux-mmc@vger.kernel.org>; Sun, 31 May 2026 23:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780296747; x=1780901547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iyou3X5eHXmwONgdpxt9PcO5bf2Dompms35djagGuVM=;
        b=aMeGbOuVXPqULmrQLbRTzEQagT+uAozPvyjl3gS589YUrMsKNXKpi6QeR+AhWrgFMc
         9W0C1pPOzpdCJWl8WL1/Ch5Ap1UDAqYslUYDkLH05Mzy659HmWh+45wUux5bMR2AzHcS
         J+0IRc3lgw3eVQXYsPZhH6UKsnRx+K3TeIIiIGobYPuyOA00G4r88U4kQUXxhqAwIG/Z
         nJj18v5WBqfC4eUUjWK5gZZpaYlCAI1z1qL76gd2mMS8pGW7oOCojV8oeKPME4+bK2lO
         uID35D16eb9SmCYIRNItc8UHLWDh9ijOxIkejHs8Ed5Z4t2TtwhqspoRNjWly/4Mlcyz
         mDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296747; x=1780901547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iyou3X5eHXmwONgdpxt9PcO5bf2Dompms35djagGuVM=;
        b=Qasm6C3u8l1WzS7iUCDTjUY5cRgWhkV/P/fIKREUKaes0pICd8+NyenCw2WdmbvVh2
         pj+X58sQmkp4ZE1IagPfGr+7LZcJUNyg6f69TdjtCL4c/RoEtHGWW9Ss1yYFhwhqsoPJ
         H99baLFPrs+BQaDxhQciWzObbkq+vrdO+Tnx4CWl7e9PuaH6y1cZJ4I4BGdAGerJ8sFO
         Z/efN2E0lfAqLwnw1xHG/XdgwI0ekH/4hRQIP3bl6tpqW8ejjmLaHaRcQjH5LnBHAX3G
         Ongb4JM9dT353Xe2GgY2b3EbJ5NhoLzaaj0dy6IKZVYYCTRBnLurAPKr8iLnvQCHkSN/
         e+jA==
X-Forwarded-Encrypted: i=1; AFNElJ9UIEPN04uIske1wMQb3JEMF3BfTFznXGdo0PXwxwXaeAMrw27+SCXZlhn7c9ow4u10tvRh9ryv3mw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ID4AfMRfaG5LSx+gQd+6Phsf0lT2TK1V2NUHT3CA4QEF8rIS
	dUANmtx95jNHxscrKyPpdfyji59N5cDCHqSDmaCCLW5Md/HawTC1sxXh0PCaMbrov2jwQiMwyZw
	/1VcaLvT8lD/WjM8igA3gpidbUcVmfmv5ZPvQvYeMZyw2NhWjqY7GkNuIYCmeqg==
X-Gm-Gg: Acq92OG7Ikp81j2yjb72+jCr8nBBLTdzUafnmCSoL3wVtT0ID/Ry7Xd1pMRcXV5aPvb
	77TV5bGoqPuYB1QAzssKW48LoEhUWCHmVKGLBuvC0N6HrxzC3sr03ZWW3fxw8Ft3nqpUlqCLbkF
	a9RPPGE83tnqBUyyMBlRGnUtJdYZHsh2QVGdM5u0avILToAMmUj0oJqdxl4oRKekzFLEiX9kaP2
	vmXyTr2hQ2GcfTvoaZMkuIDau+v3tNiowrBl6hmXGJv7OBQWmFDTauieznL+i0ii4b9of0cVu1g
	9oyegTYfuGlTc3NEHP1CfMDcLSpOMAEV2xVToFwD9uYE4H5AQDj9EPkfGXiafKjCUI0qPFXK4MU
	qDs+yF84HzW2xSQ1JvNGE1vfTO57Cq4fSID3x04q/+o6clQTF1pPzaJGI
X-Received: by 2002:a05:6a00:71c9:b0:842:2f28:4e36 with SMTP id d2e1a72fcca58-8422f28a598mr6117533b3a.17.1780296746711;
        Sun, 31 May 2026 23:52:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:71c9:b0:842:2f28:4e36 with SMTP id d2e1a72fcca58-8422f28a598mr6117517b3a.17.1780296746151;
        Sun, 31 May 2026 23:52:26 -0700 (PDT)
Received: from [10.217.216.18] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8423bdd217csm4400839b3a.49.2026.05.31.23.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 23:52:25 -0700 (PDT)
Message-ID: <ba42e3ce-6f1f-4c14-bace-c4b5669adf47@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 12:22:21 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: sdhci-msm: Set ice clk rate
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, konrad.dybcio@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pradeep.pragallapati@oss.qualcomm.com,
        manivannan.sadhasivam@oss.qualcomm.com
References: <20260529081045.2877910-1-ram.gupta@oss.qualcomm.com>
 <20260529081045.2877910-2-ram.gupta@oss.qualcomm.com>
 <ahxu1rm14pbwQFXK@hu-arakshit-hyd.qualcomm.com>
Content-Language: en-US
From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
In-Reply-To: <ahxu1rm14pbwQFXK@hu-arakshit-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 31RiXPrCr9XapnaSifVUNlcL4kpPYfd9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA2NyBTYWx0ZWRfX4nM8Nu/BDIIX
 N2H+WxMctcPGGLtoi7jWUbv5xN96OjO0kxqBM1L+Gd6yoewwY8UmJchu0KUXRqxlvFSSdFV2VxS
 ddhpY9FaxLIdrAb/fPvYSNE5plAtBXa1yzxSjmtcjJCpFYPZvANnk8vHWLXul29EYPYLOqZ1YTC
 rG0Nwx7T2y/UDlMSOYWPZvIMLO7xwsExZ/QfEuXRA4S/V2Xqfoz9C6XY+2YhJ2kPp6PKmPdMF7h
 FwNKs6/abcJ8I+zUgyhScQ1T8w2Rgtu6yPdV9Ul8U/9h98opJJCov/2Vc63Js3T95LI8qjQ/eDs
 JV28G3Akvk8KKu/PYn6jjaFNi+AV9+W9ZcxAPWJWpabldVmsONU9js5jZ+efC5pnQJhijtR3wUB
 dsCtDANdT6+OVZE0RosWJJjeC149f0OSXgG5/V0nFE5+TrnKIeu3O3cBdt+czG8F1o0O6wP//9p
 +g59xlX5wU3rcdh5ryg==
X-Proofpoint-GUID: 31RiXPrCr9XapnaSifVUNlcL4kpPYfd9
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1d2c2b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=yX8Kf8TJ2c6MFKM0v7gA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010067



On 5/31/2026 10:54 PM, Abhinaba Rakshit wrote:
> On Fri, May 29, 2026 at 01:40:45PM +0530, Ram Prakash Gupta wrote:
>> Set ice clk rate from sdhci msm platform driver, needed for
>> target which are having legacy ice support, and need sdhci msm
>> platform driver to set rate.
>>
>> Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
>> ---
>>  drivers/mmc/host/sdhci-msm.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index b4131b12df56..c6a073718aa4 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -286,6 +286,7 @@ struct sdhci_msm_host {
>>  	/* core, iface, cal and sleep clocks */
>>  	struct clk_bulk_data bulk_clks[4];
>>  #ifdef CONFIG_MMC_CRYPTO
>> +	struct clk *ice_clk;	/* ICE clock */
>>  	struct qcom_ice *ice;
>>  #endif
>>  	unsigned long clk_rate;
>> @@ -2708,6 +2709,17 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>  			return ret;
>>  	}
>>  
>> +#ifdef CONFIG_MMC_CRYPTO
>> +	/* Setup ICE clock */
>> +	msm_host->ice_clk = devm_clk_get(&pdev->dev, "ice");
>> +	if (!IS_ERR(msm_host->ice_clk)) {
>> +		/* Vote for max. clk rate for max. performance */
>> +		ret = clk_set_rate(msm_host->ice_clk, INT_MAX);
>> +		if (ret)
>> +			dev_err(&pdev->dev, "ice clk set rate failed (%d)\n", ret);
> 
> If we keep dev_err(), the failure path should probably go to bus_clk_disable.
> However, since boosting the core clock to max is kept optional,
> I think dev_warn() is more appropriate here and avoids making this a fatal error.
> 
> Abhinaba Rakshit 

Here its only setting rate of clk, so no clean up is needed, hence logging is 
sufficient here, but I agree dev_warn should suffice instead of dev_err. I will
update this to dev_warn.

Thanks,
Ram

