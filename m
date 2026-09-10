Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B564B488D
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056355; cv=pass; b=ns14Sjr9NFjLo/zxGUVcjUJ6Bx3Heto2ujrFWZ4ccLf7q6AM2edZZo2o2i7qbSeXT+T1WSNvl3eiMrkL6ukJNSlhpmtWWBsXqWtjM22L6JoJAKf+aDUVZGFO+STSxQZI+iTvOGgnynkhNIrVcrIoz5M3yCkLJTWXkCfdSfpPdms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056355; c=relaxed/simple;
	bh=Q4uhx4UzUQra1vjR/trzB6RCmVA5xxZuwzkYyHRjWlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqNjliH0WcaWV2puP208OIeFaFUdszW5zWZsepSGatd8PrL6qLtXYwBNxISte6vPsMzFXulcQEFxk/medowTGFR87NptC3WDPpqAERj7u0QyLHpZO5qIMVH28Z+nw9E7lZEuj9nXFXddNeGifidiBj+ldesdlj1DXQcIcxF6UBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nzZeJjsh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VoGzRjnD; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nzZeJjsh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VoGzRjnD"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF4NbD1494295
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OJUaJsREfJ4f8VkOUx2mPECCsS/3Z5pmGh8xL/RsWKw=; b=nzZeJjshZKPCnAEh
	nYHKYLcgjkVW46dvdsGX9u3bcTgB7RupQO0UbcSUxguHOkRF/KOhUDv3TxcvPCRp
	7Kn1KoGb5jLzuOakFwiMgxo35ttj4F/eEoqtSiYC3ayF3rD6ZU8j5PUF0cVV3SU1
	D3fdp/9r/S8nHax/fU1pcbWmkbEnHlvBptog2N5Fv9NYFKlPW27H7xx6ISMO7u9p
	xPgVaYGRSjWBlqGYoCstUi8Rre8WsolZ+AZHn7u7znsgDjCXSpZ7V6yZ2A31X8o9
	/DRKrK5bqCSBThw/ZilgmD0H43/VuVH7ApwXfURX8SwS3MQI7Uzsx1A0TGJrkXbp
	tOF/YQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwx9ruea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:51 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8623e5d4279so9178457b3a.1
        for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 09:05:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789056351; cv=none;
        d=google.com; s=arc-20260327;
        b=hkjD24oVeeOfbPYK/sx1Qqm26/CaTcIQNlQ9tWGCVvfbC4tfNi84o9e9JxxLf3FTIp
         +Nm4iJz0/2ON1Xylf5RM7rIxql7btElDLAK+kNlhQlfNtexCqirqDdDZxDQ72SW3RTtd
         kiOUxVgdsIw1jOL56yUHbTfGnJ1GPnXDe9kAgYcjuEqMSBHDB6B6XC0Uv/534EDdiiwt
         w5/WnhYEh/nZtvgile9AjQJfOx/e/j44appMvTCkvZPLG1yP3PUdIpvP7JhIsK0chhJU
         IpnvmBoo4YVW69Rq11gkJyT+RAkjXkR6tGzVf2Gdk3v8+JDW4OngidNOuluM/RPCknay
         ouiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OJUaJsREfJ4f8VkOUx2mPECCsS/3Z5pmGh8xL/RsWKw=;
        fh=c+pcsfp3zEG5wYRUU+Oj/i7kT2ApEt2t1Ep1KU3Y5r0=;
        b=qqt4gFx+ESlv32EOs1ivRZPTMsgliSVV8AgAqpmuuYrvZ53KJ1UTQyqs0Ehe4BpY6o
         5Nroejm0MG23AmI688oW/GxaTGH9rpAHk6lrDBoeMVUBsIHWqZMN99/CmeoguCHz1ixp
         VbWRQkYfq9CcRML63rXZJivN6x3h3zuuhKbsu+2pKR3ISrmaUhOIlHIrDde5xC0LCRF0
         LwAN0UBvVonSF6AKBzN+1vz/ba82UmF/qjNtmnX0adR3ifUvYSAPRda2aerj3P3QybRh
         hxbHBQLOMTkNWzSpuF9kqrS47b3OW0dOMh5U4APB/O+MGpvdU3JMti3SivmfKxnZlj2S
         3yuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789056351; x=1789661151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OJUaJsREfJ4f8VkOUx2mPECCsS/3Z5pmGh8xL/RsWKw=;
        b=VoGzRjnDuL89O88gpdSFxeZ6/mPehhrDIhjSme7vkDk1tN6K4xxt/cCJfeUS+C4T5I
         1adZbcW8zRdHzDj8lrlmsEi2sHlUpTQXEWhlofwNQvMEqtZjR+GKsD3NaqvrxzRjJAnR
         P3ZPBXZyvbEOvrJU2jdEe6CGeVNu7FVbrdkLUojkHnzNHa7Kub9IiqyNu9howfivISpg
         WAiEOIlJU2eH/5lrIWgTT/r0xkmEdlIek67kUo5VenhB0pvJjTvzW2/wgXatlC+o4eka
         8MVwy+kCySXO4qy52M0I+4XrbyqWB7vv62SIU5qEZ2aRM5xjy/eJGsZTgR+qefsAg/Fv
         D6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056351; x=1789661151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OJUaJsREfJ4f8VkOUx2mPECCsS/3Z5pmGh8xL/RsWKw=;
        b=DJkzxX4bYogY5jslboZaM5v2iFPSG7OE099Ig/hqCXhrvXw4gGEMe23IEWzA/GE7U3
         HxUHQE3Bjl3ljlC7z0207khQ4l7brwFtQ8akWmAH/ESSvoLdmFY5IrS57+ijIseGz7c5
         Ks5h5dVmJH979/bB2Sv1/09AG86aPnvBjC+BbUQTEQxIJi3feQ1W10AQWADbWPiflJKZ
         NOyCs8LDn7+rx671DcLaD/1ohoXsHiTFn9oBOQGpJp5Rqh7C/RyKrH+ALqcl4uHstIsY
         bT3vGY9UjMOpaCfluhWeINUrZvu0fe03irPRjKCc5KuDKx8RJ9lS+NYuuBcozwkuZRuF
         R5hA==
X-Forwarded-Encrypted: i=1; AKwUvBwTcHbiC+f9vb3TvZgZSZSImG5FhUQIGyI6A14wAwRgb2so+AZuWKF0CrzxBvMSIivVNzEVnLbrwZM=@vger.kernel.org
X-Gm-Message-State: AFuF++mywxdKjs7AWABGPCcQWITgmYzC5YR211silpQOIVwzoXIzZNVg
	tp9aR7U59hZENo9dz1PuJcQ1Vuk5DAkzCk2pNPlTyWj5cV4sIpqrOiVFfOGP2ZRokePsBgFXpKO
	h2l6dlribE+UJF2tpst638QQks0MwDNb0/XIE0ZE4oi3ez5Jk+KkrSHcZl/gT3ilMLW0gLYr8lK
	a0ogi2XS80tbNARVW6BgZpWD5+q5f1cwfjJX8APA==
X-Gm-Gg: AYBFou2fuZ5JplXjUqaR2hbr0QmFCyqRVmvxYp8jKo9sCUE/+X1S7XUhYG8cylEUvIF
	naC2gMOXs4ZoBoj6iv8JWD6c57CboggnnCgge1FRzCWMsHhfmTvMMXpZRWtVZ1FjFasCh52Mf7X
	WSAgGPQWHsoZT6acX76AhwVd2uVPO8MQIb9EVS+NjoTgGNheEYIGMI9UykwQ==
X-Received: by 2002:a05:6a00:6d43:b0:869:201b:7386 with SMTP id d2e1a72fcca58-869201b7831mr9247510b3a.1.1789056350328;
        Thu, 10 Sep 2026 09:05:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:6d43:b0:869:201b:7386 with SMTP id
 d2e1a72fcca58-869201b7831mr9247402b3a.1.1789056349581; Thu, 10 Sep 2026
 09:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_CAA125B50CDEC8BA29F4B982356549608D07@qq.com>
In-Reply-To: <tencent_CAA125B50CDEC8BA29F4B982356549608D07@qq.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 18:05:38 +0200
X-Gm-Features: AcwNN1WvimKFb8VJFOX40v762E_cTADJwrFab3f6eIRNPA32Bu6Jw3cM_hL4OQM
Message-ID: <CAPx+jO8XTB40rAwzbtAfP9D-GvGhjnSWEcBpzjXjjNhZA0SKrw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix OF node reference leak on card add failure
To: Zhu Ling <zhuling0805@qq.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Hans de Goede <hansg@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfXyGEgxgGrJjqL
 4QugX1WkfY07tFF+vJyzb9BtMG89LBI6iiE07wt3rWdZv6NTFXujfNmnlxx+vyzsaxEPr8xN6ii
 ugWJSKej4fl3/ew75gh56hUvBz4gaab0QdQfocaIKJvnzJ1UWnWOGNMYChhtsIRw4PCpbXTU8lz
 zjdVImVGDj/xOaJDLWXNOChX+5LtDx34T71Muja4ljcz2ZppTKZDSU9/O+DpyeZwKf23JJJobKU
 QTYexd9wLO7Dz9S4VZsYi7HW6sI2nuhRHexznh5V6183cchffUsJTw08a9ITumpGeK87CcI7zV2
 kOBF4f6XIaJYuq3MaKEam5Fdv9IpvWUgkOXvJoCWzBDVs3lu2B+pzhs/aPWD6ytNt1ZpLveBSUJ
 AQh3Fzk0DKDKa0AOwnx2PO52y31OjCInAfIWXELl25eiKmuPXCxojazeT3JnVYK/ZZhpTE4KKWX
 YLJM+/7PzpzDZzwYOHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX8+9E0AR3+VuM
 o7sSRwCY7i2lGJtn9AWNKLlJz4dexysO7BdlTx2cBOxj3ZzciI5hSsPYeuvWTnKAEVMN1vdB0tJ
 VAzDZLScIWaFa6YktQkznzqdr+uKK4o=
X-Proofpoint-GUID: VlzEhIB0SM20Sp46c2bqljnuIMMTLHXD
X-Authority-Analysis: v=2.4 cv=TupzFzXh c=1 sm=1 tr=0 ts=6aa2d55f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=dZbOZ2KzAAAA:8 a=VwQbUJbxAAAA:8
 a=bVVfCyBLFoj7s5xtQnoA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: VlzEhIB0SM20Sp46c2bqljnuIMMTLHXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100195

On Fri, Sep 4, 2026 at 11:08=E2=80=AFAM Zhu Ling <zhuling0805@qq.com> wrote=
:
>
> mmc_of_find_child_device() returns a device node with its reference count
> incremented. mmc_add_card() stores the reference before calling
> device_add(), while the card is marked present only after device_add()
> succeeds.
>
> If device_add() fails, the callers release the card through
> mmc_remove_card(). However, mmc_remove_card() only drops the OF node
> reference for a present card, leaking the reference on this error path.
>
> Move of_node_put() outside the present-card conditional so the reference
> is released for both registered cards and card-add failures.
>
> Fixes: 25185f3f31c9 ("mmc: Add SDIO function devicetree subnode parsing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhu Ling <zhuling0805@qq.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index be5cf338bdeb..92ad39c0cabc 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -417,8 +417,8 @@ void mmc_remove_card(struct mmc_card *card)
>                                 mmc_hostname(card->host), card->rca);
>                 }
>                 device_del(&card->dev);
> -               of_node_put(card->dev.of_node);
>         }
> +       of_node_put(card->dev.of_node);
>
>         if (host->cqe_enabled) {
>                 host->cqe_ops->cqe_disable(host);
>
