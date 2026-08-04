Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D8443D4FD
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850980; cv=pass; b=tW5vnhKRBmT0wKhtMSqi0FshG3yyLER7grgqMt8hf8Y3/ROKM7foRG15WH7VEM1k77tt4J9WOYwYS56kJRLZjB05vXyeE66rX/pApu0Fpcbf0aVHWJvRfV1394vuppwSEq2/mYMCmc1FAI3iNaAro9aOyfH5J6xLYvQhuHs1jxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850980; c=relaxed/simple;
	bh=O7wUWXDsY3uEeARPEMMNmbRY52q+9eneHeaJu75kFmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoSsPHxzIpschaVZ6354xikFjjqXbbYdERFiKrLdjA+QWw2gDOgisWA0WcIlOSwjvPl27AKFBNh8qHrFG57wUsHFrPmTn8VpcBlZHeL4CMI038uVZNI3C88N6VYuREZJUd6ZaKFXYqLAUwDsLxyqngeNQ/WYmsHyTjA64pkxwco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=beU9q1KW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S2PIy8xy; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="beU9q1KW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S2PIy8xy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CXGvM4130153
	for <linux-mmc@vger.kernel.org>; Tue, 4 Aug 2026 13:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+XvvqE13EntW6712+NVvxyzFymgdbvIBVB20n97Y8Rg=; b=beU9q1KWcc06i6JJ
	HtF1fUhq3CAtPEl8gOjF9N4gv0zfw5Ow7L32WO5Nyb6JTSQzThP08uw1bvB+jB9H
	p72I+2joIZO7aJpHdXSyN7a84jSRcUB766b9UlYe9tNfPsssLbsSvXuBeSb6fvAi
	lqnAGOlTolGbaARO2zONpEP/kGWuocvmZU37VDCMSHHET21PnCcpRgwGxlYIb4bl
	daB0Y91CdGDn0h8plEws9tCV22C1hF0xXI3hDBB8/2vXMvWSeTKRAYFO82jToe9u
	7Pa8wv3cnpqFvOvhp3/tTangOX6WVpgDFF1TfeY54eSoCgFo8am6aEWAUrsmaVXG
	qGffpQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fug6589vp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:42:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0199faafso47843241cf.3
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 06:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785850976; cv=none;
        d=google.com; s=arc-20260327;
        b=p1x6yQgAvu6t1mCSx5y60X8FylDwIPZ5trUIqpsihZ/2FmiVqztlgVMotT9uHG3EY2
         hCfYCNZb3SeKTkJon6nFDTjWIISmDksEn351rHdpPsb9T7okMn/CAsZWShV2feUxSk78
         QUZmyWAaupC3HHl6cJxEuv/AA890QIiQxev824V2kMeE8LN1zlmq/KrtfuZmUgTBpCqW
         c3dvAZ4NzmUJaen/TxBoRfCdXjiR4UISixzYZV44cQgQi/wtDrbXcxcUk3NnBTSrgKIp
         HiTGQByOEDfTIIVsF3YCZ8PYzrLGW4nkhisgVBVdco7vQVAck24bLNeGndh80NlXRY8a
         5Lrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+XvvqE13EntW6712+NVvxyzFymgdbvIBVB20n97Y8Rg=;
        fh=3A+i44A/WZCf5QUigAYi2glAnPGtKUt9ZXN1DXJr7jo=;
        b=ZyYryeskOYalygga4A20RYUUAGlzSkNSbAgBxhTD1PCAb+aFU/VKNxbpIv8zP0u4N2
         xhDOQDz1Y2uNJpt5ESxP7k/KEMRv5k3D2gL7YLYRihDJl/4tiPnLe3K8JTKmU7EwFShg
         ztopBpJBQ7qqTjJfVHlEVXQK8rqJa6MAJ7Ib2InxGEJC482pXYONrOJJNvfUMtpM46Yh
         cx3mJseC8gJPHgstJNRGVBG+l4Ye/58eyzoMe4fB79FpjCP9FaFiNGovCfhYBjMSHs9m
         l6jNTBsn6xQwPuDadf5MACySmvEdPcJeYT+2EdhDzwQrQZhszMCf3t7G1P1AFuQrg9Mk
         DPLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785850976; x=1786455776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+XvvqE13EntW6712+NVvxyzFymgdbvIBVB20n97Y8Rg=;
        b=S2PIy8xy3DKbBKm+u++aPUWcYTQrV6hgEbRu1lIXDVObWle27Mm2fs3eibctxGEgHb
         jdXn5IB10OtlWHFJSQJqO67QATDoktdVS2aCIm01SoBvJb+9KXPFMoB0MxFDYvHnrqm0
         bYCg1jhKJ7McjZu9CuhHxrR7A+gYAoF4wPJmoD1+eaEbu8DbtFwNa7bWB2D+g95pG9at
         BUPSwqyJV9oyGfI4dxvygulZAgcmHCcnWzlwdn2hfh1qmTN1ylcJ1NtWxgrdwI4TWWoK
         AyDRsG29MH30pVLWn1afiI6h5rpL7o1wqWFqJvWV8/Pcnremt1IgNZ8B/0RmxF+TX26C
         hO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785850976; x=1786455776;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+XvvqE13EntW6712+NVvxyzFymgdbvIBVB20n97Y8Rg=;
        b=FHhhYYa6aek11s1XRA3vCC7xzGJuvKRnnYc2PHJVxvzvtDLqg+pwWAQFg6Aanuwujr
         cfA0KnwkD1mac46ZPih0qLjzIX83L3H3eneoO19A3M3emaPfv3h8+oNvLjyIjRfLSCsI
         05jJQ9qc4rMTBAFdYRE4JFta/nkeh5F0bddpwdxSVJR7pg69mi0wZcmU86Jv2CuoS4SN
         QmBZCUAnzVzT7OUsr/Pl/RR6sYS/CXd9oEBpiqAaDNWCGNgk+AoNZXUWm3Q8pfSTtu8/
         lVtAmm4RJXhWcmDs9tZbN3wkc24zUxDalAWB36xZSmKe3DoR2uFrS/0IHrXAnIoPHxi5
         YV/g==
X-Forwarded-Encrypted: i=1; AHgh+Rp5PMqU2+ti9+EEDZv6Q0SiG8964mmy5js+IoT2WKr4qox0paGopWxbhx+s0+2ximXaRksxYB+AX9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyRyHGWp6bFXSnyzl6eawTygDAGyIeiWivN5AUsgTOH6p3HrNX
	V6GR/k/uv06yro61G8Du0wY1KEAJwMlNA6Zp3U0zBZyuNaa1xZIjxblx7M7O28ELVXiNM8Q7kjS
	BOBQwiCVnB6O9ej9ll45fP8mvK9rKEYJnUmJi6zlSKPwJEAWyru0+ddEZVEfCwuCW6GRim0QN7b
	S6xxhn2/dlNtNqreblRMxFMRapPhBE195ZZGZsaw==
X-Gm-Gg: AR+sD13qp5C6qe9Ly0FdNdz+yrKblzck5HnK6iCgY9+PIoMRc8zOim5pbAw6xFP4HM8
	GP7hIKaFZkaxfFsKhsAhUqlXKuTgwTpXR/IIezoMeeqQvlOqvlz/dQX5O/2bQFBsJTHa0a9ulce
	LuNhEbn8hoRqojTQoXuIHmF/d47pQAvkUyESf7KFgomrWi9H9cTJGogMt/jA==
X-Received: by 2002:a05:622a:d5:b0:51b:fb4f:afdf with SMTP id d75a77b69052e-52b56670980mr263922791cf.9.1785850975698;
        Tue, 04 Aug 2026 06:42:55 -0700 (PDT)
X-Received: by 2002:a05:622a:d5:b0:51b:fb4f:afdf with SMTP id
 d75a77b69052e-52b56670980mr263922111cf.9.1785850975193; Tue, 04 Aug 2026
 06:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724075700.714261-1-pshete@nvidia.com>
In-Reply-To: <20260724075700.714261-1-pshete@nvidia.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:42:44 +0200
X-Gm-Features: AUfX_mzFueV34L91xtuABsfkzdKLs6pi3RDoAgO7ALwwTVDO2DS46FaYhxnqSHc
Message-ID: <CAPx+jO--kLFbs-khz9UX4OUq6yFHTpoZpjwaKdbKoXZwZhm7LA@mail.gmail.com>
Subject: Re: [PATCH 0/5] mmc: tegra: Add Tegra238 and Tegra264 SDHCI support
To: Prathamesh Shete <pshete@nvidia.com>
Cc: ulfh@kernel.org, adrian.hunter@intel.com, thierry.reding@kernel.org,
        jonathanh@nvidia.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: zmCpL585fXI3zTt7TKSC0lkjB0jRCrRw
X-Authority-Analysis: v=2.4 cv=fcydDUQF c=1 sm=1 tr=0 ts=6a71ec60 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=Ikd4Dj_1AAAA:8 a=DZf_on3a76gVNrxzGB8A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfXys6qkhU4MMiQ
 GZjWhJNKMHazhMFsMZxCNiyEplJSnIYdnsN9F6siORnztj+DeRHhscciWUbMBtWQYqLODSBxFZh
 kK/vdvG3hYo7YA+7PsnQVjl3V3xQD3o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX09VhlTfV5/rD
 7/cXoI+czd/fPZBDZK68JwfT0Crlzs6NViSg06bK6Td1oRdLqBq7yj/xJok6yRfJqx2+VPyBJuB
 GdHBVxkL9HSzTytk+OrNw52Pjr1K8r+dFvy4JDn20r/N15HvCXZo+UlSO78yD7QK1nW5+jgvUen
 lyCG5jZ9Gb2Vud/CQKySxeQKYvRaXn7fYi4tgKt/HFENGnpiQuTkqZbQPGR9/rs7maKTsbDULxQ
 5nd3QEkpXue8HAxx1dUiLJtPvhKK1axy/3QqqRY/7pD72u8QuEfNFc/c/Divy+cEu70m1BFDpR8
 0DlcBvpLM49vQNbZNSOOfTGByckfjgalkhzVDJM6WjFFXdN3hQMsvreAH55awCLnzjQFZwcdpKX
 HfBwYrdElggkWQg1Ha4rSWo1fgeI6sRcw2kDelxYpBT4t3rqsvtXxfgm1PVi9gGfrateGkFT1tD
 1Z5mq1+kvDUSZJPpZbA==
X-Proofpoint-GUID: zmCpL585fXI3zTt7TKSC0lkjB0jRCrRw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040110

On Fri, Jul 24, 2026 at 9:57=E2=80=AFAM Prathamesh Shete <pshete@nvidia.com=
> wrote:
>
> Add SDHCI support for the Tegra238 and Tegra264 SoCs.
>
> The series documents the compatible strings and adds the corresponding
> SoC data. It also adds the Tegra264 SDMMC1 device tree node.
>
> Prathamesh Shete (5):
>   dt-bindings: mmc: tegra: Document Tegra238 SDHCI
>   mmc: sdhci-tegra: Add Tegra238 SoC data
>   dt-bindings: mmc: tegra: Document Tegra264 SDHCI
>   mmc: sdhci-tegra: Add Tegra264 SoC data
>   arm64: tegra: Add Tegra264 SDMMC1 device tree node
>
>  .../bindings/mmc/nvidia,tegra20-sdhci.yaml    |  6 ++++
>  arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 34 +++++++++++++++++++
>  drivers/mmc/host/sdhci-tegra.c                | 30 ++++++++++++++++
>  3 files changed, 70 insertions(+)
>
> --
> 2.17.1
>

Patch 1 to 4 applied for next, thanks!

Kind regards
Uffe
