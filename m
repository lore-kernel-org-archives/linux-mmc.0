Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA237F748
	for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2026 06:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776751812; cv=none; b=I5SGZ6egpy1q4KYRzzwGMgpSOr/knYXiZRWe0jpwAdiqe304AaqjeFS/BrZcBs94Pqkt0AzhwbpLGsZb8L+BmWoVTnvB7rqa7OCdGPj+5KOm2b46zuGGb9mCRmT+d829y4QTomXHdBJ/7/NG5tYqcB31iA61kEf+d8T5chZcx4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776751812; c=relaxed/simple;
	bh=DU09t4e01tb2Dg5oxA0hYoS2Sw4H3Q/MxB4hZIBL86c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiFE3hTsA29f+I3eNXFbEXQzx6EPQX5/t001vWr+WF7wj4FzXiOWYJ/cPj+QKJLdPPpTFidMKBQJem3pNdsFGWiEY5/pGMBfIhhb9guX7UQ4pOZt8ThCRFz6Ayiv8Cew5afWU3DN0wRNVxszz1TWiIN4aFZyIvFTAUFnvPVMrFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ss0fIIkU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FbQU6f8P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ss0fIIkU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FbQU6f8P"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L10x33785485
	for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2026 06:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1guwVUsMIMD/Wpv/IcScqQdd
	RIpEXoJdanKvBpB1ZJ0=; b=Ss0fIIkU1dxb5Xy/z/S+TipJ0qapF+MW2z9RlxuI
	seJUYFSYlo7RfNQIndELCdlXAo1Yd9KlKN58BlvPXYli0tHPDRUnU0j6tz1JMRDB
	qZvE1oDA9TTDSum0vF6ztWcUdvSSFEHahRBX0eVMV38DUk41RhLEVOYJz6iqxU+y
	WBHh7ytR25fEZZYhI4bpvYJxJr6ueOhVxwqE9qK5841XW/tBqVwUQQR+ob2A1gsR
	ew66n2e2nNYC5JWPni11CRrl4u99iZClicgK7oKxD3UM6PD4+wQSR3bKVwYMZrHd
	WFQOVVY/rcvr63ZaGTSQ7mtU3V72eVjC0OI1p9lmpNbBIw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnhdhkyk3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2026 06:10:10 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82fbceb0181so1266810b3a.3
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2026 23:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776751810; x=1777356610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1guwVUsMIMD/Wpv/IcScqQddRIpEXoJdanKvBpB1ZJ0=;
        b=FbQU6f8PZ8kFklrctX65ahrHIsvl9OvXziHclG+3ZOAe8LZhEUA99ih0fk/CzJ75Vj
         n9QHQ977Igr1ywGo3Ui2OcL3h37IAYiWu0mFMM5L4YdmERGnpKbFZrZBH/7J+ayd8DPt
         n8w6byR896bujnERBnctK8hT+RHufNs3o3LjdV6/lSFyWrUmPD8fIz/kZZeiCHdnUCvV
         +nwom1XvpkResTWolzobFZ78CKyQg8AYzoWRyqSf6uE3BvJC4yHkdFt0ElIsueVEQKjP
         DyMSiQWcPLvPkrI/+uentf1klBgepkqvpDN7cY7LdLMUzD7DCrch9S9BZWdnwuaTRhWA
         DSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776751810; x=1777356610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1guwVUsMIMD/Wpv/IcScqQddRIpEXoJdanKvBpB1ZJ0=;
        b=gGZah6S9SdyXCBXae9JOwxJhWnlGxpTvec4ZAybpXXzu8+BxaUM2eMLRpIAfogspK+
         vqsB0qNafPmA4dnTroLjNJd27TacWItixKc71gEdyNQO0K4PFg57u1p6s2A64+WpbBc/
         0BLpeYs5FtfOIyqbLvoouaclLK1TkxW7zcy3MZfZ5eeIyeQN9sxO0Aq5IGV4hOcMaGYU
         haElEelHiDyCSY7s1hm7w3rKMUEmv3dbPSjkP6NWVJAHbNmVYiB8qDP4dbhNKiXeBxy1
         F7C9W9AA/NIuF561OFxGsRQAMtFHJNciLR7jUT0POMBbi7M0F8PCWfU+wapIwuEv8v0S
         3HEw==
X-Forwarded-Encrypted: i=1; AFNElJ/jiGHXtstJLAkDRnlWw7Q7pe2b4tBCl+hBcdxnpnN98JvMlaXSfU0U0MdpH0NroEhm/PppSpTsaPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDVDrlH/M6wsOOKkxh8j5DXdw6RYZEttmFdHfcObW7xTc9MiOc
	uKyaAc2pp/bQzG1SLDBLC8WuXzxEABgQIlegsGvwfq97Wc8pp9pPE6Y9DawhlPR4fxifc5tq9Kz
	78Mk1XIZqGHay5wCHKq1HlLS0oYqmToBlYFUPo11lEzhRSxl88u3K55Lt2FoiDHQ=
X-Gm-Gg: AeBDieuUVLtDvc5PEOSGKddCY7HMLFMQV3lxv19Luy6uIn6symlWNRkQ/qL1t2S6swj
	neqfwGfvw/tMiEoKUXm2v9iuO5m+VH5cz31sNWiZzHw7a/quhg1d+m+O9a3Aeu9GwS71fUIb0jI
	fbYcKRwMPPNRtH+lmg8KfTfLr219vVWQhkxmzCuRGQhEmpED0tbzijSYH3qczY0QdWJTnFAVzHk
	yONr0o1cbeSELBnMCoBv0nalN3UyZzJ+cZOLHveGYBA9LQ5HZU5SjceMBWj9JAVsrEeCCmdO4NC
	6y2SgmqQZMawhmlxFYVpz30w+uLKNDoO3sOnfoKxLb3CjKfVRZen7H3u0qjJ+1mN8ICyiHiJ3ay
	VZm6WtIlt6fht3VdXJZi6qmDdP3F/ZZkPx4mLcKjVyh+OrLrfX8kbMJf3kIvjrfuzLvFTKA==
X-Received: by 2002:a05:6a00:1c9e:b0:82f:6b6f:13ec with SMTP id d2e1a72fcca58-82f8c9427b4mr15422862b3a.34.1776751809500;
        Mon, 20 Apr 2026 23:10:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c9e:b0:82f:6b6f:13ec with SMTP id d2e1a72fcca58-82f8c9427b4mr15422812b3a.34.1776751808982;
        Mon, 20 Apr 2026 23:10:08 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe68ebsm13905438b3a.47.2026.04.20.23.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 23:10:08 -0700 (PDT)
Date: Tue, 21 Apr 2026 11:40:00 +0530
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v8 3/5] mmc: sdhci-msm: Set ICE clk to TURBO at sdhci ICE
 init
Message-ID: <aecUuK5nF/hjV8tX@hu-arakshit-hyd.qualcomm.com>
References: <20260409-enable-ice-clock-scaling-v8-0-ca1129798606@oss.qualcomm.com>
 <20260409-enable-ice-clock-scaling-v8-3-ca1129798606@oss.qualcomm.com>
 <a432b2c2-475e-4833-9225-801990cb2d34@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a432b2c2-475e-4833-9225-801990cb2d34@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: umH2eU0_BS9ndEPBoa_jqvavRofTaskx
X-Authority-Analysis: v=2.4 cv=IMgyzAvG c=1 sm=1 tr=0 ts=69e714c2 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ciROkYvXyXDSqN8Q_VUA:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: umH2eU0_BS9ndEPBoa_jqvavRofTaskx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA1NyBTYWx0ZWRfX8Yc2LIpVDWEN
 vPNPilgyKuAPPPtuVTHKJTUDE8e4KDpVigbMATewYotgC68lLRbMACPoCbM3jlQ4A0x8a4GULCU
 wvZwtBd6CtlpfjCL7SlApuZacWrgZY6Y6DqUZZEu4pY0hg9Dxn5g1rTmCHgmhRbMsvtS3ZVT7vX
 /BbokzjbilXw20OGp8ZaJzIIVVCLPS1Nl+Hty0txZdNWC0SbkE2/DKYwFswmUy2ec+oJu4MdrkO
 wWks9U6HLbgCH9goT/Yh2kMgPJGXxKd3Hfl5JZD+GP/3+nRbdpKL0TlDccl32s4yhFvE+hu1f1T
 bKxgYKSwOwU6YXhqLDnP/FnEZ1kkIjb10krqKe6PD2iSNQTYowFRsHCubWoNHdM4xMCe/Sr6XUJ
 x8NLg+vpN1I7x5xskBSObDLrh8taqESMZuIPi18zMxr6TsEXYA8/2D+GnUlTAreUw24ha3/qakB
 vwKz2npZkUmyAAEl3Eg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210057

On Fri, Apr 17, 2026 at 06:59:42PM +0530, Harshal Dev wrote:
> 
> 
> On 4/9/2026 5:14 PM, Abhinaba Rakshit wrote:
> > MMC controller lacks a clock scaling mechanism, unlike the UFS
> > controller. By default, the MMC controller is set to TURBO mode
> > during probe, but the ICE clock remains at XO frequency,
> > leading to read/write performance degradation on eMMC.
> > 
> > To address this, set the ICE clock to TURBO during sdhci_msm_ice_init
> > to align it with the controller clock. This ensures consistent
> > performance and avoids mismatches between the controller
> > and ICE clock frequencies.
> > 
> > For platforms where ICE is represented as a separate device,
> > use the OPP framework to vote for TURBO mode, maintaining
> > proper voltage and power domain constraints.
> > 
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> > ---
> >  drivers/mmc/host/sdhci-msm.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> 
> [...]
> 
> >  
> >  static const struct blk_crypto_ll_ops sdhci_msm_crypto_ops; /* forward decl */
> > +static int sdhci_msm_ice_scale_clk(struct sdhci_msm_host *msm_host, unsigned long target_freq,
> > +				   bool round_ceil); /* forward decl */
> >  
> >  static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
> >  			      struct cqhci_host *cq_host)
> > @@ -1964,6 +1966,11 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
> >  	}
> >  
> >  	mmc->caps2 |= MMC_CAP2_CRYPTO;
> > +
> > +	err = sdhci_msm_ice_scale_clk(msm_host, INT_MAX, false);
> 
> The 2nd parameter is an unsigned long, do you really want to pass INT_MAX here? I would go with
> UINT_MAX. But still, why go with such a high value? Do we not have an upper bound for the clk
> frequency that we know we can't ever exceed for any target across OPP tables? If not, then maybe
> UINT_MAX is best we can do here.

Ack.
The scaling functions along with the OPP-helpers clamps the requested frequency to the
maximum supported rate based on the clock/OPP table, so any sufficiently large value serves
the purpose here.
Frequencies are better represented as unsigned long values hence, will update it with
something ULONG_MAX in the next patchset.

Abhinaba Rakshit
