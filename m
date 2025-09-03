Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCB2848B7
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914469; cv=none; b=lhKOr7z4dyZU0Xelg8my7y4ddYK1z4wtH8zqa3AqPJujHg0GMBVbLh6P/uI4T9EG3liELuuEL/R86eYAK+Mz51IxAyRj8Ue3DWoSPBsKf6zPuFGaVyIawdmrMPQAwdpa4T4fulEmw3dvp91Php+5vnDNQCckHpMUyx6PwWCzUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914469; c=relaxed/simple;
	bh=XInwh7iVomsQx5qogF3hzih+Y3WyM16GQrfW14cftWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBZiJS/kEk02IC56y8QEy3uAGdzxeqIDGttlaL4fL7zLi1ovUNNkTwXLelPvYrzAlBuuBatg7p1KLEf7UyIGre5FmHqKxfDZpT4pVqsHla1dIsP5isB/l6rp1It+LS3nyzWrfAKlT6zibbQUBsamlHq4ZXAYVygoWkY9h+Y70Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MoqhkWoK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MoqhkWoK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwrfj029052
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 15:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oU9zNSZ+JNQecUFr9QN7ywvBOG1sjWRxRq01g9yamiI=; b=MoqhkWoKRseuQIXB
	zhRJ6euWY97pDSUuhd3mKCZpuIgDFvV/gqKtF8qamruclyNzXc6uR+s/w1GXm5wl
	mOHlceyHakYFsQU2zLvvRoZF1urhyT0xldpqnRx/iZnPzn4thFCjDJ80HDATBZ80
	+Bkg9dZmYVh8WKf7PenuHvVjizd43iSjFLxK9Cqp/M3+EsOMA6jz1w2DLotpCoS5
	uCqGKy1LarQoximJsUB9CeBPnzw2viL3VacWZA0IUK7veCA2hDogndrU+gagpO+c
	3BTzR43Th+S5McMANst+BNgapNJBsojjIsnK2OpJazJ+vxAxm/PUsgKqYWuHZ1Iy
	AJd+lA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw04a9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 15:47:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4c949fc524so4560509a12.2
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 08:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914465; x=1757519265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oU9zNSZ+JNQecUFr9QN7ywvBOG1sjWRxRq01g9yamiI=;
        b=s7REyFx3gXzJ2jEivWWkepRvFQn2vsUgZdMSBejFUy0X1vpB2q0KF7u7CZx33C+fKG
         C2tL+cRmIoVfTzSMbFbkmZ09v49JN8PwF0yfLlVzgftaGVH5E0mcVE0VArtVqTKmHzWv
         xaEkzQ4zXqQdFFX2IRJy2LazDcMKtGEeAOT3iPGdqihj9zrnRuhknrlkzPC0xmMCUv0C
         P4vPplGRogcEh+80tjQyUnmGAwaYxo9aBl7s5lH3gb0oivI54U7wQrtCfyN5lVF5jkms
         9jhlyvWK2NYv6MgIl6MOUNLb1+9najdxMDkvpDpUycNUahtGr9elc6gtTipWMNPWPSaL
         Zeaw==
X-Forwarded-Encrypted: i=1; AJvYcCUXi57a8uQYZTtE1UkxfoAfmd6ja5aMnfcu3R09aiSWqL5royNHFAxglqQphxTUSH4uWepuHcCrg3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwATm3VabS6upPgneolD4wvnjRCg9SIKjQQPV/Qqk171E+Prupo
	17XJvIKFzXoOTCWSThrz26qQ8q4Oo1NbMzcmTi3qPgtNfSMtV6T4H0O2pEAKt8IekK8vnalVd/O
	9GgkcGATf9yAB1mRi+gaaFYzHgVgKP14JSW6tBD+A5Gbx4p9iZN+7nzDZeoOP5sQ=
X-Gm-Gg: ASbGnctCvrXU0eamt611+0zmzPWbEJP2/G0yU4ie2Y6vKK2HVcgRdZjCH6/+zaaPEkp
	pjcy7tA4cLXwUJjkPzDQyJ6U/q0zq7WZ3bfqSRt3DtD8QZZvWKH/i6xNqcsopXYlh4Li4JcgDgJ
	FfyFeQiKMWL6BpQTUVFVvkQ3e3StvyzZ5Kh68lERD4QBBcTKUNrG/4WZ9wYOP93Jxr3IJOjUaRt
	xlp8xnPIhrdZRbyd2lqOYz52u4kVg4B7c9/LESox5SIsXGR/grxEEl2N3tgc5gHEbZEd7LyzRHY
	qikBp2a/cZMM1HGg9L0B40fl/kfpG0cfxGaT6S18lHoJw6DnWQnPgM5WA38BlX6LdTkT
X-Received: by 2002:a17:902:c950:b0:24b:1585:6363 with SMTP id d9443c01a7336-24b158565c2mr73678165ad.8.1756914465242;
        Wed, 03 Sep 2025 08:47:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4YwLQKquajxMk71cIseTHOUFmzvVFh27auBfgVNaa4odZqX0nZOQA82oA2Q+AJfG8X0fGzA==
X-Received: by 2002:a17:902:c950:b0:24b:1585:6363 with SMTP id d9443c01a7336-24b158565c2mr73677845ad.8.1756914464769;
        Wed, 03 Sep 2025 08:47:44 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903705b91sm166483095ad.12.2025.09.03.08.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:47:44 -0700 (PDT)
Date: Wed, 3 Sep 2025 21:17:38 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH v2 04/13] arm64: dts: qcom: lemans-evk: Add nvmem-layout
 for EEPROM
Message-ID: <aLhjGuaAybp2CeIg@hu-wasimn-hyd.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
 <39c258b4-cd1f-4fc7-a871-7d2298389bf8@oss.qualcomm.com>
 <aLhMkp+QRIKlgYMx@hu-wasimn-hyd.qualcomm.com>
 <aLhZ8VpI4/fzo9h8@hu-wasimn-hyd.qualcomm.com>
 <c7b87a26-2529-4306-86b3-0b62805f0a2a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7b87a26-2529-4306-86b3-0b62805f0a2a@oss.qualcomm.com>
X-Proofpoint-GUID: XET4-1ZtCwNh4dQ4zl6_NtWbmmhNKkG-
X-Proofpoint-ORIG-GUID: XET4-1ZtCwNh4dQ4zl6_NtWbmmhNKkG-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX2wONrHeyQbBG
 mwNRUmw3gcoC3B7v+TPiVTKYx/a+E/5avLm29fKE7h/GMFWDNA/rdyEO5QXI+zuy0kuVCN8C/21
 fj6knd6m5WPHPR/06Fpuvuvn5K+dWFfxzUZaLtZkQjiFdgL03xcJ/2ClpE75WRdKGCIOC/Ao+sK
 +rR3MudyG91d+SBKItfkdONggAeHPFw+HN7pKiyNUWe3wOc/lTVHMLEbMuZovcn4+QMvVg6rrVK
 fJ0Szhhird1J/ePuyHETJ/SRRS2boXzAkNg6bW9yMH0/Zm6lZbp27V9HO0R5Ls629PyPTPw/Cgj
 6KDPWmKtGsnPbbOMhsANu63DZVr2lgo4tAlmiBPSorR+23ziY9WJhpesJHAHboUlMjO/QJ5WpLu
 cc/WN3sa
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b86322 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=QqZMUp9YY9ei_m5RKlQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Wed, Sep 03, 2025 at 05:12:44PM +0200, Konrad Dybcio wrote:
> On 9/3/25 5:08 PM, Wasim Nazir wrote:
> > On Wed, Sep 03, 2025 at 07:41:30PM +0530, Wasim Nazir wrote:
> >> On Wed, Sep 03, 2025 at 02:29:11PM +0200, Konrad Dybcio wrote:
> >>> On 9/3/25 1:47 PM, Wasim Nazir wrote:
> >>>> From: Monish Chunara <quic_mchunara@quicinc.com>
> >>>>
> >>>> Define the nvmem layout on the EEPROM connected via I2C to enable
> >>>> structured storage and access to board-specific configuration data,
> >>>> such as MAC addresses for Ethernet.
> >>>
> >>> The commit subject should emphasize the introduction of the EEPROM
> >>> itself, with the layout being a minor detail, yet the description of
> >>> its use which you provided is important and welcome
> >>>
> >>
> >> Thanks, Konrad, for pointing this out. I’ll update it in the next
> >> series.
> > 
> > Moreover, I notice that compatible definition is missing for this
> > EEPROM. I will add it in next series.
> 
> I think the pattern match in at24.yaml should catch it
> 

The EEPROM used on this platform is from Giantec, which requires a
dedicated compatible string.
While the generic "atmel,24c256" compatible is already supported in
at24.yaml.

-- 
Regards,
Wasim
