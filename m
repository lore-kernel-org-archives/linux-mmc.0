Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC24E230BF6
	for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377113; cv=none; b=JdkoJU3i7+5dA4ctQZUF3nkJ+O5k5+c1FBZa4S6jNuD6qYegDU5XH0hfcw40evBm/hGHgzWPFQPTUFTNH0JQKXPPeKtPhsj2vkxKOOI3GEJwEEYA7tOO2BSDvAB2YGY7OSWob/In+WX6Q+bs1W0A98YJnGSLNEqR6mgqNqjhw9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377113; c=relaxed/simple;
	bh=tMosiq+ds7fp5y+WKEytetzY4ZZNGU0P/rB2j6Ht9Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpqbuoXutTDK9XZbrESd0HiAicV4NzqFWkO5sUpfJcOGYGz4PuNssL7knLpoTWkS7EfGdh5zfhsofC82cdiuEcAi4MdL5iPIO+GWzernmcx63QDsf9orTlixk6jmaCRaW+7pvL3pmb81hMxRcCAGLHp9MFRpVzKxGs7f+3OoblY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OSAIudBw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OSAIudBw"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5jdVS023204
	for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 10:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l9WiOKIOlKJ7PLAZcqgHAvc4Wt1A+B1/zu8MBNbx8lw=; b=OSAIudBwJveiw/KV
	bOkh+Lon975z9UF0xiN2gKFOLlWcReO3R8+asuYkddXIDIhyIBADKZq0IP4RJmqD
	cHGfOch2wRBKkyDfhAd8sud7zxYGe4HQ0ywkkBFkHqoBK7bbj18VJrVy2QRjZoYq
	HoemJuTYDzEviS0XVVzqdIIBK8OEsopK+/qlk1KUtcwTOzuxwbKj2uMmAE9rkdp9
	MZRxzYNAg2Vz7oErr9wdf4OonV60WjSMUnTv9aWt/CYneMnDut6zQfJBjv6quu5l
	ypEy4f+KJl5EWmzw+xpznHGm5a5ujNH2smyh+uVIkNGv6ZNxBPzRaGA5ZJfuaN/U
	gHou4w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5qp7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 10:31:50 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70ddadde46bso17852566d6.2
        for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 03:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756377110; x=1756981910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9WiOKIOlKJ7PLAZcqgHAvc4Wt1A+B1/zu8MBNbx8lw=;
        b=ZevqscfXBKxSWk3ilvWB0Prm/yltyZzoYGBKDMyAEjk+4XKHRd1hVvxhs8pl3msmpk
         ZYPcxRCk7Pk0w2Wtbfj3anRrk1xPpWuZXzHDyyhm7cZ/7QgGuIcHBGA1mVjuiJ8y76rW
         P+0JKC5FWsLlKy95mgfG8rRh1GfEbBm8B6rLKxTngoejo6AYX7EDH4VbDdrfCPPBMGo+
         P9oTHB6b5xL8Or5uQNhsPLNLDYoNL7Xeo3kqxJCg3p3XDKSKCgNAQwh7QaVbUnhaWLQc
         uSx4q+CfjGGQV0nzOIP811IuzUUSpNB9H5Bd3e8M2wTD33edtWcv1KoMUx7tYj9fPfAA
         dHJg==
X-Forwarded-Encrypted: i=1; AJvYcCUa+6AK07bxuoJg9isapIQBfKPQVSnA4VQKQ78BsCa7LJCf4IpcdILQkrEmQMckLoJLiE5HKCo8AXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya3P0I1kme04iVF3ZokAFKPSsEx8ctZfMBmhCHF+ZkRKCa7vZY
	DUruV6yQcbxDkzCDfTBdMh7zzPBmkqRWNueTyzY28xV9bwKUiuQzXFcKQPcJzAnQd8wpAB55m27
	YUcOer16/63TDyI0LsVoyv6jvVLX3VsEB5Prm3/sN0SAgb+JHups5FL3ApwEfUJ8=
X-Gm-Gg: ASbGnct9WLykFVkskglAPHzxG00hAww6TwrEJ/i5cgvekVY9dt7tnvw66GkwNF8wV25
	tHzJKnMuafnHONFmaDNkqL5TB7Q3U/F+H6Ymhsie/4s96F3z+hQ44CpG0n5vLtu3p4/SX6if3Jo
	BgiAY+ndHYYSu7C63pnjRJx2/fDEfgQuF/NiulpxxyJJjNV84GReDbxZXjspE2M4gQLcxxVWja8
	PUMqCMGAkFp7WhxR982P5wxmzM+lKKEaJsNFRhldbo4pfs0l0CFrWvKRNoEnhyJ1UQ9zrJ6jJY3
	MjuzpecF18ewPCO43XOtFtTKA33lXYbXyFKi5hvOjSyKN6tAD7Vd++bnvb9itjSm993/8TjRKmy
	JsCjUnaysW0jMOanGXuibOpGBqXOJUXJnLa6ipyFjOvhxW6hrXs0z
X-Received: by 2002:a05:6214:ca9:b0:705:c148:26a0 with SMTP id 6a1803df08f44-70d971e4c3cmr256141156d6.31.1756377109641;
        Thu, 28 Aug 2025 03:31:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGabGDuV7RH7XtiHw/GVFS0TL++vOcS9epnGu7rG9+RKZF6r7predeBwqVI57sChDQW8QANRg==
X-Received: by 2002:a05:6214:ca9:b0:705:c148:26a0 with SMTP id 6a1803df08f44-70d971e4c3cmr256140626d6.31.1756377109029;
        Thu, 28 Aug 2025 03:31:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c0221dsm3168701e87.7.2025.08.28.03.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:31:48 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:31:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sachin Gupta <quic_sachgupt@quicinc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_mapa@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sartgarg@quicinc.com
Subject: Re: [PATCH V2 2/2] mmc: sdhci-msm: Rectify DLL programming sequence
 for SDCC
Message-ID: <nvgm2jeyhabxdhurcflc2gu4vdk2zjfoba22mc6j3d7azxdicz@ln5pu676b3lf>
References: <769268c2-9a7f-4b6e-aabd-a6cf5a744d5b@quicinc.com>
 <d5ykzwuk3wrwycol3wpeontfp5t7h7vfrfcxnmxei3qs74xsp7@ihtzne5wbytf>
 <81323b02-a7be-847a-b973-ca0cdb906558@quicinc.com>
 <p7o2ykmpghx5jqagpkhd2rfqgizcdagn366rltyn4gmbmnmpje@vcygaqcaowkn>
 <82d11cf6-bfed-9b73-c697-c692d1c7e02d@quicinc.com>
 <1f910d65-de34-424d-adf9-7669c22afeaa@oss.qualcomm.com>
 <bb85f33a-17e4-3c7f-57ce-c4d67b7d655b@quicinc.com>
 <jybd2m25jtg35yocf77e23ytbvrlt5d2f6jjscdyxilpk75tx3@na3u4h2vdweu>
 <ec1b0c96-3069-5937-7bc4-cbce0a4c4ec2@quicinc.com>
 <335a0397-59e3-ad65-5e75-0bb7f399be66@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <335a0397-59e3-ad65-5e75-0bb7f399be66@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX+luW1Ha+4zWL
 nroD5ouiW1CARZ4SwORZFFaxiR0Qz6YT2XrwDoRvwfXD3WW6d2VeLFlEsPnEu3dOU7yPKp1QoeI
 vjtiGrsc2hi34ON+uq6wVwOmC0c1ZFuyT1+vqL23knLCzKsee0WuHrhlZHEFX6kabAbFkQzdZ8H
 OcmsTVrJwBKwFeJAtEd1QjKR1sKzHwb8/BTgUtpnzNbHZpGHF16gJsMzbTzPmGsdwmTEsZyP7Fq
 Anp7afSpsG//eJIiQHqZ9Ms/BvKC4/HEHmyZPB4WtoVkuXQ2WCuX9mGTSzsDZm8Ey65cokprXY5
 JRYhN8iNZRbFNgH6TJn3pWkBY3DhtumK4oEoN5lKjwHvfuk4F4AGP3dsBfCzC92RJmOu5Ou16R5
 RH6624Xd
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68b03016 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=DmG7qftGFCsyeU4zcA4A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: S4hppXbmtfN-WclcMciXl3MQI3yt0CTl
X-Proofpoint-ORIG-GUID: S4hppXbmtfN-WclcMciXl3MQI3yt0CTl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Thu, Aug 28, 2025 at 01:30:21PM +0530, Ram Prakash Gupta wrote:
> 
> On 8/21/2025 7:45 PM, Ram Prakash Gupta wrote:
> > On 8/9/2025 3:10 PM, Dmitry Baryshkov wrote:
> >> On Thu, Aug 07, 2025 at 01:28:28AM +0530, Ram Prakash Gupta wrote:
> >>> On 7/31/2025 7:49 PM, Dmitry Baryshkov wrote:
> >>>> On 31/07/2025 14:46, Ram Prakash Gupta wrote:
> >>>>> On 7/30/2025 11:26 PM, Dmitry Baryshkov wrote:
> >>>>>> On Wed, Jul 23, 2025 at 03:43:37PM +0530, Ram Prakash Gupta wrote:
> >>>>>>> On 1/22/2025 3:20 PM, Dmitry Baryshkov wrote:
> >>>>>>>> On Wed, Jan 22, 2025 at 02:57:59PM +0530, Sachin Gupta wrote:
> >>>>>>>>> On 1/7/2025 8:38 PM, Dmitry Baryshkov wrote:
> >>>>>>>>>> On Tue, Jan 07, 2025 at 11:13:32AM +0530, Sachin Gupta wrote:
> >>>>>>>>>>> On 12/27/2024 12:23 AM, Dmitry Baryshkov wrote:
> >>>>>>>>>>>> On Thu, Dec 26, 2024 at 11:22:40AM +0530, Sachin Gupta wrote:
> >>>>>>>>>>>>> On 12/19/2024 11:24 AM, Dmitry Baryshkov wrote:
> >>>>>>>>>>>>>> On Wed, Dec 18, 2024 at 02:40:57PM +0530, Sachin Gupta wrote:
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +static unsigned int sdhci_msm_get_clk_rate(struct sdhci_host *host, u32 req_clk)
> >>>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>>> +    struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >>>>>>>>>>>>>>> +    struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> >>>>>>>>>>>>>>> +    struct clk *core_clk = msm_host->bulk_clks[0].clk;
> >>>>>>>>>>>>>>> +    unsigned int sup_clk;
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +    if (req_clk < sdhci_msm_get_min_clock(host))
> >>>>>>>>>>>>>>> +        return sdhci_msm_get_min_clock(host);
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +    sup_clk = clk_round_rate(core_clk, clk_get_rate(core_clk));
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +    if (host->clock != msm_host->clk_rate)
> >>>>>>>>>>>>>>> +        sup_clk = sup_clk / 2;
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +    return sup_clk;
> >>>>>>>>>>>>>> Why?
> >>>>>>>>>>>>> Sorry, I did not understand your question. Can you please explain in detail.
> >>>>>>>>>>>> Please explain the maths. You get the rate from the clock, then you
> >>>>>>>>>>>> round it, but it is the rate that has just been returned, so there
> >>>>>>>>>>>> should be no need to round it. And after that there a division by two
> >>>>>>>>>>>> for some reason. So I've asked for an explanation for that code.
> >>>>>>>>>>>>
> >>>>>>>>>>> clk_round_rate is used in case of over clocking issue we can round it to the
> >>>>>>>>>>> usable frequency.
> >>>>>>>>>> If it is a frequency _returned_ by the clock driver, why do you need to
> >>>>>>>>>> round it? It sounds like that freq should be usable anyway.
> >>>>>>>>>>
> >>>>>>>>> I agree, rounding will be taken care by clock driver. Will remove in my next
> >>>>>>>>> patch.
> >>>>>>>>>
> >>>>>>>>>>> Divide by 2 is used as for HS400 the tuning happens in
> >>>>>>>>>>> HS200 mode only so to update the frequency to 192 Mhz.
> >>>>>>>>>> Again, is it really 192 MHz? Or 19.2 MHz?
> >>>>>>>>>> Also if it is for HS400, then shouldn't /2 be limited to that mode?
> >>>>>>>>>>
> >>>>>>>>> Yes, It is 192 MHz.
> >>>>>>>> Good, thanks for the confirmation.
> >>>>>>>>
> >>>>>>>>> As part of eMMC Init, driver will try to init with the best mode supported
> >>>>>>>>> by controller and device. In this case it is HS400 mode, But as part of
> >>>>>>>>> HS400 mode, we perform Tuning in HS200 mode only where we need to configure
> >>>>>>>>> half of the clock.
> >>>>>>>> This isn't an answer to the question. Let me rephrase it for you: if the
> >>>>>>>> /2 is only used for HS400, why should it be attempted in all other
> >>>>>>>> modes? Please limit the /2 just to HS400.
> >>>>>>> Hi Dmitry,
> >>>>>>>
> >>>>>>> like updated earlier by Sachin, HS400 tuning happens in HS200 mode, so if
> >>>>>>> we try to use "ios->timing == MMC_TIMING_MMC_HS400" that wont help, as at
> >>>>>>> this stage timing can be MMC_TIMING_MMC_HS200/MMC_TIMING_MMC_HS400 for
> >>>>>>> hs200 tuning and hs400 selection. In this case we must divide clk by 2
> >>>>>>> to get 192MHz and we find this as host->clock wont be equal to
> >>>>>>> msm_host->clk_rate.
> >>>>>> What are host->clock and msm_host->clk_rate at this point?
> >>>>>> What is the host->flags value? See sdhci_msm_hc_select_mode().
> >>>>> There are 2 paths which are traced to this function when card initializes
> >>>>> in HS400 mode, please consider below call stack in 2 paths
> >>>>>
> >>>>> sdhci_msm_configure_dll
> >>>>> sdhci_msm_dll_config
> >>>>> sdhci_msm_execute_tuning
> >>>>> mmc_execute_tuning
> >>>>> mmc_init_card
> >>>>> _mmc_resume
> >>>>> mmc_runtime_resume
> >>>>>
> >>>>> with values of host->clock as 200000000 & msm_host-clk_rate as 400000000
> >>>> Please check the rates explicitly in the code rather than just checking that they are not equal.
> >>> in function msm_get_clock_mult_for_bus_mode(), clk multiplier returns 2, with HS400
> >>> DDR52 and DDR50 modes which is called from sdhci_msm_set_clock() and
> >>> sdhci_msm_execute_tuning. And in sdhci_msm_execute_tuning(), we are calling
> >>> sdhci_msm_dll_config() when SDHCI_HS400_TUNING is set and this flag is cleared
> >>> immediately after return. And sdhci_msm_dll_config() is called after that.
> >>>
> >>> Now when the card is supporting HS400 mode, then from mmc_hs200_tuning(),
> >>> sdhci_prepare_hs400_tuning is getting called, and there SDHCI_HS400_TUNING
> >>> flag is set, and clock set is multiplying the clk rate by 2 in below call stack
> >>>
> >>> msm_set_clock_rate_for_bus_mode
> >>> sdhci_msm_execute_tuning
> >>> mmc_execute_tuning
> >>> mmc_init_card
> >>>
> >>> so this clk rate is doubling only with HS400 mode selection and while setting up
> >>> dll in HS400 dll configuration path sup_clk need to divide by 2 as msm_host->clk_rate
> >>> is twice the host->clock as mentioned above.
> >> I don't see how it's relevant. I'm asking you to check for the rate
> >> values explicitly in the driver code rather than just checking that
> >> rateA != rateB. You might error out if rateA != rateB and they are not
> >> 192 MHz / 384 MHz
> > ok I see, but I got one another alternate to this, I can try use similar checks used in
> > function msm_get_clock_mult_for_bus_mode(), ios.timing == MMC_TIMING_MMC_HS400 
> > host->flags & SDHCI_HS400_TUNING, but for this I ll have to move check
> > host->flags &= ~SDHCI_HS400_TUNING in function sdhci_msm_execute_tuning () at the bottom
> > of this function, this will make code more readable and consistent to checks at other
> > places but I am testing it right now and will update.
> >
> > If this doesn't work then I ll explicitly use the rate value in check.
> >
> > Thanks,
> > Ram
> 
> Hi Dmitry,
> 
> adding checks for ios.timing == MMC_TIMING_MMC_HS400 && host->flags & SDHCI_HS400_TUNING
> serves the same purpose for dividing the clk when mode is hs400 and hs400_tuning flag is
> set, and clk value checks can be avoided now.
> 
> With this HS200, HS400, HS400ES modes of eMMC is tested.
> 
> so if this approach looks good to you, then I would like to proceed with next patchset.

LGTM.


-- 
With best wishes
Dmitry
