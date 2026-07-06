Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219BD382376
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352781; cv=pass; b=NpTzXbbSe8op9/SqXhV0K06oeKedvo3R83KlU+lNneIvjQ1QGj72BUOOrB0eYXueSgdqp2b7QOZaL4XYuKVVayQ1jSJ/1aBEQ99JhfAsiaD50rF5+UwHDsssmsiTAlqv05lnYpPoNUfU2bXxlCN+pKjppst167TC7WrAb/UIZ5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352781; c=relaxed/simple;
	bh=xYmENpXmDPnuMk1/CUycyFr+awBe6nSvTWePQTudzMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACAH7P64XwGvrIPTs0y7SLdKjlmBZu63Ta38FdQmsn/EwVvKPNZ+kL6Iq+cdKL8bVsuTEwZ6K8WWpAD7JAyLvXD7mInA9WzKf/C1QVzOPLDoRRorhGARnC7618DF7klI6QKV3mIMMpyRUbroKkptVLURmsgCdapnwdy7sv5J5Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f9FVMwzc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ETs1d7Un; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f9FVMwzc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ETs1d7Un"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF18L956528
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uVwNgSJTtVTKbtqSaGAFbxzC9Mmpfk3iXq7vDmyv9os=; b=f9FVMwzc9wc9WH3J
	3ZYb/ThuiVXqY44vE4KUHg6xeqe81jp91mkfL7mgX9DLHYzUYGYEm4PO7dZz1ilL
	0gvJe60fMiXXNO4lEqDAUO3X0/1HCYNTarknepb1BpqKfC2+wsOYkQh8hs4hNZO1
	iSwca0GRi/JWuZs93mkZ+sYJrp+DhR5Qldt7BVRLz8g96ogI/izOelcEGqTdYkNc
	2vQ1DjSVymWlSg5ubVSwoXIdh1d3i8W5dRLKFB12GwcWR/nJT8GJDETarCTU3igt
	8JMfKnzurbm02wJghc9s+LwdWCpTWBwXbmGuhULrNdBDZchkK2YI2Yy5x33cxPZ1
	ssewjQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891usvn0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:46:18 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ee593a5a2fso40405056d6.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352777; cv=none;
        d=google.com; s=arc-20260327;
        b=gZQNcCfOYIfMH4dmlqPsT71xSChuFROOfHw8VPmfvyIhBUUa03FMUMNwDBQqcW8b8l
         vsQO7ytG8KkzO3HjbEYOAm2mwjLqIkiETm58HvF+UnpGLZtoYobe+xjldZMF/FEbcm1w
         x06f5+A6kUy5kDmxGK3kUji6ZWOep0qtCjtQ1K0jPzks3aW5B62Po0xxWYASFgY4Fo5y
         TrTDXhbNoLUICtssyKAP1YamIzWekQ3ZMstPh0eLpKEtMvZoi5D6VziEsL1VyfDDrK9F
         tqxnAXNmc7w49KgDFAVyvUZOfDO5/YIcTf2p78FFPlTuIm3ZBR7x7uS3A98uF0yN55JZ
         E4/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uVwNgSJTtVTKbtqSaGAFbxzC9Mmpfk3iXq7vDmyv9os=;
        fh=aHmQHuxXDVE1uYrlVdy8OWM4itW1B666W9HytQKXZ1c=;
        b=lLyvG5KGVHTsCnEWC3cH64dUNTxmIyXimQEDan+R8naBrhtieeb5T4RrL00K2/Ctg8
         /7SEG9k4apUgWhLuPsb+8sdn/CizAAlCVkUeJ3Ea4hZXB6nRMsyWHUDFJfHU0DKeAQHA
         P4ggfkoL70/5SPmaF83Go9PyDmMl7+HvBz5KkS4P4pqPlIyUHb0NVV3iDw/VRwYTwLmT
         JoW4X0yQ4UzZbZi/VsFILiMsV627zK4Szt0BDkmUetoLPF7RvpBJh3iXKMD1tI9/wk5K
         HcfFHAwKHXlZ2o4SgmgeanaVL0RK8XpbKOUjQzMFjcRn3piCGOU/HCvi6w1cNZeuTRZO
         R35g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352777; x=1783957577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVwNgSJTtVTKbtqSaGAFbxzC9Mmpfk3iXq7vDmyv9os=;
        b=ETs1d7Un8xTGUMD3fhtVnRgFrf85qfwV/Ym82YEnrJrApE3SclMkgpUHEdH8iAZL78
         x6YvxkCMOnN1WLK6CACDm3Zl3qCYXj6E8SN+Rc54TiqKoAUIY1a2nq08ZYVh7UTA/nid
         2g74KWrs7ap3fKknBHlvS7oG4DhbrR0j6oUFk8hzteP2jdcaocJtLatjMfm82YUJ3VtT
         bbJ4c6B4392OIpsUD5tF97ceipKa3skkDuB4fRsNu4l6x6FSldxedTdCXbgqd2AZg1nb
         5YQXGAMcNabypgxChcEF1dC7u834rEYS/oqmrVV7SW1NIojP8dxfnYZxnUH9UwDcFxr3
         PlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352777; x=1783957577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uVwNgSJTtVTKbtqSaGAFbxzC9Mmpfk3iXq7vDmyv9os=;
        b=Ub0VCy/AzmLRWOkkOqnOdUPFRPnKxqERDjKNgYVlq7v5SDSQzWFQGQgIF2DNolwpKl
         i0MI7tBUkKCSoAxoa4seB54gTrva6OtpBiD48t6DgXi/w2ekdWShRNdCmge+XqLxFzL7
         mmTf3UYFCjHWAbJQHF3wDx7f04hmUr05i1dassJ9CYsCQ7beSFShEZ9us7v/ZWNrU9NP
         oucRaQFxqSn2XPkUWaPIENudGeFHD5oqHAABG63YfC9BJv4OKV1SBaXlDXNLQ+BH3A3E
         VZ+6qhqA+NqRrfPJodzSudrKOY1Lpq0pIVW6ixejqU3Knw8q0a4K2JXWyLM+CPT+u0zH
         TS6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpQdNHqk4O0jdFY05rmyCk386lRkaJmGk1WPl7WHUB+TArCmVQ7QYDs5Ljt7Pa0yZGgvmfH9sfEXvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQL6qOa4dooDp1lCmvlgLMz1vWKO4QceVNEGgURamhZaq3FcZR
	SmGtaVK+EekP8+3iYbzb2xFZzUSR6RkQxpkMdiAb66O9JnJrJX+1fVMFKRnoBOlNfN6xHG3A8kO
	KqxDDHXBSbHFB0+FBZfIsuiKPfpHesD9fGMBjrN0RzAUG1HCpL/AzEZ7SvhgPpkl9tJMmi/71eW
	4KDzvEz7nUCl6Lj0KkgC/yR1BhU4d99jdxypzYxa2Yht+O7A==
X-Gm-Gg: AfdE7cm8RWnpFpCveDCmu1pCZ20RCiokakllW64kQl6QoQVnssbHsk1q5c+Yv/3itMw
	0LyfKd0w5U7capbkAchaRQYM353WVt+/uUvB+jjCqD6eAHp+LbZ5PXWyFo72TEy2FdHzJLh9/lG
	WEhHwx0rkGLT0a2peF0ith0t32rAhki4t/KDDk0TjPF+dHWE6iWv8SoLSThlE2U+jihty0
X-Received: by 2002:a05:6214:509e:b0:8e9:cd74:87ab with SMTP id 6a1803df08f44-8f5bdffd9e9mr220890686d6.21.1783352777365;
        Mon, 06 Jul 2026 08:46:17 -0700 (PDT)
X-Received: by 2002:a05:6214:509e:b0:8e9:cd74:87ab with SMTP id
 6a1803df08f44-8f5bdffd9e9mr220890016d6.21.1783352776811; Mon, 06 Jul 2026
 08:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com> <20260629-ice_emmc_support-v8-1-1a26e1717b85@oss.qualcomm.com>
In-Reply-To: <20260629-ice_emmc_support-v8-1-1a26e1717b85@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:46:05 +0200
X-Gm-Features: AVVi8CcMiaMIm1Vvge8nZlP4c_CpSIP7RoUq2vlhL8_0iLB8z8z0FY5gCTSjriA
Message-ID: <CAPx+jO8t_kQ5q4XmNJoJ1nR4Kro-2M1s_Xj93qxuFUW7VPQpTw@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: mmc: sdhci-msm: add ICE phandle
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Lgl-9P12IdiWqzvGxYOGbDTVPDSCBfah
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX4+NXBzBBEWGB
 2ZEKwTRMng6Ks7OCcv55HzC9dXR/PZIm7IbACwHDTrsvi18mAcBCfdTGg6bendYOeNPNYIJp17K
 iRTmLDLhFio3gldA/AcQANAdUbZqCEk=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4bcdca cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=mKE6IO2wa0aNAFb1U8kA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfXxLGJoDo4zFCr
 jhIQLtchUtlJLln5SEQpf1vF2HooPeUT2zQcG0xFecOJ6wrzLfp+S4fI2LSF0RrSMVA5v6inYjL
 ZgJKWtC6FW0BbOEWLwmax2M7LfFYGioVTSOyS3gGDFc/wY6YyALEB5q4NKfUDCsi9kgUIarh6gU
 l0q6bcz9K6OHzEHwKT/FJU8FjkQvenD8rCNOpL4/neZKkmCSGoUfRzXkOJK3uTNnmHuhw+qCVqO
 xv9lDqgbAgDg7mumpkA+iut8BixbpXFo2rd1rIe6Dvu1NE3zdtobhy3/FC+BYKQ61j8r2ul5Jj2
 aFB84+wlokXhmLKMNEl05Sa3CM8Pu+wv2jirg0ymd0yxmF8xKlocvL3+w1dRCsRGEdM6K3CWs7U
 /ov4aasOZsLNfTRJ7xAz7Jrq45AYH0S+Nda0GqQiQE6wxR/c4M+hHw+N1Qplts3B6K+SVMA5nOt
 wCWZx7UsYO4A9xXIE4w==
X-Proofpoint-ORIG-GUID: Lgl-9P12IdiWqzvGxYOGbDTVPDSCBfah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060160

On Mon, Jun 29, 2026 at 9:36=E2=80=AFAM Kuldeep Singh
<kuldeep.singh@oss.qualcomm.com> wrote:
>
> From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>
> On newer Qualcomm SoCs (starting with sc7280/kodiak), ICE is modelled
> as a dedicated DT node. Add the optional qcom,ice phandle to reference
> that node from the SDHCI controller.
>
> When qcom,ice is present, disallow an embedded ICE register region in
> the SDHCI node to avoid double modelling. Older SoCs without qcom,ice
> remain valid.
>
> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Co-developed-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/qcom,sdhci-msm.yaml    | 95 +++++++++++++++-=
------
>  1 file changed, 67 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml b/=
Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> index bd558a11b792..b3fcc1673c10 100644
> --- a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> @@ -145,6 +145,11 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: platform specific settings for DLL_CONFIG reg.
>
> +  qcom,ice:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the Inline Crypto Engine (ICE) hardware block for this =
controller.
> +
>    iommus:
>      minItems: 1
>      maxItems: 8
> @@ -198,35 +203,69 @@ allOf:
>              enum:
>                - qcom,sdhci-msm-v4
>      then:
> -      properties:
> -        reg:
> -          minItems: 2
> -          items:
> -            - description: Host controller register map
> -            - description: SD Core register map
> -            - description: CQE register map
> -            - description: Inline Crypto Engine register map
> -        reg-names:
> -          minItems: 2
> -          items:
> -            - const: hc
> -            - const: core
> -            - const: cqhci
> -            - const: ice
> +      if:
> +        required:
> +          - qcom,ice
> +      then:
> +        properties:
> +          reg:
> +            minItems: 2
> +            items:
> +              - description: Host controller register map
> +              - description: SD Core register map
> +              - description: CQE register map
> +          reg-names:
> +            minItems: 2
> +            items:
> +              - const: hc
> +              - const: core
> +              - const: cqhci
> +      else:
> +        properties:
> +          reg:
> +            minItems: 2
> +            items:
> +              - description: Host controller register map
> +              - description: SD Core register map
> +              - description: CQE register map
> +              - description: Inline Crypto Engine register map
> +          reg-names:
> +            minItems: 2
> +            items:
> +              - const: hc
> +              - const: core
> +              - const: cqhci
> +              - const: ice
>      else:
> -      properties:
> -        reg:
> -          minItems: 1
> -          items:
> -            - description: Host controller register map
> -            - description: CQE register map
> -            - description: Inline Crypto Engine register map
> -        reg-names:
> -          minItems: 1
> -          items:
> -            - const: hc
> -            - const: cqhci
> -            - const: ice
> +      if:
> +        required:
> +          - qcom,ice
> +      then:
> +        properties:
> +          reg:
> +            minItems: 1
> +            items:
> +              - description: Host controller register map
> +              - description: CQE register map
> +          reg-names:
> +            minItems: 1
> +            items:
> +              - const: hc
> +              - const: cqhci
> +      else:
> +        properties:
> +          reg:
> +            minItems: 1
> +            items:
> +              - description: Host controller register map
> +              - description: CQE register map
> +              - description: Inline Crypto Engine register map
> +          reg-names:
> +            minItems: 1
> +            items:
> +              - const: hc
> +              - const: cqhci
> +              - const: ice
>
>  unevaluatedProperties: false
>
>
> --
> 2.34.1
>
