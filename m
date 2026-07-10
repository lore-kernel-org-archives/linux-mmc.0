Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD12426D18
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783689730; cv=pass; b=QfMMb9M9vCtW68tVVr+4HvAbDtEhlrRk+81ccaVjS7sgi2NtWtcPl4OyHqV+TGO/y/354Xpk5+kNuTAqkfvbS4tMI7FTLCItoIeptVEgaJcQ1O5Ksy9LzPwd9tXY/56xTlggV/hAOl34wOB979JPP9iwlErpQ3EA322QyuVHing=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783689730; c=relaxed/simple;
	bh=4KmKDxIXwspt6Jccei/ujhRUVVmRui+JyLDUBsu54yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4dLgoDGugdlDFwJVLt2nz0FO9w+sBhG0yVrJ8xexlqPmpIJWgiqRqo+7oDIsELvU9th47XtUgWd5SGJeHSPqpAzcAkqjVVsM3v1aYfZLRjbPY+o/Fg1lFJE5pwxGixScpNNvSdaP8ywBGSpbbYP08YU7lbHY4kQsqkU5P0UnTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AXt0FCIk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T7LtEQVB; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AXt0FCIk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T7LtEQVB"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD6Z4q700696
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SXG7S3p3xLtYKwJ43eakLYqv4N13Bj7bELOQ9MVpdnE=; b=AXt0FCIk3DGKI/Nf
	pBp5yCPv6UEDsmhYLoWUYxfExoDKdSex+bAkYEDQtib/RTLJMBNYLluw59O+WHLC
	vI/00XWT7TMDcDQeBJswrEXoYtCFKxoLOecFNi6J0l9j1JfKUfibky7pgMm3CtK+
	X4gElHkuw4loNDmcjzmQCrApudoXCsKa69wvqBc5PMc68BwgWgLpKF5AcO4n1CCi
	+qtIE8LwMX8RwiXmNcHB5C7kBFI/8m+a6JGoh3Qq0I3W5MZ1ioiH1UHx1HMnZfw3
	D5INMvKJtgt2A3csGxHhlwcgkrfszkPh6dolM+adj5ldp9WDJg7JTfoAWLIdJtJ4
	xZW0UQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8kfmm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:22:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0408254aso24575081cf.0
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 06:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783689727; cv=none;
        d=google.com; s=arc-20260327;
        b=BBkIz4kLodUTy6o6MhfTWOqf/HVf6+Lyyh6q5cPzlgM8wg0BQNyjA25zSCus0nhnB0
         vUtVJNmnDXzCXfcQqhYQ1oYJbEpqnpYlMszNZoTHKDxPgIMTNdol3ZYY9DBfIGlecjM3
         Ip5pwMPJb0nkszMOtVq7yGAT+eSVZbvf4qxKm6wCJtRrEJfK1F0AHjcxSYDcPWBtF4AN
         19FY2PRaUI04iKbJtezdxVy5SpB7Zp7+wIqH9ZlqML+hZKLzNc74iKKHZJhaR7roAv//
         J2et2cYdYU1sGtRK20Om2/GhawdGBjxeIiriyQrLwinkGJdApliZW1maMQBUmMPGL2Pv
         h+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SXG7S3p3xLtYKwJ43eakLYqv4N13Bj7bELOQ9MVpdnE=;
        fh=gU/rIJmiLliWAAos6h7PAKznRk62J7NHxTQ42+uipuc=;
        b=svq/S5/7iD/vdQGMoGkN6ZDU2h0SLErEK4uTpY/g6QZKm/7QhjNj7jGAd0E7Ud1n3D
         Fx179Vio23s+LVW0fmDz+MSeG+kflzcCoWxb/fuOUFcPHTVPNMklH4NY0LwKv3O31wdj
         x8M2I4mSzFhtRe0wMVnqZYWdxT6VF7VGidlMqNLFAW+XyJIlFX0IOD12R2HB2q7hCEuQ
         2MZWW+pVc2WTBNXsdXT+GFpWl8sDkN5bIxnS1YOV/6N6qGWedYrv0SWDQCUdSpd4a7nY
         7FDpolz+15fBAvnjKQWWrxj95prkDHSe3YgnhHXxnLPlz+k2CawoJdQoKzGDMwhHkdRM
         QUnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783689727; x=1784294527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SXG7S3p3xLtYKwJ43eakLYqv4N13Bj7bELOQ9MVpdnE=;
        b=T7LtEQVB9JSWyoVskbnjWQfOuXPFujy93s5VJVWmOhkxc9jMxiSnqXdA+PvMLSQrcK
         4MPCP82x5qar1YqhRNVDqTyJNZmzHW2QPs1Fc6C27B555RYSAyURjAi+EBJLbvfnV0/k
         D29hDC+KPYG3f/OQyH5Q2aWpQS82A4pl+rMWN7ET6qVo0j81pjHWq7zWsilZjAxwRAQS
         LbLkmzIQgHTswjc9RivvzDx/qw4s2ATk5tEteu/a1s9v+t4M7Amyrho3PgcNl/bbi/0o
         FdWFj6fkkEi4pivBDrT0fT/QjzjE3Xxb8X0y+JKb9SXOBrjHK0qrP+RUyKElPP4g32L1
         863A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783689727; x=1784294527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SXG7S3p3xLtYKwJ43eakLYqv4N13Bj7bELOQ9MVpdnE=;
        b=aQ/q7AYqJ6sAgi1clDRmScI+WftGda3qWaFjnquq7TAWlRL3fWbrSBiThr6Mz/UZ9S
         KpHACXE/x6u4bYYFbiqNn9y5hLUYvcfXZ9sFBQceYIgQill7SEG/qUY4mV+ofPM0AD2c
         +S0Dwbzb3OqWNHrevv+yjBHn9XlYwljdYl1JtvYkyBsN0aQfhEpoVzvzNOWR494xnJQ/
         kVWBgo8w79GH7QQFwZB1vtuzlsOQ91U53DNa8cGY+kTCO2PU+Gia2OFQjc2ugLbYsRH8
         DxXGWF8dTmS9OvqA5nh1LLZ4Tp/AohPRiftJGJ/KA4rVZlx+s/wCBpyIrlFaZh0QhGn6
         jUAg==
X-Forwarded-Encrypted: i=1; AHgh+RrEbc9+n1GqIhvMnh/IgZ1tS4M590JsVDkR8UMuiMpDC21wRHfdEuUs60dJQrBs+PkAY5l3PqWfgDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gD611Peyq1YjaCCE4g1LgnZvbhJijEs/uB6zEvLSddH3QBgy
	NIgRCA6KIlj3dWOiaJou7Jv78xslF4fKFnTkBSl99nmLTSD28mAJArc3GYO8oc6FsgCqgWMryyS
	XlIiqqB4NE98/Xi9I1y1d9wfxlvxEArEs1IXYR0XcajXEa/GS5o63R9Wv7eOIIlvdyyWVDOyrp6
	FM9GsjAplGPVaanA8Uslq5LpPAvFiiRvm7Oq+ICw==
X-Gm-Gg: AfdE7clRo7p1ErVyZR3xCnoIlJaucwbCg0AbimDbZfPN/qRFMWUfJzWnFnY+zCGbUGQ
	WZs8FBlvFa3HK7f/tTZskESVoy9ko2JpPVEs7qKWlf5ZylxxGCONTBCD3lUB724gXwmivmhh38/
	jO8Q5OZ8kcHqCiZXNTFWIxY/+Lm6RM59OAN1PdyM3/mkwRYSj1PAmLUvgC3Ny3jd9s9MzC
X-Received: by 2002:a05:622a:4d8e:b0:51b:fcc1:a0b7 with SMTP id d75a77b69052e-51caa02bee5mr34237561cf.8.1783689727509;
        Fri, 10 Jul 2026 06:22:07 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8e:b0:51b:fcc1:a0b7 with SMTP id
 d75a77b69052e-51caa02bee5mr34236931cf.8.1783689726914; Fri, 10 Jul 2026
 06:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706195818.3906949-1-sjg@chromium.org> <20260706195818.3906949-8-sjg@chromium.org>
In-Reply-To: <20260706195818.3906949-8-sjg@chromium.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:21:56 +0200
X-Gm-Features: AUfX_mzmOYvznpst6Fhzo_RRhZo2t92NP1TaOref0jVQgAZ-t89JABzPIjGVV8E
Message-ID: <CAPx+jO8t8JoTJJCCMU_yz0yyGQCSA4cKsmpSeX_=jEMUwuYsuQ@mail.gmail.com>
Subject: Re: [PATCH 07/12] dt-bindings: mmc: rockchip-dw-mshc: Add RV1106 compatible
To: Simon Glass <sjg@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@nabladev.com>,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 962zFUqe-qnmY9LasLRxjCM6LaVmZvcA
X-Proofpoint-ORIG-GUID: 962zFUqe-qnmY9LasLRxjCM6LaVmZvcA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzMSBTYWx0ZWRfX2WF8i0Rt9tvc
 jIekJ/f6hJWAIg7TVyLncuqBXfBrhiUFkw7ED9lNSiJMRcePxGPiAwyIcaZlcV0/Hhr9XliKs1K
 qBmtX562b+99AuXWkCUkYcqDZOYNbQk=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a50f200 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=cm27Pg_UAAAA:8 a=-hWoO2I3uisOaqaBfXAA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzMSBTYWx0ZWRfXxb+oBoKEImz0
 9/keCzjNKiiX7fYDbkOlDkj4xkeiK6OkbiErnI7Io1doQzXuZXpywXYre+/MZPSsXM/RF6nTKeM
 1XnHMHXmRVkmSVHVNw2pZsJWfEwBtpFiqdlI9pay9v0UW8p0pwJvyE4WRD+GOQbEbQ7s4XnHML2
 GEy/xBx6Hj226t0xewi71utmoL4C1/Qdi4jT7+eCGNvixVgDVD7saaMRRdQhIOUcTZsfsml1HYK
 55FkxITLzM3zZ+zKhoSMNqYGMI/Y7jM75PgJ3H8igk9WA3VLxnynY3x2vxK+SqK+l8EDHS+gkGb
 /GAW0K1pDEVkijhQe/Py0/mems8j5N1kKVcW1pQzgyq6Tdsb/8q16YHxntajFgmwYfkaIkiA3cu
 BM9j0QzwyslIxHjeb5LuviE0MTSLLQyqLhilzap/OQKrCPQtlKiQ9yyFyNADChIW2oqw+T7GeTp
 M2CwdUrcZJRS8Vl7F/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100131

On Mon, Jul 6, 2026 at 9:59=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Add the compatible for the MMC controllers of the Rockchip RV1106,
> which are compatible with the RK3288 variant.
>
> Unlike the newer controller in the RV1103B, which uses the RK3576
> fallback, the RV1106 controller is the older IP whose drive and sample
> phases are set through clocks provided by the GRF, so the RK3288
> fallback is the correct one here.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml =
b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index 4965bb518c54..21ecfaa454f4 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -43,6 +43,7 @@ properties:
>                - rockchip,rk3562-dw-mshc
>                - rockchip,rk3568-dw-mshc
>                - rockchip,rk3588-dw-mshc
> +              - rockchip,rv1106-dw-mshc
>                - rockchip,rv1108-dw-mshc
>                - rockchip,rv1126-dw-mshc
>            - const: rockchip,rk3288-dw-mshc
> --
> 2.43.0
>
