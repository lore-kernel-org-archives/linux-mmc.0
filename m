Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207733;
	b=koHwHN/LWKr7wklw/GEXKeVHaCnM3C5/7AB+StBDYxteuALrSsBPpY9N2DN7hJb073ab
	 7m7+mIHnZrzJORFs7FlfnE4Vb4OYsuggsZ86Xsg7yNfqjlsYwqzwqIPwSec4AQyZGVP/0
	 KgDtX6n0ZdILW0W9XjjjmvOTVWt6w1la/f/RHfvBnYJDuqaoy8ji7xt4ISHYQKOluDv3i
	 yIRXqcwOmfl1tPJtCFYSO8LWfLuNQOa+Xhag7eW+f25G/W7+00ZRIY7BnCjm3Dj+TMtHA
	 ILlwqroQtVbhxsl8FgbWwlhl8JxtM+GbIF6uWFeRyGLxQP7eeCfb+f6oFXN7NLOlLWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207733;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=oTivWQmlj3c5+xkG6q4vbbn4oVPWL+isyUMjXXpYFaw=;
	b=wOu+YnyRjjtu0+7Ai2j7ZhCixpjB5/wU+s5iOd/RGZJsOSlek9PIGEutz2szA4AJLvPV
	 rBke3RFU/nR6VL/WiQEhA6zfuXsIFzcvxVoj7xCRZP0M99hsHDgFbDhd48AQLV3Jcyxxy
	 bNRMM/IQQR9qeHZ6r/TLilMGGXAOkhR2qTH67hSflaSpHDUsPG6y35yyedIlnj38qJrby
	 zaf54wDvuWekADIwpzCiXDMsIJTtJVNhJzzao5Dgcj/QkYorAQlhzettSwqN3t1/HCdci
	 zCKaH01MxZOQ0B+wDVh++KO/74DKMOeoS7i4/BvOnKBFR2vnL4yJNnxFxTS2KWlRd2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dF45AgXc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eA0TnroS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71C6606A323
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E71C6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dF45AgXc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eA0TnroS
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SF9uAm2542927
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oTivWQmlj3c5+xkG6q4vbbn4oVPWL+isyUMjXXpYFaw=; b=dF45AgXc8VSFUAam
	MkVUkfihAY+CYWwjpd+ztucIAAksFQE38OUc0cchDLR4R5/oMlE1O68f3URXyz3z
	wcAX5TGve92gD0wGzDG8NDjH4CyPMUvGplb0ffP3DkVZeiyqgzrmXjYnWIqfTChW
	73KyASSGOQCZ30XNglipnkgBVXaQRn41GMYCfg9TNNoNsjuP0R5FXypTIF/WOSAC
	rgHGBOKJ7SwuPDvq6GgvFAam6JmJC2DiP4Qwbn4emJPJN2c2T4gkk9uefjs5kPtk
	qudeJomt0lmdqZWfdmVK8iltYpRwNfHAezDVkFQJ67cqOtD3DEk70yAg43J/4103
	JiSytw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehrkd3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:32 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a08903566dso1696060b3a.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:15:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207731; cv=none;
        d=google.com; s=arc-20260327;
        b=TLfpFo2d0IrqaE7cqsirdfUA5wJfdM0bm2/whSxcVKrqYKuoqi8tyx0E55GkeXogbK
         ic5P6DI11DnsJ4M6098/UdLKthxaDNLxJxdSsTq9tIfMNuFcR6Y9aArcVIuzfiDkG8rJ
         v65WUUkj7lAz0WtTFA8RMJRRnzS0Setp6/KAkgx4JGUma3GMVUqdq04OiNZSuLGXLZrl
         MXLJQq0jJ7Q8ZIcM7BDLgB4Ms8wb8/blDB3hY9zMNOexYXnOZkW4VmvTev2cUwBMT4W6
         g1Qb9dczIqmlNmuTVB+/War7olE22piZbHFthG+8Gy6XE5BM4d46+a4D8ebvgkDm2al7
         i3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oTivWQmlj3c5+xkG6q4vbbn4oVPWL+isyUMjXXpYFaw=;
        fh=qbbmTh3WTG2NL2hVExeY5KoWMovCAFvk4ruEYA1Swzc=;
        b=BfLSMRRk/sH0l8GTKeoVcCkK6oQeblD8wkeNG4Ceb6F6bsZatyRY99SJqys6IaYqQ2
         5h4GY2YmS0T+/9ww2Qig3CZlzVnHgQUJfcrovL4vhBzqGNQ/DLwIFuOj8XMd2KYHwxJV
         5xc1dJUillGyff2vA/SQ8tWW3j3QVTEu741v6AjttUoBTiiP7irLiSLXMbVu0ab71X+j
         VF9ekmhxWRzrVTHTuuFxNJfVMXJhPIvulzJZx+o1hH7uPGG635h1o+Y8ap1zysSn63wy
         hKez/GVXrbruFOQ5s2Vu1InQxkmJ1qYPDvjyPYhwUOHF5WRJzgDj0+AqfseJ8YGmIyEo
         skUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793207731; x=1793812531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oTivWQmlj3c5+xkG6q4vbbn4oVPWL+isyUMjXXpYFaw=;
        b=eA0TnroSg5+jv4U8V8ogErbmniejvIqS6/qHparp1PryJPPw+yDG3W38T8BugJHyth
         ar3rT08x539Khxa6TllV+uJ2rHfBfeKKT0PckQAvZLO8+v7eqH67/oce72qQwNtxfQW6
         OiwZqS9Of4wKewY/vWCtuZesoRcwd4sR1ziVDiyuQg9VMQyvpg9HNxRbIhAh0vsCJc7o
         Ty3nHKg7D7d5zA0exfGddvEmKvEpbBpcglcmoM9XqxylJTaSY68pWcMP5aFPIo/cs0n6
         9TAVl3twzrv2sdz50LSZZyCJjGRG6KYNo+waC+A9iGpjbHcCNyUFGsN/2vOFdFJ8OG0R
         /F9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207731; x=1793812531;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oTivWQmlj3c5+xkG6q4vbbn4oVPWL+isyUMjXXpYFaw=;
        b=Wt8xJoGiP4wES5yxZCJRRdXcaxZ3DoGUmYFod6zqFKS43Tx4zIYcBEQMu44RLxjj9/
         4V5gk8SOmy1mwgBoOZ1M1JMKRNpMh5kbmF1NTSNzlBo8xgwrTBjvE8bIytaBYuMBHN5C
         a+3Fj+riYMv0T8hY/LCGmHH+96ntpt/aRNn7STdW9IiXDyYGXXCIaDn5HWNRNNZx3wDl
         M5i8FjVLD/Vzvnp9vNRfWOSrWusAQ+aIRZQuaCHWp9h00z2uyTHUTGOciLSTGTfo1FaO
         uANLMkAyP/1eE4yU3R4DOhzG6HTNRi/kesQSsHW1XV3pY3eVC71MK5my2lRZqSC/SS2W
         8s0Q==
X-Gm-Message-State: AFq9FYIL44SN87s3xjqbfAQrBcwXjGoRRe3df1vcHbM/R8Bbgh5BwDl4
	uz0jVFV1SytrX16tBT7UZN91N+gLYpg9WfFrf35U1HAsJk+/t0Yr5FqOzwlpOyDZ2j1mLkCoOka
	ZeLzvjoLSMCy/UwAjb+IH/H988YRYtQYsXrvxq6TqhrcLQ9DCg4V99ZSGEG6175itI3PZcwhIHH
	DTQjXUw6qu7id9KDXuyhxisS/O7aunTytJFcsouw==
X-Gm-Gg: AYBFou0ezjlK0mqHimfIeTPzsXe44Du3O9PLK73FnTiORfouW2x6AuET6EHcReA/4x3
	xeLXBrx4XyMxL2jbXHf2CxMHcVCiUxj2qdt5SLReAkjyUrI5BKuF9i8Txa356oC0qmS5OzBQfUV
	xPv1VJIaXZ3ycAXM/w9YlaaKfkxMOS3y6jp3aPcsV+68Ug6XU2/aLT9vswQQ==
X-Received: by 2002:a05:6a21:7988:b0:3e2:26fc:2e01 with SMTP id adf61e73a8af0-3e913ab2aebmr48592637.40.1793207731213;
        Wed, 28 Oct 2026 10:15:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:7988:b0:3e2:26fc:2e01 with SMTP id
 adf61e73a8af0-3e913ab2aebmr48564637.40.1793207730492; Wed, 28 Oct 2026
 10:15:30 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261002073419.36768-1-hjf3108@gmail.com>
In-Reply-To: <20261002073419.36768-1-hjf3108@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 18:15:09 +0100
X-Gm-Features: AclHuK9YLBBZafufwzgL6LURhvDYqnRlzUNebCFCX2H-pOPqDcSAM4YgPIJZ7ak
Message-ID: <CAPx+jO-6rwecB_-o=QWtFhyzE7SAz5HhG=0M6ZaWL6-1GCexTQ@mail.gmail.com>
Subject: Re: [PATCH] memstick: Add Broadcom BCM57765/BCM57785 host driver
To: Ho Jie Feng <hjf3108@gmail.com>
Cc: linux-mmc@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Qi5HoPARXKTCS2QUunW2bbZaZ3QOiLZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX7+0kmsOYqAWz
 4WpWGM9Ta2brG+UXJn2TXPw2VQ+s4GWshpHf6jP6AAlf5SoRm1fDnnmlFioxhNiUXr6oAE3YXiR
 i3m5IXS0P4zFTroAPWcbR6CcmShYBH0+BqC56FIqzjaoXodFg4CIM8OxhCHsFkoX9KmKA+OF6ex
 i1Wwqa8muTZ+ZSUZ82QcvrA8p1zS1VjrV8QPxO5IMAOYADcbzfsColbdokttSC8C3yurqUmFmWA
 THtGj3WjChTZ7Q4O3H4qSiAf0P/02GMQTP0lqmMbGiOrNZpdhE9gpM1SyK2DW+QQyGtamIDFS9p
 jYVb3tubLgLUZ/cebwK2S52MHhE54WyRDGsdlMBoXfL/qeZZ1shzsJ2auJ09SHZuV7COpM1D5ud
 ZXREwESnLZFDgA5+wSAsUN575/6h3QqsNMzY6VGBhmK2QTDZNRp59Yu3JQE3iR7B8erQTwyJ4Jn
 WB9IzyLfQTPf262znuQ==
X-Proofpoint-GUID: Qi5HoPARXKTCS2QUunW2bbZaZ3QOiLZH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX3VaLU0R/mSbl
 hd0bpZNXgT8ft7YHRVYKn528ZHOtr8A63HVGBq2Nb6ItGy6v+tmP22TnO+3kHP5LiqSsew9RJHk
 ePdAyLH+35srV+ARPkWTe4XCiwP4OhI=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae22db4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=0ppYhf8rUd-JUyar7iEA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280068

On Fri, Oct 2, 2026 at 9:34=E2=80=AFAM Ho Jie Feng <hjf3108@gmail.com> wrot=
e:
>
> Add support for the MemoryStick function of Broadcom BCM57765 and BCM5778=
5
> PCI card readers (14e4:16be).
>
> The driver is written by inspecting MMIO traces from the windows driver
> and experimentally probing the device registers. Note that there is
> a register that can read the card pin state, used it as a logic
> analyzer.
>
> It was found that the controller exposes an SDHCI-like interface with
> TPC command handling. DMA mode was then inferred using the positions
> of the bits in sdhci.h.
>
> Tested on MS/MS Pro/MS Pro HG cards.
>
> Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes since RFC:
> - Fix the issuing of consecutive read/write commands.
> - DMA uses dma_alloc_coherent
> - Use debugfs for DMA/PIO path selection
> - Various PIO/DMA transfer fixes.
>
>  MAINTAINERS                         |   6 +
>  drivers/memstick/host/Kconfig       |  10 +
>  drivers/memstick/host/Makefile      |   1 +
>  drivers/memstick/host/bcm577x5_ms.c | 880 ++++++++++++++++++++++++++++
>  drivers/memstick/host/bcm577x5_ms.h | 157 +++++
>  5 files changed, 1054 insertions(+)
>  create mode 100644 drivers/memstick/host/bcm577x5_ms.c
>  create mode 100644 drivers/memstick/host/bcm577x5_ms.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5576f7d5f0a57..9ccd8084073ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5234,6 +5234,12 @@ S:       Maintained
>  F:     arch/arm/boot/dts/broadcom/bcm47189*
>  F:     arch/arm/boot/dts/broadcom/bcm53573*
>
> +BROADCOM BCM57765/BCM57785 MEMORYSTICK DRIVER
> +M:     Ho Jie Feng <hjf3108@gmail.com>
> +L:     linux-mmc@vger.kernel.org
> +S:     Maintained
> +F:     drivers/memstick/host/bcm577x5_ms.*
> +
>  BROADCOM BCM63XX/BCM33XX UDC DRIVER
>  M:     Kevin Cernekee <cernekee@gmail.com>
>  L:     linux-usb@vger.kernel.org
> diff --git a/drivers/memstick/host/Kconfig b/drivers/memstick/host/Kconfi=
g
> index fcd2c2cc3cb47..f9b18f0d85513 100644
> --- a/drivers/memstick/host/Kconfig
> +++ b/drivers/memstick/host/Kconfig
> @@ -53,3 +53,13 @@ config MEMSTICK_REALTEK_USB
>
>           To compile this driver as a module, choose M here: the module w=
ill
>           be called rts5139_ms.
> +
> +config MEMSTICK_BCM577X5
> +       tristate "Broadcom BCM57765/BCM57785 MemoryStick interface suppor=
t"
> +       depends on PCI
> +       help
> +         Say Y here if you want to access MemoryStick cards with the
> +         Broadcom BCM57765/BCM57785 PCI card reader (14e4:16be).
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called bcm577x5_ms.
> diff --git a/drivers/memstick/host/Makefile b/drivers/memstick/host/Makef=
ile
> index 0c90df33165de..8eafb70b26706 100644
> --- a/drivers/memstick/host/Makefile
> +++ b/drivers/memstick/host/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_MEMSTICK_TIFM_MS)          +=3D tifm_ms.o
>  obj-$(CONFIG_MEMSTICK_JMICRON_38X)     +=3D jmb38x_ms.o
>  obj-$(CONFIG_MEMSTICK_R592)            +=3D r592.o
>  obj-$(CONFIG_MEMSTICK_REALTEK_USB)     +=3D rtsx_usb_ms.o
> +obj-$(CONFIG_MEMSTICK_BCM577X5)                +=3D bcm577x5_ms.o
> diff --git a/drivers/memstick/host/bcm577x5_ms.c b/drivers/memstick/host/=
bcm577x5_ms.c
> new file mode 100644
> index 0000000000000..a08cabe2c9b85
> --- /dev/null
> +++ b/drivers/memstick/host/bcm577x5_ms.c
> @@ -0,0 +1,880 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/align.h>
> +#include <linux/atomic.h>
> +#include <linux/bits.h>
> +#include <linux/bug.h>
> +#include <linux/completion.h>
> +#include <linux/container_of.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/jiffies.h>
> +#include <linux/math.h>
> +#include <linux/memstick.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pci_ids.h>
> +#include <linux/pm.h>
> +#include <linux/scatterlist.h>
> +#include <linux/time64.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/workqueue.h>
> +
> +#include "bcm577x5_ms.h"
> +
> +#define DRV_NAME "bcm577x5_ms"
> +
> +static const struct pci_device_id bcm577x5_pci_id_tbl[] =3D {
> +       {
> +               PCI_VDEVICE(BROADCOM, 0x16be),
> +       },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(pci, bcm577x5_pci_id_tbl);
> +
> +static inline u32 bcm577x5_reg_readl(struct bcm577x5_device *dev, int ad=
dress)
> +{
> +       return readl(dev->mmio + address);
> +}
> +
> +static inline u16 bcm577x5_reg_readw(struct bcm577x5_device *dev, int ad=
dress)
> +{
> +       return readw(dev->mmio + address);
> +}
> +
> +static inline u8 bcm577x5_reg_readb(struct bcm577x5_device *dev, int add=
ress)
> +{
> +       return readb(dev->mmio + address);
> +}
> +
> +static inline void bcm577x5_reg_writel(struct bcm577x5_device *dev, int =
address,
> +                                      u32 value)
> +{
> +       writel(value, dev->mmio + address);
> +}
> +
> +static inline void bcm577x5_reg_writew(struct bcm577x5_device *dev, int =
address,
> +                                      u16 value)
> +{
> +       writew(value, dev->mmio + address);
> +}
> +
> +static inline void bcm577x5_reg_writeb(struct bcm577x5_device *dev, int =
address,
> +                                      u8 value)
> +{
> +       writeb(value, dev->mmio + address);
> +}
> +
> +static int bcm577x5_reg_waitb(struct bcm577x5_device *dev, int address, =
u8 mask,
> +                             u8 value, unsigned int timeout_ms)
> +{
> +       u8 reg;
> +
> +       return readb_poll_timeout(dev->mmio + address, reg,
> +                                 (reg & mask) =3D=3D value,
> +                                 BCM577x5_MS_POLL_DELAY_US,
> +                                 timeout_ms * USEC_PER_MSEC);
> +}
> +
> +static int bcm577x5_ms_reset(struct bcm577x5_device *dev, u8 reset)
> +{
> +       bcm577x5_reg_writeb(dev, BCM577x5_MS_SOFTWARE_RESET, reset);
> +
> +       return bcm577x5_reg_waitb(dev, BCM577x5_MS_SOFTWARE_RESET, reset,=
 0,
> +                                 1000);
> +}
> +
> +static int bcm577x5_ms_power(struct bcm577x5_device *dev, int power)
> +{
> +       int err;
> +
> +       switch (power) {
> +       case MEMSTICK_POWER_ON:
> +               bcm577x5_reg_writeb(dev, BCM577x5_MS_POWER_CONTROL,
> +                                   BCM577x5_MS_POWER_330);
> +               bcm577x5_reg_writeb(dev, BCM577x5_MS_POWER_CONTROL,
> +                                   BCM577x5_MS_POWER_330 |
> +                                           BCM577x5_MS_POWER_ON);
> +               err =3D bcm577x5_reg_waitb(dev, BCM577x5_MS_POWER_CONTROL=
,
> +                                        BCM577x5_MS_POWER_ON,
> +                                        BCM577x5_MS_POWER_ON, 1000);
> +               if (err)
> +                       return err;
> +
> +               msleep(20);
> +
> +               bcm577x5_reg_writel(dev, BCM577x5_MS_STATUS_MUX_CONTROL,
> +                                   bcm577x5_reg_readl(dev, BCM577x5_MS_S=
TATUS_MUX_CONTROL) |
> +                                           BCM577x5_MS_CLOCK_SOURCE_62_5=
MHZ);
> +               return 0;
> +       case MEMSTICK_POWER_OFF:
> +               bcm577x5_reg_writeb(dev, BCM577x5_MS_POWER_CONTROL, 0);
> +               bcm577x5_reg_writel(dev, BCM577x5_MS_STATUS_MUX_CONTROL,
> +                                   bcm577x5_reg_readl(dev, BCM577x5_MS_S=
TATUS_MUX_CONTROL) &
> +                                           ~BCM577x5_MS_CLOCK_SOURCE_62_=
5MHZ);
> +               return 0;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int bcm577x5_ms_clock(struct bcm577x5_device *dev, int clock_hz)
> +{
> +       int err;
> +       u16 divisor, divisor_lo, divisor_hi, clock_reg;
> +
> +       divisor =3D DIV_ROUND_UP(dev->base_clock, 2 * clock_hz);
> +       divisor_lo =3D divisor & BCM577x5_MS_DIV_MASK;
> +       divisor_hi =3D (divisor & BCM577x5_MS_DIV_HI_MASK) >> 8;
> +       clock_reg =3D (divisor_lo << BCM577x5_MS_DIVIDER_SHIFT) |
> +                   (divisor_hi << BCM577x5_MS_DIVIDER_HI_SHIFT);
> +
> +       bcm577x5_reg_writew(dev, BCM577x5_MS_CLOCK_CONTROL, clock_reg);
> +       bcm577x5_reg_writew(dev, BCM577x5_MS_CLOCK_CONTROL,
> +                           clock_reg | BCM577x5_MS_CLOCK_INT_EN);
> +       err =3D bcm577x5_reg_waitb(dev, BCM577x5_MS_CLOCK_CONTROL,
> +                                BCM577x5_MS_CLOCK_INT_STABLE,
> +                                BCM577x5_MS_CLOCK_INT_STABLE, 1000);
> +       if (err)
> +               return err;
> +       bcm577x5_reg_writew(dev, BCM577x5_MS_CLOCK_CONTROL,
> +                           clock_reg | BCM577x5_MS_CLOCK_INT_EN |
> +                                   BCM577x5_MS_CLOCK_CARD_EN);
> +       return 0;
> +}
> +
> +static int bcm577x5_ms_mode(struct bcm577x5_device *dev, int mode)
> +{
> +       u8 host_control =3D bcm577x5_reg_readb(dev, BCM577x5_MS_HOST_CONT=
ROL);
> +       u32 bridge_mode =3D bcm577x5_reg_readl(dev, BCM577x5_MS_BRIDGE_MO=
DE);
> +
> +       switch (mode) {
> +       case MEMSTICK_SERIAL:
> +               bcm577x5_reg_writel(dev, BCM577x5_MS_BRIDGE_MODE,
> +                                   bridge_mode & ~BCM577x5_MS_BRIDGE_MOD=
E_PARALLEL);
> +               bcm577x5_reg_writeb(dev, BCM577x5_MS_HOST_CONTROL,
> +                                   host_control & ~BCM577x5_MS_CTRL_4BIT=
BUS);
> +               break;
> +       case MEMSTICK_PAR4:
> +               bcm577x5_reg_writel(dev, BCM577x5_MS_BRIDGE_MODE,
> +                                   bridge_mode | BCM577x5_MS_BRIDGE_MODE=
_PARALLEL);
> +               bcm577x5_reg_writeb(dev, BCM577x5_MS_HOST_CONTROL,
> +                                   host_control | BCM577x5_MS_CTRL_4BITB=
US);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       dev->mode =3D mode;
> +       return 0;
> +}
> +
> +static int bcm577x5_ms_init(struct bcm577x5_device *dev)
> +{
> +       int error;
> +
> +       dev->prev_tpc =3D 0;
> +
> +       /* Reset the controller */
> +       error =3D bcm577x5_ms_reset(dev, BCM577x5_MS_RESET_ALL);
> +       if (error)
> +               return error;
> +
> +       /* Power cycle the controller */
> +       error =3D bcm577x5_ms_power(dev, MEMSTICK_POWER_OFF);
> +       if (error)
> +               return error;
> +       error =3D bcm577x5_ms_power(dev, MEMSTICK_POWER_ON);
> +       if (error)
> +               return error;
> +
> +       /* Set clock divider to 2 */
> +       error =3D bcm577x5_ms_clock(dev, 20000000);
> +       if (error)
> +               return error;
> +
> +       /* Set timeout */
> +       bcm577x5_reg_writeb(dev, BCM577x5_MS_TIMEOUT_CONTROL, 0xE);
> +
> +       /* Set mode */
> +       error =3D bcm577x5_ms_mode(dev, dev->mode);
> +       if (error)
> +               return error;
> +
> +       error =3D bcm577x5_ms_reset(dev, BCM577x5_MS_RESET_CMD);
> +       if (error)
> +               return error;
> +       error =3D bcm577x5_ms_reset(dev, BCM577x5_MS_RESET_DATA);
> +       if (error)
> +               return error;
> +
> +       /* Re-enable interrupts */
> +       bcm577x5_reg_writel(dev, BCM577x5_MS_INT_ENABLE,
> +                           BCM577x5_MS_INT_DEFAULT);
> +
> +       /* Avoid retriggering a card insert interrupt */
> +       bcm577x5_reg_writel(dev, BCM577x5_MS_INT_STATUS,
> +                           BCM577x5_MS_INT_CARD_INSERT);
> +       bcm577x5_reg_writel(dev, BCM577x5_MS_SIGNAL_ENABLE,
> +                           BCM577x5_MS_INT_DEFAULT);
> +
> +       return 0;
> +}
> +
> +static irqreturn_t bcm577x5_irq(int irq, void *data)
> +{
> +       struct bcm577x5_device *dev =3D data;
> +       irqreturn_t ret =3D IRQ_NONE;
> +       u32 val, status;
> +       int i;
> +
> +       val =3D bcm577x5_reg_readl(dev, BCM577x5_MS_STATUS);
> +       if (val & BCM577x5_MS_STATUS_INT_ASSERTED) {
> +               status =3D bcm577x5_reg_readl(dev, BCM577x5_MS_INT_STATUS=
);
> +               atomic_or(status, &dev->int_seen);
> +
> +               if (status & 0x100) {
> +                       bcm577x5_reg_writel(dev, BCM577x5_MS_INT_ENABLE,
> +                                           bcm577x5_reg_readl(dev,
> +                                                              BCM577x5_M=
S_INT_ENABLE) &
> +                                       ~0x100);
> +               }
> +
> +               /* Each individual bit needs to be acknowledged separatel=
y */
> +               for (i =3D 0; i < 32; i++) {
> +                       if (status & BIT(i)) {
> +                               bcm577x5_reg_writel(dev, BCM577x5_MS_INT_=
STATUS,
> +                                                   BIT(i));
> +                       }
> +               }
> +
> +               /* Signal the command or TPC is done */
> +               if (status & BCM577x5_MS_INT_RESPONSE)
> +                       complete(&dev->cmd_done);
> +
> +               /* Signal the FIFO is ready */
> +               if (status & (BCM577x5_MS_INT_DATA_AVAIL |
> +                             BCM577x5_MS_INT_SPACE_AVAIL))
> +                       complete(&dev->fifo_done);
> +
> +               if (status & BCM577x5_MS_INT_DATA_TIMEOUT)
> +                       dev_warn(&dev->pci_dev->dev, "Timeout!\n");
> +
> +               /* Signal data block transferred */
> +               if (status & BCM577x5_MS_INT_DMA_END)
> +                       complete(&dev->dma_done);
> +
> +               /* Signal end of the read/write phase */
> +               if (status & BCM577x5_MS_INT_DATA_END)
> +                       complete(&dev->data_done);
> +
> +               /* Immediately stop all ongoing requests */
> +               if (status & BCM577x5_MS_INT_CARD_REMOVE) {
> +                       complete(&dev->cmd_done);
> +                       complete(&dev->fifo_done);
> +                       complete(&dev->dma_done);
> +                       complete(&dev->data_done);
> +               }
> +
> +               if (status & (BCM577x5_MS_INT_CARD_INSERT |
> +                             BCM577x5_MS_INT_CARD_REMOVE)) {
> +                       if (status & BCM577x5_MS_INT_CARD_INSERT)
> +                               dev_info(&dev->pci_dev->dev, "Card insert=
ed\n");
> +                       else
> +                               dev_info(&dev->pci_dev->dev, "Card remove=
d\n");
> +                       memstick_detect_change(dev->host);
> +               }
> +
> +               ret =3D IRQ_HANDLED;
> +       }
> +       return ret;
> +}
> +
> +/* External interface: set settings */
> +static int bcm577x5_ms_set_param(struct memstick_host *host,
> +                                enum memstick_param param, int value)
> +{
> +       struct bcm577x5_device *dev =3D memstick_priv(host);
> +
> +       switch (param) {
> +       case MEMSTICK_POWER:
> +               return bcm577x5_ms_power(dev, value);
> +       case MEMSTICK_INTERFACE:
> +               return bcm577x5_ms_mode(dev, value);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int bcm577x5_ms_prepare_dma(struct bcm577x5_device *dev)
> +{
> +       int len =3D dev->req->sg.length;
> +       void *dma_copy_buffer;
> +       dma_addr_t dma_address;
> +
> +       if (len > 4096)
> +               return -EOPNOTSUPP;
> +
> +       reinit_completion(&dev->dma_done);
> +
> +       if (dev->req->data_dir =3D=3D WRITE) {
> +               dma_copy_buffer =3D dev->dma_buffer + 4096 - len;
> +               sg_copy_to_buffer(&dev->req->sg,
> +                                 sg_nents_for_len(&dev->req->sg, len),
> +                                 dma_copy_buffer, len);
> +       }
> +       /*
> +        * The last byte should cause an overflow interrupt on the 4096 b=
yte
> +        * boundary
> +        */
> +       dma_address =3D dev->dma_handle + 4096 - len;
> +
> +       bcm577x5_reg_writel(dev, BCM577x5_MS_DMA_ADDRESS, dma_address);
> +       return 0;
> +}
> +
> +static int bcm577x5_ms_finish_dma(struct bcm577x5_device *dev)
> +{
> +       int len =3D dev->req->sg.length;
> +       void *dma_copy_buffer;
> +
> +       if (!wait_for_completion_timeout(&dev->dma_done,
> +                                        msecs_to_jiffies(BCM577x5_MS_REQ=
_TIMEOUT_MS)))
> +               return -ETIMEDOUT;
> +
> +       if (dev->req->data_dir =3D=3D READ) {
> +               dma_copy_buffer =3D dev->dma_buffer + 4096 - len;
> +               sg_copy_from_buffer(&dev->req->sg,
> +                                   sg_nents_for_len(&dev->req->sg, len),
> +                                   dma_copy_buffer, len);
> +       }
> +
> +       return 0;
> +}
> +
> +static int bcm577x5_ms_prepare_fifo(struct bcm577x5_device *dev)
> +{
> +       if (dev->prev_tpc !=3D MS_TPC_READ_LONG_DATA &&
> +           dev->prev_tpc !=3D MS_TPC_WRITE_LONG_DATA)
> +               reinit_completion(&dev->fifo_done);
> +
> +       return 0;
> +}
> +
> +static int bcm577x5_ms_finish_fifo(struct bcm577x5_device *dev)
> +{
> +       struct sg_mapping_iter miter;
> +
> +       if (!wait_for_completion_timeout(&dev->fifo_done,
> +                                        msecs_to_jiffies(BCM577x5_MS_REQ=
_TIMEOUT_MS)))
> +               return -ETIMEDOUT;
> +
> +       sg_miter_start(&miter, &dev->req->sg, 1,
> +                      dev->req->data_dir =3D=3D READ ? SG_MITER_TO_SG :
> +                                                   SG_MITER_FROM_SG);
> +       while (sg_miter_next(&miter)) {
> +               if (WARN_ON_ONCE(!IS_ALIGNED(miter.length, 4))) {
> +                       sg_miter_stop(&miter);
> +                       return -EINVAL;
> +               }
> +               if (dev->req->data_dir =3D=3D READ)
> +                       ioread32_rep(dev->mmio + BCM577x5_MS_BUFFER,
> +                                    miter.addr, miter.length / 4);
> +               else if (dev->req->data_dir =3D=3D WRITE)
> +                       iowrite32_rep(dev->mmio + BCM577x5_MS_BUFFER,
> +                                     miter.addr, miter.length / 4);
> +       }
> +       sg_miter_stop(&miter);
> +
> +       return 0;
> +}
> +
> +static int bcm577x5_ms_execute_cmd_short(struct bcm577x5_device *dev, u3=
2 cmd)
> +{
> +       unsigned int len =3D dev->req->data_len;
> +       u8 *data =3D dev->req->data;
> +       u32 response, val;
> +       int err;
> +
> +       /* Write the data into the controller */
> +       if (dev->req->data_dir =3D=3D WRITE) {
> +               bcm577x5_reg_writel(dev, BCM577x5_MS_ARGUMENT,
> +                                   get_unaligned_le32(data));
> +               if (len > 4)
> +                       bcm577x5_reg_writel(dev, BCM577x5_MS_ARGUMENT2,
> +                                           get_unaligned_le32(data + 4))=
;
> +       }
> +
> +       reinit_completion(&dev->cmd_done);
> +       if (dev->req->tpc =3D=3D MS_TPC_SET_CMD)
> +               reinit_completion(&dev->data_done);
> +
> +       response =3D bcm577x5_reg_readl(dev, BCM577x5_MS_RESPONSE);
> +       bcm577x5_reg_writel(dev, BCM577x5_MS_TPC_REG, cmd);
> +
> +       if (!wait_for_completion_timeout(&dev->cmd_done,
> +                                        msecs_to_jiffies(100)))
> +               return -ETIMEDOUT;
> +
> +       if (dev->req->tpc =3D=3D MS_TPC_SET_CMD) {
> +               /*
> +                * The controller will execute a GET_INT command, wait fo=
r it.
> +                * Sometimes, the second interrupt will coalesce with the=
 first,
> +                * or arrive after the response changed, so wait for the =
response.
> +                */
> +               readl_poll_timeout(dev->mmio + BCM577x5_MS_RESPONSE, val,
> +                                  val !=3D response, BCM577x5_MS_POLL_DE=
LAY_US,
> +                                  100 * USEC_PER_MSEC);
> +               /* A second interrupt should come within this time */
> +               usleep_range(20, 30);
> +               if (bcm577x5_reg_readl(dev, BCM577x5_MS_INT_STATUS) &
> +                   BCM577x5_MS_INT_RESPONSE)
> +                       wait_for_completion_timeout(&dev->cmd_done,
> +                                                   msecs_to_jiffies(5));
> +
> +               /* The int reg is placed in the response register */
> +               dev->auto_int =3D
> +                       bcm577x5_reg_readl(dev, BCM577x5_MS_RESPONSE) & 0=
xFF;
> +               dev->req->int_reg =3D dev->auto_int;
> +
> +               /*
> +                * On legacy MS cards, the controller doesn't automatical=
ly issue a
> +                * GET_INT after the command is done, but it still requir=
es one to
> +                * keep working without getting stuck
> +                */
> +               dev->get_int_after_done =3D dev->auto_int =3D=3D
> +                                   (MEMSTICK_INT_CED | MEMSTICK_INT_BREQ=
);
> +
> +               /*
> +                * Reset is needed because the controller will expect cer=
tain commands
> +                * to follow the SET_CMD command, which the block driver =
may not
> +                * necessarily issue.
> +                */
> +               if (!(dev->auto_int & MEMSTICK_INT_BREQ) || dev->get_int_=
after_done) {
> +                       err =3D bcm577x5_ms_reset(dev, BCM577x5_MS_RESET_=
DATA);
> +                       if (err)
> +                               return err;
> +               }
> +       }
> +
> +       /* Read the data back */
> +       if (dev->req->data_dir =3D=3D READ) {
> +               put_unaligned_le32(bcm577x5_reg_readl(dev, BCM577x5_MS_RE=
SPONSE),
> +                                  data);
> +               if (len > 4)
> +                       put_unaligned_le32(bcm577x5_reg_readl(dev,
> +                                                             BCM577x5_MS=
_RESPONSE2),
> +                                          data + 4);
> +       }
> +
> +       return 0;
> +}
> +
> +static int bcm577x5_ms_execute_cmd_long(struct bcm577x5_device *dev, u32=
 cmd, bool use_dma)
> +{
> +       int err;
> +
> +       if (use_dma) {
> +               err =3D bcm577x5_ms_prepare_dma(dev);
> +               if (err)
> +                       use_dma =3D false;
> +       }
> +       if (!use_dma)
> +               err =3D bcm577x5_ms_prepare_fifo(dev);
> +
> +       if (use_dma)
> +               cmd |=3D BCM577x5_MS_TRNS_DMA;
> +
> +       if (dev->req->data_dir =3D=3D WRITE ||
> +           (!use_dma && !dev->get_int_after_done)) {
> +               /* PIO or DMA write has to be multi-block */
> +               bcm577x5_reg_writew(dev, BCM577x5_MS_BLOCK_COUNT, 0xFFFF)=
;
> +               cmd |=3D BCM577x5_MS_TRNS_MULTI | BCM577x5_MS_TRNS_BLK_CN=
T_EN;
> +       }
> +
> +       /* Execute the TPC */
> +       if (dev->prev_tpc =3D=3D MS_TPC_READ_LONG_DATA ||
> +           dev->prev_tpc =3D=3D MS_TPC_WRITE_LONG_DATA)
> +               /*
> +                * The controller will hang if another TPC is written,
> +                * this is a kind of continue with the last TPC command
> +                */
> +               bcm577x5_reg_writew(dev, BCM577x5_MS_TPC_REG, cmd & 0xFFF=
F);
> +       else
> +               bcm577x5_reg_writel(dev, BCM577x5_MS_TPC_REG, cmd);
> +
> +       if (use_dma)
> +               err =3D bcm577x5_ms_finish_dma(dev);
> +       else
> +               err =3D bcm577x5_ms_finish_fifo(dev);
> +
> +       if (!err && dev->get_int_after_done) {
> +               /*
> +                * On legacy MS cards, we need to manually issue a GET_IN=
T.
> +                * This GET_INT is special because it interrupts with
> +                * data_done, not cmd_done
> +                */
> +               dev->get_int_after_done =3D false;
> +               reinit_completion(&dev->data_done);
> +               bcm577x5_reg_writew(dev, BCM577x5_MS_BLOCK_SIZE, 1);
> +               bcm577x5_reg_writel(dev, BCM577x5_MS_TPC_REG,
> +                                   BCM577x5_MS_MAKE_TPC(MS_TPC_GET_INT) =
|
> +                                           BCM577x5_MS_TRNS_READ);
> +               if (!wait_for_completion_timeout(&dev->data_done,
> +                                                msecs_to_jiffies(100)))
> +                       err =3D -ETIMEDOUT;
> +       }
> +
> +       dev->auto_int =3D bcm577x5_reg_readl(dev, BCM577x5_MS_RESPONSE) &=
 0xFF;
> +       dev->req->int_reg =3D dev->auto_int;
> +
> +       return err;
> +}
> +
> +static int bcm577x5_ms_execute_cmd(struct bcm577x5_device *dev)
> +{
> +       int len =3D
> +               dev->req->long_data ? dev->req->sg.length : dev->req->dat=
a_len;
> +       bool use_dma =3D READ_ONCE(dev->enable_dma);
> +       unsigned long timeout;
> +       int err;
> +       u32 cmd;
> +
> +       /* Immediately return if there is no card inserted */
> +       if (!(bcm577x5_reg_readl(dev, BCM577x5_MS_STATUS) &
> +             BCM577x5_MS_STATUS_MS_DETECT))
> +               return -ENODEV;
> +
> +       if (dev->req->tpc =3D=3D MS_TPC_GET_INT && dev->auto_int &&
> +           (dev->prev_tpc =3D=3D MS_TPC_SET_CMD ||
> +            dev->prev_tpc =3D=3D MS_TPC_READ_LONG_DATA ||
> +            dev->prev_tpc =3D=3D MS_TPC_WRITE_LONG_DATA)) {
> +               dev->req->data[0] =3D dev->auto_int;
> +               dev->req->int_reg =3D dev->auto_int;
> +               dev->auto_int =3D 0;
> +               return 0;
> +       }
> +
> +       if (dev->req->tpc =3D=3D MS_TPC_GET_INT &&
> +           dev->prev_tpc =3D=3D MS_TPC_READ_LONG_DATA && use_dma) {
> +               /*
> +                * The controller doesn't respond to any command until DA=
TA_END
> +                * is completed.
> +                */
> +               if (!wait_for_completion_timeout(&dev->data_done,
> +                                                msecs_to_jiffies(BCM577x=
5_MS_REQ_TIMEOUT_MS)))
> +                       return -ETIMEDOUT;
> +
> +               err =3D bcm577x5_ms_reset(dev, BCM577x5_MS_RESET_DATA);
> +               if (err)
> +                       return err;
> +       }
> +
> +       /* PIO has no DATA_END but needs the same treatment */
> +       if (dev->req->tpc =3D=3D MS_TPC_GET_INT &&
> +           (dev->prev_tpc =3D=3D MS_TPC_WRITE_LONG_DATA ||
> +            (dev->prev_tpc =3D=3D MS_TPC_READ_LONG_DATA && !use_dma))) {
> +               /*
> +                * There seems to be no way to wait for the command to ac=
tually finish,
> +                * since DMA_END only signals the data is in the controll=
er, but may not
> +                * be fully written into the card. Instead, the controlle=
r ignores any
> +                * commands until it is done, so keep issuing GET_INT unt=
il it
> +                * goes through
> +                */
> +               bcm577x5_reg_writel(dev, BCM577x5_MS_BLOCK_SIZE, len);
> +               cmd =3D BCM577x5_MS_MAKE_TPC(MS_TPC_GET_INT) | BCM577x5_M=
S_TRNS_READ;
> +               timeout =3D jiffies + msecs_to_jiffies(BCM577x5_MS_REQ_TI=
MEOUT_MS);
> +               /* A small wait is needed for the write data to be fully =
written */
> +               if (dev->prev_tpc =3D=3D MS_TPC_WRITE_LONG_DATA)
> +                       usleep_range(150, 300);
> +               while (!time_after(jiffies, timeout)) {
> +                       reinit_completion(&dev->cmd_done);
> +                       bcm577x5_reg_writel(dev, BCM577x5_MS_TPC_REG, cmd=
);
> +                       /* 1 jiffy is too coarse */
> +                       usleep_range(200, 220);
> +                       if (completion_done(&dev->cmd_done))
> +                               break;
> +               }
> +               if (!completion_done(&dev->cmd_done))
> +                       return -ETIMEDOUT;
> +
> +               dev->req->data[0] =3D
> +                       bcm577x5_reg_readl(dev, BCM577x5_MS_RESPONSE) & 0=
xFF;
> +               dev->req->int_reg =3D dev->req->data[0];
> +               if (!(dev->req->data[0] & MEMSTICK_INT_CED))
> +                       return 0;
> +
> +               dev->prev_tpc =3D dev->req->tpc;
> +               return bcm577x5_ms_reset(dev, BCM577x5_MS_RESET_CMD |
> +                                             BCM577x5_MS_RESET_DATA);
> +       }
> +
> +       /* Same for the next page of a write */
> +       if (dev->req->tpc =3D=3D MS_TPC_WRITE_LONG_DATA &&
> +           dev->prev_tpc =3D=3D MS_TPC_WRITE_LONG_DATA)
> +               usleep_range(100, 120);
> +
> +       /* Write the length of the transfer */
> +       bcm577x5_reg_writel(dev, BCM577x5_MS_BLOCK_SIZE, len);
> +
> +       /* Create the execution command */
> +       cmd =3D BCM577x5_MS_MAKE_TPC(dev->req->tpc);
> +       if (dev->req->data_dir =3D=3D READ)
> +               cmd |=3D BCM577x5_MS_TRNS_READ;
> +
> +       /*
> +        * Two types of transfers have very different flow,
> +        * so split them into functions
> +        */
> +       if (dev->req->long_data)
> +               err =3D bcm577x5_ms_execute_cmd_long(dev, cmd, use_dma);
> +       else
> +               err =3D bcm577x5_ms_execute_cmd_short(dev, cmd);
> +
> +       dev->prev_tpc =3D dev->req->tpc;
> +       return err;
> +}
> +
> +static void bcm577x5_ms_req_process(struct work_struct *data)
> +{
> +       struct bcm577x5_device *dev =3D
> +               container_of(data, struct bcm577x5_device, req_work);
> +       int err, cmderr =3D 0;
> +
> +       /* Already processing requests */
> +       if (dev->req)
> +               return;
> +
> +       mutex_lock(&dev->req_lock);
> +       do {
> +               err =3D memstick_next_req(dev->host, &dev->req);
> +
> +               if (!err && completion_done(&dev->host->card->mrq_complet=
e)) {
> +                       dev->req =3D NULL;
> +                       break;
> +               }
> +
> +               if (!err) {
> +                       atomic_set(&dev->int_seen, 0);
> +                       cmderr =3D bcm577x5_ms_execute_cmd(dev);
> +                       if (atomic_read(&dev->int_seen) &
> +                           BCM577x5_MS_INT_CARD_REMOVE)
> +                               cmderr =3D -ENODEV;
> +                       dev->req->error =3D cmderr;
> +               }
> +       } while (!err && !cmderr);
> +
> +       if (cmderr) {
> +               /* Reset the controller so it accepts new commands */
> +               bcm577x5_ms_init(dev);
> +
> +               /* Controller will not respond to any more commands anywa=
y */
> +               while (!err && dev->req) {
> +                       dev->req->error =3D cmderr;
> +                       err =3D memstick_next_req(dev->host, &dev->req);
> +               }
> +       }
> +       mutex_unlock(&dev->req_lock);
> +}
> +
> +static void bcm577x5_ms_submit_req(struct memstick_host *host)
> +{
> +       struct bcm577x5_device *dev =3D memstick_priv(host);
> +
> +       schedule_work(&dev->req_work);
> +}
> +
> +static int bcm577x5_probe(struct pci_dev *pdev, const struct pci_device_=
id *id)
> +{
> +       int error;
> +       struct memstick_host *host;
> +       struct bcm577x5_device *dev;
> +       u32 val;
> +
> +       host =3D memstick_alloc_host(sizeof(struct bcm577x5_device), &pde=
v->dev);
> +       if (!host)
> +               return -ENOMEM;
> +
> +       dev =3D memstick_priv(host);
> +       dev->host =3D host;
> +       dev->pci_dev =3D pdev;
> +       pci_set_drvdata(pdev, dev);
> +
> +       error =3D pci_enable_device(pdev);
> +       if (error)
> +               goto err_free_host;
> +
> +       pci_set_master(pdev);
> +
> +       error =3D pci_request_regions(pdev, DRV_NAME);
> +       if (error)
> +               goto err_disable_device;
> +
> +       dev->mmio =3D pci_ioremap_bar(pdev, 0);
> +       if (!dev->mmio) {
> +               error =3D -EIO;
> +               goto err_release_regions;
> +       }
> +
> +       INIT_WORK(&dev->req_work, bcm577x5_ms_req_process);
> +
> +       host->caps =3D MEMSTICK_CAP_PAR4 | MEMSTICK_CAP_AUTO_GET_INT;
> +       host->request =3D bcm577x5_ms_submit_req;
> +       host->set_param =3D bcm577x5_ms_set_param;
> +
> +       val =3D bcm577x5_reg_readl(dev, BCM577x5_MS_CAPABILITY_SLOT2);
> +
> +       /* An alternate clock source is found that gives higher write rel=
iability */
> +       dev->base_clock =3D 62500000;
> +
> +       if (val & BCM577x5_MS_CAPABILITY_SDMA) {
> +               dev->enable_dma =3D true;
> +               if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32=
))) {
> +                       dev_warn(&pdev->dev, "No suitable DMA available\n=
");
> +                       dev->enable_dma =3D false;
> +               }
> +       }
> +
> +       if (dev->enable_dma) {
> +               /*
> +                * This needs to be 4096 aligned since the hardware does
> +                * not seem to issue a dma complete interrupt, so we have
> +                * to rely on address line overflows to detect completion=
.
> +                */
> +               dev->dma_buffer =3D dma_alloc_coherent(&pdev->dev, 4096,
> +                                                    &dev->dma_handle,
> +                                                    GFP_KERNEL);
> +               if (!dev->dma_buffer) {
> +                       dev_warn(&pdev->dev,
> +                                "DMA memory alloc failed, disabling\n");
> +                       dev->enable_dma =3D false;
> +               }
> +       }
> +
> +       /* Disable interrupts */
> +       bcm577x5_reg_writel(dev, BCM577x5_MS_INT_ENABLE, 0);
> +       bcm577x5_reg_writel(dev, BCM577x5_MS_SIGNAL_ENABLE, 0);
> +
> +       dev->irq =3D pdev->irq;
> +       dev_info(&pdev->dev, "Rev %c%c dma=3D%d clock=3D%dHz irq=3D%d\n",
> +                (pdev->revision >> 3) + 'A', (pdev->revision & 0b111) + =
'0',
> +                dev->enable_dma, dev->base_clock, dev->irq);
> +
> +       mutex_init(&dev->req_lock);
> +       init_completion(&dev->cmd_done);
> +       init_completion(&dev->fifo_done);
> +       init_completion(&dev->dma_done);
> +       init_completion(&dev->data_done);
> +       error =3D request_irq(dev->irq, &bcm577x5_irq, IRQF_SHARED, DRV_N=
AME, dev);
> +       if (error)
> +               goto err_iounmap;
> +
> +       error =3D bcm577x5_ms_init(dev);
> +       if (error)
> +               goto err_free_irq;
> +
> +       error =3D memstick_add_host(host);
> +       if (error)
> +               goto err_free_irq;
> +
> +       /* Switch between the DMA and PIO paths at runtime */
> +       if (dev->enable_dma) {
> +               dev->debugfs =3D debugfs_create_dir(dev_name(&pdev->dev),=
 NULL);
> +               debugfs_create_bool("enable_dma", 0644, dev->debugfs,
> +                                   &dev->enable_dma);
> +       }
> +
> +       return 0;
> +err_free_irq:
> +       bcm577x5_ms_power(dev, MEMSTICK_POWER_OFF);
> +       bcm577x5_reg_writel(dev, BCM577x5_MS_INT_ENABLE, 0);
> +       bcm577x5_reg_writel(dev, BCM577x5_MS_SIGNAL_ENABLE, 0);
> +       free_irq(dev->irq, dev);
> +err_iounmap:
> +       iounmap(dev->mmio);
> +       if (dev->dma_buffer) {
> +               dma_free_coherent(&dev->pci_dev->dev, 4096, dev->dma_buff=
er,
> +                                 dev->dma_handle);
> +       }
> +err_release_regions:
> +       pci_release_regions(pdev);
> +err_disable_device:
> +       pci_disable_device(pdev);
> +err_free_host:
> +       memstick_free_host(host);
> +       return error;
> +}
> +
> +static void bcm577x5_remove(struct pci_dev *pdev)
> +{
> +       struct bcm577x5_device *dev =3D pci_get_drvdata(pdev);
> +
> +       debugfs_remove(dev->debugfs);
> +
> +       dev->host->removing =3D true;
> +       memstick_remove_host(dev->host);
> +
> +       /* Cancel the work before interrupts are disabled */
> +       cancel_work_sync(&dev->req_work);
> +
> +       /* Clear interrupts */
> +       bcm577x5_reg_writel(dev, BCM577x5_MS_INT_ENABLE, 0);
> +       bcm577x5_reg_writel(dev, BCM577x5_MS_SIGNAL_ENABLE, 0);
> +
> +       if (dev->dma_buffer) {
> +               dma_free_coherent(&dev->pci_dev->dev, 4096, dev->dma_buff=
er,
> +                                 dev->dma_handle);
> +       }
> +
> +       free_irq(dev->irq, dev);
> +       iounmap(dev->mmio);
> +       pci_release_regions(pdev);
> +       pci_disable_device(pdev);
> +       memstick_free_host(dev->host);
> +}
> +
> +static int bcm577x5_ms_suspend(struct device *pdev)
> +{
> +       struct bcm577x5_device *dev =3D dev_get_drvdata(pdev);
> +
> +       memstick_suspend_host(dev->host);
> +       return 0;
> +}
> +
> +static int bcm577x5_ms_resume(struct device *pdev)
> +{
> +       struct bcm577x5_device *dev =3D dev_get_drvdata(pdev);
> +       int error;
> +
> +       error =3D bcm577x5_ms_init(dev);
> +       if (error)
> +               return error;
> +
> +       memstick_resume_host(dev->host);
> +       return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(bcm577x5_ms_pm_ops, bcm577x5_ms_suspend,
> +                               bcm577x5_ms_resume);
> +
> +static struct pci_driver bcm577x5_pci_driver =3D {
> +       .name =3D DRV_NAME,
> +       .id_table =3D bcm577x5_pci_id_tbl,
> +       .probe =3D bcm577x5_probe,
> +       .remove =3D bcm577x5_remove,
> +       .driver.pm =3D pm_sleep_ptr(&bcm577x5_ms_pm_ops),
> +};
> +
> +module_pci_driver(bcm577x5_pci_driver);
> +
> +MODULE_AUTHOR("Ho Jie Feng <hjf3108@gmail.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("BCM577x5 MS/MSPro card reader driver");
> diff --git a/drivers/memstick/host/bcm577x5_ms.h b/drivers/memstick/host/=
bcm577x5_ms.h
> new file mode 100644
> index 0000000000000..80b0703a43b3a
> --- /dev/null
> +++ b/drivers/memstick/host/bcm577x5_ms.h
> @@ -0,0 +1,157 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef BCM577X5_MS_H
> +#define BCM577X5_MS_H
> +
> +#include <linux/compiler_types.h>
> +#include <linux/completion.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>
> +
> +struct memstick_host;
> +struct memstick_request;
> +struct pci_dev;
> +struct dentry;
> +
> +struct bcm577x5_device {
> +       struct pci_dev *pci_dev;
> +       struct memstick_host    *host;          /* host backpointer */
> +       struct memstick_request *req;           /* current request */
> +
> +       /* Registers, IRQ */
> +       void __iomem *mmio;
> +       int irq;
> +
> +       /* Command execution */
> +       struct work_struct req_work;
> +       struct mutex req_lock;          /* prevent concurrent requests */
> +       struct completion cmd_done;
> +       struct completion fifo_done;
> +       atomic_t int_seen;
> +       unsigned char prev_tpc;
> +       u8 auto_int;
> +       bool get_int_after_done;
> +       int mode;
> +
> +       /* DMA execution */
> +       bool enable_dma;
> +       struct dentry *debugfs;
> +       struct completion dma_done;
> +       struct completion data_done;
> +       void *dma_buffer;
> +       dma_addr_t dma_handle;
> +
> +       /* Device properties */
> +       int base_clock;
> +};
> +
> +#define BCM577x5_MS_POLL_DELAY_US 10
> +#define BCM577x5_MS_REQ_TIMEOUT_MS 450
> +
> +/*
> + * Controller registers (from sdhci.h)
> + * Registers are almost exactly the same as sdhci registers, reuse them
> + */
> +
> +#define BCM577x5_MS_DMA_ADDRESS                0x00
> +#define BCM577x5_MS_BLOCK_SIZE         0x04
> +#define BCM577x5_MS_BLOCK_COUNT                0x06
> +#define BCM577x5_MS_ARGUMENT           0x08
> +
> +#define BCM577x5_MS_TPC_REG            0x0C
> +#define BCM577x5_MS_MAKE_TPC(c) ((((c) << 4) | ((c) ^ 0xF)) << 24)
> +#define  BCM577x5_MS_TRNS_DMA          0x01
> +#define  BCM577x5_MS_TRNS_BLK_CNT_EN   0x02
> +#define  BCM577x5_MS_TRNS_READ         0x10
> +#define  BCM577x5_MS_TRNS_MULTI                0x20
> +
> +#define BCM577x5_MS_RESPONSE           0x10
> +#define BCM577x5_MS_RESPONSE2          0x14
> +#define BCM577x5_MS_BUFFER             0x20
> +
> +/* This can be used as a logic analyzer */
> +#define BCM577x5_MS_PRESENT_STATE      0x24
> +#define  BCM577x5_MS_DATA_LVL_MASK     0x00F00000
> +#define  BCM577x5_MS_CMD_LVL           0x01000000
> +
> +#define BCM577x5_MS_HOST_CONTROL       0x28
> +#define  BCM577x5_MS_CTRL_4BITBUS      0x02
> +#define  BCM577x5_MS_CTRL_8BITBUS      0x20
> +
> +#define BCM577x5_MS_POWER_CONTROL      0x29
> +#define  BCM577x5_MS_POWER_ON          0x01
> +#define  BCM577x5_MS_POWER_330         0x0E
> +
> +#define BCM577x5_MS_CLOCK_CONTROL      0x2C
> +#define  BCM577x5_MS_DIVIDER_SHIFT     8
> +#define  BCM577x5_MS_DIVIDER_HI_SHIFT  6
> +#define  BCM577x5_MS_DIV_MASK          0xFF
> +#define  BCM577x5_MS_DIV_HI_MASK       0x300
> +#define  BCM577x5_MS_CLOCK_CARD_EN     0x0004
> +#define  BCM577x5_MS_CLOCK_INT_STABLE  0x0002
> +#define  BCM577x5_MS_CLOCK_INT_EN      0x0001
> +
> +#define BCM577x5_MS_TIMEOUT_CONTROL    0x2E
> +
> +#define BCM577x5_MS_SOFTWARE_RESET     0x2F
> +#define  BCM577x5_MS_RESET_ALL         0x01
> +#define  BCM577x5_MS_RESET_CMD         0x02
> +#define  BCM577x5_MS_RESET_DATA                0x04
> +
> +#define BCM577x5_MS_INT_STATUS         0x30
> +#define BCM577x5_MS_INT_ENABLE         0x34
> +#define BCM577x5_MS_SIGNAL_ENABLE      0x38
> +#define  BCM577x5_MS_INT_RESPONSE      0x00000001
> +#define  BCM577x5_MS_INT_DATA_END      0x00000002
> +#define  BCM577x5_MS_INT_BLK_GAP       0x00000004
> +#define  BCM577x5_MS_INT_DMA_END       0x00000008
> +#define  BCM577x5_MS_INT_SPACE_AVAIL   0x00000010
> +#define  BCM577x5_MS_INT_DATA_AVAIL    0x00000020
> +#define  BCM577x5_MS_INT_CARD_INSERT_2 0x00000040
> +#define  BCM577x5_MS_INT_CARD_REMOVE   0x00000080
> +#define  BCM577x5_MS_INT_CARD_INT      0x00000100
> +#define  BCM577x5_MS_INT_RETUNE                0x00001000
> +#define  BCM577x5_MS_INT_CQE           0x00004000
> +#define  BCM577x5_MS_INT_ERROR         0x00008000
> +#define  BCM577x5_MS_INT_TIMEOUT       0x00010000
> +#define  BCM577x5_MS_INT_CRC           0x00020000
> +#define  BCM577x5_MS_INT_END_BIT       0x00040000
> +#define  BCM577x5_MS_INT_INDEX         0x00080000
> +#define  BCM577x5_MS_INT_DATA_TIMEOUT  0x00100000
> +#define  BCM577x5_MS_INT_DATA_CRC      0x00200000
> +#define  BCM577x5_MS_INT_DATA_END_BIT  0x00400000
> +#define  BCM577x5_MS_INT_BUS_POWER     0x00800000
> +#define  BCM577x5_MS_INT_AUTO_CMD_ERR  0x01000000
> +#define  BCM577x5_MS_INT_ADMA_ERROR    0x02000000
> +#define  BCM577x5_MS_INT_CARD_INSERT   0x40000000
> +
> +#define BCM577x5_MS_INT_DEFAULT                                         =
       \
> +       (BCM577x5_MS_INT_RESPONSE | BCM577x5_MS_INT_DATA_END |           =
      \
> +        BCM577x5_MS_INT_DMA_END | BCM577x5_MS_INT_SPACE_AVAIL |         =
      \
> +        BCM577x5_MS_INT_DATA_AVAIL | BCM577x5_MS_INT_CARD_INSERT_2 |    =
      \
> +        BCM577x5_MS_INT_CARD_REMOVE | BCM577x5_MS_INT_TIMEOUT |         =
      \
> +        BCM577x5_MS_INT_CRC | BCM577x5_MS_INT_END_BIT |                 =
      \
> +        BCM577x5_MS_INT_INDEX | BCM577x5_MS_INT_DATA_TIMEOUT |          =
      \
> +        BCM577x5_MS_INT_DATA_CRC | BCM577x5_MS_INT_DATA_END_BIT |       =
      \
> +        BCM577x5_MS_INT_BUS_POWER | BCM577x5_MS_INT_ADMA_ERROR |        =
      \
> +        BCM577x5_MS_INT_CARD_INSERT)
> +
> +#define BCM577x5_MS_ARGUMENT2  0xF4
> +
> +#define BCM577x5_MS_BRIDGE_MODE                                0x180
> +#define  BCM577x5_MS_BRIDGE_MODE_PARALLEL              0x02000000
> +
> +#define BCM577x5_MS_STATUS                             0x190
> +#define  BCM577x5_MS_STATUS_INT_ASSERTED               0x00000002
> +#define  BCM577x5_MS_STATUS_MS_DETECT                  0x00004000
> +
> +#define BCM577x5_MS_STATUS_MUX_CONTROL                 0x198
> +#define  BCM577x5_MS_CLOCK_SOURCE_62_5MHZ              0x00003000
> +
> +#define BCM577x5_MS_CAPABILITY_SLOT2                   0x1A8
> +#define  BCM577x5_MS_CAPABILITY_SDMA                   0x00100000
> +#define BCM577x5_MS_CAPABILITY_BASE_CLOCK_MASK         0x00007F80
> +#define  BCM577x5_MS_CAPABILITY_BASE_CLOCK_SHIFT       7
> +#define BCM577x5_MS_CAPABILITY_TIMEOUT_CLOCK_MASK      0x0000003F
> +
> +#endif /* BCM577X5_MS_H */
>
> base-commit: fd9af27f6c2319713bb23832066585f8a59a1771
> --
> 2.55.0
>
