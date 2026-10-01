Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4745637AA7D
	for <linux-mmc@vger.kernel.org>; Thu,  1 Oct 2026 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790819848; cv=none; b=BYvDogMYn0E9s8hPoWvAltKUJr6ob/gM6I9wfVhMatVX9/3V3GMDHLklGyUpHrn72d8fh4dH0QOSVmASO7i5Iw3sNKgcggNdvyCADnaqsHev6Ei17J3RPpWsZZRM83ECx9JfRSfv6J6L8ljnvjpZUoMShhbUR6gy9KfYN9f+T4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790819848; c=relaxed/simple;
	bh=dc23h0DAzeahU2YQjWsf1UtM8H72KH4uKWQYNEb1GJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nR1z7qlmT1tR0DitPyihnTI21sSHuaVava8kuu3eV2A/Ajpf/S3cSxs216sC2koY4BLVUG6VeI0Ae86KVqBeH7qS1UQxwZz/yDKuCwZ64c+xrCylUOr2hdEQcn+TKh2494Q/KNmky1+UMfe+miq8PZrJDATbdX6oG0DOYayGDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S50noS3a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B3ugecIW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S50noS3a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B3ugecIW"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6910jtex2099161
	for <linux-mmc@vger.kernel.org>; Thu, 1 Oct 2026 01:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uoVV9AMom/z0Z5MeMxOVZrJn
	fnZMhEF3YGoQPtJPVgc=; b=S50noS3aCk+5o+zo395zaz85DH4dKB/5pNEcwflo
	sOOZu7Jf9Zf4L6f2HIIt2NIOJgaC39THUFZ5YJQLhQ4ZIA/9usI4JfGvnfqc0Asx
	0xG7xi6Lyw8j7eoN2QXXDGurmww8SjMNhIrwf1pzzU6/MY9DDL0mYa/WUwzLZHFG
	g4UtuhHxGQaXLZgYMOuLaVke4M013uQinV4XXShCcGSj49b9X216TkJlJfrLcDEf
	RYCTetkmOpdbhFL5iw41bl7O5SOFH9aLRSRNyUAwQctTN9BoBgAK6UMluDs70FK+
	CdnQXuFv/CLkLPfdszF6bWnckNNhN3iGN6k+73VZ+TnnsQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tjxc8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 01 Oct 2026 01:57:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e82060977so82963385a.1
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 18:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790819843; x=1791424643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uoVV9AMom/z0Z5MeMxOVZrJnfnZMhEF3YGoQPtJPVgc=;
        b=B3ugecIWfPCyYWci1T30GWIM6J45zSEjj6EFH7hpByKPZ0mpcumVoGHtvzVp1SDNG5
         +nszWC1CNppg8jqGiucCc1tqfiKXVjiS7/nrcJxEnfeeFUHcWXLaQi+K7zrR62J3yuk7
         /Tumm5fF9dglVgzqSKgJaN9P7W3z2ebTt6gcnQ9rbiUJdwEj+8r5d3RRenBBFFQUGyke
         FbyXRQx9t7uMe7zUzY6Mei+GwAVyBNe+ZoFvrbUc6ml32FNVKuV3x3C4O3SqEsnwAVju
         ogXESl00SBq9ItVufo/GXeOpmbtPKL9qT8OFETWH0fn2xutE5cZrmJnlvtpeLY2bTy3A
         gjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790819843; x=1791424643;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uoVV9AMom/z0Z5MeMxOVZrJnfnZMhEF3YGoQPtJPVgc=;
        b=J5mhfedDoEdF7bPwMkesTyjomnOwcBYDuQtR3dOIZUICo//er9b020iy4dcG8bbb7X
         ilFjGIznkcgIUcwMudkJHuA9ESUlvO2je8ATyqKn/atCRHueCLRb+Gm4SCg/BaIYghGl
         ytR3oNAj04FYCY7RIwnMxS6LVioD135I/RbQBNoMlHX0lRvvTWDpSfCg8OQeu2u/7Jgf
         Y7sdwNSbGQdM2tOSqlijpaXz0wb+8pR9vGx1/dZwRJUnGYZpIrHrUYTzUb3/Pm7alu/P
         y46C+0smfBiKqZgz6vq9JF/VR5EuuYTl5D/j4JH7j/7yp939XgvE3ep0PF2aVPPPWMx+
         BbDg==
X-Forwarded-Encrypted: i=1; AKwUvByaBnP2kWr0oDa6Qr9WPktsUX8tl1ExQhO683eh/d8d+bfEme+I+SiraAM22jA86qw1y3rRYESI3mw=@vger.kernel.org
X-Gm-Message-State: AFuF++mvQ39459J8/Iywx17AMQZ7cAoJfomJ1xrn18VdtbeY8/LKBHKG
	LV74U6Odt+IEXiyANLnfcCTDlxZ7WP9WgWJTuoTsZtSiJhQDwDrGNOL6nJNp+GKPKrBKW88Kbn5
	xhphfVg8OdZxkEW/IsIvMIxGp4VikEG2iLxAIuCS2zSGHCufzXKwWBTeIqGykslE=
X-Gm-Gg: AYBFou0wJQUacYn3rzB8qpzmjm1tNDFszzFLEj52Nk3nTAnhQu5C28iLOwnyw6MsdZB
	q7W8rQABi9GQLwv+0V5ULHuQR2A+wBTRi4aRFINZLoQNYNE/ftZVvKr2DQR97XvrVBq2RGnMhpI
	zFuQxzbdndUSkEmwWLo8Fa5+zNfqfRI4VHZnzBiAiSq7zte0326oXbB20h6x2tUgo+JBf5AmTGc
	r5WrRhLAwilk2iPB1+EG6nfm1PgFZcgGXuacKb3FuZJfpjU3gbkdZkz2VOkcMTAvUa/iC+s1Ax3
	/JtBjdCPP9bKrhRNdIrdtPv2YS4VBWh5Tm7UPGYEpx/BCDDiVwGAPyUKq2U6WahMAipFhFm+fD3
	EtAshLbGJjLcq0cwYs+pV8J/axrXLk6BmoJtV7uIFMR4WcQCdXc4k1k1+C9qhLqo0XiRuJpqJlZ
	vHSohneuJ5AbdH
X-Received: by 2002:a05:620a:269a:b0:93b:d7a4:9d49 with SMTP id af79cd13be357-93cb5a1468amr287211485a.28.1790819843430;
        Wed, 30 Sep 2026 18:57:23 -0700 (PDT)
X-Received: by 2002:a05:620a:269a:b0:93b:d7a4:9d49 with SMTP id af79cd13be357-93cb5a1468amr287207785a.28.1790819842965;
        Wed, 30 Sep 2026 18:57:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a77192ee13sm12526111fa.30.2026.09.30.18.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 18:57:21 -0700 (PDT)
Date: Thu, 1 Oct 2026 04:57:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: muzafferkadir@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v3 13/19] drm: msm: mdp5: Add MDP5 configuration for
 MSM8952
Message-ID: <diibislcaubtwwazmkjsv4y732har2eskayle5mxpdkr5npana@uckh2yzblzxp>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-13-b96fd3fe298b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-13-b96fd3fe298b@mainlining.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfX5NsQHz5nkPGJ
 5hF2ENOixTRjILDuYgAVeLv6+ipNjx0A8qScSz6r1IvLBQ1eWO6QKRe3Y1U3sO/QtXf3dA5v1zX
 g7zdTWADX7MrZJZ6QoRfC+pp53GMDbA=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abdbe04 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=OuZLqq7tAAAA:8
 a=EUspDBNiAAAA:8 a=YvXxkWmvim7rQlE-Do8A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: yYhDg740OXROLdjxdevfX6hbW_NsQLyr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfX5qSwSn+JYuIp
 98/I3ed7wT/Gcigi1q6RzE4QA1tNi0Nw2uw9U3Go1inIvhKILE0IJVWfvZf1z9cFh2jo88lYxno
 MI3g27XokHX1UG1Ike6p1AzeEQBPPto1wiguebyhKbhpkPoL4f8pHhsvnTmuqeXQmn92mHJn3Kq
 j2LaPVgT2Uam+lJMcmr8SmjUKUn8NcLkdX/GuhIfyXNejyMzwnKUpgBzsN5il1XQhyTNmX93SHt
 6oGcoWbGMcl6d2tDfoVzkFCmjDuRbzZDlj5pUiPy44hNzNpdvTz/xFdpMipQVqhsZG2zjSxv3GO
 RROo9jZkTv3UnpRRBsujDMOZ5hFJViKnNfzxrAXMoSHyqQFoROFMDL+/oogG9HFHxYuZMt9oKYu
 pSPrY/9OXNheM2gZYG5xcy0xb+Ld6UobwW5UAsaectFdLJ4FMSgB5VWRMR9lVHoqOwBnrj/xMLv
 olMQErzvXFNzTypszew==
X-Proofpoint-GUID: yYhDg740OXROLdjxdevfX6hbW_NsQLyr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010007

On Mon, Sep 21, 2026 at 09:19:04PM +0300, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add the mdp5_cfg_hw entry for MDP5 version v1.12 found on MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 81 ++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> +	.pipe_cursor = {
> +		.count = 1,
> +		.base = { 0x440DC },
> +		.caps = MDP_PIPE_CAP_HFLIP	|
> +			MDP_PIPE_CAP_VFLIP	|
> +			MDP_PIPE_CAP_SW_PIX_EXT	|
> +			MDP_PIPE_CAP_CURSOR	|
> +			0,
> +	},

PIPE_CURSOR is invalid and should be dropped. I'll do it while applying.

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
