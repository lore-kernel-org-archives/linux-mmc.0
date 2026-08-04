Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D5244999F
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840923; cv=pass; b=m00pu1cbadivOxSxB2/jf8mVzc4MThbuKK8RsPv8sb34Np5ElRFjNqw73JYCwC/WaQckYqhto0MGewGO90In/wmO5CTwYnoHBfymxM3xE3JgaPXjfbvk4ytxFunsqJGy9zwUos3iBRxeNkDRChPf2yn1twkPvlrvZcZc3O7UV1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840923; c=relaxed/simple;
	bh=G1KQ+LVtHy8RC0QnGA0WPBnXR1RfM0037fuPlYYD2aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsrKSL8x7PSrhG3rRGmgu7PH+OeX8g8DZCipBrc9MiDkbzIIfSdvxcHMfNIyr61yG1BR0wNJS8C0riYoGFaJXAJMe3uGNM8OoPABEI2Ard7fSqodg7fjUK+xssErb5wtvJWZQDOAYF05VIgSzBUpo3F941AK7YdXERI1h8fIfQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y1ns8Tli; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eANkwK9V; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y1ns8Tli";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eANkwK9V"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748CBBi2978743
	for <linux-mmc@vger.kernel.org>; Tue, 4 Aug 2026 10:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ufWXi06UUaYpOR2ocZYH1DcUH9ePXARaYiL0CTrWXC0=; b=Y1ns8Tliv4Vt8fg5
	n06OE2tVnaiAXIrrFkxkSoAikEz1oaSN9zNiY9PpxPb+v5DrbwCqyWlx94EfHisS
	Df9qQSz6yK0RKQk5pbYgpR7GnKWiXvfK8mRjF155XEC8teVY7k1jY+vn72KHAAQJ
	Cp7P7b0JhzqI0XYwGsLlU8E7FbhnxB6nFz88rju/aALA1fxyzCAVxQgED79DwJ/c
	yuL/zw/wpd1rzzGnXssQFFQLuGvmQlbDHLsSPaLAiGKIzgf5xB0cR2g6kbs4AU9/
	ZVXuwBClcQmDZhIW7tN1QtgK4tU6In7ti3nhzaCqHNlDPnsdbu88ivJ1v87yomXa
	bC3Zhg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu2syjub0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 10:55:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-526da7e3c9dso39784321cf.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 03:55:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785840916; cv=none;
        d=google.com; s=arc-20260327;
        b=LomASbpDp1nafbl6qL8HGohgxYoVobtburBuIqZ9MB/HYq4y88a9tmBaNpY0R2sA94
         jtVsypyvbyU6Z8IQzDiFYK+K/oQIb+5ZnCtQjScSpwPG4/Cvnzo6HfKBDUgsugnWX2cx
         qZAFe2QZQ3Cs1b4BStsRdbAyxcqr9JpHP1buYRx/iWmPTA4BFVix8eK7js8ZGjubfcMv
         C+BTP0Pjbb67nYW29QVUmc/4WbTJ2nDvLMvFT2QJ3b3vUOU5SP9dTgQiduySahspvo4m
         P39UqqhEYJgoU35a5dv8TyKHGpT4oDL8fkx0IJUTnD7v5fsPbzg5icr4V8znJrDjVFdr
         2JXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ufWXi06UUaYpOR2ocZYH1DcUH9ePXARaYiL0CTrWXC0=;
        fh=m7Ew5kuZ6K1HRSH1prVh3TXKPw/dt7SZlwA9GWmelnE=;
        b=AT6pqc5xlJfTymuJkVhHvv+YYQonDqYFo5/LqtJxpBt8nQZNu3Vs3D1/8u41gGIUnb
         E/fG2nlHekoM5wgWFWXII6W5nzITmfjAq6UDLrB1xuzfXC+TixN4qokHqM+oJQ1Im/v0
         K6SRalJNIlTb8Fl5cgtaD30YjGqBEUGjKUFFAtJCFzDpQK94Du5PcS/gpy5kYEIQTW+x
         m/vA9mzm+GQXcPuXRAtV00VtPkMXfv1xtzGGgVABRCMB1FaKkc3qlzOfCy4KIedYZSr2
         8szR4dpHvDn+EaWprf7A/QefUiv26ACB2CDZ4EJkUyNjGQgaP1f+lk3Fy0NpidpmXJ/O
         LVJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785840916; x=1786445716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ufWXi06UUaYpOR2ocZYH1DcUH9ePXARaYiL0CTrWXC0=;
        b=eANkwK9VzQixu5jQJhu29WNi5zREerRJmRXkAIAqeYQgNMOXjgvA59W9mpGwmq9/OC
         x6oMtSEm7p3rwk9SpBnltD+vCHoaGlLI4xWmi3uftTmSj5JJKXZbXRHgDRzsZd37GwVS
         EpXWFSDmzlFj4rn0fFl9JQKDDPZOEnaC6YxWzAXpNteVxFXY+qlR6iZ1gOLtjXkL90aS
         KSe07vt4r/MSpS+0yg6O7XXj8jOzsm2S5e7/xVdmmi4pt3KCWZFDQJTdRUE9pqXGI9QX
         kIB6bIPaR7LYmTvdtU185sUaWYtBHGxNy4M51kBes2MSKT2oitJn7T5u+4bX9OkhKg/f
         IA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785840916; x=1786445716;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ufWXi06UUaYpOR2ocZYH1DcUH9ePXARaYiL0CTrWXC0=;
        b=ig3dGoJI47GYCDsskU3Bvc+Q0MHQIHENJEMQ1iFCOdxpaaicC5M3x79/8I9TDjJXj5
         H3EQ9QOasqqSpUTJB+iLQkj+TmlAYKuiQI1XLBwOr8oB1Djdp/mdAgvu2JMCAWGkEW2m
         IdN95hE34eKpWnrXNXqmekXxLSuYIcmk5WC35GhEshhmX9b8SBq5uD3WOKiyBopeSXZT
         LOboxqfafcdW/iI1Ep0JZXgXQTQnBijKdnl/jLPyAUqrJ14YRbveIwUCjZPvMtgPO5c9
         a5xTnzqkMu9oJrsDdPfNoV/S2DrQeb2EiIZSPTTfAqeMllfN77ZjqCatZ1G5FYV85nSZ
         Ubtg==
X-Forwarded-Encrypted: i=1; AHgh+Rpgkwob6gv4EgEA+TxvxqaeYsmhkYHQVE2KXH1ufleI5RbrfRCowGpYZA5kIPCxFIQrH0iZn26NEnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnD0999jz590Ebz9/Ky6yv6LRefGi8hE3+mjLHvcNpuxtiiSJc
	G/vBRcOpdIYCW1hopTJQlRA/pm0X8zc88EfpfahAlG7T4XvwpiZcRw+n/kGIHu3LqMGseh9gQOe
	hGPG6YAYxRAbFSdpIxAouXaP3TWHETxFmRQNiCLUP5mQSv+RzboIw71Zh8D5yzunWCwxeV/UpFH
	Hg5e9Ehmut+4MxRWWSeyoAoDFu8o2YWu/L3kWjBneh2JftkbHs
X-Gm-Gg: AR+sD133enRGxVvBCh6H7Fcitk70XEUmRit7vuM6jKnKFqyULZITpPts/fFGiwQXPHO
	CDts/rXjhd0FDAQYsegpLmWOI6z0MOazv3fdSD/nhosOSD0e0vU3+DHnizgF0pqObUtKDu50w81
	ForaSvZVooT+MvnWeLtc0B8iRHh+3kGdGTUfRm+XNTHPZViYx28fExbGv6eQ==
X-Received: by 2002:a05:622a:230a:b0:51b:f857:cf82 with SMTP id d75a77b69052e-52b5669e087mr269251321cf.8.1785840915738;
        Tue, 04 Aug 2026 03:55:15 -0700 (PDT)
X-Received: by 2002:a05:622a:230a:b0:51b:f857:cf82 with SMTP id
 d75a77b69052e-52b5669e087mr269250711cf.8.1785840915162; Tue, 04 Aug 2026
 03:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729201420.4047677-1-kamal.dasu@broadcom.com> <20260729201420.4047677-2-kamal.dasu@broadcom.com>
In-Reply-To: <20260729201420.4047677-2-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 12:55:04 +0200
X-Gm-Features: AUfX_my6NQKv03nYfYlqvoSJ9uyhPkd5qHV0OIawzmvKcfyE9Gp_ic94xtc46ow
Message-ID: <CAPx+jO8G=u-D2saEhzoH7WvLH+TYksbkg7sTH5RdnuZx5gGqtw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mmc: Extend keep-power-in-suspend
 beyond SDIO
To: Kamal Dasu <kamal.dasu@broadcom.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Avri Altman <avri.altman@sandisk.com>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        Erick Shepherd <erick.shepherd@ni.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=TIh1jVla c=1 sm=1 tr=0 ts=6a71c514 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=Q-fNiiVtAAAA:8 a=EUspDBNiAAAA:8
 a=VTvvGi8E7jVqzfWfbMMA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4NiBTYWx0ZWRfX5jz+i+l55Tee
 b9wTBqSgnJzeLpXsJNfEW/1ncgVYUwjkjRS7aUUcqUufHf7FCO4nr83TR2DQpsZ2UZ+IBQmufaq
 D6tMhGmtbrInNqbi8/6A2B/NtgmfpAM=
X-Proofpoint-ORIG-GUID: ehExzAnxHamSHMwHbEpfxZD-TdTfXNGr
X-Proofpoint-GUID: ehExzAnxHamSHMwHbEpfxZD-TdTfXNGr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4NiBTYWx0ZWRfXwMFzW8HMPy+0
 6R4IoD+9SZe+iSPDAoY9e5S8VbJHieM0FeDzasQMIcr0v08mNTejaYZC2jsbKe6fiwhjF3YWhGf
 AARAG2s3T0VadXKRkduGe21zlahAVY+bZOYrm3n7z2+8y5m6VPm+mQwTWsUoXIJCasEehTtkotN
 CAeW1bXnYwqtSqnOE3baAAZ0iWl1a2tBo8hIr5KQ52roHaTuuc1/tSo3KVMgx/E2l9Pv2IE6Xzc
 xORkBfkeRsCDTQ9d6A9en+Guirm8KQWwNfEDKZT0m32ZjiCoRiDM9zgcR4zLGYF9wEN1PYQ58K5
 fJcYiXRahSRBHUg6k4/Uw2a577EDSRBGLlty0u7Vjb/wx4EAGSsn3QCC57t98y6yizsFp463Ivr
 fSo3W4zFHmmjygWwQJ40IlNE00ZlaIsGNIEWz2+LSgGYKYnTPVs0sZXAKw+A9ZBVVz+dbTd6U7a
 LHnRnQeV/o3VZAt7pPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040086

On Wed, Jul 29, 2026 at 10:14=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.co=
m> wrote:
>
> keep-power-in-suspend already documents exactly the requirement
> needed on (e)MMC platforms where firmware accesses the card directly
> during resume. Rather than add a separate property describing the
> same contract, drop its "SDIO only" restriction and document the
> (e)MMC use case alongside the existing SDIO one.
>
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
> Changes in v5:
>   - Added Krzysztof's Reviewed-by.
>
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

I realized that I responded to an earlier version yesterday, anyway
the comment for v4 applies to v5 as well. So in a new version, please
rephrase the descriptions to mention HW/FW and not software.

Moreover, as I said at v3, I don't think re-using
"keep-power-in-suspend" is sufficient to cover the brcmstb boards.

"keep-power-in-suspend" means that the power for the card must be
preserved during suspend/resume, yet at the moment this is limited to
SDIO cards. I made some more thinking and below is my suggestion for
how to move forward.

To be able to describe the brcmstb boards, I suggest we start by
extending the DT property "keep-power-in-suspend" beyond SDIO, so it
can be used for any type of card (eMMC/SD/SDIO). This should be a
separate patch and the first in the series.

On top, I think we need a new DT property, perhaps something along the
lines of "reset-card-at-resume". In principle, its description should
say "The HW/FW may have accessed the card during suspend/resume,
leaving it in an unknown state. Hence, before the card can be used, it
must be reset."

For the brcmstb boards, we would then need to set both
"keep-power-in-suspend" and "reset-card-at-resume".

Krzysztof, Kamal, does that make sense to you?

>
>    wakeup-source:
>      $ref: /schemas/types.yaml#/definitions/flag
> --
> 2.34.1
>

Kind regards
Uffe
