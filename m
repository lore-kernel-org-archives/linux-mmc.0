Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136610A1E
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035425; cv=none; b=fRNPBLEy5AJQedxoCme5LhTKwjI+rl4Tam9Oem5QZ/9ao5ZuXi80HeeiVkHAb/bwaA4TOrSKFYomIh94vZF1LFGlU+lZ1x3nnYb9mBSIbpyC2ixbKMDU6gSPTzFhbwMD6T/U4nKHAqXks2cLjHC11lzMO0yf7hrdDpQNwqrZtN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035425; c=relaxed/simple;
	bh=jPuaeZTW6WYteNkW2J7/5OFdzopwcBsfgkccni30zHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBR0sg9CGqGrb/w2QsmCiLu0hFvj0hv8IDQAsnJtNd5O25icBN0u7oxkpl07r8aBO8zI3L1fa2/KcsK4xdOriIbGl67JwTLOGyveC0yvFZRaGuWstifPTKWSZi8usFnxkTEsMrfExAmJHtWO/SBr2PYyUaFQQdY5tJX26v/djWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bX1ydxqy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bX1ydxqy"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9mllB013874
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 15:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TcedMU3jn9IbGxGqJeuSafFA
	3N2TJP3yv0Irk8eYIvI=; b=bX1ydxqyAvzTu2umm2rKUkg2ehgygbfhrQnIRcNn
	mjyLCkfdrGd3wxo4Fg0SFXnLWogdcg0IvVVgUbbwXH83Ow88GPbOX8Y2TnPnU9O7
	s8tbWlkexCg3Udj+5WJruUXGLhdCzqE2zq0j/qMv3rPYzFcw2q6BTWFfrui0ttLn
	b+wdN/4O/vp0GU3KlIWt1P2b3xgZj5Krw1PobShUm4WtL8FQsoj38C+RiyBHFIzF
	FN8NDZnc28eQuzHtIKMYzRBvaY++kyULF8JTyFrtDnUkItawMt00OUfMG9/doeM7
	kXqbTv0DC3j1Mz+WdkEkBcQDInBrXWCrYDxXvqQluw7sYg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496x5atef6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 15:10:22 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78e0ddd918aso5612316d6.1
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 08:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035421; x=1758640221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcedMU3jn9IbGxGqJeuSafFA3N2TJP3yv0Irk8eYIvI=;
        b=HyEwvuS7ePtdBBgVPYzG7ssUvmflWCR79RUDfX8tPTMW7E+ndDm+GHSq5PP9fXJa9s
         m2RHczAsECs3VJaeBFsgUSDEmXrGsGU30Qq2lfk/U71aXp6Ev9Y9NvCCew+RtuCySdff
         ODSeTnLjBRa6PF7cK3w9SGeNqj3xC2XZMYRIKWJyTQLAEdVQWo5IoOrMnu+32Q2/d0pr
         R4uIpwb8EOnwKyUg/ycC3SdaOCoTuMEgoR4lDQbu9SycT6g1J1yjM+L+Q/wsMImMRF+w
         N5R9diN5ufwgwnKdW3Gns9HZM3D1Zp1A5Nc0ajgHi1YBKguVuD6VQEfV8EQdDrkD65yO
         dSjA==
X-Forwarded-Encrypted: i=1; AJvYcCUyBGJv24gq4FTnbjcPiXgoIMbnaQjD8HraHjhVckrRYUwsrwbtLlN5KcvrxM2L4+CKsgBqN3hwnfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztp36Pxs3U2CKtjDQFL031Kotg3pm4ZOJmXzOMnbN2CpUa9d/N
	4OOdfmts/AXBzZ2OvErL7iC8pqJDTpcAi2ohAfew7dGMAL13fJnfkEls7noDQek78k/UoamunUN
	VEM3p3DDDGi/YEulaan2Ukdgy4si1bDkjBMSXa3BMoAKTb6SSKAqmgRvLbKZbUI0=
X-Gm-Gg: ASbGncsUeLuA7jvQo9DILdlOjS8qcaeZEExfxnQ2CLqOz0o1FNqECDNbApG0Cqa2ONf
	98jR1norOQJ4SCJmfycEj21fjOzbnhcaPaVTrHXqPSxcbT0LbC2FB8Jqm30blxX6iPQ1KTXRjGB
	sZw+lptWYdWpPtQH6JFWMHf14go1Jbhz7jWwF9RGXwhBEyWmokg2liLeUky2IGpxhPtkWyDPicA
	eSyE/8F/dkbxaojOXr1PaWhHA9NMuNoIJpFOu5Sb1UHmrHjPcbtevKM6vO0u2xJt7GPhcZJfy4E
	PHTuHsMHjeIMOUNek598PCibh5siWHIWunMu15vof2gRlhhhvQfRJr1ZHh79Pj6XXbCmLDTABl9
	h5XIZU2c5zwpxWqLhqLXXyqTfdShGkbrJXl81C/ARL31Xa7oIuqTU
X-Received: by 2002:ad4:5aad:0:b0:789:2556:f984 with SMTP id 6a1803df08f44-7892556fbaamr73641656d6.18.1758035421440;
        Tue, 16 Sep 2025 08:10:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnX49z2cSD36W5CA4tXYLLTMMMKW63qRA/5PsrZgN1RV9C17RW84jLlEaeZ3RADW+1Km6vqg==
X-Received: by 2002:ad4:5aad:0:b0:789:2556:f984 with SMTP id 6a1803df08f44-7892556fbaamr73640776d6.18.1758035420812;
        Tue, 16 Sep 2025 08:10:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f163f4c52sm34087491fa.22.2025.09.16.08.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:10:19 -0700 (PDT)
Date: Tue, 16 Sep 2025 18:10:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: Re: [PATCH v5 02/10] arm64: dts: qcom: lemans-evk: Enable GPI DMA
 and QUPv3 controllers
Message-ID: <hgkc2ifabxcvzc3ngxnenav7mposnsk3u7kvwhmo3yxbm37fsw@wt6uu3g4dynl>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-2-53d7d206669d@oss.qualcomm.com>
 <n4p4www37qz4hw75l6z2opeqks4g3u26brceyxi6golam7f5aw@raandspcihi6>
 <aMlXIdgavXT6Ndt9@hu-wasimn-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMlXIdgavXT6Ndt9@hu-wasimn-hyd.qualcomm.com>
X-Proofpoint-GUID: RBUcH3O5aBaNmhkVoEBSuBaWEzNtmkkK
X-Proofpoint-ORIG-GUID: RBUcH3O5aBaNmhkVoEBSuBaWEzNtmkkK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDAxMCBTYWx0ZWRfX8B+MR7cweTIS
 VpiMRhSqHog4vysXHRvPkD9AeBEpoQNhcGwIlJM3aJQfP7cQWY/wpsQpvNT67n9WAWOe7AmTt/g
 B+pQYde8Ecs+zRABOLXYttA2A8DGrPoSoad4fIwFamNAZijYxl+q4w6nV5svDG2/jojDj+c3j0l
 EmzF53EtLX7/NakaM0+nc+Sgq+3wq+f0g7DHTLtEa+swXQbDKGzWkE5E2g1f2TxsmqB8uiJ225Y
 hCxwqhXnDGDAyMA1ihaJAv4ikhCWcP0iZFkyJ1KsxcORmqzNtznFr4IjjeX+JWMUm6rnfmpTXi0
 spAzT5zexamUpwFdTd0TudgWuu+3ywm35Gts1BTXUAhbTYqZzGV2fqYwF16nyocLSjSy98QDVU9
 u55CTd+x
X-Authority-Analysis: v=2.4 cv=WpQrMcfv c=1 sm=1 tr=0 ts=68c97dde cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hx3DdL32n9YRypj0U04A:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160010

On Tue, Sep 16, 2025 at 05:55:05PM +0530, Wasim Nazir wrote:
> On Tue, Sep 16, 2025 at 01:59:20PM +0300, Dmitry Baryshkov wrote:
> > On Tue, Sep 16, 2025 at 04:16:50PM +0530, Wasim Nazir wrote:
> > > From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > 
> > > Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
> > > interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
> > > DMA and peripheral communication on the Lemans EVK platform.
> > > 
> > > qupv3_id_0 provides access to I2C/SPI/UART instances 0-5.
> > 
> > Nit: used for foo, bar, baz and slot ZYX.
> 
> Ack.
> 
> I will change it to:
> 
> qupv3_id_0 is used for I2C, SPI, UART, and slots 0 to 5.
> 
> > 
> > > qupv3_id_2 provides access to I2C/SPI/UART instances 14-20.
> > 
> > Ditto
> 
> qupv3_id_2 is used for I2C, SPI, UART, and slots 14 to 20.

No. I meant something like 'GPIO expander on I2C 2, NFC reader on I2C 10
and CAN controller on SPI 33'.

-- 
With best wishes
Dmitry
