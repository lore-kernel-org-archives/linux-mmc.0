Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7454313524
	for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387808; cv=none; b=Fwx409YhIC0EPWV1qjZDH98t/QtWnK9uOcjZRiUClJI7TncYKbp21H28p1K36MgO1ocB5ub4cdRrssyFlyKZcfAqElH3L23wmmY/VRPW3JYYTQJ7QTWx+dTQjb9t8iQ9Pt/ic0ENNinvzxC4yolRildOTjgjRfapl/1V3hrktQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387808; c=relaxed/simple;
	bh=cv0ZxHdea5CKsewlRvW/nTV3U8O64mbsID3Dg6IGx0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwX0Fi6K7iV3ZMfVw8wwA/gSwkH1ZpS15+x9mt590SQZolpJmOzKmTPwZudvupWOxXBMLZscR3alR7IVMHeus1gYrzDuyRI5nHxv79ExClkccojpDqW5qZjQZhCacQsk/ZpbbySiwOfHmM2DLwfK4IB5Xhd0TRokYAEHRCnSxnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WdVPK2jG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WdVPK2jG"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S53WUV015919
	for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 13:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t1IRldKz0gQmhFQYU2bb3SAPuJJrpPeWPFtRHihBROo=; b=WdVPK2jGbR8S0q4p
	vNFhQDsCRbecVWA+fCnLIBrkBx+EWt2dqWkdCKJ+OgemYk4l0b0y8X+shn5sZFmB
	LHlBk3TXiGkfoaL9vZFkTT2UTdIkluEnODuBI6TbGwHEUK7dlqS7H+YRQBfWsdtI
	moblJdPF52D+fmAQ11reSz25Q6iOxf1Qn0+OrARUkOcelB+PYrc+KxtAg8Rqr6Tq
	X3AqiNm/FsP7G0EQlyDxvBsZhb6a2QgcNKA5Ls6xGeDb0uy65begVgG1H/ON8unt
	ow24+4Fpv4f5mjUZGsvwW4XCDcbh6KH4GpbvGhRg5DvwUFnUtjJ//UH7nPbjucrc
	P6ssXg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpf2mdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 13:30:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109be525eso21030941cf.2
        for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 06:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387804; x=1756992604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1IRldKz0gQmhFQYU2bb3SAPuJJrpPeWPFtRHihBROo=;
        b=qg4Oj4ImVSEQez0JXD1W6+xvRCWJQvCgoMJbiCCWLcP5Cc2BwzBTyWngvkUqwFdRuY
         QyUAue7Ds3PJe00BqGQTpnvZCDk2QKRXryjirByQE1Y7vzqrHVCR4SjBL9kkWM0ymQ7i
         ye99vNMu8yt621ThCMXmDqvWwlpEx9wTi5GXlCLMPrA/g9gwUZ33Q4/5vlU80taozTa6
         SY/tiWIgQ1aFlEQTXO0SulQ8gF1odCtVUWcyANfPG8oa8N7HgInU9d9FZ2z3Cvh0kK9e
         Vh3InX2HAHbzjgqhP+dlRdWgMbxqXxxbWHcjlgRfupnnjRlnaRcGWZZ5UrKZ1AqCgb8i
         gEFA==
X-Forwarded-Encrypted: i=1; AJvYcCVTdnTcBha0ugQmOWFLcEHybIi8RyzcbTXBHwfNk9PxEoNN7G7eyrdpwZg4HOmm8FBheDd/0/3RajA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZqFCFmS5sYD7IWS1R05CETmGJm8/ELnXelCBtUgXIC9KKCyiT
	1lFqUl2TOTo5A0p6S6Cssmv5XvhhCHWU+gsaFUsOP3NCbWqQNRNNSTS2TLOB2sUFI6LL+uk7YBC
	x3yq7ME6mlugW0eN4IWWJv5RKG3s5TUCiSj6mw988bwfwZIUk5ziwxdmXBWrrsdA=
X-Gm-Gg: ASbGncuxo7TNCJ58SVvgXaloYPWfzvhIRJJxRViWdvY5gbdBrioRRW/GHeybMQhkl6G
	Wf1EzZ1MIXuAaA2UdVXRPBQpd0IjYonqK74bjMLKDbP4kZ4OqXM79fTCQI2Jbv+ys+xDUOSKJGw
	D7avj646vv8vQ/IkKaIM+wTMLSla3lvJhhKGf4N+5eOYKR48DchC+vCMGeSUiKLdmzK69U01ejU
	4H2ASd6Pn9R9VGSw/F+o8R9GAEBMHMSdGPZPVpTjs3+z8iqPRk2MzQ81vQO/E4a+NWeXYsoWuhO
	jQ44ON30q3C2mQEsQj84l/m9hUydBnuFmFTMCY2134g/MvGeSp/+hu0Vy8GSJcW1chutuJHFNJR
	g8HjgQnNMyxSuA+L5glo2R04voBQoF3IFgo/XrdugzhQ/XY50O+7U
X-Received: by 2002:a05:622a:5b9a:b0:4b2:eed0:4a61 with SMTP id d75a77b69052e-4b2eed04cffmr82140721cf.71.1756387804434;
        Thu, 28 Aug 2025 06:30:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaOiP53QzP+S1t68Ggm4fjMOYi9fuzbFRp57u9VDUOAbeZXX2cOuJSczfNUU5F5LjJth2aNQ==
X-Received: by 2002:a05:622a:5b9a:b0:4b2:eed0:4a61 with SMTP id d75a77b69052e-4b2eed04cffmr82139901cf.71.1756387803743;
        Thu, 28 Aug 2025 06:30:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f489f09a8sm1977650e87.116.2025.08.28.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:30:01 -0700 (PDT)
Date: Thu, 28 Aug 2025 16:30:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
Cc: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Vishal Kumar Pal <quic_vispal@quicinc.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: lemans-evk: Extend peripheral and
 subsystem support
Message-ID: <zys26seraohh3gv2kl3eb3rd5pdo3y5vpfw6yxv6a7y55hpaux@myzhufokyorh>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
 <kycmxk3qag7uigoiitzcxcak22cewdv253fazgaidjcnzgzlkz@htrh22msxteq>
 <3f94ccc8-ac8a-4c62-8ac6-93dd603dcd36@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f94ccc8-ac8a-4c62-8ac6-93dd603dcd36@quicinc.com>
X-Proofpoint-GUID: P3WmQ8mBWsdZ9hnp_kculNwZ_MYf0tIL
X-Proofpoint-ORIG-GUID: P3WmQ8mBWsdZ9hnp_kculNwZ_MYf0tIL
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68b059dd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=bO8WyBFqmgISiikzXHoA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfXw8bJexaExer1
 TEm9+LxtbbC+CMyFzeLI46XJxDlKXhnTJiR2yaEyky7J1ubmGgGUFsvXOENumcNSne0E0Xoa3sd
 rh4MDIodZYuLdBlZlKs8xFoApZzHRiguizMF6Uopq/ppgQlBfomgyJ22DFl18yEndEf3irQubRc
 lvnxmNPBiXUgu0d1/XajkiDgRkOHIRezERG6aw3oekTfVgEdymeynw0hRN4tuOldINBYcRSZRQ2
 65W/X0vJRn9Dp8zvPIj+b8STgYR1relT9UmJ+zjSanpaBwNw0Uv1gqU+bcW7c5sY+8Ott/o73/z
 BGI3C/PnEU2lXHeJqmZ0Y60ndH2Ig3JD6kl6AWTi8A7d3UTjjBHYjcHeaWQcSYoDvLWtX3ojNvV
 W2JRkfoo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

On Thu, Aug 28, 2025 at 06:38:03PM +0530, Sushrut Shree Trivedi wrote:
> 
> On 8/27/2025 7:05 AM, Dmitry Baryshkov wrote:
> > On Tue, Aug 26, 2025 at 11:51:02PM +0530, Wasim Nazir wrote:
> > > Enhance the Qualcomm Lemans EVK board file to support essential
> > > peripherals and improve overall hardware capabilities, as
> > > outlined below:
> > >    - Enable GPI (Generic Peripheral Interface) DMA-0/1/2 and QUPv3-0/2
> > >      controllers to facilitate DMA and peripheral communication.
> > >    - Add support for PCIe-0/1, including required regulators and PHYs,
> > >      to enable high-speed external device connectivity.
> > >    - Integrate the TCA9534 I/O expander via I2C to provide 8 additional
> > >      GPIO lines for extended I/O functionality.
> > >    - Enable the USB0 controller in device mode to support USB peripheral
> > >      operations.
> > >    - Activate remoteproc subsystems for supported DSPs such as Audio DSP,
> > >      Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> > >      firmware.
> > >    - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
> > >      and other consumers.
> > >    - Enable the QCA8081 2.5G Ethernet PHY on port-0 and expose the
> > >      Ethernet MAC address via nvmem for network configuration.
> > >      It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
> > >    - Add support for the Iris video decoder, including the required
> > >      firmware, to enable video decoding capabilities.
> > >    - Enable SD-card slot on SDHC.
> > > 
> > > Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > Co-developed-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > Co-developed-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > Signed-off-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/lemans-evk.dts | 387 ++++++++++++++++++++++++++++++++
> > >   1 file changed, 387 insertions(+)
> > > 
> > 
> > > @@ -356,6 +720,29 @@ &ufs_mem_phy {
> > >   	status = "okay";
> > >   };
> > > +&usb_0 {
> > > +	status = "okay";
> > > +};
> > > +
> > > +&usb_0_dwc3 {
> > > +	dr_mode = "peripheral";
> > Is it actually peripheral-only?
> 
> Hi Dmitry,
> 
> HW supports OTG mode also, but for enabling OTG we need below mentioned
> driver changes in dwc3-qcom.c :

Is it the USB-C port? If so, then you should likely be using some form
of the Type-C port manager (in software or in hardware). These platforms
usually use pmic-glink in order to handle USB-C.

Or is it micro-USB-OTG port?

> 
> a) dwc3 core callback registration by dwc3 glue driver; this change is under
>     review in upstream.
> b) vbus supply enablement for host mode; this change is yet to be submitted
>     to upstream.
> 
> Post the above mentioned driver changes, we are planning to enable OTG on
> usb0.
> 
> - Sushrut
> 
> > > +};
> > > +

-- 
With best wishes
Dmitry
