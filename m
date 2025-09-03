Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEAA29B8F5
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916924; cv=none; b=KOeQt0W4NZAh6kwNOCvP1K5IY5kDtoYeQ4UQh0/C6w2PBoi0/jSYAWljJQ+EWNBF21XQ7Jy1rmyYZn1M2dFUlDHz7UpHCzujWX4JprPNS7swrCLIU3FjcPf5kD85ZLvEKW7eZ7N4vB9/6oME06fMt+CXK59FwNOMZdBRrXjJrgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916924; c=relaxed/simple;
	bh=h4uzpxwbZv5GjsKYDvvfHvKOFpa5oECNqTN6Yy9bj4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9QQmHrc6h12CiVK6Xb9aAVaDn4RRN4nS1YwLGV8YnTXCo+bpG4WgGLiKxUDHYVq0xzRyN2dvBUFQwRDhVEFVWjHaZnTz6vpAc3qIg3d8cl/Vmv2FVDjs1NCQvBrCj67RVg6gI32ASJA2HhWs1siy4mi1QXqLy2xZkhM201y0q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BrtsH0fi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BrtsH0fi"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwx1v007597
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 16:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3W8v279knRH3OWhUMa8czqjX5zZ7UZx/tVNRcDruII4=; b=BrtsH0fiD+ApJV97
	Y0r9qpTkipdek14wqYg/qYx6vUcKC5WywT42WJk+qpFhicqfMW0Y953Ef1q8HRtR
	3XUl31g0QSVQDhyUNDwOg5IEN4A5+JfyL6cqV8MYQQCsbWtXYEeqtWCbo+GbldCq
	FMpRJ5ISzRilwhIo6oBI1IyaWHYhqd+7YxC0pzCm+w37ldRAbgEK0ej6Bxw9d2lv
	1eW/FOyx7Lr6LamPW/hK3uH1vcUBcFWk0pT3HtSVBnoKqELJPgLJihXSsopen1cg
	lLsOzVMyEvFI+vf5kZe0dN/cbkmP2fBxMkmK+EJqj0jdQ9krQW7iqAqtHqw3OvOL
	2sKAfg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv4hsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 16:28:41 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7725c995dd0so69714b3a.3
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 09:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916920; x=1757521720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3W8v279knRH3OWhUMa8czqjX5zZ7UZx/tVNRcDruII4=;
        b=YfxGkrWO3wA8fzRTje/oQf/QdNWtqosiZe9ZYbxrJN6YGm+fNjYFdA4OPqIX14MM7j
         V8RcWrJfktdFSPGym65Qu/ZD2RLYHh6p/3eml5pfN6OqB2QDPX1JdKU+9hLNccrAI5m9
         uqbAKPpJto3B4qDHMhHXoVP4UBOOfJNclDz8FbXjxfRAX2L1eOQwY4IM7azUQ2sCYxQp
         mRLHlKSc7+VchIaDnridLdfvDT1Z+OvGeqVBqrqDaGMei5XbXNKX4ln2QMyIeJtW0AW3
         PD3oYKjlbp7VXAIAhfAgeQUlxSegvrRLhW7KaLBObRg5HCW4o6x08z9z0T2BmmLbqrYf
         WbtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq8DXdAEvqXIKNAbkoxTCm2dk+7e7lxKAg5S4BKijTOgjTw0dskAvs90K+naeQfa1jNFg2xN+8iHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8iWt/Z2hWIZ15sjUJ2/99C3TS3NEhw+BDIc4zaNPNW3CquCJ
	+PxLaqpFKjzQcRLFswqRANnpYxJSCYMRZqvGoTMytAW6YJmnzIxiZXWFH0RCagu+zGHAId5FFd+
	8jzQ1nSEj8Aja+vpl8MyWbDN0tyPd143+TC5YKEF5Ukjws0Zm2YkW2W9jCKFquGc=
X-Gm-Gg: ASbGncu64IEX7jMa+aXjthTGLDfwf74ecJocgj4uFnw6AfYxrNgS7T6eAUTCSPeGOFk
	met5PggOLwPZiQ+F/Zul7GsgJZub3ZLHTyGwDMpoQpPMBMUYnutx7V9DfghWzdQxQsWYmpFDFpr
	tyXUD3nXHDdPKIOAyZYPtIq/FUh7YqZRe6W3lR3vtWX7vYr7P3mgFbolx9B5E5QvrXehfDhQK8X
	AF496qPkoqckqgAOfK2Mi6n1d0Bx/0Lz6erhiGPGspbR+0kb0yJRLgN6BUF8fldN2360Cm16xce
	3Ai+s90kFdJgB8OiV/xIWPHPYVk0bJCuxyCrddOIMY7nQDrzaBqvtINqGfppSvVuBOzG
X-Received: by 2002:a05:6a00:2314:b0:772:bb4:a1c8 with SMTP id d2e1a72fcca58-7723e387c08mr16394824b3a.23.1756916920255;
        Wed, 03 Sep 2025 09:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxMR7hBz3AXIbxT3k+26DZmNA55+biuruOPc4EMsmI//RROhDkSqh0Pri4+DqMIllJh0FwlQ==
X-Received: by 2002:a05:6a00:2314:b0:772:bb4:a1c8 with SMTP id d2e1a72fcca58-7723e387c08mr16394797b3a.23.1756916919720;
        Wed, 03 Sep 2025 09:28:39 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725ad1e086sm9459942b3a.20.2025.09.03.09.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:28:39 -0700 (PDT)
Date: Wed, 3 Sep 2025 21:58:33 +0530
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
Message-ID: <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
 <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
 <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX8esOm+/iTORM
 +629c0/GDA/nAu9v0yO6xZcK+2i5ZiA0rxOiZidH3TwR8OTKRPBIJ5dT+rVCbzo+fBIPbKvDpgC
 L9UA+EJ3iKwTEGjRfee6vivOvO2jgvnJEdNX9enBW1fjaFY6bYYKQd4k5hwm0rgIkLFmVGm4YvQ
 AI+8ousDETOMOKyj1Q5NBf7VqIkGA0yxhrGMB/Tf/UGuLIo/nPX3d7hXohVig0d2U8hWfJEWlOD
 EfWbFK8kSaabXaTK1WWsBoiLcscGtL2wCoN0itk2EKRiaHTaaDY2QFUW2lGtITlHc1vBUPZ52+A
 twfoueuD6pMLUR0h9n9QaGNfIsuM4LKe7W+bOKToHES3sL8FAEWgdT/lb+qaa9WLrDlxr7ANwF5
 wKtdtBOR
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b86cb9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Jh9KyP6SycQYY5kWdYcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: duS_N8K8JBq2HaQWyybXhdOj0lOgObTV
X-Proofpoint-GUID: duS_N8K8JBq2HaQWyybXhdOj0lOgObTV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
> > On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
> >> From: Monish Chunara <quic_mchunara@quicinc.com>
> >>
> >> Introduce the SDHC v5 controller node for the Lemans platform.
> >> This controller supports either eMMC or SD-card, but only one
> >> can be active at a time. SD-card is the preferred configuration
> >> on Lemans targets, so describe this controller.
> >>
> >> Define the SDC interface pins including clk, cmd, and data lines
> >> to enable proper communication with the SDHC controller.
> >>
> >> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> >> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 70 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >> index 99a566b42ef2..a5a3cdba47f3 100644
> >> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
> >>  			};
> >>  		};
> >>  
> >> +		sdhc: mmc@87c4000 {
> >> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
> >> +			reg = <0x0 0x087c4000 0x0 0x1000>;
> >> +
> >> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
> >> +			interrupt-names = "hc_irq", "pwr_irq";
> >> +
> >> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> >> +				 <&gcc GCC_SDCC1_APPS_CLK>;
> >> +			clock-names = "iface", "core";
> >> +
> >> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> >> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
> >> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> >> +
> >> +			iommus = <&apps_smmu 0x0 0x0>;
> >> +			dma-coherent;
> >> +
> >> +			resets = <&gcc GCC_SDCC1_BCR>;
> >> +
> >> +			no-sdio;
> >> +			no-mmc;
> >> +			bus-width = <4>;
> > 
> > This is the board configuration, it should be defined in the EVK DTS.
> 
> Unless the controller is actually incapable of doing non-SDCards
> 
> But from the limited information I can find, this one should be able
> to do both
> 

It’s doable, but the bus width differs when this controller is used for
eMMC, which is supported on the Mezz board. So, it’s cleaner to define
only what’s needed for each specific usecase on the board.

-- 
Regards,
Wasim
