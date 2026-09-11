Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1813932FA
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140508; cv=pass; b=EttI6IC8hbBerPn60h4nrlZlghwJXwAXeNcEhRxbxuTWt42lQNVY4gxTEy1CJmFQp6j895W7FljjRrdcG9tHwnWtY7aPB3JR/2v88jObTBe5dRmJP8TKRk77PLtX1ZbLXDpWfCFTdamZZRmpqHT2CvtDbbnSM66KKf2OIOtAxrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140508; c=relaxed/simple;
	bh=R5n/jjsRA/NUilRaVSmCDbA1/CUgsa8ZyoXeF0hNg3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhQ3Rd6aRVeDq7UjaWrxQlTylJxjHFq5Lv+mt9jrcZKCo96rrUFgAPQKv++m8XkD+nvV738298Xzc4ajCKiowcfD1m1GVGsH+yTAMRYg2AEy8fhtc/+q87ZeniKmmtJqhp1AFCtCjezohkQtJSC1CRdVNEUe39yYRvJ2F7C4q2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iofmqfl5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FsGULuh+; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iofmqfl5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FsGULuh+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEm7Lk1090771
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	svMDt6dlhUloJNhLHfCFC18SuqeTtDnWBl2KFSnEON8=; b=iofmqfl5nUKEyiEf
	1wn6qM2a6QbNKP/CgNjsJxVOVb1oCEbjVJKoMNiryd3x1Nz16/z/rWyCA4nGhLVT
	Cs97sGwJrNfAgHqX2T1ZAnaFF5rqbc3xO/G6XYNZHDQozi2ynwcOaAqxWCVTjRit
	8sEV3ILYlyi7LBDIaI8vPvfNun6cbIuMqUyrVbSxFZAYSLD2EjD7peMXGmnHygE9
	cf+3W34zBnyPK4kXQFBNpeEeA7FXECt9zQfyFnAr7ckpwfum0hzC6pL2BNLsv+nc
	eQZ4YQBmZQ2HFYr69gVqBMviO3E9PmQK+R/4HKiJVBK0FmSFKsTjxhwLeBZ9XjgA
	HD/nYA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd3ahem-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:28:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db87f759c5so17768265ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 08:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789140506; cv=none;
        d=google.com; s=arc-20260327;
        b=MsSDbFyEmjHpUaAk2gAQi1Q88iUNAGWrEPYOs0C+h9iGUfS7DilTeiXguEpXSrjZzo
         bLNy/5/5QSveJEktaQ8HP0vqcw4hX9F0IRbAksAOg6wr3nmvUEbqI/i8adFXM5T2RW7L
         UdoAPDhm2uyOs0JNH84O9UwAEhWz7pX5xKHwaQ1PyAerw7hrXHCTBiSHGzeZm2cFW5UN
         wpBzpSk9/qKvigwE8QjMSRmKHoE1UIFynTySv6Dh9mbmmr8l4gFZTzsGs2Sjke2+RYEI
         /wejyjPwV1taufQxggvRR+7ofEllHe0Kk7ZfiDFLsElOAJgzDY6GYdwJNNEFSWacPcoO
         MFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=svMDt6dlhUloJNhLHfCFC18SuqeTtDnWBl2KFSnEON8=;
        fh=AVRQHq1ZE5ahhPGL8Y/O/VATIiJKLYcgMfDX3ldx6mU=;
        b=O/igmhKMDvD8DePnfOey0fDMcH8fJfNaZJjmUf1DuvaTRDkT1N875lRy9RAsS01xBI
         GEdIQeoWXVAVtz8fgBKTyngNwAkKOAkTp24DpVRlpvCV6qTWfjiiG4FQv7PDSOFv2Arb
         2fPJJbLLNU5PzY0zE64vn6J4SMlsLbfhXf/SikLJ9vxEJGNFhqntTdSSJxTAw66F4SFS
         upjbrcSFnh9Tvm1vXRFCy6+BYDD/Jf6toIG8Q5zXjht3Gipl9SaC5MHwE2LrYUg4J/FN
         DcEiu+oD0HQGgg6TehNsRu6CqEKHkJeAzMvQHGQuG5rhv0GgoAX8cShe492dgJiBwGwj
         n3lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789140506; x=1789745306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=svMDt6dlhUloJNhLHfCFC18SuqeTtDnWBl2KFSnEON8=;
        b=FsGULuh+qf433375ubFP2FW9HdcXPgXhPXFRgs40e4P4jkJl6V/wuxO6PVEkQ1Rz9y
         gLkQX/PUj99p6VXoAaEP2OEbAhCNDL8NXarruIra1fDFPgOJBrRTMlvHiwTSGsPHqyMl
         ENhEUNfvmRdOS5qsOeXRXwoDDtZSaxkLLOCJq7+abinBsak5ofF9MwMNsgW+loaTHuTo
         +erkvgSaMJqpImaE0FOHSciEiEoQTEp9pJ13XIbvUKN/d/92DhZU72YeHh/8BKLEXm7b
         4u8YBa4il5nESSI+0ByryuTY7lLKMLVuHtfTt2El6ogrtUHxygXzVkuTw6qPRrEP0mHt
         dyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789140506; x=1789745306;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=svMDt6dlhUloJNhLHfCFC18SuqeTtDnWBl2KFSnEON8=;
        b=L3E+G5oRCxQZ6WkbKwBAGXPU6t0kWd3vJ5WLPyTsy0kC8B5Qli6AaXIvLHrzi52gZp
         uBJOHfRYXx1jimGOkiGY842zqGrHG8vuzRBiJHxO6N28CXFVQj3tWNjAS7T/SaQ8c2yl
         WPtaDpap32GNqRMMVe1ZkGkif1n/KrqyAc4Rte1m8riCzT75z/QBg20Wbl4cXGSFA/pd
         so179yK0KsEm1MEvzGuCoFF/O30Y+UVoa47fHRKqV028Inw1vbyhZ+3PnxkGdUtA+nbD
         EgeAMdMWQoKuu7feL2cpcJ/UVQQROmU309HXolkTxe7+m8j7Ol/bPhVYvwYUqhpqv+X9
         SuxA==
X-Forwarded-Encrypted: i=1; AKwUvBxfC+76ts7yecLpDPyu5Ry3W8zdOcKnp8xV2c1cDyjgpEeb0G2ojcFb7VNFFq7CF9IMt856z18BnmA=@vger.kernel.org
X-Gm-Message-State: AFuF++mLTnJYD3zzoKtaxq4+IebgKZbciEFXZkb+9bHsUzHPI0L6hYMe
	8DvuR2CnVU/0U9YbbYeA5yyCwl2sigNGFfLQR9lyHWYzZypIUewYIQcToFg0isPcDm1r7dPjR/f
	u1/in7bxCj3jLPxFH+oyLJDU7l6PA6y67ES0Xzvc7XHBAhu3Ejo4O8sSNZixjlCuo8sxbiZblji
	c4PSw7LjFw8I/AW/9eSlb51kfEQ8HyWF0jVp0r/w==
X-Gm-Gg: AYBFou2dWrymArkA0kAp40EHfPracIXh+YO48OsPJPhSz3zzKRaq/A3NIidpSu56KKJ
	32f+lUnGbQrvmQKeJzPkIGEuasbMJuyDQysy1O/LhVjOfChV1RHegTrX9wr9bF0GQRTxOul+AWh
	k+TDPp4uVbYiaHdekVONAY7hmxDF6klPgPrG2WIKZi8GwS/5Um0MIRhA6asg==
X-Received: by 2002:a17:903:2f8b:b0:2d8:d4d0:7930 with SMTP id d9443c01a7336-2dd2a455062mr81599565ad.20.1789140506054;
        Fri, 11 Sep 2026 08:28:26 -0700 (PDT)
X-Received: by 2002:a17:903:2f8b:b0:2d8:d4d0:7930 with SMTP id
 d9443c01a7336-2dd2a455062mr81599245ad.20.1789140505659; Fri, 11 Sep 2026
 08:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908093758.596444-1-chunfan.chen@gmail.com> <20260908093758.596444-2-chunfan.chen@gmail.com>
In-Reply-To: <20260908093758.596444-2-chunfan.chen@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:28:14 +0200
X-Gm-Features: AcwNN1Vt7W-bt4IR2okAT9VgkUOIhH5DNfot7X0_JsNH2glYNJpfmkK5igPON3U
Message-ID: <CAPx+jO8xjqpmChF_F_ZAU0AmbTY8ww-K3vq62VDpR3n+YJe=jg@mail.gmail.com>
Subject: Re: [PATCH wireless-next 1/4] mmc: sdio: add NXP IW610 device ID
To: Jeff Chen <chunfan.chen@gmail.com>
Cc: linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        francesco@dolcini.it, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>, Jeff Chen <jeff.chen_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Bv8IUoX5 c=1 sm=1 tr=0 ts=6aa41e1a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8
 a=GLjWqU4heM0_rUE6tFkA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: PqFJAeht_Ikx7eBIJFnVf1EfO06Laij_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxNiBTYWx0ZWRfX2I+vU3bj8Uv8
 0sM4IqkGaNZwu1QftrrtaBKwWCpNo/TjUGPVLGyurOqaPaHxHEiQF4KTGgmuwiQJ5Gby2i2QFh6
 gp3KNPcKIgugsWGcXMwbaqffEQG4qaY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxNiBTYWx0ZWRfX+5X3urXvwpEq
 +ZVl6FMvmTv6vWLpJmVPL7mbuA+GaQYDQIYbS6iiZ3bfonVMUNA2GJL8tMwAdFpYSrhm1xNxkvw
 XySsAaPU7gD4VfHD6KC/IYoAuBCNUqzEg5W8EolV1B0fsGzXqWgs09ZsbJ5xBQrL/FQhJzwfOrF
 HS7BUWyrZ7UmEACF5Wz/5AsDBu2tvw2opeNNyTLXrbHO25LOJRvlmNvI5g/Njzf/E14T1Q7PKU9
 Asfy4fDaFvtKRAMO04NdCcuWyYjfSqWEaQtzdmVD3O3HR8KRAJYbnzs3Zj3koHVeyxMyMirYxV7
 PtSDJzwxGKOqc+0lY7siRA3/DFjNWXGbkoc+GUBdlKYzkrnTJyxDCK34fHRZS4t6KrUS7+4hWIR
 Ya0RtLz7sDLheY02WRfuQopOB06wujxMlvZU7WfUZi1hdAveVQoGT3KmullCy18PlcoMt99LSEz
 N7yi2UtenV8L+WPs8fQ==
X-Proofpoint-ORIG-GUID: PqFJAeht_Ikx7eBIJFnVf1EfO06Laij_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110216

On Tue, Sep 8, 2026 at 11:38=E2=80=AFAM Jeff Chen <chunfan.chen@gmail.com> =
wrote:
>
> From: Jeff Chen <jeff.chen_1@nxp.com>
>
> Add SDIO device ID (0x0215) for NXP IW610 to sdio_ids.h. It is used
> by the nxpwifi driver to probe the IW610 chip over SDIO.
>
> Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  include/linux/mmc/sdio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index afae93f6f245..5eff5e348eb0 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -123,6 +123,7 @@
>  #define SDIO_VENDOR_ID_NXP                     0x0471
>  #define SDIO_DEVICE_ID_NXP_IW61X_BASE          0x0204
>  #define SDIO_DEVICE_ID_NXP_IW61X               0x0205
> +#define SDIO_DEVICE_ID_NXP_IW610               0x0215
>
>  #define SDIO_VENDOR_ID_REALTEK                 0x024c
>  #define SDIO_DEVICE_ID_REALTEK_RTW8723BS       0xb723
> --
> 2.34.1
>
