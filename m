Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A7D3B47E5
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789035481; cv=pass; b=pN7kz7NPCLvyPOWdpCPmXGigHhm//1u+1qokV5KnTU0nLabjs40tH++13ae/f64G1ljewsnGBv84pisrN3Jra8ID7gm+GscvPBSMmS+xrdu4+D50l90AUOaYHl+KuSISwGECGIOM4ygBs+an7zUcAo7wRKgiQxEADbLOhEl0cNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789035481; c=relaxed/simple;
	bh=xJtlT+brubTDzcwB1LsQU2wH8jfhem1ycRIpQIZsMuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lv0Jfhn46eZtjM9R9TPFgXB+Z33Sp3+uLjTvjiwUqmz9qS7S4DWhovhaWsK25RNYdOVw8zFcof+2CBFQtcZ5uQz1Xo7ZJ4XFnvX4D26s2qYC0jL3Bea+vRfolvGLK4b9tr8Vcl37Khtg9QcZDUkYv0MobDsVOqJALJnzevrNDg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PGKqZv6u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YYG7PFlR; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PGKqZv6u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YYG7PFlR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A8prOq1290004
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 10:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5o0LQq2H5NyuqhWcIAsOhclTasLhXE6zFp16BztH0tM=; b=PGKqZv6uqTxJsb4V
	yz/56PwDXoYI/+DTCIsMR3DS/Z1r3noojO+XzGn4dFF++mrEALLWcGYqgjyWe3WJ
	ZHYBaIZghgOs2KV0ThF9P+XHnCRbNDHS5d/9EFsz6fhbSRUpiEfy/fBUN9IdRTOA
	TW0teNVSH7BgXWyi7J4XQvW/RwS0u1vLSONrNTUqUcRTkuyenE4y8wVAhp7D12bc
	YYaBUeeCvKRDcdXwi9yU0Sf8UBVOV/8PTrIKBN9qSXquo7+Dyvmf6QsOlNPpf2Yq
	nah7yoUwbbBLZawcshuQMNKa5GbnhltI41cGg8CkvKkDjBxyHIp1j6SDVwjDSzKP
	JBStIg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydka30-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 10:17:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so11222910a91.0
        for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 03:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789035478; cv=none;
        d=google.com; s=arc-20260327;
        b=rlxZex7M9IV0WNIykUsb3hU3I9etrPU4yCFXc0K1CX8AnA5WQL53Fe+iGH2A+59v+R
         rvwj8m6934A9LD5CDblwjumj+PvC3HuCtkLj0QRv1oYZNSd5mb/djsh0Q0EGPBRW6agN
         kjahaD/JK606ymAP0KltUcFNgclHWwdpKg3UdnbPvrnacjqHPUfRiatxQM0y3cUahdgB
         07ySoh+awsaxxTrJledVBbZUmLFD37Y4Z57xf58nmii72Qr9aVXZBwieeogNENmEhOBZ
         WjB77WkIwm68XznkkpWTpwoklnvqCovF74+nI5KFNJENr8xVIuIa/f2mg1rcgezf+QFf
         5o8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5o0LQq2H5NyuqhWcIAsOhclTasLhXE6zFp16BztH0tM=;
        fh=s0ONYfbr2crawwVo9siwtL3wQn9649CNK2DTpimn094=;
        b=fLQ1Z76cFmHxJeMBY6YDVBOdSgNJgwSPZbNwVSfNb820lCMoOASpxpWFkyR90oBLMe
         bWNmcKRK4PySqk77TDI5knUwrdhrIwxxGjvm2J54EWZEky7bQjYWywrxFfsWzYpK2clg
         AyqTv2UQXosmOdNnL4WofL5oDQL3FCyZLXRbrBrn3D4z+oKsRNU1OpCT1eJLDIwZluyd
         EZhNuLT/53FS8k/LtzIyeym4BG7K56yveC0kPd68GaYH4gN5HXQV22z9+CaLPewp7ph1
         95bcUI3fZ7vd+U7BMNtvTGz+ab43tc3GVDvXvUS/yUDvl1KJXnmRdhMsgSynM5r+JDpE
         3QXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789035478; x=1789640278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5o0LQq2H5NyuqhWcIAsOhclTasLhXE6zFp16BztH0tM=;
        b=YYG7PFlRv/m7RtW/2T+N2DJNrZXsXtWKhFJOa1UdQ68pEJDuw2oDtyLTbu+wQWJqvJ
         ++i1ue1XoDSxWUvDyBIiYzS/frVNffrU9P9onZSrRwyVo6A3rY3Urmmj5kvDmf/X8W6i
         ektBJtxE8Zl+w6+R9Xsixdh5tvaKkvwfpmLOiEQHgVvxBsQnb/4j+iaQtMAQeP21m+HQ
         dZOmFs+ZhrWX0Rep3xscs+Worxc536G8Qt4fkbY/VeIxwx/6MmOr1WFKjnVDiHZnaj+P
         ibWw/LjhdjXtk1z5Uq5qcaG+NMejXFHerT5KsK26vYHQ8H1gRZZ7f7tnR4YQw6y4QfJ9
         N9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789035478; x=1789640278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5o0LQq2H5NyuqhWcIAsOhclTasLhXE6zFp16BztH0tM=;
        b=drPTx75lHSsJP/VoPjtTQX+AQnaLPEs3yIRBlivfAdwajU+PuJIUJseeA4qJdstbS/
         gPUnyRhVU54UjoNg6ygs/S99MpJh+jGrV6QwiCBYnyGenc/JKUap/BJ2YfY+Dk+yzehy
         h5p5gbnt+BK+oL5e+kWY2ezgUJyYZQsr4B8g9MXG2WJEq/Uj+9xsabFcBi9eetn2iGUM
         Q9zf+xZvLC2TBsQ4ufN4PhQDWXqB96Ic2m3m765MHXolWRBBdULU0WaBVougvWt+i69A
         +64KIvZ+tpyDsvblNss/ooEhOm3r1Ecvr5gQyfaOjBoJ/6CN9LkQ0VUkQhdYb3lGk8En
         T1Tg==
X-Forwarded-Encrypted: i=1; AKwUvBxWqKi/QTMaqp+HsZJkYWwxvNQYf7TtoL7MTT6chDlq9oa12RzVGTOztQBMJxvfnJMe6twg60KXuXY=@vger.kernel.org
X-Gm-Message-State: AFuF++kyAlTiiuS6hUT12ImjsSJEQqnFxT5Q/o7C6avnde4X9cDtjJeO
	Nq0oN0rOnVvJe5lEp8S2akpvcwBK02IregCL+kORYHqlWxm5F469IW1aPxbri17MKu0JHy/3ijF
	72qSobtQuJDl69btG7rkLypdDkwRQjDNYFQARqLUDmMufl0m1DtDOVmiTQhs2AQZ8gwkJ2DaT0i
	DMGGyLEJ3yaIuKPY6amZ3upnPTRDacyYXh3X2nPg==
X-Gm-Gg: AYBFou1AZzKhhZ1+GDBTKA6HlX9pVIVGEPcjWvJnYP8o+rZB4sg/kVG9wuL+tZYi5sn
	pSWa6tC4RH8uyEW98bYGv1h2UseZyGfSIq7vjC+A+Q72YFjBC2491Kotw5MurbU08vVqILl9RTX
	l5kFPulUnssfZwyBIRIFH7VY/sBZvAjs/IlrFTtNfChWNFk83vA6Qrzs6C4g==
X-Received: by 2002:a17:90b:558c:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-39d70ae1a5emr10579641a91.13.1789035478534;
        Thu, 10 Sep 2026 03:17:58 -0700 (PDT)
X-Received: by 2002:a17:90b:558c:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-39d70ae1a5emr10579584a91.13.1789035478102; Thu, 10 Sep 2026
 03:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
 <20260824-enable-ice-clock-scaling-v12-3-09271f583dc6@oss.qualcomm.com>
In-Reply-To: <20260824-enable-ice-clock-scaling-v12-3-09271f583dc6@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 12:17:46 +0200
X-Gm-Features: AcwNN1VvsxYSlSneh1UTJxLDFcgkCYVDC7Rwi96BfcNazOVn_vX8zy2Sk9dMolo
Message-ID: <CAPx+jO_Ltc6Q+VdUgOs81azTiM5Vx12GH1z+CXt6NW=M601THQ@mail.gmail.com>
Subject: Re: [PATCH v12 3/6] mmc: sdhci-msm: Set ICE clk to TURBO at sdhci ICE init
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDExOSBTYWx0ZWRfX8wEtzsDLGkKB
 VQBoUP8TlEsKDQg8hT5jbFL5o0me5+rQxSBw8ppbBhQOvo3pgTy5Eo4Epz8ZvcS1OgyY6a1VLwz
 xuYFx7QRc6HbSZWyJyMOcq0eYRyikxA=
X-Authority-Analysis: v=2.4 cv=UJNIjyfy c=1 sm=1 tr=0 ts=6aa283d7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
 a=i-sMpDq2_rzAXM5hadQA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 2yW8-ykCbzJtIPMFP5JCq_mvDeeCsIn-
X-Proofpoint-ORIG-GUID: 2yW8-ykCbzJtIPMFP5JCq_mvDeeCsIn-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDExOSBTYWx0ZWRfX0DTzQq71BhXo
 D5NHy5Wd4tjTWQVjwuiC4g1ZdR4SAj2g0MjMvv0lhP7EfWHiafVt4JM6up+lurMEXLbi1zXDfT9
 xxKkIpLdpfMqXPGBWSfQaPeQFYhc4IxYZ+Y6YRlB6o5mz+yQvRXemUYmgTZKYuPuTgoU8WkS1Cu
 b8gz2QoA73QZyvojO30n92pVtLw+bIzHWfBVwKSHvut1zFGiqd0uKovlpLfIAGURIMBpIdjwTuM
 UVwHG/oT2LnSpvubR3pOI0Ws4HiXd8oMFmUoxh3GS4dmz9E6LCyv2ohjRt4N1hBz941qhKRDwJe
 rcFhkH7dIlbXoQF8dzBCbnIrCKLwEv1nopTHTH6hCaiVZrDWkvFGIpobCQK2//fefmNDyHsl54p
 pUFGb11oNrm5XOV0aTz9tDsJSBAJzsYPRYwAe3RhoB6iL2+rhUY7Gh7a5f2cZGsv2CGmwMuuEfP
 jooYJs8kwINR7p3vd6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100119

On Sun, Aug 23, 2026 at 9:48=E2=80=AFPM Abhinaba Rakshit
<abhinaba.rakshit@oss.qualcomm.com> wrote:
>
> MMC controller lacks a clock scaling mechanism, unlike the UFS
> controller. By default, the MMC controller is set to TURBO mode
> during probe, but the ICE clock remains at XO frequency,
> leading to read/write performance degradation on eMMC.
>
> To address this, set the ICE clock to TURBO during sdhci_msm_ice_init
> to align it with the controller clock. This ensures consistent
> performance and avoids mismatches between the controller
> and ICE clock frequencies.
>
> For platforms where ICE is represented as a separate device,
> use the OPP framework to vote for TURBO mode, maintaining
> proper voltage and power domain constraints.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>

This looks good to me!

Although I have a question - should we never drop the vote? Like at
suspend and runtime suspend, at least?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-msm.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 0882ce74e0c9bdddd98341a67b97bcef74078e0c..1b4c276dce34d76dcbe75117d=
e37e09ea2002633 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1902,6 +1902,16 @@ static void sdhci_msm_set_clock(struct sdhci_host =
*host, unsigned int clock)
>
>  static const struct blk_crypto_ll_ops sdhci_msm_crypto_ops; /* forward d=
ecl */
>
> +static int sdhci_msm_ice_scale_clk(struct sdhci_msm_host *msm_host,
> +                                  unsigned long target_freq,
> +                                  bool round_ceil)
> +{
> +       if (msm_host->mmc->caps2 & MMC_CAP2_CRYPTO)
> +               return qcom_ice_scale_clk(msm_host->ice, target_freq, rou=
nd_ceil);
> +
> +       return 0;
> +}
> +
>  static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>                               struct cqhci_host *cq_host)
>  {
> @@ -1959,6 +1969,11 @@ static int sdhci_msm_ice_init(struct sdhci_msm_hos=
t *msm_host,
>         }
>
>         mmc->caps2 |=3D MMC_CAP2_CRYPTO;
> +
> +       err =3D sdhci_msm_ice_scale_clk(msm_host, ULONG_MAX, false);
> +       if (err && err !=3D -EOPNOTSUPP)
> +               dev_warn(dev, "Unable to boost ICE clock to TURBO\n");
> +
>         return 0;
>  }
>
> @@ -2149,6 +2164,13 @@ sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_h=
ost)
>  {
>         return 0;
>  }
> +
> +static inline int
> +sdhci_msm_ice_scale_clk(struct sdhci_msm_host *msm_host, unsigned long t=
arget_freq,
> +                       bool round_ceil)
> +{
> +       return 0;
> +}
>  #endif /* !CONFIG_MMC_CRYPTO */
>
>  /***********************************************************************=
******\
>
> --
> 2.34.1
>
