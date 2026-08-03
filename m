Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4243FC5A4
	for <linux-mmc@vger.kernel.org>; Mon,  3 Aug 2026 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759281; cv=pass; b=gBEJQMwVycJhD0wfxkaJUkIcSNvW9hRINI8vziyJdRk6UR4Wbmli78DywkZUyy8nzRXVXJZn/YEHwFePmWkBPmF6rAqIzSAh+yAbjx85fD2Ljn/9sdjO0AXXd/pk7XidUb1pb9dAOg+Pdhn8DdViBUYGwytWeR4A7eIgT4+vPzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759281; c=relaxed/simple;
	bh=N46OaCTnuU9L+JwkzNXlmEiTgMNWR0GrcZIOoWyazLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opwDVSnco4nzjQPhkbQYRPXAmvt6A8jLlpzAxOzdQf+ko9t6MnSgEH+tbGfpHM7k85dS3LgvPEOz1NoDABANAJLE2gJTIhsR/nWSsLfIBek44JM2l3CoBLWeZVxrbyeLKVwinUGrDP25iOm3EoMEN5suTTEjLaLx+cEVQeeRivw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KEtdT7qh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AqAplncu; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KEtdT7qh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AqAplncu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673C4rJV365359
	for <linux-mmc@vger.kernel.org>; Mon, 3 Aug 2026 12:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z68BIXPiwwO1+VvUJNPr6amEVLgz2i8l7Jipl5mMv2c=; b=KEtdT7qhAr0k6vh1
	ylMdesdvqK/magq92A/fxayeDIYDcNct3N+AEh1GGpWCXRHdj2jxa/25feUeJkeV
	hm2wLgVxre3LLcCJSLSlOHF/FuedPVCO0X3nGfsWwWDJJCRLAFU4S/d1G/B2qc1D
	14Dek0enmjyM0lmL+y8heOAC4ZK+5H+IQmDJMRPPPT+AoeT9aDa/WiEnEFbmlmZk
	t4/0JV2F8Cs6Fmr7Jf5oRdgMIx/7pqAgJY+TZoixRyeWVBs6LKKkpuJSE+Oy/KCv
	uKMLtsernE2uC7I3ALBwjbWi2stusp+7gqbJ5KPsGnuLWNoW46xO0GU+Ok5EiZRf
	Mvqplw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrnsdjt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 03 Aug 2026 12:14:38 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8eac2620cb0so33466596d6.3
        for <linux-mmc@vger.kernel.org>; Mon, 03 Aug 2026 05:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785759277; cv=none;
        d=google.com; s=arc-20260327;
        b=I1TxlN3pbPHWrp6y+61zUaYkbWYJv4MY1N52aO2wtGWFA+hGrL04uf1HhqFvGvAc5o
         bbCjKNNhUfsQglHEvou31OK02nQ9H+JtTQwyPDaztxeWxMyscZseHAvyaMgWbY0T5fTg
         k6q3vAt44teoO2iie1f8optU0g4BQfR8PZynxWvoE82mKMbM7PbQkFbVIS+1T0ZBqpgp
         i4dv5Ms+/ECYCXdmggAgJycuU+fGzhknyoXKnDbCe3c3b+gslOnuIWgknbHGouYViAHL
         M9GYgmp5eKR5F6XySgdR1nAnIoKEatEs68MK7n61hyRw47wsFah5cnbSaSxfpMZ8EICB
         U5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z68BIXPiwwO1+VvUJNPr6amEVLgz2i8l7Jipl5mMv2c=;
        fh=53xYwhaKpK5BQiKsehx5pB3nhAWDSsg88TqEhhYoT5s=;
        b=WYd0tqrSKuSAU65jYDPBMv7avb4WUc8odBjqOmasLbQMnaenXoTQmiddzXPT9B8hTr
         yMN8M/Qu6oJN7Q1c0GG2zGeieiA6Kzu8QwSgPSkGIXcyEElEAB2yhG7ktZiiB3OoccM6
         AjWcb74O22Cu8R/uHcOi0a6IQr0XUdz5s+m4CEHoGIFcrpVy5wa5AjBqGI1Z7ODa1Qaa
         Od4brZQpKnYj962Jp5R7zNWNRBcZreMTOa/BRyGL/S3+WGiUwLzou64YlStPTdPCBl/H
         z88+qjrcXYRF+JdpBYcZkmGa74LPS/imvhVfYDsftRZ+Rl/oMV4D8Aty0D0UB2GqZTAX
         pV0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785759277; x=1786364077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z68BIXPiwwO1+VvUJNPr6amEVLgz2i8l7Jipl5mMv2c=;
        b=AqAplncuR0lrJ+jcsz7TJFRzUD0zW/vGY0idnuFp6LUgOFXPSqphXZXA/CASFTa66p
         FmYdc3J1oQJYnO/HDnNH/dZ9j8fukP548lufWpNXUMOCUDFBTSoaOQYaMbbSoS3VuNUT
         KE3LqSZC4o5QzCJmWXYIPc6L5JzZK6/OXP6OJyRZNqIidzLma7e6ni3kb/gE3RRB04bW
         xTQ2Bttxutg7IakyY/+Yj9I5fwIT7b3xkedqi7OzHOVnlkqEHmTwCXJK854ZNY8vN6BS
         f/b+61/eDqlE23eo3FDQNjym7PPtZ+SCW+sPjS7J+Y5lJuWihXPRv7T+kbUYoj+YKUAZ
         P+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759277; x=1786364077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z68BIXPiwwO1+VvUJNPr6amEVLgz2i8l7Jipl5mMv2c=;
        b=hXHXwrkizW/X+DvEGv5DbsHF1kh6IXlRVALM9sPj56ZhVA/TXGeI/iMVFoPyJlPz10
         tHRFXBy7RBQdS2VGN9HUoR5fo8H5orLv3Zyr35e8ykBEK9/KYRANTYGE15xC4I1BS8b6
         6DO8cSPboRSDKcfe9XkwF6/okJ5xkRz1KoYQiczlc02Bk90tiVMEyaFXghKCof8mmz2U
         +r3JPLmtYeChIDOOm3yDislpzt/PPReH52Lf6rcs3yKqw1eOPL+yNj++9d1RAojJNrZ2
         0sftXs/vC8YG6KLfVW+gwtadmdcbQkgrSZ7fWrCykm67VFXSkioAXy6+K1PFipmhB3x5
         ZNOQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLBg08QM+T+PqJ4+6M3YMEvTFM9suWekfO752P+7xYKr62AH97/viynHpF/d90C8uREjehBPtksiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6AlM3zhCU4YfMibhqGwKNcOpQjqWrC50j1U+MFg9KsYKgWxw
	tJnBHl/f9hJZY1Cd5yrJsu6jOvbfMgLfA5xxp6Gg/bBCoJO/dqrW/x/Cny9nF2ZUXD2F32xEf9i
	1Fw2t/Ny+tENnZuUGsGnCI1ffxVlIJJ0LN4H3bvj4LdP0EKxIO3pU6yIa2M6El1le5OGDcNcr2t
	oKAv6Xsa1/Br352apoqXs7cZJwnpgCDO7YNCHPGw==
X-Gm-Gg: AR+sD10PH7Kb1++T5whlPEZiU5Zr1Gd1Rq6D/3eJ+Sa3Blmg4zjdKuOBpgrs751RtBG
	n0rP7KjqpSQKEBgNgQwbLT1+cuKP17vM7qZOuFnj1CID8MD/jN0YwVW56AZEwqgfNQK54u4/T58
	Vr35Gfe0CDJUwDGqZmyYrZxNbqI80FZ7CwYvjh71ygVBA5h+yMrRBOp1+6aA==
X-Received: by 2002:a05:6214:2429:b0:8f1:1081:a950 with SMTP id 6a1803df08f44-90849632786mr210024136d6.22.1785759277210;
        Mon, 03 Aug 2026 05:14:37 -0700 (PDT)
X-Received: by 2002:a05:6214:2429:b0:8f1:1081:a950 with SMTP id
 6a1803df08f44-90849632786mr210023436d6.22.1785759276608; Mon, 03 Aug 2026
 05:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728190314.2325906-1-kamal.dasu@broadcom.com> <20260728190314.2325906-2-kamal.dasu@broadcom.com>
In-Reply-To: <20260728190314.2325906-2-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 14:14:25 +0200
X-Gm-Features: AUfX_mzK-1C0mh3-O8tZGEzZLoSTAi2jZENqJ3feTTbD7BGLUaC2JKq2BREtqOQ
Message-ID: <CAPx+jO-C9AYu012zw5rUZe1-iN6779DpYUqnURfKX=5Mdi1BWg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: mmc: Extend keep-power-in-suspend
 beyond SDIO
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Avri Altman <avri.altman@sandisk.com>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        Erick Shepherd <erick.shepherd@ni.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwOSBTYWx0ZWRfX39hL2blkP1lj
 SwT8SvY9FskcpIZu6CQ+kQd3jLnHuWiVvECpxRVVi7CTx1YfwJKvFvJYH/g15jrg8wKYdS1UHCz
 cDBTG897pmo1xrdzFQXe0jxNmaBdQ90=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwOSBTYWx0ZWRfX+ryH2GlttxuL
 5oUaJniuT4ucskuZk+BXZpWuCq/GuoEHzn+qpBTNhqCuFSdU3vo4GEahVKjDETq79yFbuiP+BeE
 gU958ozxCvgcnXRdBSeAd60jcOJN7DbUsADn2fdJH1m2RANprM9sHfeJAKNwkCZuw7QfOS4ikLY
 qWLCQlviRrzgifNte4mAnocPN3Y2PqjWr1Wrmk4ry3F/QDvP8Ohf7kyspbpl+eCVBpg8Dtp66as
 YltCIjAeavSh/J2/rCu+SQYzB3eqw0/XX0RetEFfRmfEWEJL4Lq7ns/OcBWOZt2VPdjgGh8JLxX
 73dKO9KNc94nA6IbXfSr4LrjgZjsbJrQ3OQoXI7D4YQ8XUvcvb3Q0I2272m30qW8areZxk9dj1i
 6QfYFWTKOsQesCL1t+mF64+9viFivVlZiS5V4ns/KjQqlHEA0rRnkQE5Oc1BDg0ofVVos5nGiTd
 zYyNLO9TGXVdUu9CWNg==
X-Authority-Analysis: v=2.4 cv=Zest8MVA c=1 sm=1 tr=0 ts=6a70862e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=Q-fNiiVtAAAA:8 a=20Cfs4-G_dBtE3sHqwEA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: AOUP5KWUWBLMG7NoCGGfaiwc5GnPV1A7
X-Proofpoint-ORIG-GUID: AOUP5KWUWBLMG7NoCGGfaiwc5GnPV1A7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030109

On Tue, Jul 28, 2026 at 9:03=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.com=
> wrote:
>
> keep-power-in-suspend already documents exactly the requirement
> needed on (e)MMC platforms where firmware accesses the card directly
> during resume. Rather than add a separate property describing the
> same contract, drop its "SDIO only" restriction and document the
> (e)MMC use case alongside the existing SDIO one.
>
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
> Changes in v4:
>   - Dropped no-mmc-poweroff-suspend entirely and extended
>     keep-power-in-suspend instead, per Krzysztof: the two properties
>     described the same "don't power off across suspend/resume"
>     contract.
>
> Changes in v3:
>   - Renamed from no-mmc-sleep; dropped S_A_TIMEOUT framing per Ulf.
>
> Changes in v2:
>   - New patch, replacing v1's card-level quirk, per Ulf.
>
>  Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml | 7 +++=
+++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.=
yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> index 3d7195e9461c..f4663b318435 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> @@ -291,7 +291,12 @@ properties:
>    keep-power-in-suspend:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> -      SDIO only. Preserves card power during a suspend/resume cycle.
> +      Preserves card power during a suspend/resume cycle. For SDIO,
> +      this is a request an individual function driver can make at
> +      runtime via sdio_set_host_pm_flags(). For (e)MMC, it is instead
> +      a fixed platform characteristic, needed on boards where firmware
> +      accesses the card directly during system resume, before the
> +      kernel's own resume path runs.

The above isn't a proper HW description. It even refers to functions
that currently exist in the kernel.

Please update and remove the software related parts.

>
>    wakeup-source:
>      $ref: /schemas/types.yaml#/definitions/flag
> --
> 2.34.1
>

Kind regards
Uffe
