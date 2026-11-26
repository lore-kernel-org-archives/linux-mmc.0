Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795708222;
	b=hRIdDpA4mNGKjKyIpJXcEc2Ce+zkRQqUZZUTxRqYme2f2hTNBGrPu0IxjNV8YMbiks29
	 zKGQT10NbeVGsyVF6IL4J2rwGJAwYCKxKvPN/EOma+bhm6UDg+XKR+CHWRwkr1/3PKgU1
	 tezxtFQC5Vf7AGJaLBnBijtMDEk4lEItwkT4KnMc8/agtCx9naMGvWVKep/VHR1jLWvWI
	 HwVtVF9tZvCcjsF0WFZKLHrNe4Ao+uorraKnjO5Ugy4jDL3J5JtghEIXgs42FYVuYddf3
	 TNqpofeSdPM5XBtAy2dRmyZCo4JKRXaJTuf7Qf3QeF1VmAi/sxB8PW2frHzBmYT5PRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708222;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gIwZcK4QOl3Mm5lzx8mQRAanf4vTLDTmM49asUT7xVU=;
	b=VwKpXnfLvOyev+Y4d+Ypk9Ya04Qb6PWZGrdlNgF56fQCCTJVvk+EX4X13CPQWJsQyotx
	 SRIZIqxfOhl4yBl/WCGS2lk+OIMKBPnfPBjGPvibTyZx15CMemM4DZTrLrFWNCKIWnN5y
	 Aaqk2jJMDTNpwux1UdiFpKIvOwwVG+KqHTAvXdtmzNKJkYQySi7MRvdCSx1Wb/ZR8mL+R
	 elMYm9sfRc9u11dwVi7ZiM5uGZw2DAR3oa6jYdQ3eQddoX+J0TYhlb0xhWUgeE11Kuk9l
	 g92knJdLG7z9l9GDes4h96JjWLnJtwfnfOmp0NXN5VHpJInp5HAedQtyWYwwIVeHrjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Dcvo/I7g";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TYr0bRva;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66986606A323
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 15:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66986606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dcvo/I7g;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TYr0bRva
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQEVYwE3298771
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 15:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gIwZcK4QOl3Mm5lzx8mQRAanf4vTLDTmM49asUT7xVU=; b=Dcvo/I7gXFcqEJph
	3qe+Zy7ukwRz60QpxiUvzYinwPbZ5zXry3KOaePjTQZ3wXEzdF/u7tSb1sXtMWim
	OXGUpwOIE7v+kpjy33MHwit8tjOuZg3d8akrKLMgDdah69IxiGeV02/L07X+IZTs
	DL8i4ZqdrKlqmxr2wONtQD9uzMyg1pHnAj7XSNhpQiPzYMqeX/d/sUknJLiV00hp
	xvOer6QoNUdeZ49hS+pzuv+9IzWQCNWo53ZoCo4v/MnyQOyGSqAewwplxdZIEJim
	VHK5o//xNesDq1KWF1Bo1qOxz3Tc8vJAdAhOU6nu7B7B4toBzkQxtEeL4YUOuqDR
	/QidsA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ak02wts-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 15:50:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2f045e399acso62097285ad.2
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 07:50:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795708220; cv=none;
        d=google.com; s=arc-20260327;
        b=e1ONmO3lXDFWXnPrtSVFu11PXMi/8F5hnjVg/Wf/MsLDl8DNWpWTCnqwZqO/Oapsnk
         xuj9HIS9PbvtRndwr6IbIDa/F3rWoNHWoypj4X2WtWNEiQy4nCnpqi3f5mSj0FIWyRC0
         hJa67qAuYobM/1CIAcOgBuuSKl/M/M0clkzaOexNrq8PBrnofKo44HRCcDqBxQQUmQcD
         /LcyVrBXoxeRIBAyR+LM/ZSWqucEQReGR5BpIFSwrfVLO265bTIRMBoDXH9+ahVST5Ml
         MN+AN3n+yt7JwL26EOXSY8MloIGEPpklm84ff8hmxjp2jOGSysQ19I7wuJBgO3JFvDu5
         aXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gIwZcK4QOl3Mm5lzx8mQRAanf4vTLDTmM49asUT7xVU=;
        fh=fFf/86oeVEPpj46Qum47r4XT9cv0rVrPHU293/4Ewoc=;
        b=sDZXMbqHcp6ld61LHtLkQH21Ob1ANW7OBY+9J/SALfdlIg6MHvJ+pKMZudyP19HZlN
         v6W2iMAqiJa3tr5jQACiWx0fqzOosTts+efMejaFUD0bek85TlU2+fDbupKQBC6Hh6Vn
         brJ1V1FwpIbNkoIx7WLvnLOw5sftFQ6g8/91+V/vVnvA5ZwLZOrg+1ohXPQbVl86QT59
         Snvr8hKiDVF5U6wwx4gbhKjfxdXQYfC1HElXj3q2D73hM/dFFcjCK0rcnM/gqqt5ZI+0
         iYErtZxwuu0hklkkn8EhVuHA73SfLDJv7YNv61MW0JiQjYTS4YMDKlNw9EDBJ7OOhHKD
         K06w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795708220; x=1796313020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gIwZcK4QOl3Mm5lzx8mQRAanf4vTLDTmM49asUT7xVU=;
        b=TYr0bRvan2D5sbZOUEVtFhHcqoQVLGMhef0bhOGsS8bQa6JhXTDXgQ+USn5ORgY0vO
         crndiv1fWxVUyNGnP6zWvpfQ7Nu+B+K9kxwoQwBoOqm3fYfP/oVVeFEZJ/vcwgqQZ9c2
         CpYFtUXBXodJ5jrWDOzKbapp3yEXVpoIHu4jXFuw9bTYXF+CZLesGbbd9Lb93dIK9t2j
         BATouYVChdiiVy4nY3Lwrl2Pg1VgCy8V+z3LbVtyi3xmW9dbJaf7eq3bRLGW2WVQFg2R
         2x8j/aKMrSP8fOjR1l1bX30xymdNJQ2h9mJqrAoeXOwP8dJWw+ZmO+X8j6MvjBErb2do
         Lf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795708220; x=1796313020;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIwZcK4QOl3Mm5lzx8mQRAanf4vTLDTmM49asUT7xVU=;
        b=NS5/vZsaGesNHg4FDzBtjWwazCstwzYbKsqsS5UKGiXzwPVL0YeHvT/oufanvSJy7d
         C1ck/v8irMfdrBOeLbOoKRN2FuXRdqPxcVjSQRJTl+zmayNhpwErBQzK6/oIRBZsWewA
         sb+WKRHS5p6s1pPvURNKAWI+3ZADuSWuIjJWvv4Dt2Qv8ZDqeMc4oOpTUUWzIBxKDfMG
         GsKvdqZ5RtsfTvqMX8+3Lyw1ztHswtcoJf1EXokVkO7Pr5dHrXSV054E9Uaa6YLxhrxA
         UCgYnWvVjgVCtDqMPvqCzjRC6rfgQzi0yvaviBEsRyiAr/aigrXTdMUxyazRpjp8ihUN
         9kIA==
X-Forwarded-Encrypted: i=1; AL+hErHVeKdHfkLeEjCXSIKFQ5zHgTEtf1Rcjz63KoLvjrrncxG9do1IGqSSx/xYVOiMJHZRDIGxoLpbQos=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ujz85XjBYsXWoZZy8ApC4PnCWdwj1H5u68FV4mzUvHC0DhoMx
	fGzQ0i4XHP1cJ19RZidCG3mE2DWDA3hvj12Hu1CZFPpMd4R19ctezqlM3zKg9iiSgc1weN+LiuN
	XObYP7ac4NYBCh7SnlNI/w9OlgJFijG9apqn/SkjN2USs4r+LG1pGvOhHdGgWZRPZf2By4/xYxb
	BMIIgQrpAafwfYqhWqTR5KDJwvvrcVGaNJzSwogQ==
X-Gm-Gg: AZFdTZdVpjEZUhfwKzDZrj7lD74lyAXazfPycHlE50q37e8YLbKJB9E/9V8Ugw1v/X7
	GlvbrPe1N7iuOfYoC8mHBj6Ts6DQfcURWP/BsIYnwlBdIl0SFzqzroUzHVJXDSXjgUaCR3GEG4w
	bLlnVTKdeNgELnNWEpnZf4OL0ACPVH5B6Zo3Pv/avAOfuioKm/sNrF7grg3w==
X-Received: by 2002:a17:903:198d:b0:2f0:39c6:8ee5 with SMTP id d9443c01a7336-2f03f27787fmr233290485ad.52.1795708219877;
        Thu, 26 Nov 2026 07:50:19 -0800 (PST)
X-Received: by 2002:a17:903:198d:b0:2f0:39c6:8ee5 with SMTP id
 d9443c01a7336-2f03f27787fmr233290095ad.52.1795708219369; Thu, 26 Nov 2026
 07:50:19 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1789975099-157594-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1789975099-157594-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 16:50:07 +0100
X-Gm-Features: Aa3M54r82nwhTksPYmbjufapjUhnrkNXbvAYflMCCiHkeElDYkLBJ88_lHxNLsg
Message-ID: <CAPx+jO8UC-6be9-24eXgWdrFnm047niARcNR2CaOjm0jP_CEHQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add SDIO userspace passthrough support
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6b08553d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=s8YR1HE3AAAA:8 a=4V_M4x3YfzuPUH-Wr70A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: -xQ63oz1QNvuRHqLTc-q9KuvxUkSQzYZ
X-Proofpoint-GUID: -xQ63oz1QNvuRHqLTc-q9KuvxUkSQzYZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA2MSBTYWx0ZWRfX+DzNidQpX9lN
 R0kMtgrnAaKhGkve+spyQcGIxQm8R3Ggb/oQRswRXogmqEKwzX7eN74Ck4zDF5swTgKBLZZ2kcp
 XUFlaOhVyq569e990eVRhmUNIgvASfa5HWwqgjPDNjtOS3RgAHrV7YnG9oSJR9V51bwzvcYJZfv
 mQEWZA9Mp0dCyMRvVJKiElaEO335lTjWg2N/ZfKh96uW4odsoSEAyhKFAIF6xy9d9a9dmtES9w7
 wirI3j/mJOTWianXGqL9fruSbXeZh2sKEgLO6/xHnQaBOeck93E7l/n+D0PrreIMJpDYwp/pYYv
 1z2/ZAnii1jguBm5M+kioDdMZkTrT3+I4FkZ2bos6cEKwY5zzs2nafaDdpKv3XNWEA108C2ewMR
 cWyHQ8Dw3McYg6XSj78Cko3GHZTddvcWC1CRB/B5aY4Jc4F8ZXdnL/uvwvBwBsChF58h83Wp7H1
 sOTHyCEY4V02K65Yvuw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA2MSBTYWx0ZWRfX0u9AAZy0sPkF
 2vpHX8ZfjXzKFGzR8l3pDikKGHpO12Wez8hiA0fFSBMADYFa1WGqnWkJAJPm9p8sYrzDyZKzTUN
 dtpubC8uH59vKX9mrRMWXPxwdWNvlBE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260061

On Mon, Sep 21, 2026 at 9:18=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
>
> SDIO cards are normally driven by function drivers (brcmfmac,
> mwifiex, rtw88_8723bs, ...), but bring-up, debugging and factory
> test frequently need to poke the SDIO register space directly:
> CCCR/FBR in function 0, or vendor registers before any function
> driver is bound, and some deployments, notably lightweight IoT
> boards, want to handle the SDIO function entirely from userspace.
> Today the only way is to write a tiny kernel driver per device.

My sincere apologies for the huge delay in reviewing this.

I am simply not convinced that it's a good idea to allow SDIO function
drivers to be implemented in user space. My concern doesn't only cover
various new use cases this would introduce, but also about bringing
another ABI to the MMC/SD/SDIO subsystem. And to me, it looks like for
no good reason.

However, in regards to debugging, bringup and similar, yes, we may
have some pieces missing. To address these problems, I would rather
suggest that we look for in-kernel solutions and if it turns out that
we need some new SDIO helpers, I am certainly open to discuss them.

>
> So this series adds raw userspace access to the SDIO register
> space as well a small reference client. Meanwhile, adding a new
> documentation about how to write a proper SDIO function driver,
> because I have recently been working on SDIO function drivers
> and kept referring to the existing drivers for guidance. It turns
> out that the knowledge is scattered and there is no unified document
> describing how an SDIO function driver is supposed to be written,
> despite the MMC core having clear expectations about how the APIs
> are used.
>
> In particular, the interrupt model has many pitfalls:
> sdio_claim_irq()/sdio_release_irq() must be called with the host
> claimed, the handler runs with the host already claimed and must
> not sleep or claim the bus itself, and sdio_release_irq() must be
> called from ->remove() because it is the last chance before the
> core removes the function devices from mmc_remove_host(). Recent
> fixes around the SDIO IRQ work and host removal and the discussions
> on the mailing list showed how easily these contracts get broken.
>
> Also worth documenting is the buffer requirement of the CMD53 based
> helpers: the core builds a scatterlist directly from the caller's
> buffer and the host driver maps it for DMA, so vmalloc() or stack
> allocated buffers are not acceptable, while the CMD52 byte accessors
> are safe with stack buffers.

Documentation for SDIO functional drivers would be really great to
have! Thank you for looking into this!

>
> Changes-in-v2:
> - drop RFC as I don't include mmc-utils to be sdio usersapce tool
> - add sdio doc
>
> Shawn Lin (3):
>   mmc: core: Add SDIO userspace passthrough character device
>   tools/sdio: add sdio-raw userspace client
>   docs: mmc: add introduction to writing SDIO function drivers
>
>  Documentation/driver-api/mmc/index.rst             |   1 +
>  .../driver-api/mmc/sdio-function-drivers.rst       | 211 ++++++
>  MAINTAINERS                                        |   2 +
>  drivers/mmc/Kconfig                                |  11 +
>  drivers/mmc/core/Makefile                          |   1 +
>  drivers/mmc/core/sdio_bus.c                        |  12 +-
>  drivers/mmc/core/sdio_cdev.c                       | 189 ++++++
>  drivers/mmc/core/sdio_cdev.h                       |  21 +
>  include/linux/mmc/sdio_func.h                      |   4 +
>  include/uapi/linux/mmc/sdio_ioctl.h                |  48 ++
>  tools/Makefile                                     |  14 +-
>  tools/sdio/Build                                   |   1 +
>  tools/sdio/Makefile                                |  66 ++
>  tools/sdio/gen-sdio-ids.sh                         |  59 ++
>  tools/sdio/sdio-raw.c                              | 714 +++++++++++++++=
++++++
>  15 files changed, 1346 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/driver-api/mmc/sdio-function-drivers.rs=
t
>  create mode 100644 drivers/mmc/core/sdio_cdev.c
>  create mode 100644 drivers/mmc/core/sdio_cdev.h
>  create mode 100644 include/uapi/linux/mmc/sdio_ioctl.h
>  create mode 100644 tools/sdio/Build
>  create mode 100644 tools/sdio/Makefile
>  create mode 100644 tools/sdio/gen-sdio-ids.sh
>  create mode 100644 tools/sdio/sdio-raw.c
>
> --
> 2.7.4
>

Kind regards
Uffe
