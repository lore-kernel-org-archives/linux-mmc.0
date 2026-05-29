Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596B43DEFE3
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056624; cv=pass; b=G1usp9tASYnHEvUfAw2NLH1uoW0R4cfy4LWq2vceq+ee99GBDDfygzHnn+VijgtwVOzvhuwd5Yh2BuMAZC776xlLmzIq0TuU9TVSWsndCAEkwwle9MXN5H4v5ect/mX6T7tt12uQREU4WzoNXU5jJlzmQsi96ruyErABLakQ6Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056624; c=relaxed/simple;
	bh=4/YiZqa/JG1FUnGUrvFzA0RfBsImCiaHLKL6cwUuyk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApAzp1dou8PGIZq09N5dajKqkWmU4eYfAsPUH16X+DPSbDOKzvCxwv6Z29I8B1yTFV8h6WC/SFImPAPcJBhFJtRBIarraIef1aIeTTJTPzukaMHfRgX9kM5/cYJUgh4wdFeK1naWZgEJB8PJvH7pBffDu9jjZBBIKPeISFgi+Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RRzFHM6c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gqEG4QsM; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RRzFHM6c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gqEG4QsM"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T6VTmK562521
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 12:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+QilAcV8cP0/k4O+QEhYsVYC0asG/uWMj8eMgwQ+hcA=; b=RRzFHM6cekQZB+QT
	YsJaly3UU4j8wdtqTG00tu9CqE4XqQSMNOZno4518QluS/gdD5gHi9Or+KS6VZ5g
	l4pG1REEHirObLR1qUet6lJx+uEAS/W2JSvIPuaco0IT1rqoKWJ7MXornqkMeiTf
	2GjJf/uZcBOFpyNWzXOBAchsscEFzBSXhURutW4rfdA/7VFlFKt0IQvvPWhaSyQz
	Cv5kCIrSAhQKVhyz2TQGCinJBB65pk12mdH+e7Aiz07zoDymSrmgATpLY6BEDAgl
	s8RNlWD46DU1jsjjvyNO/IhGjcoXlUuqg2MYo9Dsfy6eg32QP1RJJLQuNh3yxJt1
	YWQQOg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eevug3f9f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 12:10:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8b49260e3d5so82748196d6.2
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 05:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780056619; cv=none;
        d=google.com; s=arc-20240605;
        b=ZNY8uVu4J2iXRhaCyUvXNU1WK7ETT5WEVBt1XPZlnyEDtRKuI9CJ7GG9E5IkM5IrAv
         Ipbhp8G7Ly2FCTu2f0OPS6FNWR7RHvUy7lkDWulCRZi4zeEAh3vv0T4/ja6SrYRPXmbZ
         Me1W1fuyqgTeDcVpaG+R2HHoYzCIC93R/L98vCTALD6V/2iqiL+OSDmSoWLWp3d46yvD
         ho4rj5tAeCmnm+dGKF7TsA/BV8ohgQrHSTqpSZ0P0vQgY4j6CGoC6CX3oRgU5+hNTbwH
         PIwp1YQmqLF7a8pyGWjNrkjfEESaCwbr4sUgH79FDHI1ugeGyjn4KLJZ4ALYYPsmP4WF
         J6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+QilAcV8cP0/k4O+QEhYsVYC0asG/uWMj8eMgwQ+hcA=;
        fh=OzE6J/gySYrc+4M3wfF1wluRrFR85gISXR/4lKZUQi8=;
        b=V94Y1xq+jrnO6ceilR49GJFsHpqkooytcyR/0WhanpkgoxVhXpjIfwO69AIvUQ1Ti6
         iMi7UWeAWEZugpz8PyFx0wvpRaMEJMt6zeFO0L1m8kXFpaLVaInsU/15iLMkRh5MZMjk
         ea+XP1vgf56Hau5xntzkeoFrOxSi8BwcCqz2h2mooETJ1zrwyYtDoHII/si8J2Ze5pgA
         U+gP/9vClIg8rrqxWColkcumrs9Rs6SRc+kE5rMmek4ugZhXwZLsahPSdYwX7foqJ9qo
         CjJaSB6cQjR5TfKQKmnCF63kkrmLNX+LbeEu83Ol8eFDLrhDs/kmg0bU7dfYLKh0dOc2
         fAJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780056619; x=1780661419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QilAcV8cP0/k4O+QEhYsVYC0asG/uWMj8eMgwQ+hcA=;
        b=gqEG4QsMid54c2AZuImkJYvkHuHSZZntWQwHHoITuMJqN17SLmm7DADeg3SfinVD2B
         50m8pve740UBSFNdW8MCJhyeNu2aXhFWKZ9YxQiac/yKfXSxMZDo999zrhC4trd+ly53
         ivGF9sd3tgeVCnLkBCqygRuCYtD4w0YiBS9iyki5mm5WVOZuubh9q9hzW6XFQjtiG0ur
         /PHPmdexuux8VgKq+l6kW3xIhLJ6ZFf8oRwX6xxVXPh+lmKtacusL1PTUl+tnY4uSp79
         KL5p9a4Wevc1bi4+uJZLwL5N5U4GW8u6Hgnys3+Vh1oDxkYLsiKPvMhYqK8XtFXwp5Oi
         EHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780056619; x=1780661419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+QilAcV8cP0/k4O+QEhYsVYC0asG/uWMj8eMgwQ+hcA=;
        b=gIosAPnl3C3p6U+/VBFbn21+JEUuTMl3cWbqMNOC2t5XRc/kt892zADhSlCKEvGdaB
         O1ZlgsvpwCAduHP/C6UmPoL3q87hT25OSnPB0bicS3mep6bqcIQNvVnUtVvHCPhgHUk9
         kCGodReOhhXZv/U7nYuLbZXt1zl9j8abtHeqaha2CiHc08nkZg/F/k3tZ3XaeZTIELf/
         l5RGlBoE8niyDg9mh5xSCqmLOwHfu9WT5k141Jm1JxZlOwdHeC/+8pgEZMAJDMU018Gx
         w11MFt9j1Ro6BAiRAtyzujIHDwR4z0m1PV4UadpqwM1W1qP0MLasRBGz8xO6w2FZVhHM
         KoSw==
X-Forwarded-Encrypted: i=1; AFNElJ+kN51wH4KAnob18PoqfdrRjkOW86TlZlVSk94THyD2OYYNWZvhe9j/DxCmDB9A0Nc5suTIqfyLL+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlX1eeG/SGwnh7T+rUnkEf63fm5joWLbANaFrE95PF+G+Jr/a9
	fzPkkFGxr7Eoa3jittQkgwfbn7ubJiUpWywC0OflX6cnpVlq2yNboQo8uT/j08QLzamxnxrmEza
	fQsG7Wr0jGgdzGWdq4wTg8cC08fsOcGclX9u+6vYEbqIqTiOhleXTeTOMLfONw9IVn0m6X5pPRp
	iv8VPs5G+d5pHK6LAFDIpn60spt6JjRIgpenpxokfEq7SYGZzo
X-Gm-Gg: Acq92OGiraFFuibYi4502SkDNhJJkOFuQCzBTPJtEMHVjhbIiwqakCpJTkF4H4W0JTQ
	ZodaxZR4n8nNkPQ4x2XjcNAsFiSGH/HtNLsKtnWEtuDyzfZx0B3r/V3t4lMW51SfFsaKCDW8/59
	caSzgpe+RK6phFjOW9+BkhKXaZsBj1Vp77wbwWn1ngPhizu1rnoEE6k5YPFIpheqQGOl9yFnN/9
	1jx6hv5+frsSd1whw==
X-Received: by 2002:a05:6214:e88:b0:8b2:138d:32e8 with SMTP id 6a1803df08f44-8cce7fce689mr30733496d6.21.1780056619462;
        Fri, 29 May 2026 05:10:19 -0700 (PDT)
X-Received: by 2002:a05:6214:e88:b0:8b2:138d:32e8 with SMTP id
 6a1803df08f44-8cce7fce689mr30732946d6.21.1780056619051; Fri, 29 May 2026
 05:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508-st-mmc-v3-0-81c329ed28e8@gmail.com>
In-Reply-To: <20260508-st-mmc-v3-0-81c329ed28e8@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 14:10:07 +0200
X-Gm-Features: AVHnY4LU162OOxc9tFfE3j5ZpvhE4LA4WVgEbnaL_F-Mscjocx7-8n74YjsKkeg
Message-ID: <CAPx+jO9woUB9VGUx+ebWD9oOhqCwzXL9=41MEesnWS15Nyr66g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] dt-bindings: mmc: st,sdhci: convert
 STMicroelectronics SDHCI-ST MMC/SD Controller controller binding to YAML
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEyMSBTYWx0ZWRfX53LSgiFeMCtm
 gCx/6pDldDlFhXkSLT2STWZ8tnPFDlJ4bYa4JFkPaTSJWbOfqnVhGBBWutLRYLVPn9iBHL35ET5
 qArVkWs2XzKmt9f1EnOU2nQ66BI5C5XqAanUJDB2UewkB3jBL2rBfR75BZ+QQIxox88mPnVOBlH
 TR5UHAWIi0rIQ5zTxSgVzzuGsJpolKJg2dMw+0ip+42TV5G+Fu/hgeuzFblJDDAvJX/Q3/sfrPk
 bIfYe+cySa+ucC+EA2Eu6X5yZjqFBtIsA6gsE2D/ewnsv0fiqwIGvgNqL/ZLYOKRtirDbTEjGTP
 Yd7p2gMoH2/uiXiFFbeb3klkcYqav5zVntVdS9opX7XcHOr9urxNtxeRQw6aLeR69D98JNlvBpD
 Qm6N+Pv6PKcY3d5HIpmdxwFimAE8my1GA28RAdueNC5yJiYPHk2OwqvY1GogSGADwrRqKOx6hpe
 tgjhFtvKC70FIm56iUw==
X-Authority-Analysis: v=2.4 cv=SNBykuvH c=1 sm=1 tr=0 ts=6a19822c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8
 a=xZACtGnEiovJ44qPjMEA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 8pw92RZDVLqKLCHF3kuZHkgohmEprldW
X-Proofpoint-GUID: 8pw92RZDVLqKLCHF3kuZHkgohmEprldW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290121

On Fri, May 8, 2026 at 7:23=E2=80=AFPM Charan Pedumuru
<charan.pedumuru@gmail.com> wrote:
>
> This patch series converts the legacy text-based Device Tree binding for
> STMicroelectronics SDHCI-ST MMC/SD controller to DT schema (YAML) format.
>
> Note:
> The patch "dt-bindings: mmc: st,sdhci: convert to DT schema"
> depends on the patch "arm: dts: st: align node patterns with established
> convention". If the DT schema patch is applied before the DTS
> cleanup patch, `dtbs_check` will fail due to the presence of the removed
> properties in the existing DTS.
>
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>

The series looks good to me, but awaiting and ack from some of the dt
maintainers before applying.

As the change in patch2 for arch/arm/boot/dts/st/stih407-family.dtsi
doesn't seem to cause any conflict from soc maintainer trees point of
view, I can pick this up too when applying.

Kind regards
Uffe


> ---
> Changes in v3:
> - st,sdhci: Edit description of reg property. Modify reg-names. Add
>   "minItems" for clocks and clock-names properties.
> - Modify the commit message to match with the updated changes.
> - Link to v2: https://patch.msgid.link/20260503-st-mmc-v2-0-11ae3216d2ce@=
gmail.com
>
> Changes in v2:
> - Fix node name in DTS for the MMC to match with the estableshed conventi=
on.
> - st,sdhci: drop unnecessary properties, modify "reg", "reg-names" and
>   "clock-names" properties, include an allOf with $ref to mmc-controller.
> - Link to v1: https://patch.msgid.link/20260409-st-mmc-v1-1-4c54321c3535@=
gmail.com
>
> ---
> Charan Pedumuru (2):
>       arm: dts: st: align node patterns with established convention
>       dt-bindings: mmc: st,sdhci: convert to DT schema
>
>  Documentation/devicetree/bindings/mmc/sdhci-st.txt | 110 ---------------=
------
>  .../devicetree/bindings/mmc/st,sdhci.yaml          |  91 +++++++++++++++=
++
>  arch/arm/boot/dts/st/stih407-family.dtsi           |   4 +-
>  3 files changed, 93 insertions(+), 112 deletions(-)
> ---
> base-commit: cf2cd8efd046c561191b8541d32a8bfe845bf06b
> change-id: 20260327-st-mmc-c906ad95ff83
>
> Best regards,
> --
> Charan Pedumuru <charan.pedumuru@gmail.com>
