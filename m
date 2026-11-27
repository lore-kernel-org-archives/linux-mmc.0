Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790236;
	b=VOJ0+WSJWiZBC8Wa1nadlL8hqoaFcJqmvgApzv+9M0uZ54VibMDfbaG5rVsAaMbmG46S
	 8WKQjWjcqAUuZZM4PabxUPiSEThcFf1zR5MrQ2i5iS/V4mbEFvGW4boov+BdcFB2Ev1xm
	 f4alaazLHtJ/5XlPOPWZbxxMb6cknla8MHNRUBzU/MCdeUhVlO3G9QvzrUt4qg6e+S4h0
	 kFBrYZ34RrCCh+gVwfAE61qmRLlc2FcAKjSZcLXlQxLosTUirWWTqI7RrEQ7aIFQLNqEX
	 HQXGU4r03zcaLCll6HBb8V7aHYBVLPfMKeUADvBypIZVJt/G2KMHpqPJneqKLoJBzNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790236;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tWNqqUhi+1+BXB18Sy8VdaElJpWatihymQrBKDZIAhs=;
	b=zJPJThNZw1MIv+EdJGd4WltgdUC72VcassbWULZLIXkiwsXFYrDXOWcyfZSMpNu73XjN
	 d3mO6ZKV+bEZKdRKqnGtOtWbT9OC5DUhIiMXDWNb+PNjU3+DVIDsLD8kxcqMChUVm41Ru
	 NJG3d5gVRF9RgH6FsuMxkkxWBlCkWvpRmuK1p5gNieeJ5hvExPUwoEQ5AToWny1WCRyWV
	 p95md/OKt8hAORltDBahfG4GD8TL2jT/W9260yo5p/4SSDIA5yv/tyOTDpWsFAQUqQzka
	 FKzVYoM7wXlaHi1y7NPjp1TKZcys53uWMHhVHGz5OUBStv8QHzOlsbY01cs+9rbK83w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="YmMgZ/pO";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kh8NqtIS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F4C606A33B
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5F4C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YmMgZ/pO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kh8NqtIS
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1Zb32097673
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tWNqqUhi+1+BXB18Sy8VdaElJpWatihymQrBKDZIAhs=; b=YmMgZ/pOab9CSh5Q
	DVl3xNIexnnlIj/zQKs3hc/pzrbtXHmPn7TGlsdPgxAUpy9/ZzqKZ4LNPwnkB7vL
	F8Zk/BehkVn/5JMt0fWGJoklG0bGOCfa/wc9JsNLt4Nh42vD5wux1HniKAa65pDs
	kq33x6S4hv1O3wBgQgwH/3p98pu6plj+zdNMklwKniLieS21ov0TWTU+dwgrrFlc
	mN8/vqERjgEjMDnaGOPVx5XOuRn+6eOy0hkeN4PxrqQqcglQrxtCShhRBk2acWcG
	JSchMAdZmx9UuP6JVLmhR8gvpE3AF0lnUXSvtw04e9ompKow6crfj0ayXXuwBHOx
	6gfowQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j756k9pm2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:37:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b08aee6b3eso6946884a91.3
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 06:37:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795790232; cv=none;
        d=google.com; s=arc-20260327;
        b=g9CuYmyS/ydck6Z2mLlnbDfB/maWZkn7dLttzg/9qcrCkYxXc7HwING1wLJscYQ8oW
         UOELgS+uhZ8DyZYgT52pep6WQFQ0CB03svQ7Yq1nR3u19Qm9jaR22AZsOti5DYXvWElj
         8WxFbY2JuYIedAr56ZZfQdAzb4gjFifEcKX0YkvhPKMJ6CM/vqQgSelMlzMc1NjOGMcN
         e9Fi8GbmAZ7fov9XKlL+lrCp/TbxJtS61dDyjmNIatkuKI8YpSDSueLAoDdTpJlpUf10
         27Q0+3AapvNNP0pHDPo6VwYYLIM4Nrn8Zf649DZhrH0jJWJ5o8yZ0Jpr25i7ciIevoMc
         EL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tWNqqUhi+1+BXB18Sy8VdaElJpWatihymQrBKDZIAhs=;
        fh=P2XN6QEFe3o4IefAtku5KUIdBwEsnnA52jDqC/WLzfQ=;
        b=PjW7BMnuIvuM3HcwvXd/cUMIWrHUBtOm8CtwSO3m2TWsGvOriKGOkpk1yEvB/gEi3g
         VYLWiFmbiZtdPckfFY/UFFtkRGf0S49rRBQbMWUtkJwa+rFFhqSKrAMwL4q3EL5nhlV8
         Uj9dwtpLYeN2TeZDXr9G9PsScVtcWLA9rl7OJ+0rjJF0qa3PeAHsBeLvldKZstQisbDV
         d4xC9l60ptrm21p4PgzfE/6Mx2xjzC1kE2r+7zZmi/8chPXfp98B/FYBbBpZPa2iICPG
         hjL9Iis3qSMzYYkT4eX6ZzK3dctQEW1ONgPcTv61pYYK8INdBXms0tKlEmYhuejfL9Uq
         ftCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795790232; x=1796395032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tWNqqUhi+1+BXB18Sy8VdaElJpWatihymQrBKDZIAhs=;
        b=Kh8NqtISoZ/Vkw2OYJepH8g7VFszxxaC8+OnoQ4WraEetnJ1DKypshW2OahcEE7Rsc
         wozXephNpe3etPMFc8Znd/FYmSP1SrrfDXw4dDq8WnIvILj4/6GwWU6yvzIeoHZIB9Vd
         v6NwR5AaXVwPgZ+bX4JbzuLmH5zA+vKl/6YCQsxVqzv1b/p9a0ex6b7l3/o6EGJ9NU+j
         ohe/EJWixmDTuXPcL0RKN/OGmoO3Yfk6oRp9nkH3ydnAm0XrT6JWbPzxRJb7lXI4uXy6
         bfkXHDYbAnSuXfC0HN0nzZaqMFFQEno7fVECEMFsa8sceA0YV5ImJmfNMBxm2Ms6OqHV
         3xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790232; x=1796395032;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tWNqqUhi+1+BXB18Sy8VdaElJpWatihymQrBKDZIAhs=;
        b=yitTb/jNAh0pJaarsVeNPkzDeogsynmL2U3Dzwizp8QeRVL8i8PJma9/TsoBBYsKU3
         8CypFItFpQ8WsLko+VKlZ4a/THwdgWNyMYC9sJmo0UiQWZasxIZr0RhATp0Ym6I7PsDW
         PB8mZ1y5XNa9YPnW1r4zq9dXGXhqtltnLkZtmzOICubIQTDMqs/VMSckFbQPu9cWAlqC
         6Os9XorwJip3eSEL8f18kkfwFN+ReqvlugpZPAzK+i4JSwsUP0RDhG+O0StrP2Pd/22P
         Oz0OZle6IRdh0Meb4OZAuOmZ3baJWfpYnB14tALwNt5UENRPSFODGt3EdhgHxhRsqRV3
         o+Tw==
X-Gm-Message-State: APuU4Z/4NnFTjDGSSwKgund+Q4BoQiEqQm8Hxj5UcWh/EsFQ7cndFaR1
	5kR1fNrxl1ZxzHaJR+62l/dAPL/UTxX0SkqKsQpmdbXtQoVCS38c1JP4RLglrRPdoCrEDe9/ZEr
	BQ5uiyH6mJ0gi+s1U6sCuM8DJDuS/LAi5VJk6/OzoDorx9oYVYWGJs6sHA/pPBl6gVzr6SIk29Z
	vHKO9BNaSRZk5+g+RrBMd1zA2lZGixQnuC1Y5rYe/VvLc+Qw==
X-Gm-Gg: AZFdTZfOt296JigirRIFTsZaTGroKdgdFSHbsD2GMlE8Mv6DIhSYz4vfFVP1wCveJn1
	QKP8uYblsBYbb8RLha7OrZtn9bKzxFaw+knQjYid/YScUE8lXHEyF+Dt6O8cOyOjSO7JWfOobkH
	y8urzJR3zpnELdsfSVgbs7PSyTObmI2BEA1QIUNZHlt8n+cmkjAbMGIPHHxQ==
X-Received: by 2002:a17:90b:4a48:b0:3b3:af45:6a6b with SMTP id 98e67ed59e1d1-3b41c7b5e76mr24825960a91.3.1795790232107;
        Fri, 27 Nov 2026 06:37:12 -0800 (PST)
X-Received: by 2002:a17:90b:4a48:b0:3b3:af45:6a6b with SMTP id
 98e67ed59e1d1-3b41c7b5e76mr24825891a91.3.1795790231581; Fri, 27 Nov 2026
 06:37:11 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125182053.3915833-1-kamal.dasu@broadcom.com> <20261125182053.3915833-7-kamal.dasu@broadcom.com>
In-Reply-To: <20261125182053.3915833-7-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:37:00 +0100
X-Gm-Features: Aa3M54rA-JO2YKivrqSDVD5rGdTwrKCSYiQ6IpwpRh3i5IBbuLuwM2MCvKhsdJ0
Message-ID: <CAPx+jO8cJD74g=u1bHEbFVDe+KuxfspukP0VKmhgOC=dEr0Ppw@mail.gmail.com>
Subject: Re: [PATCH v14 6/6] mmc: core: Add support for resetting an eMMC at
 system resume
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Shawn Lin <shawn.lin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX/96Utw+gMNOv
 3Vr3K6E+AmXSAnNnpw0GfbT2w/g6yuZkePf0Fj7p+ezpV3ESvLOL0biJ4D+2/r0N5u+ujXxNhgU
 29Yk5xnE68KuW/ErKJpLVaGaEP+P+XyeFPDnUuUodMpPFnDcyult30k8hehbPUYj9p5if6tALxo
 nKqLoNMklE9X7b/JvIhkw+zLoAy7doBT4SR2V2+he+i64WkBRtyn9Rn9cYZ1KBaS5Ss98wgmH2/
 YvPbXXxZ+LMskT/kAUtqr7zXNvk4QnY0PCUCzRL4N6VMjAHxoQWNXmHNG5TJbqgJT7CIyFbb5k4
 QSswsmTgAzU4U5okSuCC+j+lVim7OrhgdUjW9I2p54fEOzKnaboED29DDvlR0cJvLzBlc8BdRiO
 YIb3U8XNX0BngShifGr8F3ErFZYdr7VQh8d4vVcIdh5Bwk0Wbo62dXm08jRfeJe8EXUbVtHvd+Y
 J5yNruWhwAOpfnrimww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX6hu6zWf5W9t6
 utIghDjhhqzYZOsytuiJoVMXYKqyak+FOgzbS61q2GI+OIe4lWplh4IhkWneEX5WXxU5ElP2Nz1
 HWUXlIk4HIWnzKhOaFmgPgGNfWphg8E=
X-Authority-Analysis: v=2.4 cv=ebWo7LEH c=1 sm=1 tr=0 ts=6b099599 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=Q-fNiiVtAAAA:8 a=EUspDBNiAAAA:8
 a=r6S0buWGwmKu9fT6DDkA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 2cRfvnSHvccmwdUtcTKPi0oG1JIdynFL
X-Proofpoint-ORIG-GUID: 2cRfvnSHvccmwdUtcTKPi0oG1JIdynFL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

On Wed, Nov 25, 2026 at 7:21=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.com=
> wrote:
>
> From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
>
> The DT property reset-card-at-resume specifies that we need to make a res=
et
> of an eMMC card at system resume, assuming it also has stayed powered on
> during system suspend.
>
> To implement support for this, let's start by parsing for the new DT
> property and set the new bit MMC_CAP2_RESET_AT_RESUME if it's found. Base=
d
> on the property, we must also set MMC_PM_KEEP_POWER in the pm_flags for t=
he
> host, to keep the eMMC powered on during system suspend.
>
> Finally, to manage the actual reset during system resume, let's extend
> mmc_resume() to support the needed behaviour.
>
> The property only makes sense together with keep-power-in-suspend, as the
> card would otherwise be powered off and system suspend is refused. Valida=
te
> that in mmc_validate_host_caps(), to make the host probe fail upfront on
> such a misconfiguration.
>
> While at it, claim the host around the reset in mmc_resume(), as it sends
> commands to the card, and propagate any error from the reset so that a
> failure to re-initialize the card is reported by the resume path.
>
> Also clear MMC_PM_KEEP_POWER in mmc_host_class_complete(), as mmc_resume(=
)
> isn't invoked if system suspend is aborted after mmc_host_class_prepare()
> has set the flag.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> Co-developed-by: Kamal Dasu <kamal.dasu@broadcom.com>
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
>  drivers/mmc/core/host.c  | 26 ++++++++++++++++++++++++++
>  drivers/mmc/core/mmc.c   | 12 +++++++++++-
>  include/linux/mmc/host.h |  1 +
>  3 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 8e9e61839198..9cb456a153ae 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -48,6 +48,14 @@ static int mmc_host_class_prepare(struct device *dev)
>         if (host->bus_ops->pre_suspend)
>                 return host->bus_ops->pre_suspend(host);
>
> +       /*
> +        * If it's required to make a reset of the card at system resume,=
 this
> +        * indirectly also means that we must keep the card powered on du=
ring
> +        * system suspend.
> +        */
> +       if (host->caps2 & MMC_CAP2_RESET_AT_RESUME)
> +               return mmc_set_host_pm_flags(host, MMC_PM_KEEP_POWER);
> +
>         return 0;
>  }
>
> @@ -55,6 +63,15 @@ static void mmc_host_class_complete(struct device *dev=
)
>  {
>         struct mmc_host *host =3D cls_dev_to_mmc_host(dev);
>
> +       /*
> +        * MMC_PM_KEEP_POWER is set in ->prepare() and normally cleared b=
y the
> +        * bus ->resume() callback. If system suspend is aborted after
> +        * ->prepare(), ->resume() isn't invoked, so clear the flag here =
to not
> +        * leave it set at runtime.
> +        */
> +       if (host->caps2 & MMC_CAP2_RESET_AT_RESUME)
> +               host->pm_flags &=3D ~MMC_PM_KEEP_POWER;
> +

I think it will just simplify this a bit, but there is no need for you
to send a new version. I will update when applying.

[...]

Kind regards
Uffe
