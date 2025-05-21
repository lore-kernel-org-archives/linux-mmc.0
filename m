Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F025E832
	for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832141; cv=none; b=aSrq6fPlRvVEPzSQkB7qysO0sfiOsI+uUz8/UeC5F/3l9g+MdcffTCuaTeLbXe8/If1WRPltxV/mxmQTtwHfXbcuGvvpKv3gEbAWPhozYhYi4jVmboNNn9vLcNEg5/BD9BwQvVnUAyXtxubfXemQzGC5sKxtDLC80YLq9dqDd70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832141; c=relaxed/simple;
	bh=dVeZTI4ANbqPLAk7vVWJmaDi/wWRegogvggZf25+oHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGxk9V1nc95nlvPNnDWNyGtmRt81veKzRmBMntJQ0Ud7E+Px0wjXVnZb8y0W48BuH7fYkwbuwABR1gwTWbqYzYC083VAEzbLgxbn9xm3m/5FFSRCrT05lOuUgIaNgBQ2/IZ5vcsB2IkDjWu4MSLP0e1GxF2ygh4AM4Bh2jvJ7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B6mhUKxj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6mhUKxj"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XKO4016577
	for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 12:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tKAI9l5PcEf+JViDHozLfx+m
	cavirtg/fHrR9QMjeUg=; b=B6mhUKxjNiWAT2SIGHmJSbed8rrI9GnViY9sOxL+
	P/qwXOBNs24WmwfB4nzJKWEPwObfS4HTDUnRujmp+62oyZQr4nX8uU8ZeLfWM/kZ
	z7R7wCWJ3AeQD3maH0eXGoHv1TFh5jPrkLGUEfUQc3p7gNKyuMxJzD3XmkkWRiJe
	VhML6sQi64wWy+erx8W8ZEOxqTtIQyr1RJt510jbvYBcC/etTaMGXLXvwtC7gA4Z
	7x6muuLAs6ZLm+H43FPJPPALjIZC+AS1JYwKG8FskB7O1FfqDY5OGEgaeaQbNlwB
	rDJ2bloDodKZNV/gXHdCi0x89jqxUz9SUFSWJb0tOVTlfA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9u0bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 12:55:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c793d573b2so1205051285a.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 05:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747832138; x=1748436938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKAI9l5PcEf+JViDHozLfx+mcavirtg/fHrR9QMjeUg=;
        b=pTbygHTd0V+dzmpDgLp/HecXhlkHYhdNmPAvLUPB3USqvR1FffHE1vcvrbPU/S9hc8
         cpfmTSgUUJ6hkhPhRfPtukIaNvGIDtcWAIGDn9a6oYvStpT/4cfbecnTfpRFS3t8QpWt
         p4N4yAh82fkt67mP5gCLzT2kPJ9szHBwsht2hcG6wQ5HY0QV+TYGiu88lvgnvuRb9uhu
         vmh7m6LV9956O5Z0bLisMuPmCXTDLWemgheQVwTT7dcUhAiVM8xp9+BhVuww7UAix61i
         6Dk1nqQ+wMiBgjAxaCeBYjA5UVTjVER1YZNx8LmpaU1W6w6Kecwyc0863PjYyyJy2AMk
         oFXg==
X-Forwarded-Encrypted: i=1; AJvYcCVM9NPxL3WVuInaqehjjMjiT1DgXy77m+knTj+LZ7i1o2VQVgHKJvi4wYwlqblphbFfc6yhgUFE0xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+qpGAfoD+X1oxFn2MycMdatjapjqglr5x/Pe4IN6dAKBtj1k0
	W4gUg4vz6yXkJPw3eGqiccPBV/vlh+LmFi/SzKRjODGmAWMv5cs7BDqGmrzpVUMWRX2ZOCnezhZ
	8dJAWVNNzGd+4q797goRXPkEXFAyZxQr6Wb3T2v9cu/h0Y1ljPfAU7OTt9zszK1w=
X-Gm-Gg: ASbGncsBklxsvu2g4TKiX7bpkrfHApM24mcVYfjYuAD/RhsmwvQNWqQQb6/9UXDjADZ
	qx5iaXCHyDt+VdAyAwIr8VvAVCdILDNw9sC8cbpYrlkZQhB3qZzBBHtvOE9Bqxx8SOnGGobyodr
	P9P56kwEgvrOFkiKtZh4xxoohe+ovvJSMKKyNy4kvx93ETBkbFKy1npcPEgNy3DurvQ8UYOEOuU
	JORG4gXs9OD4POieFtqv+GAhlg17sAe0ygpdvLul6JFMcxkTQECzZCV/cCw663bslO5djQRsocz
	J52M+gHW6bRWTQYxuBUGU9RC0Z1g+XqM0SUMsx2LvhdJtgEnNcwyU+H+ic1BlFasI/K+wMlh+nc
	=
X-Received: by 2002:a05:620a:1923:b0:7c8:39ea:5166 with SMTP id af79cd13be357-7cd467af417mr3368957785a.55.1747832137714;
        Wed, 21 May 2025 05:55:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsRCeRgD/B3Foav4M0OQSyuJeHudoVNith0RuRKrEcTmsJP5u3ejyMw9gC+t0sd3ETrAbsPA==
X-Received: by 2002:a05:620a:1923:b0:7c8:39ea:5166 with SMTP id af79cd13be357-7cd467af417mr3368953685a.55.1747832137265;
        Wed, 21 May 2025 05:55:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e70406edsm2864319e87.258.2025.05.21.05.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 05:55:36 -0700 (PDT)
Date: Wed, 21 May 2025 15:55:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_narepall@quicinc.com, kernel@quicinc.com
Subject: Re: [PATCH V1] mmc: sdhci-msm: Enable MMC_CAP_AGGRESSIVE_PM for
 qualcomm controllers
Message-ID: <ehgjdszjr34xppmkrkicb4pnq326nor26tqu2ekop6ew2j3y3h@pm45aiipzuc5>
References: <20241104060722.10642-1-quic_sartgarg@quicinc.com>
 <konkbi4hvd7qc4rhokwrymzqntroy7gijk3ndwv5rluswdrykp@xsafrtrjzmuq>
 <10c90fee-ce7f-4034-9028-4252f19cb67f@quicinc.com>
 <CAA8EJpoLLDXFQk-ViuaioKrECzMV0aUrcOj4v+Ufs4oHY53mrw@mail.gmail.com>
 <064d3eed-c2ea-4b41-85b2-d2a5a922f8c7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <064d3eed-c2ea-4b41-85b2-d2a5a922f8c7@quicinc.com>
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=682dcd4a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=4I_ifG8pwFw1aE3i0MYA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: k9bduXNeVBMGjJH-DeYbCVt8bT4jiXL2
X-Proofpoint-GUID: k9bduXNeVBMGjJH-DeYbCVt8bT4jiXL2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEyNSBTYWx0ZWRfX5RXtJd/6WmBx
 1yCeEGRvGY5g0tgzg9VUZ9LznlGczog83Me87Cq55RfKZvi0WtQrzAB5K7QidCc1yR3zu9ZgYuI
 kn5vV3deK9RBUGxklZnpynyv8jH00Hg2IIBa7z2UUsPaB/p9ZUj8N8aOT/g40xTA93hPukUahpK
 NkKB1fZbBYPO5bK0fxxPtoM34Lc+gCapOlkeFujxM35QsZ9tPSoZCJeMSnX07oSS5Qxj1Qmkl1M
 Q7qmKDFXfN0xVbHrK2ccmkeYW/pEt3W2ozLiEKNGMWiTDRuEn0+8zvzG4zexfU/+QKnqFfVQ2Yn
 tn9K3cwQcLHx6IxH2OLRoxku93AaFZCMMXpbSDn2Gj6QUBKQZ3cnkHpsAdPUxr8VthNrf2IakpD
 UKqZ99EfW6WRx8qSv3YdeO8ZvUzRQXGm4W+sGWehRhrXMmS7GkBX6uoonAvWUyvSIQ2j9ozD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210125

On Wed, May 21, 2025 at 12:46:49PM +0530, Sarthak Garg wrote:
> 
> 
> On 11/15/2024 6:53 PM, Dmitry Baryshkov wrote:
> > On Fri, 15 Nov 2024 at 12:23, Sarthak Garg <quic_sartgarg@quicinc.com> wrote:
> > > 
> > > 
> > > 
> > > On 11/4/2024 4:19 PM, Dmitry Baryshkov wrote:
> > > > On Mon, Nov 04, 2024 at 11:37:22AM +0530, Sarthak Garg wrote:
> > > > > Enable MMC_CAP_AGGRESSIVE_PM for qualcomm controllers.
> > > > > This enables runtime PM for eMMC/SD card.
> > > > 
> > > > Could you please mention, which platforms were tested with this patch?
> > > > Note, upstream kernel supports a lot of platforms, including MSM8974, I
> > > > think the oldest one, which uses SDHCI.
> > > > 
> > > 
> > > This was tested with qdu1000 platform.
> > 
> > Are you sure that it won't break other platforms?
> > 
> 
> Thanks for your valuable comment.
> I am not sure about the older platforms so to avoid issues on older
> platforms we can enable this for all SDCC version 5.0 targets ?

No, there are still a lot of platforms. Either explain why this is
required for all v5 platforms (and won't break those) or find some other
way, e.g. limit the change to QDU1000, explaining why it is _not_
applicable to other platforms.

-- 
With best wishes
Dmitry
