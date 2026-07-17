Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8637A4B8
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284908; cv=pass; b=KZN+swuprC0I7EJiyZ/kX8Ay8bfAxCyfDjJmoF7CAiMYzJGr6Mrc/Uqw44pc8j/zD1IyuMj5pxxp+qgcObfKYyU2PC8SMe9ovyZHBhUXF9jikAF5CNpeGUWHl46qcWF4kC2IeumaFMzeHos9ieLTgzpeVEVJqjVyfW7GZqSK4P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284908; c=relaxed/simple;
	bh=XrfucVrMCM8oIHYW1+hDEG4ZBglJU7no9wJ+HRtrGl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AENLRGXA3orJNHpD0XhaFer8ICkEm/GsnosAqiMqwXypwMe7JaXxDaB8RVhkhdLPxm1YJaYWD7a2GPtHTdyCqEPOQWnPdy6AvpX2keJAS1uLg7KVsYQ20ExfgS7A9PuHL1j5/Dq2KGRBjxBeHJxBBYbLN+0oLEYJSthMLWDqoxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JjgHOh06; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rd77X5uO; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JjgHOh06";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rd77X5uO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HATM5W1388493
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 10:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ua9pRS/rBw6i3Fo1FdGicEIBWEUHA+NkqLTFoW/Hyao=; b=JjgHOh06IkDjMS3N
	LnFjKlryPprQ9vArxMWhcPsxP1NaKXuHEA9bJL3gcv+4W34/9IDCy41i0o9LEzVt
	aEVSlShgauhDhZLoK1PYyhzwu9Xm9D2b1K5OONYzhrRmT+pZf6RYhg3DzCpAFul5
	PVMSKBSDontyBe8DOgaj9fWn6tdz5n82+L4HjwmFL3vr/aSMABnc73Yz08M6Lazv
	lX2UplD6vDz6p6wudYcDA4lHTyZ8BNb807mq0I+nMxsnj6h8N86E1sb+q+jpSpkf
	1xmVBPTWWPjXyEZ8LQXvbpQjIPegLEuIpmFSS2lwJd32KOXToPF/GONrxeDCMArA
	fw0umw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9p8wjt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 10:41:46 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ee2847cbd4so121776986d6.3
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 03:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784284905; cv=none;
        d=google.com; s=arc-20260327;
        b=gGnUULUzYNurLH4h7Vl3t+BG34MUfdzQNMtOo3fOeFB9BbCwX63sdm9fVaWJknD2mt
         fBiVl0Ooj9nFDb11c7o92pskBXDK8XpnE3lCJ5i2uzriRpgMck6XtJF6gS3wlPc6Uiuk
         cMZEa4WG9AWSjw1e1TT+zn5939MsDEncXS5PZogpwkdehBaGiVs+8j+nkaRGhimGG5Yy
         +wUdh/OEon8WJz8TGOXGUIBer9tdwNbLEr6P7x5fHq1JPgBYbKOtyvkNGcrDXGQ3yRS5
         JWW+tC1OJDpozNzL4Rf0hlmdhjdjXN/OcIXajlngoj4lm0hOlArbLocS3cwzI/nLGu+N
         EEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ua9pRS/rBw6i3Fo1FdGicEIBWEUHA+NkqLTFoW/Hyao=;
        fh=ECapnU6Z99POHFESnjnAYyZbi+D0WGNNNGcBsZsN+s0=;
        b=ONFtSmgg9b0ploAteD6WzkjjYYcz+gBmu1kKCQzc88H0EMRNGqVLgFwBLjr43i9scg
         3iAx9gnKHXDEX/FCj8QukKT3klWEeugqWUk818U4n0erm1Gw4ND8Zqd+3TjdSMugnVi+
         9K2lxRdoEZCYI6qUsJFLaHhYuS+g/rG0zHuBhUa6vOqjGpiGo0vfxSxNGPSFWp/upyuz
         Bkmaln1G/A+dq80bohZV+al8MkHR5FYRNRklD1PAXqv0XQdxtgS1aUerbQ+x5FLS9kII
         XalZXGIRc1PFmyNj/rTYMFKUNyEbFpXB4ZzEMkluqFOgEx7580UUyLolM21uQ9vQscAU
         HXgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784284905; x=1784889705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ua9pRS/rBw6i3Fo1FdGicEIBWEUHA+NkqLTFoW/Hyao=;
        b=Rd77X5uO4ohcqbLy8QVYoe4FD++uQ5LB3dpGq9czcMpmx7x4DoYkDcrzkf5kO9wNte
         JKSpakklKidhA5eVyXQoAYFcfkx5IuX+3RUu0jkkXBnESWlcDDnPSTagu4EifA46tqjd
         j8lxSg10cKZyUfX6mgnIcpVlDuDKQcwMNJYQdFc1ZdELQ/Iz8NvUmBGwoPjBoA6wel1X
         89obAZ7p+sY5vUTbFxtaVysNXZs+EbVks3IYou8vOLxKlAojukKF4iGeMkjAITjmHh4b
         4kL2b7q2BQidsfjjIiSPlb/NyqOZABRL8zHAcskjPvowmgKQWYmB+rFUTCqaO2m9cRUa
         gp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784284905; x=1784889705;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ua9pRS/rBw6i3Fo1FdGicEIBWEUHA+NkqLTFoW/Hyao=;
        b=lS/1o+DurXqQlrM140N36VwTagVp3L17Dd7u3OkdEaIA2U7Q8Ez9Rjd+BhHrD48ie4
         kIKI+ykkxWFcp4M9EIV7Vvlk/aJ6dwL0Sl/+GRH5wvOV8fBd8JAssuaWxKGDzgLqUuy4
         y9SF98pYcVam2QJ5H3m0cpBglTpD4bFD4xH4tlGDgtm5f/XhxctyZ9YuLCIO9RokfdiV
         XQ57s0WzvcyohmtuA8K0O86yqsP67YZvVxeiDCZJEc/IhZ+KKPG/mmzQ9LKRq8q6WG7L
         cNhz9wN+AqgqZudlhRPVU5pTlRjYfzciKzpdBHbBPudYu/7OV0LLer1pCbHrN+HknV6W
         dTUQ==
X-Forwarded-Encrypted: i=1; AHgh+RpOJJrq00z6+5yB1QWrQkpIr46thzho/ZliWHSAIOIVLmapPVrZ4B3kQds1XpvYYgO+A2eyPN+q1uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDHTAdFbOdGPfUVMuHVjGGX9tGVNRJfVLfRwF2hh8yN/IIrQBX
	uRjqQdNTbdBYAympihsrgyP8vvXcngbzei7VtYF/pzPi2jYs18yn6J2z+LuOdizX8h9ZcBQQEld
	jDG7hHzhO0q9nJADPoGmJWYh1lG2tISI2iJf1hJRdx3uFBIRcWpO+cUsMgw+08FyiJK0rE/jFhW
	LMsjFxWZyQMM8Yybi6t/2wZsLf+/Vx0VTMzEaMow==
X-Gm-Gg: AfdE7cnB21nPJWlcSuxrpTw7/6KZaevfwnC+6+CPnLzh/qpL5+i6oZ0uNTFAGK7yHDj
	9vNz1EUCcmYGg3IaVkNArOkFY4IAmCPMuTbpP5LEaEkbEyUDYFynJJPXecGlgulnnJ5yYDS6bK4
	LsIjTnCNT690G7rT9oQL3MZfYTtVF615f3Z/stOuPSjM5UB1L4LNb0niIq8A==
X-Received: by 2002:a05:6214:2dc6:b0:8e9:f62b:bedf with SMTP id 6a1803df08f44-9077853777bmr20999506d6.47.1784284905567;
        Fri, 17 Jul 2026 03:41:45 -0700 (PDT)
X-Received: by 2002:a05:6214:2dc6:b0:8e9:f62b:bedf with SMTP id
 6a1803df08f44-9077853777bmr20999266d6.47.1784284905093; Fri, 17 Jul 2026
 03:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716232641.2659710-1-jm@ti.com> <20260716232641.2659710-3-jm@ti.com>
In-Reply-To: <20260716232641.2659710-3-jm@ti.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 12:41:34 +0200
X-Gm-Features: AUfX_myV7bHFgy62QGyFKSW2TFvxOlR3TbiCr7q5KWVKha-aN4nPTJWJ9zgqy9A
Message-ID: <CAPx+jO8H=J-B-DgXG5Qrg02y2GZDMFr+mySt=oCP5L7WBbzZAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Add post-power-off-delay-ms support
To: Judith Mendez <jm@ti.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: OKt6o3NXdvg3OLxYsnBw2XHDHmiKjWGP
X-Proofpoint-ORIG-GUID: OKt6o3NXdvg3OLxYsnBw2XHDHmiKjWGP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwNyBTYWx0ZWRfX9iKLFLx+8qcP
 BZoW5l9sBUVwnUskK4VhjkhNGFHyUoR/1mky3zdVU4y1gCIFCKv6bBHnq6VLPOUc2h9jQqeqr1F
 m353gah4J6e9U7IaqhLG26qPxXy1tJUx+h5Q+TSnsr8lKsiCpEva7iiixpUecStm5ed04XlkAYP
 IduKvI7+/JAd/yInByvcSfKV8y9vknGUOwk9NuCjPUKOAP+mAfvjjIt1x39BbUqk7n/H4J4aAAs
 GEBbXDuj2SYBUYsrkYE/JeUGhEbDzcMma0zvZt9CV3VW2Q/u63MXV33/OLdCY3xRui7pNxX2xOy
 Lze0boG00ynvE3ER42dtc+SdH76Cssi7NMA0SpYfdQ76DtQzOzqnTNFP/PSSNFHYNOcIhJMwY+4
 mege9kVoHbFK6TWcr6zkV9fHOUykV/YPL5YGQs+A9VYXtV0pzV6TCjUeJHaPZJbvJ5HNUHi3mus
 G0RJ5MJnYl8mqxPI+5Q==
X-Authority-Analysis: v=2.4 cv=TaqmcxQh c=1 sm=1 tr=0 ts=6a5a06ea cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=sozttTNsAAAA:8 a=zrnE107Yo5mwZZ080UgA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwNyBTYWx0ZWRfX6qDBrDn69aQd
 ZN5fX0QxlKosyNYvcbCKH4C5zxKoi0rDMnXmSwZ/mqyQDIASPfUJeqBe48Z87HmmlDxrIuV5ZEA
 FjwpMJQI3ahnJUpFGmggfDzAOTYXcrc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170107

On Fri, Jul 17, 2026 at 1:26=E2=80=AFAM Judith Mendez <jm@ti.com> wrote:
>
> Add support for post-power-off-delay-ms which shall be used to insert
> a configurable delay post MMC power off.
>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  drivers/mmc/core/core.c  | 8 ++++++--
>  drivers/mmc/core/host.c  | 8 ++++++++
>  include/linux/mmc/host.h | 1 +
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 29e80e5f928e9..f9049aaf44394 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1394,8 +1394,12 @@ void mmc_power_off(struct mmc_host *host)
>  void mmc_power_cycle(struct mmc_host *host, u32 ocr)
>  {
>         mmc_power_off(host);
> -       /* Wait at least 1 ms according to SD spec */
> -       mmc_delay(1);

The above delay is kind of questionable in the first place, as we
already have a mmc_delay(1) at the end of mmc_power_off().

Maybe the delay is needed for legacy reasons and because of that, I
would suggest that we leave mmc_power_cycle() as is, for now. In the
end, I would rather see that the above delay gets removed altogether.

Instead, how about making the mmc_delay(1) in mmc_power_off() configurable?

Moreover, rather than the code below, I think it would be better to
set a default value for "host->post_power_off_delay_ms" to 1 in
mmc_alloc_host(). In fact, there is already similar code for
"host->ios.power_delay_ms", please try to follow that for this case
too.

> +       if (host->post_power_off_delay_ms) {
> +               mmc_delay(host->post_power_off_delay_ms);
> +       } else {
> +               /* Wait at least 1 ms according to SD spec */
> +               mmc_delay(1);
> +       }
>         mmc_power_up(host, ocr);
>  }
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index b7ce3137d4529..ea8f36827e41c 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -421,6 +421,14 @@ int mmc_of_parse(struct mmc_host *host)
>         device_property_read_u32(dev, "post-power-on-delay-ms",
>                                  &host->ios.power_delay_ms);
>
> +       device_property_read_u32(dev, "post-power-off-delay-ms",
> +                                &host->post_power_off_delay_ms);
> +       if (host->post_power_off_delay_ms > 10000) {
> +               dev_err(dev, "post-power-off-delay-ms %u exceeds max 1000=
0, setting 10000\n",
> +                       host->post_power_off_delay_ms);
> +               host->post_power_off_delay_ms =3D 10000;
> +       }
> +
>         return mmc_pwrseq_alloc(host);
>  }
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ba84f02c2a101..b751b61b1116e 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -578,6 +578,7 @@ struct mmc_host {
>
>         u32                     err_stats[MMC_ERR_MAX];
>         u32                     max_sd_hs_hz;
> +       u32                     post_power_off_delay_ms;
>         unsigned long           private[] ____cacheline_aligned;
>  };
>
> --
> 2.54.0
>

Kind regards
Uffe
