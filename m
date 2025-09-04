Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD822A4FE
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007131; cv=none; b=Cfj/qzKGOAdhScqF9/WVWeOeHVzNBiVVEG4/FFA6+guvqVZ8eg6yxUwaey4Y2beG12asqJCp9Qnpc7Jvrr8mnXfTuO/XMyNb4cldg3Smx1Sc7MZhBBQQvHhWvc+hz0jNQ6ZAndLx6Z5RsYRjOERtDVu5Moo77SFO5/aFXrLBOMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007131; c=relaxed/simple;
	bh=S6K7ZuuI9Bt+Smd+P1c+fd+/jUyGt2Lk9wkEvGESl70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw+rF0/ijx+W6U00l7x4JdRkX+0TZS4JOwVyr6iIpXnlW3ogF5L47Fn2c0OViPs1veL0ihTnGx1i1d7pdBCxRyHf7lhY7P3xyA1btsUypPz+Nc4VNV/MbVAL8paS29Hik5kt+wswRVMqo8wfJlKFfBge7JgMRNRgz631mCLn7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SyQqNY4M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SyQqNY4M"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X89M008125
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 17:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Da73JYrU/YH6aVt86oA5anWyeFztGpATifsoe84jD5s=; b=SyQqNY4MUimxvb2E
	dphFdMl8HZnvD9gFoeUmBK78RINJHp4EvPzSR/kBUwREEKvdIgZ69XaIXfiAskS0
	kstFiRXXynOQDO/+Bhf7eG3rMYPBQoTBVh/uj8rhfxcQdjKNCaQVP9RAbQizEJOI
	xJ+XeQ1mgH8r2Lr+YpmR65BvGf00qbzFtgrzxAtC86q6uCMA4RYT3/X7XeeqEPc+
	Ueooe7YQhng4pqWkdkYL890YuD5u3eC7RjgTzQEt9DRsi1XSHFTqc61HkL7iMvRT
	BIJbvAEmb04Qebhdh+6JJxPXWDRN7xe39AXYJ6KAOtXHSwsLvA25RqDwWhU3aRz7
	Wn5rfw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjrb9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 17:32:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b335bd70b8so22878931cf.3
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 10:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757007128; x=1757611928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Da73JYrU/YH6aVt86oA5anWyeFztGpATifsoe84jD5s=;
        b=c2fj3365y6DVUumPjWhCRE6TMNdopj0RXEITY+f05K8vnhaoVnZ2WWzuy2LeWhnJ9z
         j+L7uxiITlZvdilZVXWYE+Csp8e4Sh6kZQqGZlld9wKiNDMsCV9ZrpveGsFsUB+GRXqK
         0kizYhZhcyObvXlj4o7lXgNMjBGwUG6WZlWRGrIeuUkY4yz+lED9m90uvnNkBikOb3/A
         4gPY2gGsr+Yeg7P9wWRiw0CNGEJpgUmpLtoSUREMELCSFfPkZ9rcEm4+niwcbZIx0gca
         98dmOwD8jfUgGUW1zLPo8KizogvevG2lg+9Um43WlfPI2fiJhrRc/CYEX/DrjCNKp9HF
         WMoA==
X-Forwarded-Encrypted: i=1; AJvYcCWXqR0VW6rLlFOrgeAZWxgEMe+97kzfoVfYPAsA0tlq/FkWkSeyEK0CPBwp6ONyccjHWRszTZboKYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+K6UO4ar5+5F66tZ71Uv5vnh7Rb7/IpyFbJWgQgXqJgO+AW9
	p2CAnFT0+cQL7oTAudA3hoVCfuulcsmAkm0Ymx1vVCyf7sSU3w3GvXAzS57qkVtALH+bhD4MGoU
	DYscOQ2HJhzOShBWJFmCzfJlXAxYb23DPjwjF5Qd0JrC/HLyQmFmRTGgDlxVUHqM=
X-Gm-Gg: ASbGnctHVvbYSXyZ/WH/oVB308NkhCCA0FjKX44EqDO1ablh8a8zHBpSB/n+N2E3Sua
	yqIGzF/9UEWqVXc0BglrHPpLEJKGvNIl/KDzZA1LuE2CEXNHUJ9qjfRY68Fk/2kSSaC5hwRrr8/
	Ybri30kdMC23cOKFx7B9GhuEq5Lk+qtLBc0KSclG6iXg9SiLJuv6vHvw3KmVnbpnDfK2HTRC+TB
	xfcXCntku4ckiBXqXSNHV1mMdbCPDX6EfNgyrVl+kt37QB6VWpbUpEALLU+ImK/wYtluMYn2slk
	o7mk4pvxt1Nqezn00s+QJvm4Tp1Os0wZqcAjYrAtBaL8m/xqowDbxDlK571Ndud73iHgzWbdpPi
	uEBSKbLASirZpK/MKHgDCMMsGSUMVY4RaoEdT2b8DxTfWkQSTYR9V
X-Received: by 2002:a05:622a:5809:b0:4b2:ed1b:c4ef with SMTP id d75a77b69052e-4b31dce5334mr232514571cf.82.1757007128086;
        Thu, 04 Sep 2025 10:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzY46Xf0yuYtNJopahgPntF+57SdK24XGBjq5que+6q55hgL1+myrBZjHkcDslthTY8AGG6A==
X-Received: by 2002:a05:622a:5809:b0:4b2:ed1b:c4ef with SMTP id d75a77b69052e-4b31dce5334mr232514251cf.82.1757007127542;
        Thu, 04 Sep 2025 10:32:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ace9fd1sm1316585e87.83.2025.09.04.10.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 10:32:06 -0700 (PDT)
Date: Thu, 4 Sep 2025 20:32:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH 2/5] arm64: dts: qcom: lemans: Add SDHC controller and
 SDC pin configuration
Message-ID: <zofmya5h3yrz7wfcl4gozsmfjdeaixoir3zrk5kqpymbz5mkha@qxhj26jow5eh>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
 <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
 <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
 <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
 <tqm4sxoya3hue7mof3uqo4nu2b77ionmxi65ewfxtjouvn5xlt@d6ala2j2msbn>
 <3b691f3a-633c-4a7f-bc38-a9c464d83fe1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b691f3a-633c-4a7f-bc38-a9c464d83fe1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b9cd19 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=7jlciowUQMUDIi_Z8n8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: KusjWmwteLT92TNbhUGLiCRlCcPCU4PC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXyAuw6z3xXCNT
 yzvLw2y0bpTXMJHcy5cX1E9FO35mozig5bXYXdjQcjeoPLYlzZNfoQFtb3tozpYyVIzjPDjoH9x
 HoZQTdMywXmv7YkUVzL+Iyr8UKsnQVr+877mWWRdS9dKSDBtdlaGVVGVh7jlDKvRzZE8s0M+YTb
 PN36Xh+vSaE0ZXEmTsxKrfYUQERJSWdgBQCgfHnVj6EYRQJWvLAv+5Xs1KH6YmWRfP0Wo1NKfaj
 xj9IC7T7XtOl56HgSsCtgtQUXkw9zE3d+82rX0zZ5DOVnRoznwqshdGUDe4gVRsSXXOPiXYQYge
 +G13cJIMAM+VlY0Q7psqZ2NdAufnZu+2g8OLlu6tVLcZ2j+y53L9qQFLL3ABUFJsBNhXNFD6OJN
 QjeaOXvx
X-Proofpoint-ORIG-GUID: KusjWmwteLT92TNbhUGLiCRlCcPCU4PC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On Thu, Sep 04, 2025 at 04:34:05PM +0200, Konrad Dybcio wrote:
> On 9/4/25 3:35 PM, Dmitry Baryshkov wrote:
> > On Wed, Sep 03, 2025 at 09:58:33PM +0530, Wasim Nazir wrote:
> >> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
> >>> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
> >>>> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
> >>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
> >>>>>
> >>>>> Introduce the SDHC v5 controller node for the Lemans platform.
> >>>>> This controller supports either eMMC or SD-card, but only one
> >>>>> can be active at a time. SD-card is the preferred configuration
> >>>>> on Lemans targets, so describe this controller.
> >>>>>
> >>>>> Define the SDC interface pins including clk, cmd, and data lines
> >>>>> to enable proper communication with the SDHC controller.
> >>>>>
> >>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> >>>>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >>>>> ---
> >>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
> >>>>>  1 file changed, 70 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>> index 99a566b42ef2..a5a3cdba47f3 100644
> >>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
> >>>>>  			};
> >>>>>  		};
> >>>>>  
> >>>>> +		sdhc: mmc@87c4000 {
> >>>>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
> >>>>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
> >>>>> +
> >>>>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> >>>>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
> >>>>> +			interrupt-names = "hc_irq", "pwr_irq";
> >>>>> +
> >>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> >>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
> >>>>> +			clock-names = "iface", "core";
> >>>>> +
> >>>>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> >>>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
> >>>>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> >>>>> +
> >>>>> +			iommus = <&apps_smmu 0x0 0x0>;
> >>>>> +			dma-coherent;
> >>>>> +
> >>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
> >>>>> +
> >>>>> +			no-sdio;
> >>>>> +			no-mmc;
> >>>>> +			bus-width = <4>;
> >>>>
> >>>> This is the board configuration, it should be defined in the EVK DTS.
> >>>
> >>> Unless the controller is actually incapable of doing non-SDCards
> >>>
> >>> But from the limited information I can find, this one should be able
> >>> to do both
> >>>
> >>
> >> It’s doable, but the bus width differs when this controller is used for
> >> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
> >> only what’s needed for each specific usecase on the board.
> > 
> > `git grep no-sdio arch/arm64/boot/dts/qcom/` shows that we have those
> > properties inside the board DT. I don't see a reason to deviate.
> 
> Just to make sure we're clear
> 
> I want the author to keep bus-width in SoC dt and move the other
> properties to the board dt

I think bus-width is also a property of the board. In the end, it's a
question of schematics whether we route 1 wire or all 4 wires. git-log
shows that bus-width is being sent in both files (and probalby we should
sort that out).

> 
> Konrad

-- 
With best wishes
Dmitry
