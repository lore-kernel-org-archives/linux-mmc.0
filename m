Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CABD3ECBCD
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065970; cv=pass; b=VyRPJfp7hY0rqNk0oW5Rln3kbTfFkeNdQ7VAlBFqSZ6EHj51fpq7KE/x1VsunERWr5VXyf2vlMu0/jAEkKoldyluPvmN8ZPKQdmKDMZpohl2NRsAQdrnMDEHG6h4qsh6XWHvcKmP1aZ8M3UrPxOD1P4Pc/Qhz1WLaN76Hu4YJo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065970; c=relaxed/simple;
	bh=ujCYn817iX6wlBEWzpPBEDe4rtEevi5+ZUNJsLLv2oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGoT2Rgm001ebIGwwOMsklSiY0wNAqGfUgYxH4cT4sKH1lROEWsenrn74E55YiWWpbFsdEgsv6ZaNo3pXQyLVLnBdqHW616KmtdFCQcvgY2WJX1gMQhG9NwZSJUBSzi3U2L3/q0t6hqq6f3GkhYXH59/ohaFpzvmkLxqV9N8fuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gvjaNbGy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gdsmLXL1; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gvjaNbGy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gdsmLXL1"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDKxkI3729436
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	voUJObYcKin1raCObqToYyhbjwo0Gb69o1ZFsTElHNc=; b=gvjaNbGy9OG7lgC+
	1XjNFFrJei/xE63AvWA+ms4OiSYfmg0+FVGVDmKiL6kAE7ix5pBZoNcRwaFFsJDa
	+HGGvn9bvwfKm4rNUf/W1V4cGMH0hnHQz/XSMW/tTCi4j4Jx2lHpeBhBWh09nICg
	1z+rKmsEaL37efwt8dBlePbMZMjvjXgGkRxf9xv6Y+eXBK9XugZrXkx4xS+WK5Q1
	2AgQXcm7VC1sbvA/MLZvKgErte5FY143Tijk+3+xo3YZm5Pyh/6L3W1twxbrpq7S
	RwqzLltfBHsgBkMjoYrVgHooE8qatMoRKKwck6DHGM3Pi2UAIAZDgr6OKaj2D0k0
	FagbyQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety4vn5q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:46:08 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8cce230de8bso25698916d6.3
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 07:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065967; cv=none;
        d=google.com; s=arc-20240605;
        b=Lzw42/iRgql8MDIzNGtCSV1u68ZnWVLKmPEXTqOYG7haaCKJMPU9F0GUz2Mq+JrQ4s
         InP85mBRVB9BlF5PoSUw2aPH4UjwY/XQ4uknrIhO939xUNEtEchm0STyNFkCaWbzJ/qF
         83++RqJDW/oq960KRElIvNIV/aITpby4TxKLhVfrkopfYtmULh8hHcirsg8y2Saw2/as
         zPNfHWqneoMQCh1TMJwlCg4vWbXAUUMsEUZRT4pfDjpW7pX0QBiO6SGFJ61jvesaizLH
         RoDnW3Mc7pieDSsIYJKGFYvsuFb524h3XyTDXaBCZ2Cg0AkFPDWKeA9TREjF6SBxJKP3
         u8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=voUJObYcKin1raCObqToYyhbjwo0Gb69o1ZFsTElHNc=;
        fh=LyJLBinr0f1j9eLW/UkUeosAKzNGKZbZHkEICGCmzI0=;
        b=hIVPwU8xTZpBSd5WnmhL21slSBNzR0+0B1GvjcQOcjB7o24opeT+ayhvtRd3oXuasB
         xwjolfhSexFqX6w6fHzo2ZSPHJZOSS1lD80YbX16wGuGo9wFWln6faZ2zvw2bt+8QoJG
         Ddph0NahtxKFA2WGfCxPmEiP3KBM35EUpShweuEXmH6xL3l/7zbpvuyN2G7NIsO2xEdo
         ic/+cqFuDs4BWcqmyHPtFrC8MqWu79WtKwZmrhIC+IHQYYmP2it1j1/0Y35mJhXVeAsm
         9JjPOB21wG81LB3G42lhUdGC0RKqR9rqK9S8yHeBR3MUMo7BE3P7Xvud6V/GK1gF6p2q
         a1cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065967; x=1780670767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voUJObYcKin1raCObqToYyhbjwo0Gb69o1ZFsTElHNc=;
        b=gdsmLXL1o3n2VUCpZex7dM82iA6UDdpimAAk9EEXZBMEZrBvNs5Q0JQs4aTyMkPiGP
         3hCs4XpRzJw+wonztg1EafKoxCpHnBDAliEe0yeKo3be+U2G2FWEGNKgc+WAHWdhXy90
         qo6tvdR2Pf/RnmmuOZMCvmkncFK2GU0DFIHzE7qoedTrE3gXO+7FUyyMxnbbTbGcqgKR
         nJdwaWHfR9INM1z7D0dNL2roTauJHtlJ6kTA9XVAmQyiANX3cl/KsTS4Dp8fG9ytYBP7
         ZrVJOv/lkHj5S+bp1IcKh3fWtdJfUO3f0iWjyzWAwgaLskTujljDY2IH9xZvhRrKDB8g
         EtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065967; x=1780670767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=voUJObYcKin1raCObqToYyhbjwo0Gb69o1ZFsTElHNc=;
        b=kXUCBNvRha/kh4NiUNuj2lgvnBYGCSY1eVH1n108y2csa2EB5BDVmqDiTWt5S/1KF2
         k5B3/pHkH5Gn21E3j4B10m7CrpXmVHLkbRlKG/GWRlxrHq8EJhZtP55ZHzNh4UI5MfJX
         zrem2kakgsbcOPS0txTXVIwbsa/t8z4gRDMWDTDw0TsIYuMsmZiMRBrnxCRjsHjGl8vS
         5shPc411xJD/yICWz7x1KvQFQ5orXixPZOyJQMa7Ey6DJb7Un0Bq9uuC1rlWmpgUf+Qn
         fRHkOqP6JrigO/irccep7hZz39eny65mLvh7IeUUfGMRBfu2dIGtpxaP0jfY54ZdelXu
         8YXg==
X-Forwarded-Encrypted: i=1; AFNElJ+DlJJRonsszS9vsaFOauvwHk7PxJT1YCjE8MRMK2atDwSpz8aN99gsTygSOXfyxu09fuJ8ycipDjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIHHCeHTPyCMEPln7HhSzHjpB6EO7OrqhkFJtSgt/zWhpju9y
	EXUshDC/8q8sea457iElYg9N87vdg3BkTKr8x8Q/MPW0Wvp7Og+wcJqDjFkezxrhFh9Er7DKPFI
	grfP1/GJX+TVkva6zh1p0SG0XwrUbEwAm5e6jFQcirQnd3Zjim5jJeJkit52Kv53dzPQd/wWmm9
	uwwrR/uVICthZOQHXS21gCdqOrvN+JSn6bZLe8Rg==
X-Gm-Gg: Acq92OHqtpbqv2PMoCWO6BE5IRTm6HCNJ+VYRNTeKIhrkAtnTg+FP7Kq1x/GsiikFNg
	LwQ9I2hbOiOe1dMyo3FzbIUmZFAevN7qU/4vplZHAtQqwBTbfSZZ0zKZXWXa7SoD9maNOMV86y6
	NVuSCITrIKfiQahE/4ocVygXIzP3tBAI6v/LHmrPXDDUxbH1WoL7DU00WGjs09fiN96CKUwLzbR
	LR7BUEwonanpV507A==
X-Received: by 2002:a05:6214:2129:b0:8cc:611f:197f with SMTP id 6a1803df08f44-8cce8273b9amr40421416d6.44.1780065967388;
        Fri, 29 May 2026 07:46:07 -0700 (PDT)
X-Received: by 2002:a05:6214:2129:b0:8cc:611f:197f with SMTP id
 6a1803df08f44-8cce8273b9amr40420966d6.44.1780065966941; Fri, 29 May 2026
 07:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528135342.11678-1-manivannan.sadhasivam@oss.qualcomm.com>
In-Reply-To: <20260528135342.11678-1-manivannan.sadhasivam@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:45:56 +0200
X-Gm-Features: AVHnY4L6MWNB9ipo3mmpNNI-uKAIfhPINhRgf_XrDuSat0AGf5o159oc_oNQjTg
Message-ID: <CAPx+jO9782bBRuMAsJBgRc7y=THa_+48hY8xPieZAB_3dWeaHA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: Rename the binding to
 include 'qcom' prefix
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: ulfh@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: zJ1dIdb6Aim3yaN_g3mJLnOtAdZhj4pH
X-Proofpoint-GUID: zJ1dIdb6Aim3yaN_g3mJLnOtAdZhj4pH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfX5d7MeT3Vf87o
 W4ut+8iiKj5y98mGyB88aorBGlxLdtYiTUUAGjBYZhDKIGKf3EEF4nTjug0RvV/1Gr+z0KyKwnv
 4eUh+58gD8586N0IE/Lc6SGeAhhekqWRELnENcpc/smtfX8eC/Wn97x9w3HycAJx+2L5CodR4uY
 1MMuhwwGg19Rdcg63RmQFfwN2YDMqfCMuupd3bnsSezVWLlFgBYJoYXWoQ3D3vxNvSao8HvRVL2
 6ACFbHfG1TTMmgIlWxVcANBPSXq+SeAxlWNyT933+lfZwGWOUsfbHv/RVKzfGYI11wxn1qOwr5Y
 BjqKFShRJRP8xxtGEQL9VeHSLjaioQt7U9/BMBdiKiRpUqcBzh9ZRqAYZYRj/If1d7LGpoatizC
 JnMNic6PhGZod0DLKCV8QIDoEXFjZzwXqdcAsnqbIO7ibaVajclS6Zy2sH/5C/qn+ilG+wbtWTq
 zqUrdu8+KCxRRTml0xw==
X-Authority-Analysis: v=2.4 cv=S+TpBosP c=1 sm=1 tr=0 ts=6a19a6b0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gEfo2CItAAAA:8
 a=5jWyPAnK0HxrPH3f6sQA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290147

On Thu, May 28, 2026 at 3:53=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> This is the only Qcom binding that doesn't have 'qcom' prefix in the
> bindings name. This doesn't match with the regex in MAINTAINERS file and
> the 'get_maintainer.pl' script fails to list the 'linux-arm-msm' list:
>
> Ulf Hansson <ulfh@kernel.org> (maintainer:MULTIMEDIA CARD (MMC), SECURE D=
IGITAL (SD) AND...)
> Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEV=
ICE TREE BINDINGS)
> Krzysztof Kozlowski <krzk+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FL=
ATTENED DEVICE TREE BINDINGS)
> Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENE=
D DEVICE TREE BINDINGS)
> Bjorn Andersson <andersson@kernel.org> (in file)
> Konrad Dybcio <konradybcio@kernel.org> (in file)
> linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITA=
L (SD) AND...)
> devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE =
TREE BINDINGS)
> linux-kernel@vger.kernel.org (open list)
>
> Hence, rename the binding to include 'qcom' prefix so that the regex
> matches correctly.
>
> Reported-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Closes: https://lore.kernel.org/all/20260526151003.p4kn2vek3hpv4gzv@hu-mo=
jha-hyd.qualcomm.com
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../bindings/mmc/{sdhci-msm.yaml =3D> qcom,sdhci-msm.yaml}        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/mmc/{sdhci-msm.yaml =3D> qcom,s=
dhci-msm.yaml} (99%)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Docum=
entation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> similarity index 99%
> rename from Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> rename to Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> index 695a95e8f35d..cb16c08d22cc 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml#
> +$id: http://devicetree.org/schemas/mmc/qcom,sdhci-msm.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
>  title: Qualcomm SDHCI controller (sdhci-msm)
> --
> 2.51.0
