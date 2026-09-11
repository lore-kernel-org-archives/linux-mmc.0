Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7A391E4B
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140523; cv=pass; b=oyH/prFTVA22gernbBgKOAKs1N0GMW5fC/XPVbQc9Pyr3F8sxWEYP7LOFCREXaIAtdPmGkW4KTOrlM+lbWQuLhMp7N/BdHOtiDTGsjlACvSOtI3Eey+lVsvuzYtwJJXU0dSRA9lkt/7PyV/Xu1kZR2USn3hX218m0Kw6dRScKkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140523; c=relaxed/simple;
	bh=xlbxi6WaFUPCA7LeNxrUbKoPhMo6iJn4O8sl6FchrG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2L1/IV3Dj93fA3P6wTRWNFKCSwSXHU9fylM9X/f+5Kc1puEqxmluJqM1/N/HUCKFkqrc5F6GSp1GaRXMKwBmb63F87hdA/PbaTphvshxraGWjABFNF3QFCR8wIgSJgUzMbRV+6VCWvgci+0jIGbgvIG5SeQYOInlYhjm4ppUew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=io7lFtD1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jMCikJCV; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="io7lFtD1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jMCikJCV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEmPlZ799180
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U4WxxPS929fZkSPOOc+ipfTxEdcesMIlDw9PLdLIXDk=; b=io7lFtD1LOzpjHPd
	5AunBCnaeKtoIE1L6TO99/8TSwnDIaWkr0F518juyvN5l5rwxg6tmK3ygU3hIp/K
	r4RH4PSMv6ImJS+Rwtd2PQNzdazMYbd8PQsDTje5594u1vBJbJaRx0p0Eq7ViRHp
	JDNcyC0Ca5GhFuCqgr4yhURYVeBBJJETxlRbE5aIbaEP5Tb815rHae0597I3SawW
	iMS5X3kwV4abdAzZ7K7GaGazOioJvdqCyNKVhbbwXmjVQ+sXI5/oYQwfoTce3tMs
	m0qOQCCI5imj49wD5rehjSdeySu7YLr4JX20QIqOt7KUjUuf25sGgP2ilCc8NXFi
	zI0ehg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm2q148au-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:28:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d63bad3d09so16879015ad.3
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 08:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789140519; cv=none;
        d=google.com; s=arc-20260327;
        b=h5ihR8ceTBSS6D2YANaUTwKICJk/OXplM59j0qtG6TSoLc0YNL+TOJ6xXyuyFRpI0t
         8gs1JTIQT4qOiP/JmGJKgiD3YvhZz2ROxproVXAE0NKKkTeOOG4fZoUuOzHj3Ewr0KZd
         D1mr7FmWGSPZKGvMG3HkxahbLiKTsLOFletOdPAfy3O+A+9MIt2kRe+wy0GE9t5bw/QY
         haWDQSVNQseZiA0b2gx2ykPOIBWoy0blJnEoL7D2WBZe1bALofu392TDxgkhKU925wUi
         qMHBgTR3qNlOc1ia7066ngTGy1dc1R+8KQasVkAj23ejyHlKuJUhZ1AbiRtYqs92Kw7W
         IIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U4WxxPS929fZkSPOOc+ipfTxEdcesMIlDw9PLdLIXDk=;
        fh=ijd6xDtrQ48yb4gtlTL6fKahz3S8Bev9R0pr/sINHro=;
        b=W8twnj8llYICPlbPsD95tA4XX29xcXMdwRUdT6sZ7GI1CIfYoMuTpfbplwFQwgLIDB
         GL93MxT3uYTq3oer2rXbipzB0tOl7sau7d0tL+3BjTABIyz2Jk1SoArOBzGFr3Yf3oJF
         bTNFfthKupeOxEsNSSD/sS0fnlxJE3NHLQWYFzfI3ZupuOs1Jbir7zO8+l2OnMFarY0Y
         r5k2r2Bxm7i/8fznJM8/T2aHjgyYx6AoFBpXb3DhoER8Fx3vbTsUD+5zwGulBZBTJ0Wd
         OTla1mKN0keHqc8AxI3OemWXOYJrhDV+C101XQv7hw1ZXl4GHEEYjNv7biT9/I12wnzX
         7JfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789140519; x=1789745319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U4WxxPS929fZkSPOOc+ipfTxEdcesMIlDw9PLdLIXDk=;
        b=jMCikJCVd16Ia4hTyn6mfFS4L51gJfgwovtkYbnW113OFY5QNZl2zveLVygEPbfn8V
         1BaUfFfpG3fHwJ4cW+uFZVzR/z1eEp3j9fWHCI7W9jE0XJKKR2XRqCBldnsh7RrFwehb
         ANijN8xsUxZ86A6aBtWLbZ9sNM3q/VyZa2jdXHk/BeuD1lhRlKmMRXtsNoxmaPtMz03l
         cWzB+kOoAqweDM1e019eV1TxCvdyS86LDTKZOZnZKSsk1a4HHwB64BDPEi0kMGVsK3L/
         sLDeDxLMguvhsOQQldQqwUfpcZ3SohK/KkQcChT7D8txbHSz/rakp1/DcOhMfxBrvOjz
         g86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789140519; x=1789745319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4WxxPS929fZkSPOOc+ipfTxEdcesMIlDw9PLdLIXDk=;
        b=Szc/QX/htl4iFBaFGXHgGYgrGdoeNRgzfC1684NKDwFAg8WbUxBG0jUGpT1BB5lTHC
         uZDcMHTx4X3gHiRX2Mq0mDkLR9dMWr9ocPoQTPpeUApOnnfOjN+4L8MTyfbLXPfTW23p
         YzELapcpF1arZ+oBSD+ejwhW+q6ryQHNmpgYkhMvKxTGmmyn7fhiqzUQFCubP1/AqjOw
         0cpg2Pq34CZnQCREwgVp6s3mtsj7GM8ko0jX2vH2psdu1AOb5JS8o+C486VDoxHHHBdM
         4H13YhBD3gDdhFxSceb8GUAIwP+lVp9f85mph8kGWkt5yHd2ayp9DNX9AO41RiNZe/1X
         aSdg==
X-Forwarded-Encrypted: i=1; AKwUvBypGLRPhffD2aUtw6gRmddv+LS0gM8aHkfefPSwTPKGStHaoW2xyyzbFHAvofQGlD9eRCPmsnbO7sE=@vger.kernel.org
X-Gm-Message-State: AFuF++k7yOyRb0JM+CaGeOKVWlrHqUXOnxiRq4Rz7vnnmBFD6V3Iw6RV
	GtFoSe+APaAFlRQS3N2Q5xuPTv4olWoefFyv0/UOgyoVkorJYTMfXsk7tZsJF1izT1PgymOaPAf
	OSyxQ1jw7pdR5NGh7pCFpljOhaMlJsZym+LyrpddBPql0Tux0CqBoCJJeaWxEdKWVNIxhZ10jO0
	Pek9X/6Ak0RJUKABJDTleeYqyJIjQUEZ9pI1AZ8g==
X-Gm-Gg: AYBFou2TU893ir/VkSUcUAqLV15mBycrYTyPB+zlA/5a5A4FLjA2SAWvwf3Ih5ZTvcL
	u8ITPbb7zBgjURnTmOpB4ioW6JHMrMLeQAbX9oLcPdMmRuvDPw1sYElLy6Z7gF5PK5H3GxZdGWA
	8Igs+TwIum8Je1157gv7zE27vxOtWjpwXM7+nYdNS1+GPn8X1m5T00J7iEtQ==
X-Received: by 2002:a17:903:32ca:b0:2d6:f6ba:263d with SMTP id d9443c01a7336-2dd300d2dcamr65524955ad.7.1789140518968;
        Fri, 11 Sep 2026 08:28:38 -0700 (PDT)
X-Received: by 2002:a17:903:32ca:b0:2d6:f6ba:263d with SMTP id
 d9443c01a7336-2dd300d2dcamr65524445ad.7.1789140518527; Fri, 11 Sep 2026
 08:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908093758.596444-1-chunfan.chen@gmail.com> <20260908093758.596444-3-chunfan.chen@gmail.com>
In-Reply-To: <20260908093758.596444-3-chunfan.chen@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:28:27 +0200
X-Gm-Features: AcwNN1XzUWwnh5CLEKhfNtk3zKUpeQCQbWgTHeTb22dt2m8PJF6whzjBiBiGR9U
Message-ID: <CAPx+jO9xR6ep07H-b2ztqpQV3_nSwjXAxESYW87ZR6tg424z3A@mail.gmail.com>
Subject: Re: [PATCH wireless-next 2/4] mmc: core: add NXP IW610 base ID and
 block size quirk
To: Jeff Chen <chunfan.chen@gmail.com>
Cc: linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        francesco@dolcini.it, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>, Jeff Chen <jeff.chen_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=d6lgWhjE c=1 sm=1 tr=0 ts=6aa41e27 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8
 a=eHH5Ge4S8a-hsxGmG_wA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxNiBTYWx0ZWRfX9GoJSLd0Dz+z
 hp6DLEruQlHtFKIWeSfJ0QSbY+lvoZfVxlNt0QSOFlFyRyU9qKheklrNWXROCBADHO6DsXlhomy
 ZEx3eQ+Cv73MQDP5GeR3PsCDh7H2qM93PDZ1CqOw8WOV06HQSUZpp6wfb2Un7t6JqqgNKCYVCpQ
 7bPKOT/MWq5WjuiSIGJOuzEn8oRvVSK0IjIUVNkbuu7IGpJ6zvTLpFK98qLEyJQpwjgJtuhk57I
 jqW35oz9oU9dh2T5+KXufVpSRRvrk+lNsNSxaq7L80BiDJdPgXjHcNUa5Qa+XueyAGRbgvP04V2
 UajjV1n6ZjcM7OeUe2nzQPYkUkCr4gRhWP+dXbTrzvGvNcmh0HGgeta/nXOna2wC+fLjD7PVtbg
 rcRSFverqKuYVVsx0UFTEnF9xX7ffqA/1vh+ScnI5JoaY68GHCnr0HEjIRe2WGGLMhPQDqIn0hP
 R+tWmu4eVi8eW+gnX6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxNiBTYWx0ZWRfX2p3e2cC17tkH
 /eXSSSU8bbRFGxFJ5jcsP93R9iN3KpsepLmUULZhT0blz1g6bKZ4J2tDuxduTLAhtXx2R3keOMD
 g+EbxAsuV2fNHX8XJ+pUhENeA2nNfOg=
X-Proofpoint-GUID: T9bSpN8kkJ2Vov4VZtXno5kb0Jl9scBx
X-Proofpoint-ORIG-GUID: T9bSpN8kkJ2Vov4VZtXno5kb0Jl9scBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110216

On Tue, Sep 8, 2026 at 11:39=E2=80=AFAM Jeff Chen <chunfan.chen@gmail.com> =
wrote:
>
> From: Jeff Chen <jeff.chen_1@nxp.com>
>
> The NXP IW610 SDIO chipset identifies itself with a base card ID
> (0x0214) during the initial MMC bus scan, whereas the WLAN function
> reports a different ID (0x0215).
>
> Like the IW61x, the IW610 requires MMC_QUIRK_BLKSZ_FOR_BYTE_MODE for
> correct byte-mode block size handling. Since SDIO fixups are applied
> before function devices are enumerated, the quirk must be associated
> with the base card ID rather than the WLAN function ID.
>
> Add the SDIO_DEVICE_ID_NXP_IW610_BASE definition and apply the required
> fixup in the SDIO quirk table.
>
> Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  drivers/mmc/core/quirks.h    | 3 +++
>  include/linux/mmc/sdio_ids.h | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index ae3ece89d0aa..98cb680e3ace 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -211,6 +211,9 @@ static const struct mmc_fixup __maybe_unused sdio_fix=
up_methods[] =3D {
>         SDIO_FIXUP(SDIO_VENDOR_ID_NXP, SDIO_DEVICE_ID_NXP_IW61X_BASE,
>                    add_quirk, MMC_QUIRK_BLKSZ_FOR_BYTE_MODE),
>
> +       SDIO_FIXUP(SDIO_VENDOR_ID_NXP, SDIO_DEVICE_ID_NXP_IW610_BASE,
> +                  add_quirk, MMC_QUIRK_BLKSZ_FOR_BYTE_MODE),
> +
>         END_FIXUP
>  };
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 5eff5e348eb0..dfffda3d8002 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -123,6 +123,7 @@
>  #define SDIO_VENDOR_ID_NXP                     0x0471
>  #define SDIO_DEVICE_ID_NXP_IW61X_BASE          0x0204
>  #define SDIO_DEVICE_ID_NXP_IW61X               0x0205
> +#define SDIO_DEVICE_ID_NXP_IW610_BASE          0x0214
>  #define SDIO_DEVICE_ID_NXP_IW610               0x0215
>
>  #define SDIO_VENDOR_ID_REALTEK                 0x024c
> --
> 2.34.1
>
