Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DA0368282
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883830; cv=pass; b=qoP+Ig4tEAuXif9Cwq98i9TgVYAV/ytTVhWSq66mA5jDTXESa5kT4mTaJGhq6FCZ2hn51UnRyf/+WQVRN61NjQwPWT9VnK6MtpKriLfGlCrSVec7PZQsr3+CFXVwI106Tl2t47bmWouJhPsG/jCD/Z/a2frDRLmgNQwaMR7XOQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883830; c=relaxed/simple;
	bh=WjCczMzq7v2DMLMClL76SWWp3Z7LjHwb7cMCKyxrJCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlyVymaG8rgmTdAVxHDmmLyAPgYoXFH/lz4N1hmrgNVB1Z/8/4x12HOzTCF9EEvpkFRWEidGrju/jXS6VZUI/sV1Iqm87juzzzVbcEdzPc/uLl0QMBeVDvJlX2CYgnvwXkn9dHL+g4c8mrw8HWCPk6EuRO9pyKrqX6VdNtcKGt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hFW0de9n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KVEtJois; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hFW0de9n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KVEtJois"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FdaV52194414
	for <linux-mmc@vger.kernel.org>; Tue, 8 Sep 2026 16:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gIptT6ebDKpfRTnQEYKVwnIudW38JeoR/b0x6LGj/2s=; b=hFW0de9na3S3aphS
	KMdpo/gpsWf6jTo8uGntP21Jl0kKTvtZSarFzZPOQl9KIzgkPdHmbsqDrLtxGD0w
	fghngdgPHdCm4GIs3bI5qm+xH00rGqe8hRWjvnQ2S0QOhxNPGryvxM5sorneBYkI
	0tpPrXPIoL5jYBFmuAf65IUcNre/SDyPHajBSIamTv+74dBlJvzn/02JBPeEuHYl
	RdU4Z05NVNCvSKSrNBRIol5e3w/UFETcVaT8c57qw0ushGQCSiujPnEmyUZkWi9W
	NZjT5JZsp0yUsN4YEJKUMBsVDp+ci+WsYUOo14Lc+w/jLJjZeuSk/4pLQoYJqA0z
	4XYeyw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjkshrn17-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 16:10:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc21bc2923fso5833062a12.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 09:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788883827; cv=none;
        d=google.com; s=arc-20260327;
        b=mU5TfZU36b+7JDIV0QC8bXeCWNb1BxCZqjPttGy/MQckH5e8bJh8zY/tlrI02cnVAK
         Nn7nZCyiGRSTH7B1hjr6lQVjiR3pdmdYJxm55FYAMb4iUiZWYWyyDO7zp1twMW/wtXXI
         UO0ei5s0zvfYuvrI6pXwTyFqPj2JAF+nH7joZvh01ws34KPpp3wD1d3CkN7ds1cboPrB
         BZ3qU53Z6bA+JxHnehn3IMnWUH6HekM5u4MjSYS9pu8y29CwXdhZS96ALIEdYoBtegXb
         fVdrk0Dr9YZtL0f2l8KdhF8klFflV+FxQ07ydgRLKDrQFtoQ419mUNLvj/Iysil4lYhr
         GgGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gIptT6ebDKpfRTnQEYKVwnIudW38JeoR/b0x6LGj/2s=;
        fh=lzuudfOyN83Vsi8eW/T2UjN7pi9GtvWbOFqnpe7UWxw=;
        b=Ngj5T1Bt6rX4S3rzqITfVHvFjOaxR9uLwJwEtNDlhwyBfo1lLSTXQAHFHbLZ5r3+ZD
         Z2IkMzs0n7fpejwuxmM2aQCrEiodJui9iciWlzY+Ms9/RQZozyNpS+rl+VnTiBPENqXN
         X7i2i7ZTSnfHEysukoYW09Mujae9rPmkv0AedmeCQXUDFsuKG4pr28y7148m9czdOhkf
         XXt91yofg1hBZXMsWhXuU/0jaQCwBUVOZhaqVW1lfxZB4glHbL0Dcu3Y3kJPJKOSUTPp
         6lC06J8HAUrMgqWScF1fkrav39tRGJGymNQIEjvz+77pvERnGyKRCGKwQWY+xt0XRcsT
         xxtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788883827; x=1789488627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gIptT6ebDKpfRTnQEYKVwnIudW38JeoR/b0x6LGj/2s=;
        b=KVEtJoisMPMFUwnND5nDw7qFcPAotVoJgDlXPWsWVdOd0y1REVJsbUtD6+GBjwlloQ
         y8vjF2p3lGvVgYoZR1xBYXNfDh7yC3lVGjwfwd1tw9csFuWDl1auVsdCx3tuogG1DK5m
         ZwtPOjFmHttmlm+y3XA46uEtq6RU8qiYol4MtVBbSFZ81IpUm7N4ukVs4V4lgnptoPto
         OD7cqh5KniwL0J5XAtl3WUAfr87+Fet07MUi/HiYYDz7MnN8BopnR/fzOmK9trx+aGZj
         +KQHCC26efmCehfircR3ik8R4WjQ1GJ5QJoSw04WmUXjRh7GXDapCmxNHIUEVhov7Gtc
         fO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883827; x=1789488627;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIptT6ebDKpfRTnQEYKVwnIudW38JeoR/b0x6LGj/2s=;
        b=CKn6zWoBiHSs38EB9hbnhb5B9SFAJyu1EfaCJPblrEKr91E0/Uqs4e+4v8vtZ9Hy7X
         cCsEl1WBxTibjtsjHhxENPifwYhW2pVCQQLPbxp8KLxc0yhR+vleYPw1R3unCMHBH78H
         ctdTtLi68nsvqEtRvq/bh+Tgl0O6QiYTbsHXP8AY/iLmipB+QWzyTNIleUnVv4pUzrIJ
         xpbHRKYRKexD+MHVZ2RTWqtPojNIzWMKJVztbd/0YFFpDJF/vk51YQlpbKRy/NeUUFq+
         T/Sx7PBlXs6Px4orRCfqwB88GO/YOmqqfXaUGObsdCfuuG5QYi8d+8DI2pqZEsYg6sVw
         95WA==
X-Forwarded-Encrypted: i=1; AKwUvBy3K2ZMsHaOABZWhPbkFM0TDwKrazrKFDu3b6NFU3f4lIhIphj+QgtBGggpY6U1HoqVc9fa3Cilmuk=@vger.kernel.org
X-Gm-Message-State: AFuF++lfOsg2h7I8nvxmj7tqTuQXAOFGiz7kYpl7vd+PAxGBheg6jU5y
	hdeb2VR2Ylk3p6Oqpq3FhTUxITezC7SO/zx44J5BxNdMwBeovxgk3NXePP5tzgPo2iCWsDXjlmS
	8qTaxD/JLsEx1Du67p8sG9MjksQKJpaaYtltq1QgUwSDarIgpTNGlLHLyKIJpIf7dk1KqUkrQS/
	pjxLtIPGHM3WOPzD2834aontlZnFQKf8JkKJylBA==
X-Gm-Gg: AYBFou02kYmVNAawfHIN/wt0QIeFhuXCp1Q77nF2zRu9LOQgzyjJJk/1zakUP5Mcmq4
	8AzRmbG+nFkPXIuI9SYbRD9dC4+/k+x8dZy7tyNXemBIJ/QqWnAoR+G2BoXps/WT+pEvTr2sP5H
	6xjyRBfWV10gOkrCleKE6H1dQ7b9XsQZmj2FaPEfaRnKzf6Yw8qxAjz5WOzQ==
X-Received: by 2002:a05:6a21:648f:b0:3d1:5c01:e6cc with SMTP id adf61e73a8af0-3da39f7bf83mr45855675637.10.1788883826563;
        Tue, 08 Sep 2026 09:10:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:648f:b0:3d1:5c01:e6cc with SMTP id
 adf61e73a8af0-3da39f7bf83mr45855537637.10.1788883825825; Tue, 08 Sep 2026
 09:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CD1C18732FB187DE+20260818113153.3521044-1-raoxu@uniontech.com>
In-Reply-To: <CD1C18732FB187DE+20260818113153.3521044-1-raoxu@uniontech.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 18:10:12 +0200
X-Gm-Features: AcwNN1Vap-n-hNxpqf0uBnt7qV4BRywFtHrgMgkW8s4z4JbnZUCZDoemIXHPZM0
Message-ID: <CAPx+jO9BF2ZjPsL9MJE_dTT8pmO4WqRmQEWF=MWNR8VtsOM9WQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: spi: reset bytes_xfered before retrying CRC failures
To: raoxu <raoxu@uniontech.com>
Cc: ulfh@kernel.org, error27@gmail.com, rex.chen_1@nxp.com, kees@kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3NCBTYWx0ZWRfXyzdOL1uYDuaM
 53fWKQ+2+dxjUdb3wN+xak0NsUJEkfznqZI5rogWO2IJT4WS4uDiz2mjQtgBFQPYRBDN+t9I71t
 /ciC3pBoMg45yU/EkXExub8+7mr9IDI=
X-Proofpoint-ORIG-GUID: zMD8RKIE59ah0QKwRkPn0F4xGQJNBPnT
X-Authority-Analysis: v=2.4 cv=TammcxQh c=1 sm=1 tr=0 ts=6aa03373 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=iHwBjlyiAAAA:8 a=VwQbUJbxAAAA:8
 a=8VdVo41s6FPOG_PhRFkA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=uNSKXYNwxGiU6LD0JREI:22
X-Proofpoint-GUID: zMD8RKIE59ah0QKwRkPn0F4xGQJNBPnT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3NCBTYWx0ZWRfX1naC7pIKa6Dg
 K3huRoUpiJkTiD6+1ueR7HBGxzkWxHpfN45Ru7dIFNrj0R4QytuUIRkPHFR44wqyehScG7gE53x
 XKbghHtwvt2DOA+6R++5aV2EJsHFRJS+jfUTjiWiG6nIC9Cvu9T+UfSP1fqfOKXqd/CtlnlbSDx
 fYS0BIp6X8RjtMBVL9yd6G/88i0+TARYz9XIhYL+v3EqbvOhhZZJ1gv1WZrV2XzRQ2NZs4mYfrd
 O5cgS4dzYofYuoNw5li8LIkKO2ATOQ+QBSYRpw6rCFpMJesVA73EbJQ2h1vs9GH1UG9SOUnv1yE
 rk3z2TgU7EvLG0YcGk53pwA0YELTTpwo2kpPjS0oaTz8L6MfmvCUeR0mjAJhBd7zB2hgkFVzLTY
 EJ96sYABLuD7YSriIZGIzehZRE76m0SNHMyPzq2Ovf/FohFp8t+f60C+LGdk17Ol2dPHp3Lhnqr
 yenk6SL0b8ANqJfyMEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080174

On Tue, Aug 18, 2026 at 1:32=E2=80=AFPM raoxu <raoxu@uniontech.com> wrote:
>
> From: Xu Rao <raoxu@uniontech.com>
>
> mmc_spi_data_do() updates data->bytes_xfered after each block has been
> transferred successfully.  If a later block in the same data request
> fails with a CRC error, data->bytes_xfered may therefore contain the
> number of bytes completed before the failing block.
>
> mmc_spi_request() has a private recovery path for such CRC failures.  It
> sends STOP_TRANSMISSION, clears data->error and jumps back to
> crc_recover to issue the same command and data request again.  However,
> it does not clear data->bytes_xfered before the retry.
>
> If the retry succeeds, the request is completed with the bytes from the
> failed attempt still included in data->bytes_xfered.  For a multi-block
> request this can make the completed request report more bytes than were
> transferred by the successful retry, and can even exceed the request size
> when most blocks completed before the CRC error.
>
> This is most likely to be observed on MMC-over-SPI systems where long
> multi-block transfers occasionally hit a data CRC error but the
> mmc_spi-internal retry succeeds.  The data itself is retried, but the
> completion accounting is not.
>
> Clear data->bytes_xfered together with data->error before repeating the
> request so the final completion reports only the bytes transferred by the
> successful attempt.
>
> Fixes: 061c6c847eeb ("mmc_spi: Recover from CRC errors for r/w operation =
over SPI.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index b471a7795b4d..5217d713c826 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -952,6 +952,7 @@ static void mmc_spi_request(struct mmc_host *mmc, str=
uct mmc_request *mrq)
>                         status =3D mmc_spi_command_send(host, mrq, &stop,=
 0);
>                         crc_retry--;
>                         mrq->data->error =3D 0;
> +                       mrq->data->bytes_xfered =3D 0;
>                         goto crc_recover;
>                 }
>
> --
> 2.50.1
>
