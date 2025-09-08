Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C80C2E54A9
	for <linux-mmc@vger.kernel.org>; Mon,  8 Sep 2025 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315004; cv=none; b=YJYxVHUegf0skdtWa0RPjl3I3QB8oFq6NQ7h2Dm7mznDTe6h/mCvhS9WBQp/S8CVz17SvKPN0uU42YKy4mTXYXCIe3y61zgFXFcJrEaEyKoS0pq804Ks1FHTFaD5iF/g3Fmk8GdjYVeOZTjKZr4m3H15Lg81ADryjwNOW0p4LFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315004; c=relaxed/simple;
	bh=17UQX824nlbVdC+aYTL514AyIs6q26ZvyaBQ/3ozHsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sptzVom9BIevM6EWkwaiT40awFrmCOpVed6UT7+ejrOGuG10+zSyoHXjALwjRqKwps3ZAMZTxef2DJngjs/Fa74M/iRRW0IVJKJLrnqPWRy8LZHJQwTEfNctuHICeRRBvShtHspwJP/Nxz5EistIrKbOwovowIwRymbbBsU+wRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FFc07t5B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FFc07t5B"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587IF1ft023525
	for <linux-mmc@vger.kernel.org>; Mon, 8 Sep 2025 07:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eFkNTr8zzb2XRVtI/ozEIlqL/lrSUHLn6CThYwbEDL4=; b=FFc07t5Bd0XZ2+lz
	jg9evOPzdBkZ8LbubWd3UuXnCz/MZXPVwboy8cG5qBvlOm9fnG5Uiyg8THGI4yi7
	d2Y1oNdwm8hWUNZqWIGA3GMHodu6qOQGnNSwd90gHH7I0hpsBZxOBjdEFk7a4MJw
	mowJLMyTuOaXYSTVZRYAWj76nhPyMja50VhXzVPXMQ7X9glH8Xs+ccPwnYFCgU+f
	PLdZGHQmZTUKWmEZUreEMA0OUfoVtBibCOKVST4wN2bsPuvHbiGg2VD8Xj2Q+Eni
	zm/tHrBJXLlfhe3QqyAcFYNOjUpGfQTZoWaNq+yZt1o1kgEkmUBaswrdNYJxWM3V
	nkiecw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8bj9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 07:03:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24ced7cfa07so37128445ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 00:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757315000; x=1757919800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFkNTr8zzb2XRVtI/ozEIlqL/lrSUHLn6CThYwbEDL4=;
        b=v0MRbOkakVLTbHFpYFvDINPNdOX1FjsKEjYvPQ+GeH9hh8iCbGzcG8rChd4+NhgW5w
         WYkpIgoRP3M/NGSSCEKo4FJsnp08mOZWmhCeASJMrYEvGvg9NNDIsED2lQng+9FxSa3Y
         3HUW06EM2C9Fm/ppHYGbhXLykxPv+1kDZKtMZnXEEci2ocLf6FzhJ/8Cwu3+IPrUbSeJ
         Timuy6i4o0cT5ABBAzxpIydogzKVvpiNUR7Z2cAeczicU6n4Ptc5B4OjBrjOgxakZjjY
         +JYMrrp+/HPE6y1qKeSgGFWwbrI1MssJB6IudIomFsDdSeanjNnNAj4CNvhH5yyy/SM3
         YXfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV/g79t2Nax/pQV6ukXfsm4tZcarVlxHASsfPE0o6V+t9V9ixawVAxbwLuc15FxV8SCyUKYSA5QV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVNNElG4RmA80KEqUACTulA3IapwmL0Xi0ivoSMPE/KnYUXJl
	XwfBFmp7/APC9LvHzDxTGk7JcUY31wEfXK0oLHbFEJJ93xj3byweinbFOnr3BfG+SFcNg4KKNs7
	qJuckQghnEx4MSYeCUoz9YixnYiGfONBK/IIIwAQKlnSXZ3zOwOn3U68ly+FKt7c=
X-Gm-Gg: ASbGncvewJqaPH252t0UUCn8oDOC/u0S7XA4cxHjPQhXUyWvWcF9PMWTCYnhSexFn1R
	lRYMfwiMH1gR434g9Ia/Rz7pExixQEJVMeEvbhRTDHyLfvB53WspXmBhtwfJjKgkMjWZa3jBt4I
	9dCzQJYzg9mCyramEp5vtMEeEBCSr24cM8rG9UR0Pj9YiyWec4w4iupHCmmuRWpj8bDgRyw38rw
	0KHuUV0RNgm+i76jSWyCNcuY+btyqgzxixySDIY7ffbJfbxpYFTCrXDHQJyjZGdZn/9ibw60hB6
	w+0DrrGeSBEvHokWE47C+P39URBHVM2OQiQ1spXBD2lgxO2LWGDRrThndVskfU/4AK7e
X-Received: by 2002:a17:902:cf4c:b0:24c:7b94:2f53 with SMTP id d9443c01a7336-2516dbf192fmr100673465ad.6.1757315000306;
        Mon, 08 Sep 2025 00:03:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHAR6RVUYMHh/34G5+HxwgKEqD/SZwYH4tzTafc/vIO61o6ubhI4u1IV9iY3SgcDS+3f8lLA==
X-Received: by 2002:a17:902:cf4c:b0:24c:7b94:2f53 with SMTP id d9443c01a7336-2516dbf192fmr100672855ad.6.1757314999648;
        Mon, 08 Sep 2025 00:03:19 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24a92f89809sm238283025ad.2.2025.09.08.00.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:03:18 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:33:11 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
Message-ID: <aL5/r65/WBXx2JHG@hu-wasimn-hyd.qualcomm.com>
References: <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
 <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
 <tqm4sxoya3hue7mof3uqo4nu2b77ionmxi65ewfxtjouvn5xlt@d6ala2j2msbn>
 <3b691f3a-633c-4a7f-bc38-a9c464d83fe1@oss.qualcomm.com>
 <zofmya5h3yrz7wfcl4gozsmfjdeaixoir3zrk5kqpymbz5mkha@qxhj26jow5eh>
 <57ae28ea-85fd-4f8b-8e74-1efba33f0cd2@oss.qualcomm.com>
 <xausmwmh6ze5374eukv6pcmwe3lv4qun73pcszd3aqgjwm75u6@h3exsqf4dsfv>
 <53aac104-76fb-42b8-9e0d-0e8a3f59b2da@oss.qualcomm.com>
 <zw6o6nxczrzz3dkreq2nuxalbrlv7jmra2hs3pljew7xnbuepo@b6rs47vnnctx>
 <d3e96be4-8c78-4938-8072-abdb0f0e8f05@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3e96be4-8c78-4938-8072-abdb0f0e8f05@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX8JPomR3sr7UJ
 1EIJzVrFezRWSA+mDGGU1lN8HVh17lR/8BKIyYeVVvioC/GMH3YFsI2uYi2WpXLasZzcfYQahQs
 MgXpTSJ6GnUPYxdic1MHxJuSluMYGk8jagZ3ArGSfqcnZHbjdAzbdZCR2AGk0vVcba47qoQFlZW
 vk/pdZml4Pje+DxZuXb68nfcq/DKlTVckYx3mK9PylB4qVClSoMt5EeQVfRrNlbTGEhWxIUUM+o
 onvHf1WXY+XMKJUBVHcX00z4nXa/59d7biiuOZiIm+zSVyJI+gh15sWocrertK+cfGsski+pd68
 fPr1ePjfzG2xKKxWhlOGQJpaPLfVJ1TixvUau3aBEgPOZORP48r3O3oYNRoFgsxmhO+TADWPprs
 zAjbU+gB
X-Proofpoint-ORIG-GUID: lSUlxiY1aRRScXSuDh6CSpBlSxKjQIGP
X-Proofpoint-GUID: lSUlxiY1aRRScXSuDh6CSpBlSxKjQIGP
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68be7fb9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=jXrvpXCBLM6H2ZY3dOMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On Sat, Sep 06, 2025 at 10:28:47AM +0200, Konrad Dybcio wrote:
> On 9/5/25 3:44 PM, Dmitry Baryshkov wrote:
> > On Fri, Sep 05, 2025 at 02:04:47PM +0200, Konrad Dybcio wrote:
> >> On 9/5/25 1:45 PM, Dmitry Baryshkov wrote:
> >>> On Fri, Sep 05, 2025 at 01:14:29PM +0200, Konrad Dybcio wrote:
> >>>> On 9/4/25 7:32 PM, Dmitry Baryshkov wrote:
> >>>>> On Thu, Sep 04, 2025 at 04:34:05PM +0200, Konrad Dybcio wrote:
> >>>>>> On 9/4/25 3:35 PM, Dmitry Baryshkov wrote:
> >>>>>>> On Wed, Sep 03, 2025 at 09:58:33PM +0530, Wasim Nazir wrote:
> >>>>>>>> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
> >>>>>>>>> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
> >>>>>>>>>> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
> >>>>>>>>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
> >>>>>>>>>>>
> >>>>>>>>>>> Introduce the SDHC v5 controller node for the Lemans platform.
> >>>>>>>>>>> This controller supports either eMMC or SD-card, but only one
> >>>>>>>>>>> can be active at a time. SD-card is the preferred configuration
> >>>>>>>>>>> on Lemans targets, so describe this controller.
> >>>>>>>>>>>
> >>>>>>>>>>> Define the SDC interface pins including clk, cmd, and data lines
> >>>>>>>>>>> to enable proper communication with the SDHC controller.
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> >>>>>>>>>>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >>>>>>>>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
> >>>>>>>>>>>  1 file changed, 70 insertions(+)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>>>>>>>> index 99a566b42ef2..a5a3cdba47f3 100644
> >>>>>>>>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>>>>>>>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
> >>>>>>>>>>>  			};
> >>>>>>>>>>>  		};
> >>>>>>>>>>>  
> >>>>>>>>>>> +		sdhc: mmc@87c4000 {
> >>>>>>>>>>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
> >>>>>>>>>>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
> >>>>>>>>>>> +
> >>>>>>>>>>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> >>>>>>>>>>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
> >>>>>>>>>>> +			interrupt-names = "hc_irq", "pwr_irq";
> >>>>>>>>>>> +
> >>>>>>>>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> >>>>>>>>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
> >>>>>>>>>>> +			clock-names = "iface", "core";
> >>>>>>>>>>> +
> >>>>>>>>>>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> >>>>>>>>>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
> >>>>>>>>>>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> >>>>>>>>>>> +
> >>>>>>>>>>> +			iommus = <&apps_smmu 0x0 0x0>;
> >>>>>>>>>>> +			dma-coherent;
> >>>>>>>>>>> +
> >>>>>>>>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
> >>>>>>>>>>> +
> >>>>>>>>>>> +			no-sdio;
> >>>>>>>>>>> +			no-mmc;
> >>>>>>>>>>> +			bus-width = <4>;
> >>>>>>>>>>
> >>>>>>>>>> This is the board configuration, it should be defined in the EVK DTS.
> >>>>>>>>>
> >>>>>>>>> Unless the controller is actually incapable of doing non-SDCards
> >>>>>>>>>
> >>>>>>>>> But from the limited information I can find, this one should be able
> >>>>>>>>> to do both
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> It’s doable, but the bus width differs when this controller is used for
> >>>>>>>> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
> >>>>>>>> only what’s needed for each specific usecase on the board.
> >>>>>>>
> >>>>>>> `git grep no-sdio arch/arm64/boot/dts/qcom/` shows that we have those
> >>>>>>> properties inside the board DT. I don't see a reason to deviate.
> >>>>>>
> >>>>>> Just to make sure we're clear
> >>>>>>
> >>>>>> I want the author to keep bus-width in SoC dt and move the other
> >>>>>> properties to the board dt
> >>>>>
> >>>>> I think bus-width is also a property of the board. In the end, it's a
> >>>>> question of schematics whether we route 1 wire or all 4 wires. git-log
> >>>>> shows that bus-width is being sent in both files (and probalby we should
> >>>>> sort that out).
> >>>>
> >>>> Actually this is the controller capability, so if it can do 8, it should
> >>>> be 8 and the MMC core will do whatever it pleases (the not-super-sure
> >>>> docs that I have say 8 for this platform)
> >>>
> >>> Isn't it a physical width of the bus between the controller and the slot
> >>> or eMMC chip?
> >>
> >> No, that's matched against reported (sd/mmc) card capabilities IIUC
> > 
> > What if both host and the card support 4 bits bus (normal SD card), but
> > board has only one data wire?
> 
> Ohhh, touche.. I assumed it's "smart" like PCIe, but it's (probably)
> not.
> 
> Sorry for the trouble, Wasim. Let's keep 4 for now and get this patch
> merged.
> 

Sure Konrad, will move this to EVK DTS and keep it 4.

-- 
Regards,
Wasim
