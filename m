Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286739E180
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333832; cv=pass; b=E7pD54K/T87vHGfRfX9UvtsFC48zInqsq/z07o3CEPQI0LeXsFa6MgHT0r5Jhfc9pozigjIAA34ii8437Ymnzd4JAbWPq9hFNaEoFN4lFrBi88v6w1FHq9Wgo4dXCkUKUy82wjLog7S39JqtEE44Rx0XT41fxHnEtIv4MIgtHs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333832; c=relaxed/simple;
	bh=6Ayca8qLGPKxUsIFjQxpWalPBGZaUIXDglEzs9D7DBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z76MaM3eHZszoRaylHmA43Le8dJn9qw4rv9luAc/XrNftqHH4BHPHObbFJGXap8jk2iz7Tet0T+YscE7HnNeuFjftKSuf6OYNf5TkWAU8kix62hVXObOB1+acbQb43Za3pTSMdC1B2AfBYZvDFur8JViz7lP8G5lI2Q4WL2J+kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EX4qlknn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BpsGMuZC; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EX4qlknn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BpsGMuZC"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666940YP4151656
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 10:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M3UbmA7EX72PxXWjZzRHV5fuh/MSA7OywU2pO5D8f/g=; b=EX4qlknn+baYDBNq
	mqFMYeYf0Sl3nQuUHxNsxaxCJkg5UfYzdlRYDERlLr8WBuvl/KuUx6Qf24ztD3tU
	vHxEpXNxkeiM73z2JX4Fh9GJEQe0ZplXO7XmuVI1zbmMaQHExO96I7jK8yH+th9f
	xq/9mG8Y7IisvKHuUuC3/Jqr7Z+Jq18eBVO7ZhkkL/Z5GeXYYAad4uRfwXivMBea
	bdFRXFto5FIAHSgCUiKDPbt3SX/uFbRGIyV1s4u0x2N/KQ2o/+UrwkTJ1Jy7UXwt
	lPhp+SLDROr6F10RheypMP8DNZ4SHc9woUXgvb29U7Ocug/Qlc+oTobc4Cf29Wvp
	/aJUoA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs8m0b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 10:30:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1eb52e1fso56924071cf.0
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 03:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783333829; cv=none;
        d=google.com; s=arc-20260327;
        b=MMjqVFbkjqpkV2Au0lrJrB+IyW9wsHaK47TC2Bjom3jGko0y0y9WezTB1GQ9TKR4zU
         HZDKbzO8QcNnbsz8+4/QoAW6rJ/PzxiS7+YkpzGsPzhgOPoARXetsUx8bPDeRg/MeT5y
         bcFH0GrkZ5R+rW/M26i29m8w5bOL7WpF4yqydm0mwWwOLv8rKgIkeum5ckR6W4eZTLBT
         q6P0jc/PVLOa+LEU9xS5Bec2AvCf17pr1FXokAX3JqvSaAPef9v51HLeBvM98963LdLB
         p2cmCkyTUCWuNQZ1nNJafAMimAypSBFyGsHpchuxKqLU3JiEJW3K6W9O2poH2IUxK/ar
         y9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M3UbmA7EX72PxXWjZzRHV5fuh/MSA7OywU2pO5D8f/g=;
        fh=uMed5Hv8t6QKUwVRNJyozqmAD5nVjZeAQAjSu87QM2g=;
        b=lRgNATm3sPRMHjW/rlZwnjERbkZc7iyiBQjPaHMvR6DzyXT43JDtUa1icb3ELBsz8P
         njN7jrbc24axrP5nx60dBNRJrRBMI3+siaac4pFfCA4LebTrk6poC7G+Wk35U2imOKT/
         ePwbYEPWxiJo2cWGzwi6CTsD3ExOIAAzomDHxbussDMeU3xU99lMass9qSndvbWfmxsw
         oFqQVpYK/wpY7SvZoyBoZqDG0PVNKtDAfDCTmV93EHRzoxC6y1gCIjRkwkuiWHLKxEyy
         sEce/gmr2cQsrzm6dJByUrCIr3v824l5+EZAcbJjBWo6o3gN2D3US9Sb3ZjB/sh4K8H3
         U0ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783333829; x=1783938629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3UbmA7EX72PxXWjZzRHV5fuh/MSA7OywU2pO5D8f/g=;
        b=BpsGMuZCbxUcrogq5ioEsKuaxg6hmGzUGlAtkxOYHpuAtpqx1+kWG6VGbq0RW3Hw8N
         xL5UcwQ2swnWcRsHRjfwesVv0PKTSGVqT5+l5GIOxkQcJkIQRFm2C4v0KK7VQqYnKzwM
         CIgPGBXX8CNzuSPIPCEfF2IylPAarcoCach1zE4lTkRUd328kdEEAwOSsXXNgY85F4PA
         fh8AbVSknlf3Ox5ij7YQOuOEfKUCF+pGgk1IQdXd0IRrLizTv37iPfMSw2Ib8o/sTWab
         wEBe1m4rb74/Vxgzx4NGi0/SblF2/jXohMk1ErkgujQhqW1peUhD34yRyvSE0i2epVlv
         gv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783333829; x=1783938629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M3UbmA7EX72PxXWjZzRHV5fuh/MSA7OywU2pO5D8f/g=;
        b=rqXzOia9D7A+ycDvcCnpPrPeOKJRMXIHlvfoH1W9IKbIK2PwcQnWbzbrSd49bk5hTa
         0XPiiqc9ow992Kz5DxgKrQP8ibOtM3GiiPyI9N1JXNa2EjEn4LvAx0FU4NgN5roQYNiJ
         HtlU8wQwtSMa+yuB58oPO0qYixNTwPPB39VCudxUCfcRaqRatXopSuGVuzh89ttECG7K
         1AH1LFIoscnht+J7uDnorOMA6A4wcpK8Y61o2xKW/2rHo4x0m59Ax/PZzt3eKIlu0GNk
         Ywjv3Lp2e5z+wTJwQcOfdu+Fno6FCimIZwWQYaviJjq0W02+GZyh0TjRQDwvKBxUFYkX
         M/Dg==
X-Forwarded-Encrypted: i=1; AHgh+RpHn8bYskcJODHsEQaJ6B/JSfiPhAf+HHjk8so9wn04u/5aByucK6w6Xf2Fe6s08AudR3CVqAi7ejc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvUzTV2F8YgIsOtuRU4yHH8JS1vX6GG6019ymIKvFyel5wee0I
	nEZeRQdi4RG5iN8av88YqJG6tYV8q2vZVzbC3DPTXhaiH9861c7vHjwQeYZCn7K+G1yK45+kSNu
	K1I0YyT6aA+wAiB0ARtU1rzhWhABnT+cjDjRbtgJ6xBVAF2mjMDdHgubRIscW6wIjm+JCLx1O+a
	I780DukyB4iHwwjuh/WQMWHMgNCDTX7niQi0OhEg==
X-Gm-Gg: AfdE7cnHqFDDxJYFPSnFPP/KAWU/5thxsAuKFvGG1Gq+06TUdTqtwvBZ3exIE69ebG6
	a0qvfS9cUuM+3mfslZAQ5IEQPyEbjQkEKXSSbq5rv1IdeVzbU3qRlmKpEHZ2ftIswrGGOypjkL4
	PoPDgqQbFe/NL35fiP3SI6WBKcnXIEiA6y01kHmFMhWMJ1lzj+mPEZ3fAuliCx24EDXQnh
X-Received: by 2002:ac8:5d14:0:b0:514:9ece:a15a with SMTP id d75a77b69052e-51c4c2d1bf5mr140999261cf.45.1783333829315;
        Mon, 06 Jul 2026 03:30:29 -0700 (PDT)
X-Received: by 2002:ac8:5d14:0:b0:514:9ece:a15a with SMTP id
 d75a77b69052e-51c4c2d1bf5mr140998741cf.45.1783333828803; Mon, 06 Jul 2026
 03:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776080528.git.sean@starlabs.systems> <95a293902585bd43c6857b79bdcdb8be692ff687.1776080528.git.sean@starlabs.systems>
In-Reply-To: <95a293902585bd43c6857b79bdcdb8be692ff687.1776080528.git.sean@starlabs.systems>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 12:30:18 +0200
X-Gm-Features: AVVi8CdB5MkOPhKcT6X0F1vQT7djuSsQ5aVdQBtoqYS6goKo_LfVx_GqnZHDEx8
Message-ID: <CAPx+jO8aDe2MP_2B1zu7KP6WWj0igvP9u5tpoqMLSyixEjPeBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] rtsx_usb: hold runtime PM during transfers
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Ricky Wu <ricky_wu@realtek.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: JD9OmRl2xZYEDsP7zZ2xAXeFr6AsmSLR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEwNSBTYWx0ZWRfX10lCLMjm9T9C
 AvfUCfFMhnIBbbahDlpEZpGcUUkvB/w/16bXP5gDM7t5cHpHGJJcnjP2tA+XSw+5WgKslB2VVMO
 DhVnDuA8Pbn7yZu5liAuuVD4q8vQvauxr4mGka+NX/Le3EuA+9ol9S7woDQpljMPTjfLtfX7y2n
 C02Ww10LNdzadLicfQ5LwCkE6RSU4EEheJ5+ILUvQMoUOtxDb+xz3rlHAeEE59A4WlA5DXa60zD
 mYmhzWU7HX1/mqk1OKVRBVJ1DkzsY0Muth303m8RCjCxYOYQozIVPJSevSThsAkeC+FBFvwpY9P
 gXWDEZe1jvs3uNzlr2Yl3IURZw4A965X6cjS1fOKl7K4n/JoXB+5nEne8EfIiLlSjgFIQbaF4FN
 QJppvqLseYkC70j0tnMjGUUPv34sJ/oMLCO76059CfpF5Y0zeeNU1rlab5Y0ysf2SCPtAU8MTk8
 0jx6I7lRbIf1Zx8tbJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEwNSBTYWx0ZWRfX+cZZVjCN4aWO
 xKJ0T3LzNJdUbMY2rFK7aRMgroG45SdcdkACyzI5RQxmAiQKpjPN1hmx/RwbsvGkSq2ivXI463Q
 opGXHdoPXA1VlWeXOLT/F2eVWB/tURQ=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4b83c5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=DU1fBQQ00hOWpVFU5jsA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: JD9OmRl2xZYEDsP7zZ2xAXeFr6AsmSLR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060105

On Mon, Apr 13, 2026 at 1:42=E2=80=AFPM Sean Rhodes <sean@starlabs.systems>=
 wrote:
>
> Hold a runtime-PM reference across bulk transfers, and mark the device
> busy afterwards.
>
> When runtime PM is already in progress (e.g. from rtsx_usb_suspend()),

What do you mean by "runtime PM is already in progress"? Is the device
in the process of being runtime resumed?

> avoid forcing a runtime resume from within the PM path by using
> usb_autopm_get_interface_no_resume() unless the interface is already
> runtime-suspended.
>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>  drivers/misc/cardreader/rtsx_usb.c | 38 ++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader=
/rtsx_usb.c
> index f65acf4d1164..c8badd0db87b 100644
> --- a/drivers/misc/cardreader/rtsx_usb.c
> +++ b/drivers/misc/cardreader/rtsx_usb.c
> @@ -12,6 +12,7 @@
>  #include <linux/usb.h>
>  #include <linux/platform_device.h>
>  #include <linux/mfd/core.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/rtsx_usb.h>
>
>  static int polling_pipe =3D 1;
> @@ -65,19 +66,42 @@ static int rtsx_usb_bulk_transfer_sglist(struct rtsx_=
ucr *ucr,
>  }
>
>  int rtsx_usb_transfer_data(struct rtsx_ucr *ucr, unsigned int pipe,
> -                             void *buf, unsigned int len, int num_sg,
> -                             unsigned int *act_len, int timeout)
> +                                     void *buf, unsigned int len, int nu=
m_sg,
> +                                     unsigned int *act_len, int timeout)
>  {
> +       int ret;
> +       struct device *dev =3D &ucr->pusb_intf->dev;
> +
>         if (timeout < 600)
>                 timeout =3D 600;
>
> +       /*
> +        * During runtime suspend/resume callbacks, avoid forcing a runti=
me resume
> +        * from within the PM path. The device is still active when

Sorry, but I don't understand the above. Can you please elaborate?

> +        * rtsx_usb_suspend() runs, but usb_autopm_get_interface() can bl=
ock when
> +        * runtime PM is already in progress.
> +        */
> +       if (pm_runtime_status_suspended(dev)) {

This looks odd to me. Should it not be the responsibility of the
caller to make sure the device's runtime is resumed before this
function gets called?

> +               ret =3D usb_autopm_get_interface(ucr->pusb_intf);
> +       } else {
> +               usb_autopm_get_interface_no_resume(ucr->pusb_intf);
> +               ret =3D 0;
> +       }
> +       if (ret)
> +               return ret;
> +
>         if (num_sg)
> -               return rtsx_usb_bulk_transfer_sglist(ucr, pipe,
> -                               (struct scatterlist *)buf, num_sg, len, a=
ct_len,
> -                               timeout);
> +               ret =3D rtsx_usb_bulk_transfer_sglist(ucr, pipe,
> +                                                   (struct scatterlist *=
)buf,
> +                                                   num_sg, len, act_len,
> +                                                   timeout);
>         else
> -               return usb_bulk_msg(ucr->pusb_dev, pipe, buf, len, act_le=
n,
> -                               timeout);
> +               ret =3D usb_bulk_msg(ucr->pusb_dev, pipe, buf, len, act_l=
en,
> +                                  timeout);
> +
> +       usb_mark_last_busy(ucr->pusb_dev);
> +       usb_autopm_put_interface(ucr->pusb_intf);
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(rtsx_usb_transfer_data);

Kind regards
Uffe
