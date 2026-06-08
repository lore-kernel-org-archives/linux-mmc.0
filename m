Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8719C29992B
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923764; cv=pass; b=dpq0kKXKTAXj8fBBL1M64aKuFhYLLf2LJ4YOR61cuzfuSYtbjrEd2HJnxKklILy6Z+sul5Hzebs7D+b8UdGMPDmXejBKvsnnJYkVjg+Shs1uvmYMObMh5aLtwvagXA0KNxh66ECe8vp1JESVJ/+6/C8L+FRwbM/+DCNOsKzDhUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923764; c=relaxed/simple;
	bh=vVjU3pwVlqs1eGL3LgvYGVSpYqf3o7An1hUHG7tFne0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXJ1qitRFZxcB9l1PURpYvRjhMXG80dYhZ6mqTogjiAx6GL1jMu3+MT766T1fRTyY50LXg0iQni9csxeDj83UHBU96kSCH4Cud6r/7yXlkEyu95T8AZf0fgkNd5Amevx0O3uYrFPIg48ogTHPLzTKkdj5EiC9C7RptCWQXf16dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j+rUH7yN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FOvDuEs1; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j+rUH7yN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FOvDuEs1"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658BBKuQ3417615
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 13:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=; b=j+rUH7yNKShbdNZr
	MqPeI10vwdoPUpfzUXM9yE67URwfG9f0JDVVLUsjGLRvD/v/a5wWvZlAOk53MIGY
	LjIAmHuiq0Y7nQzBPMV/sLmmLpmTz4Z2Fhhe/9VKFllEevVNCvaKfs8Deh5mgVbP
	XZUGYjS4x+joNYUOgYpqmjey1ARbnX7M9WqpEK2EfdQcRxxz5b4N181GIbqfv7uu
	AHI36YCPoIxY5nEoCxDPPjX9+bOXKPxuxWB9fJL6ElDeMVwZj8kFrxTqi+vtPS6B
	0U4A2fZclkQlc0vqe0jegAp6NKsUhWozFi7CmVerYMI7Q+oOXk65aSmTgo/iXTPD
	nmpo6g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enuptgqpu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 13:02:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9157ae36434so148091385a.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 06:02:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780923756; cv=none;
        d=google.com; s=arc-20240605;
        b=JrIkJuinU9yKjPBcq7xYvJbzbvU5+yQn9Mw8b9uENHkEotiw4Kza9Eep8mWoHI9F91
         bm1G5Yp4XC/9M3oXFDaoU3c5uX98T1SMi29DpP7O5MVHJArkdXPD/U+4yzr3AderE0OW
         dnLQ2ar9gq3YiloQcgn7nkGJTJwgfS01jngrJLXBB/6JZsUyJgb8kPHERcxUKi5pILdP
         5/9cCVNfJzkKTUjlVwfR8K6BZtlIxL40wnESXEleUlG7YiYZs4GExSWp8TdHbecyWJ40
         nUpK8P2Je+mnEwALc6gNsRFaUMQA/5VhbcRSF6t2P0Z7JPOAPRk3xQ+GwSkqys1yLFW8
         Liaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=;
        fh=5b+nwn5A5hFZyKK4Ls2evPq+OEZ0X6cvTVXEttW8828=;
        b=TNLZWuHh6X7EveQFqrkw4+b6RkZOin2zTaxUUgXmQJoS9aPSEE/8+zPt3CW3LHqW1a
         jTPJJJZ9ONl0D8EtL2czJt9/7aClp/q+W6VzwOtWdpzLEg+XvA5ztLPHnCYKfULNuDIH
         VObZUqOGGtzd6gzahsHIml7+w+Pe8cyb/PP4iydpUIKtI6+xeXXY4L6SbUcUG2AgnMNP
         wDtBGjoLUtBOBXh1qB/B0coMDFIOPC0QeP9jf2V2gBS+vFz5kTEQQEB6FPlfMCMz8pzS
         vI7JAsuv5zde9MhO0RUxUNeEHh7UQepoLg6Gfc+4dDoR9HYOMCtqVIkw3VV+6Iqc+dxa
         DM6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780923756; x=1781528556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=;
        b=FOvDuEs1HeYZL2+YXmrDlpZo0kNgo6ZTosywK+ME/B+dq2CBzUvZ0vkq2hNxRISZJi
         zIxOAs1HhskE3VF9URfe6lLjLYVP8JNSuQqhU9ww7xOxGa18/4uKGbRtgMj8ryx6mcjJ
         Wtgr6BIlLLV2y4MVtT8k8FeqiNEyWc9K5N7/VGc4X8vzeEmtHTp+ObkvEfnpC1bxTVJ3
         fN1VOpNL/6tKQPAFQYhK6SZ3A2xEI3jE4ORNMgmiYONjxq4UGDtkpnMyiWSB9tKeP2hU
         vTN+8+RCTl1Mv32CscRfn7ps8kAd5cfUwqGNE1fx5Bn949NAJlIwCGvctvAfULYMpDGk
         2vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780923756; x=1781528556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=;
        b=DxvVDv6d8fG/JG+qXuisvRbjI2VotJcqzGIOdNoxCMJ00sxEevbVtgUKFv+4dI58YY
         5mEyjp5880NTQQE0/EAxwFr27BvjfI7EvNoSESeRxHVSEqQrZQwWlsVVhjiUw1fomWx3
         OO/Ub4TnrkHStFeoiDnvQmPzRjB329jJnRV5EUqFKr5HckjE1NeIr38NZ29SsVmHJI43
         ZdHx4pT02cAybG9WSN8p5MDA80gjfnW/DERMdTLmmmcGzBLpDV8yq+HpFVTK1kNXS60b
         5z3HCTr/R15jvXSYKGTvl4Vqaq8cIPCKjfqki/H4DY+8SDCpp/aTfAkHSGZQf6TK9/V5
         XMTg==
X-Gm-Message-State: AOJu0YwkSKAJAqp8F9BWtFI4Q0DjDN2/PkXuIGx3xlQk8xiEuPSulIsY
	fjCFLg5qDY8i5EBVKoGjCu3UpeimY9R7pkwn4ZV5M7tkzOro4ntFkflVTPLr28KBOtsPgMPZ2ZA
	Fc6Kj6YcwNgSPHk1h2t/ZyuNv66BnfZ4vM9eKOdNAY0NenqRoM5CYW+XTdVUATLsCT2H2wpwz7S
	fySPHQXiZTId3KurblLHPBAREDld6/CZz24PrUvg==
X-Gm-Gg: Acq92OHqRps+bujjfEaPwOjnpA/7qGM6tPnT+WcL1/jGYofdnVZKyr2ThPrre5vDyuR
	xPct6iusrJi2GtroVYKfQMhgJtZPuRruOxRWJ3zGhZ8jZZSx32/FjbvdN7SVWIvkrRdPp3MvimY
	oLGraSHA6nAYF/stQ02pED/GHrRDkUuUzwqB+B++SeC39F4ro1f8fuH7z+2lcZpbqA6PlXHwqXU
	FZ0BfYHHRCaGhFH2/yEMF95SOUxXtUW+JoWsux/U+R3fmp8H/gWGEWlRqAdWAKVz+O6AnCWbt2R
	NcBeNrLjrloIRWLkNF1LMq0S61iPwzqg
X-Received: by 2002:a05:620a:454b:b0:915:2404:bfe9 with SMTP id af79cd13be357-915a9c35852mr2536190885a.9.1780923724464;
        Mon, 08 Jun 2026 06:02:04 -0700 (PDT)
X-Received: by 2002:a05:620a:454b:b0:915:2404:bfe9 with SMTP id
 af79cd13be357-915a9c35852mr2535551485a.9.1780923662522; Mon, 08 Jun 2026
 06:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
 <20260608-block-as-nvmem-v3-4-82681f50aa35@oss.qualcomm.com> <CAMRc=McmoWvezeH05_5AR7ZbAyg1L567HsKWbuD7711LwnjV0Q@mail.gmail.com>
In-Reply-To: <CAMRc=McmoWvezeH05_5AR7ZbAyg1L567HsKWbuD7711LwnjV0Q@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 15:00:51 +0200
X-Gm-Features: AVVi8Cc-wgzw5gsLbwZHUHPYEgpxejd9uRTmITt11-0eb6tOd2NzMwDpPGAFaCc
Message-ID: <CAFEp6-0JaOd8PpqMY_21BEDyDyYx1kDfskOS4VSd8nxP4KBXZw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] block: implement NVMEM provider
To: Bartosz Golaszewski <brgl@kernel.org>, daniel@makrotopia.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
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
        Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Tw5EQ5TCDjibbbosqrZQG5MrB4hcRaIv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyMyBTYWx0ZWRfX4/f5J0QXzBYH
 WLGQiDhYwH6iyAOA6Pp9m17Deo+jLymW8AKv2+nVZOxmlVKhDaQhz/0iYkOcDlZ7ryWlV9QMWX+
 6K9TEoSJuKhplF+XMxfVQBGlepMwl/2YSXKvBwlapAmbPjRgG/6/D5YbqJvPCRTyzlCgTHOSCoQ
 vToTktihSPoIE57dITlSw1hZiGT9IayRl0Htf0fakHTIxXYCWHBd46uT12v+733RnfFfhoms8C+
 AmjN+WGqj5IXsqz5QUGyPSphBIE90ULZd7IDDamdXtZi4BvdplaCBmb3C7AH/K2WK7Af0AuMuqe
 /Hvrk404hg9lPhrpyM6NYqAItA0leFKbOhy6LyJOKpAuA+V/n5xYJ2rd0ORAXFJpgd82EABLSOV
 2MGWFvnFCLWDq1tTJ0D2oB00ZvCaSA==
X-Authority-Analysis: v=2.4 cv=XKAAjwhE c=1 sm=1 tr=0 ts=6a26bd6d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VT4XjZGOAAAA:8
 a=IjnKPMcg25KrRLxKrC4A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-GUID: Tw5EQ5TCDjibbbosqrZQG5MrB4hcRaIv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080123

On Mon, Jun 8, 2026 at 1:17=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Mon, 8 Jun 2026 12:50:41 +0200, Loic Poulain
> <loic.poulain@oss.qualcomm.com> said:
> > From: Daniel Golle <daniel@makrotopia.org>
> >
> > On embedded devices using an eMMC it is common that one or more partiti=
ons
> > on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPRO=
M
> > data. Allow referencing the partition in device tree for the kernel and
> > Wi-Fi drivers accessing it via the NVMEM layer.
> >
> > To safely defer the freeing of the provider private data until all
> > consumers have released their cells, a nvmem_dev() accessor is added to
> > the NVMEM core to expose the struct device embedded in struct nvmem_dev=
ice.
> > This allows registering a devm action on the nvmem device itself, ensur=
ing
> > the private data outlives any active cell references.
> >
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  block/Kconfig                  |   9 +++
> >  block/Makefile                 |   1 +
> >  block/blk-nvmem.c              | 171 +++++++++++++++++++++++++++++++++=
++++++++
> >  drivers/nvmem/core.c           |  13 ++++
> >  include/linux/nvmem-consumer.h |   6 ++
> >  5 files changed, 200 insertions(+)
> >
> > diff --git a/block/Kconfig b/block/Kconfig
> > index 15027963472d7b40e27b9097a5993c457b5b3054..0b33747e16dc33473683706=
f75c92bdf8b648f7c 100644
> > --- a/block/Kconfig
> > +++ b/block/Kconfig
> > @@ -209,6 +209,15 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
> >         by falling back to the kernel crypto API when inline
> >         encryption hardware is not present.
> >
> > +config BLK_NVMEM
> > +     bool "Block device NVMEM provider"
> > +     depends on OF
> > +     depends on NVMEM
> > +     help
> > +       Allow block devices (or partitions) to act as NVMEM providers,
> > +       typically used with eMMC to store MAC addresses or Wi-Fi
> > +       calibration data on embedded devices.
> > +
> >  source "block/partitions/Kconfig"
> >
> >  config BLK_PM
> > diff --git a/block/Makefile b/block/Makefile
> > index 7dce2e44276c4274c11a0a61121c83d9c43d6e0c..d7ac389e71902bc091a8800=
ea266190a43b3e63d 100644
> > --- a/block/Makefile
> > +++ b/block/Makefile
> > @@ -36,3 +36,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION) +=3D blk-crypto.o=
 blk-crypto-profile.o \
> >                                          blk-crypto-sysfs.o
> >  obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK) +=3D blk-crypto-fallback.=
o
> >  obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)        +=3D holder.o
> > +obj-$(CONFIG_BLK_NVMEM)                +=3D blk-nvmem.o
> > diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..99c7728fb7bccdc2216780a=
73a89a9210f925049
> > --- /dev/null
> > +++ b/block/blk-nvmem.c
> > @@ -0,0 +1,171 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * block device NVMEM provider
> > + *
> > + * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + *
> > + * Useful on devices using a partition on an eMMC for MAC addresses or
> > + * Wi-Fi calibration EEPROM data.
> > + */
> > +
> > +#include <linux/cleanup.h>
> > +#include <linux/mutex.h>
> > +#include <linux/nvmem-provider.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/property.h>
> > +
> > +#include "blk.h"
> > +
> > +
>
> Stray newline?
>
> > +/* List of all NVMEM devices */
> > +static LIST_HEAD(nvmem_devices);
> > +static DEFINE_MUTEX(devices_mutex);
> > +
> > +struct blk_nvmem {
> > +     struct nvmem_device     *nvmem;
> > +     dev_t                   devt;
> > +     struct list_head        list;
> > +};
> > +
> > +static int blk_nvmem_reg_read(void *priv, unsigned int from,
> > +                           void *val, size_t bytes)
> > +{
> > +     blk_mode_t mode =3D BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES;
> > +     struct blk_nvmem *bnv =3D priv;
> > +     size_t bytes_left =3D bytes;
> > +     struct file *bdev_file;
> > +     loff_t pos =3D from;
> > +     int ret =3D 0;
> > +
> > +     bdev_file =3D bdev_file_open_by_dev(bnv->devt, mode, priv, NULL);
> > +     if (!bdev_file)
> > +             return -ENODEV;
> > +
> > +     if (IS_ERR(bdev_file))
> > +             return PTR_ERR(bdev_file);
> > +
> > +     while (bytes_left) {
> > +             pgoff_t f_index =3D pos >> PAGE_SHIFT;
> > +             struct folio *folio;
> > +             size_t folio_off;
> > +             size_t to_read;
> > +
> > +             folio =3D read_mapping_folio(bdev_file->f_mapping, f_inde=
x, NULL);
> > +             if (IS_ERR(folio)) {
> > +                     ret =3D PTR_ERR(folio);
> > +                     goto err_release_bdev;
> > +             }
> > +
> > +             folio_off =3D offset_in_folio(folio, pos);
> > +             to_read =3D min(bytes_left, folio_size(folio) - folio_off=
);
> > +             memcpy_from_folio(val, folio, folio_off, to_read);
> > +             pos +=3D to_read;
> > +             bytes_left -=3D to_read;
> > +             val +=3D to_read;
> > +             folio_put(folio);
> > +     }
> > +
> > +err_release_bdev:
> > +     fput(bdev_file);
>
> There's a __free() action defined in linux/file.h so you can use:
>
>         struct file *bdev_file __free(fput) =3D ...
>
> and avoid this label.

Ok, thanks, will use.

>
> > +
> > +     return ret;
> > +}
> > +
> > +static int blk_nvmem_register(struct device *dev)
> > +{
> > +     struct device_node *child, *np =3D dev_of_node(dev);
> > +     struct block_device *bdev =3D dev_to_bdev(dev);
> > +     struct nvmem_config config =3D {};
> > +     struct blk_nvmem *bnv;
> > +
> > +     /* skip devices which do not have a device tree node */
> > +     if (!np)
> > +             return 0;
> > +
> > +     /* skip devices without an nvmem layout defined */
> > +     child =3D of_get_child_by_name(np, "nvmem-layout");
> > +     if (!child)
> > +             return 0;
> > +     of_node_put(child);
>
> Same as above, can be:
>
>         struct device_node *child __free(device_node) =3D=3D ...

Ack.

>
> > +
> > +     /*
> > +      * skip block device too large to be represented as NVMEM devices=
,
> > +      * the NVMEM reg_read callback uses an unsigned int offset
> > +      */
> > +     if (bdev_nr_bytes(bdev) > UINT_MAX)
> > +             return -EFBIG;
>
> This will mean a failed probe. Wouldn't it be better to use -ENODEV?

That would indeed be an appropriate error.

>
> > +
> > +     bnv =3D kzalloc_obj(*bnv);
> > +     if (!bnv)
> > +             return -ENOMEM;
> > +
> > +     config.id =3D NVMEM_DEVID_NONE;
> > +     config.dev =3D &bdev->bd_device;
> > +     config.name =3D dev_name(&bdev->bd_device);
> > +     config.owner =3D THIS_MODULE;
> > +     config.priv =3D bnv;
> > +     config.reg_read =3D blk_nvmem_reg_read;
> > +     config.size =3D bdev_nr_bytes(bdev);
> > +     config.word_size =3D 1;
> > +     config.stride =3D 1;
> > +     config.read_only =3D true;
> > +     config.root_only =3D true;
> > +     config.ignore_wp =3D true;
> > +     config.of_node =3D to_of_node(dev->fwnode);
> > +
> > +     bnv->devt =3D bdev->bd_device.devt;
> > +     bnv->nvmem =3D nvmem_register(&config);
> > +     if (IS_ERR(bnv->nvmem)) {
> > +             dev_err_probe(&bdev->bd_device, PTR_ERR(bnv->nvmem),
> > +                           "Failed to register NVMEM device\n");
> > +             kfree(bnv);
> > +             return PTR_ERR(bnv->nvmem);
> > +     }
> > +
> > +     scoped_guard(mutex, &devices_mutex)
> > +             list_add_tail(&bnv->list, &nvmem_devices);
>
> I'm not sure I understand the need to store these? Whatever you need to d=
o in
> remove() can be scheduled in a devres action here.

I think the devm_ approach would work fine in practice. The only
difference is that NVMEM unregistration would be delayed from
device_del() to device_release(), but during that window any read
attempt would simply return -ENODEV, so there is no real race or
safety concern AFAIU. I guess the explicit list was initially kept to
mirror the add_dev/remove_dev symmetry of the class interface. But,
except if there is no strong technical argument against devm_, I will
switch to that simpler approach in the next version.

Daniel, feel free to nack or ask for authorship removal if needed.
This patch submitted in your name has accumulated enough changes since
the original submission that the current shape may no longer reflect
your intent.

>
> > +
> > +     return 0;
> > +}
> > +
> > +static void blk_nvmem_unregister(struct device *dev)
> > +{
> > +     struct blk_nvmem *bnv_c, *bnv_t, *bnv =3D NULL;
> > +
> > +     scoped_guard(mutex, &devices_mutex) {
> > +             list_for_each_entry_safe(bnv_c, bnv_t, &nvmem_devices, li=
st) {
> > +                     if (bnv_c->devt =3D=3D dev_to_bdev(dev)->bd_devic=
e.devt) {
> > +                             bnv =3D bnv_c;
> > +                             list_del(&bnv->list);
> > +                             break;
> > +                     }
> > +             }
> > +
> > +             if (!bnv)
> > +                     return;
> > +     }
> > +
> > +     nvmem_unregister(bnv->nvmem);
> > +     kfree(bnv);
> > +}
> > +
> > +static struct class_interface blk_nvmem_bus_interface __refdata =3D {
> > +     .class =3D &block_class,
> > +     .add_dev =3D &blk_nvmem_register,
> > +     .remove_dev =3D &blk_nvmem_unregister,
> > +};
> > +
> > +static int __init blk_nvmem_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret =3D class_interface_register(&blk_nvmem_bus_interface);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +device_initcall(blk_nvmem_init);
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 311cb2e5a5c02d2c6979d7c9bbb7f94abdfbdad1..ee3481229c20b3063c86d0d=
d66aabbf6b5e29169 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -2154,6 +2154,19 @@ const char *nvmem_dev_name(struct nvmem_device *=
nvmem)
> >  }
> >  EXPORT_SYMBOL_GPL(nvmem_dev_name);
> >
> > +/**
> > + * nvmem_dev() - Get the struct device of a given nvmem device.
> > + *
> > + * @nvmem: nvmem device.
> > + *
> > + * Return: pointer to the struct device of the nvmem device.
> > + */
> > +struct device *nvmem_dev(struct nvmem_device *nvmem)
> > +{
> > +     return &nvmem->dev;
> > +}
> > +EXPORT_SYMBOL_GPL(nvmem_dev);
>
> This should still be a separate patch.

Well yes, actually I should even remove this as this is no more needed.

Regards,
Loic
