Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81261403E82
	for <linux-mmc@vger.kernel.org>; Mon,  3 Aug 2026 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760057; cv=pass; b=QyjhxMjGO21TBtm/tl2+BHlQnsUr8DRg2Br1YK3aDZBLZBR5K8MxfgF9MrqqG7E3tAW521jMkJrLHpz3FdwTWvzYvFAfDZm5HuCRV9cdwEw6Ms14AVb1IG4giwfK4Os7vgKcSopOuOlz5k/eI5lvT6RC+SrAyd0hI5x0/vm8DxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760057; c=relaxed/simple;
	bh=8t2b3lxGnBqDFg9CDbFOnXkf81lMov01xY50g0Xv8iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+5dmsuuGm6OT/OepFhys4yk55+1P3/siuQzBztIbd03oUJG/4f9NXby/krp8zBDwgeP1zb4DS+t+h//e9Oznavdv/tzUmzsn3qJLsmzWb3qqumqfYg/xSQfaW6RZpdc+MGPwsbErAp9EAmOfYccyQtD7MPatbtLqHOhDoJLiwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W6wIsQB3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kAtLPsIJ; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W6wIsQB3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kAtLPsIJ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673C4rSs365354
	for <linux-mmc@vger.kernel.org>; Mon, 3 Aug 2026 12:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IL0YAibvI8JaOTIvCw3rwIszIsz9z2Uq9frc097mPdo=; b=W6wIsQB3x36xZBAD
	FkMv8Jk9VXjvqUSzPWzZAYxQhgS79qzFdKiO3ZvSO/3yLLiA79jDT/V7hRrDpnIK
	RisUQ61t6/Ws15jOJ5UNnYKYSmHz1P94L6HIO9q6aHG5AF0j/RcXJUpVMr4q/XWx
	XdXfj+S3lKAZ6/A5jIRzFvcZeSxVRrCNWFzf4003NSKgTCs6ovzS9ShcJSOQdG/D
	TJDT0FHdu6VzBYNu9ekXW1o3G2ySt3qArg2vlQ2zP3XojsFZmKhZJtjZbZ16HrDF
	309b8iYMmAECX8CgYCMzNQA8JcBvJR+xdE039zxtOhT0aPjPZvF6hudh6LCTYLjQ
	Hw1MOQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrnsf3s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 03 Aug 2026 12:27:35 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-904c1d588bbso35517826d6.0
        for <linux-mmc@vger.kernel.org>; Mon, 03 Aug 2026 05:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785760055; cv=none;
        d=google.com; s=arc-20260327;
        b=TP2eJJd5TGYqxFKYSA3vKo3cWwlassJCPRUGvhGSo76yNbOil/B7LcS8ut1Lu6hPua
         bCH/2Zj/y+4/QHf/Wl8Iu0O5v8wcNOPk8VHlXQzyEgR+J+VcRU2I5SO1hY8AwuGAHqnB
         V9hcQga7/KUgKJF9bee8tw9PmtLRLYQE1EtXWvnqY0S+XhHrFgUOUbd1cfQf5S+iFJ3D
         RJIhOCovzM+oPgnUnHlz0zjFFiIsydXVsaqQowJFfJcBehaEsxwWHHMvc4YAwybe/FMw
         yIB/+v0dZgoC3FVUnetX+qLXEZ+LlIYZmlTKlaeWPlEREnFCwS8zxobbVnZ+8mbFZFXr
         69Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IL0YAibvI8JaOTIvCw3rwIszIsz9z2Uq9frc097mPdo=;
        fh=qNB4nFBpCNOCSbt2vsA5F3E7/GFFVTs9eeCftLUu+Pg=;
        b=m8V/Vxu95g0K2fkZDOlNcul7uaM9RajKPe4RDJhJIJEUAohc7ppzSM9hVThfkxxfzW
         3Z0JOC38gjN0pCnOVGEoSIhqU6TnbSXeau1C+RgdI86hDAfu7q3JxziIzoLacUn5g5ak
         RLF/n0TnQRmlre1csZUGdZ614SWF+AUFGCMfAZhX0GTkyP9dG1pKYqCOdk8oJGTS253B
         cI5sNCUZPzrog99mxUctRDhl1tPr/5kPUid8FliU1D4x2HxZmSzSm09iHsl6YsK51HmF
         dmKT6scSg0MK9JM+cBN6uba2U4O59BVogwd6xeg2o2Lzu7V8yMI4kuwbLqDJxUj+i4N3
         BYNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785760055; x=1786364855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IL0YAibvI8JaOTIvCw3rwIszIsz9z2Uq9frc097mPdo=;
        b=kAtLPsIJI+X7netUihQh8LlbWQ6YbvzR6rYyc4XVspIeDR9BYL43NuXfXRa4/Z3khu
         QgG/HbsSJwL4kSc4w08ZYo+51/b+IxI2RfhW3oTNVKEFuHEZgoWquK0r69JaM8xrdPbX
         9MliXxo7XLxxLkcPRV1Cb631FYjynNSHtwb44PLJkparnpRTB5DHR9eWAWJr6S7aU8ay
         dutTKkNu7J6pv9qtyHMcQR+olRKnTKG+b3wWxr9wB8CTIQh4b4xZk70jOJ0xDm6q5S98
         /PkOqkto1G2ZPwy8OszuJpdTID5rkUUa4JqGcyQnUbXUzQ/mTnMJfEAykubFy4icHhMw
         qjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785760055; x=1786364855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IL0YAibvI8JaOTIvCw3rwIszIsz9z2Uq9frc097mPdo=;
        b=Ag/cCbuSSWeyfYRO1EDRvO92+GPouAwcnj08nnkDsNW6wfhJC0/TRFTCnjVSePQqqv
         j3/RDwX363HBDIofKtMBFpeQcwO8x6MgNr/wEwYGbPwtJ7DimgqdrEMLw8BAUdatyRmV
         WsOYUHJb/MycArHDO0kBYOSHxbp/3cAdqa1ALr4s5xhgLl+E8YGM55Wib+XKt61Yusn8
         DVX3RMm5VyGMfopAv8mJpYjTenpwmd11z2//+tEzbrzqlKlkJgazygju1pQq2b/VFCdx
         JFYOX8hPZ2UWz9F5hyvFj6a6UGDDeWX0yoCF9rXuFz5TLqvDTQOJpJ3fvBGBjpBOdqrc
         KQRg==
X-Forwarded-Encrypted: i=1; AHgh+RrAGJBBzEVmBr4d0HZtrFDQu5RDr3J9lGjq5jsxwXasPG0bkkU7EOBPyTTD+MZt4DbzZ+lx4o9e7Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEl/Y2AboSM++Vbu9dkB6rpbsqtMzbF9i6FuNMDmomo1QcuE+l
	nXI9krDfWKvJRZg4S5jzJtpEhH/PFp3ToYQ5FFcSPlR1w1Ky/q4HMMyATQyDKmQtowmYB9YRoDC
	1H1CbptphSbAyB6X4TDm4T+hs0X2U406c1dg1sdAGulPWwm7POln4qz0YPN+wCiBgyfD+4KOEwa
	gh4pZzX5R4+qCoMeLFBJPPT9iDe16RyM5xXQW9BA==
X-Gm-Gg: AR+sD11BtjoAnRtJgoOhgUbtja2EVTQZHxfcjMZVa5ooFK4sxhb773LJFHFKqM/hLbb
	8b7SiPWVPlmcS9QklTCa9dGmLQgOdQwifqeuNw7elwsJB8MeeNEUadgpLzDft/KUgoz5x7F4aN5
	XVU7nYX/UcDGMmcPsDblPxdW+b6Xfbwuu0MNF6ZCmHq6wbjlQjmA6L9zc5nw==
X-Received: by 2002:a05:6214:848a:b0:908:488b:14f with SMTP id 6a1803df08f44-908488b0344mr226428206d6.5.1785760054460;
        Mon, 03 Aug 2026 05:27:34 -0700 (PDT)
X-Received: by 2002:a05:6214:848a:b0:908:488b:14f with SMTP id
 6a1803df08f44-908488b0344mr226427396d6.5.1785760053927; Mon, 03 Aug 2026
 05:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722205701.372789-1-jm@ti.com> <20260722205701.372789-4-jm@ti.com>
 <CAPx+jO9w0utg5BhsKnUSgdCWeM1prOqoV0gCrTpaeuaWZouXoA@mail.gmail.com> <307ee173-81ae-4434-aee4-9ddbbc9e6890@ti.com>
In-Reply-To: <307ee173-81ae-4434-aee4-9ddbbc9e6890@ti.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 14:27:22 +0200
X-Gm-Features: AUfX_mxc1kMmSPRDF-FoVDCOaaiFmoNXRpwiZNTqei2Fu-2tdARSI0YMPYEGSSw
Message-ID: <CAPx+jO_3tHk7KWjRs2dCBJC8j9FnKz64Fp2BtcmKSZSTNUGd_w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: core: Add power-off-delay-us support
To: Judith Mendez <jm@ti.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMSBTYWx0ZWRfX2EVy+PjpKJqy
 WvBNekJX3+Cz0ZqPGlguTNDOIOgjuDOb1BFFBCy0sPpe7MrGpoUbN2zogKgpN/UkeeuvHh7foif
 E3njeBIWG1nrHM+PZY8//HleaXuDrbs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMSBTYWx0ZWRfX9Rm7hsdZa0YJ
 YpQaqVJ9TmCw8Oxr6f4aTnHd6jPytp8V6LIq43Oiro0q6STqs7nfvik0CFbEta6xSHlcGIy/oY/
 rEyNS7sw5NhTY/pucKJm3HqPs3829OqTB5LJ42o+tb+gIVJL18ucvHcHA8HGv6iSdJ1OTY04t8e
 THZmH9ZE28DiQrATqq4f6B9a0u6831KXyesFZlhVmF6eRrtMPdirmQT6fDspaMALxF1j+yEQEVl
 /CROAEpyW4PSGmW7DTK+u0xgqki1RFqGzDvIDIcUu6xSkDCZPrIk6y0KrJJjC2XKx4W6NaDJWvm
 QJ8XpdAdX4S49WXTIHIG2QKRdP9tsY5vYLc3QXNwRCM9JLsTUCsqqB65q1Cnnz/gASZsx+Xm025
 E/we09AmZgyoNpiO0wXO9mTVM7JgGhOdSafRpXdsfmsOZ8GUTFSJYm/BTozGyOw1QUS5xe+5RG6
 WD4P8cWjk2hWuah96mA==
X-Authority-Analysis: v=2.4 cv=Zest8MVA c=1 sm=1 tr=0 ts=6a708937 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=sozttTNsAAAA:8 a=ESAVbi1KNat6v4_x51MA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: uhCN2I6XNy6y0H3qMQcZEe3KLaU2KZ8z
X-Proofpoint-ORIG-GUID: uhCN2I6XNy6y0H3qMQcZEe3KLaU2KZ8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030111

On Tue, Jul 28, 2026 at 11:56=E2=80=AFPM Judith Mendez <jm@ti.com> wrote:
>
> Hi Ulf,
>
> On 7/27/26 10:16 AM, Ulf Hansson wrote:
> > On Wed, Jul 22, 2026 at 10:57=E2=80=AFPM Judith Mendez <jm@ti.com> wrot=
e:
> >>
> >> Add support for power-off-delay-us which shall be used to specify
> >> value of delay after deasserting power during MMC power cycles.
> >> Default for delay is 1000us but custom delay can be passed in to work
> >> around hardware issues such as slow RC discharge on MMC VDD rails.
> >>
> >> Signed-off-by: Judith Mendez <jm@ti.com>
> >> ---
> >> Changes since v1:
> >> - Move delay to mmc_power_off
> >> - Fix dt checks and remove print
> >> - Move from mmc_host struct to mmc_ios struct
> >> - Rename post-power-off-delay-ms to power_off_delay_us
> >> ---
> >>   drivers/mmc/core/core.c  | 2 +-
> >>   drivers/mmc/core/host.c  | 8 ++++++++
> >>   include/linux/mmc/host.h | 1 +
> >>   3 files changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >> index 29e80e5f928e9..9472041fe1c20 100644
> >> --- a/drivers/mmc/core/core.c
> >> +++ b/drivers/mmc/core/core.c
> >> @@ -1388,7 +1388,7 @@ void mmc_power_off(struct mmc_host *host)
> >>           * XO-1.5, require a short delay after poweroff before the ca=
rd
> >>           * can be successfully turned on again.
> >>           */
> >> -       mmc_delay(1);
> >> +       mmc_delay_us(host->ios.power_off_delay_us);
> >>   }
> >>
> >>   void mmc_power_cycle(struct mmc_host *host, u32 ocr)
> >> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> >> index b7ce3137d4529..fac50a2860211 100644
> >> --- a/drivers/mmc/core/host.c
> >> +++ b/drivers/mmc/core/host.c
> >> @@ -421,6 +421,13 @@ int mmc_of_parse(struct mmc_host *host)
> >>          device_property_read_u32(dev, "post-power-on-delay-ms",
> >>                                   &host->ios.power_delay_ms);
> >>
> >> +       device_property_read_u32(dev, "power-off-delay-us",
> >> +                                &host->ios.power_off_delay_us);
> >> +       if (host->ios.power_off_delay_us < 1)
> >> +               host->ios.power_off_delay_us =3D 1000;
> >
> > If power-off-delay-us is specified and the value >=3D 0, I think we can
> > respect it as is.
> >
> > This means we need to treat "0" a bit special and bail out in mmc_delay=
_us().
>
> Ok, just to confirm, then, you want to drop these guards in mmc_of_parse
> and instead catch 0 in mmc_power_off?

Not exactly, if mmc_of_parse() doesn't get a valid value (>=3D0) when
parsing for "power-off-delay-us" it should not set
host->ios.power_off_delay_us, but rather rely on the default value
that we have set in mmc_alloc_host().

>
> What if DT parse gets garbled and host->ios.power_off_delay_us < 1 is
> passed?

See above.

>
> ~ Judith
>
> ...

Kind regards
Uffe
