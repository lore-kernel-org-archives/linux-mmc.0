Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE3E1514DC
	for <linux-mmc@vger.kernel.org>; Tue,  5 Aug 2025 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387955; cv=none; b=CG4nMCIrwYe4bqFxeS/znBZ5PVd+HP61HZbv+RlMMZfoE9axpFUsrucV1srxdaJPDqEu5ash2D3Ov6/Mb7Fn8Pk6ZeZuomNbqICU+X2YqHjZIgyqb6AMrRg2wBUHizDST/cGWKnDYB6ZoWMLe+ge8Y7nWpvw/IX79jAyCa7MFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387955; c=relaxed/simple;
	bh=6xnkcRjjaBCV9mGFQ39UJqLkd2ZbEMv3DHt3bw7xXVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFagfyOkLbcIviLo2E3aQFj3kf51sluV61WmSDIBd/aq7a4Xj9YUhBKKUpN/x0DLwfs8IGuZZ7RMDm1qP+ik5oIwHRAPAjfj2E+XokXqkuyI+DEn+fvINh0QatRGafWfjKxwZTQTKmcOVwos88hFVm7A/DPnt0VzqeR2tEU8i+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a/cKFDsv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a/cKFDsv"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5756xPmw028493
	for <linux-mmc@vger.kernel.org>; Tue, 5 Aug 2025 09:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oFkvM2HVsX9Y21JHEp/hCHiYryvffbqt4OmpC31gI6M=; b=a/cKFDsvjeknMpcV
	QDZ0r6yQBaPCNk7jNDdJ/aX+Ognr4LHk5faaMtRFv4C55saHwbzUGEp1Qph4yRkZ
	VwYJEEeeGhhxq+71m+g44x3hGmCrQr8tZZ7PjtN6YbQgq8gqKmgby/xaNM92ijom
	n6Nd+Eqp2AsqRvoaAQfOgDssOnNgQdcciVpVeFhyYeZ0OalpesYBLEyyb45qysGT
	Lu0WoFIbOzjhdFpOPH3DfrO2fG5HvOU1SHFb4wOfxO9Tvp9B+58q1znp8ZWZkzGy
	dElqQHtrPat2JrBWdD6epOg/jj7Ku9B+eHHi241DdozGQmn6TtNVWOIM08Nv6pBq
	nHVj1A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4899pag1u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 05 Aug 2025 09:59:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7073a5f61a6so81284976d6.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 Aug 2025 02:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754387951; x=1754992751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFkvM2HVsX9Y21JHEp/hCHiYryvffbqt4OmpC31gI6M=;
        b=wquh/1hXVrNJ/nzjci7FuoROUuD/bPOFNa7VhbBCIT45tgA7ffxJ4/YENM5/J7PVfT
         6SvsIPURZuOGP/TPDMWfeV/bdHqUzeakUtk6dGHS90/ZhA68B/YY3DRMbUyyRPLS7jdN
         pl6HYJWas7AxWoA9a72+dC/FMHzEtLamuQxgDqaxzWLv4C6lDyxvvtZl0spZo2f3/XRt
         kV8tJvofMQ+VPxS4WWLe36UiYiz54DitV0kUtXzJt9lt3kUtHgMCmvUzxR5NmqjC9rHM
         Mt4sUzCwdXYOJcdaUMA6EQBph6MiEkbYXChzaTX80eiwjzYY1GirMfKxd2Otw2LYwQjC
         lHCg==
X-Forwarded-Encrypted: i=1; AJvYcCVDFeRIZkUG+vs+8CrwOTVK/mo2OMiDZypsCK3pzuInL8+BnFkxjpsIHbQLg5bI/kWIFACL3kVsK7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3eKzfZWPklQ+Z2tk5Uqn3p6436BQie65Rp4oNVyGxbuCo8n7
	gzsGx49fj6fLTROiLLFQRpZsUeBduTyLQ/G+2T2VvY5KIJyFTb/dCEqQpeKmzl04IZb+hYoMjAW
	S7A89oa1cGcX1pjwG8c0WNrcdmV+ZmGavRzK0/sCbGwE5CSzS4a8OS/rns/6Hxrg=
X-Gm-Gg: ASbGnctW8OLFQy2tH4EA3wOzYMTBmpv6UBcpyokTi0nIlyVqFL75mgeYZzlk1VZfI2+
	rcAtQp5+vxdoWoLxYQZErfFRatttgJUHI2iKzYyJO5/CBOzK3ghdO3P4ZQJnc64+qmqiHGq3eFa
	8TxMoqiwQwqQTZcsTBno9XkvO2J5y9lXHPJD0M8UHdXgj9P0ZWuaS6mA0Z6UZJFmsBtqT5SJPZX
	Ke3bQdEXp9mzMZ1auB3sQMT7YFmdVwXg6i3VsttAfnOBmEOYvl4uFbYg03wyfPXPRqgfoeJQtQE
	9a09jZ3ITzsrtIZyyZQAIPCVCU95WfIbuSkvvCNpKwKv/Ydd6cKZ1TbcBp5NXsUr0kq9F8P/JnF
	SyT24wdjll5tHkK1eS2OXVGHZsMZ67fxktcfP1TjxeTMmNxTH2F9y
X-Received: by 2002:a05:6214:411:b0:706:de4c:fddf with SMTP id 6a1803df08f44-70935eeed18mr164933396d6.9.1754387951284;
        Tue, 05 Aug 2025 02:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGERL535Nj+LI6rztA9IAgnP+naoieBDZmsnatDeRA4g6lNmzXFHANW7lm0JicsfOzA4t0Pqg==
X-Received: by 2002:a05:6214:411:b0:706:de4c:fddf with SMTP id 6a1803df08f44-70935eeed18mr164933146d6.9.1754387950742;
        Tue, 05 Aug 2025 02:59:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272ff7sm19726081fa.7.2025.08.05.02.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:59:09 -0700 (PDT)
Date: Tue, 5 Aug 2025 12:59:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com
Subject: Re: [PATCH V4 4/4] arm64: dts: qcom: sm8550: Remove SDR104/SDR50
 broken capabilities
Message-ID: <lkjp2353athoi76h3j3bgkcxdwfn6akcyyweipt4g774ztmmer@vcw7ru5red3n>
References: <20250801084518.2259767-1-quic_sartgarg@quicinc.com>
 <20250801084518.2259767-5-quic_sartgarg@quicinc.com>
 <69f2807c-9a28-4b31-97cc-2756f0ab9fd4@kernel.org>
 <c7e36755-9255-4209-9d53-20077bd1d3ba@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7e36755-9255-4209-9d53-20077bd1d3ba@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA3MiBTYWx0ZWRfXxm40Ppov7K7q
 dwccyxO5OhmpLWkeIX8SZEA5DpsXpfdD/kuVb8jjDvaihSGnST4OL2m5ckRd2lzqogfGDTJmgD1
 QFqVytus/QHNNytQp8hSfKP5WNkrmVLSJYiZNBN1Xkv3t7Tlwck5M1vz/Ti8jXNobpVjCDcQ6nS
 qqzYgGTGIAqeFu6v1+ZIxwBQoT1uAIdQJQxxNnhS+I0k2Gk2QJVuH12NOWy0A9FhBuoFHSL45XD
 vIdoFK5n+rfnPjBmBdERHRXT/R/9PLM7hscUzyoUPhv/gyTrHVmwFLOuuljXOI618kzIgepbtrN
 YOVi/ro9weYrCDExd3iTTkS4EUoVcv6BvuEt1DlSzW5pkcoIaw/OZ4xZ+zHKuFIjwefMXQmiGEk
 SUMXYhzIyXXDp3HbypHPyv5p6P7gHFyovEb1LtxpAAzx1aGzkjG1yYx7DlPPKU3U0JIhhitM
X-Proofpoint-GUID: h2RDYZ_sh7wli9I5ZnsQuUIO6JJwbTEN
X-Authority-Analysis: v=2.4 cv=N88pF39B c=1 sm=1 tr=0 ts=6891d5f0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=kKDBy8IbGvpil11uj3cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: h2RDYZ_sh7wli9I5ZnsQuUIO6JJwbTEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 mlxlogscore=993 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050072

On Tue, Aug 05, 2025 at 02:49:29PM +0530, Sarthak Garg wrote:
> 
> 
> On 8/1/2025 2:32 PM, Krzysztof Kozlowski wrote:
> > On 01/08/2025 10:45, Sarthak Garg wrote:
> > > The kernel now handles level shifter limitations affecting SD card
> > > modes, making it unnecessary to explicitly disable SDR104 and SDR50
> > > capabilities in the device tree.
> > > 
> > > However, due to board-specific hardware constraints particularly related
> > > to level shifter in this case the maximum frequency for SD High-Speed
> > > (HS) mode must be limited to 37.5 MHz to ensure reliable operation of SD
> > > card in HS mode. This is achieved using the max-sd-hs-frequency property
> > > in the board DTS.
> > > 
> > > Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/sm8550-hdk.dts                     | 1 +
> > >   arch/arm64/boot/dts/qcom/sm8550-mtp.dts                     | 1 +
> > >   arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts | 1 +
> > >   arch/arm64/boot/dts/qcom/sm8550.dtsi                        | 3 ---

You missed several devices which use SM8550. Please fix that.

> > >   4 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > 
> > This will break MMC for all of the users and nothing in commit msg or
> > cover letter explains that or mentions merging strategy.
> > 
> > Exactly this case is covered by your internal guideline, no? Please read it.
> > 
> > Best regards,
> > Krzysztof
> 
> Just to make sure I’m addressing the right concern — are you primarily
> worried about the introduction of the max-sd-hs-frequency property in the
> board DTS files, or about the removal of the sdhci-caps-mask
> from the common sm8550.dtsi?

This patch requires all previous patches to work, so it can not be
applied in parallel. It should be applied after the previous patches are
merged by MMC maintainers and then available in the Bjorn's tree. This
requires either skipping a release for this patch or using an immutable
tag for the MMC patches. All these deteails should be explained in the
cover letter.

-- 
With best wishes
Dmitry
