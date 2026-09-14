Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3720424D6A
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380572; cv=pass; b=AD35anK/u2D041usu9WJ4PAWvlAzT/4ClNO0IlHJzbM593QulXmUPNLghq9XGvlpIMs7W/ldpLQWYAMgPwktpu/+bv0VxmZhmwjZoTbzhe/cGA+MbzGDEvVe1OjypmokMPixm20sOBhAA5Qk1Kicbmh4mGW0Dv8hOplb1Y/GUp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380572; c=relaxed/simple;
	bh=lYGwUA2Xxra6KgKrHICgQUeDiCGOArIbNNRe9D84Uc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KL8PAW0vN1XehGsfEs6lbDvYTr+HTGD8QwFgyxO0O8NgPVTOHkx0+/LSz8u0X9wzC2kE0iDIxnFBletIiYBbm4iFFQ4m7NC3iXTVawWM7To2UL3Fi7+XSO6Qfp1RVxB4+U4dtmUD4IJkGqkUfnpgw+dnJ0EK+WelUsWMN/FmqpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DTJWsWax; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BloN282o; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DTJWsWax";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BloN282o"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E9ndt6184537
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 10:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MUkfAr3dLBYHJ43VED259V7T5siL3Nd9v9HANDkn5BA=; b=DTJWsWaxEWcyQxd7
	/zc8B2l8YfzSEJu1xocwPAoboX3DoCDxB7PEY/LideHUdL2MgdUoVbBdpcMPVOTw
	MkZaKJeoGtDfgrYhp6hhfa+UxAZHNucMsblfD9392xgKUn2zeJRsSBDqiy0vPgOy
	CbEwG0IG9SMgIm9j1VvH5sEUvFB0KRdW4DIRQ9lXWGOXWl0unTrNuKRmulXkK9xP
	YJzQn4VyPMOs3Pz1QzyWl9nV7XFlRZFJtakhVP8s0a3pF+qB9IcD4Z/AdhWEWUeC
	Hdc/rlib/HRq8aq7qFrtZwjWCE0nVAV9ZkeR3LOBZ8aRKxjViixoDuZT0cdq0zBd
	0TR9fQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c633g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 10:09:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d6df0a1e18so62066445ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 03:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789380568; cv=none;
        d=google.com; s=arc-20260327;
        b=ocWhvmOLZtPnyWolxve3zRInU/yUEB51adMyLK0rIjRtQoTxc3hvStKA4MiD96mtTa
         UZt/XoPEl+VBLCT2ZrQqEYEd8XRmGDfx8AJTCfQRNGR7r9F/+KGiXsG4U6PEJhH644IB
         SuuZ+FShN1hl1FcDK7OTboUF4RJXqa+U0e0Z4Af6oO4ZvRqnC8zUbKjZ3TQ8HNygwwIE
         dAfKsArgKYpsoMbPnTgsEFg4lq0yqPEpp6M0+aqxOcN+OLiPIFTWdeCCPph3CKtw5XGJ
         RrOa4K25yMC3Xsh3NO+J9vt9yuP8ANWwN+loi9f+/gIVHGuTit8NoPrXh2qSLq/V0qCg
         3fEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MUkfAr3dLBYHJ43VED259V7T5siL3Nd9v9HANDkn5BA=;
        fh=xgcTsYlOueFNMsJzT0UZ+spoOwxXd0VXJ0/H98R9PaY=;
        b=rCXFrKJ/JbTlMB15mhztvgORgw+YAAJpFUfB9OPKn/DJXmJZ41DujwRQ4uitT5P3kz
         0azlNUCswpkboteQ4x3cItSipsN8BuJIicdlZq8dKi1jWaKkRJ7g0kj2pS3+UVI6+A0a
         bPVLMn1/uhbkFLD3e9fSHexAQ/dxWbX3HKkiKZrrEwvj4MvL9BHXBWPXfUqNyX12zJdv
         fNRJeBw6XMMKN2Cik9ZFcyyERyKAr88XYiANbpDB6DKEH3Jre9XvHXcouv78+154fCXa
         QDnHuKimycXDF3rHcmEI6ofcAXouomQOkXprNWtQw1Trfl3PxupQkQLEv3O2IkQJc+jP
         wTyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789380568; x=1789985368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MUkfAr3dLBYHJ43VED259V7T5siL3Nd9v9HANDkn5BA=;
        b=BloN282odbzzEWbr6yDhSvGJIOYXvMlbC/n6XlxwdewmvU3pEggpVAHhmnex+t/Syj
         v8IveSQ9PqYICc17oLIn3SZlLCmsU/aZOGK2MuCsfG/AsW1g0cTaqf+jGnipk2RUN5CU
         fWvxs1lNv4zxqRoui2jSLRzAQ0xsa/yWxjRV1JvobFaR4Z5IjrQH1tVPXYG9OpxEYKrx
         gpRMS9e2mLy5gsiT2DQsArm/EMukKvYW5sT96hcU7xJSHRNh90UoWgHjyxBh0yco/cND
         lGZT4JdaGvMvW3cRgNMjpcoafQlPVNmturgCAK1Oa+Iaf0PC86Ecj6DkgjQ5e5Kxeu66
         TpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789380568; x=1789985368;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MUkfAr3dLBYHJ43VED259V7T5siL3Nd9v9HANDkn5BA=;
        b=khuuYHEs64Dzz/Euk5jd5pfoBYC7U9unOhUsaNYE7oOkukL1Co+WvxgDmlmf9NsE+H
         IeKHwwnuRTHEJsurMqJFUMCJVcThgsmqNpK0Ks4pV3kG9ndSWVWRURllPIEMWzJW78SE
         SNHFLk/Runq1VlKVwIJWTNYmAqo5o0uyzdTtva2O4WDMBytPg1l2YDghkgM++ENG5n9/
         1vsQd4xEAk1KzK+/N0qA2GtwXZ7SIKlBhe/mP+OyzDXVGfH8mQXDPihIa7etURd5Mjcz
         XWw4NEXUaxnWS9tmbhCSthJPHMayhFA7jgkqsepi9gRnQc8KGK+7hEtvhj7E5Xlp002Y
         sCNQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7+dIFfe9afevhSvuTQax9lOzgNV39XWGjjNsoaeWaMHQ4Wv37Pdj5xDZlm/xUbJwJM98t0HY4BN0=@vger.kernel.org
X-Gm-Message-State: AFuF++ku12AE3YUQ0RnNJ4can5+6EquskXeF2FbvPQgRm64O6DglEpiy
	S7NvrV60NbdCd4ZSWMwx5h70vlOyDOAMkU3h+vZdnD4CthsUj+4KunqUk+kWVT+i48mkacCvzJ0
	I4b3+qOhsL/khrkTXt2BXb2RrYummpJ0ZRiCKegjsmreVdC/in+xoMThmW2K3fliwhbPie3ZyuT
	tiUkivr5jhWjztoRSupwTqpESy3njOdfcX8upqPa3y8VCP2w==
X-Gm-Gg: AYBFou0dke5eWIvHayxiiTPH6bFCN0f7M1bQ1gXwyhWbywKmAgD+32AxhZWSUGt4aVL
	HLT2/ksTt00Qsh/25ecQjWXtrdRCUHzP3SuH5pc94bGin4DXqWL8tkX0HOcw5g1DYLCoXc9f05R
	4zFgxeoUkunb1DlxrHDa2l4y8xQSDuH9zmD7s6ptDIjDopqNGg1q7nyWl4YA==
X-Received: by 2002:a17:902:fc4c:b0:2d9:123c:8c49 with SMTP id d9443c01a7336-2dd6c6db8b7mr42625845ad.14.1789380568260;
        Mon, 14 Sep 2026 03:09:28 -0700 (PDT)
X-Received: by 2002:a17:902:fc4c:b0:2d9:123c:8c49 with SMTP id
 d9443c01a7336-2dd6c6db8b7mr42625125ad.14.1789380567732; Mon, 14 Sep 2026
 03:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907064632.8926-1-hemanth.selam@gmail.com>
In-Reply-To: <20260907064632.8926-1-hemanth.selam@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:09:15 +0200
X-Gm-Features: AcwNN1UHbb7Un59MqnfrrdPT2h7Y8EIzqrVWafIOztdgL3w_NXx4_dDPh0RBRQM
Message-ID: <CAPx+jO8KoLW+dpKrgdAnwDpWxNn-uJcUGS_j-VUGyW6YPTXoMw@mail.gmail.com>
Subject: Re: [PATCH] mmc: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, Nicolas Pitre <nico@fluxnic.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: mbzYcHrlmJ5YlwoJKRhR7-JB_TMKzQDr
X-Proofpoint-GUID: mbzYcHrlmJ5YlwoJKRhR7-JB_TMKzQDr
X-Authority-Analysis: v=2.4 cv=c5Y+0h9l c=1 sm=1 tr=0 ts=6aa7c7d9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8 a=_vvJFgV3Y_p9qj4_XX8A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE0NSBTYWx0ZWRfX8HA8FmvDEenK
 KYq8rnY2SFCbZNFnct6KfZVZ+v+9KDH6ozXoe9YFDpcZy8iDKBfNCOZAUrXfINL4Gky7S4eMVv6
 WFl0ddn5CvDCzavdtPDQW3L8Fa633Fxub7Zvx78zGdMBp1/jaRW4A5H/ohkZQnE9RcU4uvKV9Qb
 2j5S6+CMRx9DX3XlcApiY6SX/yuKm+pi8Hht6Q134yexfgiHXc6/VpMlrJKhbE5QAW2j7m2/LUR
 rp7MO+HwOAQMy0d4vSV2cp+5RDxb6C+f02jNOSGvslLI4zLwBNnAEjj7X8BGsbD38b9q8YukdSo
 Ii4lkNG3xapiIoC7gUz5m7xnf6XhkChPBiF+oDSn2C8tRMAtFpsAHm5ken3VH4scn17Cwh+yNjT
 gW4KfmQyVaA2tzxIsGm83DL8fLTS+iWa12UkDIM8kiVOpoIQEdoVRUDoQy5nSJMk53/LWTh7qiB
 SmXvd8MKjt7vsFLWu4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE0NSBTYWx0ZWRfX4mZktAd6g1vG
 H3fm72oIxfQRFlR3N9bbii7XwXZmF25G2bhKuh9Qlf1kWYt0W1lQoRhf/i2yrMh3keazOuCaoaQ
 yWBHs2oQApCBSSoW1l6KKH5dU1AcQKU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140145

On Mon, Sep 7, 2026 at 8:46=E2=80=AFAM Hemanth Selam <hemanth.selam@gmail.c=
om> wrote:
>
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
>
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c  | 2 +-
>  drivers/memstick/host/r592.c      | 2 +-
>  drivers/mmc/core/block.c          | 2 +-
>  drivers/mmc/core/core.c           | 2 +-
>  drivers/mmc/core/mmc.c            | 2 +-
>  drivers/mmc/host/bcm2835.c        | 2 +-
>  drivers/mmc/host/dw_mmc.h         | 2 +-
>  drivers/mmc/host/mvsdio.c         | 2 +-
>  drivers/mmc/host/sdhci-msm.c      | 2 +-
>  drivers/mmc/host/sdhci-of-esdhc.c | 2 +-
>  drivers/mmc/host/sdhci-omap.c     | 2 +-
>  drivers/mmc/host/sdhci.h          | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_=
block.c
> index ce33907bfc24..e2bf563ccbe1 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -720,7 +720,7 @@ static int h_msb_parallel_switch(struct memstick_dev =
*card,
>
>  static int msb_switch_to_parallel(struct msb_data *msb);
>
> -/* Reset the card, to guard against hw errors beeing treated as bad bloc=
ks */
> +/* Reset the card, to guard against hw errors being treated as bad block=
s */
>  static int msb_reset(struct msb_data *msb, bool full)
>  {
>
> diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
> index 605b2265536f..dc3de63901be 100644
> --- a/drivers/memstick/host/r592.c
> +++ b/drivers/memstick/host/r592.c
> @@ -289,7 +289,7 @@ static int r592_transfer_fifo_dma(struct r592_device =
*dev)
>         dev->dma_error =3D 0;
>         reinit_completion(&dev->dma_done);
>
> -       /* TODO: hidden assumption about nenth beeing always 1 */
> +       /* TODO: hidden assumption about nenth being always 1 */
>         sg_count =3D dma_map_sg(&dev->pci_dev->dev, &dev->req->sg, 1, is_=
write ?
>                               DMA_TO_DEVICE : DMA_FROM_DEVICE);
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index e760d13ee325..a02bb2fee874 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -86,7 +86,7 @@ MODULE_ALIAS("mmc:block");
>  static DEFINE_MUTEX(block_mutex);
>
>  /*
> - * The defaults come from config options but can be overriden by module
> + * The defaults come from config options but can be overridden by module
>   * or bootarg options.
>   */
>  static int perdev_minors =3D CONFIG_MMC_BLOCK_MINORS;
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 29e80e5f928e..08d41f0996de 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2004,7 +2004,7 @@ unsigned int mmc_calc_max_discard(struct mmc_card *=
card)
>
>         /*
>          * Without erase_group_def set, MMC erase timeout depends on cloc=
k
> -        * frequence which can change.  In that case, the best choice is
> +        * frequency which can change.  In that case, the best choice is
>          * just the preferred erase size.
>          */
>         if (mmc_card_mmc(card) && !(card->ext_csd.erase_group_def & 1))
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 05444ecf3909..a02b04938e1a 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1015,7 +1015,7 @@ static void mmc_set_bus_speed(struct mmc_card *card=
)
>  }
>
>  /*
> - * Select the bus width amoung 4-bit and 8-bit(SDR).
> + * Select the bus width among 4-bit and 8-bit(SDR).
>   * If the bus width is changed successfully, return the selected width v=
alue.
>   * Zero is returned instead of error value if the wide width is not supp=
orted.
>   */
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index c949a3eaae79..efd1903c3ccd 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1095,7 +1095,7 @@ static void bcm2835_set_clock(struct bcm2835_host *=
host, unsigned int clock)
>         int div;
>
>         /* The SDCDIV register has 11 bits, and holds (div - 2).  But
> -        * in data mode the max is 50MHz wihout a minimum, and only
> +        * in data mode the max is 50MHz without a minimum, and only
>          * the bottom 3 bits are used. Since the switch over is
>          * automatic (unless we have marked the card as slow...),
>          * chosen values have to make sense in both modes.  Ident mode
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 38610c89d54a..d500a419e2cf 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -69,7 +69,7 @@ struct dw_mci_dma_slave {
>   * @cmd: The command currently being sent to the card, or NULL.
>   * @data: The data currently being transferred, or NULL if no data
>   *     transfer is in progress.
> - * @stop_abort: The command currently prepared for stoping transfer.
> + * @stop_abort: The command currently prepared for stopping transfer.
>   * @prev_blksz: The former transfer blksz record.
>   * @timing: Record of current ios timing.
>   * @use_dma: Which DMA channel is in use for the current transfer, zero
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index cf705b265e21..7d86426c6001 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -717,7 +717,7 @@ static int mvsd_probe(struct platform_device *pdev)
>         /*
>          * Some non-DT platforms do not pass a clock, and the clock
>          * frequency is passed through platform_data. On DT platforms,
> -        * a clock must always be passed, even if there is no gatable
> +        * a clock must always be passed, even if there is no gateable
>          * clock associated to the SDIO interface (it can simply be a
>          * fixed rate clock).
>          */
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4aff965f0e2e..b229545d9db5 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1770,7 +1770,7 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_h=
ost *host, int irq)
>
>         /*
>          * The driver has to acknowledge the interrupt, switch voltages a=
nd
> -        * report back if it succeded or not to this register. The voltag=
e
> +        * report back if it succeeded or not to this register. The volta=
ge
>          * switches are handled by the sdhci core, so just report success=
.
>          */
>         msm_host_writel(msm_host, irq_ack, host,
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-o=
f-esdhc.c
> index 8345e2c5a034..1ca3562d8f73 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1381,7 +1381,7 @@ static void esdhc_init(struct platform_device *pdev=
, struct sdhci_host *host)
>         if (!IS_ERR(clk)) {
>                 /*
>                  * esdhc->peripheral_clock would be assigned with a value
> -                * which is eSDHC base clock when use periperal clock.
> +                * which is eSDHC base clock when use peripheral clock.
>                  * For some platforms, the clock value got by common clk
>                  * API is peripheral clock while the eSDHC base clock is
>                  * 1/2 peripheral clock.
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.=
c
> index b5d7c1a80a92..7a198fb26628 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -332,7 +332,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host =
*mmc, u32 opcode)
>         u32 reg;
>         int i;
>
> -       /* clock tuning is not needed for upto 52MHz */
> +       /* clock tuning is not needed for up to 52MHz */
>         if (ios->clock <=3D 52000000)
>                 return 0;
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f0fd81409a86..98c1fe20bfcd 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -409,7 +409,7 @@ struct sdhci_adma2_64_desc {
>  #define SDHCI_MAX_MRQS         2
>
>  /*
> - * 48bit command and 136 bit response in 100KHz clock could take upto 2.=
48ms.
> + * 48bit command and 136 bit response in 100KHz clock could take up to 2=
.48ms.
>   * However since the start time of the command, the time between
>   * command and response, and the time between response and start of data=
 is
>   * not known, set the command transfer time to 10ms.
> --
> 2.48.1
>
