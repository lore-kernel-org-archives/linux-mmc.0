Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7A23C345F
	for <linux-mmc@vger.kernel.org>; Fri,  8 May 2026 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234801; cv=none; b=aRWSArE1j6uR9K8N7rANB8wki2vJFEqR4R0BYmJScqz28vCeTqwlmfCmcfN8nNH4+vkATw3+wLmj01P0wfLtMi0skzO+F2N9o1ZZOk262NZ8bjNuB1tFkRKdQJmMLY/O2PUWkUFS4lW9+f1LrMKs1g82oAVpIU5ll6o5PbPybDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234801; c=relaxed/simple;
	bh=brD+0nXOgI/6kDlva7x0XLfgCi6MCA7+v7u5G6WMJBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZytTXUcclJga4UTVN2nl5yQ69p7BcaBqH4G36V/UgVfzAYoqhT6EnLovl00Blvt6uxgYHQWIk7qejoDIY72O1vX7bMtAKuQGsHKRe4OBAZlu0JcxzC1Iq9vPLj6uoDnQocEJEF5o035Xm3BG8Ijx/P3pPjCLx+SC2Hu/pkgtbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=blP0cPq0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MGiiRrJH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="blP0cPq0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MGiiRrJH"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64853i1m2531198
	for <linux-mmc@vger.kernel.org>; Fri, 8 May 2026 10:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+w04sk/QqE6sVNwCM1HTs1GC
	GouwNYCMOitwb5SBeb8=; b=blP0cPq090n5aMnsWDcZF2Zea+YTzBHOYqRaugp/
	aBR2PkS6M9wrHSCcQnVwb7ghq75cpZqGLnwjo6jCBhp7QMeOqmlVmt1tDJukrbeQ
	MnH5+UYgN3zDlzpxGHZGoR3M8cwq1/NRnC1a58Hz2+Cw9rA9Jp7iJrg7fY1/YMYQ
	F8i/5s9DxZRwlsJcCbupARkdnNMvMKlo7o9ww89Giv86HWg3AKTkAguLjqCoDeYO
	D9zA1XZkmtLuO2cwYwpTEi8WqXTR6+0DjG69XdxVB3JdHQjxjdUVYM40vZZNVUjb
	mjyj9bwW8Z3yaOpsI+80xCWh4SN/kMOz+YHoYUf6Rlo95g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e10m9tv03-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 08 May 2026 10:06:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c802922d230so984402a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2026 03:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778234791; x=1778839591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+w04sk/QqE6sVNwCM1HTs1GCGouwNYCMOitwb5SBeb8=;
        b=MGiiRrJHoMXWtxlzb+WJ8KtHjha80bX1bo0hMMWs0Esox2x1CyUqbeMXytXxaBRY9p
         Ad7843lenuy4JTx+I6YUaABerPqVeO1UEULHlS0/owrXUjp/B+oKdYqpA8eILJDxrCL3
         JgRfI/GhQVfJbX9z0JzLxVlIYzjcNjdEIGiAepPy/h6uo3uRB/+xndWb5LG83+B9XjVA
         W0nZ2WWHJXAVHU86qUyy+UuH6XttfVbNqIw73ndYSNve/wdjO+i0n5qdoemdPpTLxPNd
         sMIr3dxl1261JEMmbnHfcS2LBEO1ojRWiMMzFXgaFlN+OcXOKmu3n++n/qqJYGyu6XV3
         ukBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778234791; x=1778839591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+w04sk/QqE6sVNwCM1HTs1GCGouwNYCMOitwb5SBeb8=;
        b=qN1Lt97e3WeH2ratVDDzX+bV+shEJ53gmOxF7A4OXQBLrxgddmsCXHMtN1/jYe/fzu
         x1AeCN9sqVQgVnVT8yhd7Eowj/xirDPv7am/szdkAhcn2iDC/QzP9hMB0WeaSVPPz/GP
         uBMxxSWFfQlnt7NmgSuxN8Uyi/CUBcZzs0h97aOoqrKzT5so7weCIv+3l9/Ay3jm7n+P
         hzCIKoPY42gBOYycGDWDHngGrIGBUCzzvg74/p8yzLwr2R/IsbKSvWCMTctQcrzfzkjs
         EpQmfjF4gKqmLh3HFYP1zOvEgtUoswhsCWjZt1kJqA/4Eso40m1kHfmtBrlTZWywff7U
         5sQw==
X-Forwarded-Encrypted: i=1; AFNElJ9r04jlSXo9mYf1FoY81evr3dO9Q8EMZsav0pBApzzphaG+XwvH1gPKU/NlF1C8e4dDAVZjPtzlo5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2SlmeOsnRT5MnoH+jGGFgSCzuDuLhX4LZ+TYw1iFsT8SXlx2U
	52eNOBCP5OdOmPAmSpxC3rGNe/wEZO8IpEIG9ozdsFu9N8flR5ttKRLNAPoy2c+d7QdtZp8zSjw
	0lg3e7NTY9KUuZrF0cMt19uQ+ihJn9DPc0PztCuBdcDmZEtdAz4lzmYdux0pH/Mo=
X-Gm-Gg: AeBDiesaFIoeBQ3NqATuHJWGlw/gHkADF7P95yNWnCK4tcJkZBE+PyXEP+Sp6bs8Iqf
	rrRnro7hD4EaOuWe3SxT84TXscJlPrc69EuPJqkdxf1TfR5lRaQwzWvkoHMiWFAq6cqv8RHWHRg
	daKlKzkzXyo0LjYUt7NvWfxy8vRSLSLE9/S44EK6tKTR1OGo0ZdH3xQP3mcUh0LlJG1UwrUQzpZ
	/cUs2KOR6tY+37iaiC1hjn9YOYvS+tVSX1r4N0jfE94ul0EnC+pQBhovUvmHZ77sr1LLDRMbYP2
	eSKoqaZKIzJHVENL1PQTdg4dDU3j2rft7k/TLm1NXZqh9TWMakGn8Muz8xFmvoabarlMYckV9o1
	nVpjqHq5JBeOBHZ0Y6R9sfc0SmC3wABwWweMxnj5mvPMlvjuoq7WPY0Am
X-Received: by 2002:a05:6a20:431b:b0:39f:df57:ee7b with SMTP id adf61e73a8af0-3aab136e1efmr2355268637.21.1778234791586;
        Fri, 08 May 2026 03:06:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:431b:b0:39f:df57:ee7b with SMTP id adf61e73a8af0-3aab136e1efmr2355221637.21.1778234791114;
        Fri, 08 May 2026 03:06:31 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267726df6sm1353954a12.28.2026.05.08.03.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:06:30 -0700 (PDT)
Date: Fri, 8 May 2026 15:36:24 +0530
From: Monish Chunara <monish.chunara@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: Re: [PATCH V1] dt-bindings: mmc: sdhci-msm: Document the Shikra
 compatible
Message-ID: <af21oCp0/OHl5lHi@hu-mchunara-hyd.qualcomm.com>
References: <20260504071334.1061325-1-monish.chunara@oss.qualcomm.com>
 <20260506-arrogant-warthog-of-holiness-84ceea@quoll>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506-arrogant-warthog-of-holiness-84ceea@quoll>
X-Proofpoint-GUID: l6y_XENn-4TNuMXtn0I0c75XYM1jpLBJ
X-Authority-Analysis: v=2.4 cv=VP3tWdPX c=1 sm=1 tr=0 ts=69fdb5a8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=8CEDOdzbXjoYQ81OkigA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNCBTYWx0ZWRfX4TyHrtQXaZ2T
 hdhIgsJX4LZP10gxKdYb1/rjYVdCE3lVoPpFVNsx2LdW3Mhz3G6lQ/mD1Z36A+1SgNWH1VRKWh2
 evcUgR3XwbbkuTjE3SurWGwVtw4ZAdmS93xaw2IyT9uKWwgp+jks4OHjNylrv1LVJ00lLDlBSLh
 s8PnLQvAQkpwtOy2/x0FqtBJhGBpHAPae4Tav5tuhrcFi1j5gJGF8cNaoHMYh9jNk9Xhy5DOKzA
 3p9qnTMev3W3d6uFGDDUbTXe5UrhYmP81Mj6gm+gYMMyYGwzj3SS76ORMmrlpodQUwTwyrkB7R1
 KHs4Anv9yZ01Nb4ckiJ2fgRx7WRyjVEB8AFV7sTdQKbbpJu3F8el2nbHYygSteVuZYepqwsse7y
 4eTr7Qk7eGzL33IIFtXiCxGt2pFGeljuxyfnVM35mCrpn2pOB9fuNlG2MG3G3wF4vsgjIS75kER
 g+STavAGrBNKEUgjH4g==
X-Proofpoint-ORIG-GUID: l6y_XENn-4TNuMXtn0I0c75XYM1jpLBJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080104

On Wed, May 06, 2026 at 10:23:07AM +0200, Krzysztof Kozlowski wrote:
> On Mon, May 04, 2026 at 12:43:34PM +0530, Monish Chunara wrote:
> > Add the MSM SDHCI compatible name to support both eMMC and SD card for
> > Shikra, which uses 'shikra' as the fallback SoC.
> 
> How shikra can use shikra fallback?
> 
> > 
> > The SDHCI controller on Shikra is based on MSM SDHCI v5 IP. Hence,
> > document the compatible with "qcom,sdhci-msm-v5" as the fallback.
> 
> And here you repeat or state something contradictory. So shikra or
> sdhci-msm-v5?
> 
> This should be just one paragraph where you state the device and its
> compatibility with any other devices or interfaces.

Will update commit text in next series with better clarity on the change.

> 
> Best regards,
> Krzysztof
> 
