Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC354FE2D3
	for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784084; cv=pass; b=PaO7Ah0rDqCZ8b0lVJUuDi4Xtr4ygW1SZtkHBhtSt5VLzAX70sLbf3cVEP2JYRij64yn/bbHVSy3ZHxdMvVXMGzpqFCsOuaAyl4DnOng1nBM7YiZMLv76DrkrGFBGOb2r5ckz7VCMd8toO9WVGKS1R+lE10a4eKxx8sedAcvigI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784084; c=relaxed/simple;
	bh=C9Jpcl4hk2nflrSgR/CERYh3R1ZRq3nmrUq5WwdvYXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVeCvLT3re81nwn6uBO6DGJana40OXn4YH+qKfmsQQ/7o7fpesaq2GboDueYFDemMIpffTWgN/5spkmLA6BOyqD/T4wx5GGeNGqg8VwCKCWkbYmqaBx2rLoOdZaGg603Ok9bHI6MRdtbzpV4KsHMoCRUb6KIihISWXR2u/6WhSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VUqEiD4d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aX9D8cVR; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VUqEiD4d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aX9D8cVR"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UDxtZ93519863
	for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 16:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C/+/jDwGHy2o/OP2F0MWdjczwuGzPVCHwR05xkgVhWE=; b=VUqEiD4dfcVZsbem
	5GZX8RCHmJyFb3qjkdcQwNLzqNju6aF0K9VSnDL+U1q3wnemt8BVqCFApxTj3oFG
	08J35SR8OMmF0t+xG1GMOtsS7wHQzsdk3J+h+cBwGcAK1dRe3OaBsozt85g3yro+
	bprJG/uWAAGUIpdIICKxzunOfuZ5pKiDiQAYJ9dAsNfX0KQ+46EaczysJTn1fJt6
	HDp6fq1Nyh9SfPoVPM7fZ6CvThCNBDFpgNCbUw07XVU4KUZOK0SrzBQI6Fn+vpgD
	DHeYBE5RlwJZUxUVAGFxz1ZheUO/Ld0dB+6MBpjV4j2V4zfw91lzqD3nUN1mw+hm
	9NLyUg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x27j8r1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 16:01:15 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a46f0f158dso2672207a91.1
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 09:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790784074; cv=none;
        d=google.com; s=arc-20260327;
        b=sD1uzVJHpY8FTioqi0fYSr8DrdLIekSnzBxn0CSsjbnTs0tGXDCsQkp/9633Z6w4qY
         Z9ZLCNQO4clDxZNlPA5r5CgyHNtkOYE+oI+P/ppzd+qrAoUdWeWvFlW4NNsrifqOoz7Z
         IktMnvZngmGT6vWDChvtnS2exmJheEkSZk1cv0sMo7+vUZxQLN+dK2IpLN/QFOwUImb/
         IYvkjOxMhZ8SzRbqOoA2Z3yUj3MuwdmZ7ev0N8cXTP75by/Y/Z7m8pCmaVITLaStYlcA
         bILDrW1Zl5/ZVur5fy9Ugup3+PgNYm5N9NXnPQq/xmrxBokH6W4pmM27efk2xoc/3HYI
         JgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C/+/jDwGHy2o/OP2F0MWdjczwuGzPVCHwR05xkgVhWE=;
        fh=6Y3WKh9qZ8khIqELiV1OYT7tyk+6jdwI9DIYm81iGls=;
        b=R52mvI31P4JVUVbMen0VY+aQPOos44sN0sFksJpTaRwKQn9qrslHdXNfla4DMEye7b
         EdZTycbYeTluK1ajM6rk5csZWVsPvZL+/uJ5AxWcGbeaAq6xrgEo95M3EIwBa+Lz/n5/
         KiIcplXJyAYtz8zxiAyWPYfSriDeU3xvcZv95l8ssIoOTmRUbDW6Fq1LjV1miYbxTPEV
         s80ZrTaeiT39AEcrC+DsclpaFz734NWWt6PLvl9SosA96O00onREUSO5+QXCgP3haatR
         HRxghEukcDuiz14/AibaMYLX3mx6w8S8JwuT+JgKibxYOLIkmI7m1aaJu/Mee/djXoBf
         a/Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790784074; x=1791388874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C/+/jDwGHy2o/OP2F0MWdjczwuGzPVCHwR05xkgVhWE=;
        b=aX9D8cVRczpi+8aKMJtkS+J5rOzHQzybOk0HKs+g70BAKxQXcHqIid/1XnxRewPifK
         8E+gEj0CFeQuDgoyrqExHOmHJZ+tLXvOBdT7rf8cqslda9gQ/Lp5kphMXnIcGTr/CR9n
         9tD5pLis95K1+Xa9ezIx31NaATqPz02do54lFopaZcRtHoXQE0mqNQB++N5LLRSe62tJ
         K0Xd2y7JojEv4Rr/sHKxcm8HUAyIw3sMfMGmYOfU/UHl0RlV4FH9OoiWt6sjl193qW5N
         sQkK5QQvzHRQJCuDP/OmDE9zm7jOMgFuumXDh3MyIgTDkAxHCDpZRGsH2IWAIARgF7rw
         h2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790784074; x=1791388874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/+/jDwGHy2o/OP2F0MWdjczwuGzPVCHwR05xkgVhWE=;
        b=bN2l0b9pw4XC0jBogtUIcuJmKGyWIJUjgAaZW/z7c9bBYkylQpltD+++MioJzRnbja
         xkZ4mmnv6x/EU25PzGdoyLarzk8mfJrIUE1Lep2Z9hpLwRitSnPzmIF3nNq6Cv6gGfLf
         K0+W+GupinQQwhS7WvCgVlIH+s1yWMPwU3KESHbZP1Zgpx1XHozFxbBn6v9kTvWE3RnI
         N0U3GT/mYm5ej1TcmpV5QJmB/g57Zg7M2gEMsGRiYDbborfAGYTFdfPJLT8FcOfsVLbj
         VBYfSpuzYoNOUCQVYBPLD3W6Urgm4KeyHBDfsooKKvu9dzd6+CNKIQq01MLP7sXSBAhb
         uhGQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6JJ+MBrxnGlnatZfiy2Z2Kqa/g3NxaZivVcwUMtsxxQArHCS3rz9pLEWa+8cAyJJFVov9JDwSSSY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4WBXXlH0esICkWrN4YE0IOHAFuqIePQqHI+Y5mtsGeraj1fYP
	Af097SKMvmrMGYoGsPm+37O80fnispEfe+I3Fp3EzcH4ILWB5N5HJzbwG1o4MUgM3rpayChVxwl
	GdygtTM7wD8D2hXIv2F5cVe9iFqFjNuxySvwgZ9bOZCR6YPL4uPxzNdsSxfUnAgoewPdJHfOYwp
	eGzNkMuBjgKPGZ3yf8VqyCW+iSyd5rcHQml4VeMA==
X-Gm-Gg: AYBFou2EYRobHEa4j/02COehSmmklmM+bDFtEHtxh5WrkZS6e2DcteiYEx+Nj/8/9Q3
	s4cJ/8buUNnxkLter7Fc2dPk/kdwEPTxh7kZBaQp++/fKYsoWp3f+58Xji8CQI+njVOfEB9n6JF
	w0JcVggU7ZsyMI84iWaCf3X4hDLy1e63tawHFdb6pp//9axeyQYDzW/JJfgg==
X-Received: by 2002:a17:90a:d2d0:b0:39e:3d38:7ef1 with SMTP id 98e67ed59e1d1-3a4f2c2248cmr54946a91.10.1790784074112;
        Wed, 30 Sep 2026 09:01:14 -0700 (PDT)
X-Received: by 2002:a17:90a:d2d0:b0:39e:3d38:7ef1 with SMTP id
 98e67ed59e1d1-3a4f2c2248cmr54925a91.10.1790784073616; Wed, 30 Sep 2026
 09:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929124522.2141124-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260929124522.2141124-1-runyu.xiao@seu.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:01:02 +0200
X-Gm-Features: AclHuK-_MwI6oqPNb_CFHKP8OEa78Xrn6y9JHyCctq4WiB7Q3lgUKRsQJK161C4
Message-ID: <CAPx+jO8fr+Jkb9u8bx6a7cv0=oD0jUGqZpAamw4j+LVFnqSw-g@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap: synchronize clock timer before disabling fclk
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Ulf Hansson <ulfh@kernel.org>,
        linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MyBTYWx0ZWRfX75eapQwSBO/F
 Nzm/8OkAQiDbtUkPGU2T47PRVLc/PE0nRI7rNWPndifNwj5vojjNI+wDa482l/exMkLD3EN0xjC
 aQTOC92ZiwbhPDOlvNb/tW9Hs6KiF9E=
X-Proofpoint-GUID: jEsV4lr9CBsI4Ofbwk0-SdBXfJCXZE5E
X-Authority-Analysis: v=2.4 cv=W9GtxhWk c=1 sm=1 tr=0 ts=6abd324b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=ywtp7fW4YtRplKC3Ii8A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MyBTYWx0ZWRfXytxTz/lIlUWi
 F9UfVDN250ekUq5cR80z+k3LzAH7/zvl/qhpimb/rBUGg/7ycYk1UZl8VwNEA9LMg47Tdo6jN/U
 RGxT1n6TZMdEhQVKaKxOGtl/noB+eeay5mMiyEHutnxLvUXL/riUVkOIvIOVi8YMeSTvWsabXCd
 ZC9/fTW/ImAoygSI7mRRztX8hKnR69/swPdEz8/RJFnQHVePP8+PozKPTZ5IPzH+jfLN7L6w0+S
 7HeRi1xjZOYZGNhqiMXQ+FYMJQYEbBXHUKb3YxyDQqX4wFQe0CdpT7AGuVQSFZDlgKXmhcTIHD4
 ZHiCoUaFun7FStlnTJOv67MjFefn8wdRAQ1tJd7szTwa9YH00bUhsUWS1jSiQ/Ba9CfY8zsjt1v
 mfjntpZwtjWHnxLHWJUlGsKxOYCYyTpAW4CUfyTOS77TekzWivVhhKch7PSaMOkfRq4vXd7EjEc
 1KwIltUHJ9RJHrE0g2Q==
X-Proofpoint-ORIG-GUID: jEsV4lr9CBsI4Ofbwk0-SdBXfJCXZE5E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300063

On Tue, Sep 29, 2026 at 2:45=E2=80=AFPM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> mmc_omap_select_slot() removes clk_timer with timer_delete() before
> switching slots and changing the functional clock state.  timer_delete()
> only removes a pending timer and does not wait for a callback that is
> already running.
>
> If mmc_omap_clk_timer() is already running, it can therefore call
> mmc_omap_fclk_enable() while the request or slot-switch path changes the
> same clock state.  During host removal, the same window can overlap the
> final clock shutdown.
>
> Use timer_delete_sync() so the callback has completed before slot switchi=
ng
> or changing the functional clock state.  Keep the timer restartable for
> normal request handling.
>
> Fixes: 0807a9b5739a ("MMC: OMAP: Lazy clock shutdown")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/mmc/host/omap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 527b89a5e..02d288e4e 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -214,7 +214,7 @@ static void mmc_omap_select_slot(struct mmc_omap_slot=
 *slot, int claimed)
>         host->mmc =3D slot->mmc;
>         spin_unlock_irqrestore(&host->slot_lock, flags);
>  no_claim:
> -       timer_delete(&host->clk_timer);
> +       timer_delete_sync(&host->clk_timer);

At a first glance this looks fine, but I am slightly worried that this
could deadlock. Have you verified that?

>         if (host->current_slot !=3D slot || !claimed)
>                 mmc_omap_fclk_offdelay(host->current_slot);
>
> @@ -273,7 +273,7 @@ static void mmc_omap_release_slot(struct mmc_omap_slo=
t *slot, int clk_enabled)
>                 /* Keeps clock running for at least 8 cycles on valid fre=
q */
>                 mod_timer(&host->clk_timer, jiffies  + HZ/10);
>         else {
> -               timer_delete(&host->clk_timer);
> +               timer_delete_sync(&host->clk_timer);

Ditto.

>                 mmc_omap_fclk_offdelay(slot);
>                 mmc_omap_fclk_enable(host, 0);
>         }
> --
> 2.34.1

Kind regards
Uffe
