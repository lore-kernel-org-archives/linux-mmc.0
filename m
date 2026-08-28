Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6473123AB88
	for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921843; cv=none; b=oWrVcVdXCuySaakBYyJKoN2OP200niL8y+TSlDnQIsZ0dxD2elAzpq6gyGIIN9ro2wvNNXGEu8iMxMtRmLJaKd3eQ8hLURWP61fMwjACVcrIsUT0AIPwtQg38KC2wgP6Bja9/V0ki2HppufoL912d21bJ5uifKUu1HlmX09w0QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921843; c=relaxed/simple;
	bh=ru+yAHr3urcJ5M8KBNo1D5Vm86Tk1kQzSSNlmFlhCdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqUbaVeMHhVEiZTiQ7qKqjeeDyq1mEq1yX+HDFyDuSBQj8EDpR9gD0D/oyO/CeSeG9kUm8zzN3K7pE7+EuZkTYiPdcFXc4cD4DG6hjZmIIG5vaOpGUnXungFKwMzLX6VAIt/vc02Ucecjje91L7cGns3jdeZ0iSOFdaQe32FkBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dCvK7way; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fIK/0ohN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dCvK7way";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fIK/0ohN"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SA7cdE2744793
	for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2026 12:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6mztBACuCG3RrcAN2JymhhQd
	msNbc5JG/TyNTdYCnpg=; b=dCvK7wayBREnZu+c26O85FnFRAduOdGhC+fgLPGr
	qWF2BCp8eMYP4UEvj7wyOZf4PxYQYOq7mWqUFnYlCRKTgj+2iSRkPrUZKszZCVVi
	2P5LtdddbCogNWmVLUh5zJMGkgdysU23qY8ti5Mv+y6qhkVlmvOlJQHfob/AD7R5
	v76WDqzPFinCPkfUU0wRaKWuKDYvXlpjRZo2Gkrnw08xKVU60zfJHBMcCFsBQ/qf
	PKKuH0413SrI2k0ft4h7FJ1MkzJcgSWIZsoow1ZKM3iBhNpIts3cOPr7odQK6lad
	uuoMjtooxruBBe+y19UPcjVUHxlchXunpF46x0F1iyJhSw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mxsun4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2026 12:57:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52faa0dd18bso23201671cf.0
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2026 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787921840; x=1788526640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6mztBACuCG3RrcAN2JymhhQdmsNbc5JG/TyNTdYCnpg=;
        b=fIK/0ohN2DRIlmEWFMTbfWU+7fJWxt+9GAArUG3SwX16hGxB8BEy8Eo+lPwBoTZ1kM
         RCn1Pxh/+waq9UoiCh4oJeB6ycDjCqRMa+RE0llGT5+G7aIfwNM/eQi2uGpMjiT5NzUv
         Gyb6I75S+02n0VAKBcK0nro8vgr9X+qIozV4H+me1mAnV9vEBJ6RXKVirRM/kFf6CXx6
         uX+JOKxRLIFk82uo3fyjrQAtRSwp2WUafvSozzPHylSI1KYUp7vouj0pDL4RPhH5Twkb
         ZddiWSveDUuhx+9LPO3NkPvQA9R45Fx8pdIcbvVUx5ErjRnN7okcuC1ohaMAH7nvRvmO
         NepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787921840; x=1788526640;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6mztBACuCG3RrcAN2JymhhQdmsNbc5JG/TyNTdYCnpg=;
        b=rma95KOylt+36pvPQ/B4SeeAMFHq/xmJsQfEb/51nwjsDWzKSeyw/KBtV78tbKvOha
         u1d7RgaoSWz62y1hq2choCX3zg4En1TBOTtQjfrg2tYSrgQcXaKqv8ZR6NKnBmS1GFlz
         TTzIkn5cE/biaS1vJCKoS8AZX26drIEpcT1vxd1tZYxp0XZrK2ZrMgmILdolWU5fyBUF
         oTM0QKutOmoVyk+I0DrgN/OHGsr4AraXzvubPlWezsS/QwQh3yeJTRlq236/DH3lBpvb
         AhcpvFmEo5cV6nByyTvU3RprTHcOVjevrP8qTdS6+dJ0GkVxTyAsbc+gjSmEgt8PKFCY
         okHw==
X-Forwarded-Encrypted: i=1; AHgh+RrRXHvKif29smndW2k26PR85HqKttdNOxNeGRGy3nFhur2XhOOzkQ7LVjHyoVQgNNCsoq/wJTIU2pQ=@vger.kernel.org
X-Gm-Message-State: AFuF++koWgS5Eou3G0fqhZcQBv+hg07CbycXCSngYjMA+Cqes1dWwdOF
	nj87g9IM7RsAgFFDleIPz8cF9H3476UT7QSlHe1mwYqJg6af3kuHPffrQx2jUccA2FZXrpWEQHg
	8Mjs0285O8G/RdMa4yIhJe6nl4AoCEJ0/o0oWu6HIO2huSE704RfDlqbqq18zmzk=
X-Gm-Gg: AR+sD1176B9dL+LwbRaac5WlMo+F/HH9sy6RrpKYFUdzPj70potEn8zkcvbrF/d88hL
	l2ZYU1u5moasihH5FF6joXfNqgmf/kjHcWWNNimlKIgX5CbmDHW3DUsDmOnuFMd6I7eMJeJzTkd
	yXqDTb7lX6OzoVNbqYCsYsvppoZlYmd/o3SggpUz6KtJJmK/lT6O/50s+aj1NvuZXRqwIJdapIZ
	lODqwH4nA4sDFXgvJxFI5tBBP7zK5rSLURgM/tvYng6IwEF1hwcHx2+KjLCVM10HPGEt7LIg9XX
	falg/HOyXVeB5pPkK5pz7A19qruYXhP9T0g+UGfX+8wQa6gdDcQfLnmocLFI2qMtvvSL0Z0V99o
	tEx6g5wv4UCV8
X-Received: by 2002:a05:622a:e490:20b0:52f:bdbf:4086 with SMTP id d75a77b69052e-52fbdbf4745mr34332571cf.23.1787921840516;
        Fri, 28 Aug 2026 05:57:20 -0700 (PDT)
X-Received: by 2002:a05:622a:e490:20b0:52f:bdbf:4086 with SMTP id d75a77b69052e-52fbdbf4745mr34332171cf.23.1787921840006;
        Fri, 28 Aug 2026 05:57:20 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbac8e61sm3986925f8f.13.2026.08.28.05.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 05:57:18 -0700 (PDT)
Date: Fri, 28 Aug 2026 15:57:17 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Subject: Re: [PATCH v8 2/3] arm64: dts: qcom: kodiak: enable inline crypto
 engine for SDHC
Message-ID: <mwf5hq3gnkesmccede2sa5ni5lyxg3zfnxvwchts2nxh25zndw@uyn4dqehfdpv>
References: <20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com>
 <20260629-ice_emmc_support-v8-2-1a26e1717b85@oss.qualcomm.com>
 <ba96f5e3-6b6e-40b6-b6c1-300e862e8ee4@oss.qualcomm.com>
 <d3be45ab-0390-4d0e-8d5b-330a48c529a1@oss.qualcomm.com>
 <1a0b91c6-5e17-4330-a8ab-ac14d3339024@oss.qualcomm.com>
 <ffca92db-a3ac-4345-8477-1f53ec61ef16@oss.qualcomm.com>
 <56ab63c3-4288-45f7-bfea-d40046437a9f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ab63c3-4288-45f7-bfea-d40046437a9f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExMiBTYWx0ZWRfX+DsNqZTC10SA
 FgtxAuH34h34ySYqVZHX41Wepgn48UAEZl0dHWom5VbRx0gupiluDzQgAHxw+kA6TP1EuDc8zgP
 8JuDy6a6EvgahrIg1cVZOjIb9gtAC1//59FK9dm6J/l7ArIt4LISywG7o+JWsp+aZFUrkB4ztjG
 PDo//ghyxC4DYMgZjCu3oP7SmYwhw36hGc7orexCAm7OHgLU+HbCNWFfxsG0IPcrk4n8lM/qbwc
 gmqQcHXwCXTliHzODzolIqefYoNZiJ5sR7cm2uEU2706/Ne9z5hEp/IK9hkvHyfOuquM3EO5Pvp
 H2eJJZka9pVe/8XErSnnpErROMjwB82bkyNaY1Gnxpo9+iakPufO0Gtm+GrFS6Hfed6UuEnCxSr
 bMFdDLDgNH70C50lItNQtF1iHLc6LHrWzhv2H3hZmYg7BnZlwTcrgTNNxf1k75uuKynt/qdrnSi
 BfloC00wB2r+Wn1JOPw==
X-Authority-Analysis: v=2.4 cv=MONQXsZl c=1 sm=1 tr=0 ts=6a9185b1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OvFCWnAnuTFQFf3-HNEA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExMiBTYWx0ZWRfXxAxbgpAKo94D
 DkPByvegkP/DLw/vpAovtm02fPaA+Z/Dk+RUsppi763zNHCL+qJbr8XsAyAGYgurgmkB7LuqH9P
 /pa9kU7VlVL59c+ITtjvEh3FcQ2tj6s=
X-Proofpoint-ORIG-GUID: aK7BvGQH3bv7Z-caT1nhNWGGk7_nJS4s
X-Proofpoint-GUID: aK7BvGQH3bv7Z-caT1nhNWGGk7_nJS4s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280112

On 26-06-30 13:25:13, Konrad Dybcio wrote:
> On 6/30/26 12:23 PM, Kuldeep Singh wrote:
> >> qcom_ice_probe()
> >>   -> qcom_ice_create()
> >>     -> devm_clk_get_optional_enabled()
> >>
> >> If we remove the _enabled suffix and put a ice_resume() in ice_get(),
> >> I believe this is no longer an issue
> > 
> > I see your point.
> > devm_clk_get_optional_enabled turns clocks on, whereas using
> > devm_clk_get_optioanl will only get handle but don't enable clock.
> > Please note, clocks are needed at probe to read ice hw version 
> 
> Right, but we don't need them afterwards in the probe function. We
> can simply gate them. There's a parallel effort to enable runtime PM
> in the driver:
> 
> https://lore.kernel.org/linux-arm-msm/20260512033750.3393050-3-linlin.zhang@oss.qualcomm.com/
> 
> and with that all you'd need after getting the clock is a
> pm_runtime_resume_and_get() before the version check, followed by a
> pm_runtime_put() right after it
> 
> 
> > and then
> > later ufs/sdhc fetch ice instance using of_qcom_ice_get() and control
> > suspend/resume path.
> > 
> > But my idea is, if storage itself isn't there(like sdhc on
> > qcs6490-rb3gen2) then why sdhc-ice should even probe and check hardware
> > version? as there's no significance in even probing ice.
> 
> On the developer/customer experience side, would you expect having to
> manually enable what's essentially a sub-feature of the storage media
> on every single board?

Wait, don't we do that for display nodes anyway ?

Also there might be a case where you just don't want the ICE enabled.

So I suggest we disable the ICE by default and enable it only on boards
where there is a consumer.

We don't normally leave stuff enabled just because runtime PM will
disabled it for us.
