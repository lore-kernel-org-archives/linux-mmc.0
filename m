Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4A409137
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065929; cv=pass; b=RNAdvQglmklB8g5GcFTzYtJp5THKfunm4xb2vEPrkTZOeaNhjhTjk4oEee4umL8NryC9Pv268r/4gnomPWrA4O9aXBZNqlMktFg4tZ2tF/Wf+1KGRGoMGzO30SbzXyT9RCT+efYoya7ONXHdoOAHnR/zMV7ewk3o506Zd8371D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065929; c=relaxed/simple;
	bh=T4aZ5nMd2SQdcBlP1Yq87qM0y31KgodulEmLY1IKSns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BK2H8Nzhqaqg0ixfdXdyMhg606+ZLKItdTMbL9pDIEJAAzCQqcMz2GcG+zUTMWLDs/ZM8IPURYLxWYEhFTReP82NRjUhVIDA+03lVTuUpRA3vr2TC7l9hU/qMJdpkDXAfHaqKfCoBNc/I7PeaBOdL5jQhLRZuvySiBdNSZPWzYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A4twjWk2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kipfWpCy; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A4twjWk2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kipfWpCy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDL3xT3249857
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WkFzsgrdko5whgmD09ahCUh6vRbCMjGnoEBT+p07030=; b=A4twjWk2FYsJfvBE
	fxmHRZOj4tQslO+i6mWmo9eokTff63F74S/xRYeD4LZIHJMGq8LudRWy9b52cA9p
	Gn9h7wO5MFD5pfBxjhdxvLh9YPyRGfXIC5Q2OiT9VsGS73Cl3V89+DoofR8n50HQ
	iARZdslpJJwWjxYkqrkuGbbR7zUsWNaqpPQY+AMt0FoNqxigU60SPECqtL/LVvo6
	t/YBONcxjJb4b1OHeKJRUk4cI/5JJWOEAoAtuhwVFAtpykBCIfwNK8I3jFgmC4qW
	1oOTBQjDiz5s+HLztmSFXADKv8nsZWwxZk8oNl2sXPBEGUR91ST4CgS1Uy+laHOT
	YMwn5g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef015b5h4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:26 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8cce42a4e75so20089266d6.3
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 07:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065926; cv=none;
        d=google.com; s=arc-20240605;
        b=FjoLwEsbYwsBScE503kLfArULMPze7xkZLA4KLr3GFK/X2yTiQvFxBpNH7/KUZnueE
         o5JEHUkaylsTAWHq2vFKfK775Le2mMuDJz7lQiQw+BR5iP62NbG9XSQL6tKNQDF9F9fL
         ZjFTHidWFfta28bgHnjhtkM+lfZq+DbTR88Di7AsfPraWrsTpPnk3UkqA4spl5w85Lqg
         X1OnJjXDlKpPvrVf/mnTAVeIyx3r/ydBASAhZI7kcVsHqRT03Nv44WWUW/oR0fblJr4J
         iT7E2RNkp/SrHRSwOzW7ZUuXZgllpnBOZZUV6rWa7mRoMCwRbF3pKc8xkzvS8fmYTiWW
         jP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WkFzsgrdko5whgmD09ahCUh6vRbCMjGnoEBT+p07030=;
        fh=Hsra6sW6xyJla8fTHtcK9QXP+kLOPxKRQ4mIww7zEG8=;
        b=JipCGl3z801k37cmSmki7csw8MO5UI1LS4tjOcDV9Bp71L/AcToVp6tK5pszWayGGW
         t8qawh3+rzYlbDuQd0ZOPCWxtvCzuE5dRw9f4gcILpn9FylO+4z9on94Z5D99WI9VNv/
         0SYhlOWNkw//6qqMEKIchZNxJFobhwuPVffs66vOFRr+ue2jIPMZe4HLryRu/C0ucZ7O
         UhMhPj8iI0PBc0VOgq6lyYh+wSCzGDXV3ZHkn9HB9X1zISJbvoIPyFukPaUPOb56xRdm
         xW+i6dHA7doFF1xhdQRygprsbjb32oQSy59yFZZGivQdTV9wuxxylKT7MRK+wN1FWOgV
         u6uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065926; x=1780670726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkFzsgrdko5whgmD09ahCUh6vRbCMjGnoEBT+p07030=;
        b=kipfWpCykBm/QevmH4fENuNl4Yk6hEg97Q1n8gUOnIRHhWyk4VCrNMDcD9Ab9+wU9D
         z0BJDVkQbQhgxjK8LuYBjaLMGYUCM6W3KogDkK9uTGogKRSUAQVYwkoqEs8Wuvpjk0jp
         UMAYPDTLX+tU+mJ23SvE+yK2SzX8+ZQixk9Z5NntBJM2KLNKKKYDSksxy2OJRXTvPIxo
         hAvFqQMhZOv/eMNsDpPT8498HJykwMegC1+mcA3vTryLapZ0mGQ7gGWhayg0r0i5Nykt
         4fBt/ICQf/FBf0PiKldv07aOV9Ubtl8x4xkOcX4I/y71lQm/3QDskE7auWesv26jDIkr
         unBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065926; x=1780670726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WkFzsgrdko5whgmD09ahCUh6vRbCMjGnoEBT+p07030=;
        b=DgeYUZkcEdJOYDnwDgF/jBzl/L3fFuxGBkM5ruabkHP09fK1UiPPLvbFlWZnmVkUiC
         Xl2/D302xTR8/MiN46qfTOjRtLVdeOMKtF8froT0YX9Du68mj9oYFfgESBJ4eJ7MK4PH
         gwDMtoPbi4xpHvCDJ5T2kgNh5pnIzt9sB5DR6lk4Tt0GDAyNAX/BM3DeNWsn7wWycDtl
         TJ11+p833hRAddH9mGRg6PxRAfJlq4E2CB3xDX+Vkr9zQDpgT+COS3rRKc5EI5uefOvM
         p9jlHxNuuT+sjpP7Narcij6Rn5wzM0cO/3xMsKrCHZ2kjVAkVD/5Xd4Q2e8AaeMdMyRM
         Z9bQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+wpxUvlJY1kdT6tqKB4WKSIPeSSGPIMH7zOI2ZBD8p0G9xHTM4YM3N/gOrIr9q62b/AQZNplRgjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNUNUWp6KRNMhiz0/ccsef1fVL+yke8fJuTtNuvKR90W8tHIPe
	FXJ5WWvNgiMZXeF917LopP2QcWMSFyaSyw6lZcdkggeOtoi94r+V16vn+6gpmhIywrDAhwDHJ0l
	qaHk+rehm004/cyFkcxV8ynsmOZYgTL5UGMHpE8Yvot5r7T5BwxZ/SO+WcvcmYbm4liAvY2Kusa
	HMKVrh5jsw+5A654ugGkt4nYMPji57nE21pSNPhg==
X-Gm-Gg: Acq92OFKpEhC71h6R87irJoyrplUmrgssPj/PF15MF40ZzamNYfoFFPhwIK5pKFLlb4
	muBCjIWK6/2DurGuE6/7VX9lGX9UKx2nkVXrxkCTePJv/gcKyaHUAmLQbSh7J2PCwHpDu5coHRs
	tRAW3q5LzSeBDyhzOE0B9CEwFL6B71vBOP4QMKzROTulfrdrzBDUasOyxvVLKnDNfhwXAIbVowD
	hswBFM/WnGm6CLd1g==
X-Received: by 2002:a05:6214:810b:b0:8cc:ee5b:1657 with SMTP id 6a1803df08f44-8ccee5b247amr13851256d6.30.1780065925832;
        Fri, 29 May 2026 07:45:25 -0700 (PDT)
X-Received: by 2002:a05:6214:810b:b0:8cc:ee5b:1657 with SMTP id
 6a1803df08f44-8ccee5b247amr13850246d6.30.1780065925170; Fri, 29 May 2026
 07:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513-eliza-bindings-sdhci-v1-1-b2cae44163c1@oss.qualcomm.com>
In-Reply-To: <20260513-eliza-bindings-sdhci-v1-1-b2cae44163c1@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:45:13 +0200
X-Gm-Features: AVHnY4JsfzpcGAm2kTPsIFuJQe21hwabVEsrUxqMjR2Z9szB1Z4ZhMo6vLeRu3o
Message-ID: <CAPx+jO_i===QbF0=X=wm0QbpkEcqdeSyNeG8J4YzvOeChk7YUA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: Add Eliza compatible
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: FLfhevDTIG8LQiM-M86Ulc3WRZkCwQWH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfXw4b2unb8gobE
 zB9YLmQMTasBhCt70pruunHaO2iB4Q9FdYQ9l2AF3wMJPNU8l0pDGz3zVBm/NYdQ+/UIvbsDyB8
 gax7gj0PdHDrAjKcVm9b3m3snTSzxGLX7oRN3WWWV8CpyNKytNxuvR5w8VPV0RIpRijL0Gh4a8a
 fWznmSicHiCGOLvKo2hLKyowREE9+4HWS8yxUotpj07bOhm1qrVYTUBlXL+HBwxmajVL5g/+cSW
 3yeX8f0WeXMo5pPqES+MxRj+Wf9n+bzzvEnOeiDkXC3i44iKb4DoGfpeMIDsRo8WgsP+6H3odDB
 bZ/zECt75EQgyrafknUytSK7PXeLDeLzpd07k/acK2talw7kkgl8IwDCyvE7/kqfa+s26x65jPm
 TLzFk1+kERVjuQRet0jjh10EEYrSu0QrWCJMREnwElpMchka6hTRMXSj2JvzOMpTMzNubf43D9/
 B9iC3frqaNhiXA1kdOA==
X-Authority-Analysis: v=2.4 cv=DIG/JSNb c=1 sm=1 tr=0 ts=6a19a686 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=wwCG8UitSJSBhSBbBDAA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: FLfhevDTIG8LQiM-M86Ulc3WRZkCwQWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290147

On Wed, May 13, 2026 at 1:19=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.c=
om> wrote:
>
> Document the compatible string for the SDHCI controller on the
> Eliza platform.
>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Docum=
entation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 695a95e8f35d..adaed5272016 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -37,6 +37,7 @@ properties:
>            - const: qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
>        - items:
>            - enum:
> +              - qcom,eliza-sdhci
>                - qcom,ipq5018-sdhci
>                - qcom,ipq5210-sdhci
>                - qcom,ipq5332-sdhci
>
> ---
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> change-id: 20260513-eliza-bindings-sdhci-d531219a5c87
>
> Best regards,
> --
> Abel Vesa <abel.vesa@oss.qualcomm.com>
