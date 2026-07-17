Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F01B39B960
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283707; cv=pass; b=Pl/PV5xxAKoE7FjozrRL+WtCkPVnCBfz+oISVrS2xNJKf/I8jh1ArMOKmTFxAsBHwjwUHy352YzSPCZCYc5GK02Zvu0q2tbPGATovJoNrrPGSYIxEdtyXDtGArO+jATylSld6kADCjqH68cjy0uQI8wWhdQd+PKL6t8wnsfC1Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283707; c=relaxed/simple;
	bh=/G4+gIUlSW9w20eY18zrYk65ITLGo9r3/SZkfk+RMdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+Lb42FpXfVD0WYHutvH4q8RvWJNPUp9jhqEuLQhFPKXHIrSTfpL5Re8bNGCZ7X/yr93EmAcsDvVo+rleXmE/WFXjMvzTopb5NR40xPOWubqUf7zS18H9l/oVNOrqOySUpOxFdQ3gDEnZv0sEPunAGoFTA/5YmoJGHDS4PSO3SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cBNifLEv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ayuTtwXP; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cBNifLEv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ayuTtwXP"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6cRWJ794339
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 10:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dNQ3xUEu7rEeKDGZoZN4sDPkrMPXqT5TEYjiXqzqNpQ=; b=cBNifLEvBF3dlMDu
	q0RtTkWQW8q/RumeZGb1An4tC1S6kUiqpRwvBJBtoXJs7riIhYJY61Cb/oMK87Oq
	F5+/6CHrkLi//+Apm/3yywZQyFrLmWXCTlAKUtJ6Idm9ALdj3VZNV2Rk3PYeLKxY
	OuOsc+mb6SCrtgt6TodcTK5NJ6wDcP3l1CLCp1+yWOzT50HHTTMiE6LCltGFSpj6
	gJZPzgbLp9SZwmRZVUiQrQXoFD8vIKj+WVINfuRRv4q8anXGChdaQn/BXIZ3Skzl
	qS+SpQsv60MnV6UJkoFiJQ8wog5VCADNVV/uVEHk+R3FFpSmAwDgyT+VQWvYCMOh
	kjeFTg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u8k8w0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 10:21:41 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81e68281f2eso121548077b3.1
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 03:21:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784283700; cv=none;
        d=google.com; s=arc-20260327;
        b=pzXQc+OEDSLh+t74yW9e8LtJwXUqwKlsCxZN4Vpnya2oZV2gqeq7BJCEZjVg10LL5B
         zLZkPsxQks+XWQVg74jluQP30lXXXpgtX/QvCWuqDHP2kvcWLqJzqLRZ4NlUshcOq3DG
         3n6NnxqzWyi19e3X0pxhpv+pxqYOfgd2CNHmTN1vWJeNfuM8UYNCmSOT/tzr60lTiWMl
         VseLieOY0KHJuVVsvUNHTwJE1xpOiyaLaCqaUmyG0KPT1p7RLNygv11090pxDPuyahYj
         BvZibJsNBXLaV46YJXzADOlhUoGFFZPEAs8T/uZAFdUGrWE6yMRPDNUJa3BvWzm5A2AJ
         kqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dNQ3xUEu7rEeKDGZoZN4sDPkrMPXqT5TEYjiXqzqNpQ=;
        fh=FORjSvzxUwx03P9a44OTGNGDVWD4Vhe8p2WLpS3Gvuc=;
        b=m6xIIxgFjoSFmdcxJ3+Ziqz6bLrvRlwIcFRcnw0iISL3T8mzf+A59rrT+yv5Zvzv/0
         8grXuzv82qm6OuiTbeuz8PYbvGg4JtrWhg/+n7NcpJgHDOJr5cYA97UyAenlEQPiHx9i
         3ugbmub1ffG4FrXdJstumsxPZ1EjNAoN0wMk6lTF9up+qZPCxXLgydc6gvywSU3OAG5E
         H7z/ikL32jMxqHMWdahOSSF80xDwZWDZcZmUntZXVqj78S86dlcGtwuBNRmika02Ogy7
         qqEQaMJjnUkMZuNHSnjWpY2dz6nwKxFNY+kJ3mBfjaat/oZmsST69+GAPHzMOvEU2BhL
         yoEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784283700; x=1784888500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dNQ3xUEu7rEeKDGZoZN4sDPkrMPXqT5TEYjiXqzqNpQ=;
        b=ayuTtwXPhVP+1I8SfKWP5CIBHd7kJl8cntV+xLgBxuGimOyfn+swUULWUiRqONEXFr
         WMcekKtLtajoVsfiiQUJlDSRHW0IzYoCXVzGK4G/DWihTic4D/5k1q6M75VREo8NwSIh
         CeUReBW/XjupqFdlCL/8Ql0C894Skumn+RdR/44wzqqpmxwFQqurdpD40AXX1jQa0Rtz
         aDSG8SliEbb7wPyLE/S3KHNLIaVxvp/O7F5QS/US5WhgBqm1bYmf9BNiRSy7IDwOvi5J
         vQpAkSd4lz1EyLCaKnA1JYErnhHEII9ld8Dmol5sLZbmX2q5IMqk9UfxZ3B3Q+Ic9hC5
         bLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784283700; x=1784888500;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dNQ3xUEu7rEeKDGZoZN4sDPkrMPXqT5TEYjiXqzqNpQ=;
        b=gWZqHktti4Gaf4ihc3NHkFQAxZ9YXkVYlhuH6qF4VQ14Rz2iJ46IruDu/OqSwC9DdS
         1QtVaY5mOwrKhJ51W8/4zfK/+rfuEPmPPH6+uEQliGsaX5syl5Li98x3MxSUGEAcRnfA
         t2GpLVL4mlHhOg4WndBuOQ7VxLw7882wzi7/MQewpS0CLflp6z0iapsOccT7s0AnhyQm
         GW0qYl7+xYU2uJR10Qr2ba6KGX0thfQ8qtllwLeQo1FIVz58ZDHA7znhYeq1S8RDmg4G
         qEc2IsvpKdlIhNIgokaOj0TzOzTfHy35mIbZ7IFuQN0m0308Pc3Em+Sl33Rs4+O0Eu1i
         w9yQ==
X-Forwarded-Encrypted: i=1; AHgh+RpD7SWYQMpDBkj0tpzpQARdQIAqFldVVtR9nUoGHRa/1jMvImM7Ivb64zP7BeOlUhR86e+nFnFgfoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSJ0BLu2uvGHezNuap54rK4q9XaG8GsPsEBgRkbXOVW3g464O2
	S3KvKJojO/hXc+1h64neTzgtmLE1mLO7/b7z44ISWQY3GQfBUieWU1qhiq0jTYk1sHB2pIe8+Z0
	W5idmdIKxmK5K9hWvUd1OpspGj0tGoDEHPpPpxqeaYVOgjq4MpT7bPXBxDN6d0LjizzeVrq/a0s
	T1lAYRUey42ecJycGiSe4XwpHieCGoSFLBop3XzQ==
X-Gm-Gg: AfdE7cnG4AVOKAEAGtzHckGplXCgrI7XeSm6AiLHi3PzrCj8L3uxf2649HKtSgnaLCZ
	fz8ETPYFt5sthPEFQEivMrpA4vIH7XvtY8BB1buFvNiAksVIboXeR7aVQUdxctE/xQudt0LCpjQ
	e+19QWwtucBUnSHdVzMGr0C5t+92PBD67FYxHPuWPoRSBWVmu14BSA1Q6vPw==
X-Received: by 2002:a05:690c:eca:b0:80b:968:29ff with SMTP id 00721157ae682-81ef283962fmr4760877b3.53.1784283700290;
        Fri, 17 Jul 2026 03:21:40 -0700 (PDT)
X-Received: by 2002:a05:690c:eca:b0:80b:968:29ff with SMTP id
 00721157ae682-81ef283962fmr4760837b3.53.1784283699924; Fri, 17 Jul 2026
 03:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716232641.2659710-1-jm@ti.com> <20260716232641.2659710-2-jm@ti.com>
In-Reply-To: <20260716232641.2659710-2-jm@ti.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 12:21:27 +0200
X-Gm-Features: AUfX_mzSz06nBydsnL59jdtc7LlWaatmuH2qAmiMtcQw1WWvAMpZ2E_IF3c5_YY
Message-ID: <CAPx+jO-a3+mv2msL+12Ag-xs33es2+Wxbr_uKRMY3rbN7eL-cw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Add post-power-off-delay-ms property
To: Judith Mendez <jm@ti.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: B50F0bLIiEFkE1olZSI1q16l_BdpJ6sD
X-Proofpoint-ORIG-GUID: B50F0bLIiEFkE1olZSI1q16l_BdpJ6sD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwMyBTYWx0ZWRfX1xhLbqvzUZAE
 U8DM2OlRshwAPUDsVgVzRoQNRbsgoox5ODPU2vLNUTWHN4hZS8QmXTyfObvomPbPtl2VB4Dj3Ye
 ZJAiSn3du1n1Q5NRHWkCWrNpa5Wbtno=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwMyBTYWx0ZWRfXzET1YhsIJPxX
 6W4cBUwGL7Xpq/S1ACBvfv19gslDxisaPB3TXmoPlBfU6cn4AkyYnXQ9AiOO43JO4ATnp9JEMEN
 OUz7BHkMGC4KFwtjOIlWY0kkjJdJ/OcWPZ5bOGcS+kaR4oueyISAnkXH9ShYMhTmF2l/YSJXViF
 Hz9LBNOJNuKkCdUyGfVvplnk1O8nY/MldmOzIYkv+S0kslvkSl4+m8Tg/O7kGRXbVIMc601Kty1
 VhgrJYonRbZLLcmhtPFAI2FxXtH+sjIkxDdKCwTS8fGzS1GnWu8kdMWaG9Qi7GDLcaUocz6Sw8U
 aKsk3YS/aXXLiDYeKGoV7739Bx3/E+84hRz+tEbpkQx2Mv2NKQZZnj3LaET603vMAx7zVlNgVFy
 Gp/I3QfFKZZ3iHVz3fXSa7Nbf/PpO3qOsubD7TCu+gOskJsp+Ys9/tAbMoSyUOmnj4Yddf1WWoY
 IOr1i5VzETHF+hDA9uA==
X-Authority-Analysis: v=2.4 cv=TL11jVla c=1 sm=1 tr=0 ts=6a5a0235 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=sozttTNsAAAA:8 a=dMylU1riQLpZtJOQe0IA:9
 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170103

On Fri, Jul 17, 2026 at 1:26=E2=80=AFAM Judith Mendez <jm@ti.com> wrote:
>
> Add post-power-off-delay-ms property to MMC controller common.
>
> This property shall be used to specify delay if needed after
> deasserting power during MMC power cycles.

Please clarify with some additional information from the cover-letter,
like "specify custom delays after MMC power off to work around
hardware issues such as slow RC circuites on MMC VDD rails."

>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.=
yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> index 3d7195e9461c3..3ff68d32a308f 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> @@ -275,6 +275,14 @@ properties:
>        not available.
>      default: 10
>
> +  post-power-off-delay-ms:

For mmc-pwrseq-simple we already have "power-off-delay-us", perhaps
better to re-use that name instead.

> +    description:
> +      The presence of this property indicates that the card requires a
> +      delay (in milliseconds) after power off before the next power on.

Again, maybe something to indicate this is specific like "specify
custom delays after MMC power off to work around
hardware issues such as slow RC circuites on MMC VDD rails."

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 10000

Are the above limits needed at all?

I suggest we add a "default: 1", as that would correspond to the
hardcoded value that the mmc core currently uses for this delay.

> +
>    supports-cqe:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> --
> 2.54.0
>

Kind regards
Uffe
