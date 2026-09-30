Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA04F4CFB
	for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784280; cv=pass; b=RfmzMoCnyfKSJrN572ttRP+zQFufa2hy2TA7Gru8IzCoIucP2vIM2ve/R3xYOAA10HgYLyVMUp134SHas9f113ukjIHpwyW9qKmyTLS4sHxKheO02/aT0ZRJBBoIe6WicMI60lxuaCddbyPVSmhGOidl3pADCWHRDj7ih/H74qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784280; c=relaxed/simple;
	bh=n9fFaAGplQpnkm7Vf05iAz9kVcqoT3sPQRPD8gh+bT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unYl64FtUHWNQfi/3BgbdosokSRNLafUhNLZg/Ec+1RcEu5E73yUEtW3w6pMlDRn+MoSxMJDE4Z2YsVLgZrjtHfFHNdqNtTcGvdXfHQjnoi9HOhj4HyMGTpyJqjOxcVmQwjdUe6M8RN+9AKI8d5sBKtSS4zkDjC45lnVuSSGubM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L2APh1dR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RO2rSfXm; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L2APh1dR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RO2rSfXm"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UDxwdM3930157
	for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 16:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q3ippA8C7Iwe5nc7FGsk21TPZKf9tVMwe28Hxh6J4gs=; b=L2APh1dRJOerB4OL
	P1t9c2Y59+gGCoUq2l/4h21nVCaB6uiOsOnQs84z5r2jb5dQA07xYsNnISKluWxn
	7CFAtbAIXKXYSUxMLmfNC7azfgIe7g+Loec7Qk+0fFKu8dqZjJPFQWS4R9Prs2Ar
	W7y8ul3qjh3icyQuf2mIhTzslSdyt9C2IrOvNeK3ShQP7oAccAQojUDmrSmFYkUh
	iIcKFZJjrBKHkqaSn1j2Co2qBk6xUUK6nn6tKiwhEqSZuNSBPS+dQu9DelDXLWj+
	cURjdM0r1AURAAS34VgIi5K6Tr5RQCw6vetpbGX+pRIbWhWMUUsmgJukfZCOm+sI
	Ze7mBw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0w142h1m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 16:04:33 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso8555879a12.3
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 09:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790784272; cv=none;
        d=google.com; s=arc-20260327;
        b=GaaCkdtrZEri+cyDsLOwyDHMY8fP2dzu3csw5z237GBoGGYnPGLGCrF5/Xa8DYf9TJ
         dEoSsAFfq5dg8nFym3P10Bq6VX8aOAPQLpMYgGB3I4Vimx81fGn+TEg6CV7sFOWpkBmQ
         g4kEJx40fMDd8axKcRe/8Pm+xCEuss8i/bkqOFrBjn/WCnD2xR5vnsFXAWAqU3BF9Wsb
         per4HFsoZWxq7d8jxHcAF4NKlum5PT/KSdm1jc8vgybZtWP1b5q7aIwfa8kIlAsITgFn
         53KvMqrprjkPSLUkFqziFhUpTjuegYpAUpVrbCt/KEgqB3du/8RGN3brZVESLAfjLHWV
         ybHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q3ippA8C7Iwe5nc7FGsk21TPZKf9tVMwe28Hxh6J4gs=;
        fh=ct6pF3D48UuOlozV8gZiobQutFMifMzuG/ulfZIJOUA=;
        b=Mg7/p+pI70LIb6k2WhlZMa18ly3NrhP7V6tOkzfjUYYWX/f9AhM4YYD6te0sdUKS+5
         nbqLpAWBj+NSIziu38Mph9J2xeGBPETyAZXaCDVtybYGfppHijCSbcuhxo85BKE+pQEG
         49yBqw4JeanjdMgfVDZWJfuaR/PmjfmJ25hIy7C/W/hqmfemAscXkVTPp2mDf3KwoBdP
         HGP+jdX8fTGp/XkDmFapJ2sVw9qYh4bUwefcdQKzhGc4TIcNso7k8n6SqizjPM35nHuA
         HAOTR59EtSsDTFQlGUQBJdo0U0+SV0VF18EUjeKMC0X5m3HOY09CZaBTHGiZ3ycQhWv3
         sUIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790784272; x=1791389072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q3ippA8C7Iwe5nc7FGsk21TPZKf9tVMwe28Hxh6J4gs=;
        b=RO2rSfXmsKWLs1sMhLdxwK8JkIH79EieW2q3q7ZeeFC58GAkgQaJQU4n+NJEUv3Fwi
         Ep+xxeE0YDTkdJlifhishOsGWO/ke3PgxnX3bDHsSYlGfnUwVTRLANTtUNXB83oAuAJb
         G9iiHBVCLkTU3Tt7yuWQ6nKj/F0+TQppHB1jNlmfQlr2v6CQGgLJZIwdwkC9lh0+78s1
         wQ16ZRhbIviafyOZfxElkMLfuCK4Zz+rfQP4gmI+eRuvGFs3PuDk3U4gUVEkIjY/dSTP
         uMyMV+WdyDpEdufrBlLqEqVnmoZs3gbjzX2ACBWVnceG7TBE4viUL5zlOBAhT9ybCmR4
         d6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790784272; x=1791389072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q3ippA8C7Iwe5nc7FGsk21TPZKf9tVMwe28Hxh6J4gs=;
        b=1dRrp+nPnOp7ghJD9pQ3IebwBOfT0vlSEjvcR/LfVGEaTmPRPZXI3SnEPIGoekvt22
         KWkzrJTbEu+yytazmdnLbf8GZ1t7A4g8MANvd7VUzTBuZnbA0utWof0nBhIJxieVa6l7
         ErXvZqqIvxpngkj7Stbq8WVppx5riNw19Av1P0nscZ5UO+DQMokRVOFQPYJ0PBJvmOd1
         HFijQZ3mDQyKzE8VGQtL6niIyDMkpNbjNjFCZigxu5x+IY1lLzlVzSONTYnlQ2rPd3so
         V9dg6a8ux+ENoXvazCJSOb++U5gv6XrrZHbPAk40wCGPgtLx28V9DMRYQhme+bRIPWDp
         6h9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxRh3XxrzfjY54dYpT+68g4ufMVoHLURvMNuttwFP6+SXhWTiPoCIX2xAA+yY8R/TYeh9rcBgQ49Ns=@vger.kernel.org
X-Gm-Message-State: AFuF++lwQquw4UT1kFL7WPoIajhpTEfzHFZBt7JVk/0Ny7VinnFIsZTT
	Ji8GufwjFdKY/Ft1Ppxji7fkIIcTASCF9E1Sx+b9kwd5tsjFji60N91sE8rnnckIGcCOHREIBC4
	xdY4Pj63g+ekeFllifoNLafJ/eMS2HQSWuC3a3Hupw5AU0Oi6j6A5i6arOLRTUvCZLDvSin6+P2
	JtEo6WWOVjVUyH+ZkO11cmONBnolF3oAn0EhupeA==
X-Gm-Gg: AYBFou3WnMJPbU1kbUqcw9kYkMp2z7u3b0PMcwe303RFzGroot+2NoEjbp0DpcTaNiQ
	/1j28LquHsUz/QTR3VsB9Wr/LUbGAxe060r3wANil+iVTOt4kFJykIJ3nK7wPO9nMMhqwBVvy1m
	9SOgeAEXq2b5wtiF5jRiVy6ekQGkVKCgYVu1kROzO4VgEKOQ/1LJ3ihzw8aA==
X-Received: by 2002:a05:6a21:4cca:b0:3dd:a197:edea with SMTP id adf61e73a8af0-3de9e8b7c77mr1829496637.57.1790784272529;
        Wed, 30 Sep 2026 09:04:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cca:b0:3dd:a197:edea with SMTP id
 adf61e73a8af0-3de9e8b7c77mr1829465637.57.1790784272140; Wed, 30 Sep 2026
 09:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927151016.186493-1-pmazzini@gmail.com> <20260927151016.186493-9-pmazzini@gmail.com>
In-Reply-To: <20260927151016.186493-9-pmazzini@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:04:19 +0200
X-Gm-Features: AclHuK9W8iKpxeLaY0dvpEbGt-kGPjsZMSlSCjzDyfjFsqRteSj3h5zChvT9XB4
Message-ID: <CAPx+jO9aML0ABRF=j36s1HfPu405L18X6VyzppyQv_N10JPf1A@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] dt-bindings: mmc: sun4i-a10-mmc: add Allwinner B288
To: Pablo Mazzini <pmazzini@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel@sholland.org>, Ulf Hansson <ulfh@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NCBTYWx0ZWRfXyunNiohM2muA
 vBpwLBRlgp3+QzZ6npTzHllJGFmPQWLXidEp0oIeRO8+g0H/DDP3IfQLwz8FY3K7j1gFO++jzHB
 HELh7sp9l6+WILOCfkm/zLgQeItP3mw=
X-Proofpoint-GUID: fQGTOwZ-K-KsiWykhWWHl6HzEghQcccu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NCBTYWx0ZWRfX+2RVUHaeM+fL
 2LUac6ZIug2tuo//rJC31Zz3ZwHmY8xovxNP/hQ5gWspFubHb9p+tj4hxuDQs6baYFykVRMOO3m
 5MaSoU4QWh6ht0dKJI28NTDZpG0vxWf7DqQ5PCx/Qlwckp0WYppBa4O0xf6VAsHFhuZg3oY5JF/
 rvF5zA2BL21k/2s5dw0xUAFx5jKWKgULgWPwdT23TNzR7hqbSi1psBJYTaFaOHw+kPQOa8EyYKv
 tDdqQJlQ2iMvuL4yOa6/l2+qullj7SW1kewnwrGELv1gJKqCjEs1T5FEDILsnPIQlEMvrquKi2K
 sU8oANBq1kv00VLGqYr+yb5eiB9N57Q0/cLfEk4PJOO8/TMW3a0HI5ldbhRMaihqR9dONxe1s8V
 e90+oEJUeJxZMGHXjO+GadsdRciJnw/Hdmhp4c6988jHjA3UjvQENAHxC15Z+koJZ9/lwRQWN8H
 rEVQEeOtGkUcev5ifzg==
X-Authority-Analysis: v=2.4 cv=J8Q/fwnS c=1 sm=1 tr=0 ts=6abd3311 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=kqsBenvbzo-VylAG1WUA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: fQGTOwZ-K-KsiWykhWWHl6HzEghQcccu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300064

On Sun, Sep 27, 2026 at 5:12=E2=80=AFPM Pablo Mazzini <pmazzini@gmail.com> =
wrote:
>
> Add the MMC and eMMC compatibles.
>
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mm=
c.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> index 9e9610bb1eda..c2ec7151dccf 100644
> --- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> @@ -32,10 +32,12 @@ properties:
>        - items:
>            - enum:
>                - allwinner,sun8i-a83t-mmc
> +              - allwinner,sun8i-b288-mmc
>                - allwinner,suniv-f1c100s-mmc
>            - const: allwinner,sun7i-a20-mmc
>        - items:
>            - enum:
> +              - allwinner,sun8i-b288-emmc
>                - allwinner,sun8i-r40-emmc
>                - allwinner,sun50i-h5-emmc
>                - allwinner,sun50i-h6-emmc
> --
> 2.53.0
>
