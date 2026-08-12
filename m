Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB216369D6E
	for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518246; cv=none; b=I3jt3Wf5Hj6GjGP9NNgMZnsEuOh91Cnx1zv15tmBdlaQ06ONssJf+NLZK7413Ryve/lbTPXmRx9WkljULbYtcAz9DzDCN5GH0S4GFAp1lY8+NozQcQwt2c0xbb5NhCzsan1E7wXiqnodyQt1nr8RGqyYbGeuD/yzdbfQxrlesuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518246; c=relaxed/simple;
	bh=FfN0nJx8Dul8XdEWQBMUqwCzVU0xcVSQ8v0QjHtVDjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWHBR4UcGtO7BYWVgpD/6umRFgWfYq2xy6x6x4TzZqsF7Pv6BOKpBU/zIV1XohSYLh188FCd2XHrPuye7VSvXf8n8uNQmNgpA+UXExX79lcox5Ck7YyVH4Kv7YPsjeWov1ZhD8pb4ESRZIf8QZqd09nrXtvMm9RiHpYxfhpdv6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o/kc4tNR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UWx1flTc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o/kc4tNR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UWx1flTc"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C6298A4090894
	for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 07:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2DhVelqeFqlM7W2oGUB/BgJ5iSIedICiAX5U83IyemI=; b=o/kc4tNROW/9CdNY
	7BTb9fhVuvMo7QjsPpuGrgdnUMRCWI/O3iJNSgiK3UANjvGrSWsZ3XZqE2k3hPI2
	UoYifF1igAnveyO9K/DYYCsRLrjR+u+exBTh7LF+jOwW7kKgu59mQLH7rKj1IHAH
	QfsK5vXXQ73AmtU0LE6PfG/NABrN2bReMk3yLpkQOOvMItneZ39xill8EVWWnDlM
	L3Qw5oaiIAj+0golvv0lvXh1PN3X5rCX2a/kwOSnbCJM1zEouEPEFryHmEdhl2v0
	DVWczGw5tmtd2URtFHepCp/55JFO6s/uSrSI/VvBvD2OTkMFuHj1lnaWaS4memM4
	iL7zMA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049buyh8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 07:04:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc73f47bdcso7304525ad.3
        for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 00:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786518244; x=1787123044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2DhVelqeFqlM7W2oGUB/BgJ5iSIedICiAX5U83IyemI=;
        b=UWx1flTcH83n67mpVcpzSBh6OpQ2Eclnxa418mF9rAi9o/OSJ9KXwrjsSzNWB5fMqf
         VXNRoDxoI7TxV48MO1/7IfyW5ZEU/OH4p1anCyzcWc9oKHpQaQu4T3mOmlIXZzqu4O4n
         Q0c40NNJOU4bKu29iODvGruQMP74xCJTiHyQPsBbgDNDLmiO7C7gGgbbwnJTUwFXrDDs
         0Sgmhviv4Di/ptik5w7ckyINUJQ/1vJZNDd2Qk2ffDKgdvr38KNP8ECVel5F8CwET0de
         pywqG0Hm3AQVWRewuovcU1aJbXcSZBvRZa2je11UpHy6btBJ00u742xbjTOy3ZAjj24v
         pnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786518244; x=1787123044;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2DhVelqeFqlM7W2oGUB/BgJ5iSIedICiAX5U83IyemI=;
        b=hMPVdldEWMp8ozfQH4M5OmuIMANHQJx8yWAnW9nEUSCVw/68a8tLcnCVZzsXD2Mfsb
         0AeCPUCz9ABhigCNELQukFhTyYnxU+AIBc2QXTRYxWDlzI0Gj8vm1u+o1IGyMHGfwK/E
         WxYv4sJUl/BYr5X1b1RcX9xoEvaqS7hvCr+lZ1YRTxEiRnZE7jmAyFZt8tn58xfyCXVU
         zexh3/oTMMBzjVSW05lMsc62WyxwT1hOFwRoCzCU03ADb6DjfKhxq74j3JNRU0/Nz8LC
         KCY7zqYj4G78jObpuNHa6MBjx/WKUMD1Kn+zXAnbgyOdWhsalBckWC7jt2s31yZipyz5
         e15w==
X-Forwarded-Encrypted: i=1; AHgh+RoR8tuB9US/Q6U8qIFNbKdheRCcwIipax1dJSUrsX96r1LXz6+LEkHyka+VUuDfDCVyntEeQ62Dlu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD6LunrQ/E+uqzmLrif9H2omt3tNCd71dG2L9yRrjA9d4/Wm3r
	OUAJ1zEx+Z7X7tudd1jtMmWyosZtjX4ry8vdpuS+wvBnjxpRQ8/9d5BqPfPGZ0OtghiMCwcSR7p
	b0EHxSruCCWdAewfpbmUW3HrI2tyZqwB4BkvR/eR6BV4yQ2jufzw7wCXdiObqSXE=
X-Gm-Gg: AR+sD11XJ1q5pQORD8MVejfBqDCCw9DIWaluT/e09IWb4AAHs9t+BaxZwQa2aLREP34
	FQMv91swiSe3lKfRwKvSAMd0n+cT3fcxdmKsgo6xS8Vs2l7dXctAJP8BhLVFD4jaKQ6g3SFtMc8
	vsoVkFh2Uh4zoj9LxVpjvFO8VNePSP5i5gCIBYRSQZWyRlR0KcckGN1GE7z0DVzJWIsxPiH4jco
	9Zndl5TMxkm+AnGdzKDN2YFb1c9vmMJZQ/7LiXkp8D2SUYjhxwTqia9OaZvgRGuZbo63IJRjNcz
	mZbJFHK7eGEMOFJxt7iGxwLrzcnFxkndGLJKglerDINDqfHGxyBMLjDOPehEKpPCfzevFGnJInR
	EqT2MyqpVke1HisgNUVgDxyID7j3EPFTxTf8O5mBiXYz65PHeBKgW9eIshA7f4noFeNMHNiA=
X-Received: by 2002:a17:90b:2b45:b0:380:873:49cb with SMTP id 98e67ed59e1d1-39301834f69mr3314493a91.21.1786518244198;
        Wed, 12 Aug 2026 00:04:04 -0700 (PDT)
X-Received: by 2002:a17:90b:2b45:b0:380:873:49cb with SMTP id 98e67ed59e1d1-39301834f69mr3314420a91.21.1786518243681;
        Wed, 12 Aug 2026 00:04:03 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d35222e1cbsm2309975ad.72.2026.08.12.00.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 00:04:01 -0700 (PDT)
Message-ID: <87c2e82d-1615-410c-b188-aeccef66baca@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 15:03:56 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] dt-bindings: mmc: sdhci-msm: Document the Maili
 compatible
To: Nitin Rawat <nitin.rawat@oss.qualcomm.com>, krzk+dt@kernel.org,
        robh@kernel.org, ulfh@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20260720215645.1464901-1-nitin.rawat@oss.qualcomm.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <20260720215645.1464901-1-nitin.rawat@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Y16zVxCAqH1B5yrzZgY_ytD3ebPvsznt
X-Authority-Analysis: v=2.4 cv=ENg2FVZC c=1 sm=1 tr=0 ts=6a7c1ae4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=P79rZLnGM28BRmGcN3QA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: Y16zVxCAqH1B5yrzZgY_ytD3ebPvsznt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfXwHPoL7fZsrXz
 Hl3Oe5jA785UJ0NOrtb6WW8+y5h23U2W5Da3WdB47ZWQL02VvRLF1l4PCCUYVUU8CA/9hRrQYHE
 9VhTF520jRyLGlMdh9cfUHDRwm9NQ9Il7zL6Lc86n99x4qcHHldMVWzTK0PdtwoTJ7vAfA6nAtj
 PXc8mbuiF40+aEwlzGcQDOJNAxqoWg4T4LgAWysjNWEs/8R01JhZUcmnAQu5MOa4/oSI5HHub7y
 zDO/PkL1XncFLU+BsnE28pDjpNJOPLwJin4q4PUPDSy6GYQOm+ZGBT47BpbL+NUTuizfQdFrSHw
 NUGEX/lRisx9jHTpq1bAxetv3vOeK8FH/9YqTqicF0og10FyHbJsKFhjGGUCYvOkchPRd/kGIQM
 VlPLpGQZZexYQFig9kTPnd0YpAtSCVsmn3L+gsVLJ+mW62KY3641wlojSJlLkdG9Eq+OI1Io1YU
 8GUHvuIGJDZByBq/q3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX7mK7gpLyXvDd
 0emtVHodnjAvikToyDh72hmb6bbMVzQyPEew4FnVRhdJj21NIii8OnLZJjFlxIIn/4n6U8doKhV
 jrGwkq7rw9D2U0osbFmqy/9w6gkN4sM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120054



On 7/21/2026 5:56 AM, Nitin Rawat wrote:
> Document the compatible for SDHCI on Qualcomm Maili SoC.
> 
> Signed-off-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> index bd558a11b792..8dfcd1351551 100644
> --- a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> @@ -47,6 +47,7 @@ properties:
>                 - qcom,ipq9574-sdhci
>                 - qcom,ipq9650-sdhci
>                 - qcom,kaanapali-sdhci
> +              - qcom,maili-sdhci
>                 - qcom,milos-sdhci
>                 - qcom,qcm2290-sdhci
>                 - qcom,qcs404-sdhci
> --
> 2.34.1
> 
> 

Reviewed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>

Thanks,
Jingyi




