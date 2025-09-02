Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D2248F66
	for <linux-mmc@vger.kernel.org>; Tue,  2 Sep 2025 02:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780476; cv=none; b=gKjqHD9Rx/Cw0mHfGdH6g8oV1YymPDHm3YGG5rXQD8GX6oGuq+EHjFCKtq9GXd+ReP35dvGM1d2Zmv2/rXYvKr+qDBJBZudtch7wK3VUIFa8cEfoyCAKxLjp7NdwmozKIit1Z02wd9NXefwGj4xDvG3AD2GsBNNLlt+regdMm/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780476; c=relaxed/simple;
	bh=da4uTNhiqePv0Xg9eLwNKjRKFjWWOOVrp+AzpZL2hy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKIgfC2LPOK7gAM6sM0Sw7IpwSN6nd30QGKMuhgw8LOzSkhIR17nftU2wplhplHTdvXqEEQlA9oR58k+wBhKi7DIqoDFwFmdX3dIEsmgA1FE9elM1yiho9Su6UvoZXgnbWq3DhmXpLUexgFysXvqFugSPvQxQ/jY4SOCyz0oi8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RhYX4Xu7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RhYX4Xu7"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S4nB030589
	for <linux-mmc@vger.kernel.org>; Tue, 2 Sep 2025 02:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vS0F+s8gHxST2GOfLmUKRNqUAeMPii9K1GmPXyJtBXE=; b=RhYX4Xu7SpXM/EDh
	E7fuhwt6QyQakbMwxU7oBL4DfKv+4MPu144oSL5xwRrI8BaDOYQWnNPK3M3Idr8W
	kwbeZ3tY0CETMTw5qaiPOwSVhOcLLJ7zTVbwTXVuq7QjuPpMZddlLH7Vrz85q7b2
	9uTZQ3LiC7zmkTslRB8C5FkAs2z9hvcsvDhsmzPGQ0PK6riLBOvQXA7W3A1egrJd
	IPfA65WzKG+O06hscRvDEYEh+xWnmoW8oCER1a4zwWdws20zLplr+wL4dcEI+1uK
	1hHqY27u8KrbaZaTr6t91AoM7pz3gocWwpuDgIFxQ5l7HdIvuvfDC4M5MQiY5af9
	zxpSPw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8p6ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 02 Sep 2025 02:34:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b340f94860so11961021cf.3
        for <linux-mmc@vger.kernel.org>; Mon, 01 Sep 2025 19:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756780472; x=1757385272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vS0F+s8gHxST2GOfLmUKRNqUAeMPii9K1GmPXyJtBXE=;
        b=kFC4qI8VowuVSr5+Hk+IKWDUIINxmuFTjkRrJAQPlpIWLhxfELE81heZQVbBEZi7HZ
         oY54yRnbR2CoRftEI95ShO2kiFrTg58UjnZ1YnV//eWQOBdtB/Rsxa3ZDoQ6Kk8INiNN
         bJV0EKj7azb+b4vAz5KlxqoYOAwPxw07C3+ppasSL9ilog4ayoQ/TKgl2Ixwf7+P8Zbh
         BW8jpvbJSVN0+3BTscJ7AVptzZcLVD9YLR+xu3hQRWVfyJnzqRUTUamfErzia0ecP0pb
         ktogxvnyv+8ISvlML2Q2Ox5cjCHBF202exAaTTgegd+LV5loJtMDcm8Rpb7v6mDSwvw1
         n55Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBZjnMgF/R/RMRpW4It6dFx3HUYwOHG48wUk1rhZv6aueG6CYh+vcWuM3m/GvrTmx1zLEeCT4Wnjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgxlO+qhO0IxZLC8lYyfkjXmQMM/jdj74+2XshBgI0TGNv77AB
	jljsg2Fv0cusebq7rm+h9zL6mlKIwG96y3b3xvwglokmkgDZJJzmO6hhh+WKWSu5rhbUei6M9Ea
	BvZsapxd2q8QIJht9Ij3VyGUwIsXa93A0IpXq2cuYyzFg8svXU7NOJhnJrK2OWqin2SiLXLk=
X-Gm-Gg: ASbGncumB94elZdUUlpUQ2QPYmuxf1WG2QlF5625Q4qaEu4ro36CuRbDKoKKP6/9mw8
	YJXvOFi76KTzOlanHw2elOy9Dtra8MePhlJ7MmfxZ9QH/4u57TGq8Vng02xAfH19uZ7m1/2CCYl
	VS7bV6hBoAs4d7EN+QG76l6YOy+ZY+bEJ5vC0IGabeDfbnnrKWeL9upQOsJniH3YwbFG6iYMmE9
	Nk/FqtG5+hb/58zaUCwFmWvgXLFhHHa1kYb3ZDSs8pgF/frRvQRe+Gk1zsDSqwUWAq1+iZZo5SH
	Ga41KnEzhuMfua3mv5n+OUb5TEoHBU+joPCEIvjLHYhzocYhXH1FrcWS4sS6nyowrPAmjjyu670
	U8xI6X3ge4GK0gxPgC4ZPjK9UYCU8QfXB2msJt28Om42oeUiUqERY
X-Received: by 2002:a05:622a:230c:b0:4b3:1847:4192 with SMTP id d75a77b69052e-4b31dd2f96fmr131936931cf.69.1756780471857;
        Mon, 01 Sep 2025 19:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzqodcfWhpK6qJYUt42vLlLnCY1b1EAphCtxu0+mddayjBUMwightL8KwYc5BxzP8zvbba9w==
X-Received: by 2002:a05:622a:230c:b0:4b3:1847:4192 with SMTP id d75a77b69052e-4b31dd2f96fmr131936501cf.69.1756780471342;
        Mon, 01 Sep 2025 19:34:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560827a0218sm281176e87.117.2025.09.01.19.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 19:34:30 -0700 (PDT)
Date: Tue, 2 Sep 2025 05:34:27 +0300
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
Message-ID: <ly5j2eodrajifosz34nokia4zckfftakz5253d2h6kd2cxjoq3@yrquqgpnvhp6>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
 <kycmxk3qag7uigoiitzcxcak22cewdv253fazgaidjcnzgzlkz@htrh22msxteq>
 <3f94ccc8-ac8a-4c62-8ac6-93dd603dcd36@quicinc.com>
 <zys26seraohh3gv2kl3eb3rd5pdo3y5vpfw6yxv6a7y55hpaux@myzhufokyorh>
 <aLG3SbD1JNULED20@hu-mchunara-hyd.qualcomm.com>
 <ozkebjk6gfgnootoyqklu5tqj7a7lgrm34xbag7yhdwn5xfpcj@zpwr6leefs3l>
 <ed3a79e0-516e-42f4-b3c6-a78ca6c01d86@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed3a79e0-516e-42f4-b3c6-a78ca6c01d86@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: jSGuPNsuffpCtj6tIhcsCvOSSd2ul5kl
X-Proofpoint-GUID: jSGuPNsuffpCtj6tIhcsCvOSSd2ul5kl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX6VPZzD3lq+6p
 FUdp+T8BcyR3TAh8YpdGxY80+Q+rHs/EVVORx3K36m9uVlgB9HC1JbzVIwoecURh/Q2Eb+sOP0S
 E/Yn6AWVHXINenxoRBxVDhNVreg0wRhGHN0dNjpEFCRgrNNIFc26+fAnMFrSt84bcPxU+uQeO9J
 YNAsrBlA3Hll80i7DqcNEsW+smJVEhuBiei2WcO3uO8fHbEGg00AfcLKEs3YcekYyakmo1g5NiF
 v8vgs6h+sDnUOsIatBvZTeCZsPTpRlgACUbAHYNfH7kvOiyQARlGmPRn1ynb7R1pOyUt9h9MxXI
 ocyBHanXIsrjxF+jXpigTCcjEpSjIBz3tBON3Uccc4WNB2lG5oTlkVCyA8kBNYBLZAtYc0I4Snr
 xybPdrZr
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b657b9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=FAQitTM21wLSu42_UfgA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On Mon, Sep 01, 2025 at 01:02:15PM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 8/29/2025 9:54 PM, Dmitry Baryshkov wrote:
> > On Fri, Aug 29, 2025 at 07:50:57PM +0530, Monish Chunara wrote:
> > > On Thu, Aug 28, 2025 at 04:30:00PM +0300, Dmitry Baryshkov wrote:
> > > > On Thu, Aug 28, 2025 at 06:38:03PM +0530, Sushrut Shree Trivedi wrote:
> > > > > 
> > > > > On 8/27/2025 7:05 AM, Dmitry Baryshkov wrote:
> > > > > > On Tue, Aug 26, 2025 at 11:51:02PM +0530, Wasim Nazir wrote:
> > > > > > > Enhance the Qualcomm Lemans EVK board file to support essential
> > > > > > > peripherals and improve overall hardware capabilities, as
> > > > > > > outlined below:
> > > > > > >     - Enable GPI (Generic Peripheral Interface) DMA-0/1/2 and QUPv3-0/2
> > > > > > >       controllers to facilitate DMA and peripheral communication.
> > > > > > >     - Add support for PCIe-0/1, including required regulators and PHYs,
> > > > > > >       to enable high-speed external device connectivity.
> > > > > > >     - Integrate the TCA9534 I/O expander via I2C to provide 8 additional
> > > > > > >       GPIO lines for extended I/O functionality.
> > > > > > >     - Enable the USB0 controller in device mode to support USB peripheral
> > > > > > >       operations.
> > > > > > >     - Activate remoteproc subsystems for supported DSPs such as Audio DSP,
> > > > > > >       Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> > > > > > >       firmware.
> > > > > > >     - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
> > > > > > >       and other consumers.
> > > > > > >     - Enable the QCA8081 2.5G Ethernet PHY on port-0 and expose the
> > > > > > >       Ethernet MAC address via nvmem for network configuration.
> > > > > > >       It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
> > > > > > >     - Add support for the Iris video decoder, including the required
> > > > > > >       firmware, to enable video decoding capabilities.
> > > > > > >     - Enable SD-card slot on SDHC.
> > > > > > > 
> > > > > > > Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > > > > > Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > > > > > Co-developed-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > > > > > Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > > > > > Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > > > > > Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > > > > > Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > > > > > Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > > > > > Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > > > > > Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > > > > > Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > > > > > Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > > > > > Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > > > > > Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > > > > > Co-developed-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > > > > > Signed-off-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > > > > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > > > > > ---
> > > > > > >    arch/arm64/boot/dts/qcom/lemans-evk.dts | 387 ++++++++++++++++++++++++++++++++
> > > > > > >    1 file changed, 387 insertions(+)
> > > > > > > 
> > > > > > 
> > > > > > > @@ -356,6 +720,29 @@ &ufs_mem_phy {
> > > > > > >    	status = "okay";
> > > > > > >    };
> > > > > > > +&usb_0 {
> > > > > > > +	status = "okay";
> > > > > > > +};
> > > > > > > +
> > > > > > > +&usb_0_dwc3 {
> > > > > > > +	dr_mode = "peripheral";
> > > > > > Is it actually peripheral-only?
> > > > > 
> > > > > Hi Dmitry,
> > > > > 
> > > > > HW supports OTG mode also, but for enabling OTG we need below mentioned
> > > > > driver changes in dwc3-qcom.c :
> > > > 
> > > > Is it the USB-C port? If so, then you should likely be using some form
> > > > of the Type-C port manager (in software or in hardware). These platforms
> > > > usually use pmic-glink in order to handle USB-C.
> > > > 
> > > > Or is it micro-USB-OTG port?
> > > > 
> > > 
> > > Yes, it is a USB Type-C port for usb0 and we are using a 3rd party Type-C port
> > > controller for the same. Will be enabling relevant dts node as part of OTG
> > > enablement once driver changes are in place.
> > 
> > Which controller are you using? In the existing designs USB-C works
> > without extra patches for the DWC3 controller.
> > 
> 
> Hi Dmitry,
> 
>  On EVK Platform, the VBUS is controlled by a GPIO from expander. Unlike in
> other platforms like SA8295 ADP, QCS8300 Ride, instead of keeping vbus
> always on for dr_mode as host mode, we wanted to implement vbus control in
> dwc3-qcom.c based on top of [1]. In this patch, there is set_role callback
> present to turn off/on the vbus. So after this patch is merged, we wanted to
> implement vbus control and then flatten DT node and then add vbus supply to
> glue node. Hence made peripheral only dr_mode now.

In such a case VBUS should be controlled by the USB-C controller rather
than DWC3. The reason is pretty simple: the power direction and data
direction are not 1:1 related anymore. The Type-C port manager decides
whether to supply power over USB-C / Vbus or not and (if supported)
which voltage to use. See TCPM's tcpc_dev::set_vbus().

> 
> [1]: https://lore.kernel.org/all/20250812055542.1588528-3-krishna.kurapati@oss.qualcomm.com/
> 
> Regards,
> Krishna,
> 
> > > 
> > > > > 
> > > > > a) dwc3 core callback registration by dwc3 glue driver; this change is under
> > > > >      review in upstream.
> > > > > b) vbus supply enablement for host mode; this change is yet to be submitted
> > > > >      to upstream.
> > > > > 
> > > > > Post the above mentioned driver changes, we are planning to enable OTG on
> > > > > usb0.
> > 
> 

-- 
With best wishes
Dmitry
