Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628F313551
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912125; cv=none; b=Zo8RNZWuhURo/KNOiTe6SsT8P8iu65vz8AbmK6XxCQc818DXEzqY/otC9bHqB3YgS5PFfWbnorIWO3+sGG/z3MRABvMcXII4ITnegpb655yPbuyhuIlxckLwRfqZxyS425bhvGX9t4OXL2OS6vF42PphUpd4h5v3tFivLXv8eYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912125; c=relaxed/simple;
	bh=PEIi8D0ILG9jAGxoIJMBRZSWEk2VBd2QP0UtYPalGGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLYgycx8Au2WWorShFLUISJPSTzk5lxg4KYtmNiWDlQASodG7j4ciX//kdU0S6FJeAHcMUSPmdM/loT1er+FVEN9JHFefdrfPmA1RgYQ+1UAYR4v8As5d+SxkDSJ0mEtvIifkMiHlapopwyNoQU7pvmZcbryczbmBoeS9Yfo1sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c7zz34nU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c7zz34nU"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DwrDN016739
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 15:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SoH3YrDUa+bqYy/B2DvJjbGT8HAhLxpc8jLwcSCRwOE=; b=c7zz34nUkwhhp/Eq
	Mdzh+jIjmrvNfvg2XDP9A6GiLYwcb70u1CPkEEPQWqWUlSR4yA3rJsiYVVZX/+oy
	FPFf2QVrEoMzhJQtj8fOWntauHfzkGH2g0lRgfhTxvRsh2TJ7+KY/gk1Pxp5BvMu
	zYfBzx422kavaKCTuORYKPi8Nj6sKGrMLTt04onUqcE0HRdL2+yPHsWrXJKBIEjN
	z98FHOAmD5EtQuteeua8/prVTBeS9o2R03Dc2Z+zL3pgUKpzRdO/1wWS9aqt6kz9
	cNyinp9j2oDWkLqn5rEAV6BrZM5s6VGeL7zdIfubBK+RyS7+ctzgYkUb5NB+avMx
	ZriPpg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj0p9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 15:08:43 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77237977e7aso7761b3a.1
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 08:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912122; x=1757516922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SoH3YrDUa+bqYy/B2DvJjbGT8HAhLxpc8jLwcSCRwOE=;
        b=EFm4emKx2Rzn4MbS0DMMjsRgHAFIO6sNSZEDmjS+7jnv/3gw75ioZypFH2W35SCvQA
         a1PU53cbiQ4qqo/T1ZTPfF5fpDE1tY356BnGZIFG30udwvt825Ckwq/ueU0bHI96uBSQ
         yRcRbk+DbtSHaL1/dTUgX8VijmjgZYIUwyeEvzLjzxGbIhu6m0ULxicItkuKnrT5ruY9
         wJ3Ns95wmRjJOmPBZKAajyajnCbAl5Jewwi0dWyE+su9NAS1H5Ce23JpFVpvC6VGhBpf
         52gi0wCrm2zWAqF3RuDMgqouVR0/QPbfXxF+1txSDibAyfGKYl6tN8RQDmG7P3pmtMkK
         461g==
X-Forwarded-Encrypted: i=1; AJvYcCXvsMkoL9n6hUFuhcPKXKL7XTHy3TZhVsqc/3gMW8Hdl8hvhCg+1aLic5/wtzic4F1o3yV5LBlB05g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGI6CpUx1WIrNx20GMjd7u/mHgHJ2DDnyRikc/GYM2DdzD71re
	R7gM5aqI2HegSQ4I9Il8W39owPGKzOwNStYpGgrWfLy81EAcjmzNVycL/0jsJHE1EhP9U2eg7oN
	yQ7aokGib5DZ1JBscz/KbrbQSrO6+gcunEFc62sB48ov08DM710aW+510+LCvOiQ=
X-Gm-Gg: ASbGncuOh4MJr3KC1zjiPZJ5NGzPgBpiV78pYnMm+CJrhSS5n/b7aHtSlfIYdn9K25N
	F1z9yUKEcdwB/n6yYeMSOBeSsm03iKaG/cSgxbcZyjUvjwLfsEIGSLIf5aa/E2CUAn4qAS+qi0V
	9+RMHAf11tNCrtFaP5mfJ1CLwwR7krFYvt9lBI2EDhWU4vGqc0ZxjwWpxH9MRxmU0gj9AcTDbNS
	QW25cI9kP/23P8kk5F56A6MMF2Mm20snR8VxRe0KK3hZxizsMeJZsYtK2HmHQLuO2XI+7qlnqrT
	GqEhdlKZHoWCgXSttChMvF2Q7h7UXZ1Kewswwaiq6mgRzMidyKD7mxsdtM2JkvAYwvY6
X-Received: by 2002:aa7:8895:0:b0:771:fab2:83ca with SMTP id d2e1a72fcca58-7723e21e641mr21760182b3a.4.1756912121963;
        Wed, 03 Sep 2025 08:08:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoo21E/5aDqRCm9BjpK6u1Ze7qpiyckB+Jd3+cAAsY5ZXnVugKuxKFWIjKzAdwtxx5J+LzRw==
X-Received: by 2002:aa7:8895:0:b0:771:fab2:83ca with SMTP id d2e1a72fcca58-7723e21e641mr21760127b3a.4.1756912121469;
        Wed, 03 Sep 2025 08:08:41 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e3fa1sm16546097b3a.83.2025.09.03.08.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:08:40 -0700 (PDT)
Date: Wed, 3 Sep 2025 20:38:33 +0530
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
Message-ID: <aLhZ8VpI4/fzo9h8@hu-wasimn-hyd.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
 <39c258b4-cd1f-4fc7-a871-7d2298389bf8@oss.qualcomm.com>
 <aLhMkp+QRIKlgYMx@hu-wasimn-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLhMkp+QRIKlgYMx@hu-wasimn-hyd.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX+S/9P/+fKF3H
 uVpsupPK5bJI9HTrItB18dFtbDmECfpSmNRwleZfb5JbQdzAmN1uxlc4KTzXc713SEsohcqnuJj
 ZHGPOOLtShULAmUPo/qg1T9VpMir9BoybQpIVaak/2zehK80I4/3l6hHB2KQg+pTLqb6x6LAP1z
 mgjS5a29fcHdMtNBMrn2h9tPkeBmm/WEJSkfO8VjriHgvbT8cS6LUF0tsn73wmCVkDcPmQpVVex
 C+r6xInTcTjQqTWAb8R6BBqq4kt9EPk+E925yn1zzwrqkXHF/4GOf4xdK+8bCWjSUOyXg/zcyAb
 UyEBn1wJIyCoYwzTsxlEf1WZ21/4+990US0v3qbAEOnhg90JnlwO+i85IM/THUoZKjzXMqJeum6
 SWIuolnn
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b859fb cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=aoA1JJJOD3z3MUMqd-EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: wnaqfViA9HMhij2YuoObeikfyoFwTIhq
X-Proofpoint-ORIG-GUID: wnaqfViA9HMhij2YuoObeikfyoFwTIhq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On Wed, Sep 03, 2025 at 07:41:30PM +0530, Wasim Nazir wrote:
> On Wed, Sep 03, 2025 at 02:29:11PM +0200, Konrad Dybcio wrote:
> > On 9/3/25 1:47 PM, Wasim Nazir wrote:
> > > From: Monish Chunara <quic_mchunara@quicinc.com>
> > > 
> > > Define the nvmem layout on the EEPROM connected via I2C to enable
> > > structured storage and access to board-specific configuration data,
> > > such as MAC addresses for Ethernet.
> > 
> > The commit subject should emphasize the introduction of the EEPROM
> > itself, with the layout being a minor detail, yet the description of
> > its use which you provided is important and welcome
> > 
> 
> Thanks, Konrad, for pointing this out. I’ll update it in the next
> series.

Moreover, I notice that compatible definition is missing for this
EEPROM. I will add it in next series.

-- 
Regards,
Wasim
