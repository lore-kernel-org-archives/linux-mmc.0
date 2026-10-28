Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207779;
	b=iqjZkxtITf765c7x8BUQ3/UVDnJEeiGbrERP36aMsK0u70P79KtEBT8Z8LlVleLXMdwa
	 +nZ/tMS6XDJbl2FYdTn1DFKKq5vfutieFC2PofLWT7qQIyq7qKsJ475Ngvog0FB53j72t
	 0FTUXZpzoHYiZZfWgpfgAJq10YH2PgXbXCVQxiegZJ1ZAcrNQiOs5NsINp+Af7amwIZm8
	 sUFCZu/tXoyJzdNNLbVScy4Xknjlsuwh5uPxFxKNaMuSWYr9Vl168xfYMvuGuYPhEo4nT
	 3HfLOdS/LwfraEYHDSEMilYwPoCZu3SZrP1lBIlN5OSx0AHU+mtGPvxxE4IbifA3inA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207779;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=D7GG4SgIjIgyPXJ6NmPfb47FfoLIQACfPP84KnXPQTk=;
	b=p6qb3jjfLYFRW+7ID0fMxBjTuXWrDy3svUVy1hX5uQPDvgrITxBovE6UAMrf/WvkiQtw
	 4krHozlwMO6/TK9N4gSo+qxTsJpt+tK0euHjH8bKdBSHKVaeOdbXgAt73VINU3WTZnmFY
	 5j4LHhBgruABNi5EmUIu/Ti2fClcGK2tb4RtsszLlfDL9Uvgqr/J8emLodKvF2PEJP2K4
	 1qufRA3FvcdzlOvmzcnLqvdEpR5xOBQghJpwOInhRGxHXYyI2S9kSbf3IKmraljYpeyRT
	 CuBXNnHT4FSpI9GgrumkmuJoF5eV+zO5PegM9zuaBuwj9jrdsRGPqfiAJEdMs5sdA5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V390VyH0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OdKGMSTj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C511606A31C
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C511606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V390VyH0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OdKGMSTj
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFAlKn1517242
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D7GG4SgIjIgyPXJ6NmPfb47FfoLIQACfPP84KnXPQTk=; b=V390VyH0LdF8a2Lv
	+sXglJb5Aa3ivHajkH+ONtNVtwo0SGCJ6Z+Oz0FWmxCNoR7M8GljvWCb1rZPgpBM
	jN+2KTBnxFtVX5+JpXSzJY/zzVkW2LwnhbFfH38HTRUwGcE0uBXBBNa0gf0POVcy
	OZJqBEdWNCTcPzpSepfmg+1s4HGnrRDdDEJIZ7wamjttuOZyr+/8uLVsl8ykqUN3
	tV5UNzmiuxej77Ml3CIQByR0buz/zpLH6IwUDOL6m4Iff4KxrjrzUmAJQ33DEYL4
	jhrpRlz6itEhcgimMXhtw1CFhA/TAWQ/CqXiukqqqs5Z+JqX2btt3P1F5kcuayXy
	h0rM+Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkbhwamch-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:16:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab926c236aso1097503a91.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207777; cv=none;
        d=google.com; s=arc-20260327;
        b=Pvu5R6MucnOfL3+dgSTN6JnaWVITCDaB3lOph/yXOMUXupg0KPIYqc+Obv2h0/OsCk
         04mnQHVZstNcXbqOeIhgayN0NDDJRfHMic8I1bKmRz2Dg53eq3m/96ZpQSXUaiRx45XO
         +0sYQu+k+RosF0hrV/3g6Qhyj8HzpjIs6SSJ8DRGzJMUC8vE0Z9G0IzhQmPwcyP+qlco
         MrDQDWzGaGbfUSB0nO/Xz/19eKMn2qN2FrXglutcj4414xy0ZaKpogTeDnYdGr2XJwkd
         TDymhHxEG6N/uTQeOhg6HzCFCNoSU5xDa8K/91FzhpgZu59xPqz/IdwszpThrjkan6vu
         84qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D7GG4SgIjIgyPXJ6NmPfb47FfoLIQACfPP84KnXPQTk=;
        fh=Iq+VDB9XqvvVdFkkdW9Cxni6Ku/I6WRQM+Kp7pxVpSM=;
        b=FBStY6K4gEk91BHln2pKyDgTWOeFpS6+S4CFq6PTdTNbRyUThC8/a/nDryZZ3quDDJ
         nenR1iPM56Gaoa+S+J8rsdNHFTmQR9JEm2Kl1xzlDhHp72bLG8AjT0XfA1xzIZfiPd4y
         lThRw6NoWrG1hB4AIZ/MTB4oAWTFZrWtNJdbripgaUhypfahph0pQQChhrhV5wtAPmWH
         UlzYj1OjDhhXDPhZCqjaC9xlcEnhroFLs4nYRZQtLDefBzb4pKuPkCDAeJUyltKZWfd2
         kfspxL1X28r5LF8YFBw/JSJnaRKQ0u3sF7MyYd2iTdzCvRd+nXlKfF8Lz0aOLCmXDV7D
         G9rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793207777; x=1793812577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D7GG4SgIjIgyPXJ6NmPfb47FfoLIQACfPP84KnXPQTk=;
        b=OdKGMSTjWmTqKnSCB/1NCwBdlg1psqK4h/ADk2h4E88WIDUAo/6SJOdatUxitwhFYG
         SBFR5LnuEVzLmtrHmppdDV6/GL/B387G0lbT1Yud3Rt/ZUcKjxWSx98Rtc0iQvdc431g
         EShigpmHBTzpqZwkzNeJev7BSUIRFE48s1KUkaS64vLvgp57r2E725kgl0SxcyWmXkOO
         +ldVgPg5JnPlUj7evyxKspER3yFVt6Bu1NHaoHLAE98T1MmEAN4m4n676wkI9zp2FICZ
         gYNTINcFyU05Pg3Z8dSkui8Ujm0H8AYbGryko34knto5vPMGUQHnAxXwl+cuxWpryojd
         lYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207777; x=1793812577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D7GG4SgIjIgyPXJ6NmPfb47FfoLIQACfPP84KnXPQTk=;
        b=UMlN3ZzA/sFAJ5Y+NkHAZr0dL5AiYBMwXhL5aA0yrj1yhgb70T+VFhj6uI1aQjl8lh
         TOJoSQFPhM40NpcCGK/z2/JAriwWMILL7R89HI6BvwkEk8t1WfbXmjL3nAGsahYzegx5
         W+5/zZWL+h83hG68ePcw64UXsylaawcw+CXIUJQ/C0ofyeHytlx2yTuc1PA7bviz/4UM
         JHsjPcJUyuQvKOG0lN+5yNVlOrRWhM+QWddxDHB8AgNYLFL7sYUznyXV99vzUE+FQEtd
         u1IoEQIolBJzMiNc2FsPYZ0EW9GXztRUbEUHuWQCxSTDXGCkkJ43JaNaAIWa4zU330Au
         WBmg==
X-Forwarded-Encrypted: i=1; AKwUvBxNkYwPl09rKCzPaGSlbq2w0t2oYDB539CBfFJSZSvOIcCckdoyQyw2DQJz57+DlimYA/PMd8EmBoA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqR+46VPtTf/XCYnrSeV1rmmwhs/yEEnDBmBqQQF8lEIDX1nI+
	DsA2/x2nQQamGGx15MyryipgCnAYCaIMsCcVrzZLJQiF8QJOucbAlrUfnp8hOrd7ZCg76iouWoD
	s5/gYJ3GwRBMYDEaAax8x53fYfpeO89B6/xE5EKEWpKDcw58/I9d0Yx8ElqfLwlFf2GD6W7q5wS
	eMxafGfvzYcD0MUCTIejRdWwI4wpwtrT2xafUw4Q==
X-Gm-Gg: AYBFou2P6THNKGE5REOsor7ss7jNV+Cii8Jo8ylJJqGp+tWMKl0QosXNT5+wL3RHYHg
	4de5+vvN2UztkhTCiXioqnBbPgPTNd/MraPkLlhwgBwJiUP0W3pp2UrTMPPcAIzqnfZm+QBlDqk
	/l/h0STidikpSZ7atHRo0U5E+4R/gzJBZXRtsnbZIkJVLPLIANh7Cc+JWnrQ==
X-Received: by 2002:a17:90b:280b:b0:3ac:8af9:4a6a with SMTP id 98e67ed59e1d1-3ae580df8d5mr2117277a91.42.1793207776901;
        Wed, 28 Oct 2026 10:16:16 -0700 (PDT)
X-Received: by 2002:a17:90b:280b:b0:3ac:8af9:4a6a with SMTP id
 98e67ed59e1d1-3ae580df8d5mr2117255a91.42.1793207776430; Wed, 28 Oct 2026
 10:16:16 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1791876245-190981-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1791876245-190981-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 18:16:03 +0100
X-Gm-Features: AclHuK9Kxlm5C3IgAhirnZvTK6BIFy9iuNX1tDcinEVTipCMGdkXQyIMtujIolE
Message-ID: <CAPx+jO_Oo_Uv4vagaBzyss6EuAm8g3eYRJ8v2V-e5k4k10R-SA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: enable MMC_CAP_DONE_COMPLETE
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 91ypAKJ8Pa8drKnsv0y_I4Q907MTvKF4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfXymc6UfkBQR+Q
 3fCjYlNMiQ7Dtwl14kTf37kpwx3qgERszMquHy4BVvcsNT8w26FPvPPjyDvsdA7xWL3ot6ttBgs
 9Mu6G7joVreNNBsqKrnCUvz6U+6m0WQ=
X-Authority-Analysis: v=2.4 cv=V+joQuni c=1 sm=1 tr=0 ts=6ae22de1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=s8YR1HE3AAAA:8 a=fHPB9ihC9Gx1bL0rJyQA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: 91ypAKJ8Pa8drKnsv0y_I4Q907MTvKF4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfXw7cMwX1RXf3h
 eze+4ADWOaMW2/ACiejxsx1aStZItSccdKst5vs23M3KirJklnTfFBlbPxNn0YkU3TczOwB/ME9
 tHZxSRlma+hb8kN+cRzUiz4jP8EV05xQB8lhLoOGRmoV7mbup2jEl7Izk4yIKyDnjFSe6TDdxOq
 FJmrnBnDf7r4iqzOoKqXz/FuZY+NvpMQZfXN52jaCwmisDMYejDSnkaK84pJ9p2ZoUbyYRPGx6M
 +C6zt6NwK4Sx9vTeq7wx9Bc62KAp3kLZhTZugHx8ASarF8MyZsXGmZxj25ciStvvnzW4XOfkbVY
 WojUb2tQRr/dZvxXsDTvtPu77pbw74pMZXRXwvr+WFWTW1jvvat22/YwJSyKt/9oLJnACZhk2yH
 t4DUvRhZAvddvMjHPYCLf7ARYNjocdB8fdkL9CHu60ddjaqxVWKV+fwjdvnDgXOdEOxFmhjIqIn
 18OLwXFj8vakeEPk+lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280068

On Tue, Oct 13, 2026 at 9:24=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
> All requests issued by dw_mmc are completed from dw_mci_work_func(),
> which runs from the system_bh_wq workqueue. It is therefore preemptible
> context and host->lock is dropped before the completion, see
> mmc_request_done() in dw_mci_request_end().
>
> The dw_mci_interrupt and the dw_mci_watchdog_fn never call mmc_request_do=
ne()
> directly. So every request is completed from a sleepable context with no
> spinlock held.
>
> This is exactly the contract required by MMC_CAP_DONE_COMPLETE, which was
> introduced for hosts that can complete requests within mmc_request_done()
> without deferring to the core's complete_work.
>
> Without the flag, the core records the finished request in
> mq->complete_req and queues mq->complete_work, i.e. a second workqueue
> dispatch plus an extra context switch per request. With the flag,
> mmc_blk_mq_req_done() completes the request directly via
> mmc_blk_mq_post_req() -> blk_mq_complete_request(), and a following
> request completes the previous one inline from mmc_blk_rw_wait().
>
> Measured on an RK3576 SD card (dw_mmc) with:
>
>   perf record -a -g -F 999 -- sleep 30
>   perf report --stdio -g graph,0.5,caller
>
> fio: 4k randread, ioengine=3Dlibaio
>
> Without the flag, the completion hot path is:
>
>   mmc_request_done -> mmc_blk_mq_req_done -> queue_work_on      (~4.3%)
>   ... -> mmc_blk_mq_complete_work            (kworker/5:1H-mm, ~18.4%)
>        -> mmc_blk_mq_complete_prev_req -> mmc_blk_mq_post_req
>
> with the flag the workqueue round trip disappears completely: there is no
> queue_work_on and no mmc_blk_mq_complete_work in the profile anymore, and
> the previous request is completed inline:
>
>   mmc_blk_mq_issue_rq -> mmc_blk_mq_post_req -> mmc_blk_mq_complete_rq
>                                                   -> __blk_mq_end_request
>
> This can remove a redundant workqueue dispatch and context switch per com=
pleted
> request.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/dw_mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ff0b25d..bec777b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2945,6 +2945,8 @@ static int dw_mci_init_host_caps(struct dw_mci *hos=
t)
>         if (mmc->caps & MMC_CAP_SDIO_IRQ)
>                 mmc->caps2 |=3D MMC_CAP2_SDIO_IRQ_NOTHREAD;
>
> +       mmc->caps |=3D MMC_CAP_DONE_COMPLETE;
> +
>         return 0;
>  }
>
> --
> 2.7.4
>
