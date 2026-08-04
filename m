Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FA04519B2
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785841374; cv=pass; b=BfgiEM1jmfd5V4OYRPzCFdjoXhfKZBiJ2ZoXYurVgWIUaJf5Vm+Los69gWw6yF5sB7NAQLbTrqU6d2xxg11uwcxxA3HYDQ1qnldEaycDm8bdsHi3bloVSrfQes3XCUvfmGovkJn7knlO+7NOuq3PWcG6Rka8Kju8bG2QRqmKcyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785841374; c=relaxed/simple;
	bh=pvfa2zQPt27/egsVTaH5BIj3J7J+6hv2mqtI6MlTyTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6I0aSNOQlHUoPyr7zP/zWkC0XHAz9IsuB0TD3tX4cSo1y2icq2KQ9HO9KSbeQB67wc2Gi/HLQVk5kCv5Z5wnuRWNO+xZJu+kkl5l34+HtB1dx/HLozhqHi4Kef9fy/jMJ//rQ5+GOaLtoiLgcu9+n/VOXXxWjMz7YxoUuxVRpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mw8KMRYX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KteqKMyB; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mw8KMRYX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KteqKMyB"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748C4N23016278
	for <linux-mmc@vger.kernel.org>; Tue, 4 Aug 2026 11:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RxuMNOUsm5PWH6LUewq8G6NpcCD3wQ0J7nbDQgaEG70=; b=mw8KMRYXLA46Qr5/
	HPz5HgmKgKsyKXkvzhxtP7ie7Mp47cOnx9nENwa+HHglLjT8o7Bq/9vTRHyP1mQ9
	omn38PXswNX5lvR7/3F5L8NVGPHmYsbD4kvj7qTsRlEUeazsAZwvUTWlYXYzSV9F
	VaBnqKORjCkCEnp7GHWhG4NbhYpYVE91JX0yfgv4Ez7lwoCyRDKmyxg8c0yCk+Si
	cWpVeaU7rqoOKkhYyvXpi18xgfyk0c+aa7Jje3nm/n66ewDebSEXW0udKaiaFDPL
	om0opxJsC+JnNF49UGYtP1i/vr6XhAnpa7LeP5UTmE/1kOMG+Rce/GtdkesCJlnS
	N5VHtA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu72720mx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 11:02:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930b6bdcb4fso653566085a.2
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 04:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785841371; cv=none;
        d=google.com; s=arc-20260327;
        b=L7YRb+pVkINaqDBATol6XNYnZtOMj7sPQkNnmxYZS8Yffg0tpP8GCeLYe5bf/Y9iZC
         x8VndTfmKdMiazhDF0d8/Z7o58Gc2Ys2RkxCC+zQelTC/OiDAq+uwsfPj7VE4wIHzODD
         Tj57MwduYABxJQyBA/AFFkzE/0G5NIIZHzV5tAr5lSUR2o7XSnSwuh57XIA0BLrcv/gL
         44/4xo0jgTcpvw5tyFZRxb6WjchrB7ISMck4Z3UJF/zxFIP1Yd/J0j6mA5FhTokstrEl
         37aBPyYvR7wiU+1Vbkvb+IoqDDJOtPKSOeqaNy1xIQpeXC2cjlzqVSklxf4WBtfKA2vJ
         8OGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RxuMNOUsm5PWH6LUewq8G6NpcCD3wQ0J7nbDQgaEG70=;
        fh=P5WscGyLmZ9L4opZoXl6KggHpUTuE2BueJqpAY/+FwE=;
        b=YqLaSizJaIRUFlDaX19M7yRlCBvrI/thJHLfpnN2PyKDoqrR1X5zKZuAYrC2NUPHS2
         INjFRQt6Y/i3T6gv8I3Ala4cs75ligjCfSrPTdTNrKeNacBDGXLJF7lgMPPlW2twwBqj
         4n+rChcncH7f1hLbW0FNSQckvolJZRjcOtzvMk88FG7nvK8c8thOLr0/2kk5r3DJ58dx
         I749/uHVHnVlu3F54ehLsS23xNLMtqahXFN/KSGrpnXmRbpBA+PUtp+NO7Eq5dBX2ehT
         g6d8rrUecCaQkQYEPOLcNUSFBKHF/0KlK9H7atdjNySBTYklOS9oWsTXOyf7FsI1j8G/
         V8xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785841371; x=1786446171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RxuMNOUsm5PWH6LUewq8G6NpcCD3wQ0J7nbDQgaEG70=;
        b=KteqKMyBjz/eeY7/scA5ueEzgbfj24yILNqHUjaIKgHKUDwgg5b0Ojl1ZW/dEIxzoE
         C2ug3booNT1CX1D4nuBZqlWryVW2Kr6s+w3ssP5M/d7NgJEywUmJsmzeVsKWKCcPOY76
         TWmdlRXbW+wq4ckaydhcR6vDKYaYcZQ4noXRGFmqQqR5jLebqLTJu+UUhUj8Xn72u3p2
         NpWMaqGyvnqKhhuYE0ry0Jd9T3jj8jWdQVvnQpQb29IIpHDbvE0JwZ7WesUaUbArdU8o
         p22TQtugvH5rGYVNoBxNz3yAAQcquoHLtq6K9MiCUTKgAgaVuKOiKUVXt7zIa88JBkN8
         jjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785841371; x=1786446171;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RxuMNOUsm5PWH6LUewq8G6NpcCD3wQ0J7nbDQgaEG70=;
        b=K8QKMGbNQ3sPPC6hPFEfGEqpAugfEEy7/H8bXei/Wd37q863OzmxWqv7iA3twjpoDc
         HojrndxnzY/3GpzrBDWXxOKeZd5qZ7FegVPf92N4oIRDalqsFmIXa4lC+rfzvHGYHOta
         L7tJ7MIpmxYnLBKJqDrpIgfccHgzEZOgbKU/sYuMUqGXx9d5met/lclGDauily+gd2EV
         iAolEt89uaucN5OnXxaRgYTsFunFO7csdHJzf+3+hmMlfsyiIW83c7dk1mqikJj5XEiw
         UOB2OLAGokBZbnlboPUuwurFzEFaVLemXEeZd5qbR1WEe9hO2JPTEnggavP/smIjsRuy
         zu1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rocx76TM1jyKx0fOn71EourZiWlVpH5A5uumwTYhDAEGcU1qkcUrZQEnsy+xyiJdVDr97yQzo8zNSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQXMc7o7GrUYcYeVyW17XlJ9oJZccSN8lIbe4yZGqLX//HMSz5
	VfF8DU2OmEij/CzqlKpNNx4fvW/HuQpAITRYpIDN6ks3ASZMdjJmtaXFWuN+2VY1ymT6CmkhcB5
	e/I4ATv5MAOeIYJcFNqYRnzDY1gX2pzB+nkHAtuWVg348ug7uDYwaitJ4Up8NYlJmCH0/F0gXet
	dw6fWF7QFQiOw3gLyKHc7HAhM6e1Abex3L+/0R1g==
X-Gm-Gg: AR+sD122ozBp6V/9LCdYT/MkBdGzbA38LoqpJkEQSqWs8F5gjJWBiqd/TvHNQmrbf+C
	SwlYJUKZ1feX0pyh0efDQS7KMSYJ69J1wUwv4NAywpt4UMnE+jLeMnEUEQU1X5NS+LVqLdtNK1P
	o2lZsRCFHf6RjqottWnhOsd4b+tlNyNhXhmWQqOLiNglmydy16KbT4k72o/A==
X-Received: by 2002:a05:620a:5687:b0:92e:9d63:a6f6 with SMTP id af79cd13be357-934a07a1795mr1767200685a.17.1785841370479;
        Tue, 04 Aug 2026 04:02:50 -0700 (PDT)
X-Received: by 2002:a05:620a:5687:b0:92e:9d63:a6f6 with SMTP id
 af79cd13be357-934a07a1795mr1767192185a.17.1785841369878; Tue, 04 Aug 2026
 04:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722205701.372789-1-jm@ti.com> <20260722205701.372789-4-jm@ti.com>
 <CAPx+jO9w0utg5BhsKnUSgdCWeM1prOqoV0gCrTpaeuaWZouXoA@mail.gmail.com>
 <307ee173-81ae-4434-aee4-9ddbbc9e6890@ti.com> <CAPx+jO_3tHk7KWjRs2dCBJC8j9FnKz64Fp2BtcmKSZSTNUGd_w@mail.gmail.com>
 <c5ecd0b1-580e-4447-9459-f7455fa6c448@ti.com>
In-Reply-To: <c5ecd0b1-580e-4447-9459-f7455fa6c448@ti.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 13:02:39 +0200
X-Gm-Features: AUfX_mzCpUo6JfNMY_DeytVj6b_23n6B8Knpsj_umOmJJ48Z32F9C_Gkn0OihFM
Message-ID: <CAPx+jO_Yc1rBcxatzByy6cWAy6JdXcLXqkOpFbAKTcEsK2ASXA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: core: Add power-off-delay-us support
To: "Mendez, Judith" <jm@ti.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4NyBTYWx0ZWRfX8X0Y7GUcnSRo
 QbQOFIsh4fbsxec6tXwJj6W/P9BDHH6/5kcVBgDWPxZMihC9i/uWt5SEamXfmcHqPa1it4lg2p0
 cHr4Sw7iJ9lCKoJQDyGuO6bxIknAxw0=
X-Authority-Analysis: v=2.4 cv=Z6Lc2nRA c=1 sm=1 tr=0 ts=6a71c6db cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=sozttTNsAAAA:8 a=4rwqBcRinW2UmxHnGOUA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 0IAMlX16RxQepNa8aeXMBH7Ocpk1GYbO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4NyBTYWx0ZWRfX54CzIz8rn8pS
 NnJQjt9lq22mdhUB9bNPEZh/BRHtOI3i+9RqqsnfXlZgGOMNXneWksthDyBmBTc9n/aRvbnuEqV
 M/omCQ03UsFxlk2f66HTG6BDdBc0wCp5IfVTcTon4GW5yDKgVImndkcbNva27sYMKVfzGEfIwfp
 kGTWSAjm1o6dI8MhfZMiZ4yTZasJnfuZKhJqwJ/Zv3d+nT92LSq9QZbaR4THJUCeea5OHi9jeKB
 +dHK+UyDsMEIiWgY9YVgCs7om9XEvcXwrBLS2K+ECYL5zv5GoENbeNNV9Sqe+EiokF7HfLbd3+F
 yY2k/Qsf4VHw2V1jjLNR4K6BuhZhv/NWma+4ot9kGgW1U0P/sYMtw49a6PcEed4SiC4/jvoNSR5
 AVC9a+JRSFpSKaBvqmg2gwuiLBxVQI1UCBmd5A/zGQIDWlvM4Vtgh0hP0uP2bNo8nJKN8+czJwk
 6bg06frLI0LnzxJqSjQ==
X-Proofpoint-ORIG-GUID: 0IAMlX16RxQepNa8aeXMBH7Ocpk1GYbO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040087

On Mon, Aug 3, 2026 at 4:31=E2=80=AFPM Mendez, Judith <jm@ti.com> wrote:
>
> Hi Ulf,
>
> On 8/3/2026 7:27 AM, Ulf Hansson wrote:
> > On Tue, Jul 28, 2026 at 11:56=E2=80=AFPM Judith Mendez <jm@ti.com> wrot=
e:
> >>
> >> Hi Ulf,
> >>
> >> On 7/27/26 10:16 AM, Ulf Hansson wrote:
> >>> On Wed, Jul 22, 2026 at 10:57=E2=80=AFPM Judith Mendez <jm@ti.com> wr=
ote:
> >>>>
> >>>> Add support for power-off-delay-us which shall be used to specify
> >>>> value of delay after deasserting power during MMC power cycles.
> >>>> Default for delay is 1000us but custom delay can be passed in to wor=
k
> >>>> around hardware issues such as slow RC discharge on MMC VDD rails.
> >>>>
> >>>> Signed-off-by: Judith Mendez <jm@ti.com>
> >>>> ---
> >>>> Changes since v1:
> >>>> - Move delay to mmc_power_off
> >>>> - Fix dt checks and remove print
> >>>> - Move from mmc_host struct to mmc_ios struct
> >>>> - Rename post-power-off-delay-ms to power_off_delay_us
> >>>> ---
> >>>>    drivers/mmc/core/core.c  | 2 +-
> >>>>    drivers/mmc/core/host.c  | 8 ++++++++
> >>>>    include/linux/mmc/host.h | 1 +
> >>>>    3 files changed, 10 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >>>> index 29e80e5f928e9..9472041fe1c20 100644
> >>>> --- a/drivers/mmc/core/core.c
> >>>> +++ b/drivers/mmc/core/core.c
> >>>> @@ -1388,7 +1388,7 @@ void mmc_power_off(struct mmc_host *host)
> >>>>            * XO-1.5, require a short delay after poweroff before the=
 card
> >>>>            * can be successfully turned on again.
> >>>>            */
> >>>> -       mmc_delay(1);
> >>>> +       mmc_delay_us(host->ios.power_off_delay_us);
> >>>>    }
> >>>>
> >>>>    void mmc_power_cycle(struct mmc_host *host, u32 ocr)
> >>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> >>>> index b7ce3137d4529..fac50a2860211 100644
> >>>> --- a/drivers/mmc/core/host.c
> >>>> +++ b/drivers/mmc/core/host.c
> >>>> @@ -421,6 +421,13 @@ int mmc_of_parse(struct mmc_host *host)
> >>>>           device_property_read_u32(dev, "post-power-on-delay-ms",
> >>>>                                    &host->ios.power_delay_ms);
> >>>>
> >>>> +       device_property_read_u32(dev, "power-off-delay-us",
> >>>> +                                &host->ios.power_off_delay_us);
> >>>> +       if (host->ios.power_off_delay_us < 1)
> >>>> +               host->ios.power_off_delay_us =3D 1000;
> >>>
> >>> If power-off-delay-us is specified and the value >=3D 0, I think we c=
an
> >>> respect it as is.
> >>>
> >>> This means we need to treat "0" a bit special and bail out in mmc_del=
ay_us().
> >>
> >> Ok, just to confirm, then, you want to drop these guards in mmc_of_par=
se
> >> and instead catch 0 in mmc_power_off?
> >
> > Not exactly, if mmc_of_parse() doesn't get a valid value (>=3D0) when
> > parsing for "power-off-delay-us" it should not set
> > host->ios.power_off_delay_us, but rather rely on the default value
> > that we have set in mmc_alloc_host().
>
> Ok, so
>
> if power-off-delay-us < 0 -> use host default
> else power_off_delay_us =3D power-off-delay-us
>
> And in mmc_power_off(), if power_off_delay_us =3D 0
> what would you like to do with special case?

Well, we need to bail out somewhere. :-)

I guess mmc_power_off() will call mmc_delay_us()? In that case,
mmc_delay_us() could just return immediately if the delay is 0?

Kind regards
Uffe
