Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F53B4EAC
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849564; cv=pass; b=W77tmdAyIqR1q4G8ZYaQjIvzRR7WReLZxq/RgpA/+cYaz5RrqfFcwzgYROyoSEfohV3t1hG3NaZS4wzIkYMLd6hOkth9p4FUFeziCMBxZKn+vFJIQ0x8zkjwiCHxjsZ7EQ8S0R26en4isLR0F7mp+QkY1vCev74mSjw55xFOkRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849564; c=relaxed/simple;
	bh=RiKwOhz2rdMC9/aebYm1g33822i4EXTv8wYdbkHCerM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cohp+UqAbA8Ecl5DAZEIkAVoX1LEHGwe1rfDtHaCxgjnFRUxsuVeSqhkG5MgQRH35TVso/4VW2EfLtL29b1zmmWiHS+6lLGLoz0rtDVB9uUqDba7vHTNzwcwyn1o5HAtt4JgPCuAPjoxVZ88jF8/7zqfIKXBpctEfuKn9hLAbJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdR8HRwp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XN24c5TU; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdR8HRwp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XN24c5TU"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDVE92881288
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 19:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=; b=cdR8HRwpOL0F5KGf
	Pa72vskx0M2kP/Z35S2cu0vrb4j+OEKIt6KMM7Th6UonX+P19BpjlUhTk5Li1d1Z
	Y/Wv59ciZPfT/RYaiQrRsZFm3fZPcDfKBwaFfoTbWjAmnFyZj3n9bpk2D9uAq+as
	Zefne9lZYGQzV3whovwFyt/TN8jYz46vzYj5NL0+/lOGbG9MlNpdo0tsMl5xk0yg
	fCV3pDFQVQuR35FiZSvIftsxLo2l1P5E5HN15BL52dlkXhgQkdoSVKvLPz9tpEoo
	i0SPA3tzquu7dDbPf2qsPBmIKC29344dcx2/YoqDcNf3SztycbPjKCqS4n+bRngs
	SWWdJg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqgevq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 19:59:22 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8e9489f62bfso105277636d6.2
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 12:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782849561; cv=none;
        d=google.com; s=arc-20260327;
        b=PphEcKL1kO4LLoH2hC8vfbjJDIyLxWnREYJPBRN7WRVwlR0EtIzd1kW1aSHVGiJqDf
         Ojt4FTlEuOLgnfBuCmNZZ98I2azFweuYRXL7h2pH/s+SxdsNDNYURWp8kTUKS627sdm9
         afAsELSttLrWd/n7/o4mu3/PD7FNIA2d4aKXfAniRMVaycNaxgLiNveHGbj2VnSdVYNw
         7DjhYuO3+qcLiM6IEHUd8tfXPt/KUxD3/zMpMb0SA+AJdMOPlgyQCDHWzJMk8zL73WRk
         cMhQdFC15kuAoasdmstms3a61fBb2uXBvw1ukbq4a2gasEbSJ9nqYpk4A8VheK1YRCiz
         RFLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=;
        fh=bG3sD/zxqrreUte8Ip22U2zzdfZQIiMF1RJXuCFQQ0o=;
        b=UEEOEt59Zq3W1kiGtTjB5tp/gQP/HU+TG0knRnIRPMk67aCx0+1r/cvAXokS6zXT8X
         dz82TB+KwBv/u0W1faLTowV6QkqHwQG1aAiiaIUQ/dQNWfLY55sww73tTO0UEy+8kw73
         ro8txFa/6hcgFi7CTLuT2p5UGR3VZMuVcpNZcVJuV+NuiPOONr5jZ2w0ZPK4Qk8XSgSG
         Hr74JckgjtTWxYrH+zwCM32FGmH9axItYgLShFofxQfy+a6tlHFujLROp7DCxC0zzeBC
         k+Ew+zXl/fudsd0FhKf15xQ7nbMsjKKhr4P0DqkhQpbOQgzkXKauEV15/ur+eP0EaQPx
         0Yzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782849561; x=1783454361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=;
        b=XN24c5TU1mLtMwwVQrpsA3cb+Ec8JVOKflkTLwTXGBmehHakzQGPaN2aEZbPFpbD97
         LJXI7Xi/LFKLihPbM/Ozc33AJiWJHQW3D1ngB20cGK4F0B+mw1KKlsWOORfLOvwYsoe+
         pmnAxjzZ9/JjnTdkln0XJbGOPCH4QQHP6a4M2/WUsRbPfukntEC+Cb5T4b5ddzPzo/1E
         Fgqd0htDz4EopwjnY4LZMQlSDeipFKR95uSEQi4bnEoxNaYVXOfOSGL1EIqOhDX1SE0p
         xMUobMZUWaIXPebd5HgAPV046c5JKpeaohJhunSH/eiRKkNKEPKNFA+8OSveeGfCXZK+
         ujaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782849561; x=1783454361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=;
        b=izQX7NstlsNuu0u650wU662SxXkeUuG/MDZxFsyt5TttpvroYI4R2wZUqcfkN/g0gh
         sf349XHXO6zOszFKoXVZe5a1PGfsP5sG7etaM0TD5EvLLVYqAE3NzKBNLcXuWfq+jw5G
         zynherR6c1/jRkdLrMUaAkYl4Zd0goLeLTjBfifASTbAs9CuH5AOfan76h1ZUI0qYz7u
         DuUNq4SJp6tCpFL0iIaQYlyP9Cu9ob/R8/dh8QriFbSz2FU71SOnTwMvDO4mByGzzY+t
         ykmbXbNWTfFVKALIXjCgtGPbxCpCOhkQimJQOWrd/Ok1AEgtgALCzVQZQ8PN7Z+59KvU
         eZeA==
X-Forwarded-Encrypted: i=1; AHgh+RqI8j/mhojyzqm8+RO9WT+RpJHTDw8kW1LWIb5f/9wecZR32KcsGYSUzPjXZ2YUZRKCK1AjuMHN4Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNh5RE2Tu3v0vILpr1XQJ/GUcd8jeWELP21zGfZJXEV+W4T0r0
	TAMTMOZ9BlZY+VPUgJMJnkSYFb1jYqtHrr8o0MJgDvV0N38S1hpnrMpn6TTpW2km7jRiXI/ersf
	wTwdu1qMkXFNI4BdBQjYplQsURi3kTSbYzKC70+i+4Ec7pbTafoWAkPunpCwFrs7s4UDB0Ys+Sn
	96esG1I32E/vauQZLUxKBywsWneKVYDhApnEFbiw==
X-Gm-Gg: AfdE7ckjJqOhs7I7MzedVU1wr1BdjQTp5WHXhTPTcRrRztyjSlxQoz7rWpxXyOIYw8t
	7vSpDS1eiWO0oQ77MTUjNp04nDwxtJ4X5y5upev1oSTx/qKX4spLfkJGggrfyrZptYyBbozpBND
	lBxI3Lss/2myOdZ0IZge69MxjsxW/fRQeLV+0QevLrCC+y8y+TyDkBbDCv4ggBq4OE9a45YW7gl
	Iijv7osKC7vTG2SRwRprX2Ba0JNKQjCwja43Yzln37h31fe02sAqtkvvqpsPVMVXx9wtQUFVJwq
	H0OTS81RTZU=
X-Received: by 2002:a05:6214:821b:10b0:8ce:e651:5d63 with SMTP id 6a1803df08f44-8f2d1343d13mr25863726d6.31.1782849561033;
        Tue, 30 Jun 2026 12:59:21 -0700 (PDT)
X-Received: by 2002:a05:6214:821b:10b0:8ce:e651:5d63 with SMTP id
 6a1803df08f44-8f2d1343d13mr25863166d6.31.1782849560532; Tue, 30 Jun 2026
 12:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
 <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com> <20260630180219.GA4139943-robh@kernel.org>
In-Reply-To: <20260630180219.GA4139943-robh@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 21:59:09 +0200
X-Gm-Features: AVVi8CcrbqRCRkmYSZLH_ub9JNgkd2IUQmjyz1dD9_QoekOgl29FSB3CCebEUbk
Message-ID: <CAFEp6-163adAq8-H_pCzGnq+Fo4jpyKGs6Jv25j3fSpZg3COjQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] block: partitions: of: Skip child nodes without
 reg property
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: NFaXk149LgFFRn8OIviEYnuuvgAJPYV7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE5MyBTYWx0ZWRfX6KRoOkUXhgMJ
 S33uYROol+uWBls6N9KODVdht41pX+hhDJzskI0Qg0VJg2+CE8TOTrxiEt09Mu09OjtaUXuH0r8
 +YCYt0B1HwUjvmF5WTa8btHDULfU0GmeZ4CdwkFCOfp9di5SGaNEpyQLH5CfJTo4jJKv8Wt6qeV
 11KzQdizDIwwJvr3lKWUGTvc/e55tZjDmTiBdeMu72JkcCXHiotkI118YnngjR0Sv1xTe/qM4jE
 8fS9FEgICb08LL8f7pNnQ8R3aoatcfki+gkC0/o53FWMV0fJqLVusDYyt0xRqY/jHL4EzDUXoXM
 z+5069ZQyos/2SPHJYcA94OmFMWar1C2FXC4hh+Woy0zEzYJjOMP9mQEIv0hIaetHhcXOQw19Du
 Fsbi21XywfW9V6PFRs9Vrq84tVG/vRRG4NuI0LK0qWH7LvqnOKeJjVW6jS+LGoPKhgqgznE2fEP
 E42YuqFYy4rM03cfv6Q==
X-Proofpoint-GUID: NFaXk149LgFFRn8OIviEYnuuvgAJPYV7
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a44201a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=2sLY7anfMaDELvqluMMA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE5MyBTYWx0ZWRfX6X7hmlHpXPM2
 eOGKkD1clvRP0yI6I2xEnicYc5NGaUkZzI3AAL6ZFkg9VWqustpbTp4Kasd46scLqriGRZnhdr2
 UCOPV6uswx5Pl14njPxCM9qSjuniQfE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300193

Hi Rob,

On Tue, Jun 30, 2026 at 8:02=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Mon, Jun 29, 2026 at 10:55:20AM +0200, Loic Poulain wrote:
> > Child nodes of a fixed-partitions node are not necessarily partition
> > entries, for example an nvmem-layout node has no reg property. The
> > current code passes a NULL reg pointer and uninitialized len to the
> > length check, which can result in a kernel panic or silent failure to
> > register any partitions.
>
> That does not sound right to me. A fixed-partitions node should only be
> defining partitions with address ranges. I would expect a partition node
> could be nvmem-layout, but not the whole address range. If you wanted
> the latter, then just do:
>
> partitions {
>   ...
> };
>
> nvmem-layout {
>   ...
> };

In our case, the nvmem-layout needs to be associated with a specific
eMMC hardware partition, nvmem cells can be a simple sub-range within
the global eMMC, each hardware partition (boot0, boot1, user...)
having its own address spaces.

That said, your point about not abusing fixed-partitions is valid. I
initially dropped the compatible =3D "fixed-partitions" from the
partitions-boot1 node when it only carries an nvmem-layout and no
actual partition entries, making it a plain named container node. But
it's a bit fragile if we want to support both nvmem-layout and
fixed-partitions.

Regarding your expectation of a partition node being a nvmem-layout,
do you mean that the nvmem-layout should live under a fixed-partitions
node? Something along these lines:

partitions-boot1 {
      compatible =3D "fixed-partitions";
      #address-cells =3D <1>;
      #size-cells =3D <1>;

      nvmem@4400 {
          reg =3D <0x4400 0x1000>;

          nvmem-layout {
              compatible =3D "fixed-layout";
              #address-cells =3D <1>;
              #size-cells =3D <1>;

              wifi_mac_addr: mac-addr@0 {
                  compatible =3D "mac-base";
                  reg =3D <0x0 0x6>;
                  #nvmem-cell-cells =3D <1>;
              };
      [...]

That makes some sense, this would require extra work for the
emmc/block layer to also associate fwnodes with logical partitions,
not just the whole disk/hw (hw part), Is that the direction you'd like
us to go?

Also, Note that regardless of which approach we settle on, this
specific fix/patch remains necessary to validate the partition node
and prevent NULL-deref.

Regards,
Loic
