Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE47301469
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992912; cv=none; b=Zhcyy7obyVL1k6+oPhJD8F/zS3Vg2uZRpa6hHIOI/+esPNDPnI8VdJyLzBx0FySdpnX0dMVciKp7qayTHIDs3a0bAP/huuZ5jTOvnSrSGiz0o3yFOE9yR8ToCNN+/ozq57ltsOFPf8x+0rQp9iQ+ZGI+r8Wbjj2f14JiYPSf+5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992912; c=relaxed/simple;
	bh=mNw4NPJv7jfExJEaKhRJuxPTUkc0hirhY7JArHV4h90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMquaNUbg1ahqpA5hLvQDT4myVHfOqe9RB7fhT/+eAk11FjLSNMTuhpnUMWoTjLRf7trqsllBvtDIhmp5oxs+TdTY5/Io+ty1LoFKkHgJqQcO7ObRIEqs/nV/IT+gr8V8PJqro0FJo2vVOyjHUcbXvzCklmY5WFQ2aCSYbs+9RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sw1j+vVA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sw1j+vVA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X823031806
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 13:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OPxYfslCOHAID8SwXwG5fuaFBZwwpSGhUdIFauIo1JE=; b=Sw1j+vVAiPFzQ5kk
	VZ6QxScya+uHCTspldly+ltI7VOtyAO+fwpG/mfGEfNBIngjzlf4BKj9IUK1D9WP
	c77xC+M6IVj9SRNrNi4O/chNKqy3lQ2pEZnrNmTYfqN7NFTM2Z49+nBq5cMoaky0
	nSHf+u8W9h/1Woavt+BZ8WI7xrstxuudIBigaaMGixM2z9SZMn9Qj3pe6tI2Jk2E
	dzuzKc8aZVOhvPJjsFCqUQade9bqJbJEokDZu2BgS+Wodgh49KiXqk189L4bPCs4
	0JJrAPvTp9pJ5M8jnotkLAsFsaxHD3aO4sN0s04DQwwBguUW4E25DrKSUmEmXbLZ
	R2YHUA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw07nd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 13:35:08 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7224cb09e84so16026256d6.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 06:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992908; x=1757597708;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPxYfslCOHAID8SwXwG5fuaFBZwwpSGhUdIFauIo1JE=;
        b=ZUd+34a+DZ++dVdV5LEytBx9sIh5zziVSHcpBlUxkhBsl3D40SnFLrvVj0Xx08TVAx
         QvW0vYTZaQ43l/UtH/ERnWW0O1Mdo/NluxaT0cW/+zwvseaakZYrV4gD98KZsrojtAJB
         jPMUSGGAsTksKYURCEjt8umcg9jZhSNKMlGJphUyAjKBBFh8DkMqkV6ifWnfNjJfj0X2
         Ejv888Biitv+5ek1zENWNyOqUx4GkZHklr9b+cLrJrzPmp5IsMtiwteQNJufdt7NOV/x
         p8X0pHeYxFT+LlN09ffiYK0BOYQ+0A50I5lXSMbqZK2YztbjNsFVWdYYNvhZq4j0bR+S
         kTRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQm+1XHiQkC3q6Am7zPHJSNyu9Od+faB5YvmGuD20uq9xovtk6q0Xbj+WCcDEah8rcaBL//6ug874=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoej26xzUE7o2R9YfrVLL3wKQinYJTAcRfKumG1iaI+M/U8C+F
	Wyotx/bB4RHmT4oqB8DAcO+T/4x2JP/dX6AzvkDHxXEwy/AfcNs1Uq3xuFj0Oq5sJLfPlqeREcu
	fVNGhCqa4fdLupzUIyB1pFj4nv1X7CsQOnefJRhz7nrcZ44KGoUNkL5/iH7g8Tao=
X-Gm-Gg: ASbGncthm3ejWsINNQe4ECPMPu0fIlDqHfUbaYR3CRZHKlLwlGVUwqgsUMYUiNr5N8U
	jkMdLb/a140daNQbjxQvVuShFGmmoQJ/LZR/7ISOrDoCUnemspGtu7nPhdrkO8hr+hybNolfBVV
	YRveW10Y2vBQKng5qMkuQ0ivQbt4Csx8XJzwe4vCeT+XE69c9YTqxxcHc66l5sVUZolFH9fGSLD
	aYP1G0NUF2NhhlTukSriN9MxPLGMGfU7KdUoKNWRZSt1u1Fl2kO7Kffif7rCJ3nO0jK9eWZ/H5N
	5A76sjWvmad7tAcbPZlsLHk3ohqNpcROg6l1391sPh3W4XxUjQZU4ajRQokHJopJ6m//d0FQoeE
	9wUjI5JT9v4IIGxk+cEeL3xj/d1m2o2ms/An4RfCE2qOSOcl+R1fy
X-Received: by 2002:ad4:5b88:0:b0:70d:f64e:d49e with SMTP id 6a1803df08f44-70fa99538d7mr217622436d6.23.1756992907766;
        Thu, 04 Sep 2025 06:35:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/pjp1F9a67cZt9KewNwhTZVwINluKfADfpH0CCTf4H3LNZ9T9PTZyP8kwGKz/Y999D34yNQ==
X-Received: by 2002:ad4:5b88:0:b0:70d:f64e:d49e with SMTP id 6a1803df08f44-70fa99538d7mr217621666d6.23.1756992907150;
        Thu, 04 Sep 2025 06:35:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfaae4sm1239147e87.99.2025.09.04.06.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:35:06 -0700 (PDT)
Date: Thu, 4 Sep 2025 16:35:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Message-ID: <tqm4sxoya3hue7mof3uqo4nu2b77ionmxi65ewfxtjouvn5xlt@d6ala2j2msbn>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
 <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
 <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
 <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
X-Proofpoint-GUID: lVHnwXBzO9JVeyzcrfVSHig57JL6_tp3
X-Proofpoint-ORIG-GUID: lVHnwXBzO9JVeyzcrfVSHig57JL6_tp3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXyo5+fsF5YZe8
 m55qAndG8VgZIENyrGe70wlZYNTUbLPleEmqgweDpDMQnEWz1Uto8d7c5h9eLJZGRU/6jUjqGSF
 vZLNLJPn3fZSQocck3SFmjkH1rPePN1rxZ1cju7NNg3fV1kTs3XAyOpchVVy/+UnIXy3wtesRis
 0R89nG3ENVz9YWN76OUKiCVbHD63s5eNgh7aSCY1UgXTUoDM504q5DEIemPW+SkZ8LnlOiAFqg1
 nZ5C0IguJKycp61qMmstYLc0eC4WiQ/BBvs6jdetsP1wxxQNs/rlyK6vE9/rdUuomGIlqr9ILwE
 7CM8shyZrhKgXHpioZPWXrs/lrEEegUW1FOZU+yJfp8tMtcZewzsfE4cZFVMMN5yHXOg9Y8xBKN
 dIlHywUJ
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b9958c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=QCn0C3cCROmBCoviGrEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Wed, Sep 03, 2025 at 09:58:33PM +0530, Wasim Nazir wrote:
> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
> > On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
> > > On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
> > >> From: Monish Chunara <quic_mchunara@quicinc.com>
> > >>
> > >> Introduce the SDHC v5 controller node for the Lemans platform.
> > >> This controller supports either eMMC or SD-card, but only one
> > >> can be active at a time. SD-card is the preferred configuration
> > >> on Lemans targets, so describe this controller.
> > >>
> > >> Define the SDC interface pins including clk, cmd, and data lines
> > >> to enable proper communication with the SDHC controller.
> > >>
> > >> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > >> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > >> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > >> ---
> > >>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
> > >>  1 file changed, 70 insertions(+)
> > >>
> > >> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > >> index 99a566b42ef2..a5a3cdba47f3 100644
> > >> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> > >> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > >> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
> > >>  			};
> > >>  		};
> > >>  
> > >> +		sdhc: mmc@87c4000 {
> > >> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
> > >> +			reg = <0x0 0x087c4000 0x0 0x1000>;
> > >> +
> > >> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> > >> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
> > >> +			interrupt-names = "hc_irq", "pwr_irq";
> > >> +
> > >> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> > >> +				 <&gcc GCC_SDCC1_APPS_CLK>;
> > >> +			clock-names = "iface", "core";
> > >> +
> > >> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> > >> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
> > >> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> > >> +
> > >> +			iommus = <&apps_smmu 0x0 0x0>;
> > >> +			dma-coherent;
> > >> +
> > >> +			resets = <&gcc GCC_SDCC1_BCR>;
> > >> +
> > >> +			no-sdio;
> > >> +			no-mmc;
> > >> +			bus-width = <4>;
> > > 
> > > This is the board configuration, it should be defined in the EVK DTS.
> > 
> > Unless the controller is actually incapable of doing non-SDCards
> > 
> > But from the limited information I can find, this one should be able
> > to do both
> > 
> 
> It’s doable, but the bus width differs when this controller is used for
> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
> only what’s needed for each specific usecase on the board.

`git grep no-sdio arch/arm64/boot/dts/qcom/` shows that we have those
properties inside the board DT. I don't see a reason to deviate.

-- 
With best wishes
Dmitry
