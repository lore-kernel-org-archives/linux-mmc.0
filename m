Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6863322C9B
	for <linux-mmc@vger.kernel.org>; Fri, 29 Aug 2025 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484681; cv=none; b=vEgdcKRAFotbom37JdCALpEdIg+Z/sLIGxBjI8Ohw6uqg5eAy3ruyyZCaQS1r609rSAsDxE1f5C82Aw9K/KEXIM27pOaO5+vCEggNIj29Cxa7fgXfycmrR0A10eiOn4q7L8ot/Qgcvf2V24UybZSTeSBUtMaOASWVdKs5SRJOuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484681; c=relaxed/simple;
	bh=3B97zBH4p9jRcLgMlEAc2P4fRn926Py9yl1OWBr7GvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/0y9zaKGj9d+OyfNBFg/OokR9S4ECQwGTl1sXKhTabxcNt5PYh7s0npOt5i4f0QS59gjKITouR/ekSwezmur2SBW9VPykIFK/w0TdzBhAS50t+Wd82jnuiMY5Fk+MS3xPqNxhoXZYYqzeJjnpBaeAsVuSjuF0Q+Hw9ZVt7rYpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vx1+Nkfe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vx1+Nkfe"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T85ETo018639
	for <linux-mmc@vger.kernel.org>; Fri, 29 Aug 2025 16:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XCIfjiGc29TyHYiTm4KLiwCktBOr1c2fqrZ/oTTcfZo=; b=Vx1+NkfegDhBk6Bf
	fz9QkSj4uQXedF2HcUipcq/YN/IeXx+DvrakGMN4PA8SIbyDMeF/EFY8+SGlJhCM
	hWQuULnOEPwdLEE9OI3kN3J9ENLVFPsOSQGeArClQUEq5AT2HDzNZZXN7cXGDlL2
	XEMstV+DzQaqKeu5+yvsyikbFjzUAsBHRJXkxz/H0qyhjmQUeNxQ4OMXTUVTOAFb
	hw2ZCWfBXFpoFE987qMsXv8Y4aL1WzcICnFpLL76rNO4YL2wqNF+jM2zBcUZCD1y
	MoKNK2FFxccJCt1R8PkBP7U6X615kh7h6V8HaaawsANhi73UCyGASKypSnlclA95
	rWCH/Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tn67mkew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 Aug 2025 16:24:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b0faa8d615so84620581cf.1
        for <linux-mmc@vger.kernel.org>; Fri, 29 Aug 2025 09:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756484677; x=1757089477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCIfjiGc29TyHYiTm4KLiwCktBOr1c2fqrZ/oTTcfZo=;
        b=PCweVuBcizTrIlb+Kus/NCFVQa0fNJgGC2LO23NyTFBdQ9d2E/AokznLhRb5sOS6cG
         Cljmndbr8srUUCoVNaczh+zEF+0UEcFQQWsCcuptOLTf2kr7NZDEOOXTA4kVRWaRgBUe
         hKhiuyEhZCOUqYrPyGiF9burarnN3tm2mmSnGdiIYdGhSbMq5jbTzjFWM1SWz6ru2/2+
         ur5fVU4wN1Cinxenm/cvkqN2e5tR448LXy+I3Mx3ons2VrQl0mXF8SWRPvstaOJrTXUb
         ele3h7aHBTsrUoOE+36E6XX5aRQ5VBc3p4hyKBNOffn3C6t0H1nJ0/E32xyPMyXZJW1H
         YbEg==
X-Forwarded-Encrypted: i=1; AJvYcCUL85kYheOw4u5u6R6bXGctzcVxNBuRFmMDGeVMflYntOR+tv5mkgpAkqtPT1uXO7JeVxJRJegeLbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaenQl9KZwTXiKoIgRfE/A18TTJMTbrE6i89hIQmJkLZI5vr67
	Smk8A96+SgXAoyZLhbl63E/+fYlc8aorSLV0iEx1Q3fTaTgu8QOy0d0WLLuCFYRDcdjNg/hNZ0m
	CedOWKXevkn3KIbLpzgaQxswKbCdS88r34Vd+BHliUNCJIiIC+FzVOkENj1442X0=
X-Gm-Gg: ASbGncuQItUszX+m1hizwVsqIh4sc0CH36w5mGvPZDHtl6jShzg+ca0AiiZVwL+NZ8z
	gBJiL5LOYHf5iDv4NzuzL+RDXAeRdV2OVa5cw0gsrd9s7aGUEWJ11pLO08hfsBaUQ43I4jReaYJ
	aEVrtzP5nLfgdKxuHXYyiiiaXsYsXU/NGIy8Gok+m2S7OU+4+sDs+CC+EPx7SlpoJD9LkJVQAT0
	GXxfvZ9fGNiN26X8g7P2KxmA9TBmVs6iPPCrrlY1civvlQzAZHwhzBuGvYFDW8YPoxrprBT0yFQ
	j5cfSAzw9bdKV4NXPa7FEpuk9T9sl3Kyyy5N77MQcWokqIi/4cT5n2ae85+UhCv9RsZH7WsaoBJ
	amByTqvlcA/VeJkxwAjyXv0loPbkkEUGGp7ZHhfSu+A3wfPy7Nk9I
X-Received: by 2002:a05:622a:2c1:b0:4af:bfd:82bf with SMTP id d75a77b69052e-4b2e76f6c2fmr159959931cf.17.1756484676358;
        Fri, 29 Aug 2025 09:24:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3avH1Zre9WfCU8qCI5LcLOBiCx7PfjvDuQh+HklBIJkQz+ZtJjjyCJREb1zAER0kzRP6i/A==
X-Received: by 2002:a05:622a:2c1:b0:4af:bfd:82bf with SMTP id d75a77b69052e-4b2e76f6c2fmr159959551cf.17.1756484675754;
        Fri, 29 Aug 2025 09:24:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f678450dfsm713370e87.72.2025.08.29.09.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 09:24:34 -0700 (PDT)
Date: Fri, 29 Aug 2025 19:24:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Monish Chunara <quic_mchunara@quicinc.com>
Cc: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
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
        Vishal Kumar Pal <quic_vispal@quicinc.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: lemans-evk: Extend peripheral and
 subsystem support
Message-ID: <ozkebjk6gfgnootoyqklu5tqj7a7lgrm34xbag7yhdwn5xfpcj@zpwr6leefs3l>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
 <kycmxk3qag7uigoiitzcxcak22cewdv253fazgaidjcnzgzlkz@htrh22msxteq>
 <3f94ccc8-ac8a-4c62-8ac6-93dd603dcd36@quicinc.com>
 <zys26seraohh3gv2kl3eb3rd5pdo3y5vpfw6yxv6a7y55hpaux@myzhufokyorh>
 <aLG3SbD1JNULED20@hu-mchunara-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLG3SbD1JNULED20@hu-mchunara-hyd.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NSBTYWx0ZWRfX43b5vd4R1b83
 waWiaVMGm6QH91rhsVyTqZbLd9X1monkOvPpGyMmzTmKHkgiMzMbqeVh1mDOUcDafS5Wnq1QB6/
 iOPC0JhOniC71waEP6H8dElgeCbiPOQN6vUxLPw1hvnW3qHngv/BZZ/ybQLpP/MzK0ChJc132Kv
 hf7P0jqqFU2MYwmeLr+AB6d4mFvzSamfRsVxe4x7bJK87gEFEeNEvUYxXPasFBfSqUc3aXF9QDS
 rIAHvvwAq5WVnpAgvH9J5OijCjXEn0zT9SbDNwbhazUJ5c+SZWKmuIPZcErznZzFl/UcoYcj3HZ
 niIvOwSffNfJU8/racvXWKCL6qNYzwIFfCSGPnpCFfRfAXuTm/OJ7KIgaFxZJ6KX05BZwKtkNUW
 PFfyGuw6
X-Proofpoint-GUID: RWp3u8YKDQLuKZT1cWSb7BS1-srrZR7e
X-Proofpoint-ORIG-GUID: RWp3u8YKDQLuKZT1cWSb7BS1-srrZR7e
X-Authority-Analysis: v=2.4 cv=P7c6hjAu c=1 sm=1 tr=0 ts=68b1d446 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=YDAz1v9_iDTVm1Y559YA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508280085

On Fri, Aug 29, 2025 at 07:50:57PM +0530, Monish Chunara wrote:
> On Thu, Aug 28, 2025 at 04:30:00PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Aug 28, 2025 at 06:38:03PM +0530, Sushrut Shree Trivedi wrote:
> > > 
> > > On 8/27/2025 7:05 AM, Dmitry Baryshkov wrote:
> > > > On Tue, Aug 26, 2025 at 11:51:02PM +0530, Wasim Nazir wrote:
> > > > > Enhance the Qualcomm Lemans EVK board file to support essential
> > > > > peripherals and improve overall hardware capabilities, as
> > > > > outlined below:
> > > > >    - Enable GPI (Generic Peripheral Interface) DMA-0/1/2 and QUPv3-0/2
> > > > >      controllers to facilitate DMA and peripheral communication.
> > > > >    - Add support for PCIe-0/1, including required regulators and PHYs,
> > > > >      to enable high-speed external device connectivity.
> > > > >    - Integrate the TCA9534 I/O expander via I2C to provide 8 additional
> > > > >      GPIO lines for extended I/O functionality.
> > > > >    - Enable the USB0 controller in device mode to support USB peripheral
> > > > >      operations.
> > > > >    - Activate remoteproc subsystems for supported DSPs such as Audio DSP,
> > > > >      Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> > > > >      firmware.
> > > > >    - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
> > > > >      and other consumers.
> > > > >    - Enable the QCA8081 2.5G Ethernet PHY on port-0 and expose the
> > > > >      Ethernet MAC address via nvmem for network configuration.
> > > > >      It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
> > > > >    - Add support for the Iris video decoder, including the required
> > > > >      firmware, to enable video decoding capabilities.
> > > > >    - Enable SD-card slot on SDHC.
> > > > > 
> > > > > Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > > > Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > > > Co-developed-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > > > Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > > > Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > > > Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > > > Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > > > Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > > > Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > > > Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > > > Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > > > Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > > > Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > > > Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > > > Co-developed-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > > > Signed-off-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > > > ---
> > > > >   arch/arm64/boot/dts/qcom/lemans-evk.dts | 387 ++++++++++++++++++++++++++++++++
> > > > >   1 file changed, 387 insertions(+)
> > > > > 
> > > > 
> > > > > @@ -356,6 +720,29 @@ &ufs_mem_phy {
> > > > >   	status = "okay";
> > > > >   };
> > > > > +&usb_0 {
> > > > > +	status = "okay";
> > > > > +};
> > > > > +
> > > > > +&usb_0_dwc3 {
> > > > > +	dr_mode = "peripheral";
> > > > Is it actually peripheral-only?
> > > 
> > > Hi Dmitry,
> > > 
> > > HW supports OTG mode also, but for enabling OTG we need below mentioned
> > > driver changes in dwc3-qcom.c :
> > 
> > Is it the USB-C port? If so, then you should likely be using some form
> > of the Type-C port manager (in software or in hardware). These platforms
> > usually use pmic-glink in order to handle USB-C.
> > 
> > Or is it micro-USB-OTG port?
> > 
> 
> Yes, it is a USB Type-C port for usb0 and we are using a 3rd party Type-C port
> controller for the same. Will be enabling relevant dts node as part of OTG
> enablement once driver changes are in place.

Which controller are you using? In the existing designs USB-C works
without extra patches for the DWC3 controller.

> 
> > > 
> > > a) dwc3 core callback registration by dwc3 glue driver; this change is under
> > >     review in upstream.
> > > b) vbus supply enablement for host mode; this change is yet to be submitted
> > >     to upstream.
> > > 
> > > Post the above mentioned driver changes, we are planning to enable OTG on
> > > usb0.

-- 
With best wishes
Dmitry
