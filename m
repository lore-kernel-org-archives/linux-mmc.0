Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B935336A
	for <linux-mmc@vger.kernel.org>; Fri,  5 Sep 2025 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079895; cv=none; b=pXODjefJZ8nUk3WGiCnrT3zh8ytCapoEF/Ejd3IS06FDaEUquYRGu7eBpmdFTZC0Rwr25s2kg/hLbNo1/1t7hw2s+koLQxcrS76qSkP/JtyVKRqZyWBW7mHmci8Jus3XgOZZf528wRjuBas9qWcwfjf/HSyz78Q7ZXON7RG+ZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079895; c=relaxed/simple;
	bh=+mpyX9Og8aI2yg1J7ZFrWaBz9IJchiYAHonQj1EnHfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDqcCEEZNquJKPQjsufR13DOyxEtCFuSCirxp/T2EJsaMKTRDGvvpklvqchO1P1B1ZpJ9dCjXe5M2I482ogNQG8N3tHigIXAEFa3qfo2DxUajpPUZdYrdrWDUXk5oCNj6XDWkOb5boBH65F29CAe1T+/z1D1wwtmXr/NKQ9diHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sk8wWwLY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sk8wWwLY"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856nCVp023154
	for <linux-mmc@vger.kernel.org>; Fri, 5 Sep 2025 13:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c2zKvsgCGnbfbtTBnulsiawiQ/4EzwqzyBuLEYUqo6M=; b=Sk8wWwLYQeKcpOfl
	cRcYHlh7C9bBOynUVS9GO1QdJmwRA4sV9fab0L/DGaknVyzkgVm9td3CMBtWAbRD
	EBIUquW9fFk0OidquP7a/1wvNkCIgXulmsz4J9d6G57Qe/WSooDeU2j/zusegx71
	qwMiOUbQJEXRZOy62TyzQj0WqGC132D/kY9snRfLdUvid230RuwcPGwRVcg6fR5i
	5jMlEdkONjHkKUszbt/8Hd8DXQUVQx5WMMNq6ZO1OrFDGkGh75rk/exCs8OIS71Q
	ySHR070bWvV8xafoND0wBbH/sY/s3hzxKuvyvJ/I4f39MT3PQsuMrDF5UY4dt5Ml
	S6f/bw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eueyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 13:44:52 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-728a71d8fd9so51822796d6.0
        for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 06:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079891; x=1757684691;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2zKvsgCGnbfbtTBnulsiawiQ/4EzwqzyBuLEYUqo6M=;
        b=KzRSOwSPXxxaQUsF3pIzo/X+dU9fiiyj1l3i5SLC3igBAUggg/f8c0fZGkoBW5jJqb
         T1vGV5rK9FsBS+FKw+ielf0DHQeDO+0I++zzXoA+NCNP8aJ9wIGX9Rx9uT2r0XPvFDQz
         idETGzjKb7bfw7/77SFLFJ26Sg7jMswLm3qfoGIKjt9/6mjiKnMtF26XdLskDGSWwVvv
         U3V6wWSbYUurpZYreaimIpMCiYaM26qtRZbO2fhqcH51v8Kx/NQsZZcze3/riXAxpEuB
         5WMAkU1wcpFwGgfRCeV5pYvVW6KJMFQQtHsYhmy1gLkqXpTXDRRbIBIkZVfbTcvWWSFH
         JwFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxrgt13ygX20spPVPbXpJKwCg0Ik38OVhEO2ab47DJ1D+CMlxN6WNosZ25xPkxAq8hclMw9Hq0J1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRSzdELLePcrsRo3YW0DVYUBksRajQn+UKz8WAcECFISjwk9VP
	K2Q/lueFpPzSnbREuam5dKZboLgd+dfCjkzZHQe4nw/ys6Fxhoupngo5Qo2prQZYAuZ3maNsb44
	H85UDutQ7vO2uMHwrHNKeQOT86Oo08YeQWHGqI4BfDjEqmF3XbBfZsIbne1VVipE=
X-Gm-Gg: ASbGncs8eo1aytKy7iXNYofXPi6hs/MUzuarw11wW/YarVReqidahccrnTPcC5vnnGU
	IKxNMTeQzvXeJiGuWgpkfjFdUtshhR8+USIdrhGbutDAruZ4AIzgf7GCmoPC6kY+UFQeNL6qKHh
	m0byXT/XoOkAJbHPjOHRqXEv/mlrl2VuajBLs4dxmFj/VNCfMda3YEmFkzslcIpVW7ZWnvsH/OC
	3Nma2QPuj4/C7d7sLEk/Ma87LQqGlMue5qs83QvhpQMtao105LsouwUDnmqFxWL+7oOUcxDbVkY
	ePuroSRnVfcX/nfBr5CSCPKcpZuUriA6AWgVjKSx0849PLrEiUiqoriujbgQBVrulh6u8kVDSda
	d9lrNFqajYhEboGavXQjWthhTGTOUUe4pGRaHAhhEK9tPfx1VSIVG
X-Received: by 2002:a05:6214:3a03:b0:728:854:6c5d with SMTP id 6a1803df08f44-7280854734cmr82649056d6.40.1757079891318;
        Fri, 05 Sep 2025 06:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEysaH2r+sDH1VYSbBfUlmUfjVqBsoj0EWYtUbiy6ntQYp2Fs9xV0PFRVXB9rLnJ9AW0Z0rlg==
X-Received: by 2002:a05:6214:3a03:b0:728:854:6c5d with SMTP id 6a1803df08f44-7280854734cmr82648586d6.40.1757079890632;
        Fri, 05 Sep 2025 06:44:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad11f25sm1749779e87.115.2025.09.05.06.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:44:49 -0700 (PDT)
Date: Fri, 5 Sep 2025 16:44:48 +0300
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
Message-ID: <zw6o6nxczrzz3dkreq2nuxalbrlv7jmra2hs3pljew7xnbuepo@b6rs47vnnctx>
References: <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
 <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
 <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
 <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
 <tqm4sxoya3hue7mof3uqo4nu2b77ionmxi65ewfxtjouvn5xlt@d6ala2j2msbn>
 <3b691f3a-633c-4a7f-bc38-a9c464d83fe1@oss.qualcomm.com>
 <zofmya5h3yrz7wfcl4gozsmfjdeaixoir3zrk5kqpymbz5mkha@qxhj26jow5eh>
 <57ae28ea-85fd-4f8b-8e74-1efba33f0cd2@oss.qualcomm.com>
 <xausmwmh6ze5374eukv6pcmwe3lv4qun73pcszd3aqgjwm75u6@h3exsqf4dsfv>
 <53aac104-76fb-42b8-9e0d-0e8a3f59b2da@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53aac104-76fb-42b8-9e0d-0e8a3f59b2da@oss.qualcomm.com>
X-Proofpoint-GUID: pcFrO9WcldP_9lwlutZzW4WBrsjV-y4Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfXxns82fMKDLyr
 zCAw0nKyxhrBvkB2QFM7V6+HkOKjrHanlgnyss4AqnkiAnYkRty+ND818IYUdylYPSRP7o2AYwN
 amtUlDZwy7gMJGMAh97lqBLdSYxUVwNdFt/rzvL2xXqQ6IMZ7AsVbpnr8V2UuuAilf1JaZIF1H3
 9Oq2Y7G0+ilIhwu1Xj7av0CScEeqeQGus2+AIcm9oq45IAuuown+/fzR9+ne+BrIm0yI4yIvxts
 /vbML39chSNNBQHbEGwGkNhR2+8Y5wSulzuLRTidzEp9AAOvBR4GX+heCV6tKP7n+3nEJiU1evM
 hvDu3a/lBd/cSDHX2/rMQiuIhAv7uBW/IrApkibnw62ZTaPUsUOnb9Zx+NclBrPfiSkDQL2trbZ
 QruZBvCn
X-Proofpoint-ORIG-GUID: pcFrO9WcldP_9lwlutZzW4WBrsjV-y4Y
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68bae954 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=mUbd499wupVbqrUIRmUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

On Fri, Sep 05, 2025 at 02:04:47PM +0200, Konrad Dybcio wrote:
> On 9/5/25 1:45 PM, Dmitry Baryshkov wrote:
> > On Fri, Sep 05, 2025 at 01:14:29PM +0200, Konrad Dybcio wrote:
> >> On 9/4/25 7:32 PM, Dmitry Baryshkov wrote:
> >>> On Thu, Sep 04, 2025 at 04:34:05PM +0200, Konrad Dybcio wrote:
> >>>> On 9/4/25 3:35 PM, Dmitry Baryshkov wrote:
> >>>>> On Wed, Sep 03, 2025 at 09:58:33PM +0530, Wasim Nazir wrote:
> >>>>>> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
> >>>>>>> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
> >>>>>>>> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
> >>>>>>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
> >>>>>>>>>
> >>>>>>>>> Introduce the SDHC v5 controller node for the Lemans platform.
> >>>>>>>>> This controller supports either eMMC or SD-card, but only one
> >>>>>>>>> can be active at a time. SD-card is the preferred configuration
> >>>>>>>>> on Lemans targets, so describe this controller.
> >>>>>>>>>
> >>>>>>>>> Define the SDC interface pins including clk, cmd, and data lines
> >>>>>>>>> to enable proper communication with the SDHC controller.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> >>>>>>>>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >>>>>>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >>>>>>>>> ---
> >>>>>>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
> >>>>>>>>>  1 file changed, 70 insertions(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>>>>>> index 99a566b42ef2..a5a3cdba47f3 100644
> >>>>>>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>>>>>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
> >>>>>>>>>  			};
> >>>>>>>>>  		};
> >>>>>>>>>  
> >>>>>>>>> +		sdhc: mmc@87c4000 {
> >>>>>>>>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
> >>>>>>>>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
> >>>>>>>>> +
> >>>>>>>>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> >>>>>>>>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
> >>>>>>>>> +			interrupt-names = "hc_irq", "pwr_irq";
> >>>>>>>>> +
> >>>>>>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> >>>>>>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
> >>>>>>>>> +			clock-names = "iface", "core";
> >>>>>>>>> +
> >>>>>>>>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> >>>>>>>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
> >>>>>>>>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> >>>>>>>>> +
> >>>>>>>>> +			iommus = <&apps_smmu 0x0 0x0>;
> >>>>>>>>> +			dma-coherent;
> >>>>>>>>> +
> >>>>>>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
> >>>>>>>>> +
> >>>>>>>>> +			no-sdio;
> >>>>>>>>> +			no-mmc;
> >>>>>>>>> +			bus-width = <4>;
> >>>>>>>>
> >>>>>>>> This is the board configuration, it should be defined in the EVK DTS.
> >>>>>>>
> >>>>>>> Unless the controller is actually incapable of doing non-SDCards
> >>>>>>>
> >>>>>>> But from the limited information I can find, this one should be able
> >>>>>>> to do both
> >>>>>>>
> >>>>>>
> >>>>>> It’s doable, but the bus width differs when this controller is used for
> >>>>>> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
> >>>>>> only what’s needed for each specific usecase on the board.
> >>>>>
> >>>>> `git grep no-sdio arch/arm64/boot/dts/qcom/` shows that we have those
> >>>>> properties inside the board DT. I don't see a reason to deviate.
> >>>>
> >>>> Just to make sure we're clear
> >>>>
> >>>> I want the author to keep bus-width in SoC dt and move the other
> >>>> properties to the board dt
> >>>
> >>> I think bus-width is also a property of the board. In the end, it's a
> >>> question of schematics whether we route 1 wire or all 4 wires. git-log
> >>> shows that bus-width is being sent in both files (and probalby we should
> >>> sort that out).
> >>
> >> Actually this is the controller capability, so if it can do 8, it should
> >> be 8 and the MMC core will do whatever it pleases (the not-super-sure
> >> docs that I have say 8 for this platform)
> > 
> > Isn't it a physical width of the bus between the controller and the slot
> > or eMMC chip?
> 
> No, that's matched against reported (sd/mmc) card capabilities IIUC

What if both host and the card support 4 bits bus (normal SD card), but
board has only one data wire?

-- 
With best wishes
Dmitry
