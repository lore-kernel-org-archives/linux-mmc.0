Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793365841;
	b=wiZD98Cwng7DhhkpEHSw+G7w1WtF9W5nSlF1z3QvYSElr6N9motVP09vlSdYKUyeB8IJ
	 yofR+96xCxY34RN9F86PpTukzOc7nY23Al1lcYB7CxLOClVQ115DkpdbhhKIhd0cs39GT
	 aOVv4nxQI/ZQkeBLvYXfJwGIE7numJWe5RE+LS8KsMBYkwRqwRTNss5n5u6DvJ4fmep/P
	 6cVr3W3kx/TBJtajNeJ36RGaxuC1jXivUDEO3NN6ZDcrBafoW6z135CLL0QtcyfGKyhkr
	 EVHu8hPLBYDVbKBpLWppE2Q1o681UMYM0MuadL+PGuVtCsjB90ZRxX4ZJj5rBSv2y3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365841;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fsCPpPD5U9nNBpuQWRCxqec/1B3N7vDFnL3Qo+9kNSw=;
	b=KmE++65H2O+zZCEjcP13iNU8JE3yIVno0/IP8GDiKerEZN4cJzs5qKY8zgySNBOiYclx
	 sa3A2rM7M6RvA+dMl4TDRK+hOz0fN9qXb/XSWpW5s6660+pSyWWU6GDe75KZOn1O4z0gI
	 X05VoTiFD9t9KojNijIiEKOOqnFhFWsmerZ1TbivdaSTh8PaVCGiF5fOe52Hw/zaEIVb6
	 Tbdr9Bal7pajxJjPYjGmz7KL/16lXoUd+zVhhhrJy/7bYWL3484oRzn3M6A4b6aDMarRt
	 5kOrrUPQSv7DuQZpVySG4e4mwrPDrbcL1ibck2gmY33O/aO78Bjtkz2pnTrHfEZduTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kifoh7G0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=THl1cyq7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72B606A31A
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 13:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF72B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kifoh7G0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=THl1cyq7
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBG00l2169618
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 13:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fsCPpPD5U9nNBpuQWRCxqec/1B3N7vDFnL3Qo+9kNSw=; b=kifoh7G03Kc7/228
	GK2O2Kkc+AkuUb1qaMVS165NeIlZ89dp1r6GvJDGR+UxIZ/wM7W5KjopaNP2TtaU
	eUm8QRLbrVPBxV0bAJXrkDej8ARO6aIvLmicS8Or2RglPkMY9gfnyg4MG0NMfVoi
	QPbDgkqDalnLetl+B3fNejIcLiB3CqHfvnkOOJYlInJqrh1AqKf0WpYL01fOW9em
	hHqD8Q3ROl8BluZtdEKiwbAG9jzjNjxfKrOMTvQUOmW+kGn3Hst1jFn8GHym4xgV
	mKsIg3DjhTar9uT0IvJqx26thHAjmq4r9BEIKN8ufe9L2aWzngL0V7rCDVV8DWtZ
	XsFKfw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pb5ay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 13:10:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so844780b3a.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 06:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793365839; cv=none;
        d=google.com; s=arc-20260327;
        b=YMEZfFhEl5G0EI2VZKTnufTsDwpAH30Jz7ciC2ZKowPXTy0sduql4G5+sfUlrSwsor
         Xnz6XW0KqkCr+3atIx249f+3VeiRMDHQBklrxzb9GRVHD27PgbLs9WbwJNeb/quPjkWe
         xw+DjsKV0ySbm+hC/z4zTYpXBkKqiNaIxHIUQQ80pocOpLk7SoJZpHTVQbcgvGL6Txs/
         unefZhIIklYtUaKSUXVNq8n8oqk2l5PkfU94G1z9Q8y+pwuf1wMSWkL2Le3T6KH6E/SU
         ozFXiyD8UbJPD8x4rxBjVLOmVDJu/w6lYu6yXnyUXkFjtmxHyDz6U5FcA2TMaNTZWs07
         trHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fsCPpPD5U9nNBpuQWRCxqec/1B3N7vDFnL3Qo+9kNSw=;
        fh=gWzGcLCLns3tdcUXec9A3WkCbigOe2GgIi0nid7Eb38=;
        b=JEeLHeEJUPSP7lBj09RlNvgq8GG8hGVaEsxADSK/LewUxA60C0Afou/rg+VQOIE8JS
         z9VjLj9I67qY3hW89rxGa/YbEUw1p1ks0K2HYe8+fKm/6VDT2l4Z3WG8ZWpjAtTBndjg
         Dao1jFXnKheddYyMOVC3i5IL9o3U+e0b0O8YB16UJS2cLNPc/z7QcQu8RPPeGfc/gRDO
         QhXf8cLl15FBxRj//jRZwVBHj9O8z00wLKvXVwANxlE0k4rV/7ygpTfETeUG+cu9Jmue
         Igc+nYn4j2OdVZh1Nvl1VjamZKGSkzzSbEbof7LUfa0VUSOjRoewNI+koB52liicb+g7
         gmPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793365839; x=1793970639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fsCPpPD5U9nNBpuQWRCxqec/1B3N7vDFnL3Qo+9kNSw=;
        b=THl1cyq7k4BKQN2TP5BY/QiSiPjkI6ZfVN8L2I2UvLFFwOox8MgPFJmp9dyNA03iCF
         pbddaL/VPMVl4F9WBZUTQM/ojY55IuRDxbkXzJqGw5Rs/0YJZZ19OjPOfXQVCkhUdnfx
         8P00F1w/QTF+XsA34+g6XsM1MRFHzMyiY4OOWR/DrFw9Yo/hS+FWG6xnA8x+8m6BeLz+
         rXsKMD0WeyZQAux/X6Ic4A5JkWRYVxEukSD00FBPNBDumfeXOFjw8q6mih3U+lp7PmRK
         V+BWeyKhXiH5jJlP8eOjvMJzKNmsKeYEqZWV5jkSIapcQTkOjqf9J7ufcIh8JlnuSZ8i
         9BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793365839; x=1793970639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsCPpPD5U9nNBpuQWRCxqec/1B3N7vDFnL3Qo+9kNSw=;
        b=rRB/5DRAX4WruwoZ86+pTxBfGDyEpovve0fJEypwq/+jeuwlrAyxEbG7X0LoHxSs1N
         8DQJbmySGQDfvNo+gEU/AwLuBAdDwfwJ73hq9RQAXy7YfgGYyE1zPvwSAsQsjt6k6kB5
         FNQXGBqp85Uo02s2rFTIoJULadrjq9RjKwjcLtDc+nR8W1JN0ie2WiFvvRTOpzGGBgRk
         KIiZfYgIIPEJ5ur9Ojow8JV3Bt35jruxxX3cqcb0+z2iv622+eY7uHTToGdzx0xrEONP
         2YySTe+xK0rSKxJMJ+PfbP3hUGd9LKMvjHLhNP3NPDgFGHrE+UVu9ihSqAw8qkxVGdFa
         dpWA==
X-Forwarded-Encrypted: i=1; AKwUvBzFlIB44sNiNHwr3+BSHAW45uHx8U8OvtkNM82GLauRS5Q9ZnaxKN1wUIUM42IEVsRw9qEy0V+5EH4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVOmjzkK9I8h/sRJKX4Qk+4aJP429wAQOSOfJ17Qql0eARhGvg
	KazXb34T0cf1LaeglNzkjrKIxGhWuED8zA8Q2pe9NOz0VknCJQqZvBbAru1w2l5GSqFmr6y+mER
	ybfpqrR8e37jRYKZulv6sMYnsqlj+EIeek52Ph04nCbq8nfy93BxZ6sIlZmqxgTjdibBEgSIc8r
	A2bhcmxQLZdko/RmDDuRQSpoLQVK5lY9GNmp1q5g==
X-Gm-Gg: AYBFou0ybI9EQjB3LvehpaLPjBaTfOL0ifJCKnLHczORqkbcLQUXIWDjU/+w0kZvKqW
	vdZqc7+8o9FPvB88bjNmAPzw5neb8jft8ET2tlmTPCUX1Dx0iRTYxBkdkzLqpWv2ls8hLJCPKIA
	5QYOeMY1t+RqR8oEeUWHsE5+PIIv/6BhfPSHCkZI/RAxkRecPb3D8oqgN0EA==
X-Received: by 2002:a05:6a00:600d:b0:898:9b2:605b with SMTP id d2e1a72fcca58-8a9c079a97amr1958328b3a.56.1793365838929;
        Fri, 30 Oct 2026 06:10:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:600d:b0:898:9b2:605b with SMTP id
 d2e1a72fcca58-8a9c079a97amr1958300b3a.56.1793365838423; Fri, 30 Oct 2026
 06:10:38 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027122417.954133-1-rojer@rojer.me> <20261027122417.954133-2-rojer@rojer.me>
In-Reply-To: <20261027122417.954133-2-rojer@rojer.me>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 14:10:26 +0100
X-Gm-Features: AclHuK-f04QOKVsOKTCid1138RFgbSpIdyKV4SVuLgzWJk-mOLcmCEvz3IZlzQE
Message-ID: <CAPx+jO-SrC-8DKEfOC9KTMY=zHyiNVqNwiZyf7ipvX1=ZzZ1iw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: core: sdio: retry without UHS if UHS init fails
To: Deomid rojer Ryabkov <rojer@rojer.me>
Cc: ulfh@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, llj@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MiBTYWx0ZWRfXxwov4TUFKD9X
 BVuWZEvch56Ofb4LDyU/WFgjj9LCllGbp337VSPPqmkM087I3Rt/C0SKdvUUZfr1i5Gp+tIcN81
 XYrzIhL6igJFcAjUG8J+M3BxRnp89QMPkbTF9Z0oiE+kpHWbXdcVK5PmMmIC1eg3RMwsoutEB1w
 qg6aSieyLXD4g0yAttH8QpYe6x57moRSGS4AQfZ/itb5jkaDZumgbcLF5XVHZO92GowgjrF1iFo
 B3VsvPs/3pmsS+wuJgmoMlzvF/MngP+JN86wOHdRYtnuYDo2mYC5B2+0keWEIt94cDn3U7wP/Nq
 o0WTP7GsL1pdePAynzLZv3UuxyuKpRCSdpKSFxU1QjsvZ7iR7QUvM1q7KYKXV/fJFBIJQ23D3wn
 hm8WKyW0gFLHOBg/CYStUlu1GUD/iVXU85JiaGD6x3TG9yVGnIZA2JPbe9SpCOTlD6fR0gshenA
 1KjiiZySgOmbCIkgRoA==
X-Proofpoint-GUID: VnZwpiYPiq2U4R717OJgJ1oglOMYp99m
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae4974f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=s8YR1HE3AAAA:8 a=KMjSppSA2jvgilID46QA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: VnZwpiYPiq2U4R717OJgJ1oglOMYp99m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MiBTYWx0ZWRfX20tJveNnZQpc
 uyeq/GC8vTNf8Yz9TZvN9Z7sL103j9Pz9ZOjlX3j1eNqAytxkmE9N4Khvfy/dSZ9uvdLNsy+dNR
 E7Xq0KCwd91TC+1h/Wm6n3yVbn6/z2o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300052

On Tue, Oct 27, 2026 at 1:24=E2=80=AFPM Deomid rojer Ryabkov <rojer@rojer.m=
e> wrote:
>
> If mmc_sdio_init_uhs_card() fails, e.g. because tuning finds no
> working sample phase, card initialisation fails and the card is not
> usable at all, even though it would work fine in high-speed mode.
>
> This happens for example on the FriendlyElec NanoPi R2S Plus when the
> SDIO pins of the RTL8822CS Wi-Fi module are left at their default 4 mA
> drive strength:
>
>   dwmmc_rockchip ff5f0000.mmc: All phases bad!
>   mmc2: tuning execution failed: -5
>   mmc2: error -5 whilst initialising SDIO card
>   [... repeated for every init frequency ...]
>   mmc2: Failed to initialize a non-removable card
>
> There is already a fallback for a failure to read the CCCR in UHS mode:
> reset the card and restart the init sequence without R4_18V_PRESENT.
> Do the same when UHS init fails, so that the card comes up in
> high-speed mode instead:
>
>   mmc2: UHS init failed (-5), retrying without UHS
>   mmc2: Skipping voltage switch
>   mmc2: new high speed SDIO card at address 0001
>
> The fallback is taken at most once, as the retry doesn't request UHS.
>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Deomid rojer Ryabkov <rojer@rojer.me>
> ---
>  drivers/mmc/core/sdio.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 83085e76486..6787fdf1c53 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -867,8 +867,14 @@ static int mmc_sdio_init_card(struct mmc_host *host,=
 u32 ocr,
>         /* Only if card supports 1.8v and UHS signaling */
>         if ((ocr & R4_18V_PRESENT) && card->sw_caps.sd3_bus_mode) {
>                 err =3D mmc_sdio_init_uhs_card(card);
> -               if (err)
> -                       goto remove;
> +               if (err) {
> +                       pr_warn("%s: UHS init failed (%d), retrying witho=
ut UHS\n",
> +                               mmc_hostname(host), err);
> +                       mmc_sdio_pre_init(host, ocr_card,
> +                                         card !=3D oldcard ? card : NULL=
);

Is this really correct?

If there is an oldcard we should *not* pass the card (since it would
be equal to oldcard) to mmc_sdio_pre_init() as it would remove it.

If there is no oldcard (oldcard =3D=3D NULL), we should pass the card to
mmc_sdio_pre_init() to make it remove it.

In other words, how about just:
"oldcard ? NULL : card"

> +                       retries =3D 0;
> +                       goto try_again;
> +               }
>         } else {
>                 /*
>                  * Switch to high-speed (if supported).
> --
> 2.53.0
>

Kind regards
Uffe
