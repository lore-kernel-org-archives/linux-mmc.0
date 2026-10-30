Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357966;
	b=1O+RCHAv0HLRvHIhl61BUF0ZDZjzjlxyxSUHeR5/EGaPh8mmDKSFTiNsK32oMCz/0+3h
	 AWV8dNlgRqpT4LaUaHxGux0GBu6c5Ygf3xTnGu1ER55gUlox25RFuG0n2qgtjNxXRk+Pn
	 hNdD5xVHiNevSRqDGhTSocVNGs/EOh/i3uDN54YAc4dBLfKwbKYupfRumdedMe+cxgoCE
	 9GMqF6IapFM9sjdwbzWQ0O0PbGNTeqjBQlvIQglw4XU/y0qzQqcm/CgLCYj3eUDPknuhY
	 jHD9JQjj+HcBqARce5TQkc+PqvyIQCwxMKarh5elZsRhwREGXaz3V/gPr7K1+w0JQoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357966;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=DU0BmoKanDFLwT8UEH8ag18x/Sshh1zOZeafnoOkRQA=;
	b=MNjNFzWNSbiSmkKmG8UN9SoLllQh1O9Uo1WKkeeeVZGweA3+ty3SUaitOV4CDC9QHhC2
	 5T1NRY6Bjlb5qoXzRnPAC5ciXC1cnC5FRbPR+eCgUtgAHXU8EOExn5loNi8F+K2pKxQYA
	 NM2RFLxXQwOU0kPMSaJXii8iyRHRjOfFmnEifxJx9Ig10+3NsrteCvtFkK5YHBQMR2uOm
	 4O9BCClMx5i66uLWZhr1m8n8A3ZetALz6D3DDq2+E4/gp4a25CJNn3OZD4XE+rxWhPilw
	 j22JavKQ2l8NQ97ECdzFnIx3+EfvsG0jejjs7qu7outlImfLpTcwP9/MBcnZkLyCObg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NXGMf4Rk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YvTGgsZP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E1606A321
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 10:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 169E1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NXGMf4Rk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YvTGgsZP
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8F3mt1761962
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 10:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DU0BmoKanDFLwT8UEH8ag18x/Sshh1zOZeafnoOkRQA=; b=NXGMf4Rkgi+HUugH
	hZlJfzDe7dKqvdrJ9ndyLIUXPxXB+FBT2cMtVXbRPPSHhhNp/+dcLdaSsUMFNrsy
	UQTYRWiw9WKPSQrFixI3g4jSyq2LwIR57b6pu6JNMy+WcA9BDowddjSrFY7HC8Pl
	sEWH8tCZd2gzsE9wtQGZIuZbtMtt7vAowzhh9ngzEBG+wMUbBf+mMdxrsbm8jo52
	csGuBlMuZ3/V7amzAe6fUSTO92Vavg4M31qQCN6gd/1+xgnpWzS86EtQBnpsNP8z
	sooCTjkeJRAFCaJ0+rzl037EDbfAiWDDBJKRw+St3+gaIfja8hepZ7cledu8B2ip
	y0eWZg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6paj5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 10:59:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ea71803effso7468685ad.3
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 03:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793357964; cv=none;
        d=google.com; s=arc-20260327;
        b=MxAUWR9t+oriVFHvsuKOaMn8u16rYwRZ0pUDTXPYbaEI/KAECshaGBeKV9MExNWuor
         uWkm0nkItSPhikXP70sF4fhzC/5Vh0c7Dps0c2zITfQ7lUDClQQ7lY1LPgczdKRGJBTJ
         RlZV/ID+B1F7cIaKtFgPf4NKgwNcd37NTAQVGUbYBbS1CqDZnNFZDL+R6JcOBQyhpAWp
         QnUoo8kS2cch73jM1e2Wa+YFQFxWZ1FS9wdx3vCzwY3aGlOajTq1KydFHxvJq7YEaPxm
         6vCPG2XnYaMNQ98VdHqA8PKSN2jXYKhwPpC0D0KQHBdAbeGx9Xn0uf3C9zJSiG4PKY0c
         AokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DU0BmoKanDFLwT8UEH8ag18x/Sshh1zOZeafnoOkRQA=;
        fh=zAgoE3QbIy97q8Vxg99vT/mhYnijvxAJ2vvR7aseu6E=;
        b=ND2w5cGhkGsS1HDXU6ln1f5rNzcEcm5isGyIPKiNmocHiATaSv4dp5+amQINevAfqX
         IiygM007WDASFzUIj/3Qa6AWRUItEOyxsSVoYg2g+tqtGYSJQ57zoJiWffqXDIoBhZmA
         oV3CkWX+k8qAf1QH2V5r2ba9SOKn+KMbP/5WBNfbxrKUoEtl7bPmEBUYOJYIqDpV4OP/
         3y59XSFPLHfkYbXU+9nuqQ+HsmuJuRxXalNuUhJGYvcnqyeUwjEDko6nJV9hGUQBDo/j
         AXj910W9nf87Jr9bsJt5/KC1c9KuW+Iozi42UK8dBKGLB6TGe2V8nm5CMyMben9SwmsI
         Xj1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793357964; x=1793962764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DU0BmoKanDFLwT8UEH8ag18x/Sshh1zOZeafnoOkRQA=;
        b=YvTGgsZPKQ4gpzRsvb4UTxKgndAHftFtg301s/oPtpwtMlcOtsbW1XIDNzR1MV1+qZ
         /Ll3aPp2IwDyOMlx3PknXdxC4Q763HcajhouSlRVxuZ9ETHxHFyI3M4jGbsCeBu5Fq/h
         jdmXRthCYy7/US/pCZoNoYuCkASQIwshyX+hjgU3bLbOlNtCng9HojJYXkLb1Q6GGc0j
         Bv8Uul2OFRYdicvDG7TVY/6kkNgqzvmGCVinw7/K0xAUgGQO5vC8SpJNCpZJh8f+Bf7J
         xPaIpTDIjtc20Yn2XE8FjGZkc4yRVDRg47UznbLpgaxHyhymuaDGnaPQigwhT+38jnkx
         Q9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357964; x=1793962764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DU0BmoKanDFLwT8UEH8ag18x/Sshh1zOZeafnoOkRQA=;
        b=lruEZ+/2HIdLZYfW6tKI6Y/vBZ13lTFAdf8imZVwVDa0KWdj67ndGk0ZFaBVMEZJYX
         vvfpcrRgkX97FwXXxdwIfnn7jHzQ0TBPn3Pd5rxAs46Y527aEvIFEx/K5KNL+NRn7Ls8
         vxOaOp6EDGsHZKLMIwJ7nXH+x54dSxG4oMD8oJIKo+pec7tf5KcpcpJ6p42eZHOj4GL9
         wVRabyVEo+BHC3cpSTCcjgLLS+Z4qOcqtabCmjjYt51yviOXPvjaQk3fUx052N6ZA/X/
         d7lyDFQpiplN63H1EWlJHdN4OYaMduFYaqUedxQlEYGdSrhsZ4rQnu1BWlGxreRtsc3i
         ab/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxjxL5n33xTRgmxP/84RDUUXRkQio2d49SJRfwTrr5YoMZvXWmDokhRKSj+HnLAO70XJJXeMC4QHR0=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0gI59rEehT7lBJmoyDMqN3kAKFjaDaOqy6qTD480jfp1oltR9
	MsQsm9+h0hNSFFl7fPnInwcCuLWM/ENekq9DInKkrUnK2hJ6G4ikzGN2yrKKiYLVn8bg++glkDZ
	CFsFU2PPyr9uX5QjtdSG7/uHYCv1kLl3Hlbc/UtQJEPMErVWcKp5w1H+Ml2ZkZA3HRxVymsOZAl
	6caWIylf8HqzMewN+vjal08INANbT4uSw4URD1Gw==
X-Gm-Gg: AYBFou3c76SFymZHEfF6AtF1BAt6sgon+i7HZqH2be6DxH/a4uZ7x91lA72gQ4wiVi5
	dePelTvuoGfMbDHtoZl3xRQnPF575m566KjAfOWb2HTehAsTpXk30wpGO8s4kVKoEjC7odLoJPM
	xtWiXqnikVVXu9gdMRPeqekresbCiTkc4eGOnzt8IXU9+wiciz1dQbBO1S9g==
X-Received: by 2002:a17:902:ce05:b0:2dd:ad73:5b6f with SMTP id d9443c01a7336-2eb364b55camr20159685ad.31.1793357963442;
        Fri, 30 Oct 2026 03:59:23 -0700 (PDT)
X-Received: by 2002:a17:902:ce05:b0:2dd:ad73:5b6f with SMTP id
 d9443c01a7336-2eb364b55camr20159505ad.31.1793357963024; Fri, 30 Oct 2026
 03:59:23 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009003201.68288-1-kmehltretter@gmail.com>
In-Reply-To: <20261009003201.68288-1-kmehltretter@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:59:10 +0100
X-Gm-Features: AclHuK-BIpE4fV2IeH76KyHZZ83cOZXmUKrwETbmZLgjmf4hb_uw76VEZ66rz3I
Message-ID: <CAPx+jO8xc_OiSJ2b6BV=yPZV2DU8Bq4AyA7HkUYMkB6=8w85xg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: don't log an error for missing BOOT registers
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX5+sJh8u+1Vr4
 WpDUB2Ku+ubLLIdZA06FzUKWA1vQizkDQ8+BgcDLnSMKdCjmpr2kGd6BlX2v/FBVKqG51+J0x4G
 WNpFzyw2wUg3JziokiZiRfFsqhMo6TUA38NaEXP75/PIO6RbOMLMVNdSXhJvxmVSzQAh7kzCv/g
 v5b+9oRrbErdwNIMWK73wEDCmmErMYCRaUGZzptfsWOiT/NNPoCPK7LEi2p8+houeCIhXCoKHD7
 cwrM8/Rd8xTH8QiQuN+Q9hzwNgjxy0MwEXT6lwzytOcXbGIOM5y9KTfMkrMP6pbMOtMzxCPoDPU
 ypbRsdGQqiese4vGCDkZby+bkzdbIKESeI3LW1nc2GQieHSP+IWAdyBfG+Ag2XhDI9OnHb5ej2I
 iefCEjLrpWQDu7d+0+cg3vNkoWZNkCHyiw8LyT0qO8NcBiIGA3qxhD9S0ri/oOnfpq4rh18zdT2
 TsEmTQ66/TJHgKmO7nw==
X-Proofpoint-GUID: TGqNrP9rlD64KSj_vAri66q5mMTXVU0u
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae4788c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8 a=AFOK113v-V9XLpTQ-4oA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: TGqNrP9rlD64KSj_vAri66q5mMTXVU0u
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX3z+LKNSAPzSd
 NW+rgsV7S6UPDW10+ApRH12hiJsWL1JuqiaKqIGaz70tDOD0As+uhPvFZPbSGSxSLo/HYU6e0gn
 jXq8IniGFfN/ZxjjHbj3NeHHc7fdeTE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300043

On Fri, Oct 9, 2026 at 2:32=E2=80=AFAM Karl Mehltretter <kmehltretter@gmail=
.com> wrote:
>
> The BOOT register range is optional: the probe function ignores a
> failure to map it and the suspend/resume code checks for NULL. It is
> mapped with devm_platform_get_and_ioremap_resource(), though, which
> calls dev_err_probe() when the resource does not exist. Every
> non-removable host without a third reg entry therefore logs an error
> at probe time and then works normally.
>
> The binding only describes the "host" and "cfg" ranges, so this is the
> case for the in-tree users. On the Raspberry Pi 5 family (BCM2712),
> where the SDIO host of the Wi-Fi module is non-removable, each boot
> prints:
>
>   sdhci-brcmstb 1001100000.mmc: error -EINVAL: invalid resource (null)
>
> Look the resource up with platform_get_resource() first and map it only
> when it is present. Hosts that do have the range are mapped by the same
> two calls as before.
>
> Fixes: b7e614802e3f ("mmc: sdhci-brcmstb: save and restore registers duri=
ng PM")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Tested on a Raspberry Pi 500+ with v7.3-rc4: the message is gone, the
> SDIO card is detected as before and Wi-Fi works. Suspend/resume, the
> only user of these registers, was not tested.
>
>  drivers/mmc/host/sdhci-brcmstb.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-br=
cmstb.c
> index 1de2f05..7c17a3c 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -491,6 +491,7 @@ static int sdhci_brcmstb_probe(struct platform_device=
 *pdev)
>         struct sdhci_brcmstb_priv *priv;
>         u32 actual_clock_mhz;
>         struct sdhci_host *host;
> +       struct resource *boot_res;
>         struct clk *clk;
>         struct clk *base_clk =3D NULL;
>         int res;
> @@ -534,9 +535,13 @@ static int sdhci_brcmstb_probe(struct platform_devic=
e *pdev)
>
>         /* map non-standard BOOT registers if present */
>         if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
> -               priv->boot_regs =3D devm_platform_get_and_ioremap_resourc=
e(pdev, 2, NULL);
> -               if (IS_ERR(priv->boot_regs))
> -                       priv->boot_regs =3D NULL;
> +               boot_res =3D platform_get_resource(pdev, IORESOURCE_MEM, =
2);
> +               if (boot_res) {
> +                       priv->boot_regs =3D devm_ioremap_resource(&pdev->=
dev,
> +                                                               boot_res)=
;
> +                       if (IS_ERR(priv->boot_regs))
> +                               priv->boot_regs =3D NULL;
> +               }
>         }
>
>         /*
>
> base-commit: 6c377d19d4a5116d9bec5203aa3c6c11523e7898
