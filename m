Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34BC424D74
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380588; cv=pass; b=hWxAllARk6fTzUHG2OBPVRB3EWnGJ8m7V+2BqD0WPjJ+L4c3ByQwMySkMleW4cT1W9IwwSwCuX0GBYb55kDPS5DUpTTF0HNJMEdix8fEiADuvmiaX+t1fbawuM+aSy9WDICqx8wRKE+O3hSbX5OD9+haKHdfueczKkZQVvgQQPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380588; c=relaxed/simple;
	bh=rjEOE9sUHwclD2RnLO14aHO4Dd+e75AyPGzbfxHtzyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sfr8BSyWfLJUwp+dzo1kafEr4pETbksSVO+uZDkpx8wWjOOhtD2x2vBVQZ18c9mi/U3ix6/CIEIIz3of/dtCwEf+7cUtsZHMpkTyrdo8BE0cjfOKoh9pZ8YkOl/HvuZM74e8nCUWTtvhh2VM0Zkd8kdAVCg1j46416Y573Yqj4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ted10X4b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YBO4KsJJ; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ted10X4b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YBO4KsJJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E9nPmH3731427
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 10:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aI4PMHQwnMxJwwbf4y7Z8JLgo/8t7cwYMVkRcFaFXPE=; b=Ted10X4bk4RDDiro
	T9D/RaxdjCAQs5pUQ75PCQ5lvk4Y89C//Yt/KZJqktahm0pC7j+vMqZsBXwGHEa7
	0Al9tu9qzlCiMwArZracL0jFx8by/DRoIL8sJ4qQmhqzXitlBRodkmdvMv/N6s8l
	dNjIL4+dpHxJ0dsUckYPev31kqLICXSXkObjocSQxrFFBzIVaLSdVZG1LbLLwUtY
	GXo1OA8avaDWpPbV9CPHI2S6p95B6YAjKxx7rtVi5CukZZHTrOSjEl/WrYcF4Hac
	NoBU9w4Oof8dGR4l5l1+QEtXmwaAY/AKbF6aL/N/J+ES7pY0k7wWkFnD8MC8P3JR
	kC0I4Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpd1f0e9y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 10:09:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc73f47bdcso39654795ad.3
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 03:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789380584; cv=none;
        d=google.com; s=arc-20260327;
        b=Dau/Od0VwNcL+vpWIQwWDoZApVTQS9RftVqkvIy2b94NX7MxWUfVrCI4s6oDrrfwR3
         hacS3Tup5YeP6CV6bs5v/1ghSG2JQCStaTIXm0DiehT01Ls7DcZLwKDU0iB6oC5el7cq
         NGlNf2jrjlHS21iYYX/rVDmZqvjBbvrEal3ik/PpAAJb4nNy/h0WA7BLVoT343htfXTq
         dNagL0YZDRhkp5Cwp6rrLv4UDDSG3lL9MktdK+ssfnqXpU6aFLuWZF/HWinp1kMDTezR
         BWlJzzeqjlkSMuaMTNtYTY2JRJhFkAHWcra8DtJdpIj4SiGQ8c/qvPhq/Tagk1GLJ47M
         W1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aI4PMHQwnMxJwwbf4y7Z8JLgo/8t7cwYMVkRcFaFXPE=;
        fh=wsuLGeudIYhXEgIea6hGg5bIQv9qlTATMcLcYtBFUMQ=;
        b=gu9JnWPcCPedX70Lc161ehERqv5sxKWesbIo0wArMc2hH8lDOnK3lfjYEtCEj1KVNf
         z+7nUwvDw3BjE4LA1LZGj9Cg9Mwt3I915gt+nXId7r0QtFqtbLR9rWg+OQPF9V4cnPOI
         R1U/e+gsMlvxj8JhKKtZKY/7nXuwzNpqDGZwoXj0uIE+zBfSkeLnxE+rp+oDMPYFtgm/
         ps5CdNU9eiI6ICsB9OA+yT5B0q71LckWQFYIK1KiVhjOF528X9jlVn+FjRcw9XXM2Ukc
         P8y6EQp/OPGdko4RZraHm05DrzYqGgHwiL+SwrKKf2kHKZX00rDsEyKLl2g5hIlAcBbb
         qZ4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789380584; x=1789985384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aI4PMHQwnMxJwwbf4y7Z8JLgo/8t7cwYMVkRcFaFXPE=;
        b=YBO4KsJJzQh30LW0d+AVtYnaXTQOLcq31N5XI0Rtr3rztbJeHNme/2BVxBiVcsMk7B
         6EReaHTKAXglBqKEnMwKwS3oDHblZKhGYgmw0AaocdT0BTeF+8WPEDbFBfkGRyCdAFZh
         VoqlydtqMUFYPD6D0V4ypXHZmqC6apIl7DRAZWoJ9Z+LEwwzxsgfml0oGNGHqUTOaaKt
         2Pdi9njCZNIBjmq2a7siaVVjtQrZqN4kIahQz98J6zSI8aqWNdAesmprU5ajYyxDZ7HU
         Mq0iixXfauVtO/fYWTDcPdyV1gn9LBZ46s9QwQr0beAseH1K49qQ+EcA7gXvu1LIEg8E
         VnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789380584; x=1789985384;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aI4PMHQwnMxJwwbf4y7Z8JLgo/8t7cwYMVkRcFaFXPE=;
        b=LAQki5cwwOy1EtzNzEp4qHTcZa95SsFZdz+5YteQsYFpXH14UleIdMgXTIGthkf+ss
         YxvP3K1jcF9eDqVXuL6okstmQtJ6M2aJyJT7DGvQIWLb2oWWV+AewcmI1qGkx4VPGSQA
         4aP9/65BkHc4/qvI2L3ZODK1v+63kAYACzw2VFrUCZSFlWXKeU7lN3Nrk4Feuu1hQyms
         JgHVTLdd7PliJe/D0zbT1dHO8DtgDJGNx3aMrZlcrFWLxrSNKkdOKRnBkugA6p7+AkUa
         0VCf8SUc7EpbtsyYOQZf+04IMEDAzQwTw9EVrv0DRurQhTzsGuoyFVVR86Q8AIXyEGfV
         GP7Q==
X-Gm-Message-State: AFuF++lmdqlwayU6iQhuTv+5igdP/hlOYcbMX5OdkdLAMmln1cEkdX7+
	prYWupekpY0wXZZeH2qNYO6uyptM7x3ExAGw4HhhQHY7BLmiy6zRqIn+OnGsfeX43T0SAPdiGfX
	Zfl3YOf+yxKbfKXjhFpSbenKruTlIZcnXNbPxkSXk0l8w9c2HjzUMYdVy1huj58Q6yHr6A0Unhd
	mQrBdt7djcIWGDV15XbQcAuyLIbwTqaOxvx0HBLQ==
X-Gm-Gg: AYBFou342TE3k/kPl5Ay8vCgnGi1evmc3bcwp6ZDGP/xk0oeiKl5eCHJRiuzMK1pDO+
	jKG1lmHsdaAs7+XvmYQ5MKGMGESnxMMiXc3vY2FYBfBvo/UrnrSr5SrNn0ZZ60DHsNW9H56viEr
	qi+VqmZVS/tbVR3PdBhDMXuNU8XDa+HjRAgZH8VB58IHzuUw+ZwNET8/pc1A==
X-Received: by 2002:a17:903:1b6d:b0:2dd:5363:3219 with SMTP id d9443c01a7336-2dd6c757186mr43992915ad.20.1789380584393;
        Mon, 14 Sep 2026 03:09:44 -0700 (PDT)
X-Received: by 2002:a17:903:1b6d:b0:2dd:5363:3219 with SMTP id
 d9443c01a7336-2dd6c757186mr43992395ad.20.1789380583981; Mon, 14 Sep 2026
 03:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909222432.62847-1-rosenp@gmail.com>
In-Reply-To: <20260909222432.62847-1-rosenp@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:09:33 +0200
X-Gm-Features: AcwNN1U5GXLHTiZb9rdmoFd6O3EjdjtICQOfMAX4hVsEWVlfxHEDcRmxUYeTP0E
Message-ID: <CAPx+jO8C7hz5qctbpOVJZN_PRTTrb_Q_di6VnsdJd3Q+DsCOtw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pxav3: avoid of_node
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulfh@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: NNXaVmQ5BdCU4RYkqwxEo1-n0j0akp9b
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE0NSBTYWx0ZWRfX2Gyfnrj6xgbG
 JPlWdAEl2+HGKxM4XkclQ2aAi2S3caLc8lX9bGvd50oM8IktKC1BogJ5QeIJA2xOqItW5G+QTOB
 TJGDP8/x3Q8df28S5v2Pu7dPSiKwnkk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE0NSBTYWx0ZWRfXw1Qw+A8oiDp+
 EJpvZ8Agz0WIEWYgh6B2tJZNTd8EFA0/wwT++52I/PV/82NwNc9nbHvi32Gi1zMw13rY/VraOz1
 bKvTyTeLlgqH4lfJMd1z3ke4sHbguj/3saKw/CiidlAc9u2+HYcwfQDeMCkbbfPv+bHlS2Fp0ga
 qFZl92RcHHcTpblrG8zFmjLGL+lO7DQp63dfaz2YsLW7LvfrKOFrFTkUM1y5g7LyCRGS9DCSRpE
 YprQrfT9U+lKp0pHb/X/euqn0G/BLTHX1JbSZWCMp0mtVoFLI/PWFAwMbrd5XwgjyNEH+7Go66y
 DZcif3eQ0MTBkRs1lq++lRd+iai9Ja1c1t0siojZ2DDzbb+GpMdKHndNZ5HUK/PPQGPFtkGxk6b
 vo2FxviHRl2hDoOblCviRfGTdbotzwJ0Mj6gf8Iuq3l/Kpf0rK2AdHch5jQGLrg2EfBu8NE6OP2
 40BhLw0LBMll5CdHhaQ==
X-Authority-Analysis: v=2.4 cv=XKel2ghE c=1 sm=1 tr=0 ts=6aa7c7e9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=DDOL9g8ZTEjboH5SDGIA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: NNXaVmQ5BdCU4RYkqwxEo1-n0j0akp9b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140145

On Thu, Sep 10, 2026 at 12:24=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> Use device handlers instead of of_node ones for simplicity.
>
> As this driver is effectively OF only, it ends up behaving the same.
>
> Change is_bool to present as no-1-8-v is not specified as a bool in dts,
> but as either present or not.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pxav3.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav=
3.c
> index 181b4989c74d..f39764ffd4a0 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -123,7 +123,7 @@ static int mv_conf_mbus_windows(struct platform_devic=
e *pdev,
>  static int armada_38x_quirks(struct platform_device *pdev,
>                              struct sdhci_host *host)
>  {
> -       struct device_node *np =3D pdev->dev.of_node;
> +       struct device *dev =3D &pdev->dev;
>         struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>         struct sdhci_pxa *pxa =3D sdhci_pltfm_priv(pltfm_host);
>         struct resource *res;
> @@ -155,7 +155,7 @@ static int armada_38x_quirks(struct platform_device *=
pdev,
>          * controller has different capabilities than the ones shown
>          * in its registers
>          */
> -       if (of_property_read_bool(np, "no-1-8-v")) {
> +       if (device_property_present(dev, "no-1-8-v")) {
>                 host->caps &=3D ~SDHCI_CAN_VDD_180;
>                 host->mmc->caps &=3D ~MMC_CAP_1_8V_DDR;
>         } else {
> @@ -364,14 +364,13 @@ MODULE_DEVICE_TABLE(of, sdhci_pxav3_of_match);
>  static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev=
)
>  {
>         struct sdhci_pxa_platdata *pdata;
> -       struct device_node *np =3D dev->of_node;
>         u32 clk_delay_cycles;
>
>         pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>         if (!pdata)
>                 return NULL;
>
> -       if (!of_property_read_u32(np, "mrvl,clk-delay-cycles",
> +       if (!device_property_read_u32(dev, "mrvl,clk-delay-cycles",
>                                   &clk_delay_cycles))
>                 pdata->clk_delay_cycles =3D clk_delay_cycles;
>
> @@ -402,7 +401,6 @@ static int sdhci_pxav3_probe(struct platform_device *=
pdev)
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_pxa_platdata *pdata =3D pdev->dev.platform_data;
>         struct device *dev =3D &pdev->dev;
> -       struct device_node *np =3D pdev->dev.of_node;
>         struct sdhci_host *host =3D NULL;
>         struct sdhci_pxa *pxa =3D NULL;
>         const struct of_device_id *match;
> @@ -433,7 +431,7 @@ static int sdhci_pxav3_probe(struct platform_device *=
pdev)
>         /* enable 1/8V DDR capable */
>         host->mmc->caps |=3D MMC_CAP_1_8V_DDR;
>
> -       if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
> +       if (device_is_compatible(dev, "marvell,armada-380-sdhci")) {
>                 ret =3D armada_38x_quirks(pdev, host);
>                 if (ret < 0)
>                         goto err_mbus_win;
> --
> 2.55.0
>
