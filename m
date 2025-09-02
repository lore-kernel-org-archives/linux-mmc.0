Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11481547EE
	for <linux-mmc@vger.kernel.org>; Tue,  2 Sep 2025 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833372; cv=none; b=cyQXHphcY3u8kX9YTWdNo7gUEneckbEcoqTwFqx8GGkyEXu5yPMp2wr+/ERL5dcTrjYJDlQtjU81khw/xfzQt2MxJfHCARwOFJ6lXI18o6t/pg+2FnL31IQcgrrNjlCR2gnRdWcCOrqHXHiBLxIJ4Nlg15Ksa6GynEPax1Ir1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833372; c=relaxed/simple;
	bh=GGixmQHMnuiRSS06dnefK9PTyJsBbkjIHfLjT8VKwlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyecmmNdRnYLHyUQf/PwAPCXlVLt4vSSH6ThBrf7hfnKcJjjHWtym7w67afiPcm9wV+S2EVGAQ9o/k/Gn+fvGoXesuVr/ravr+1k2qrQshpRR6yzGnxycp3gNjIywiIQjNXdnRsMZbey1smUQEAe4tkWScO//S10luuZ1bQhtPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P2Ufg2iT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P2Ufg2iT"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqAu4018243
	for <linux-mmc@vger.kernel.org>; Tue, 2 Sep 2025 17:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3YLUXsBb+H2fMN/x6xB9KreQ
	sLQVf3Bz8PIfMA43Cqs=; b=P2Ufg2iTd5xoqKvZgqUNWwwNog0r3wJv3SJ2a0/3
	rcX2pW9xuf5I8vFAOdMTE8gRP2zn1KI5KW4IXo8yg1sXJHdHPmHUoDoLtTDhs5Is
	bsTufpY0YUItHxmYiElD+6IP+VYLjqKLIQNFK+sXghAwUP82iFKpMXIO4hadr/dY
	FyvOAYfGplOytGn4F3Cf+yDc7Dm56udzaU0eTGLuJ4g5mCBKbqkK2l3DDWPt1OVf
	a5L9DKpX76jrIA3L+8HgGQuFotoyxrRo+lNF6f2TglXr4bef9qhrkVkTdtQ3nDGo
	QlsySFGVNG3O99OfRSbORBb7ouZxi0EM2hFYRxEYu4rpXw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48wqvwadmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 02 Sep 2025 17:16:09 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70dfcc58976so87111996d6.2
        for <linux-mmc@vger.kernel.org>; Tue, 02 Sep 2025 10:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833368; x=1757438168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YLUXsBb+H2fMN/x6xB9KreQsLQVf3Bz8PIfMA43Cqs=;
        b=wuEqHHqL5Uncy8F8ySZkY2E4UE0Mz9+rlIc6q71ptP3VSim11dsJTUcbOesTGVfAMw
         gpJwrsogrwUuVshEvaoMXCORUVifMX8v7Y3ak7tNVREqceOZ0EB/eoOM/ZaHiTs9nMnF
         AdhyczUeyHMhgorD1+6SJqov5O8TGc+33G/KxdPBJkS8SDSaeClz0SdCUwsNpggbUDOr
         c/QX7H4s5PWNSxoylpctkKPRJfuFwanOOUiIus8ywUv6TD09K16UNbEKYx1AqXRXzOHo
         HNHZu3TNEESU09pMV/OtWogIVulnGkWecjuKiE9xfEKodCz8hy712k8D6Hye04SDPvkC
         yf6A==
X-Forwarded-Encrypted: i=1; AJvYcCWYiSQV8+vJa5cguIHu/O/dNeeP10dBv9CERkeGz9SelRLqMqcuSZMgY89ZPTJh0Gqn3+lmFRmFAVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCV1GisL+CNOg8p5ObNfphXVOCig82bI8hj683qGVJONAM1Mbp
	2omOjtiSMG4k0ukR3lenV9Mrh7e1JtoFpjLTCvoQL6K0IlYqkHtgm9WYi8fB3aeMpuaQtUAfHNH
	qWteSKmufT2+Uuuvo0fzIgcawrz5xqQ1/1lB2h8joSrlMZZ3KycTfWc8teoVAiCk=
X-Gm-Gg: ASbGncvIOK4NqQIOkH64+6g188Ls7+Ygdy9910/K3lgzjgd239DMAvi3quYJDvy0+g+
	f1pEFQ5SyK49yGqfkag32hyS3PvCF0+bxET+eUzAUoV6I/qU8PNl/txZCjF4XwOobztnFC1JeHe
	ZUhyZH4mZBXKrdmuiB9mg4zyMDUHfh/IQpYBlMRclXLDS1m1g0NA43Mm37ez+S9c1kXjLpxLmCG
	0dJoxPB5zHytAJ/fz0GAoFPibf5PEsrNnoqoLHb/pYdG/e5y1rWuDkc9UFQFdz5+qIMFR+qU2XX
	t6PyHsLeWPUXlSwXPCgkjVHHiuz1yRLLQqo0AxygPZQ/djMKTwYaMp1GRngSE3v5YKuKueLkfdQ
	AFZ9j6fEUzYNi6pbhu749WI6zAvf6SdyWMS1ZFnIeuFctV8Z1pnoA
X-Received: by 2002:a05:622a:2615:b0:4b3:19c5:68ec with SMTP id d75a77b69052e-4b31d80cb69mr138409441cf.12.1756833368110;
        Tue, 02 Sep 2025 10:16:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5rotFg1jBTAZEAuapDecKRJQB2mz3OMz0pGfo5EL0QAG3I96gAKcj9HSKzh0OrRoUDRSojw==
X-Received: by 2002:a05:622a:2615:b0:4b3:19c5:68ec with SMTP id d75a77b69052e-4b31d80cb69mr138408861cf.12.1756833367575;
        Tue, 02 Sep 2025 10:16:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560827aa987sm810618e87.135.2025.09.02.10.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 10:16:06 -0700 (PDT)
Date: Tue, 2 Sep 2025 20:16:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
Cc: Monish Chunara <quic_mchunara@quicinc.com>,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
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
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Vishal Kumar Pal <quic_vispal@quicinc.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: lemans-evk: Extend peripheral and
 subsystem support
Message-ID: <ctwvrrkomc3n6gginw2dp5vip7xh5jhwbi5joyr64gocsm2esb@4zfpbvvziv5i>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
 <kycmxk3qag7uigoiitzcxcak22cewdv253fazgaidjcnzgzlkz@htrh22msxteq>
 <3f94ccc8-ac8a-4c62-8ac6-93dd603dcd36@quicinc.com>
 <zys26seraohh3gv2kl3eb3rd5pdo3y5vpfw6yxv6a7y55hpaux@myzhufokyorh>
 <aLG3SbD1JNULED20@hu-mchunara-hyd.qualcomm.com>
 <ozkebjk6gfgnootoyqklu5tqj7a7lgrm34xbag7yhdwn5xfpcj@zpwr6leefs3l>
 <ed3a79e0-516e-42f4-b3c6-a78ca6c01d86@oss.qualcomm.com>
 <ly5j2eodrajifosz34nokia4zckfftakz5253d2h6kd2cxjoq3@yrquqgpnvhp6>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ly5j2eodrajifosz34nokia4zckfftakz5253d2h6kd2cxjoq3@yrquqgpnvhp6>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDAyNCBTYWx0ZWRfX0Nrb820TTGyz
 ux8yv99ZC1a0TDP/u0BHBpL/RK/68xkPu3FkzqyMwqbdnycaI4OilQ3gpTkPmCyhwHzyvV9jJxm
 mAAf64pSq9JnBcn4h0H4mxZ3jFglnABjoIhcYtWi/myVw82SDfbXRXDWzTaesUL/fB4BPO8zscj
 csQ9Jr1c9T8jybKsoQoJUMsvU1BwfF0NFgJIT+pWZiI4fiX4LRGys6W+r0E/EjbrU7h8YevIpwJ
 OiLsDNeBoKx4PaHOh9DhbPckEQY8j/VbWKVbilySy/4DIXcrJgGTEBeYdJYUckt7eXVDgxiXb4D
 k4Y11XJFY1t3IQtG4pHvqg27xPGF/v5ogTPGVWpYx8Upw1+5Ia2PZxC5QWTkkbQAWxkXJgoD89b
 f20rSG0L
X-Authority-Analysis: v=2.4 cv=WKh/XmsR c=1 sm=1 tr=0 ts=68b72659 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=-eXanXclA7daHIafeBEA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: G7ovpMvfACtfj8soZvVLwbnB9oafx--o
X-Proofpoint-ORIG-GUID: G7ovpMvfACtfj8soZvVLwbnB9oafx--o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020024

On Tue, Sep 02, 2025 at 05:34:27AM +0300, Dmitry Baryshkov wrote:
> On Mon, Sep 01, 2025 at 01:02:15PM +0530, Krishna Kurapati PSSNV wrote:
> > 
> > 
> > On 8/29/2025 9:54 PM, Dmitry Baryshkov wrote:
> > > On Fri, Aug 29, 2025 at 07:50:57PM +0530, Monish Chunara wrote:
> > > > On Thu, Aug 28, 2025 at 04:30:00PM +0300, Dmitry Baryshkov wrote:
> > > > > On Thu, Aug 28, 2025 at 06:38:03PM +0530, Sushrut Shree Trivedi wrote:
> > > > > > 
> > > > > > On 8/27/2025 7:05 AM, Dmitry Baryshkov wrote:
> > > > > > > On Tue, Aug 26, 2025 at 11:51:02PM +0530, Wasim Nazir wrote:
> > > > > > > > Enhance the Qualcomm Lemans EVK board file to support essential
> > > > > > > > peripherals and improve overall hardware capabilities, as
> > > > > > > > outlined below:
> > > > > > > >     - Enable GPI (Generic Peripheral Interface) DMA-0/1/2 and QUPv3-0/2
> > > > > > > >       controllers to facilitate DMA and peripheral communication.
> > > > > > > >     - Add support for PCIe-0/1, including required regulators and PHYs,
> > > > > > > >       to enable high-speed external device connectivity.
> > > > > > > >     - Integrate the TCA9534 I/O expander via I2C to provide 8 additional
> > > > > > > >       GPIO lines for extended I/O functionality.
> > > > > > > >     - Enable the USB0 controller in device mode to support USB peripheral
> > > > > > > >       operations.
> > > > > > > >     - Activate remoteproc subsystems for supported DSPs such as Audio DSP,
> > > > > > > >       Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> > > > > > > >       firmware.
> > > > > > > >     - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
> > > > > > > >       and other consumers.
> > > > > > > >     - Enable the QCA8081 2.5G Ethernet PHY on port-0 and expose the
> > > > > > > >       Ethernet MAC address via nvmem for network configuration.
> > > > > > > >       It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
> > > > > > > >     - Add support for the Iris video decoder, including the required
> > > > > > > >       firmware, to enable video decoding capabilities.
> > > > > > > >     - Enable SD-card slot on SDHC.
> > > > > > > > 
> > > > > > > > Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > > > > > > Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > > > > > > Co-developed-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > > > > > > Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > > > > > > Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > > > > > > Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > > > > > > Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > > > > > > Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > > > > > > Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > > > > > > Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > > > > > > Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > > > > > > Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > > > > > > Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > > > > > > Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > > > > > > Co-developed-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > > > > > > Signed-off-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > > > > > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > > > > > > ---
> > > > > > > >    arch/arm64/boot/dts/qcom/lemans-evk.dts | 387 ++++++++++++++++++++++++++++++++
> > > > > > > >    1 file changed, 387 insertions(+)
> > > > > > > > 
> > > > > > > 
> > > > > > > > @@ -356,6 +720,29 @@ &ufs_mem_phy {
> > > > > > > >    	status = "okay";
> > > > > > > >    };
> > > > > > > > +&usb_0 {
> > > > > > > > +	status = "okay";
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +&usb_0_dwc3 {
> > > > > > > > +	dr_mode = "peripheral";
> > > > > > > Is it actually peripheral-only?
> > > > > > 
> > > > > > Hi Dmitry,
> > > > > > 
> > > > > > HW supports OTG mode also, but for enabling OTG we need below mentioned
> > > > > > driver changes in dwc3-qcom.c :
> > > > > 
> > > > > Is it the USB-C port? If so, then you should likely be using some form
> > > > > of the Type-C port manager (in software or in hardware). These platforms
> > > > > usually use pmic-glink in order to handle USB-C.
> > > > > 
> > > > > Or is it micro-USB-OTG port?
> > > > > 
> > > > 
> > > > Yes, it is a USB Type-C port for usb0 and we are using a 3rd party Type-C port
> > > > controller for the same. Will be enabling relevant dts node as part of OTG
> > > > enablement once driver changes are in place.
> > > 
> > > Which controller are you using? In the existing designs USB-C works
> > > without extra patches for the DWC3 controller.
> > > 
> > 
> > Hi Dmitry,
> > 
> >  On EVK Platform, the VBUS is controlled by a GPIO from expander. Unlike in
> > other platforms like SA8295 ADP, QCS8300 Ride, instead of keeping vbus
> > always on for dr_mode as host mode, we wanted to implement vbus control in
> > dwc3-qcom.c based on top of [1]. In this patch, there is set_role callback
> > present to turn off/on the vbus. So after this patch is merged, we wanted to
> > implement vbus control and then flatten DT node and then add vbus supply to
> > glue node. Hence made peripheral only dr_mode now.
> 
> In such a case VBUS should be controlled by the USB-C controller rather
> than DWC3. The reason is pretty simple: the power direction and data
> direction are not 1:1 related anymore. The Type-C port manager decides
> whether to supply power over USB-C / Vbus or not and (if supported)
> which voltage to use. See TCPM's tcpc_dev::set_vbus().

Okay, your Type-C manager is HD3SS3220. It drives ID pin low if the VBUS
supply should be enabled. Please enhance the driver with this
functionality. You cann't use the USB role status since it doesn't
perform VSafe0V checks.

-- 
With best wishes
Dmitry
