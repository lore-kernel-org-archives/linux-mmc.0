Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C133B27DA
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352797; cv=pass; b=iJ4xdCnri/tfxe6OwQZlk5o2URHxfCDTjjsLsSMWxxKPndLZJRAT+QDD+6Xcd1Wl6/MvrsnZ+GJp0vypoJkMxoCRVKabDdlW92vFuEpoFQ0kNOvVJ+QEsDWjFB85zlavhYA1Be7LiNfSg4pNAugoNJV4tj1++r0PFEtlaZOZJKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352797; c=relaxed/simple;
	bh=Yl9YF4C0szpgxpM6nmjLhKwOILm5ugHAFGk2LDG/naI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrRS0vXDGejY1iwC7nU5do8hVka+dIg9m6btAcoejKhmq6VCnwq4Tg7/p5JKN5eSkHXmVmFPyDEilgZfZUdX0sjKFUzCnH/EFBtp8CKCmXIQDPAMR5zBg7YSqjowWB5K8qMkZggFUVHWl4rQKPFX+XA+sWyxUiEpFQHEwNPj0Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TvsCTFP7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UuikW8Ko; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TvsCTFP7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UuikW8Ko"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF43q825884
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y5lQxlfMYGfx6hjmWG2TXwuI1j5WcvzVDOnU0deR3wI=; b=TvsCTFP7y1naEBYV
	urhWRcaSe+2zOFRHcUEW+RsLUJ8JHsvGffoPjgKHzAD2OX3biG29mbGbyC/5zdtJ
	3dQw49Ep/rWUuHgwGjKdbe1xITYkOnlIsRCsw8e9xHuIaltBj/+8is/k4jFdHsNH
	NMXfGKv6og5dY/XcyIdjniJYj9nmJBnhtN+HZ7uxKypQwRsa61UlnAuiu1C8NxDc
	Ff6c0XBGfJ9RDBvjJZlRz/lPMBO4TdN/lx/bE0Nno6TuLplmm4kyDVYOw4rTE64d
	netYvYIiWzJKq2lENJYVGAkE3eVd74vt2DNce12Z+yeStnjER4fOnvEj4Iprq/rd
	zHXqYQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t89xy8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:46:35 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9693cc255cfso3160027241.3
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352794; cv=none;
        d=google.com; s=arc-20260327;
        b=c8yMZzxzU5exs+HXwAo2FsQ4piG3TI8JsnogjqYhHsFbZDoMQNxJvS5AsIHiDNqUOJ
         JNqtQusSNf6Za6GA+MmJnd7p7Os3SnnbOAQcPHIljJilTgG741ICxcoLOePSfxxaCRGu
         hSAK+F47Or563B53Ju+5wb/o6X3mdb0EcRndZfqORmZecu7I8+Duap8Lmh2YTwTY4c6d
         B99PJFGII/TfpER8HnC6GQyozqq0F85yGFun+kAc2tuYQ0bZmxtI8W3T0mPeX1Wq5yla
         2UGR00aNtW+vE8mI5lg4WrAOUY6P6leptjuYzoHjQoVvglKIw1l5xs83btEl+1dGPA5H
         0Uiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y5lQxlfMYGfx6hjmWG2TXwuI1j5WcvzVDOnU0deR3wI=;
        fh=iKVAY2RC0+slWelnwFO4PKcknUqfX+eEdssnl8YFyAw=;
        b=bAn8TTcgugNPXsnVwzjWnhLPnE7A82TUm1EScfm71Quoh236HI3oc6kcXynJnVip6J
         9gb+jH67ghd4dU1UM2LpZ7r9cW045Ojgjo8XzbTlcxde4RnhvZrza0OFWTCqCpJPNobd
         GGKVZhNRA1VYSCpe/q2C8Rb8kZWpwgk4pJd1AAozAP19HevyD/KvRegpOBTHfO2bKmaO
         wm/KBx7+xFR2MQUdeAeV37YaSOJAPDhCx82QbyJHw+5u3nR/xuzfl2bRKsX2ZJjiaEoN
         gIYghoIpXynsyRYYi43M1SKGonTgw3Mty0T2HTUDq0eChyBqPpOlvH7XNsPlvQky8lfL
         EzuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352794; x=1783957594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5lQxlfMYGfx6hjmWG2TXwuI1j5WcvzVDOnU0deR3wI=;
        b=UuikW8KojgpgHcwwh1W3psu2xKiRNWotRgY7gh4Qi40P7JEmARNziAzHex6u21K5ys
         eQUEa46YJ4NIll8jNY5YxOhX+MU/2E+2hnQb8pN1Pvt5LHallFhbZkJ26G9b8J0pZD1k
         7SvtLxrXqLGdTbngsShZI/Z0PSxB84Kg4c0+x9VhNscG5UabOI1CzhGl4KEWWAZec/zg
         ugp6kESFU7s0OB3qp14mqOfByQDxopXlXiN8zZ07OZon2qbt7wRjVuio1/k5GztoymU2
         0GAxQ0s5UrZONSRI8Xw26y1kemjiPBFwteeHrgYf9DK1zGEdTDepnfJqeIaWDsrsb7PE
         Ympw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352794; x=1783957594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y5lQxlfMYGfx6hjmWG2TXwuI1j5WcvzVDOnU0deR3wI=;
        b=dgBqUYBe65CX8C1f6oXLMpr3+98RTPu8esNcFVt5wN16j0RKqATucne1M6KiEREiqb
         ErJFRkRUn2+E8WHWia5XnlZG9SFw+V0norrhe8vdp3yFzmia0ZfwMRRaYnRDVDgSy3mP
         DHJzMhQNTtmnN3Vqq6zanXP2gnoyAc5YwHjMYF4IMjknYmCy5KtJG6xpH+SyKghIbGZZ
         DBPJpNDaNu03TRDfpbQHaZfTuxpHzcAF251AY8SWerl7+emHnygUAghQBAQGVMN58031
         3aQpaqEFwv9NHZB8mwljz90QaQgb4t1e3TNsGCKqzX5Jvu933/XfPYXAPiNGlPaRonrw
         4/8A==
X-Forwarded-Encrypted: i=1; AHgh+RoigLM2Hv6ebJ5+nFEAnbPGC5gvGfJJ+nPr1S0rxfe4ijm8n7AvfU56QshPEdwj89sNRYmof74Rtug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwymTaPen8vjRdRUbGdZrWFm3lx7EUI9TixfE3MbXiLh7/Uyso6
	ujoYFWZZ7SZoqVtZOPlUXDJOD7bNh8SwmGnDpl5+co3IF2MAAh6QYMeRoQmernoTTyrFUThwE+f
	cacUnnFnbe5EfigBjkG+WQpSoDkgBbJsgyYzfhKW7f3tPiyFyW9rKMDURtJY7DlzyCQiSaYexQi
	E3RcKFc/tX36KeeFAtlrzXZWXTeLl0f+IidS/HWA==
X-Gm-Gg: AfdE7cnLyglJOzZCv5Ef+8Lr0JvBcWZO0eNvi5zJrn8Xj+ld3ZLcbDRCZFoUKqgxF5A
	JOC3JKkl4MFSIVC9XhVazFdX13uNlhHZGTQgA8F919UORD4jOfzVvWqF3noxdH/fn/4xXBUIYWe
	4tmWsC0WsjVnRtyQancBoJrPq2Owj+lSWUf3ZVzY/ADPwPZGwxTPELvtwX9NzUibEafv9Z
X-Received: by 2002:a05:6102:8011:b0:737:b586:6388 with SMTP id ada2fe7eead31-744b7d6e6d4mr649114137.13.1783352794198;
        Mon, 06 Jul 2026 08:46:34 -0700 (PDT)
X-Received: by 2002:a05:6102:8011:b0:737:b586:6388 with SMTP id
 ada2fe7eead31-744b7d6e6d4mr649066137.13.1783352793781; Mon, 06 Jul 2026
 08:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602201344.1809801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260602201344.1809801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:46:21 +0200
X-Gm-Features: AVVi8CcZLsh5xTCrQHeiyj9VO502FopUmqKqBqBBuThiWnFty4WMAnpf1TVTeto
Message-ID: <CAPx+jO-fhBf+8T9oc6CvsAfJu1Jxp0iE=rregHJ=HmLRCvTFzg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: mmc_test: Fix __counted_by handling after
 kzalloc_flex() conversion
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX1KmhVIVBNnlK
 YPlWH7kcCG8DXoE4mpjoNbnUZ5YVlJiQnkkqZ8O1n77RWmoQMqynacf6Uh7YLuhk8/WdH4fiNGW
 AwhGhjVlBOpEy914LK4/698w82iVWuo=
X-Proofpoint-GUID: bz78Z-y0ebrRCx9Qo8aKTsFyO7HHhLdW
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4bcddb cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=yC-0_ovQAAAA:8 a=pGLkceISAAAA:8
 a=uXk8S0VtEpXI5GqmZSYA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: bz78Z-y0ebrRCx9Qo8aKTsFyO7HHhLdW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfXytH35htAl3H+
 QH9uxc4rgIJyxHEY7ikKv+hN3xNHTdEDkA3BIsJ2VQCajAHU9lD0aU4+834ijLEL8RsnQ40N4kS
 oNm5wySAiwYhbbTclEtl84nucCXl8jJ4bt+JGlvY6KhmiR0mRb8tYpahgTtTAqxSsFEo5EuGTqb
 /GlpUSgQ4PbHOI00MP2EswHj77/qxicitqNv2RyjwN20wfyRo8plI5gEyCKbSB8ui9Ldn/dVhk4
 eFm2ZsRYMw2yeuEbnGG2slZ64tYCMsJzGO3eZ6mg/Yf4Mn/+1ooYjJYI1t1HxLHbHCRT7IyB2zi
 iErGhY5lEZUjPC5GlNtKIpsn/G6odYltlY+GqJMLaSBjA4VDiTpnKITrU3kc/qdhz/4LISLN5hd
 W1ul+077zzpDcJk5BSrrhTVxZeazQm2gcIrkJgT+zCPbfCvtyFdb0jAd6VkkB48QqzyuylNELIE
 Et6F3RqPAtG/zC8nY9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060160

On Tue, Jun 2, 2026 at 10:13=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Fix logic issues introduced by the kzalloc_flex() conversion in
> mmc_test_alloc_mem() due to interaction with the __counted_by
> annotation on the flexible array.
>
> Bounds-checking sanitizers rely on the counter field reflecting the
> allocated array size before any array access occurs. However, use
> mem->cnt both as the allocation size and as the runtime insertion
> index, causing incorrect indexing and potentially invalid bounds
> tracking.
>
> Initialize mem->cnt to the maximum allocated number of segments
> immediately after kzalloc_flex(), then use a separate local index
> variable to track successfully allocated entries. Update mem->cnt to
> the actual number of initialized elements before returning or entering
> the cleanup path.
>
> Also rewrite mmc_test_free_mem() to use a forward for-loop, improving
> readability and ensuring only initialized entries are freed.
>
> Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> v2->v3:
> - Switched back to v1 version of the patch.
> - Addressed review comments from Geert.
> - Add RB tag from Geert which was received on v1.
>
> v1->v2:
> - Started with cnt =3D 0 and incremented before assignment to ensure
>   accurate tracking of initialized entries in mmc_test_alloc_mem().
> - In mmc_test_free_mem(), replaced the while loop with a forward for-loop=
 to
>   safely iterate over initialized entries without risking underflow.
> - Updated commit message to clarify the issue and the fix.
>
> v2: https://lore.kernel.org/all/20260519133025.618255-1-prabhakar.mahadev=
-lad.rj@bp.renesas.com/
> v1: https://lore.kernel.org/all/20260513201315.3186621-1-prabhakar.mahade=
v-lad.rj@bp.renesas.com/
> ---
>  drivers/mmc/core/mmc_test.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index ab38e4c45a8d..4dc16649e61d 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -318,9 +318,9 @@ static void mmc_test_free_mem(struct mmc_test_mem *me=
m)
>  {
>         if (!mem)
>                 return;
> -       while (mem->cnt--)
> -               __free_pages(mem->arr[mem->cnt].page,
> -                            mem->arr[mem->cnt].order);
> +       for (unsigned int i =3D 0; i < mem->cnt; i++)
> +               __free_pages(mem->arr[i].page,
> +                            mem->arr[i].order);
>         kfree(mem);
>  }
>
> @@ -341,6 +341,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsign=
ed long min_sz,
>         unsigned long page_cnt =3D 0;
>         unsigned long limit =3D nr_free_buffer_pages() >> 4;
>         struct mmc_test_mem *mem;
> +       unsigned int idx =3D 0;
>
>         if (max_page_cnt > limit)
>                 max_page_cnt =3D limit;
> @@ -375,23 +376,26 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsi=
gned long min_sz,
>                                 goto out_free;
>                         break;
>                 }
> -               mem->arr[mem->cnt].page =3D page;
> -               mem->arr[mem->cnt].order =3D order;
> -               mem->cnt +=3D 1;
> +               mem->arr[idx].page =3D page;
> +               mem->arr[idx].order =3D order;
> +               idx +=3D 1;
>                 if (max_page_cnt <=3D (1UL << order))
>                         break;
>                 max_page_cnt -=3D 1UL << order;
>                 page_cnt +=3D 1UL << order;
> -               if (mem->cnt >=3D max_segs) {
> +               if (idx >=3D mem->cnt) {
>                         if (page_cnt < min_page_cnt)
>                                 goto out_free;
>                         break;
>                 }
>         }
>
> +       mem->cnt =3D idx;
> +
>         return mem;
>
>  out_free:
> +       mem->cnt =3D idx;
>         mmc_test_free_mem(mem);
>         return NULL;
>  }
> --
> 2.54.0
>
