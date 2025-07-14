Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F83925C82D
	for <linux-mmc@vger.kernel.org>; Mon, 14 Jul 2025 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489961; cv=none; b=Jq71A+7UfWuSCdsdg8d/uzqzrOlg6x8Xf9ln284C4AxG6+kA98hrUBHw+RV1hpKK4ZUfTi5HnXOaz8ug+SrUhrL8udkM/HrtJrqQdhuEGEppB/jNSRw0WbDdITd6AP5CEdem0Soey/+5nd9NaV9ZltG7B2dv4rlYa7C+DPj7rcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489961; c=relaxed/simple;
	bh=GsngcRU9ghE95V5sobt8zThiAoxS3bXWswd84ZP946Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9ZGEI5a40Nx8n+QhX32jDJzihH0ZC/MKSS51GwE+LX86MdHQDK4Cic6hYA6HcnqW1hyMXskOR+Yp+jqyS4NneE1Ad7gb+FXDGUfXXiFRcjihsrs0KjtLwnR/VFSf3KKnhj5sodKTvtgmzf2/4ZdZ6rDZG2HObWlVE1s9MsUiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OjgikyEb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OjgikyEb"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9ReeO029068
	for <linux-mmc@vger.kernel.org>; Mon, 14 Jul 2025 10:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NvkMX/SfCrQy1ThgqRjv/mjGrsXTIeTx9QKU6pkfYrU=; b=OjgikyEb1mjfDte1
	wtP/hpabasFr7CEflySVgYGJm5q0nSReES76WtUDsAjuVaGWqBaidYYc+ixjFAyW
	B1c+hS+/h5RiQtj9mbC1P/SNWh13uGAsktQ+25BjHlJO2Yp713g1b5IHML/EBtSm
	7GzjdcMCTjs4eqzESvGMBglzsukbovmXSYVcRUR95hJqGozKR0o4Tq+VKiIzkcFL
	d2fSI2y5SYSoWoqem9sJnwPZTiCFACI19+lhnsk1Jfkwn0Ld6LVvaYjNUlAeoL8U
	XKNcKYWWEsO5Gslfhw/4ku1cVVXMLjTp13cMhyuFWE+l4Q/IgOCH250QMqJZNIJm
	+gON1w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47uftmcdqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 14 Jul 2025 10:45:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab7406bfa1so1397691cf.3
        for <linux-mmc@vger.kernel.org>; Mon, 14 Jul 2025 03:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489957; x=1753094757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvkMX/SfCrQy1ThgqRjv/mjGrsXTIeTx9QKU6pkfYrU=;
        b=DqnJEv+zRMn09wPLA9d0c5bqHMF5kFiPiwg0Jy8MgJ4bA5ub1Ul0sQ3U+dEdH46gj/
         7bocZueo5y387sFod7d61cfYmuAoTje4uzRHwVTp3j8Ufg3JcW1FBLVLY2vXZRMu8nU8
         k1dABFtYw+iGpihHSn4N35ALLJEN9Z/Nx+fW7yeuKo25nFZEBCCH1ZnwM6FDLdw0/V+C
         ymeV/OhohqLmHV1b+hr/u0eeR+SpxMwxrR6yspalKYTxz03OTz4C53nFS/5HRPafva6F
         +5Mw/17pwRnWxFu7NwFbnWFSGQqq5Ti9jWiz/3QZUmKjX2bRLK7aZOSN8s+78JKrhGEI
         M/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCX6ePxTR9RqhNjv5VQ9vXvcGcQ/xv7+oRuHe+k0ekBmacCWFT+yF2Zqlmd/N72K6PqdzqUK1UIzz3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YycF3DwaHXTdje7GAOFVkvNqPv4VaPk7r+v+gVeQmsx5cUm/x0S
	Udjj+9M4s7gHt1CwVCy9m/ZJOHINDXihrsJza6pPcm70dPTyxig1lqgWRVR1FTOS7R7s7CkPDnF
	eQAX9H41i1IoePFa0xPJ0mYD+63Ea3vHAoIFXuTOb38+LTrGHN4p5okyfG8bCBa0=
X-Gm-Gg: ASbGncvebkRUFbmwFHVhgiCR8XJ33hhNSqeWTpN9Cboor4RDf7sSIfBDmhB5wSV63M2
	P/rHvLNo2FOFmcuG0tGDO+8vQz9lPQ1Mm8m5YWZhD9r8ibshhc0CJuoJOhXkk4RCLtUY8MMywQz
	v8tr+MuUK5mym6nTxtqfY01MAPTGklACXVXwS7bCost3m8FK0g/wVGFGLMIex0Nqjtyd1RbRiae
	tQCwpeKn3dVZyHv2+y1h2B732oJPK9wLQfEgffKU3eqjzlHmkGyKJnlYSl9x9I0vbytfAo6FFUb
	RrBAhKhNg6JIZjUDsXdVBD+obp0TpUlcn/1t9g0GV+Z73klfzSb5Xg0HazjlmqfgL52oSY2+RI6
	LEo5Qr97wjsXlvgavCC4p
X-Received: by 2002:a05:622a:2308:b0:4a9:a2d2:5cd5 with SMTP id d75a77b69052e-4a9fb85981emr61407041cf.6.1752489957150;
        Mon, 14 Jul 2025 03:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELfiE1hbm9W21cfQCQReZLaomvmcfube3hO9vSP/hdiOgPjCPkHWjuKc+mXLxmKJJITonrVA==
X-Received: by 2002:a05:622a:2308:b0:4a9:a2d2:5cd5 with SMTP id d75a77b69052e-4a9fb85981emr61406911cf.6.1752489956642;
        Mon, 14 Jul 2025 03:45:56 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294c15sm803864866b.117.2025.07.14.03.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 03:45:56 -0700 (PDT)
Message-ID: <e2b92065-e495-465c-957c-ac10db8fec09@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 12:45:52 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] arm64: dts: qcom: pm8550vs: Disable different
 PMIC SIDs by default
To: Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-13-e8f9a789505b@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-13-e8f9a789505b@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AI4FyeZ1 c=1 sm=1 tr=0 ts=6874dfe6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=yhMgBbtfkmf45w4ReXcA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: PyQ27wOUINMGiE_XAKkf9KsxH3JzaRct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA2MyBTYWx0ZWRfXxzRu6Nr5bRpY
 y/VaPVUnJYFv+A11AOv99ziyC+kS1IW0eVqUm5id+CFLs16JZfq4cKgwVfCe9RVu7oSX6DxrUIT
 +SMTN2iaYhc0j7uJsmBr58IG1PRFlKwqVP3LMaJKZkBeA4DdZ3eC2FbLu+68KgkCq52LHRfs5+O
 X5AjeW0h92Zj5nZ2qrW8bCYTjdoplfvGHmuWwqQbvUiCmROoNuXLNy8xtewfdxsXNRSkO2SKxaU
 XoNdj3zQCDGbNU2Ls8wP0wtctEJBKe84rGRuTXZ0ffGoo7Z6aTqhZFO7pY5EeHEpUq3gfbuqKvK
 r9mzztR0Zkiati7OVkHCFVzGFqMVNCjx89jFi4aZPTDTAT55LrIX5/PmPC68DPVNXqph/XE4Yyk
 eNX/D2xNH+ER3uGe8T9/X576bIvOE9aY0sjneO1AlRzGCLmB3uzwvkCYil/KJskULpjcbvXg
X-Proofpoint-GUID: PyQ27wOUINMGiE_XAKkf9KsxH3JzaRct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=696 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140063

On 7/13/25 10:05 AM, Luca Weiss wrote:
> Keep the different PMIC definitions in pm8550vs.dtsi disabled by
> default, and only enable them in boards explicitly.
> 
> This allows to support boards better which only have pm8550vs_c, like
> the Milos/SM7635-based Fairphone (Gen. 6).
> 
> Note: I assume that at least some of these devices with PM8550VS also
> don't have _c, _d, _e and _g, but this patch is keeping the resulting
> devicetree the same as before this change, disabling them on boards that
> don't actually have those is out of scope for this patch.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
