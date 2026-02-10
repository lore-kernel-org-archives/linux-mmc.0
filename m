Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE56341666
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716402; cv=none; b=S9CBRpeJWW07ddY9QrbSJTFBZ/7FXoG2YbYiP8IvibATO75lKj7TL5/Oh4sW6sOmh4WgM6kBLpT1ZOlImnVkajcg8Qft7p71511UMGixz/rR7L//cFfllpyBbQ8TrZnVKETPviGNnx7nIS/5cmSzZfPHPKFkZzFil80xxYPXnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716402; c=relaxed/simple;
	bh=iJ8I2MLehXxWMGH8SM93i052CBAir46Pqt//1QASbh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rD8fx/2Q+HBboGgcpdsy5tJMJdDnDrQ1lACP6uuy1Cq+rHtpcK19e0eBjTVQRH7dPYmO33h5v6qvrcJYMTdiZo7973ySr1NYgLQyCUhPVrRe5b9clvJQU7hB3VRvmpgrBIC6eAj/RByfnHkuMQM49gnx2JJRBqIvU0kWnexQqWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mLbAddnd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZysRivEj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mLbAddnd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZysRivEj"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A7Zbdo1419500
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 09:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0TAMvNeZiQWgcpalJSVZi3FF+L38Q5MAyklwP4Kb4qQ=; b=mLbAddndJbDn5ony
	egOTVcGnWdUyI2FZkelsdXo6pWG2Xk9p06LQyqwgfs8jtv1q7zKoJkESvCZd5Olu
	Xz39JOMVgn4SrsG4UcIsll0CQr7NTMHY/D0L6qmnvwn/ib5SI38kzjTrb7Nda0Aq
	L4LzVAuq2EqosezwVlLyuEm+88a9WfDLxBOxrCMMg2dpMm0DW2iEpG2gFjtOybrG
	/oC+uKEGwUoOBLGbnZApqOcDzBIwUNCAXEWnGGg14kVTpz78X070JJ6hfJHBlw89
	g2UzMyvtUVO5hChmc5Yug9js03JjvYkJ/z1w7JjH6ByLJT79R6hrPdVjKGx003zN
	ATYssQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7rpvsx8n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 09:40:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c53892a195so103084685a.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 01:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770716400; x=1771321200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0TAMvNeZiQWgcpalJSVZi3FF+L38Q5MAyklwP4Kb4qQ=;
        b=ZysRivEjwazKKCRlxUuKl7o7PvdVyMdiN0Xq+cUOWWUoYU9Opf1PbXnObA7h5Jchki
         8vg6quW/2Le70DE0xBNBdC/CL3WTa0EiSivfSe9I1tz5vyrKio40VwoBTASulBePcrCA
         eWPpjI0l3ZA7vpT1zW+EhrjS9Gsv7Ojl/aLpWIiB+PzDfO28DrTjvsWQ7Lip8YldQeCN
         fu8i/0qW3mnM7mbl/AXs8GUxN1duO7nQpjpemHqaimsU15GPzfATuCD5tzs3l1scLQqE
         QIjF+H1KT8p7Co+90N9FxlL9+tju+HbTT7Wsy8noABgTP34gXLElY4E5DcCBHZtaby3G
         9oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770716400; x=1771321200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TAMvNeZiQWgcpalJSVZi3FF+L38Q5MAyklwP4Kb4qQ=;
        b=bmBrwDBBdWSOKnPWqSb8jT0hdt+9ju+pPP+HHbdIAEkdEvmbMLcrEEmb+pXEiKMssc
         wRvU/PNHHDSwI12leQJImq/JPFZU2oYUcwDbFkvFOKn6dc6tOyenE1RjeL9k2XFeKiIC
         ina3gBrBBQfsF9Hlu4Z479A1Qvd0HThg5Ug/L3oqH+vY2LyTGsQEDP7Ges9RvuS3E952
         NbFm75OOetnA+XyQSOCO+9reVvZ7GYxT8WU09yRA+kZgZwus9KJHtPEehWNMoJSgoBu7
         fdKDzI6odWOuukgu9T7U0SBuYtlbbGRwdR+yuE3Q3uycIidJzP2zujZ3hUTDYrpG4i3a
         Oa2g==
X-Forwarded-Encrypted: i=1; AJvYcCWGpdePbcHZn2uX3vfWbCQS3f3FaO7ZcWbhVSRNU6DP91bEQEuC9m+iD9vC3sQHvGzDI0NSaT42nV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9UgBCEMILuXIf3w9p/gNjqdW2Vte3ykF3lm4wpubIUob6gt2
	so1RxMElK+YqxmehbHTddYYU4WK86GueBQnksEtiIt19C+OGwYXDiSYgn5gvzS0gS3dieB/1mO9
	HUhgpS1kpFURFHvUwRKfnp5VbFD/8iMRqv86Bqscrm/nYRFAuJ7RuLkkULbyqrCk=
X-Gm-Gg: AZuq6aJ9veDdjieCm8CiK6a2ExM5m4DVPMeR/kXLaaShzu+9vLc7QyDVxNd43CVq9Ma
	zmxwZLalSxbKjw7wbjBenHje8lSPICE49QbLvDPL3IIvADtNjllZh3rvlnlzFFC6YgBpWPwQI7f
	BOvTgIp4UYFKz/orOEursXJKV6pwc4K5fZUtABXFi4WK2Zg/MFGIGdEf1maYM+ettVNVEe3cyg7
	xC2hRn7aaQx/FjSbY3HGSSHtnz0mhsgvQuhZfHZrUeWJ7CSo8sb2HLDurtpg46I8h+KCOoTvkh+
	XvlvWtLSdkv+mU+VonZ9qv4UpvtpIBaA+8bH30IYSgYcNqZxwdCjCbDr4SIvp8W/foAkmFibznz
	mRYBu2uFdh1UDgF3jZP3nGEgQ62VX94dHBaRzjqnFijrCy12JA5ZBM6Y8OcJzqsjXneKcbDUCW7
	lDgvs=
X-Received: by 2002:a05:620a:468d:b0:8c6:f7ad:49b with SMTP id af79cd13be357-8cb1fef263cmr107730385a.5.1770716399514;
        Tue, 10 Feb 2026 01:39:59 -0800 (PST)
X-Received: by 2002:a05:620a:468d:b0:8c6:f7ad:49b with SMTP id af79cd13be357-8cb1fef263cmr107727585a.5.1770716398983;
        Tue, 10 Feb 2026 01:39:58 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8edae3ae99sm516585566b.60.2026.02.10.01.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 01:39:57 -0800 (PST)
Message-ID: <7d61d324-0d26-47ce-aac6-d17abdcf05cd@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 10:39:54 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] soc: qcom: ice: Remove platform_driver support and
 expose as a pure library
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>, stable@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260210-qcom-ice-fix-v2-0-9c1ab5d6502c@oss.qualcomm.com>
 <20260210-qcom-ice-fix-v2-1-9c1ab5d6502c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260210-qcom-ice-fix-v2-1-9c1ab5d6502c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA4MCBTYWx0ZWRfX4n19br6SrKNp
 unfWjfeHigFaUrEJIYxDB/c8dH8Zu4QiGON+t7rXQ+4ndTwFdTQjda4bkr+zSJ6lMkcFJzjBnYQ
 g0v6tjXAvvUjjXzNJRgWHtQROD2eo1CHv0rcWfgRQK1eSujGR+AWd7d11F0P8O7O/7nyMrZ5LES
 CyHp+msnSvtyrQgJHki5ow6/rWsyViclbUVaBlLh2p2TQcrdKuQaSXQVLqPisgW0aL3TJ7Ng74Q
 gsuTGH4Crv/o7sGvkcCViKlsNolG7BJHbEy2Nu8kHHGK4D3Rws9gCOdJC0DQ0DiNpSklua+sjK1
 Mi8jeFguhGdYpAxVcNEM3VRT8oGbVDCfTL7PENe132YYo29C997ooqIh/2t1PuiRb6VeDWIqCb9
 no+q/UuDmfZTOJOxESbzTZ/HE1PuQmrbHcw6rdLPHViXTzNKONH1oM8dwMHz+0FytzqVhine7IJ
 Bb7/2OS9BYklNStH8/Q==
X-Authority-Analysis: v=2.4 cv=KKZXzVFo c=1 sm=1 tr=0 ts=698afcf0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=Oy1HdLtELvYQmIkUJ8cA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: uUOYZMIKWIkB6fc4y3aZsft92vE1lZYU
X-Proofpoint-GUID: uUOYZMIKWIkB6fc4y3aZsft92vE1lZYU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100080

On 2/10/26 7:56 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> The current platform driver design causes probe ordering races with
> consumers (UFS, eMMC) due to ICE's dependency on SCM firmware calls. If ICE
> probe fails (missing ICE SCM or DT registers), devm_of_qcom_ice_get() loops
> with -EPROBE_DEFER, leaving consumers non-functional even when ICE should
> be gracefully disabled. devm_of_qcom_ice_get() cannot know if the ICE
> driver probe has failed due to above reasons or it is waiting for the SCM
> driver.

[...]

> -static void qcom_ice_put(const struct qcom_ice *ice)
> +static void qcom_ice_put(struct kref *kref)
>  {
> -	struct platform_device *pdev = to_platform_device(ice->dev);
> -
> -	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"))
> -		platform_device_put(pdev);
> +	platform_device_put(to_platform_device(ice_handle->dev));
> +	ice_handle = NULL;
>  }
>  
>  static void devm_of_qcom_ice_put(struct device *dev, void *res)
>  {
> -	qcom_ice_put(*(struct qcom_ice **)res);
> +	const struct qcom_ice *ice = *(struct qcom_ice **)res;
> +	struct platform_device *pdev = to_platform_device(ice->dev);
> +
> +	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"))
> +		kref_put(&ice_handle->refcount, qcom_ice_put);

IIUC this makes the refcount go down only in the legacy DT case - why?

Konrad
