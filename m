Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC131A682B
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2026 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781571305; cv=none; b=jJ3aqw419rOa6MMbde0mE5K1Uo3fIwnBa9Li6ojyrHeDvy0quWmJ/xQ4TulI6UZkh9/MAB3u2lb3w0xGuCvQSA5X5BmK4ZCXqReeCNq72xpcFAqJgNDDg+22w8YzI2ATiFQz8210NZOf6Wdeph72ZwSji0/kbHAabQFaKZtzd5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781571305; c=relaxed/simple;
	bh=SJ31mK3JQy19OP0EvfHyWXGR1AXAJ6g/2vEzJhFf/js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRK/MQgcIdsCjplkZrHN0BlX9L7esau6puuHZPnk8rMGjEZ4K4jnZazijQTiHSoRxIw88L9jf28xW7n5fHKiRq2/ED57lO9hzy/gVhjK8WSrx+rBZMG+fVnkIXfonHFjv6Y59j+fo//WRfuLZ9Kmkp2b9kUPR+qohjAegk2BkTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TYkLzOHt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LfaGyFP8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TYkLzOHt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LfaGyFP8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G0OJaH1485188
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2026 00:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bfH1YFfB8DVE548OmEdzvoO2
	Sfl2pDVWRVr/GFOchFI=; b=TYkLzOHtjzBiErwXALB1Dtk0csLDCxfFkRoQbiUK
	1lNAL8oCGQ35BWqBCa+ot6DYGNZSitul+QeXeViMXgnkZxpqDiKcy/0BZeXJEN2L
	cIvAD1aWbzYsuBN5teBejW90E+x5NRObKUThM4xwyJlizsaTQ//F6HWl4PlvMOk3
	qmZ0CNkrXNt6wSneaisyzRpxyaWPWN/jy2QTSE9QU8cJVgnxRw48ltOx/8oug5z4
	rO+dH29NaDmjURZxmspmmqiAGzYvvVoHtTxiVX7GWZwGtTdCpTMyvBxq0o23mR55
	32Qpe+eakA5qohbjufOjtKgQ15NR/lHkn6FMqaPBZE68LQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjuw3a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2026 00:55:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9159c4b210aso646170485a.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2026 17:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781571302; x=1782176102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bfH1YFfB8DVE548OmEdzvoO2Sfl2pDVWRVr/GFOchFI=;
        b=LfaGyFP83crTX9PBS7u21/1V991zGIRjb9pIRWEhqEEHHH8auM+Ue6RrKfXe+W4Bqy
         1kZCZTVpRa58HYVapKv3C6Omr+RlrZHNB/AKL4H+ZWN7t9OO4B1MZvJlAm+O+YmNsrSk
         2Q0G98WnSzyWUV7KsjjArr762YBJM+R5N3oLOIfyY9aU2deeTHLevxdTfC1SJ5/8lfqV
         yi8Ytrv3cGGeNgd12uGBg3Dz0Gp6/C0u1osDpRkKTXfO8ThSWXhGbasqXHCHSxGw0bil
         X6U+JyZm2nusNPG/B15NaNl4M6QDGINVE1uhrYVPH6SuS7HFdCokogdvF/dsdDg9UGFx
         gjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781571302; x=1782176102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfH1YFfB8DVE548OmEdzvoO2Sfl2pDVWRVr/GFOchFI=;
        b=lWSABa0w0jAYNbEzxC8JU0KT3MvPOuc8PO/vcSLKtTskbOCDC3Uypul0TOepNqbepw
         dejkdnZnVFLKP3lE9jsK824EjVWyje1UwPxCYu93zqlfLny98U19dtcBTTFbf6pKrbpz
         MWrkgnY6KjDDQI4VgrFGeUflSJb2UaK0H2dQqto+MnOcWX0/MVDJqYUTjsuoVK/nIGml
         M4E32K65gPvI2zcku/mpM1Q7sMH6aS4aEUw2Sxe48nNXmhxNjOgGqBQJtHeS3NxZ0Ogs
         WcHPFpqHJOKBsmrqfXjStzcncO7lL/6kLYwWMeepZmb4E8brla3wE4cQwEHls6MguG/o
         KLDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/uXgFgt5VRShFyqzqT8TzFgM5/dtSI/Cs/4OY9pUR0642hIZn78+XDU8TM47oxCxAasICspmLQRSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDgi565D0sfQLq2mCgVufA9Nj0DRUL+HK8pPbQgdPf46BNNG/x
	wjUpb1reo5ebCA/FBucasZ1aV9Rgj+PUWEf3areKllw/JVClQLdbXWo2aP7j3MI8XWN6+8N5cfn
	vr0BqWxFytj8MAwt1+ctQjRZudFOKbP3h9Acab+NbVWsfVhyUQRuexRAaHbg5e+w=
X-Gm-Gg: Acq92OEI7eJCyhSnXA8DFzM6tlXe5gqgO535i7et/W9QhF54MGRVfTJZVNlcepWlBUp
	kMiziVhwRyY/rj7nPOzb04LStFM9dmIqbWMIKDzL0z+40QLD5b6MrKZnid18HUKAWCzbzuv3a0a
	lSC+ExaJtAa7jzMJcCOjzHm4uz1EpoIfv4GuGGUKkJ3KYDshf+kAQNQ0z1rDuDdZl1VUCtXRKjN
	edEfRdFO35fzx7fNzPsaUKxHaRgpYdK9NxIn6uHHaG5tYm5NqASs9QNE6RQDXohRzIsszRvxXx8
	WgTPlCUDTso0EM8yXXCEK7zrLMlLQNyTI059oSrrkGg6LsvGnyJIoaLJYexeBX5sEhYMGVOx+Xc
	G6odKiGKIzCUlTPHY58g6Fmx1HdIPhf8zL8n34uTVZXud4O0zR/OMA4qZrvX1ZIRmKfF2Kt6Mn2
	tro4RKFXGN6GPz79qG7vdn1PvhBi+OTuWoO94=
X-Received: by 2002:a05:620a:2985:b0:915:29cd:306c with SMTP id af79cd13be357-91c2c4d288bmr257335385a.9.1781571302549;
        Mon, 15 Jun 2026 17:55:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2985:b0:915:29cd:306c with SMTP id af79cd13be357-91c2c4d288bmr257331585a.9.1781571302114;
        Mon, 15 Jun 2026 17:55:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e161f2fsm3158366e87.11.2026.06.15.17.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:54:59 -0700 (PDT)
Date: Tue, 16 Jun 2026 03:54:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Monish Chunara <monish.chunara@oss.qualcomm.com>
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
Message-ID: <boo7p6mgop7rarfu3rfsrfah6eq7zp6y3sf6mdq3hsejtacwxx@yl543m4lj47d>
References: <20260604122045.494712-1-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604122045.494712-1-monish.chunara@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwNiBTYWx0ZWRfX7s2hlUy3m0+/
 lPCjeflasiaSnjrpFU2RcpwJnXhg8qtJEkP6YGvGukXISaqcXugPm7mnhRZ6PFW3IpRDjjvD8Nu
 VdqjBISwInma2IQ7haFqU/V+grJ2k4XbJVAcJRCLMPi7s0eRKBP94MfqcIXOfH3sT8l7dRhPcH/
 ijKQTM6nCf6DGXzbe8xR1dcVyz4MnF69w6WVT5p5q3rnAA+nKdQ1SYBvifr8Wy1Vg/w9HIbcBdh
 k7l3XaGmQM7ligVgI6zA/OUHYcuYf6PWBkqZ1A5t0u0TAWCkEOvYc5yKCa2/1H5ndJ0Q0rTa0OU
 hCyJXmEcZSDFga+5TEXdP9kyBFsrZPMhkRq4SOGJuc7z50kuMEsgBafel0DZrF4eX9Q6CbDqs1R
 o05elLn2ZWan1FyrV/cGre40WG+nYxSfEcAWMhiDbuYgdOOC32oFW0pihyAbqfmK0kAKmhXun4D
 bm2z/6quvCbz8I5+HFA==
X-Proofpoint-ORIG-GUID: B0EiU3l1xOSvQvddwMSiqTButTZrDLOo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwNiBTYWx0ZWRfXySCGpoLyxFx9
 iy77vvBLNg/e8vjWY+XmJUggdF6+pruIvkt3E4upJoYKQEXmGR95qYB9p+2dQnJL79TWxGRGgjT
 V/oodbqH85/U0iWASc79n7Du/w98dus=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a309ee7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Sqa3oZAXkj-0WgPsOd0A:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: B0EiU3l1xOSvQvddwMSiqTButTZrDLOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160006

On Thu, Jun 04, 2026 at 05:50:43PM +0530, Monish Chunara wrote:
> This series adds SD card support for the Shikra platform.
> 
> The first patch adds the SDHC2 controller node and the necessary pinctrl
> configurations to the base Shikra SoC dtsi. The second patch enables 
> this support on the Shikra EVK (CQS, CQM, and IQS variants) by defining
> the regulator supplies and the card detection GPIO.
> 
> Testing:
> - Validated on Shikra EVK variants.
> 
> This series depends on:
> - https://lore.kernel.org/all/20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com/
> - https://lore.kernel.org/all/20260521-shikra-rproc-v3-0-2fca0bbe1ad7@oss.qualcomm.com/
> - https://lore.kernel.org/linux-devicetree/20260513-tsens_binding-v1-1-1780c6a6caf2@oss.qualcomm.com/

If the SD card depends on remote proc, tsens or cpufreq, then something
is wrong. Maybe, the way the serieas are organized and sent.

> - https://lore.kernel.org/all/20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com/
> - https://lore.kernel.org/all/20260522-shikra-cpufreq-scaling-v4-0-f042a25896c5@oss.qualcomm.com/
> - https://lore.kernel.org/all/20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com/
> 
> Monish Chunara (2):
>   arm64: dts: qcom: Add SD Card support for Shikra SoC
>   arm64: dts: qcom: Enable SD card for Shikra EVK
> 
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 18 ++++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 18 ++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 18 ++++
>  arch/arm64/boot/dts/qcom/shikra.dtsi        | 93 +++++++++++++++++++++
>  4 files changed, 147 insertions(+)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
