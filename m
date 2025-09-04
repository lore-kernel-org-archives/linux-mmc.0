Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B4308F3C
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004214; cv=none; b=tofLjiXYJuhgvB+ZtlhhsLxZEsPCba7M5SpXndN+BsclTjrLlMYFwYrtBw9GyBOoUBasvtUlkNiblvF/4adRAyD+1GiISq1b1bYEzYkOb5kCnn9Wcjv1kxJCWsJtN2AKJt5zfZdUGWMdXpV6sFID6Gh6cMlXMaW/6cyVX3LpUzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004214; c=relaxed/simple;
	bh=w2dejdkgkOfnR6ZZTToOeg39YeTLEfhrSvr2kuE6Luk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4SLhyPBO2Ol9YsYJz8uuEPkcau2ZOn2vDOr5uPkRydWPaAH2hb0eS5nU0QpMfLYCgsLogX/7VtdSEjInUBHcP6GLH3m+2lIqjfCrd7iyxZW9V8GWJ0HPFjoTEIb11mB2i/b5FJZ0X9jShK69AB3OG5qS0kEguOab0Qp3xW4TVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OodcnVPr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OodcnVPr"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X7pH032155
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 16:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=194cO1GmvVxOIcn8RfAnyM1k
	UF1gEHExRQSWfZpXVr8=; b=OodcnVPrmCsLxy2Ifo65URS3b/n7rJGtjCtQrPr5
	W0/TwIJsPKYuipsemCHLWxwqDYvck4Q65+3QQ3Nu59kBnc+YuocNLB7DqX54Z7k7
	5PPbczjGmEifemYZq/NRv2bV7ySZG/bNC79Ftn13pmGDQCzolsfjT9CFjFFnmMqe
	b6Va5R3e1WqqbePZYivyGv728YorPdGIWJQOxfuTezpM0gO6ZWtdUJL6eTL527T0
	A8wC9B6xhzsxwnJDnb4cuVC+b7FeKUyz8LuKD3LK1vXkcka4grf9Mae0Doo+UtmK
	4z1dnxQfgzGfHWIBRhWArTqtx1X1rnQoEedB1BbWcpHk6g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpgcdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 16:43:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5e303fe1cso6926241cf.2
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 09:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004210; x=1757609010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=194cO1GmvVxOIcn8RfAnyM1kUF1gEHExRQSWfZpXVr8=;
        b=bG01L+9awjRmOZzaxiwd8ANS1CMS55EBpQJye2e6wdoHwQogQO4shzeVE3psKe1mfk
         VwteVGGCR0P4ECT70qtL9L/KSuu+WpnCquv9jacKtnGsXD7qDJl26iGbLvWUKNFTwWS6
         VQhtUn5C/Lml1gMHKQhF8B49lcEvtuP7QlSZnrUyiA6A5CsmoVBdnlslDsuqOEbWWTf1
         Y5wkF5IsMtto496ewJynFJOltPpeIY5FG0ZfQ5KtXFdyTo5UwfV5+2OE8eCwOpeKIJHb
         EnilBEgNX+EM60keW7qmQcy+cekNnAS9Dn4SjPhpFLvcFN3to7DxWfk+NaBwurjlJqIx
         pm/A==
X-Forwarded-Encrypted: i=1; AJvYcCXEwuEJZOkM1zBWQPjvOaK2rNKhvS9rcZSswErBaKGgXArgBW55+TlfZudM10MeJP2/OPk3BOaKsu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLUpNQ1VRT3U/SYADzwIosHT39U+DaOyZZOqYcrTmx8p0eZ7p3
	Rm8wNyLGlae8XrMcewm8o83+8bgmeYG2G16BKeBFBYTRVUnBbuLurWg+5W0COA/9ZuskU0+IaWr
	09Tm3h3vMm3C4KSZ3hLqZ8RbKXEWQi0i2ZoXD97DWGAJtZtCHsLAxk2QN4aJABQU=
X-Gm-Gg: ASbGncun4Ezqv+icbvbVVW5+NzqQ0RCdapAxDTDQOL1Tgovr8Bi24knOi2PgDbB4Lz4
	kkKZd3+p251Ip0ypNFM2+PuV/z+XFgnVWG/dvzntY606tCjXJcSGb8rjNKrIVJw7tcFbpr9wuC2
	QA2hGr7xObXKc6FpV+9yVdNdpHmZ/4IM8I5KM/PHIXwQd+3dHvuLOlcp2UEMOTttea0Ai+E/dCo
	RTPypmFMAiPhkvS12NNNt7tqp3au2wVhk5Dflr9V8uE7PQ7UAYKhN7al63eOmiabJgJ3EyfBzHe
	ZEbFr1oDA2Qywb9tKWvAye6Wqy7L7Bz93FTJ6VraOkOIXxG/kCJIE5L5EShi41PrKfnsjqHKlkZ
	Dv5sAyHRZvkB7IIvdaANYBc+gAvaxd4s7OubMixZ8ORXNflx1GGs6
X-Received: by 2002:a05:622a:1350:b0:4b5:8c8:11a3 with SMTP id d75a77b69052e-4b508c814f3mr64210961cf.50.1757004210518;
        Thu, 04 Sep 2025 09:43:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoXhcaDoqYlrzIzgBJXwbTTQZl4p3OH3mRMEaeJAudeMwawR3Sn0KzCcUZMEdXKJuLkxKt0g==
X-Received: by 2002:a05:622a:1350:b0:4b5:8c8:11a3 with SMTP id d75a77b69052e-4b508c814f3mr64210331cf.50.1757004209938;
        Thu, 04 Sep 2025 09:43:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab5e28csm1307921e87.17.2025.09.04.09.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:43:29 -0700 (PDT)
Date: Thu, 4 Sep 2025 19:43:27 +0300
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
Message-ID: <qya226icirpzue4k2nh6rwcdoalipdtvrxw6esdz4wdyzwhcur@c2bmdwnekmlv>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-5-8bbaac1f25e8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-lemans-evk-bu-v3-5-8bbaac1f25e8@oss.qualcomm.com>
X-Proofpoint-GUID: dU0aaM-6mS8AHhf2nKG2Mc6r2WC1eTv-
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b9c1b3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=E0jHSIb16-xZ11K09xUA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: dU0aaM-6mS8AHhf2nKG2Mc6r2WC1eTv-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX7zbwRgK21CQT
 my3Prxxc8ZD4++Yr1AozPXY+X73m83SMZjAweqGch2PskYGJzdnbLT4tX6y3IOcVagCBYNejsxl
 a4gowPdREmVvVgJoPf8a5RleJCsDmvLmChcd9qG7Cs2HgX0XkB6zHcbpttopoGYPlZELh81/cPi
 36xdYuyVqe4zfB/eKC0N5cx31EGpy0j4DFXruJRYnwIz9FcuKhBGzVKbWuKIwVb+nNRNbXotk/3
 J7J6ijU+YImGo53Mz/kMZEhhysgtDzza1uQvqbrrIPSvKFzWBEFC8inQQQdqjRcca5CDyI/UOEZ
 bzanHsg5gDzGP7PvL5waA6Z+atdxJ4NnSWa1nVKDgGyRO0keMpowwuTcQoYD5Ahzw2T8qaT/mvT
 uQxnVxkY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Thu, Sep 04, 2025 at 10:09:01PM +0530, Wasim Nazir wrote:
> Add the compatible for 256Kb EEPROM from Giantec.

Why? Don't describe the change, describe the reason for the change.

> 
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
> index 0ac68646c077..50af7ccf6e21 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.yaml
> +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> @@ -143,6 +143,7 @@ properties:
>            - const: atmel,24c128
>        - items:
>            - enum:
> +              - giantec,gt24c256c
>                - puya,p24c256c
>            - const: atmel,24c256
>        - items:
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry
