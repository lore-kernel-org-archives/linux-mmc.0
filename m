Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D648A3BD65A
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717197; cv=none; b=HCInlVTpUN/jq8yRYwqu6ouiEasQDbsJGtsTfBoxsuuINibAt6wyCj6LyauQ5ICOCNsKghTbLLyIyHNUMOtXelkmh9NwgIMUW8Olit15y2PW0OEeQ9KeUMXU27ZSmVrmeFT5cvvpBAyiwNrZ4arRvPn4RsLNqv0OIpNEH833jbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717197; c=relaxed/simple;
	bh=KZHUaZvEKFxXtS7kRf+MZVbK87nbFyB1YcBL0fZT7sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIC5RYqS3jMcTe/g+LhLjwE40k05mgzgt6yPYpe4Jr53JjbpdQJE0jJrqISMLPFOGXk4mOSvUMyMFrGXY3r4Y1oOBxCIQt69ki3gSNncunhgC1NDC48h2dBdihdGKmw08iRTYGLDL5qAb4r3MbBuYxLO0B7XQcCdXw73N2Kp7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PrsjYO+b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XoP+BCXq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PrsjYO+b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XoP+BCXq"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T72bQI2163943
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 07:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DpBPb27RIWIwXmB/JzvE9Nff
	dB3sd81CybJo2XPwfZA=; b=PrsjYO+bFn0aUg7xZxYo9mcccrZ2ffRVpawmmtH9
	SdYyX78TcWCxyE58uEq3zmWsxg5KbFnDcARD19BqLRuhLmkF2NSnNEwIKU1JTv9q
	A7ex8X1GKgnn0+aPysr0k+QJpnoSAsbLeJCcr76F6Nfxr7P5o3hy2+9kCV7hocy8
	mtrsnfHJ1nSd7Qa0QlBiIibdKGzlSGNxPApQerTu+v45nTjqxR492DVYmXArCrTi
	wxSGixsiquzYOerCEvC45kzNzGZoMigxS1FKmYQ7/k/0ytZhXA5mzfFjtPZVhfj7
	d+S2C6n6CRvzJDKHw9a7FdwbRKlsxcyAxvTsD2pUW+TFCA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kyjg1jc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 07:13:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c9b71388fbso23572815ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 00:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782717194; x=1783321994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DpBPb27RIWIwXmB/JzvE9NffdB3sd81CybJo2XPwfZA=;
        b=XoP+BCXqJzF3P7vAZmds0iA6lTGoIjMA3f/eoEpPfuWzJQvtzt3lC1YGm++9ZKtxQ0
         bTilcWqYJlkw6kg/YTmVf0q869vCi34n+Z3b1SbzQkbnpbR0X4MYaGgzT/309Fp2j4QW
         XIY2OWwTEeejPg2W7LjyFiavx5hrHOy1F85Js7Jrx+SHImm1/byQQjCswykkn0/kqx3H
         TBTuTA5r077XuRjSDDcsmBzavp6zoJBlB/EnEmAM3ik80wDn/+Xg1akw/c/hbv4RXFx3
         iiSyT+eOXMS5avgKpxVoTrtrJ507ZGbUmf4lwKovGVXsKZuk0CDguCYq9whnt1Bdg4DB
         t8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782717194; x=1783321994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpBPb27RIWIwXmB/JzvE9NffdB3sd81CybJo2XPwfZA=;
        b=CVa4XN8cVvFBsxxcel7EWHpSosOse6IFfyv0pOGsgwBWVWlzyfzLRJvbTrBaI8A58V
         HuXfbnEnzOANAjmuFNBwJx+YPADTXXTSzcJ60xH6Yy6Oeazo4A5y9cj8Lw1KWAOEc/qg
         y0tgpulKjx/vo3aDUdGbPnqJqBglkxrvsA5zL48NE4EQ7Q3KAaXgudJjzOgQXawBdJsH
         PDxWdXaIgusA+1xbqqm1dI91ks7aNiA4CvZtxWp+HwKJJzZcZCzFSrWHkWTQ6oIsG/9Y
         YGEzZz+C7xR3Mrwo5EDL3ozOeyEmkvMetxw0pzFU6PWCplPDUSFBgneE2FnixK4JDeh5
         tTzw==
X-Forwarded-Encrypted: i=1; AHgh+RoQFp/57QV7FoagL4sgJ6NtyiDfnH2B7CvfXojv5xXi9riW86n9Ove7ux716hu4zMUjh58B6gUp0sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgA2lgWgeX9eeRj8mws7FwkTMy7DagEolFeuliXfD3DXfYukW5
	717gfpdcH5apxYVT7oJM7loTzrP9Ad64ovb2SIc001idO0WS6RHASj51B3G2M+p2P5vtDxdsbH7
	tFkYll5SCBgu1lqii9CW9L3ignNfT/kDEplaiu3PcFdmdpT95e6s1/R/g05x6WGk=
X-Gm-Gg: AfdE7cmmh5pbskPJYkVsMosxhubW6gJeHxWUv92BVxe7kYoKzBp06EAqkMtflxpAR/j
	CuhDDPIAzELEB5Vc9kdeKjSeuvylvLQoBY/kLQT2JHNk64+NafHTIP5TNfrGfSZXDW4Dgeu3fhG
	1Xz6V8I0CHvM5zKuEa2YKsHp+AagEhdYOFyKmFIcALpaHbqVvN7f3sEvF1Sf9qZSbU+TALzc+da
	J0A/pUeMvY//7/J/iRszYEPG0pS6trcWRm0b//+T6NojUbUGDbYZ1TlWJtvo/6UJxcE2zfVnvWc
	ZCjKoVAeBdZhdq1GPgBkiC7ctg6MzoFFgnhF18bDnClVvVxyXy5z8Faeiw9VwlMDuhd99HXKRMN
	+fnmzqcrRlWHGWWAjWwZXE0yw1qmomgRZv4ZbeOFkMEdiZw==
X-Received: by 2002:a17:903:2b03:b0:2c9:b396:1a55 with SMTP id d9443c01a7336-2c9b3961fa6mr64038545ad.12.1782717193879;
        Mon, 29 Jun 2026 00:13:13 -0700 (PDT)
X-Received: by 2002:a17:903:2b03:b0:2c9:b396:1a55 with SMTP id d9443c01a7336-2c9b3961fa6mr64038315ad.12.1782717193458;
        Mon, 29 Jun 2026 00:13:13 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c8255602fcsm54177235ad.60.2026.06.29.00.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 00:13:12 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:43:05 +0530
From: Monish Chunara <monish.chunara@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        Kernel Team <kernel@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-mmc@vger.kernel.org,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH V1 0/2] arm64: dts: qcom: Shikra SD Card support
Message-ID: <akIbARuf3lMAg6rj@hu-mchunara-hyd.qualcomm.com>
References: <20260604122045.494712-1-monish.chunara@oss.qualcomm.com>
 <boo7p6mgop7rarfu3rfsrfah6eq7zp6y3sf6mdq3hsejtacwxx@yl543m4lj47d>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <boo7p6mgop7rarfu3rfsrfah6eq7zp6y3sf6mdq3hsejtacwxx@yl543m4lj47d>
X-Proofpoint-GUID: TyITyRKw7Ca_EUEdCWQUxnRm4v_vzbp0
X-Proofpoint-ORIG-GUID: TyITyRKw7Ca_EUEdCWQUxnRm4v_vzbp0
X-Authority-Analysis: v=2.4 cv=Ftk1OWrq c=1 sm=1 tr=0 ts=6a421b0a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BkqjwfLYJ-8FfuLtd5sA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2MCBTYWx0ZWRfXzqi6F3+Tdnzh
 AeOb+aez4hcOi9lSsdbmyLfMx6sm2Cyfb5ggbZFfYa937ufbHrAQ+4j+7iu42ZW2XQXXKIfEjjd
 psBWJDLap+zrSAPhNK7F3OhBFk0nDsQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2MCBTYWx0ZWRfXzqBv2N6jdO+f
 5E4k1mldbAu5xqtagiU2qUxpMi6wZlFP6IzhcbfkmVT2iPAQo5QgGzKpKxn48lhFkSJgGvWZAdK
 3XAqsHh06xC3TUGtrx3lCMlgG9WuBsIH3KAzYmsRASizQlzhiXs5knvxUqf0fOXvxxCtj1TMdq0
 PWHEapO6eMUvQ7DhThCzQWsQwYvHRIOOuTbagQ09ellzaUu8OF/7I1Qggv/n2n5I3luCGnoAQwi
 NH5l4ixZVG5kBmEk9kAzu4tzDzy8WCNJ6LqIWR01cb5n2pepGZLbYMI8fo4A7N6y3xUvZCzDxAu
 wWKu/t9QIEL7FeJuycyAGTp+xygWv2oYQboG4w4L6j85EmqQ3XfOz0vBYspv2nXujuIOKcg7qZJ
 ESi95RhfHErLLcHUV1OH7e/ECfgMJ6UZTrfImPjK0K9Erv5zEHuf4nzEsa406upD7zFTERdHbQN
 jM01xZZUJftsGuPrtgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290060

On Tue, Jun 16, 2026 at 03:54:56AM +0300, Dmitry Baryshkov wrote:
> On Thu, Jun 04, 2026 at 05:50:43PM +0530, Monish Chunara wrote:
> > This series adds SD card support for the Shikra platform.
> > 
> > The first patch adds the SDHC2 controller node and the necessary pinctrl
> > configurations to the base Shikra SoC dtsi. The second patch enables 
> > this support on the Shikra EVK (CQS, CQM, and IQS variants) by defining
> > the regulator supplies and the card detection GPIO.
> > 
> > Testing:
> > - Validated on Shikra EVK variants.
> > 
> > This series depends on:
> > - https://lore.kernel.org/all/20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com/
> > - https://lore.kernel.org/all/20260521-shikra-rproc-v3-0-2fca0bbe1ad7@oss.qualcomm.com/
> > - https://lore.kernel.org/linux-devicetree/20260513-tsens_binding-v1-1-1780c6a6caf2@oss.qualcomm.com/
> 
> If the SD card depends on remote proc, tsens or cpufreq, then something
> is wrong. Maybe, the way the serieas are organized and sent.

There is no technical dependency on tsens for SD card. The mentioned dependency
series was to ensure the changes get picked up without conflicts.

In the next patch series, only the actual dependenices will be mentioned in the
cover letter.

Regards,
Monish 

