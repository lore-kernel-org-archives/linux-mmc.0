Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE238C2C3
	for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784382261; cv=pass; b=CmnS7EpphweJT6wZcpDtyAqez4xD1r++GiE0iOY2m/V9BFPZf0n5YVN9E+iOl0mRinBUKW4al5ssoT5KMa8AjA3Hx7poul7WU/PfxhSkO57ZXYcScBndNerMud4wq0g9iYOiMOO3500OEgoCXkJHJpmdCvCS7pJORhwJoH9FnoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784382261; c=relaxed/simple;
	bh=9xRtxepn00YVNq2Mt97AzAuEAMLg3wg36kab35YmvUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOLe++JYJ45kqoWFIegL+2r8S1PJ2csxIy6CUw8+eZCACV7XCfAfpNjAMwd2ajECGB15r4S0F+3L4ujlbFWPg2Q7B335e7Ow3z2OY7hvUuIDX72w8mzfvDIxqHDbT7cUSLGN/mN3xGJ3d/gMTfXQclOldOBUX8aoBVbbjlqrLV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LKagtKLN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KAoeHPFM; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LKagtKLN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KAoeHPFM"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IDDCcw701647
	for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 13:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PkfE5djuvYksxq/+quScdXtUNWrd6xtiFm0fZFAsyFE=; b=LKagtKLNDTXdFdIj
	GY4CFlGbtdy+wWbyUxQAVRrfmHVJPOB0CK8BiJvVMza1jKqygEO0XBFZw4YZURJ4
	ul7fPKDpPctLICHbdEKhBHwr5P/wWHMhyJLTmt+Wb4xAZVkmeuKAkKLsrtgm0d8P
	kddW8gdxowweP16hg3Gl1HZ5GCgu0vR2dZ/1mYmuqluDLfp4FdK+LgxWqtDwvIP8
	IpPhnVFDcpbFhVRRdaBdLOwpeu0aZvXhr+0Zig+bEfVjM+SRKpjw+xUxZ523OHIN
	XeRIg2uOmIoolt9QsGjofV8X/SiwjYTRv+PYFjHYJez7Bf7eYGPvDyAK8pwhv/5H
	bBrc9Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bngucs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 13:44:18 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f45dde7595so65583286d6.3
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 06:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784382258; cv=none;
        d=google.com; s=arc-20260327;
        b=riE1n7EgTVTg+lmAtviYJgdyKvOwuN5kRgvoP/R3/fxm7YFVroelnmHr7yNS57G+yY
         3Pf0DEM+Kfk2812qhLSItSt1MTo9Tgai3qQs7SI9oypFWpGk0dJo1cZ+XdPr/VROmkgI
         QU/2rylem0avFxtyM+nVKwjaQ6CSBNPcw3mvMHM4c5GegANYRdCw4YOYSNDrZLsw8Jxj
         I/MLSaGtJukSjhswhmYz+7ErU2nVzqpKaEq/rhxTr2KRIaHwAJvgziOxca/Blo/U5/Jm
         B9EEwVtbRKrjeuCrLXKSygJkf6igVsKuo8R6O1odA3vkJVBzpbLeG8+1UODHIyVTIcTz
         lOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PkfE5djuvYksxq/+quScdXtUNWrd6xtiFm0fZFAsyFE=;
        fh=Gy608NAVKm9CxJjmCO1agIVaQQJhm1pAvODApp4e2I8=;
        b=kvPhP/Yjj8JW0dPtl9MkgsvQM9kVlhGYCJ0HcZPHpFfWCGtR9BK2uCCaSTZ9SenHQS
         ud3efOnEyqEJ5Pf0SME8FJ4nBbuzGIhoH75UNK/uYoUmQ12yg/CW9MJvwgfieqX0ef5H
         yuI3oeH8hXLOn9pzWpJo/wExnjFdvC1/n6xcw8Tj8v2n5zDg2j6Vf+GbAtb56WSO1PYO
         H0fadJnTpBr/qBCUHTtwLoQmcLzq56zupLQVgkrtBzCDPJefiUcJkekV7WGaZTPOpR/X
         Wy9DXwRn89YMo1r8HwMBSP2jcv3VU7fvgOa5UUgilpGvC4visIv1xIvdG240em+EqJE1
         VBXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784382258; x=1784987058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PkfE5djuvYksxq/+quScdXtUNWrd6xtiFm0fZFAsyFE=;
        b=KAoeHPFM5YfhLEO0Bjm1QnDggcKn1+BA6xfHgAVtGNkwwvOYI/AIa70g8JneqXkm/j
         pqHCJVf1noxeXnZCefw02cdMOnlz6YUnioaSD03zMSYA/QSXgYNABbp/xTPYky8zG2dc
         E93+c1oDi8Z6K6bPHUgvF57qGSbGD9Tl2Q14hjPQZKIsq6IEV7lgAg5SVONh/QlQihwb
         Uqa3FEfeLCPqjwPFmUEfRZtG5YgfjmrIADtYJMJBQ3WhohNwDUpkZQkjt7pXJMlaykRN
         qlcmwAdzsPvcD6LCmxxLNCm0lQHGRMibDddCW6zfkMQ+ko4v8xzw1Ra1SsWrSq2F/Doc
         TdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784382258; x=1784987058;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PkfE5djuvYksxq/+quScdXtUNWrd6xtiFm0fZFAsyFE=;
        b=sCaPWThGYDu8IlUJeipGKKQOX0MIpVExPbf9OtbJIeM8eW6jm7cF/WkckpVBb6XHDa
         LrwCP+SakWzEy/liFWpVelVbXpgmXefCLfMNBee+2Cq6M/3GYzeK4xGPy06uh1bSgTSv
         0J04RImDdSuIaVSjzQs1/49QnilNF0pWFr+cgAEsW50ivF4t68ER5J6SrTL6m0wionKc
         z7NWRPPlSprH2oYL8hSnryhGllYd/ANkP+8XZdUqjMuJ/SwpGH7kko5W0LoL6n2r3lWx
         my3JFGy+Lu2wePQ/wdNiJqzHy/2RJjWAPVVekrtARHgg7DLpmwxE6REgcsT6t+n0IZlT
         8Khw==
X-Forwarded-Encrypted: i=1; AHgh+RpByPgo2qrTrEHBFNUNdVIhEtV1VSmOiHqZO2YbtiuH33ojCXaLj1JWYiYXQKX1PBSeyAEqaLFvC5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhpXTr6vghiFp8yQCNe3l0R9njUQwZw4wM1s6mrBWB7FzhLWZS
	t6iLymBhNNEk5d05isV/2BHqsLBcWGzbp6MbUoCt6nuOpkLT6cf3jPbc9GqinT3mqEy7m9KjiXZ
	3PjGyxd81J1csimDvCGlek0evgllJsc8x1dgXnMUP/HyyLSQ8mm5idpXTAoPmryn2QT6xLfufZT
	Tv9W1ZPDO/GsayKOEcNB2uRxdZIEI4cEYYt+e7tQ==
X-Gm-Gg: AfdE7cmN+W2eeKsOLsnWy8kEFYvThBH74RfyL8+JxtnuUr5N+LgDQ/B6uetnbluSjAS
	GwoWm6kFN3Yy1Xk6/Fk8p5eq/Ry1/j8WEMfk6GCElow3nBUDWiC9c6I1SYBvPSdFDLZWl4BzHTJ
	ujrOMDCSQGhC8o1em1KbTOcb2sHPKfgAURVw0gUumbDYNOZ6H96Xo2NAgcoA==
X-Received: by 2002:a05:6214:519e:b0:8ef:91c5:8edb with SMTP id 6a1803df08f44-90778317727mr72671896d6.10.1784382257962;
        Sat, 18 Jul 2026 06:44:17 -0700 (PDT)
X-Received: by 2002:a05:6214:519e:b0:8ef:91c5:8edb with SMTP id
 6a1803df08f44-90778317727mr72671596d6.10.1784382257536; Sat, 18 Jul 2026
 06:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717180536.1757204-1-kamal.dasu@broadcom.com> <20260717180536.1757204-2-kamal.dasu@broadcom.com>
In-Reply-To: <20260717180536.1757204-2-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 15:44:06 +0200
X-Gm-Features: AUfX_mwFg-cDp9qgxVGyV_czYgM4oxliia1j4hpwU1KKYx93iGgZ_1rVtnZAaRg
Message-ID: <CAPx+jO_PtiodfrfLD00ZXWDpYS73ftbb_e4Y389JObHRw-cj-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: Document no-mmc-sleep property
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
X-Proofpoint-GUID: 4IbSDNxTrjJsPOkA9mQY2rKeUsv0o5vl
X-Proofpoint-ORIG-GUID: 4IbSDNxTrjJsPOkA9mQY2rKeUsv0o5vl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDE0MSBTYWx0ZWRfX60Y2mILPDkTx
 PXlv31I/8bnC/tkyHkUTFO9rJ86JD7YbttswlnaiH/2bRNpRrsDt/3mO36iORN3leW2iKSQlOF6
 nQJeQ4zdSKYiRYTleTawLX33JqOXwzByu1mi1HT5aI2ER8BQlIuPMkCtGdNDOGlbtoYrBeyB4jy
 S5k6wL+JU9QY2d8+V69apkWZ50aif4xa8/vpJx8aJ0Ez/4pTpfzBhI7Xxzph1xBSEdifG44XHMx
 NEvcqFPU8nRUtp+KaCCJojzzCrVdGwxYd0TeLAvUDpOug2nR387G8XlsqfU/pmk4LTw4573fEi2
 oW6CIbDbQ/SYxfMLIzY6kOuiON4p7nHmOhGl4i85czs+dyC/nihPijPIGWUTXrbyV+q8HuWT/aA
 otdeZQPOuw5w+AnPSPyjMPKINMFaV8JmRl2fp0k6aZ6Jx5mw8fN+1XUFrYJmBxjfkE0/srxr7C+
 p4/V+t252IwAQD22qGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDE0MSBTYWx0ZWRfX9QXz2DgFBQdu
 xREQqucYRqcAuWIEe9ARoptcnPN//v9i5kYz6Ct0iL6rNCwz1B3qb7qwFMO6+JpPlEML6AHEpmn
 nwqIk/WFXnPXr2O6kSrBLtbM/JqYdcA=
X-Authority-Analysis: v=2.4 cv=YsQ/gYYX c=1 sm=1 tr=0 ts=6a5b8332 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=Q-fNiiVtAAAA:8 a=4FQgA8aB1pJx2ohrXaoA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180141

On Fri, Jul 17, 2026 at 8:06=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.com=
> wrote:
>
> Some (e)MMC devices cannot reliably resume from the SLEEP (CMD5)
> state within their advertised S_A_TIMEOUT, which can be problematic
> on systems that resume from Suspend-to-DRAM by first pulling boot
> code from eMMC using hard wired logic that is not field updatable.
> Add a no-mmc-sleep flag property so affected boards can tell the
> mmc core to never put the card to sleep.

Please clarify what the FW is doing in the commit message so we can
better understand what is needed. Along the lines of the below.

Moreover, as stated for the cover letter; this is rather about keeping
the card powered on during system suspend, because of the behaviour in
the FW.

Moreover, because of the behaviour in the FW, the kernel still needs
to re-initialize the card at system resume.

In regards to the card advertising a wrong S_A_TIMEOUT, that is a
completely separate issue. If you want to fix that, we can for sure
use a card quirk - although that quirk should only override the sleep
timeout value that we use in the kernel - and not prevent the sleep
command.

>
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
> Changes in v2:
>   - New patch. v1 used a card-level MMC_QUIRK_BROKEN_SLEEP quirk
>     instead of a DT property; this documents the DT property backing
>     the host capability added in patch 2, per Ulf's suggestion.
>   - Reworded the rationale in the commit message and the binding
>     description per Florian's review.
>
>  .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.=
yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> index 3d7195e9461c..11df0524530c 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> @@ -232,6 +232,14 @@ properties:
>      description:
>        All eMMC HS400 modes are not supported.
>
> +  no-mmc-sleep:

This is a misleading name, please try to find a better one.

The property should say "because of FW, we need to keep power in
suspend but re-initialize it at resume".

> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The attached (e)MMC card cannot reliably resume from the SLEEP
> +      (CMD5) state within its advertised S_A_TIMEOUT, so the
> +      controller must not put it to sleep during suspend or power
> +      off.
> +

Please rephrase this, along the lines of what I suggested above.

>    dsr:
>      description:
>        Value the card Driver Stage Register (DSR) should be programmed
> --
> 2.34.1
>

Kind regards
Uffe
