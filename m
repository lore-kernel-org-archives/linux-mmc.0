Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55ED328270
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770725302; cv=none; b=rxhnqlFAVhfGYmWx6gsbVq9dXl/I2CmeU50WnqIFbU7mTq88owatPK6lg6ZL2JqhwUv6yqxdzdXWeIQT+ovn2U9eTOynQYaGLpZBmFDtzQwvjmCcaef8hjixvQu60RsAvF3E9akU+femMJqbbMGgBCrGQEewdT68lvPVrObOVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770725302; c=relaxed/simple;
	bh=5UT2E8ZZlh13a8f6t1/M9YfC2QQX1bYYDvLcmDN5PoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRvup7IKuh2+YePGbav3Kk7FTVIp0dOJT3mq+KkNTi+9ddPya93C0HixGwoVNYdANjjDIesRqNwkNNYECaayS4yMooLgIlDnIk4Q1/MXRJgdW6c8ut1I484/kneJO6a+8bdqhDvn8ViwM5IK96MDCwAlI2kXmMcxbFISvzLH+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U5hEFujF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FJTqnn90; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U5hEFujF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FJTqnn90"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A7DXkw4003663
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 12:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fWHE9U4c8zXdsFbS55+J+Lip
	A5jF7lK6n2fI5kcxHAE=; b=U5hEFujFHao714hvYHxeDvR3IYZfLHShlYlri1/5
	gbcu3cDen0ujho9WLqBRuzizwkAagw3xB8+0p61+8jWJ8oCbglfdRg0VrwnDVmDJ
	H6FfB3ZI1pQDs8bMo4E/xiDpS3s2dTdNQ15nU4RUm5ed8lya4ciR1vRk8W6TOXth
	vyyVTsDb+d/IeppPSo9i0vkzm181XuqiMKJcMqJMw6UU2hyC0yGuMrjMqfyhydb4
	RSzlVcV7LNt6xSlsi6KxY6AeG4G3haXuP/mYr2Re+GkWIxwUSFlXJynpLQkq/Dis
	PIHAmCprEdhuFwBV86BRqkPVsNMMDdE1Bjzfz58VLKY3gw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7r23jfke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 12:08:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb0595def4so1200573785a.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 04:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770725300; x=1771330100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWHE9U4c8zXdsFbS55+J+LipA5jF7lK6n2fI5kcxHAE=;
        b=FJTqnn90CP/UdqBkcHjzhFX1AJRW1WzHeB7ayBr6hmhkMbDk8flcrjA3u3Q6nWpilU
         dchYGfJQZ1/Zs4J/lmkxE1dRQR2u8qODR1sKLM3MKAhutEiTIQPkGznBekyyrwswAFut
         u5Aiu00XFoOeO8SYDB87f1l69MZoBwaT8YuLjjdQVGaxdgMpqj58Ef0sbk+jRow9MUpq
         VxfxewgGymiyvWcSM1YxZ9/gTDMmni0cmURGfCs0WXEM1hNrFJUp6tT0GroS7/FY5nn6
         udhd353OJQ2HPf7+r9M0k6eg59CeRzM21YgT1C/DDaYFTgdcVSxukZRelb387DD/1842
         4Tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770725300; x=1771330100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWHE9U4c8zXdsFbS55+J+LipA5jF7lK6n2fI5kcxHAE=;
        b=qfS+xXbR3yXCSufeX8EFMvA3F07dDxVWIFm8kqjsJvXL+t2NmCyVW75lyPxR1jVVGp
         6yV6HJqzamxEjaQOW2I719zm+gw4IpJKs33eGaXUQg/54UbMdE9Nqo7NhjOUxKWRnUrO
         R1wGBrv7KaDCFSj6RBdhFYVUzIeYMQ5TqNfJbv0Z/oGUzc2+iLOQfXFkz15C+ouiSL2C
         JOSRdrRizkCktMjU9EJfqX1YjhY+NE81GfqL/vsEm86vLgvEFrLU/ZL0XhzDiNTTlZDE
         AJKTWj7N6p+7XFeXBa45ryVlkutj6wxuTj63nigyN9YT9yvI2HdrgRv/Oh3M0MY62Med
         8TBA==
X-Forwarded-Encrypted: i=1; AJvYcCWOa6FJIitcAcEB3KDveNE9NM6JMEH5mBF2AVT85krfLPcI/DuDOMycN9MFUztxqm6z99Xc2g4Fr0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSogzZMB6jxxdBrUMNIQURWWf3hQdBWW6hKowJ3LkjnHI7YxZg
	nWxCv1m49PI9z6HrPUmR8hEFzNSySll9y6rxfCE5nBE4croQp10rBJY+aeo1POQZvbrte1YJrfD
	ZFyWeeL9TXOnicVbgF1FzLn0jrK0XrydCRV3+n00Ez83KZtuwthEcr4O2GWNiTP4=
X-Gm-Gg: AZuq6aJNMBOpnWIh0LRAHnVlV+4Czz46gKSstiqcUJgAwZfeu9zuR5Vd/Rnm5ZSv1nE
	FEFk28GmGYqlHC7oqbW3CAtYCb/xbsi301FgRokLBdLV/ZY5WCi+QluVRio0HRTgHPv/U16vNir
	m0TOQ9cLtrmfkp0/mfnu9PkfznDXrgOaHNXwyqEGxoDuOdSCU+qNdb4JJ/GYZtpPSkW+ORAzg5j
	jwDeBZbvEtooNsGf98NpN1e9VL8GjwO/g/P27Lb2Oi6qoVu33zi2jpMMH0Oi1EaXt0Pdg/vOYTe
	i4uwTlchiD1vWPrCi3rdC7Sl/TP4XiY1KtMeQDl3IPPROWoYZT5iCgvkG001qp6C7onYV8GA+eq
	LOc9w126R6wUg2LRE3cOARVDkVYouzp53/HgW
X-Received: by 2002:a05:620a:1786:b0:8ca:3715:eea5 with SMTP id af79cd13be357-8cb1ed7477cmr236203485a.14.1770725299679;
        Tue, 10 Feb 2026 04:08:19 -0800 (PST)
X-Received: by 2002:a05:620a:1786:b0:8ca:3715:eea5 with SMTP id af79cd13be357-8cb1ed7477cmr236199285a.14.1770725299050;
        Tue, 10 Feb 2026 04:08:19 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376ab6e4c0sm18572329f8f.0.2026.02.10.04.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:08:18 -0800 (PST)
Date: Tue, 10 Feb 2026 14:08:16 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] soc: qcom: ice: Remove platform_driver support
 and expose as a pure library
Message-ID: <etbknbm4fwcsejnu4cqcfvmdwmzlobgki5ynrbp2m5w4yiyw2n@ztz6wbr2shbb>
References: <20260210-qcom-ice-fix-v2-0-9c1ab5d6502c@oss.qualcomm.com>
 <20260210-qcom-ice-fix-v2-1-9c1ab5d6502c@oss.qualcomm.com>
 <7d61d324-0d26-47ce-aac6-d17abdcf05cd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d61d324-0d26-47ce-aac6-d17abdcf05cd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEwMiBTYWx0ZWRfX07c973jrXMCJ
 6bTO8oUsZzTBmDdT9P73SPz4BIBlMfjkLrM17eiTT2bXF77HUq0jRTaAcy+zITrEXygQ5Q5yw3n
 ExT52Ku0V6339SjYOIbCajDvKP3Uw/e/CGP15etEVGua2zCqWWh0HEqZxvBdxBXNePZSHval3Hm
 izpYWukZ37Kdx50y4QiOLtJ2VatGWJNLO4k6Wjawy3AjkHGfWRaenEqNwPb+60gJoIxg0sKgmsf
 Gz58HiHeO0rxDgsiuaNGwTFLOSkcV3wFBZ7COq27XABwpVg981Fb0OCFAxl/8JPMEAqI2spwDg0
 YhMrKzGhN99z8GjZwJWaUiZeyxfuCJVTfuBkRTAah84pFFTJ49/CQ3c9cUabk7XEk3sz6jW2J72
 PrWE7O5LmXSs6NTSywiUALrcevY78I8cLtVWWTAtXwAsiX94B2R0Na0npLPlMj1dFB5zJuj6PVk
 V67dsY563nAwKOkB0dw==
X-Authority-Analysis: v=2.4 cv=MLRtWcZl c=1 sm=1 tr=0 ts=698b1fb4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=sslwbFw0vO9QQOdamQ4A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: zjnHDj6gQC_IWosnFNqMmLxlKgaU3i2G
X-Proofpoint-GUID: zjnHDj6gQC_IWosnFNqMmLxlKgaU3i2G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100102

On 26-02-10 10:39:54, Konrad Dybcio wrote:
> On 2/10/26 7:56 AM, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > The current platform driver design causes probe ordering races with
> > consumers (UFS, eMMC) due to ICE's dependency on SCM firmware calls. If ICE
> > probe fails (missing ICE SCM or DT registers), devm_of_qcom_ice_get() loops
> > with -EPROBE_DEFER, leaving consumers non-functional even when ICE should
> > be gracefully disabled. devm_of_qcom_ice_get() cannot know if the ICE
> > driver probe has failed due to above reasons or it is waiting for the SCM
> > driver.
> 
> [...]
> 
> > -static void qcom_ice_put(const struct qcom_ice *ice)
> > +static void qcom_ice_put(struct kref *kref)
> >  {
> > -	struct platform_device *pdev = to_platform_device(ice->dev);
> > -
> > -	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"))
> > -		platform_device_put(pdev);
> > +	platform_device_put(to_platform_device(ice_handle->dev));
> > +	ice_handle = NULL;
> >  }
> >  
> >  static void devm_of_qcom_ice_put(struct device *dev, void *res)
> >  {
> > -	qcom_ice_put(*(struct qcom_ice **)res);
> > +	const struct qcom_ice *ice = *(struct qcom_ice **)res;
> > +	struct platform_device *pdev = to_platform_device(ice->dev);
> > +
> > +	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"))
> > +		kref_put(&ice_handle->refcount, qcom_ice_put);
> 
> IIUC this makes the refcount go down only in the legacy DT case - why?

Good point. I think it needs to go down unconditionally here.
