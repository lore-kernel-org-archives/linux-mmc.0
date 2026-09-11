Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603B49363D
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141245; cv=pass; b=GDDT4QUqjXDIeIjKG1wFnw5l2wCWAFdCgN/DofLIM221sw2m7mhJKLztOG5fRUqF0/iDwUfjhaU++mJDfWhyCN+33rGP65z/ZQ/cilTjeHFKH7TSrPiegV9kihNV4zNa0w0aiEHauY6Pwgy+fMhir0yv5paVVyuM4kxIyyXeQZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141245; c=relaxed/simple;
	bh=vgyKC5wP5vZQX2PheX+c9+cU97I65EruQX6t6jcv46o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGo/g1DaeWTPuFxXalZkOfY+aaUSdj0wviapNh8/ZX04fZdypQdK9777CfhYJOWR/dF9mspny6Wswdcb9/mnhdNN9mLBZ3TVDhS73kJ9tHW2w0TdcXJ9LEOVMYY0iI1OCGVOG2I7tLF7gEfg5oDRb25p9GaNC7lHVgWfb9YE7ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IB1oiVth; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dCvu0A6Q; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IB1oiVth";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dCvu0A6Q"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEm6KG3251756
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cg1WYUrNGGFtVONVnKPa1Xj6heNwOWL+7lG2ZgsnoxQ=; b=IB1oiVthkc017Lr3
	F10TgPdkwyu9HwHfYLXWwlIM0RrPBOwAGhU9jYJ2fn0O8qlgQCeyqKzqtpFU8ok2
	ntwaN0rOSpLIbOywNILDKxqbzfeOl8hc+pQo96+i+8TobMIi7P60u/wM41oY1JIz
	7E1ewMOQB05eyPCLEVf72fMmiYq6PWk3FpI4Ri2OHqMiSbWK49ADqiwRL98PyWiR
	15rHeugTn3bw0tpq+muCMl4usWNgbCA83IqqvOPbZ5K0Q8PXOpyXM/wBGC9m6qJ2
	Vv18YGc5T3lKmmmsJW+wuVnc0efVRqiDA8nErV41ZVhqVBbHEvyMzXY9IPzgKvfM
	mS++rQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm7uckakh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:40:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbe77d6864dso1462756a12.2
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 08:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789141242; cv=none;
        d=google.com; s=arc-20260327;
        b=p/tL4SdH0qjXjx5JeDYUvX4/4lABDxoCKQOySzOegffntHOk5vOw75rCOC+qI7TiAg
         qOyFeGXgD5zBYuO9l1ZCqi6QyCwF8xcxFgBln35eK6Vr1EKb44yY1IA/Q6y5Rjfoa6aH
         wyYJKwgbF6RdbcXMYOTZKV7k99mDojcbAznJgvyxRqdS8Xz30jSYez5PAuYisuwstDW0
         WZ8gFqBVBMMGVOorOg9Bi+O4ZIQw0EYIr/1HC9jJD7IEuM8UdhgXNzw5d8SizWAOGCmQ
         +CRgmYDebu+PAMuNaxHWVon1J57JBEfdC6RI4+FVWuAfNexFWhYeIMOtbC9/2yi2FGsq
         07gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cg1WYUrNGGFtVONVnKPa1Xj6heNwOWL+7lG2ZgsnoxQ=;
        fh=l/9cwteLKqwp/iPOpCpbbJdBU8PNIMuvdIynBl29hMY=;
        b=HkFmjxctN5rKCNRzIWXIl4TtIxoLWmx5cVlY07rMoPI9huGB73veisH83y41iZ1Jpf
         dXiwtszTAS1M4wi+Kq5CbMW+Vx43dALD1m7c/HFSuZX8jtBqS7r+QC9to8+9wkX+v0dl
         n4FtTNnzMhjqHxm8TuEF15ASmu3gBiIrdRuXXptk1J0bbviWol48ExOtmlfAHlyw39JP
         LVkRUgbs/QSZ3ck1YEnmgx6WnCm8W2BSdUAKchGteYlVwvVmF/KYlCfjYusKGVb+1LTH
         Da0MPXuAK2Y+PRlQOTLOG3pgyVHfwZ+T0Dno1pITTZwCRnRVg58c3S4MdoXjzFn4ows/
         2beg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789141242; x=1789746042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cg1WYUrNGGFtVONVnKPa1Xj6heNwOWL+7lG2ZgsnoxQ=;
        b=dCvu0A6QmVJywxjnT+45ZxK4yycGg0/qP1N/VBGCqE5SPQATirAqj88os/89lAQu+N
         T9BPFB+vApynr0ZHsSfAkXc4n10GoOpKSChYTRPPP77MfSGaQegsqln6qSr8a6mHAB5V
         9xAvXXOieJPpYjFf2cVCvrzu7nr1+bBm8Exqhc3w3do1fr2tLgXK0nXU1AlnCLMB2YlY
         OFvXIMFmAbV1HxqbHzKQ+xp128aohzYaKJ0fR+4FcQLrKyPkV7rElh4r0xiM9aOcEIyP
         V55dyrKUA2xJYtKBMbMK3WEmz42rd5RC922k+PSTZmwGBmQHuehDb/Pra5QJBFagCdnI
         xfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141242; x=1789746042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cg1WYUrNGGFtVONVnKPa1Xj6heNwOWL+7lG2ZgsnoxQ=;
        b=QuSkWTkxpQwdCT1yIGygaHGfw/wjDDVzrm+mkRZu2QPSIJzF1k8Z/K+WaUwAwlyMbe
         jaBAG2Czrnh5RZrVUs+uCbNXD6A4IGBgG8tUAvzX9HQVCEowjEflWGAl4MoQZ5cpoDDi
         jJ+Oqhnpjrk8WI9lj53okraN+zUtxCDttlIu65zSgVZxg880qcXjpZGZFo7f+RzqhuJT
         Vo6NcXEdrGBZqB+rAzMCb3KDRNjvJwHakLKxGhiBYeQCBRKNLnut+2HOPWwUd445pR8z
         PmUgd+6NMa1vLP1p/C4OWYjEadBGQOimzqa72lDGUcwYCiNuiZdh9R92sxe7yJ0ZZve6
         i+Hw==
X-Forwarded-Encrypted: i=1; AKwUvByY7CAocfMyZW8MwGBEpGsp7GZE4xnZLPaA1KsMKqihs3kR1BkJ1Jxq8kXwCx6F9Tbwfp7xfypY4fY=@vger.kernel.org
X-Gm-Message-State: AFuF++mFGO5KccZZ6m7VuLJGOGlP2JIrc8obo6dDi7Kg5KcK+W8vtY/v
	YLbRvTNJ8SLVQoEtlOEUSTYH0ZkMpSqLrOYjXZrgKyP4Zmk3nuftAVPXi/jG23yAOV0eppYXVQs
	30GXUQwlgbK6Z/V2T9rlCDwsw8xlH//kzEbaIhr5NvKDf1k0aYDCSLyE5JePnY9Dnxw6FewRrDr
	Yx5hvOGywMdcDFaJRs87sek9EqmZbNcnjPvq3/LooTSQUU7w==
X-Gm-Gg: AYBFou3P7ntmbgEHp7NdJiTboP8mac0qO6bgkvBNmckDLu5dy4wdYOkIfY/H4DBzTZH
	mwxBUV/kzxCbrK8+WZEuPMoomNnQxnL4O9INtRbpZJFzWBDbcv3KwHbgE9QxOpfCj52K+xIAbko
	x3wtmkkzVR9RlNzcCn/WOfGe1LkClUbaBhTdXDwjRL8wZVq7PFstY/gdA7vw==
X-Received: by 2002:a05:6a21:6f88:b0:3cc:3d08:da39 with SMTP id adf61e73a8af0-3daed20b6e1mr9948479637.0.1789141242508;
        Fri, 11 Sep 2026 08:40:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f88:b0:3cc:3d08:da39 with SMTP id
 adf61e73a8af0-3daed20b6e1mr9948399637.0.1789141242111; Fri, 11 Sep 2026
 08:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902140926.3576781-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260902140926.3576781-1-runyu.xiao@seu.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:40:30 +0200
X-Gm-Features: AcwNN1UTv7W64Xm4jZLjYkdUFI8rRmcEfot7t-_MQS7eHd04yw0TvNJhM_aZyck
Message-ID: <CAPx+jO9y6t7vqWqpVZpt37N_71b3rL1m-=RF2RDgtB4vkvS4Dg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sh_mmcif: initialize IRQ-thread mutex before
 requesting interrupt
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jianhao Xu <jianhao.xu@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=O4asLx9W c=1 sm=1 tr=0 ts=6aa420fb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=E6_GXre4Z2_RQDsjcpAA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX5RfF2xvhDK8q
 1mdRVmCYBBdjtiB/mZK9SZfDQwl+XrEJnxXGGDr3cbRVoOz2+JsNJvInqw9iJdN1frAqGtsPBs2
 Uoe7nFz6VtEcqBt4zgpWNw32pEv0QSYb87GAvok1WafAKUQT/wwGTrcBHZKtwP+PJvEF6/Txm1a
 Y0SZhx/Zg7n1kBVjp//LsRB3Y0sGLortzgw283uKN6Qxa14d23yqUHMlFPhgoy6z7fvMg3wIhkg
 2Z3LndxoeA4xV67btiMeNM+brZGGKxkE0Tlsy61HAGKE54MsDXbF2pjQTzes2BmcbHD4Twyzqb2
 E3N2jwTGlynopfYGiRfa+DpLt17TcCsmc2TJ0QdskhSNKM1+v9eLVTRm9MwHdgNHbIbahhosrOD
 BPkv5XYIW/RIXyXwv4jQjFjjXLOHkvlXkSIZ617yOn2KxkDqA8Ts2skq9bBG1zEOKZMZP5zj2ag
 dPA5OrHO16uZjtnCx5g==
X-Proofpoint-GUID: N-qL6RxAxjVl1xefaTDhqWzrjS6mNWxX
X-Proofpoint-ORIG-GUID: N-qL6RxAxjVl1xefaTDhqWzrjS6mNWxX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfXyC3e2rjNkFzD
 N+Kyb3yNIV481CO3e1MZ2HMhT76UBqVRGdhBm4HGFYYDjGw8EgGWtqBO4FG+j7OkMSZkqRpGQkv
 Xkp9gkvBK/yK66ZBtFmPt5evNTndmmI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110218

On Wed, Sep 2, 2026 at 4:09=E2=80=AFPM Runyu Xiao <runyu.xiao@seu.edu.cn> w=
rote:
>
> The threaded IRQ handler can run before devm_request_threaded_irq()
> returns, but thread_lock was initialized afterwards. Initialize it before
> requesting either interrupt.
>
> Fixes: 8047310ee984 ("mmc: sh_mmcif: fix a race, causing an Oops on SMP")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sh_mmcif.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 7706d01b1..8bd9cdeda 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1461,6 +1461,7 @@ static int sh_mmcif_probe(struct platform_device *p=
dev)
>         host->pd =3D pdev;
>
>         spin_lock_init(&host->lock);
> +       mutex_init(&host->thread_lock);
>
>         mmc->ops =3D &sh_mmcif_ops;
>         sh_mmcif_init_ocr(host);
> @@ -1515,8 +1516,6 @@ static int sh_mmcif_probe(struct platform_device *p=
dev)
>                         goto err_clk;
>         }
>
> -       mutex_init(&host->thread_lock);
> -
>         ret =3D mmc_add_host(mmc);
>         if (ret < 0)
>                 goto err_clk;
> --
> 2.34.1
>
