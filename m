Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17595468C15
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850995; cv=pass; b=PXe/6xPYBUffKBLo6H+LKhQezfgNAFdWGIbsOf+PDMRjpedxZbO91YW9eHv7Jo6XFvQrNh6f+xCZMwreDD8PnPSv8zdCMJZgEfCOMyXNBdum9yC47oynLYmlqja2EWSaha93bMndK6Qv0k1m2jv+2Wg+KghNNu5UMJ+XGkD/92g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850995; c=relaxed/simple;
	bh=I5MvKEGC00NQ4Q/IruORDwBeXJG/s5q7GewPycS9nAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFITFmVPUM6C3/BiumHfdaAl+fFKBX3KNOH7byZXOV54N2graWMTUVV95w7UhkbpLAworRNettMMWM8X5Ce6ai91z4IO+4FzBLwy0a2MRXQ0+zrJN5cjqrOfFuU+KcJqUpVtZECOcQjuBaejZ0votVe/ZnZmlSYmT/OYKeSj8ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dI4ZLN5n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AuFqajpc; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dI4ZLN5n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AuFqajpc"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674D34qE3693441
	for <linux-mmc@vger.kernel.org>; Tue, 4 Aug 2026 13:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nbp8mVQBGl5z09DMV5RCuEsVUApOEzt1Ehl+hms6Mj8=; b=dI4ZLN5nAyQ+W8fx
	j0sKvwTO2exEedRbGmGiQorxFmf9S/+d8HSikRwTkd3wOaVj9WRZgT5tEzitjwtD
	83YQcgdGo7wx4vWkYPBGAfE0iLSBjEQBsF5CKaN9yiLse7GFLkHAhbgElT3Q3sbc
	NfRkqQK0c2Dkja+78VIfN79qqjTwECAxdjfz/4FuRiSklY3LyJZbP102yMMXMoxr
	nz0nS1gcohVdrosVtWamhgNn2bXd9gSNRaFsg78BQY0kQaqvAij8HgIpTwGG3BgS
	vIYYdOXo+OjAqtJMZQmRJE4Xxf/kX8RK9ivN/qzyQ4ZA/apONyhF5dvJbPmWp+dM
	zdcWiQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fugmgg5e1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:43:13 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-904c1d588bbso13610436d6.0
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 06:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785850992; cv=none;
        d=google.com; s=arc-20260327;
        b=moH0hEVQAd21WOVzidBF6FQalli0drAcQivW7WtSdsXzfEhRTK7L8ZUy3cn9B5o3up
         19+9SKpnCYXlYxbdS70d0TKw1qdC9RySJb3eOge/wkhjRKvw2Gt+yhlfXh6IIdFFtUhm
         qZ3rwWDaxarnKiFp1f6TsB5YsRJKxhgWh8BVPYczrKcx8Z4GGKD8hUta7iOL0xT9cU7U
         xvJRLqhFwLbQN4dW2b0vs6fYey/nZMkn3y4s0I3daQtM6SpJV9GTdUdG9TyiOSqlSfoP
         rZz68dNNmnf3nQceTuFGLCQr3KTPZODiv6k0sv7NETsBZK0AL7uU1/TA2ytGkDzNUyEL
         UMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nbp8mVQBGl5z09DMV5RCuEsVUApOEzt1Ehl+hms6Mj8=;
        fh=eMPylJXJg1eT7mnu1AEevXbL4+Vtw2cm18+MpMjG66Q=;
        b=dTYg5cvuzV/e53IoZ8c0hcBg8RowS4Bg7v30RqzVX7aIygvHiuPrlIzyHU2PVZI54J
         fvr9668JDz613J9ptqFhnEcZWRkbyaMLK5WQcL+0925+427jQrN2pn7CNmpxbOqLgwjA
         CiPQNnLoeyyoXPx43LqaTSMrZ9OMNkQ6ZmwP6nOTohVth0UvXa73mHludYDhBYPeGTAe
         1pW1w9af1WuPb0UJSxpUF4mzhiraKngGQXUo3LZ6X857HIp1W1+0+cxjS3ydY+JcmIGv
         7U6d2/VzLq+xa/DsreutftIgo0ZxpXVMfc1YrRrOX63Gfg+r2iQQEsO12aqMQM5H5O1b
         Hq1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785850992; x=1786455792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nbp8mVQBGl5z09DMV5RCuEsVUApOEzt1Ehl+hms6Mj8=;
        b=AuFqajpcc55zbr0Nvg4OUAnAi6hNSYAFmALbjtLy1bTRsPo9kJOLxUojyD3iIlw9tt
         ZSYM4voUvavORr6lFAgmbBvH3c7g5ubuOpsU1mkNmN2Wo4Q5AAJ+ooM1V+q1t+hzBIs3
         GYvpm0LShmDQCGSA7/jxkSE3z64x6cMNgoZQyFW8Bk7+/QKG9fmtn4u7M4bQ/brRAyNt
         tIYyN5tydIQjaGsfDp8qWjxCrQoD9vGkaJ1AZgJW8veeqkFjDYNpS4dvn94ucqnDn3QU
         JmP0qBnVfiXyCrCsjmjWdOFHtWDGCfaremxZ0iYMpvbFx5smcaOCmTx+aLVf0YdrVb6S
         kIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785850992; x=1786455792;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nbp8mVQBGl5z09DMV5RCuEsVUApOEzt1Ehl+hms6Mj8=;
        b=E0ifOYHlut2G4XQJ9WD2VIhtWLdY9/CgO8NRSARBWU1A4pxi6VaKpgVW/Xu5yMM6ee
         b62bK3bYVoq91vQ8TA3jr6ifhGv48ZOwfgV3jt48t57cFgng5gxoCyVT2WO13u11h/VJ
         Pnhhp6BCKElcfVzXn3n7p25ELsbGU4jpxcgHV7/lWzqElPJm6PFlkRgT8dkivy5lUlVB
         jXaf9mfVPutu7QKeHmgGU58Es2pN3AzJtJyVufngB9IGkQ9wCn4/hrLmz3FW359UcCQK
         gwx7elMYnntIRTXJgo6MlL7aokchEk3u2WpmPqkpeaZ/b/d0pMaOCo2icdW8GvncqbAU
         En5A==
X-Forwarded-Encrypted: i=1; AHgh+Rpj6HziN5Kfdk/VqBi+cXos1hv2iYDslIVIKQ2wqW+FJ8MVVMD8WhhMKIOOk8RMqzP90Va4HTkmmcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlI8v21vyoR85jKgi/TDUEcT+w+mG6lngrjSxMSwbU8r3INEzv
	rIUYPlPemjaqTYOWKegdO1l4L3DopAhiBEPIHnqRiANx6u8OEiL4ViwxqPeFh36g5yXnNcw24l4
	QfwkkEUyqjG9rCWAxPUeBTm5im0zgOXhlc+b1gR1JkIRlKRvx5LwrM9M+2yOWRoo13zOzJ4qgPL
	qX4MW+tFeZo5Ipz98MpH97w17/MEe9SjjVYdwZEQ==
X-Gm-Gg: AR+sD11C99q9QvtVJxaIK0hSYnqdAQXIBNudDKbnmLOHEaemQ/8mIjeBHm5BVYxyE+4
	YxgWnUde48NxI+VycaYgxiswEvKAhMwjxTkz3vLqlqi/CG/5itx1GB/y9S2DWOVGKk1Ij1MducL
	kpY0s3Qm8xI+MuCu1m9sKf8UIcojST6PuTarpHcfWFNti6cGJ8gooJWH80fg==
X-Received: by 2002:a05:6214:5981:b0:908:4249:337f with SMTP id 6a1803df08f44-90872b6c49fmr82414346d6.5.1785850992306;
        Tue, 04 Aug 2026 06:43:12 -0700 (PDT)
X-Received: by 2002:a05:6214:5981:b0:908:4249:337f with SMTP id
 6a1803df08f44-90872b6c49fmr82413736d6.5.1785850991910; Tue, 04 Aug 2026
 06:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-allwinner-a733-mmc-support-v1-1-e9209e3f9761@baylibre.com>
In-Reply-To: <20260731-allwinner-a733-mmc-support-v1-1-e9209e3f9761@baylibre.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:43:00 +0200
X-Gm-Features: AUfX_mxFXZDTZA_oVlCI23bLtNdk-8qS8d3T_pRa8l2TAPJMQc0QtFw5SglOqh0
Message-ID: <CAPx+jO_Me2qHx8UQF7059Q-W6cyOtnw7ov-CnMhYo5d+9aPKRg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sunxi: add compatible string for
 Allwinner A733 MMC0/1/2
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX9GaqUzYGSoKs
 lEC9Zbi5g1gNXIyZmNYHsktymFGDUCtCNTni/nviM/XzjKp1qgOwmoBWZIrLgmbc/yX04H0oxfw
 V94lUpYcSzYZr7Q7hpD54NEikYOnkyvSZyxa58hKEDNcaZgKyKwDnSvLJnY00bYM4DCvFztwxzX
 6zwO/oxCcwMZAeZ7nshliud6LPn/IPQvbDg2XZng1lhbu/a1UVBiE8yhv/9Ubqr/z/d97WeINjx
 IsFZsSt8YvCDu7Re6wR5IOkGsE1EBWKadigmB5mqDNZnfb71T8NXSITm3CoGB3i2BslAN//15J4
 4gBLa4tgV54NrjY+ns5+kp/GDZiCYpp9FN/xn3/McektMUtqRi1tQysT/8/1kwNb/5WodyV/AE3
 mbxmqTUcKBGafoB3qq29asR++RwEkTgW0lWpRXIu+481hufDptf0wCOF6CsDA658EV/QGbW2XcG
 dU0HekG8Vm/OKkK7NaQ==
X-Proofpoint-GUID: npWL27lQA2pyyFy5io279Jl6mE3SmKGd
X-Proofpoint-ORIG-GUID: npWL27lQA2pyyFy5io279Jl6mE3SmKGd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX5pgRxg+QR+8u
 0BsieKMvQLfJEFpVHFC6dNyscJnwu8EAEsCbAq0BOiCvnUMARCwfWE6RGoYwLFcIWG2/xr8FW9L
 MHOelU7ZEbgntVQiRv2uuagT60WdOQc=
X-Authority-Analysis: v=2.4 cv=XYC5Co55 c=1 sm=1 tr=0 ts=6a71ec71 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=IpJZQVW2AAAA:8 a=f_oPU6YZfnA6fFRCD1IA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040110

On Fri, Jul 31, 2026 at 6:22=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com=
> wrote:
>
> The A733 MMC0/1/2 controllers are compatible with the D1 ones.
> Add an A733-specific compatible string, with the D1 as fallback.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Like the A523, the A733 3 first MMC controllers share the same IP block.
> The 4th is known to be incompatible with 3 first.
>
> Unlike the A523, the A733 4th controller is not dedicated to eMMC.
> This 4th controller access the memory through a different bus. This is no=
t
> supported (or tested) yet. It will require a different compatible when th=
e
> time comes.
> ---
>  Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml | 4 +=
++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mm=
c.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> index 9f3b1edacaa0..9e9610bb1eda 100644
> --- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> @@ -56,7 +56,9 @@ properties:
>            - const: allwinner,sun50i-h616-mmc
>            - const: allwinner,sun50i-a100-mmc
>        - items:
> -          - const: allwinner,sun55i-a523-mmc
> +          - enum:
> +              - allwinner,sun55i-a523-mmc
> +              - allwinner,sun60i-a733-mmc
>            - const: allwinner,sun20i-d1-mmc
>
>    reg:
>
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260731-allwinner-a733-mmc-support-c901bc312eef
>
> Best regards,
> --
> Jerome
>
