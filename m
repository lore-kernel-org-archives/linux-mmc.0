Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C1E356A0D
	for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770897927; cv=none; b=b5sD3rCKZxxfGPTHqJPbrKkDs1FRrz2bUPDtcgZJkjjoDgSBeWeAkvkPqFMLwWn9pYLJ8cOUlXewlCD+vzh2f6V77nPFMxp/ziqA0wdZhbpxHrnO4xyJtlH5qiZ/mCTdL3tfNa0xfS9vo/DVv9qlD2rR9h+D+WKiMldn5toBzOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770897927; c=relaxed/simple;
	bh=o2GFVDqXiSLUKn8UeGbPsRZ1svvguHIXozzWU8zIjZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KU4XyqNqnCvunmfZnMA8U6X+yNcvnL91/XMheVttDWDL3iIVi9Z4ZLjH8FqeVWoNEeCijulNV+XW+I2kwmwwBQQru9/A6/TdltoyjktTTXb+rPeIV8d6bLwhupYVs6OQcJLOa6tHg8TRvsmpj6epC+/KqXydQsWnBziGEygMR4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VpJqUq1x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P1rG4Dbv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VpJqUq1x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P1rG4Dbv"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61C9o5M03562061
	for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2026 12:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qHpGzoa3aopZAtJxfvEehMpSqEZ816kpOkyer+YIROI=; b=VpJqUq1x4U4uaVZ0
	8uMfx/11i4i/O5tLZzXy9biQVtAsH1gyOQ2Mj1AfY4TeKOG/LBF20+CuJyem2Cth
	psNooWPvjpsD/Tf1BdqcXBY545Clbx176K/2RbxMRGF/16J05Row/CnpYKA+R5fV
	FStFEkGpClfx8tltg8a1yC3ZAAMpx0PvwInuYx0vzO+qIuQ7whWGT6t7Xarxv74e
	7h7Rt4NHZrk4mZpvZCmx9b+fqQm1IVWKRCAFzhW6t0/WOGzzIBkmzLPAk5MjVEJ+
	JfzpxWIWTnSW/AMnl3wzEOksBV9rJSUZlL7Ocb34lfRU0bntKCSHIqVahF+X70x/
	Y/GgIQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9ck2gdc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2026 12:05:25 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-895375da74bso22614816d6.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2026 04:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770897924; x=1771502724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHpGzoa3aopZAtJxfvEehMpSqEZ816kpOkyer+YIROI=;
        b=P1rG4DbvXTwogHQiPHoJA46cssDjLbzEelbSKm44tAYDctVIm0jXhV81hu5vZ4k/oe
         W/mCZdUZQwFIGYU/Bjl1iY5aSzJcD/Kfk7qXZ0xQHcWntxmSn8outCZ5YFE2hI4MPtlO
         Ipa9A4UebWQ/qPnZkkQldapqb3adRk2npWpdR85KmkU1yg8RkyWkGjtlfVYVyJsWOPFi
         lGRO4wtoDavpcfffbA7PJDBQERUlkB+AbDfFUz9/KbWe9yujCxkJz5CVhPfpa6gJ4Yh8
         1CjN0Sb5ICL382FMalaEW+ukEgI8SoT8W/PJcA374bWA0we33sMw817BBezZKGp4zs9g
         5fTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770897924; x=1771502724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHpGzoa3aopZAtJxfvEehMpSqEZ816kpOkyer+YIROI=;
        b=gHP1GUKVHew5xHJpnuWNKD6SSzmPkGk7X1VgRvMFlfwFsbfhy1RHuaMa9XDERYFQHy
         zNdSzmN30B8S2X2HjuWLr/gpxStGJSyPmbaotH0pAlzWG6sxP/KXwx9taOnOd/aFD7TF
         4H13rkPWJsnIiHsmcDOCyuPr3LZ8L6TVuB7Vb4T0dEO3g3Y+bQrLotwQdbjivdnPfg/3
         kahlH7IspCsjcgFxIvefUT2fzd5/xwVM2BqtLoKX23nS+RYeRnl0mXeSs6TEw0WvmXiW
         1moYygjAcGcb/o+1oV03dthiwqCZH2URkssdTvLuvdlcoW4gYukDIt+BVBBsF0kA8seZ
         Wr+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMk+uac5V0UgXnAC6qWdmqTx95j/7CO211bEoznl+i97u7GBkpMr/c+y6NGRp7dYqeidzj0h2e1/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnti5kGoLB9snf/juUT8b6vMYdQpabI82g4u7wXu8T1xYz8WGD
	SSefLxzUlNEUnFcAmbMPRYH09yAM+vcFE42khxdQS8A0LXv/cbkfXbDfQfmVyvNA+S1GU2+lmNZ
	fu9Jk7cLvneLLPizC+1gWtbZuoCVNeoPLpQoT30FMm/+xI8xcRqhruGFAnkiatu7VwIqg7ig=
X-Gm-Gg: AZuq6aLK0QV4dJ4y/V2m1lGi2EUPl2/5lCGz8e5h4zaLZV9iwxC/n94LNEY6WMb2Rdp
	JhWXlHpAQQBo6JZ62AjIekY1PFQp/71t+tX1ugKR7izEYy6tfjwjOH/NgLFmZUr8k+4HTPWTVVs
	TYMlRpqcxFCzcINnXFLyWJlVe/njMQiwdPHXZHHwsZ2UIYZn0XrNGwRdJSX5dszgn4IjX4azi8V
	Q8kEjf33WN5nBdZH7C6Z9/RysAC23OVQGgUmvRsrNuVXS2gLCKe6jznnkVaIs17LceubOMs3DS3
	PD3SN9Juqw20tmWpoaYFwdnaS3ECHSQ2BAJfD6HAEEriyOjvZjEwwEPc8UKESl+IKZYXPiIadk+
	mx/epkFlJ1gbIWwg9b3kiQBjenEAzDubOsqtchGdkgFCBtKcUIfM+2GTVSdaJoO0gMKuTsSicTu
	usZVI=
X-Received: by 2002:a05:6214:484a:b0:897:1d50:2336 with SMTP id 6a1803df08f44-89727972a48mr28203096d6.6.1770897923776;
        Thu, 12 Feb 2026 04:05:23 -0800 (PST)
X-Received: by 2002:a05:6214:484a:b0:897:1d50:2336 with SMTP id 6a1803df08f44-89727972a48mr28202586d6.6.1770897923258;
        Thu, 12 Feb 2026 04:05:23 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65b2da1aceasm1112696a12.19.2026.02.12.04.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 04:05:22 -0800 (PST)
Message-ID: <fe57b3f0-cda1-4bde-a215-12e3aa9ea344@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 13:05:20 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] soc: qcom: ice: Remove platform_driver support and
 expose as a pure library
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>, stable@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260210-qcom-ice-fix-v2-0-9c1ab5d6502c@oss.qualcomm.com>
 <20260210-qcom-ice-fix-v2-1-9c1ab5d6502c@oss.qualcomm.com>
 <7d61d324-0d26-47ce-aac6-d17abdcf05cd@oss.qualcomm.com>
 <jkrkp74jgjg6d63ro4inl7ily4p6s35hmhpxeroyzue3o55tto@sgl2b4uv6ysv>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <jkrkp74jgjg6d63ro4inl7ily4p6s35hmhpxeroyzue3o55tto@sgl2b4uv6ysv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cd7fb3DM c=1 sm=1 tr=0 ts=698dc205 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=FGFzfvMP8PCZN11w_dYA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA5MCBTYWx0ZWRfXzAlnFqwF9K7Y
 UpWYsDHxKKULZAhMMB3Mkb3I+623a5+by3WavcGxQid1osXlVS7kbukQqzd8dzn2bpi4pU+XECK
 5ZmFi7w4nI6DFnPLg59JMQOv30cS5aYMLL83zvSj9+zS3dxKaTuY4YWHfTr5Bfo9V4TmajEJs40
 TNR812WtJuj/L3A0YcX/PIFE7DTaJSUmNOqf/I7L0R05KDx1WAn5ZYsE6PZZ5xfpPuAPshfSbup
 Z2iVtmqH3G0y7pmCjkRSJ31XchXQlmbBKa79Hx78c15Fyl7i5mRG5cvouX7g0QOXm0Vy/nMUsJW
 DqEhZ0UL7wu8GO8GXNbActYGfrjqszyfZ1hFdrLejJ6OQPqXPr2iPP5GTKGcMqnMpNKKK5bkbAW
 IUfVZievO1yhvhdSktcLVvIstoeUOuIY4NPHe2MSKovGKeXhQcbfAb2X5XZsAz7h5n+iVEX43iZ
 bUjhIeSSX9wE3RZnowQ==
X-Proofpoint-GUID: Azv7KrgpqOQ6K-Q8SvtQiXYyf_cWIkvH
X-Proofpoint-ORIG-GUID: Azv7KrgpqOQ6K-Q8SvtQiXYyf_cWIkvH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120090

On 2/10/26 1:19 PM, Manivannan Sadhasivam wrote:
> On Tue, Feb 10, 2026 at 10:39:54AM +0100, Konrad Dybcio wrote:
>> On 2/10/26 7:56 AM, Manivannan Sadhasivam via B4 Relay wrote:
>>> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>>
>>> The current platform driver design causes probe ordering races with
>>> consumers (UFS, eMMC) due to ICE's dependency on SCM firmware calls. If ICE
>>> probe fails (missing ICE SCM or DT registers), devm_of_qcom_ice_get() loops
>>> with -EPROBE_DEFER, leaving consumers non-functional even when ICE should
>>> be gracefully disabled. devm_of_qcom_ice_get() cannot know if the ICE
>>> driver probe has failed due to above reasons or it is waiting for the SCM
>>> driver.
>>
>> [...]
>>
>>> -static void qcom_ice_put(const struct qcom_ice *ice)
>>> +static void qcom_ice_put(struct kref *kref)
>>>  {
>>> -	struct platform_device *pdev = to_platform_device(ice->dev);
>>> -
>>> -	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"))
>>> -		platform_device_put(pdev);
>>> +	platform_device_put(to_platform_device(ice_handle->dev));
>>> +	ice_handle = NULL;
>>>  }
>>>  
>>>  static void devm_of_qcom_ice_put(struct device *dev, void *res)
>>>  {
>>> -	qcom_ice_put(*(struct qcom_ice **)res);
>>> +	const struct qcom_ice *ice = *(struct qcom_ice **)res;
>>> +	struct platform_device *pdev = to_platform_device(ice->dev);
>>> +
>>> +	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"))
>>> +		kref_put(&ice_handle->refcount, qcom_ice_put);
>>
>> IIUC this makes the refcount go down only in the legacy DT case - why?
>>
> 
> It is the other way around, no? Absence of 'ice' reg range in the consumer node
> means it is using *new* binding.

Yeah obviously you're right

I suppose in the legacy case we don't need any refcounting, since there's only
a single reference, from the storage controller device..

This assumption would break if someone had a funny idea to specify the same
"ice" range for sdcc and ufs though (via the legacy binding), but let's hope
no one does that..

Konrad
