Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706829B777
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758005846; cv=none; b=MhmYwbzvNRX9sxhjEoQSXkSpyfSsG3f4otHj25sg9+/UiMynY3/yrpk86eGyhWyoo8gCbLynIb2Xm94SHuzEYxCv1rDJprgwHuyhOZ2PAJmp9ZmNW1wbsGAlPlvyUdqOt/TMNmD7GOTnawqPugQyBIUXrsiPUX9lN/7VsEIbLDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758005846; c=relaxed/simple;
	bh=VJqgGR+I8yQ3u1riqJusgJNxUJc7JbGh1X7CuNzrMz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/uw3ECCzceso07R+7pxZz67jLb3uDv40HM3dyjAVidS7uT6HFLQMk5N5CAeqLJlqf8pWKPmWsj8vDNClITIFVtfqdLEWvl3kg9CjfiJuGVQiT4U5TIrC0c4bWFzCljz0JTjiA/bVGV6hdiz3RfmjKu9ZNj04QkN7ayQyJ+4y/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jVa8Sre4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVa8Sre4"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3q41G004797
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 06:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yDOD6naCP+XeV3EVxxXgXxWe
	VWa+eq7jpdDsyJP98B4=; b=jVa8Sre4w3lXoBUivmQ6mnN9e46kDSeXxdGBWGa0
	JfG4j+WY/GXv2C/PmWlnx7kJUtfjgSAmr3xOC5jGtMqBSGYhr5RLiXTGyCIxzDb7
	LUpVq94FDMjHLam05wUVqrOmzP5HnM0LSXpA2SEZ/2kLa6RGKB19hMYmSkeNXLIL
	4cPdD/NXIW0k/1p+317qN9PYGdEPSComfwjX9ZQQBDT4dAG3J7iIjEDMNGBt9EVz
	EpSbUNbamEjdNLpGFh/PTZ3Z3fpPWUBpszoFgyCiBkZSPk2uQAdw1d+hhZiKWSO6
	Q5UU2mFtt211TfDLK9C06ESo90+NzfgZ898aWF0K+fbqAQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494wyr816j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 06:57:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7761dd1c845so3070887b3a.0
        for <linux-mmc@vger.kernel.org>; Mon, 15 Sep 2025 23:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758005843; x=1758610643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDOD6naCP+XeV3EVxxXgXxWeVWa+eq7jpdDsyJP98B4=;
        b=RbRH+FD6HLFyiLhK+ng7Tzc/Xl4+JaLvMvcsxRAhN4CS9mvDgl8rTvWo8kjUi2sNmP
         Lsaycy6hXGiNyN3wWXrIIKQ79fOlAkpjpirXk2AbUHejkdgdw9aJM5lU0JOEkwd3u3XC
         cP4rtg2cfiugE4qFermPcxNilK1fZOYgsxRfQ3VwrZmysfQ313RNOrkmgsHwEXR+oMpf
         gHFEXd4GHmM34FGgG69lxO6p29XAPe6QDUI9QV2aQwOcSE9WvFWYWcXAXOMUcJFSXRkN
         D6cyOL93+l66F2BErxdqVHnxmbdxS0eRI34kfMuvxenzFTuZhNR0rkJzQ7am1r7tN8VY
         0RHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU747/iCl5WpNwFLCRI8KbuTErBLYiWr7XcmjvN2sYRzVQd2+xXRW28q239M2/R+iaZaoqdqsuA40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVa1Mvb9gvvwZp/29kNrIeMY8fE4kYqgswqBpjwoPZXOAzJbZY
	wLeyuI+dUBLn9n+PidiW1JiXZDVlES2asgksHVI5jVOmfxSPonEH8xR9uxPTyZk0tg3lmZ0M4hJ
	4OJFRu4eRyRF2iSXKRZYx8+kEe3s1gCxhyw5QOnU82yajI5qRZwHEbKvfUkCxpd8=
X-Gm-Gg: ASbGncuBDissjk2seTVV6zIjpa4pJK228xu1mAAXYhy+R8W3Fv2Z9t81nVGJhFdhQZT
	I5zjI+Q8KdbQ1mFJwwDktW5z0j6CytKjo984wZT40PKZIknzwvNdujhcO6CXxcHEQ682hqnL1FX
	2bQeVbI1AKJHOqsXUkzWB6R+OpggG7eER4mS7YNZG7Jyvk42srlpZfzJH2gt/+qeM3mUyUnCs0F
	VdbRgbXWcvN+4Nu7Ha59YvB3WcbYSCdUGmYMPerJ49rTqCU4RpYhKyCrBSVw/4VeqdnCn0l75u0
	8WUWHLWtMml3v89JTgIRY+qS+gjAE/8VZwWtIV665vunfYLZOY6qZw4IgFXFuWrMv+RJ
X-Received: by 2002:a17:902:d589:b0:24b:270e:56c5 with SMTP id d9443c01a7336-25d24ca88aemr166330675ad.15.1758005842680;
        Mon, 15 Sep 2025 23:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4HAqsYboh1u5zQJIXFoukFFzA+7Y7eq8ylmhIrbJbC2vY6iiQjqmYMwdKUwYE0LFccwGbPA==
X-Received: by 2002:a17:902:d589:b0:24b:270e:56c5 with SMTP id d9443c01a7336-25d24ca88aemr166330495ad.15.1758005842191;
        Mon, 15 Sep 2025 23:57:22 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-260cf673181sm92629055ad.99.2025.09.15.23.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 23:57:21 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:27:15 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 07/14] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
Message-ID: <aMkKS6m0QEOWz7md@hu-wasimn-hyd.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
 <20250908-lemans-evk-bu-v4-7-5c319c696a7d@oss.qualcomm.com>
 <cb2a5c93-0643-4c6b-a97f-b947c9aad32c@oss.qualcomm.com>
 <8f8df889-3f88-4b9b-a238-16044796d897@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f8df889-3f88-4b9b-a238-16044796d897@quicinc.com>
X-Proofpoint-ORIG-GUID: PUbPSc9Epaz3r3cyw9n6aaCTjYJztmhg
X-Authority-Analysis: v=2.4 cv=SouQ6OO0 c=1 sm=1 tr=0 ts=68c90a54 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=aPFnfdsyqS22SUcEH6cA:9 a=CjuIK1q_8ugA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMCBTYWx0ZWRfXwiTXXLmCi1De
 Wrf3kX0+J2/wNL8e2usr+kbfEZuVvKnLkJZtIOEnqCNQMwZYhQp2ZrivdfK1MtJAUcP3a7XIdpD
 2pzj8IIXjg2/ZCcXOTj0S4pIfJ8KXG+LhTqbrtSJU9RjZAYiNpNsHCyXsTmxSylTL1JddVEV+R9
 Nj77od/6aGe1WpqqVT7/zlswBUci5DWSga7MFK7wvxEJmwE5DbwEPSsQJ0m8bmAjk9GdzF7i0md
 n5ALcPnoG+k20BDAb4xuA6sPtkTdHpKKrvyp1BkpTYRY5gFChpx2RKkQM6qOhoAzHtcrlwyLDIy
 2T0fHTMBc2UHxldKW96v0bZMaRpZryQM9slKEO/mgFHLxkAlKnJo0BFYfwQiemEvlnP85AuCJTx
 H/Z5oAsm
X-Proofpoint-GUID: PUbPSc9Epaz3r3cyw9n6aaCTjYJztmhg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130000

On Mon, Sep 15, 2025 at 04:03:14PM +0530, Sushrut Shree Trivedi wrote:
> 
> On 9/12/2025 5:57 PM, Konrad Dybcio wrote:
> > On 9/8/25 10:19 AM, Wasim Nazir wrote:
> > > From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > 
> > > Enable PCIe0 and PCIe1 along with the respective phy-nodes.
> > > 
> > > PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
> > > attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
> > > 
> > > Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > ---
> > [...]
> > 
> > > +		perst-pins {
> > > +			pins = "gpio2";
> > > +			function = "gpio";
> > > +			drive-strength = <2>;
> > > +			bias-pull-down;
> > > +		};
> > Pulling down an active-low pin is a bad idea
> 
> Ack, we should do pull up.
> we took reference from the previous targets which seems to be wrong.
> we will make it pull up.
> 
> Bjorn,
> can you make this change while applying or shall we send new series.
> 

Let me send another series with this change, rebasing on top of audio
change that is part of next.

-- 
Regards,
Wasim
