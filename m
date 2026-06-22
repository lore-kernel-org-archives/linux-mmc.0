Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9036A3612E8
	for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113710; cv=none; b=ZeDZMe02VSTfIXQkJWnT07I3K/pB54TPRzhzFyA42FU6fzx3Yq4NeWpGAkdojZ+48AqwzUDWObF2b8Fm1B8Yauaeang+qVKIsw8E/HC+mW1EhikAlNUZMC8vgGz3nBDsEWIUyPjni1TXPCemeoSXZNFNQIVOQ8S90DNA7YQFr9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113710; c=relaxed/simple;
	bh=eiI5cD8k2ipSLpc0njJMRUY2LdZCbvWpnnCkpiqTtcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVlBUF2Csn2KRc0gQ5Hj+f2kS4+qJcv4zJpX4rrIAezWnxKtu8pq1Ckb4t29N6+ey1d6rQzqddgJLKHKCT7C3kBxncn9I2NFmhxEq3BqxRJNfA2CnP7KEh/j+IkXqzy1OQPtw5qSpO1rJCtdUj4F87nVaLvarG1wZb/pb3+d7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RVLiRqn1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TikzPBox; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RVLiRqn1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TikzPBox"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M5BtHt172881
	for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 07:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0no1m7POsI0BGgkniWdTWtOx
	qadJtjU/GaTYTTA+k+c=; b=RVLiRqn10Q8niygYmbrWTwjOdldWadZoMRCUyjld
	kTIzWMdLbSDWpgDAhDZJqy6s/ruDgBEMlAwvnbJJhJHDV7JKPuEfEm32C0K6iThQ
	5B/n0V8bppB4SrWAZmBQhMER1fcA7zJjgXnzEmfFRZX9m8evWO5mOc2ugpJksD9z
	fTJ/ONFIRlUDj7EV4FtrnyP/YE2TeNdZOnY8o3nISn+LxhT8NiQPBZeCr/pYFZfm
	pn/PLwG6HZzgChfny/1C12wWUb4Su3+VAuvbRyQBw/TRHYYrkwIYiUZ/GkqR4H6S
	JasetESJvLuJmTQ0zaoSI5leaSsiZlwC8cnUVp8m1u5n8g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewjexwcnm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 07:35:07 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84540c1fff4so5981351b3a.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782113706; x=1782718506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0no1m7POsI0BGgkniWdTWtOxqadJtjU/GaTYTTA+k+c=;
        b=TikzPBoxqOcbzpQR0gLjIUKjeiCWcW82DgtfwYFjm4HQCGqbC4nnUvD2WFWOFhu69w
         F32+U7LJir7Rvh9RSTceionsgRqarIi1PlpLWj75dgmBF1tLAYMZzFC4f1q2wBJems9D
         xLz5SnVDG3YVv6dIMUd5M0fz28b/HmAPJqBtRnIsMz/z7gHNGiG+qGchP5ONk88rJQbP
         LomNtwqk7V51yIYy9tJ4DiZnQyw85yji1A/hMR/69+ptdvgmYvvpeo69VpJ/oj4N6vZ2
         0mPExkiDaU7fzD5ntMKBzz6KxCGTl88BEuJhg7+gB3aBu0LqgGHKIL9CgGxNBxvEeKcx
         MITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782113706; x=1782718506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0no1m7POsI0BGgkniWdTWtOxqadJtjU/GaTYTTA+k+c=;
        b=SAQ44LARm2yu1PvE1atD7GOVZi/pS3p6cnUOd7Zhwxe8kMh9qQwRH2pSQQ9qbfjyWF
         PU6AVbDwHNTK3igF76IAVqk+UxDpC7/Myn+/f4Jmlc8spkczWnnk16qhlPuXGLsV9nsi
         TfnsQpDaLPyEF8/0pRoNQwXaSK3Vy3r+Otu2E5gNkF4U3YXgX6PzKSzc28178/0K25Gl
         CQosNYOru0axAgsFDJNUyCwkjnSKcV6St29ORfdTGznu6EahT6aolq/Xth2RbhB4AQIJ
         3PyJ8ngY3YYa4muOv/nyAkgdd3JVEDHbWsvMRL/mti/3IqKNCuuXz5j8wtTFQgsVgOcC
         XScA==
X-Forwarded-Encrypted: i=1; AFNElJ90qk2JjWUdkonUPZaYNGUGnn8VuYe1L2qi776Ldz4LwdGSGBenyZbunG3BHNiYduTgIMsfbX8He9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQtVaqAAr7UUuaTdXBUGwHMYnbve7EaogJ0Uv+iSdfjLaBhDyv
	9RImx8Ej2i1uDJ+kdgOj+arOHxIAUrZShsTBxc2qMHKNrpYgxH8B5JabUlzw6i6H3eNEU0MM6lL
	hjRs6vqjOSU6upqnP+CVuRnCmDSle/55Li9STCmQJTxzNU2VA3lbdd9NBD7U6zms=
X-Gm-Gg: AfdE7cm4hoWMiUmfUl2sbVlh2wtoAu+Jc88MoXuS9Aw5RshuYJezfcABGjQZqEAzNzD
	DvStN9kdw03+CBoE8LYRsnNbpiOrJqat7/Qz4Qoxs0SASflBOBvy7KjNv8xC8mmSBGlF+OssvHF
	gCoqW/CRCLVpJQzJedkNhOajfvrzy29pN/U8tj10T+ruEgRXCCpBcp3AHIMwgZZFiLyHS+ZsNGv
	jwlDFgdJX6VDarxMIvcXDYTTSQJGoyWPK4yKxqwdVFEiHtYlBmalL9NHeYfKaKDim6kbtV4VhhD
	/MYGAR66tdw8hBXR4ySBxFpcRVXgWOhnXTFD/pzTBVuau2uRixkEcXeUj46oMQr3ZSRd599V7kh
	/Av+h6/GVm/AEMcBlvBaiu+3SkFo9ZSlN548P5UeeSJblqddT
X-Received: by 2002:a05:6a00:4104:b0:845:4cb5:2343 with SMTP id d2e1a72fcca58-845560ac301mr13520265b3a.19.1782113706486;
        Mon, 22 Jun 2026 00:35:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:4104:b0:845:4cb5:2343 with SMTP id d2e1a72fcca58-845560ac301mr13520230b3a.19.1782113705945;
        Mon, 22 Jun 2026 00:35:05 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d8dddbsm6607972b3a.19.2026.06.22.00.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 00:35:05 -0700 (PDT)
Date: Mon, 22 Jun 2026 13:04:58 +0530
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v11 1/6] soc: qcom: ice: Add OPP-based clock scaling
 support for ICE
Message-ID: <ajjloqm9eOkrr5W9@hu-arakshit-hyd.qualcomm.com>
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
 <20260609-enable-ice-clock-scaling-v11-1-1cebc8b3275b@oss.qualcomm.com>
 <d1232243-2f23-423b-84ac-4463eac79f9a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1232243-2f23-423b-84ac-4463eac79f9a@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3MyBTYWx0ZWRfX1Ru5LpBuc8U6
 uDzMyW15LvOn+Xbf06piYSS6yUIknZGc6m0PoRSdCPd2HEi81zetLPAAD4sDmJhV2hesIEOmANs
 PisP/UAJ2MhBNn5ZUwLi/S499n0RroIBsrXJfkuzFJoYEU4XGk0zxxYucUJ+hoUaQytn415JyWn
 wtGnFys3GAzPyAPnsmGpZIKac/N3+bSXFPsxbXmn/P8/Ky+r8D/sKH5B7swM4D/JtLbiS+Uyubt
 Gry7DqNjQSypS+2R4e5NcKapqzVBHm+YiP2sDakw4jM2q2dQi58fCLu8fo5DWTGUMIRcULadjlJ
 tDqo5tkNYbwuWz0pJNt/Ie2WmQuJ2Igqevmnb2sTevVNHHoA95ZX1A6EB6IjvSB/RzMyjnbWQs/
 UMABe7RVodCeSutOFUEpX4jpQ02/ke0jH1qOW/lp6i19NgPeCptz3UTsFNP9p5fbOcRkOcvRw72
 Wqwl48t2wezZJBIS8UQ==
X-Proofpoint-ORIG-GUID: rX2WkwABE-wgvybsJ6hZkOmrK_wS3JAu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3MyBTYWx0ZWRfX3Uk43m4D3wpd
 Pn+at2K83w5El60FefVTTlluG/znoMk4ZHhIGeQQ1V2Xglc798Mk00IPpbNImW0cl84zf5z3QTm
 fobMKcr967ftZr38OvRIX0E9YsNtFdo=
X-Authority-Analysis: v=2.4 cv=YtA/gYYX c=1 sm=1 tr=0 ts=6a38e5ab cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cYz2LKHLP3dAwZc2OesA:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: rX2WkwABE-wgvybsJ6hZkOmrK_wS3JAu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220073

On Thu, Jun 18, 2026 at 03:01:54PM +0200, Konrad Dybcio wrote:
> On 6/8/26 11:47 PM, Abhinaba Rakshit wrote:
> > Register optional operation-points-v2 table for ICE device
> > during device probe. Attach the OPP-table with only the ICE
> > core clock. Since, dtbinding is on a transition phase to include
> > iface clock and clock-names, attaching the opp-table to core clock
> > remains optional such that it does not cause probe failures.
> > 
> > Introduce clock scaling API qcom_ice_scale_clk which scale ICE
> > core clock based on the target frequency provided and if a valid
> > OPP-table is registered. Use round_ceil passed to decide on the
> > rounding of the clock freq against OPP-table. Clock scaling is
> > disabled when a valid OPP-table is not registered.
> > 
> > This ensures when an ICE-device specific OPP table is available,
> > use the PM OPP framework to manage frequency scaling and maintain
> > proper power-domain constraints.
> > 
> > Also, ensure to drop the votes in suspend to prevent power/thermal
> > retention. Subsequently restore the frequency in resume from
> > core_clk_freq which stores the last ICE core clock operating frequency.
> > 
> > Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> > Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > @@ -335,6 +342,11 @@ int qcom_ice_suspend(struct qcom_ice *ice)
> >  {
> >  	clk_disable_unprepare(ice->iface_clk);
> >  	clk_disable_unprepare(ice->core_clk);
> > +
> > +	/* Drop the clock votes while suspend */
> > +	if (ice->has_opp)
> > +		dev_pm_opp_set_rate(ice->dev, 0);
> 
> The PM core will quiesce the vote as the device suspends, this is
> unnecessary. Similarly, the rate restore logic will become unnecessary.
> Especially since dev_pm_opp_set_rate(0) does not actually do any rate
> setting.

This section was earlier discussed in the patchset v4:
https://lore.kernel.org/all/7b219a50-6971-4a0c-a465-418f8abd5556@oss.qualcomm.com/
The intention here was to drop the RPMh votes once the device goes to suspend same
as the storage drivers such as mmc drivers does:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/mmc/host/sdhci-msm.c#n2946
This was done to leave the hanging votes *on* for unused clocks.

However, I get your point, due to mean to say that once device goes to suspend
and GDSC power-domain will be turned OFF, it will automatically quiesce the
performance votes?

Abhinaba Rakshit
