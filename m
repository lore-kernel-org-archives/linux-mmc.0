Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C852F60B2
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883837; cv=pass; b=hagTgfGDt0x3pSM8VePJtcSF4EW52ONAPKWAGI6CsiTmOzhf4xqouAaFRuNsHUGtMF3noz9vkDSdFGNyLh88SiyNcKtDSDxv6BguS5L2M/P7mYm2JNZeh8qHZFF8/d3ZtBXE1igqx8ubYIGjmpt6fY/BbF8E6wMsYmCA8NY4WMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883837; c=relaxed/simple;
	bh=ELUY6L+uHkCA5qf6j1HjWKoHdtzv2rKWvRfbldOukDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBYW5/Q9IBnczFBFFaURzJYKIOKUvSwDYjAo8CaTqpaT0LqeQ8skO8MfzE5e/VpqoK7JeqWZ4rwzbA3Cz9fD2qcOTKDjgdTpQ6iS8Jctq60Z7NytcF/8/X+ZIT8z4W1aZNRWS6F3jyYYs9T4dn/55qwAHnmpqV23xw05taZkXG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aKZUnAuw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U2joKZyK; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aKZUnAuw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U2joKZyK"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FdYgF3612188
	for <linux-mmc@vger.kernel.org>; Tue, 8 Sep 2026 16:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	poYTtXrOshPnuod9r2bdqDYd8uCotQ96TbvuwA7Xqsw=; b=aKZUnAuwuOC2Mm6N
	dnQmHwM/RpKfmdDSX2+/4jASJo3vSdpnXrxREnPkUcqp2Bai9fmtJ5QWJmxbpT/m
	wgrSAgHAITZ/JdZx8jGT2Mz4RRt0yMoyifzyoeAfz/BUNL6tgruWcrZnc2mg8HXV
	/U1RpNx+N4ys4fKzP1hSbIkJxFkWqPQsi5/YMFnaNE1oVQ40463t07K/NmnYgZOf
	iS7zUFB4d70yG5ixvflOqQSRpU4DcxKpcl0MDLIILYOJcSdLy3Aw4uxvFd6MhR9a
	QxfCdi3dzrNHLVzZUe31/YIOZqNCn+AUVV59ucc5nIVBUmf/7SZTvKhgMqj2AzbL
	xA7B6A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjaguk2bc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 16:10:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so46330665ad.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 09:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788883829; cv=none;
        d=google.com; s=arc-20260327;
        b=Jx1u/zt2ocTY5j+l1rul98S9iBEYnARd+O1zmDCUOwfYtJjbV224bxulIOwjjUXS8c
         D3oZ0sjydyevb+Z/lugDFeg8x1VWLOsQamqaf7A6EArn85+rk7wdZhQpKRgDwysHs8ck
         ocXTIi4w14NY4YRyVTYOKJErGHdD93lH69m+qT9hw6RUWf2+eaeFpGbjjLcSdxS+bC/w
         A6desLKGt4pbdm/7yOod0i88NimGRFLM1UZTI5TZAdvh7c0lvibytwPEzNM/JH18ngso
         jS3Uc2Woh93nKgUcXuCTplau+L0g3GiVk/Xn3i70v+O70ArEHg6GYLrBq4tBFVN1ehSu
         5XuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=poYTtXrOshPnuod9r2bdqDYd8uCotQ96TbvuwA7Xqsw=;
        fh=+/s2XRTCUyjWHeNsHte4APcUSfc8Kh+fuibtizKknAc=;
        b=c7vl4IWOvntWnBZ8ev0mTgOWN+cXCWeghe6PSjrNQaqksKpEKc0+M/doG5ebaq5YDK
         vvyMu8fDn7ckf/xiIHuwzYv1BqY8TaO+2DwFmKvJdTiuxHe5oLqo1eGH/vBDtpjokleQ
         qZoIAm7yqYSxIYckRZ+6SOCt49KolqM9BC0S3toJbVAjD+KJ7m+kTfeM5Dwe1/5o58wL
         ZBam2H3uVX5+DFy2j3MT5+PqR5GC6YZX2pdsQGNdUvzfpb8x52hd3bAyIJ+JdRmSSBle
         itHKmJTzzmfD+TDX4HgplozbpCvoA6vEfmpZyZ4hImjcx2bk93yqSawyOe9Zr4pJSpm7
         sbVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788883829; x=1789488629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=poYTtXrOshPnuod9r2bdqDYd8uCotQ96TbvuwA7Xqsw=;
        b=U2joKZyKjgZEggCgjyV3ZxTL8pLGkgxyYj+WTdsRhxu5IgH879EtsNMXCso3K4+Npf
         dFZhvdmz0a1djpB4fu3LMYZrt2Y0w+pksMjEN5YIr3qsUn4TW17mQVVyY5rxnm+Ten+2
         K2BlvsILu5RrD0p3CwFoWfou3WHFI45b1T25OvUo07GlzS2f8MtcC6Fp6YXbqZv3bymh
         /umxzxrQ0hn864YUDN2qNkh5rPSwfxG8QJUgYUB61zD+wF4hRxL9E+nD8GSKL4hdc/nj
         N+0XSlwLfDb5Eg6vnoAgdmh5Z2/wU9HudTxqWbZ+UzRdkigI2p1UlkGEul4ryVUvax+q
         pZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883829; x=1789488629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=poYTtXrOshPnuod9r2bdqDYd8uCotQ96TbvuwA7Xqsw=;
        b=ZaiPas/2quT/m0DHthfsbafKsjig0zovxSE0p7nJOrYW1+Sk8cLTQashBgDpqbw9cT
         U++qe8CIYQQ1jxPnsdGuPFWkfe14JSGOw6Wq4YbHwirw/eV4KLieu9OgY0O+5tLBS4GG
         w1Fv1F8Gz82u3x/1Qr+y8T66uafsv091le4HW4zwK41cJPj0dLmmcvmTMUoSfhsh3bYU
         XuHFMohq2HeyFHZuVMw5HM8ITVRg4Zy8aBr5fbAbZiZd+sUr3UF962qht7DdPX+gL8JL
         N76YA5ajVGtgkxEBNNtXUpRNoeMwmTKPpdqYQIqrNqq8dB4FHQASzZdFxrWUmHe229X7
         x2pA==
X-Forwarded-Encrypted: i=1; AKwUvBx4L01HpgJ8MDTDUPmf1yzeQNOgT6662qrXorE5J+UNMgSd0ykB5n/ooTJI7ZZ5rRxBCHe86H/G8tg=@vger.kernel.org
X-Gm-Message-State: AFuF++mSFoSprLoHIM37ZPfTSyVTGWn+1mEDwebHo4VNKR+dHO/vCIZe
	X+p1sgA9y9E9YfLShQkC1L7DWPnybzwcsQPvR9kpaRzN+a1ZVWbUY9zt9Ylu8/Simy4JBUKRW/9
	STLhnERF4UN+1VQcWi2B+pj9jAGtpswePz6hRD1A7lBfboAfUAL8t/fpxqY5j2AB6v7ZRcTJMS8
	FfxIdvEt54aXaJ5Tw7zC7ogoJcuLwKIjaz4rbCUg==
X-Gm-Gg: AYBFou3CmQ3bFl8EJtFMZFpgzf2uhWRIoG6I9HTQlHAscyrxjhyBd06UMS/LQgQNJpm
	sF+SdBKiDW6DRU/s9xcYlWTLmiyStRDX/P8JISZ34FgXXpyRXewAXm/7bpFSEOGB+EHf96rY0UX
	0sS5TdCNPv7y/RSSQMzgNzI2+hcskblcfwdhcBBTRUUwu3eOA6NfscK32MeA==
X-Received: by 2002:a17:903:b48:b0:2da:effd:f904 with SMTP id d9443c01a7336-2db1258c686mr415608015ad.8.1788883829149;
        Tue, 08 Sep 2026 09:10:29 -0700 (PDT)
X-Received: by 2002:a17:903:b48:b0:2da:effd:f904 with SMTP id
 d9443c01a7336-2db1258c686mr415606815ad.8.1788883828558; Tue, 08 Sep 2026
 09:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787240090.git.geert+renesas@glider.be>
In-Reply-To: <cover.1787240090.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 18:10:17 +0200
X-Gm-Features: AcwNN1VTV0JnOl-p62U3bYhCoItyrrp3uBkyaa2BVtYCssF8EZkcLiIZNULpQBs
Message-ID: <CAPx+jO_Q2A1LAM-1MTFwGpULkiyHzWRUE_tpWYWfO6JzFAcdxw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: Make sure clk_init_data is fully initialized
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ulf Hansson <ulfh@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michal Simek <michal.simek@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=TqLWQjXh c=1 sm=1 tr=0 ts=6aa0337a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=gdcvayKpbD3v4lRZIwgA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: erkzMj700NGV5su5cnyjO8jr-ZadYghY
X-Proofpoint-ORIG-GUID: erkzMj700NGV5su5cnyjO8jr-ZadYghY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3NCBTYWx0ZWRfX6WECUW7tqNG2
 pOkQjKR9smuE6rQRM6Ry6rehr9BJzGtzBjRx9KleKvFQj2Tos8a5Bwqyv+idnsVfVHbewyh+7m/
 qa73p8hAbBnQq7qHmKupZduoXQ73KFg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3NCBTYWx0ZWRfX9hV79jITFfRD
 hdYILXaWxDF4uQAShMLPieOhxn8vE8dUYA87Ol3foNqNjEC2kwck0++SegbbotyGzOu4SBEWdrK
 q/PUQBHu7Deqn6EhNDoBLRted9iZTRIP3kgyuqGEAmKqS2duEP+XJRySSuTh0sp2xE1N8VIT8Rm
 yHVktA3V817umEo+gE7mveQCiDBaRBkCyECq2uj3NzBSybOVL1E8/PzjYABcUIS4WrbiGQ8ayMg
 yq4R2wF1WDOkh9z068VTjrBI6xH30a/GboVn/Phwc12XgHwV2t4J7hKB9bL34Imqna/ZB99+6sr
 Lvut66UDaCsAeB1YRv6mPoL4n51GT8iaPmW9WYqgHe+XeSl0cWLEcm+pOfkf3s50IbI7EEO2jca
 /edgzdmR2Kv9PDd7fAgTcjkRt6Vrrumt+aaw/c1oLAiG8c9FlQPbHmh/99Vv+dRpjZo5qRplgwH
 i+Yh/YRI6F+YHoiwCOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080174

On Fri, Aug 21, 2026 at 12:06=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
>
> Hence this series aims to make sure all members are fully initialized,
> to avoid such bugs, and to prevent future breakage when converting
> drivers to a different method for specifying the parents.
>
> Part One[1] fixed all cases that I identified to be real bugs, in
> response to a crash I saw on BeagleBone Black.
>
> This series is the MMC subpart of Part Two, which fixes remaining cases
> that are currently harmless.  These are still fragile, and may cause
> future breakage when converting drivers to a different method for
> specifying the parents.
>
> Thanks for your comments!
>
> [1] "[PATCH treewide 0/5] clk: Make sure clk_init_data is fully
>      initialized (part 1)"
>     https://lore.kernel.org/cover.1787165329.git.geert+renesas@glider.be
>
> Geert Uytterhoeven (2):
>   mmc: meson-gx: FIXME: Make sure clk_init_data is fully initialized
>   mmc: sdhci-of-arasan: Make sure clk_init_data is fully initialized
>
>  drivers/mmc/host/meson-gx-mmc.c    | 2 +-
>  drivers/mmc/host/sdhci-of-arasan.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> --

The series applied for next, thanks!

Kind regards
Uffe
