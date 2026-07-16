Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8643101BF
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jul 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207775; cv=pass; b=LVH05SyOeq2cV1DslqMlF3SM01/MttntKl4itp4dyvf1m9LdqX8nauZSmNEL66svqpIKdeTGgVbXZOdPPjEcuKtpWHPPA0tYatf68gmDQ5EQhhfEnBbMqF5sZAi60r7xKUFGofX/qxJAOgp9YxXO0Ke/qOGd33nleqz/X9p57sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207775; c=relaxed/simple;
	bh=Ol5TzOFQVeS65ykjtuQHG5ZR3pJBc9DnPr8fJIb2oGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NqzTI1V6lkDMD0zBFYi2y5cD6GsRNdRE0kxStxC7snkpUzq2MlYHnHVHKVf+1AMvsmeFRFXtTWuy96+FmtmYOm+k9BAIsyL9yHGdH4EqdP/TOG+f0f52awUt/E68LoaDXakGwEi+DPtfm5unakb3zxbpoQIkq3/LnHCR1/4vOPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=etdCUJoj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ry8Lgxua; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="etdCUJoj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ry8Lgxua"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GCl4Sj2882351
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jul 2026 13:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/B4iYT8JXNSKCTW8VLG62a5RUprb/Blp5ndsRHUBUUo=; b=etdCUJojuqEHNN+N
	LC7zqWl1IfOQeu1pdmw/8L86dAXoYxa1rzToiwkijk1PXVedZCyGrOhQVL8X7vHN
	S2Tsty08wIYj4iMy6VuCOJXXmnYl1Sgkad2yUVZQirDjCJifzDo8njSkhiwodGJQ
	F0dcRXt2KZ1aBwJqQ6eziLn/4l3mmM50QMUJGa2fJz69dM/cyZeupODdoYeuvcHV
	TQJjMgmgOfbfrmaFd6fLlkjLaWL4CylziwDxgOriJs80Qg17lzZ9Jx1AjC1nD2OL
	lsTLszOnj+UQj0EHu7IuJBRqksvcLr8dKtogLY8DPgDiAVtFt1+nE95Mqhy44OK3
	hseCrQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym183qx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jul 2026 13:16:11 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e67e87752so39657097b3.2
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jul 2026 06:16:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784207771; cv=none;
        d=google.com; s=arc-20260327;
        b=ptFsqAz3EZh69sgpBBg+A3NBKfWsI6RWa3PDGIXB0tbIuu+wpw9OyCCIzZUAkFdOOA
         gl870IHN/T9+z1cPR/1l6nk55V3AAPIlCZuRnEjlohb49ZYIahfM2ds4Z6CbUKCR9J/y
         xXTvXAtTH3/RcKJ0Q5Kju56VF6TWQZg7xY7tMIxfuegjZ4wxRtYMwiMuiMQjvqt35MYl
         ciGdw+pDno+uzlJATEwj+RnWlxPICBQHfrLficoJu7pqh+lyUGsoWLEGibc+ZD6VHOja
         zWSCbT2Soo+jmqaETL8RxdCKzYKLhiS3mm/jYSqQmsiKkoAF3ucd9A4A3hBAU4k3/+B6
         ZlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/B4iYT8JXNSKCTW8VLG62a5RUprb/Blp5ndsRHUBUUo=;
        fh=WHsDyAcn6NMDLyhJ8bjFAK6i+f36UN5emC66MY1qhgs=;
        b=N+gOs5XfBmiPUYWHzmHpgOqVrro7dR1irdxSaOCGdU7tv471/yfmMNO08SRVlC3wih
         ngEwEsz6NkSj/9aVSIaPzV3lqxZoyag2bdUUJU+7/G+kRLXUhtA/KsqnuOFQ4Zrg7pcG
         +KCrPlPsLrbDKfisiOP20mTij2jUn8BbPDBVia2P1FVKO6KE9UM1sBpoGaj0G3EsDKfq
         ooXWc2cr4pTsq8lNY6wrN+Oi9WYcjoLI8VmOgwFlAcsvLDRqgJWeKmkZFSvyFxzoedbN
         oJJaMCi+HmaXpvun/Y0PtCQj47A9o3CIVS9JhbcBCPUs+YdOMBkF0NXJV4NCPxdzfu95
         KN5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784207771; x=1784812571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/B4iYT8JXNSKCTW8VLG62a5RUprb/Blp5ndsRHUBUUo=;
        b=Ry8LgxuabQRErqJgcaUGUkgdudWIryO8BCxy1a72iqGAjoYvZcjaQEmH3FZbRipjQU
         4Qdug5Rq8GIfDnkY3A3bFWUnXUdu44XXCKuEKTBYYZQeNFDnQ5IRu8Tfe3j0zXlCZh96
         QhY6qa3PDOPyjmUYflgKruGgM4IjaXc7reA6nHgBUYwv6xNy1tgLFvZyvkGrjMKPSHsL
         +eQ9lAqNqcnODE2k2hoeJ+U+pamfd2w4hPOStOOP6t4rTQWZwc83ezXxQkmTloCiz8e5
         tutP3ZB/u4cuptdcLxYRMbExS3dW3hCdQrBfcHNAk7Aay9nExANj6nkWNDwJGE+hz2gW
         Wb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784207771; x=1784812571;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/B4iYT8JXNSKCTW8VLG62a5RUprb/Blp5ndsRHUBUUo=;
        b=Ou4cdHFaaI759WYpCz/AJlgpiPezV78Buc0zrvYE31sJqinaysOiRD5cmSG2XlJdtX
         npYaM++I4A7BECqactEfokE6d4ONDh6OrQPMFH4d2597TdyR8xNDEwtTcKU+8vqLOlFH
         S6w/n0b0fl1BAGB4iBeqKlVVs0uY59+Gz9ROmUBj4Pgk7DVLx603vD+8UkbNCBIKoApj
         RxfRGTEJ/A01Om6VZYeyc3MSfILoT+Kf4udIJ3tCZ+2HFMnpIBEK51+An+yq9l8GwiAZ
         AVlvM1RW+xfW538ymHAIoYNTpBjNvLdt2qn6WrrId3Y7pxqs1F2UfszXbPWEDS0abFby
         Hh1g==
X-Forwarded-Encrypted: i=1; AHgh+RorAYfEh9Y9NHCn4EigUP1cIZ/tiybPt+uOOlTvDwd9q4OY2MyCfFOSa3eaxJxw6MBMkEDKW2OX7ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzijU3r0AUOiIpgD8YUmv+dCO4gpPeBOzOmIh0zimBh39uT38SF
	5N3BwyzrQ9XX3CdQzTZ8NBL+Pum9sTrBO+ARVd2f1qOZ0FFG02PbZSvUl01LkevXxJXSO0ItKSG
	ScLeHZb9MfrK1ioJz3QpNZSBhVI+9Sp8UWrPEvZpV6IDZGTyQeYXH80ko6SGkUuDl4V1TZuGuQX
	JeSxqz/6PNKy8MGic8JG+rJyZECPG6ilESHmd0YOYBNTc7dQ==
X-Gm-Gg: AfdE7clI48MPye4byBi9LSxY2z063TCLn7GAZ7HLAkvQn1e5ggJp+uAeLvymOi//RUB
	3PkZy1xpc19DlXLBJMuMbkh8HDO1JJVy1rCovqzLy5RyeECjyRCAwvq8k9n3VV8dvTMO+MsLzVJ
	h7jqNeM9nEfPf7KbVjVrItDUPUW2NSf9OzUG/GHBdqIp1uFn4QlNnjWUbSjg==
X-Received: by 2002:a05:690c:6288:b0:80b:e6ac:53dc with SMTP id 00721157ae682-81e900612bdmr164983167b3.23.1784207771403;
        Thu, 16 Jul 2026 06:16:11 -0700 (PDT)
X-Received: by 2002:a05:690c:6288:b0:80b:e6ac:53dc with SMTP id
 00721157ae682-81e900612bdmr164982837b3.23.1784207770812; Thu, 16 Jul 2026
 06:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com> <20260703-block-as-nvmem-v8-1-98ae32bfc49a@oss.qualcomm.com>
In-Reply-To: <20260703-block-as-nvmem-v8-1-98ae32bfc49a@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 15:16:00 +0200
X-Gm-Features: AUfX_myXBBNTUmTNQa31CjGyXdLn9Tj5Tha2CpRf0CSZBFmIzb05oixLNDBVxEo
Message-ID: <CAPx+jO_6KcZyp=4HuJqnYY40VKt1ee+si0BEpxUE+1pkMFtvCA@mail.gmail.com>
Subject: Re: [PATCH v8 1/9] dt-bindings: mmc: Document fixed-layout NVMEM
 provider support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a58d99c cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=j8101uY4z0N8CqeLiEEA:9
 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzNiBTYWx0ZWRfX2/73x7mZ6SVp
 cwlFvIZ0lURgBfHoQj32fTjkzemZmV+0Bls5TP19nLcVmEA0Bd+OK9jujmOCNSqL0cFHQkYDd1k
 YffZD/bPi4pyQvZHa+ZB0Aw0q+MazSuM8K1QQdUyjSsD0VAvEClfIcFGDOFP52XJirJ/+/OWsJi
 ya+lzQf8j+WLzqZkQt+pG0834i9SgfIb3LTJh0vanIHrP5YnbIvZjFEnf7tSJQLj3PJnrqcLmsl
 HyRRBYQVyu6ne+v46s5DuOtDpWGputxzP43tv5ziv41FvWhv6U3r/KQkiR9ct+n2EyLl0ddoM4P
 vA3FTc1dUe5RK6ntFaPd6DgD5hfbhUMwYgMUmhUFp31PK+EPRQ0EuC7TettInIL/4khvNJqKrmz
 W+KQbabbzLHDxaO6QrqRxHO/huNyCj4p34DMSoNi0nk0WosZFL2syzrTyAQKGeXF18dF8lA8dNK
 TYTAn5LWxWiYOveJsJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzNiBTYWx0ZWRfX4ASUi1CTEMc8
 /LCG9WOMX/dFX2d4eEYnx2A4ef84nU0xWUUH8DCHlTQlIvCTvhLUe/FhRt9SyLfFzfw686b6iTF
 RhrpjuuRELE8HI4eNPpnB5Ev4/KfSXc=
X-Proofpoint-GUID: g9U6qMfGu76YIi-8xHNRo-QtotKvGd-h
X-Proofpoint-ORIG-GUID: g9U6qMfGu76YIi-8xHNRo-QtotKvGd-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160136

- trimmed the cc-list

On Fri, Jul 3, 2026 at 3:45=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> Allow an eMMC hardware partition node to describe an NVMEM layout so the
> partition can be exposed as an NVMEM provider. This lets a partition
> (e.g. an eMMC boot partition) store device-specific information such as a
> WiFi MAC address or a Bluetooth BD address and reference it through NVMEM
> cells.
>
> Accept "fixed-layout" as the partition node compatible, in addition to
> "fixed-partitions", so the layout can be described directly on the
> partition node.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

I think it would be nice to have some version history here as well,
for next time. I noticed that v6 was reviewed and ready to go, but
then something changed in v7 as those tags were dropped.

Kind regards
Uffe

> ---
>  .../devicetree/bindings/mmc/mmc-card.yaml          | 23 ++++++++++++++++=
+++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Docume=
ntation/devicetree/bindings/mmc/mmc-card.yaml
> index a61d6c96df759102f9c1fbfd548b026a77921cae..0422894508478c8d0ca68292b=
58a5fdbee218358 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> @@ -38,7 +38,9 @@ patternProperties:
>      properties:
>        compatible:
>          contains:
> -          const: fixed-partitions
> +          enum:
> +            - fixed-partitions
> +            - fixed-layout
>
>  required:
>    - compatible
> @@ -86,6 +88,25 @@ examples:
>                      read-only;
>                  };
>              };
> +
> +            partitions-boot2 {
> +                compatible =3D "fixed-layout";
> +
> +                #address-cells =3D <1>;
> +                #size-cells =3D <1>;
> +
> +                mac-addr@4400 {
> +                    compatible =3D "mac-base";
> +                    reg =3D <0x4400 0x6>;
> +                    #nvmem-cell-cells =3D <1>;
> +                };
> +
> +                bd-addr@5400 {
> +                    compatible =3D "mac-base";
> +                    reg =3D <0x5400 0x6>;
> +                    #nvmem-cell-cells =3D <1>;
> +                };
> +            };
>          };
>      };
>
>
> --
> 2.34.1
>
