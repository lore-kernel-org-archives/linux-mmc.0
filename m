Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101C3EB7E5
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352804; cv=pass; b=Xqf+NpaaCIOo5/jUiIAD+Whru2w016XdSGSNusWbMBbVv2h/bkCuHEBvdDNTs0lju6lnRee+Ci99JZWAau2Ty0GYbqGD3iuibsGmJ3gg1uBOzLRi/nCUyz2r+m6mKVAoGkJgOzkVIKRZ/Ey4YL5si7yFT1nvW7XPFRofHhnUji4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352804; c=relaxed/simple;
	bh=V/Zz4fc9ilJULyuvVJKaCtgYvntNnZhxkz6W7h/AV5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlH6HofMTLJfgkQxbTCtTBmrQs70WklX9XarfXGs7yA9nmATlFd/s37HNlFHV/GrgqXWyb7Mn6656yPmTQiSvH7h8yRKXmo17thG8+oYWdO+lm9VsvWUjy+IrcYbLptWg+rQWfGuMcOPcW1ejSurexBvs4jM4xxy5SZLgm7njY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=It64YZqd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QzLQTVZC; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="It64YZqd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QzLQTVZC"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF73u990243
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3xypUPvLubQm1/1Qk4UMSCjOCD4eeeEzl0qrPZ2tmTo=; b=It64YZqdQboZwbgV
	jN2arthvl62bMDnhE3LaDveUv4FdjOFji0EFia5JGs0fMSjyLN8hQ/4AfNqCZnzY
	CEHfOWn9C+rBcm91CytXQeNR69LJiKSd24k8zJZu1GGxV2f6u4O91NFlMkyBLeNH
	oQ0ZR3YzBNUczvmU+fl9MCJx1Nyu3K3jjoAsVp4pjdJpPo2ymhkMvElHIv+yzhrs
	5Bzcd0QC13jknE2hDq8D3aTcSRIb5nZI8TJ2Q0GhWdGCDUsBVH5oStx171awafp6
	DqXyY5gTOruYkbDAHi9zsigc9AaoKkANUgy01W/RFL1sKQUBQvUX+clO5hgCp5c4
	1ZLG2A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gsk95-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:46:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8e3ae05d649so40366726d6.0
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352801; cv=none;
        d=google.com; s=arc-20260327;
        b=VBZX5QW7YhrxFnSqwsQ4fbIwkTMZwVHlwawi+mrJmL/qonl1EPQzLgnf6TllVDPqw5
         G4EXy29x84UG+LALcETvr6j6cV6Vtu/0OaN7wLAXrObrMRavrZfGErZ5UF581QdwGnWw
         dW8oqDWyoy6/Ai8olqH5A12gYchGDk5S3kN+jU6cddU6pxfCY1mX70oxuvw5u4F5HMan
         WKA6VK0aAP7lRnYXD75G15ODRPeFXqPRTfKRvWns00F2y24WvCXNHDK/gxZujtuhFytN
         ugcBBo2p6fofW0qOMMp64uKkd5DgbfiUhxSAiG8qE/6KUfzD2i+L1ANTjk0ncuC8cdBi
         eroA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3xypUPvLubQm1/1Qk4UMSCjOCD4eeeEzl0qrPZ2tmTo=;
        fh=/8XIosLSgOQ5onv4cqqkXv77+rzuxlz8HnDGsQ5BSXQ=;
        b=PjNmntiiBS8FXiYYPfWTK7CKXCUq9e+Ml5mtnMI3hbyLL9yUUc6rBE3/lLfJR8Grd6
         8OxIiBHE6lQ3mz0dx+/nNGLbHKSchKx45O+odnw96MJoeFHfut2mn0AzZveVJ0NkW5rX
         l9SdEcBQBmARHnTxFRnfoC/Kl4a0biCE0DvpItsG/2InrigdmJYUR9qaUMUSI5qkKDmV
         i904duv7ZqbhoJXmLOAJ/tHGCnpZWnOg/2JPk/Mp4W2Eq5qONMXt/Fdiv6bi7nBJuFUd
         r/110ZpE/p2bVrPvWvtsoLxVlpo6IAqBDjzBTVGmi9PvwwkRJerCVIe8xPpXMz1Yq+T0
         CGZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352801; x=1783957601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xypUPvLubQm1/1Qk4UMSCjOCD4eeeEzl0qrPZ2tmTo=;
        b=QzLQTVZC8x+5md8ekYAZ/z3EusHDdlMt2Y2cYh+zDqGLol5UGoNWgPQhoPmTkJYPIM
         eN/aBivx6b+ztBY722neN6aGJVRvUQG1ckaZjTiLKC0V8KvzXMTF3nQSg+BRcTBmJx2n
         BTwbEIy3r0lRTe/xKT7xP1ZtLSNgAl1Vu2TItTtciejXhJTh8x1m0sWiVQY/cib0kT+g
         kaeSnMXPE1nmrOG/ZakRbI1Ks36EUFo+udGqVxx9XG3rtrkD+9UoF/ciNtwIGZX0pR63
         nlb/XL7qbbQi8Z6LqicFJX7hDfM9wTfMHYzaF8I5ITYuFvd6opXaqKUal1bGHjSt/YHr
         vhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352801; x=1783957601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xypUPvLubQm1/1Qk4UMSCjOCD4eeeEzl0qrPZ2tmTo=;
        b=pxEZCDtnbW1vleLzcu3pjDKX5LVvARW2daDXfkHXFP0aFI21HWWlQKCDsX9OGhc40H
         wnCme4tF+UWqfomJAY0SsYobCsO82dGDnsR6iYf9Vs5WOGHy1boc5BetqupFTJERuvw7
         UW4IeS8Zln4s3o4tw/a5nhufY0NadGd+S1ueDZFF2ydifjzX3cJcqoCvox3TnUZ8uCoV
         EfZzIZ5hqloluv4UCUXbqQrgJIuwE7Dx1f2rHjJSjpLeT23qgcuvcbi80Xx8pJDoLCw7
         64ca+rpOMmY1Eto8FOCIcipq2IDFCIqo3E01p72+XSs0z9OnE57anOyLBEW2+GydN6XA
         EkFw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0ys9RPZ0q1MqLhvmju9tL+pQGN7ldC8hyjqpgvvotA53C/ckAZhiCeAaDsaZiyiLyrTx5189QRaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOWPr+rFjwu1b1S2LyaXMaSdNGmyzDMwHuyscCcy/uPIVX9No
	Uhh0v0J9z2h20OyJ5EU6GVn8YiZ3mPrhMpN4/KKU5lGCdtSacWrqhU5EN+MQ3lWHJaSTAUGloWP
	BkiQ2o/WVMe0lwlGUUnlsYkdVa9kHhoeyhtByv6bRQgKcRz8n0HYGr0zzICru5eelxASWelljSC
	62MW4h+jrT4wuvZB86WF6S3So3N6IaWarzL6NFpg==
X-Gm-Gg: AfdE7ck5Xh8op18bCZ/82Ti8zWbUxYJZ/AnNGYMBjApukT6SCKuQNRpatqakqlpGXO3
	SHGZmaLxp/iNNrDxozD/ESvXc9McV6elUAJXib7PG1iCHe9YCusyvLXze9PMTfJ4webBghsIIZA
	Slgum4+r2OdSiJw/Sq6Qo7sG+fv3rOsK81jmmCo50/J4YXuZj8FiR+N24QuJVDETupHwQT
X-Received: by 2002:a05:6214:29e3:b0:8f3:8a75:f952 with SMTP id 6a1803df08f44-8fcb5abbce4mr13936366d6.49.1783352801097;
        Mon, 06 Jul 2026 08:46:41 -0700 (PDT)
X-Received: by 2002:a05:6214:29e3:b0:8f3:8a75:f952 with SMTP id
 6a1803df08f44-8fcb5abbce4mr13935776d6.49.1783352800368; Mon, 06 Jul 2026
 08:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609025458.13744-1-enelsonmoore@gmail.com>
In-Reply-To: <20260609025458.13744-1-enelsonmoore@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:46:28 +0200
X-Gm-Features: AVVi8Ce16IKovkNp7ixdrdpD2hLmFhO7URjbqFRpBgMGSiJRteU4DwswInGTdYU
Message-ID: <CAPx+jO9vdg62sff6eE8rCqVH=Bq0ZsbrA+HQ++qam8u-eaLYKw@mail.gmail.com>
Subject: Re: [PATCH] ARM: PXA: remove remnants of PXA93x support
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Rakuram Eswaran <rakuram.e96@gmail.com>,
        Binbin Zhou <zhoubinbin@loongson.cn>, Khalid Aziz <khalid@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: WCPxaazepdPyv-JFBXJblKYt3aCSYOgg
X-Proofpoint-ORIG-GUID: WCPxaazepdPyv-JFBXJblKYt3aCSYOgg
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4bcde2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8 a=JGXKmvUxgQsyE4geREYA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX5LJ4hLFnGQi8
 LIX7vmd08eZX8JQ5Ob94X+SXU3Q/RZzP4nvtbjG7vEhcxQi01ZlxRbXzQxv13bd1Io4oaFBOojx
 lQ49rjyfTweFltBgUycEvAJ7Gizti9hP+MTff5JwUKLS6X1XthygKm7YXUtU7nTuxndW6VKAmpi
 lEeYGP54WTGu/GoZEuwgPWfjWMkK7FsvKuogFaVQPRZJmTCu0/GJ9QeIjosdLkXjCfGPd2/aIc8
 yxK0Mhd/xqgpn5W+nA1TVNG1bpKjLNY8vCF1BFSzoZ8b0zwxkkmbW212DTxgRQDnFtnXzVUhGZN
 yNDvxzwyn0vKt84hRY3AhraUcOkfhVW+xV1AEyFBGJPzrRKCsPWklFNGEoAU84yhHFmOXoYM+ac
 zYhkcB0Xj9Rp1zwSM3MeQXwAKsPmJjcBlEdf/PH949lQblMvWZ9Z4O8886I21DZJXywMt7f9YiY
 56H6yDFI1ezChS2/ekQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX5nu9CM5weCvM
 vDXD9fjl4btTHl/5SE+h4viVTXr+TN54JbpN7qKM+BoD9QPS2N8nmU3CXGgbZ1ytzP0B4Yga+GK
 5L5vTpMCf2Fp7JSCBCm8PflnWjpSkWY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060160

On Tue, Jun 9, 2026 at 4:55=E2=80=AFAM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
>
> Support for PXA93x chips was removed in commit d711b8a2987a ("ARM: pxa:
> remove pxa93x support"), but some code to handle them remains. Remove
> it.
>
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/pxamci.c   |  3 +-
>  include/linux/soc/pxa/cpu.h | 56 -------------------------------------
>  2 files changed, 1 insertion(+), 58 deletions(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index b5ea058ed467..f8427f071c00 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -43,8 +43,7 @@
>  #define NR_SG  1
>  #define CLKRT_OFF      (~0)
>
> -#define mmc_has_26MHz()                (cpu_is_pxa300() || cpu_is_pxa310=
() \
> -                               || cpu_is_pxa935())
> +#define mmc_has_26MHz()                (cpu_is_pxa300() || cpu_is_pxa310=
())
>
>  struct pxamci_host {
>         struct mmc_host         *mmc;
> diff --git a/include/linux/soc/pxa/cpu.h b/include/linux/soc/pxa/cpu.h
> index 5782450ee45c..38bacdae684f 100644
> --- a/include/linux/soc/pxa/cpu.h
> +++ b/include/linux/soc/pxa/cpu.h
> @@ -46,14 +46,6 @@
>   *  PXA31x     A2      0x69056892      0x2E649013
>   *  PXA32x     B1      0x69056825      0x5E642013
>   *  PXA32x     B2      0x69056826      0x6E642013
> - *
> - *  PXA930     B0      0x69056835      0x5E643013
> - *  PXA930     B1      0x69056837      0x7E643013
> - *  PXA930     B2      0x69056838      0x8E643013
> - *
> - *  PXA935     A0      0x56056931      0x1E653013
> - *  PXA935     B0      0x56056936      0x6E653013
> - *  PXA935     B1      0x56056938      0x8E653013
>   */
>  #ifdef CONFIG_PXA25x
>  #define __cpu_is_pxa210(id)                            \
> @@ -126,26 +118,6 @@
>  #define __cpu_is_pxa320(id)    (0)
>  #endif
>
> -#ifdef CONFIG_CPU_PXA930
> -#define __cpu_is_pxa930(id)                            \
> -       ({                                              \
> -               unsigned int _id =3D (id) >> 4 & 0xfff;   \
> -               _id =3D=3D 0x683;                           \
> -        })
> -#else
> -#define __cpu_is_pxa930(id)    (0)
> -#endif
> -
> -#ifdef CONFIG_CPU_PXA935
> -#define __cpu_is_pxa935(id)                            \
> -       ({                                              \
> -               unsigned int _id =3D (id) >> 4 & 0xfff;   \
> -               _id =3D=3D 0x693;                           \
> -        })
> -#else
> -#define __cpu_is_pxa935(id)    (0)
> -#endif
> -
>  #define cpu_is_pxa210()                                        \
>         ({                                              \
>                 __cpu_is_pxa210(read_cpuid_id());       \
> @@ -186,18 +158,6 @@
>                 __cpu_is_pxa320(read_cpuid_id());       \
>          })
>
> -#define cpu_is_pxa930()                                        \
> -       ({                                              \
> -               __cpu_is_pxa930(read_cpuid_id());       \
> -        })
> -
> -#define cpu_is_pxa935()                                        \
> -       ({                                              \
> -               __cpu_is_pxa935(read_cpuid_id());       \
> -        })
> -
> -
> -
>  /*
>   * CPUID Core Generation Bit
>   * <=3D 0x2 for pxa21x/pxa25x/pxa26x/pxa27x
> @@ -218,22 +178,11 @@
>                 __cpu_is_pxa300(id)                     \
>                         || __cpu_is_pxa310(id)          \
>                         || __cpu_is_pxa320(id)          \
> -                       || __cpu_is_pxa93x(id);         \
>          })
>  #else
>  #define __cpu_is_pxa3xx(id)    (0)
>  #endif
>
> -#if defined(CONFIG_CPU_PXA930) || defined(CONFIG_CPU_PXA935)
> -#define __cpu_is_pxa93x(id)                            \
> -       ({                                              \
> -               __cpu_is_pxa930(id)                     \
> -                       || __cpu_is_pxa935(id);         \
> -        })
> -#else
> -#define __cpu_is_pxa93x(id)    (0)
> -#endif
> -
>  #define cpu_is_pxa2xx()                                        \
>         ({                                              \
>                 __cpu_is_pxa2xx(read_cpuid_id());       \
> @@ -244,9 +193,4 @@
>                 __cpu_is_pxa3xx(read_cpuid_id());       \
>          })
>
> -#define cpu_is_pxa93x()                                        \
> -       ({                                              \
> -               __cpu_is_pxa93x(read_cpuid_id());       \
> -        })
> -
>  #endif
> --
> 2.43.0
>
