Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0963A6B6C
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352788; cv=pass; b=V84EqqwE1OyjNiIboTYKmNV35OdxPH/tjqiP4OzjV6WwZLhlvcKLERFW4olX8v0B7rn+rIE1//d/T5ez0/w/EN3mFP024h9mvKy5tDYILJA+jT6t8E4oKwqUsnlHeE8bGinYk61CU6qrO65JAACxoiUWWsekyoOG2kdxtQwH/WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352788; c=relaxed/simple;
	bh=OT2YYPmOxBkeG7rVLnyasNud540sHV3t6NYJlF1sANQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a597Y4h7fDVgUkgny0VX2kx4bdKGdGfPM4rMluKk45BqI7WxerPTk3Nlz3YNAXxiKqKlH1hscHwnyn5vBYZqxnNx/1XYjGCkIN9GsqEvrNG15+v8+agrzoJA7kTt280pDB9F91uac3vd/RkyIaSfadiDayR0RwUIwoO3SM9rHXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EA+eobU8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M7/bmX85; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EA+eobU8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M7/bmX85"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFDLm762357
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8wdnNYYzJsTlXbIJgehVx+piQn5IlDC57IpKnYZoOkQ=; b=EA+eobU8DAVQckem
	tsdOXvnkfKuDb/n64R/jdADpMBVR6icm18vIq/DtGl1CGXgI79kJcRls60KInFDu
	+q5odCRb3WRIJYJc7z7BR8wlN11m2kDkqeJz36CAmdWf60jA/CahIePOLrSM5IAo
	KGwOUW4dSD2MetEStHWlu+wQWHqN1XRWsGOtHTupltnaGg6Eq5Kyw4dwJal00U4t
	f5GtJqd1iyP+6TAYaNJsiOy1TwCbuT1/V6dnPBKh/aAWaSekcAa0e//PiHmR49Wi
	2EDxAecUe2jjJg6Yjy18xjYF2xvau6IserK6vU+Is59F5DqsdRj9cLWJQ23tGAbY
	kQ7YGw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxt8pj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:46:26 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f0f45415cfso39804806d6.2
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352785; cv=none;
        d=google.com; s=arc-20260327;
        b=Bg97ZimR+MU6Rckk4ZOoVi7J3eWKP02BkYtcA6hGbBWo9iXrGeRHRBnuViHArkEa25
         +ahs5CIVaLwPRjvnmvt9X1n/dE2jIU/iAMBKvLpyPsjqoUUekMbDVrr4NuT353Ju7bQ0
         0YwxXJS9OviPeolppiL2pJUJ0ShTGt8yUTrVCCf1Y6T7Wghz4uXjDTGVkT53v3LuVzZp
         lH8el6ns5NbXWI9rXmMvkoOrhBZPUxZnersvzLJdLOEOaJVTSoJbJ0hkQIIQvUmPu1u6
         GTbRwQtefgsgart2nxCOHK79NFUhRu54aP81YNx8yiwp0r14Mo3BxxYJ5RpfRRGK5ue4
         A2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8wdnNYYzJsTlXbIJgehVx+piQn5IlDC57IpKnYZoOkQ=;
        fh=HSewfOrnNGD4q06cvPqOPiRYrLOo/mZ8b9RC0bOSw8A=;
        b=JjBr0rXMnSPQpvOB2iwP4McU1K8ypoiU8Ns4ZRbpZTXz2kfjTd6Mu4llrSHQc9253U
         VummKZu8jeOX5fJAAr0EwRmwczr7mcAz/tcA7RO8C57gJhQEL35nS+C6Ma+kkxlWfSIa
         zjfGijq+XXHCMt6dTzOrQVgZbsumzb3Qx85M+Osqim3Eis9es7xBMG2Dy1y/QRvLV6Tt
         CDWv3Z02o/f2TC2nJFpxQ7izZTtIZhwnHwpkhSk9StrXCQS+FEgGLr6WUPlWN3h8nfAR
         cLnZjTJ0X0nzUwyx/z9qvAruVaviw+0biXrV31I5Fs2hEQNytE21H95vVYoeJnmNxjRR
         16ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352785; x=1783957585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8wdnNYYzJsTlXbIJgehVx+piQn5IlDC57IpKnYZoOkQ=;
        b=M7/bmX85gu9PLeUTtHqR+IALQEI7ul9aX6a6FrDUJcUFlvYxbZ5flhpJvLP8KVtlM3
         9PDt6W9Btezw1QQ9TmQJ3loeboPzaN0ZnHkMbaX1b4qPbyn6LLijyMCi8efFaDrud3XB
         KTLqND+W8VS8FUXZi2RVEWoHK5156YUXE2c1K85wb6k497bEII/SmJKH/kYg6LfXXLMR
         vxaJvypl6VfQ97zLs30U6/MAxeVPl/uQzj0eVswaGRHQn5bFgGO1gdo7r3Jn532iPNPU
         gHlaEHGZEMACVbbho+ykPhTRAhmtmFIIiK6VJNmQrKoR87fEsE+piMOeaWLVGLbM0koK
         fNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352785; x=1783957585;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8wdnNYYzJsTlXbIJgehVx+piQn5IlDC57IpKnYZoOkQ=;
        b=lNz/9M4wVdI76Y1mmiP7+cb61IyFPVjDXPSmQeaCPrEu73BcuBpvYb5W3vyKsHZzQY
         ZpmxpHwT6qwx1aR0c9jbmqsfuRHCsDs6uNn0Qoq3yWIK9tlY3IiXt35ESG2hr+JQrRk3
         4nSmb5+Q37uELZFpdi+W/UhuxCiS7tfx5rm2Fu9ubFRYLvbOGjTRWRDyNPs6WAMCSUrF
         +kn3IMQ5C+0x2o+8VTQa8hGHgkJITSrI1hZjYzLuAXlULgopZaBpTLkIf3H8V6nqcUAb
         P9RRfC4utlx+1PI6D7KYQYs9OPYmCCHwFR2tAHnmEaiBegpCp4DqHJypSlL3JDodGIzO
         5Y8g==
X-Forwarded-Encrypted: i=1; AHgh+RoQZdGMesKRW8IjIsSgKkaXGhg9ymK8mnAWrecQyq0S4zwDwqg81JFqFBXpi0H9vmTancDAy2oo5+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRTNgvtb8GI1M/0UKuoQp8Enz383/nR5WeTwjvSY4wl/hQw77z
	YWpXa6bh9ZQX2qr04OEI8qJd2VdfI0Gx2Dbmw1XvofpuzbEm5FJ9r+G5HVBSAgcKobkn2k/SFDh
	d+OOaN3TvezpZlgrPBoi4E2+KslIY2kj0RCryhnN6hGxZbfP+zWnABVXJWhqIJz6Dex0GWnvnBJ
	kfbfmO28Y6/wnlJwKlRaFq/XseywhVT6DtFa+RO2wDU9pPpw==
X-Gm-Gg: AfdE7ckLkYINyas3qhF4hwg6KwnY6zD518IXxdPL0vqzEKTNcCxCcZD+pvzOTqLmoHp
	XXE+dxYWL2y3HS1aLYyfrbaHoA6mUKPUTJ29mnsew3a4UM7bcJJuj/GgAA1D1XsbfcHjxsuAspg
	o3RiTOkLCc/mh1pkColao2kLc/L/f2ByhIsCTIUhWpzl56pR6SIc8PfRHmXqFK3GWn7rnJ
X-Received: by 2002:a05:6214:2624:b0:8f2:d87e:24be with SMTP id 6a1803df08f44-8fcb480e7a6mr13017026d6.41.1783352785334;
        Mon, 06 Jul 2026 08:46:25 -0700 (PDT)
X-Received: by 2002:a05:6214:2624:b0:8f2:d87e:24be with SMTP id
 6a1803df08f44-8fcb480e7a6mr13016546d6.41.1783352784832; Mon, 06 Jul 2026
 08:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260602094117epcas1p398765b6fb4a8ee28836cfde89744430f@epcas1p3.samsung.com>
 <20260602094058.358267-1-cw9316.lee@samsung.com>
In-Reply-To: <20260602094058.358267-1-cw9316.lee@samsung.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:46:13 +0200
X-Gm-Features: AVVi8CctPkCZsCIm6dIVSREtzJmB2Wnp2gXAbnYqarQV4rNhOMZfeaFxnbRce-Q
Message-ID: <CAPx+jO_O3+MLvQqNqgsbZc1A4PLy16kpPPuoFMydbU4KfT_J0A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: sd: Remove unused buffer allocation in sd_enable_cache()
To: Chanwoo Lee <cw9316.lee@samsung.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        Avri Altman <avri.altman@sandisk.com>,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Linus Walleij <linusw@kernel.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 4edL3KtF2BFTeCBIizzcSZQwCychnhB5
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4bcdd2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=hD80L64hAAAA:8 a=KYybo1-aWJxubhzqE4cA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX8n9tYsiAS5Lg
 GJRFODay/e5FTF4X4iiEZIhmM8VFJlWy1K7PEY6n7wYSzHU0Pzjd+sMtEdrZpaaIumSoyAG2uIo
 GX6ZJk+1TY4xlJDs0mF2c31Ar8HKYGo=
X-Proofpoint-GUID: 4edL3KtF2BFTeCBIizzcSZQwCychnhB5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfXwTleMz2hwtI7
 QkcE5j/9ok9JCktYTn1OMzqZo/v0ItoVtp97rH6P/lHmk4l+0EkCWhqTnDS551cb0CDsFRV25cA
 fzAq7L2mmfGMV/9fye9L/AB2d+dhkBka2IXvYY6riV21w8Smhq7edkaO/noIWP6+EHp0lS8T7x2
 47Q3Bdri9vQgxnc8KTL+BX0KNDjaw9iR8Q6yaqhtc3DwWmWeAKMdrnriGyXQlnYHoX6WAmjBxq9
 BPTdCxQTU6WXtxSTkeHhuNbYrifIOtT0syf93L7pLrDANa8tFrvmiyKxEz6rHoCmuPhrIwsXXk5
 PrPHx76qyzEzAsRxMx/xsupYQi8jGBe3tbDoCb3f32F3eDueOT5mcULTbuPq7zRkJ69/D6nN8rL
 RPaVbQPbbyOHA3gOABg5mxlmY7F1HPyBLLTeZNElCoBJ9rWip8QkYJY86O7Ii7l1SIDjex7a3yn
 5hq2Pdsz6WxjdAS6sTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060160

On Tue, Jun 2, 2026 at 11:41=E2=80=AFAM Chanwoo Lee <cw9316.lee@samsung.com=
> wrote:
>
> sd_enable_cache() allocates a 512-byte buffer that is never used.
> sd_write_ext_reg() allocates its own internal buffer, and no read-back
> verification is done in this function. Remove the unnecessary allocation.
>
> Fixes: 130206a615a9 ("mmc: core: Add support for cache ctrl for SD cards"=
)
> Signed-off-by: Chanwoo Lee <cw9316.lee@samsung.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sd.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 948948ca9b4a..c763efb10f64 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1379,15 +1379,10 @@ static int sd_flush_cache(struct mmc_host *host)
>
>  static int sd_enable_cache(struct mmc_card *card)
>  {
> -       u8 *reg_buf;
>         int err;
>
>         card->ext_perf.feature_enabled &=3D ~SD_EXT_PERF_CACHE;
>
> -       reg_buf =3D kzalloc(512, GFP_KERNEL);
> -       if (!reg_buf)
> -               return -ENOMEM;
> -
>         /*
>          * Set Cache Enable at bit 0 in the performance enhancement regis=
ter at
>          * 260 bytes offset.
> @@ -1397,7 +1392,7 @@ static int sd_enable_cache(struct mmc_card *card)
>         if (err) {
>                 pr_warn("%s: error %d writing Cache Enable bit\n",
>                         mmc_hostname(card->host), err);
> -               goto out;
> +               return err;
>         }
>
>         err =3D mmc_poll_for_busy(card, SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, =
false,
> @@ -1405,8 +1400,6 @@ static int sd_enable_cache(struct mmc_card *card)
>         if (!err)
>                 card->ext_perf.feature_enabled |=3D SD_EXT_PERF_CACHE;
>
> -out:
> -       kfree(reg_buf);
>         return err;
>  }
>
> --
> 2.43.0
>
