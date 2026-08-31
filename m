Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39CF4B7148
	for <linux-mmc@vger.kernel.org>; Mon, 31 Aug 2026 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192504; cv=none; b=s1fRSrV3rhpoPWzySMjE8puC79Vn6x3VgbZsoX4ptG74xZGOH5p3tkFJYW83FYRhvSCcp/WBB/NTmKLSUIbWyobcyOjJc6ZWKXazbJ1atCxNGi11r1N3oKCrBofZBdA/MTV8KEJfMDVALfIXNS2OMUx7IHy7Q++SiFnkr5ylzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192504; c=relaxed/simple;
	bh=GIOR13Vau//QjAP6pJ8tBGbxO1q6YYuEw0n2DA0RMB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tanktXtjrTgD9iy1jnYtpVgn86F9aCuuOSoCDYmhjceM4tiiR9kGMjN1FjeHrEqP96B12BTlThRlxRRtBdKK7g7DdLlYEwdAgdYCaowQOHuNbFvTTxqPKcCtTK4zYlyTEVRzUALCZbTGxjiNVUOq+g7fvF2j/ou9OUMXnaRGTHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KBIr3F8a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cB0xVCzU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KBIr3F8a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cB0xVCzU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VFrYGK3891423
	for <linux-mmc@vger.kernel.org>; Mon, 31 Aug 2026 16:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=52UHJM028Rn+QiJdUqrpXvZf
	vhdocUvIr66ANCnExAg=; b=KBIr3F8a+d6CM7H6mBmIEkMo3Wc3Mu45/cGFFZEA
	YCv+i0W5n0zNVo2zkvmEw8J4rcafCSLGyav35ZNUZwZkK8B1klCUkASzG2fDyIp9
	37mcc45bqM0iga7CAIEhTOmtjn0aKWzHTePbo/3cITUKNeZ1FSFbTY6R6RLMbmBB
	0DszzI0J/q04cF+RRZU6auFF1GoyOtDN0VTZ6f7PGrVxpP3KxqZtDdZVBEU3IE9u
	Ikj758URRXgfdKA83a40Y4yonGmJWhtDrBOWGkbpygD4g/iWvghNPno63TS/R5/U
	h6fk91Ecz2nH5y/Qlte25+8W1krKwP5GKYcpZPUTazEyGA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6yasqrp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 31 Aug 2026 16:08:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936e393061dso407983585a.2
        for <linux-mmc@vger.kernel.org>; Mon, 31 Aug 2026 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788192500; x=1788797300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=52UHJM028Rn+QiJdUqrpXvZfvhdocUvIr66ANCnExAg=;
        b=cB0xVCzUyu+b/5PkWWejksqS6kT9U0yGOut8QHjRfFUUG1KzD+a5tz2yPFnr+0ZmdK
         3j8vZGMREHIhErFSpqvk1liVJrwtPi9U0hutoHTwfhMj2tUkt/nbyAnlT3MPdUw8SBM8
         ItiXGGd4ZF6XscPo5LZmpcDuInkFrfN+P5a9OiuqXQ3YeI/mDvh/i1tkcy/nVmn1QIz7
         Q2tZOYoP5JZ0e0dpaBAkpM2Dej+U4OI7L8JwQiyUcldwB5KZPTEnY+XPwJ10ilSZE6Oy
         2CVhfgUGinYJcBMLSz4JBd2N1yQTTT2z09TGfbIxeZOtf0UhxFMIUKJ5G4rPsCZ8JKsl
         BA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788192500; x=1788797300;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=52UHJM028Rn+QiJdUqrpXvZfvhdocUvIr66ANCnExAg=;
        b=MPOJAPcQ4pGqB6aMSFmFfLnL7KEHHHahITAEz3D6gRtmn1I9IgHn6EHbu8K0dlGwUi
         z5FtTBiNP/945CHWArqFKBJ+SZtzosobvnen5pdBTbP3xCq6goGY+UsAizzShv0u0fC2
         SAFdSDu3JuhPK2eLM+ehu5z7T9nWpL2JDQf0i/r63k9bydDlAUvGwQeHqa/1DeMTEYmi
         AdLD4Wsr9wNStGQb0XlqWfADzYYDN2jaxTSyAvYsbveu5NcBYQMJm+vYxl2IS6HsNp0j
         bzlvKoVL3d6nM1omfZSHhqGtt91Fa/OfeyNDtfv+lljEXT/GAmWCo07vr81MIWN5AEoE
         9Xhw==
X-Forwarded-Encrypted: i=1; AHgh+RoQdTE1sRgiQZqTDqS1MqGPGmUwchQLrgDX4ez1HEPPiD0p6bt5htCGLVQ3alQei0u6OdQSlZl7rss=@vger.kernel.org
X-Gm-Message-State: AFuF++k3CfOlHmgvLoLqu57F+xEH5IcjetaMyzbynOaUGG+PUMO4y6tA
	BuEdginWQypZbzIaJh8Vn6j90HfzOotEgxlh7+HCaLet8hjCEY/70ZcJoWiIhiycnmjYnb8G4F6
	ul01aAvvjHacaG7HAnwGEjahTeQWgPhBVJFAtlqf9ByFP9jWVBcy/UyKQEdHnGxA=
X-Gm-Gg: AR+sD12lPlq0l9EbX7wWobzPcote8KnGAxFO9w9nW+4qVwJhfZDjnJMeTYbIzOsAPbo
	ObZurn2Qm+ZpRrYNQ2EcoRrHQiKNyX7YRFDM5jXpamrRRZA6vVIJ8eO63y8k94tVdCSbfTPQ5Uq
	yPMLluy5jruk6fSwu5wYKIFs+G9yWuEIaiG3QlHz8Pu4ozmHmHVS2BCQfIDpqzpx7zqjRsJnyIp
	DSU29+GfQnMYaPkXcrexgzgB1+0i7cfE5E6sukwI1jcjL4FmZB1rOWbvih91PwD/68jfY7czzbt
	38Be82aRmqoqVxOIrOsmxDXQFPeSxoQVKQgSBARD+mIJY8/2r9RUlaDV2n+01oyfjSAQVsETuuv
	hHV4TpkeEClacKg==
X-Received: by 2002:a05:620a:40cb:b0:930:b4f9:f327 with SMTP id af79cd13be357-939138df3d1mr2695992185a.33.1788192500423;
        Mon, 31 Aug 2026 09:08:20 -0700 (PDT)
X-Received: by 2002:a05:620a:40cb:b0:930:b4f9:f327 with SMTP id af79cd13be357-939138df3d1mr2695976285a.33.1788192499764;
        Mon, 31 Aug 2026 09:08:19 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9266be71sm632091255e9.2.2026.08.31.09.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:08:18 -0700 (PDT)
Date: Mon, 31 Aug 2026 19:08:16 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Subject: Re: [PATCH v8 2/3] arm64: dts: qcom: kodiak: enable inline crypto
 engine for SDHC
Message-ID: <uwo6mb7tfgir7k7yig3w4ych5rvx6gex5zzaeyvbjf5uv6coga@srxc4jbphri4>
References: <20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com>
 <20260629-ice_emmc_support-v8-2-1a26e1717b85@oss.qualcomm.com>
 <ba96f5e3-6b6e-40b6-b6c1-300e862e8ee4@oss.qualcomm.com>
 <d3be45ab-0390-4d0e-8d5b-330a48c529a1@oss.qualcomm.com>
 <1a0b91c6-5e17-4330-a8ab-ac14d3339024@oss.qualcomm.com>
 <ffca92db-a3ac-4345-8477-1f53ec61ef16@oss.qualcomm.com>
 <56ab63c3-4288-45f7-bfea-d40046437a9f@oss.qualcomm.com>
 <mwf5hq3gnkesmccede2sa5ni5lyxg3zfnxvwchts2nxh25zndw@uyn4dqehfdpv>
 <b7658f61-17d2-4788-b635-ff2021d2033b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7658f61-17d2-4788-b635-ff2021d2033b@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzOSBTYWx0ZWRfX2OrvfyxwZCrG
 pZ+4DOpTht4dbCHNWVwmzRvOSk8RZTwhvbvUtdECln3FkveQpXIvfc/+eGHCex5FdZLLhYuyPhe
 OuNxPB2i/ifZlNmSRq3YjisruvC6mJQ=
X-Authority-Analysis: v=2.4 cv=CpaPtH4D c=1 sm=1 tr=0 ts=6a95a6f5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=onLGS3NSUnbtietV6iIA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzOSBTYWx0ZWRfX0cWzSMi0giUr
 /V5ORHvzrQevgNFnbEwefBtSsBibIIE6mGFjpjb32N/vi+WNEbt0lLAuW/NZ/uYRCubCJPcCust
 0JUhnl1gnGK1uTgKhL3u0Zm0fh0Hl4zc8lxBTq//TkHavKh9lIFGVzvuLArp4XlpZ3vN06d9kfF
 I/YcYZ1uKcrkJSYP085zv4RWg2hRiA99XDzuupkrBvSfWWtXOyshCA+gvQMzy76IFUZ4JImSEfK
 /ITtHqjDMBRkP1M8N/o8AsnvNPm8EwbFpYXGUob95/gYhKXQUoOIlsBQXT71ntAQlWJF53hkaZh
 K1pHSLjur8T/8Gv/RZP+9vDklpcw5sAio+GNEMSyB9tpf9Oe+wRLSNH9UPWTdloDzao8LJVjEdE
 sOOK6WZw9ALn99pHPRss7PLymSczk43DTitm2h5a0z8GOfRw8vokJLsstyc4k6ntgzL9UcKrdZK
 PNxB2vZEzRxu62Aq1iw==
X-Proofpoint-ORIG-GUID: a3RsodwW-NxOkCTNXqpEK4lvmuxwG6h0
X-Proofpoint-GUID: a3RsodwW-NxOkCTNXqpEK4lvmuxwG6h0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310139

On 26-08-28 21:07:24, Konrad Dybcio wrote:
> On 8/28/26 2:57 PM, Abel Vesa wrote:
> > On 26-06-30 13:25:13, Konrad Dybcio wrote:
> >> On 6/30/26 12:23 PM, Kuldeep Singh wrote:
> >>>> qcom_ice_probe()
> >>>>   -> qcom_ice_create()
> >>>>     -> devm_clk_get_optional_enabled()
> 
> [...]
> 
> >> On the developer/customer experience side, would you expect having to
> >> manually enable what's essentially a sub-feature of the storage media
> >> on every single board?
> > 
> > Wait, don't we do that for display nodes anyway ?
> > 
> > Also there might be a case where you just don't want the ICE enabled.
> 
> I can think of literally none..
> 
> > So I suggest we disable the ICE by default and enable it only on boards
> > where there is a consumer.
> > 
> > We don't normally leave stuff enabled just because runtime PM will
> > disabled it for us.
> 
> We should because the hardware is in a state that's otherwise unknown
> to Linux, I've been trying to push that forward, but many things
> currently can't be enabled without side effects.

So interestingly, on Eliza at least, ICE isn't left powered by the
bootloader. Are you saying that, in general, bootloader leaves things
enabled on Qualcomm platforms? I'm assuming that would be ABL that does
that, right?

> 
> With the right drivers in place, the hw can be safely powered off or
> at least parked, instead of letting it spin in whatever state the
> bootloader has left it in.

I understand that point, however, this kinda makes the ICE a one-off.
We do not do that for mdss DSI/DP controllers/PHYs on boards without
display, right?

Not to mention that, on an end user device, the ICE driver would have
to be provided as module for the sole purpose of powering it down. It
doesn't make sense.
