Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D1264A8E
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757016992; cv=none; b=mgJ10g0UAdrHKl0rUFjddwl5gW8HXeqI94zPRHGhLGlw2b0Wurw/FK6bKIy8eClwXv+JlPdKVsJrO9U63rJ7u04zc2+W79cohl+UvnKlAkoUDphU4/m4mkVSGpLZwYc+domDSV9fjB15JK+Re8n1FZPIUOi87PrIl9/DRHZq2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757016992; c=relaxed/simple;
	bh=wsHd20AsJfMa6Wx3AXg6obGKYV4i2kU1t40Rvld7cXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6YuZgdIOP7i/RPLqzDfw5nUQsqvz2zYSsQx5Z2arv2rrfIf/l2DpZMq6WqlAT2VFvO/xxZVsUXNXncWq1NcdolsRYUXSxIRv3S1Y9oCnloVZ6iQVxH8g4WmjxmXXTGQpZj1s+wnEnGoJwTI/o83Xlkcyw/PizueEqAQiux+ZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GStfmUu1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GStfmUu1"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IQqYk012122
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 20:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xOnQOwS+L47eJqdD2xfoBQRC
	L3cjvg9aVuPwvzZvFpc=; b=GStfmUu1CrqwzWdKY7Agp7+Uzmd0qtGHDw4NUVYC
	MVcWrDzMS6HJONHQZEbkOc1UB5oXYafzqviDkUY7K5m+wkbOElxM/kxi/zUvBlRn
	CKQl57xbcP5wYydUNyv2JJjp+T7DtL07vAMQV4mmghTYfz/avXx2loISPf8hxJwx
	cJcu5dbQpKUP/yyFVILniN/BfFTywgX2tTwajQ6pdWL8GOcyPqti5EPyvlqgxtOt
	4nnx4XncqRZF27YeNlD4816PWjUHS8MVkYAhhCJk+KvOth6nGuGHLP0mRztd0xk+
	+RXZ4T2R8xy2eyxaniRNefn3uvYgkzSGBVPALAcurDFXDQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj57p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 20:16:30 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7248ed9f932so12986026d6.3
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 13:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757016989; x=1757621789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOnQOwS+L47eJqdD2xfoBQRCL3cjvg9aVuPwvzZvFpc=;
        b=r3T82xi7V0Fo20r75GFP24zwj6RPosHkzzzr3+DRd6frV5gWZSw6TDp6HCNLpVag13
         MwjHBTEB0VHHPVlQyw9L8gAcR49TWwzdJFSORhYvHVaSGrCWf48dChk5IBrXrz47nqTv
         gSFKoknUyaVNo0PMnRg+OZPfOnOGNrDVKqyLRHYikv+Bm5jpGRr1AMcYk2IVGytU9yv+
         KvobifRKTcF75lP6xUpOacpS9bXakXwoaeY5HhDUTLgRkBZzJrQtp+o6bSbDktqOIO7t
         1Y5HguyT3E/1oc1OKMHjFvmN1nHIA3qvyQVdqUCIrlEt+tCboWQwGMxs1JNzWjAhVvL5
         y+Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXiKo19V9dFEHnK7pfcVDMml0V4tTvA5Bguk3PtfwXpqVyt2OnIUG2NOnjK2ohlBJwrk6ftWkRN8Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLCP4hUP5OyGjg+NT3AXhDIW2slLLBHBjyEaP30Biz1oj6I96s
	bFDIyHHuux4tUn+uSmjgCdXYekm0b40kPhSd8H/4tz4NdPDXxgYzbRxC/xt1zmm8ElrKiAOKaOh
	YpnTZt32XKriSeYa3WOeXwASxzIwc3zeEOjvqWU305voSIjx/jBkeS4NXEehzobI=
X-Gm-Gg: ASbGnctxfHVBRb9h3+mtFaXJ7kqbshf0R9z3/9xO68Qy/5ISsCGkovNHDJCS+sDqHtM
	qHiCgrXVJDkTFqwO28XjshTQ3/VmZUg5K9tPjjQTueYeuUgPwt130Rcr3HyLH8hACYv+GDUSCpL
	ZF0VDAEjulp3j1ZZ6Mxel1mPTx//IAt/9c3SMkrimb90H68N8eErD9+UPRMuIkrXMGP1c24z6D1
	qThDOzy8ABQz/uzSW7868TBFRSqXKRhMFsYKc2bMgApOj4Ss3Blczhhq34bbdfoil1MdJ6/n1xL
	CiFu1f+UW9pPMXzMvZwDa0GnCnQu9xe26tWiKUQjzSfcaB1cCLGIsnw1Cg9LbrmNLarY1tebo0x
	P4zLA+Ppsb2f9NP6uz1xZEGWEEbMim8aFV5uKogDK2RCXTAmDcAtd
X-Received: by 2002:ad4:5f06:0:b0:729:d2cc:9443 with SMTP id 6a1803df08f44-729d2cc947cmr38070716d6.39.1757016988775;
        Thu, 04 Sep 2025 13:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6ZBkThlXqQk+QXlZrohvU7MoDDoi4EYRmpkHcRkJ3x4qqQmgMU68HV5l9Kryo0ZsRp4157A==
X-Received: by 2002:ad4:5f06:0:b0:729:d2cc:9443 with SMTP id 6a1803df08f44-729d2cc947cmr38070086d6.39.1757016988093;
        Thu, 04 Sep 2025 13:16:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad4e2e3sm1393356e87.147.2025.09.04.13.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 13:16:27 -0700 (PDT)
Date: Thu, 4 Sep 2025 23:16:25 +0300
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
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3 05/14] dt-bindings: eeprom: at24: Add compatible for
 Giantec GT24C256C
Message-ID: <zedyu77se67b3s4zmuqcx2zslaasemllmtr6ua3k2p53cdspcc@ikpf7np6ugfy>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-5-8bbaac1f25e8@oss.qualcomm.com>
 <qya226icirpzue4k2nh6rwcdoalipdtvrxw6esdz4wdyzwhcur@c2bmdwnekmlv>
 <aLnqZktduc/aT05R@hu-wasimn-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLnqZktduc/aT05R@hu-wasimn-hyd.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX1FrdfpyDDKAX
 PUKNDLJvlbYm5OUY8mvUi9CFn0dJUpDbgeSABSlscpJ8W37nFONNuvamY0FvXbbJgHz8UZ2w/3G
 HijKnPZct/U+LQsKcM1COOqAfTlCaoPLT2sxn0a+e00tJq3DXq8ZB2XX/L1LR2nFlwCKt4KeBGG
 rqoANa53eAHJY3Zi1eVottmdU3sJO+goEb5mynhlKVFgbtqzXHqi9Oh54iTGuXWYglyZq1bFOGD
 nXFfN/4UHc5K9hkTEYuMG7Ncb7qYVKo49koR03fqRqQyshlIbFlZDPC1d1byaDdpn3h3ofMvYyb
 f2SstnEiZWqoqU5xPd5pHpmyehPEBjOnIF8dcc9ozTUtJV83qQU4Xd17picx0CbX4ZoitXN57zz
 7hCf3+sX
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b9f39e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=q5DPIbX8LfODaG0eNlsA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: aFEOV-SIMlhUxD7s-gTFC5XlwYm-gKJI
X-Proofpoint-ORIG-GUID: aFEOV-SIMlhUxD7s-gTFC5XlwYm-gKJI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On Fri, Sep 05, 2025 at 01:07:10AM +0530, Wasim Nazir wrote:
> On Thu, Sep 04, 2025 at 07:43:27PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Sep 04, 2025 at 10:09:01PM +0530, Wasim Nazir wrote:
> > > Add the compatible for 256Kb EEPROM from Giantec.
> > 
> > Why? Don't describe the change, describe the reason for the change.
> > 
> 
> Let me know if this properly describe the reason:
> 
> ---
> dt-bindings: eeprom: at24: Add compatible for Giantec GT24C256C
> 
> The gt24c256c is another 24c256 compatible EEPROM, and does not
> follow the generic name matching, so add a separate compatible for it.
> This ensures accurate device-tree representation and enables proper
> kernel support for systems using this part.

LGTM

> ---
> 
> > > 
> > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > ---
> > >  Documentation/devicetree/bindings/eeprom/at24.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
> > > index 0ac68646c077..50af7ccf6e21 100644
> > > --- a/Documentation/devicetree/bindings/eeprom/at24.yaml
> > > +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> > > @@ -143,6 +143,7 @@ properties:
> > >            - const: atmel,24c128
> > >        - items:
> > >            - enum:
> > > +              - giantec,gt24c256c
> > >                - puya,p24c256c
> > >            - const: atmel,24c256
> > >        - items:
> > > 
> > > -- 
> > > 2.51.0
> > > 
> > 
> > -- 
> > With best wishes
> > Dmitry
> 
> -- 
> Regards,
> Wasim

-- 
With best wishes
Dmitry
