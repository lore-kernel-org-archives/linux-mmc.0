Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669E424D74
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380595; cv=pass; b=UVD9fFX2+3FHAlvuywG+v2nS0gKF/ZUcnjx9jCGZL6EtK/IYa4+i5FAsIihfws+G8FnTYg/W7ZBBHiK+1JmAWUDaWI5Ywk50H9k0Yu9uBVpgaZ9wtVvMI7GT/LI62aR/hVlMdN+AolV7ndokYBfyqgD1ktCFsPWvmmvaETjYzRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380595; c=relaxed/simple;
	bh=rxWn1cAIMWcSUsbY+qVZFteusHTgY7z1SsaovmP8s/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YW2vT3rnd4sdbgxqBg5ej4N+RzymPOtXRNNBHhu/5oX+Tdg45YuL4wD/AJcO7BoFknxtrxPHx0ZVk+G2ronszfFYtYZfhe+xFGm4qQYksAF/y73aVQDRCfo0pnkBj7FYFGEbd+MCAP4WYCueAcTqvLQST0J2iAWFCunKFJv3x6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cd1MyXOo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MltvbP2C; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cd1MyXOo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MltvbP2C"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E9nQgQ3731436
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 10:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M12Cwh3ZRT6ahFa1J+DXeT+ShEs3pxzKaObkmR8W2j4=; b=cd1MyXOoNTeupvMQ
	1vlzwu5O9fxeTHN1l64x7hYxAujJXzKCr2fbv9EZX3jztY8QgA3bEZef7KsAMG0Y
	TpweHent0/06oxXjwNiUy69cLhEs3kQa+1FH0mH6pmWttYiTZirymHZCQliftGJK
	xD/mTq439qWXuH534GY9JYVWAu9ZMnjUpgL9Mfhbyful2WZqAvrC8uES+ZxUGAGE
	Ns9w53JtZXdxDqMJwCIuhBgM/xW8vEWWGbQaDEjzKqx7a8UwaGrBeh0bD59fG0Wc
	qmpoz10K8tCCzLSstgxH7TdoWJ4m2zAJerQpmC4T7IM94HQn3vHbZG9Hvrs6Dse9
	3CyQTw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpd1f0eac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 10:09:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc21bc2923fso3078093a12.2
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 03:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789380592; cv=none;
        d=google.com; s=arc-20260327;
        b=i/+RIu0P1QhVS2B9b2G4iu6iaUINIfzyCLokUY9gZzWu9FELfvxIUUwT1GsIAQRAlC
         +nHl/pXYX5ZojPdcRr8UoFdSRQTcMHs1kKe4QtuqOGZZ3but7KyXBpzRdK0QbWBG6zCY
         oDd+gJ7sert6SxLCqL8jtyy77kXQEvGADrcbpsoDfdAJ5J/r0q2/KqIrO3/pnAjEm1Pi
         UJS115FrBCatDpQEKZOSgFQMTE0OG/qqcfn08W1YXG7KdxrOVv3FjYW06uAoyZeahYRx
         ydAB3qaMthi+FLTz+6hpv3+YekMwcrihTdDxaFrI1RSRm36+GwXpE+XZYcrJK8iHHC6W
         XH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M12Cwh3ZRT6ahFa1J+DXeT+ShEs3pxzKaObkmR8W2j4=;
        fh=ar1tixmaq9PaF2BA1118ev9RAMawfMEJAkx0K+fXqI8=;
        b=bGN09yeQMx0kx6Zk5oWZ5cjOkJSGI/aXWmALHJ1xS1jLizcP0co11CJHhHh6O6pu77
         nfoH+iM6jCICiH6Abwzhfa0wgFi9x0BIeBLxEf9Qc1HnfW6MhVujWPy9F3HD67K0pMam
         53TEKUwfj3NlkCloEV57+m1XsxzOOUXNNO0iJe/6dr9jwokUisf7wbwnkv5hiuxhbthE
         OtDivM7+r7wda/QuqQ/lqoyHqgjuyAz6wG50J7JrDCfsLQZyq4WlFGIOznjIQR6ODFBg
         Er0W2sllcKqbMsotl6vOGIyoWZt4tTFzPb1XnXXF6Z7jzfgt3hcrLU2kFkw/FNYTmxH1
         N37w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789380592; x=1789985392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M12Cwh3ZRT6ahFa1J+DXeT+ShEs3pxzKaObkmR8W2j4=;
        b=MltvbP2CYGcXPbjAIDf+a0q71p2peNKZbfodPhC+9FPk92MypDJftEuxf1+mNkFcSM
         EqNdKjDJc7B7V4uY9/Cy5CV4N3RFJEs1iIeg2mH4kf3zRqmTO1llFP7myy7eAAeLo4XO
         usGlx/S9nRZkMHIkVXz8zfqCSjqhWmcXaRf4osWXgDL83Af53BttNjUQbcP1mi/yccrI
         SRXhfN2DlUBRVCVVFMCNJ6ecpHNSNHYZPyaPq8OPuN5kzUPr3EkAaKjTxSXlnE76Fwqv
         kdY1YEB1SLUfztBEMj2dna8ktt4lnuzIOBDsfoZcVIX5s1vp/ZHWtEdeaFIR58joyZMe
         evWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789380592; x=1789985392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M12Cwh3ZRT6ahFa1J+DXeT+ShEs3pxzKaObkmR8W2j4=;
        b=r9tCuSrpBK5VgsVneOCZs/jU8YDZAtZMifIkIAazPhsIv8KIGMgTdYPPvf+UWUs1BX
         fvkhinliMljSHG8kZJbqe/FmusNg5Jla4T9PJ3g39GspNYKQdIR/WGevEf5Z2CV1Ri2i
         N6do2+lUp1eFTTaApkaE+U4yQhnLHT7UfDXCb2h71NtzLUK2+xKDx5I7tNieId7nG9mD
         sM861dmJfAaS3FkU6zKlLl81CLaJWb8Hn2z+ibUvS4BnUf/XPFG8zHonARTDcugtur3v
         q2zOsNfzzSajH1CPiTsaOVetbgOi6PNlCLYZe3CQRXXdX1Yw9i0yNwcvRcWD2QhNFSJx
         6oPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzt3wUexFEInBvaEzuou9ZC7Uq3UtU58juiF3T46H3q59W882H+8rq3NvK13i1pdpEIOsDIpY6jgKI=@vger.kernel.org
X-Gm-Message-State: AFuF++nYwgS9XGDrERT/Ue9itbl8LFeZBLWCLuUj8glEnb+dGA7WfnQ8
	jcXZ9oT/GyZi0adsQGAPdjWcGxbGEyfazmWODI3F6eatcRAf2R/e9a7bWO5TN5HAp77ZHCLVZZj
	78mCBJD6bJJXXSzerPteeIK3efw+eVOm4YD9M2jEL4hK42PIok+D1MuAJzKL8tojZlPLkIVBZzL
	42JlBrxmkzX8kE3bLeQWG1dA6puNdz9cBV13UJqA==
X-Gm-Gg: AYBFou2hqAM1XItFmWA5x2MAyxt84dDJiuYRb4pqdYYihZBQxNSrNHyzCzz/Z4K1BDS
	WaHjhO/tujuSN4MhzDkfL5d0UWTZtoGqQVXQHzGrZivb7rk141iUOTeTR0cropOZA1TE4aLuVIe
	0JcB8lVD65qx9gSms1Wfi7OHOaxG0fN+yba7HKi5pP1xb29ubVrMPIGBt9Xw==
X-Received: by 2002:a17:903:b8e:b0:2d8:d4d3:3fbb with SMTP id d9443c01a7336-2dd6c73445amr40754485ad.15.1789380591328;
        Mon, 14 Sep 2026 03:09:51 -0700 (PDT)
X-Received: by 2002:a17:903:b8e:b0:2d8:d4d3:3fbb with SMTP id
 d9443c01a7336-2dd6c73445amr40754055ad.15.1789380590927; Mon, 14 Sep 2026
 03:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913223538.91579-1-mhun512@gmail.com>
In-Reply-To: <20260913223538.91579-1-mhun512@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:09:39 +0200
X-Gm-Features: AcwNN1UKvtuQqttQbqd993vkvprGXBb1M6WJsKdk_G31r2WFSme_tK7rANZaz_8
Message-ID: <CAPx+jO-Vck8PzQjg4yn6ft4Rms2_9eSOLpbAQryMLChY87BPMA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-aspeed: Remove children before releasing
 SDC resources
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: V3Rt4F9gZjNR7tbNTNxvGem-XdcAlEA3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE0NSBTYWx0ZWRfXzH1/NOWX6qpB
 M6WKPe0YAUMcWKTbUgKFpf/HFRq1k6JldZ93veUAKq+jtKRnPEPwFdh5R7jHvvXk9wvdroR/Ptl
 jKk/JJFOZOo21jMDnP7rJVOHa8Yo/60=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE0NSBTYWx0ZWRfXwHKjVlwLkrs3
 ov2pGyD8oZu5gFmaZfIPbmsjjmBY/Zny0rEpMtkhBJdj3lj69KxDaxu4jVS4HHAMyW6n9ERmLhP
 Or8L9LNr1RSlH22xpz1atS25+xxvOw/b7Je/NC0Zq+lfAjnPOgfU1wF99O54CFXopb3B0ztpxqk
 dh17fwbnxQd4QUrK0tHCd1f2I7t4KyNlcKEG0GvYfDWc7rp2hl7clhk3jikwXpk5ji4N0GTQjTP
 A2Wq9w3IgTmLbzirtY6P1sYt2CN87zJUVsDOmsvkb32fc0I20ESlWBLA5mUWsEs4wWNhM1i0APq
 tyI5mYtbNLEEHjdkospq4C0wVqGbm0KY+L6Ow+iFySZAllHne8yc+1HW+T4aSLDDpB+nosHI2PW
 6i079QFMKp29QUVeFTWazu4MvXNQMEy2TtYr+3AaT30RY3MjqQPRMum2F+q8rVR1Kvp/YJcV3og
 C2UKK2lYVFjp/XRYRDA==
X-Authority-Analysis: v=2.4 cv=XKel2ghE c=1 sm=1 tr=0 ts=6aa7c7f1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=_cOgsa2NosUwn6K3uuEA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: V3Rt4F9gZjNR7tbNTNxvGem-XdcAlEA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140145

On Mon, Sep 14, 2026 at 12:35=E2=80=AFAM Myeonghun Pak <mhun512@gmail.com> =
wrote:
>
> Probe failure and removal leave SDHCI child devices registered after the
> parent clock and managed resources are released.
>
> Unregister the OF children in reverse order before disabling the parent
> clock on both paths. Use of_platform_device_destroy() because manual
> child creation does not set the flag required by of_platform_depopulate()=
.
>
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
>
> Fixes: bb7b8ec62dfb ("mmc: sdhci-of-aspeed: Add support for the ASPEED SD=
 controller")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> Assisted-by: OpenAI:GPT-5.6

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Validated with an ARM64 W=3D1 object build and strict checkpatch.
> No hardware runtime, probe-failure injection or unbind testing was done.
>
>  drivers/mmc/host/sdhci-of-aspeed.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-=
of-aspeed.c
> index f5d973783c..d317626feb 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -560,12 +560,14 @@ static int aspeed_sdc_probe(struct platform_device =
*pdev)
>                 cpdev =3D of_platform_device_create(child, NULL, &pdev->d=
ev);
>                 if (!cpdev) {
>                         ret =3D -ENODEV;
> -                       goto err_clk;
> +                       goto err_children;
>                 }
>         }
>
>         return 0;
>
> +err_children:
> +       device_for_each_child_reverse(&pdev->dev, NULL, of_platform_devic=
e_destroy);
>  err_clk:
>         clk_disable_unprepare(sdc->clk);
>         return ret;
> @@ -575,6 +577,7 @@ static void aspeed_sdc_remove(struct platform_device =
*pdev)
>  {
>         struct aspeed_sdc *sdc =3D dev_get_drvdata(&pdev->dev);
>
> +       device_for_each_child_reverse(&pdev->dev, NULL, of_platform_devic=
e_destroy);
>         clk_disable_unprepare(sdc->clk);
>  }
>
> --
> 2.50.1
