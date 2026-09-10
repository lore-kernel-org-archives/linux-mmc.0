Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625DE4A99C2
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056359; cv=pass; b=CMZypFXzUKHAtv92tGVuEWRnbqq4JEjTkpu3Y1S02Lu6wcKmNdeFHw+3xS94PXSI51uIYEowCdWvY7kV569Gi9NIJbOEdsaHB4lqoucUJ09T0E328CmjeCGMSyLL3yLq8B4zPc3MVWpx4iYt+8QGfC6m43lvVm27itpWaxzazW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056359; c=relaxed/simple;
	bh=4kcA1rVWhFCb6bHJIR5W/uz5wDQtM1654lmOyYLDrm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnnmZdMIOl8g9b2KLQYSJTwW7Va+ofESpXz1dFe0Trj1xNaR0bTWYMDGUrmwKnewgMriO9STcSyX9/S6M0/EJ5xEL7V3kebGzpP2fAxoh32FlvwQspFF6KbP1N1aCWoR+VVUXqjg6UWzfJURCz4nq5inxzij2IPnHf9ovk9y5r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eW0DNZd9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Schgsf1/; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eW0DNZd9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Schgsf1/"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF4ZS11186654
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1sUllQwZR0DIHyG2YQmMoUKs4IfVi2xBX8/Va7BBPQ8=; b=eW0DNZd9KQZ1yCXa
	k8E/g1mNM3X1wOnFx8ZQaqWVnxpNSJfTjvfHYv00DujR90MCLe4TtKq1jGV79sUN
	8FjEtbBW/8R9F0c/t4yjdynh1ClQ/3NEAtzQ9aFuVwDdgFv8Y8JlhUs/6MWveJfj
	V6nY/9RHNq0KrwbPSs0NYgn4wI+cg9vPgXZJVfKFHFYoowT9RLSSNbAlhbdVi4qu
	vsLnzLtoRHKKIs0yNO/oiorLbu1WxYX056NTIqzvsWa7rmXdqT6jFEPHzW5YdREx
	pQ8fgQl6tOGzap65S9UutOU56xDYQ3TSldvn12dIwzIePH+hEdeXMbR+di2zM7vX
	+r3BCA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkraka9fd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d932ef41c4so22978865ad.0
        for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 09:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789056349; cv=none;
        d=google.com; s=arc-20260327;
        b=TAfssnkHaAJT+oaAdYetJ3zOR+o201pM3SXMu41yETl31uQCcZy0g+lHeQKgCQ9mIE
         julRw3cDwzfU5nXbIZO+U/ikynaXo5n3sZ7hisuE+cu49PsQxOiV8GOtPXxdXkmmGdgK
         WP7r2qup3LnqU2xMCGM6z2NF7G1qv1cT3HEoOfwegovYsMwuAbUNIvagmbIgXSTUdDoS
         iIgHxXu0x4+79DLli0faicbsSEKRX3/QVIEDus5FSntv2dy4kufsfMb8h3bvFje0ySVx
         vRdoGaImz4DvGoqfmu9tcyVKZqYNzCWOeQTxZW/nc5piqia6qgu9F38uaHpIjnCZJbzy
         ExfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1sUllQwZR0DIHyG2YQmMoUKs4IfVi2xBX8/Va7BBPQ8=;
        fh=WmhE19bFM2jzNlo5qbQvZpbqB559TRRpn5fa3b8yjg0=;
        b=BzIgd/644MQnSH0b7Mam8UdVJh0q+XWZpQ7sOhSvreo1srM8OAZhSIcvpvfXhPFjFw
         +ZyKHaIu6Ig0KlFMHIq3/yDisGd/ReGbbTtC+tLveuG4G1sldXkwvkl3AynM2DEwyS+V
         AnH48U2sIj2QrQzUn7qV1ter4urPTbwOQ2G6Iln1wGvT5qjUJF+Ze/uCrFhCI8mO/7Eh
         0+JQEqBEFpycIs99lzh31GZnDcEKHyPXUqOM+d7fWOqX4ow2/u3Fh7zSSbhIK6Dq2yNm
         uTxmX5RFDfcgb4nWFdWDSklu8rCtSkR4A+DZ/hLHjVQW+rfVjmHnUQKN9Sz3kGivRuHK
         rmtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789056349; x=1789661149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1sUllQwZR0DIHyG2YQmMoUKs4IfVi2xBX8/Va7BBPQ8=;
        b=Schgsf1/tXo70gOSSkGkjGbbsrocne0H3Cw4EQ0lqXa0snpJrOCQGdQkeanvmRgRz9
         pvjDT29qWqsT3pz3f8Q/O4a9U11a/53bmNp6c7L/qJUXgsiN5/R/iFTVsgWlNEd33Gqu
         FM6yTth84dxE6ku8DOONRNBEUjomaBNI2/80vH/FQA8qWEZbeMs4BEcHwU1xnstBt/7i
         8FJc3UkxX9uEhUwZFzxC4uU4C4ba4FMbhOuh5opbpDzRmig24DPUwfkvt/wLHRxVkTH1
         hThOMdZa5iVdu8LQPek5cTodPnC/WOkKHVDm9el3E76kC5CM60hhQrmYb2VKkJ0RVHML
         7LRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056349; x=1789661149;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1sUllQwZR0DIHyG2YQmMoUKs4IfVi2xBX8/Va7BBPQ8=;
        b=UCnrJXY4LpMXL+qkJgKGEUBblo6Az3CxPqOAufhZKGZlg6XbJgAYRtP9zcLhbMS7Wu
         hF2gXv7KyYbNgOY/E/4r9S7j2WnWNxAxEyrDDKnDSXcKlgPhSMnhG8g6QMuTWq7wqP9G
         C18grVt1/SrLSSsPYvh6rkNJ7Wj3A8Ns+ROMO2dkD3mAiJ7uaGTuifhLrg334fBPKmel
         nNR0PrEaaFpEmKigboRZGPj3Akdq+aSiETp2pKJ53eVLhc8loIkJW9GNZp4vAfB7aMCI
         3tDZ/J0ughmF2f82wclAe7U8VeJ3zWjXW+rvCWBJJLVmRVl2THcqLcfFDmAVQ5lCjGws
         Ni0w==
X-Forwarded-Encrypted: i=1; AKwUvBxhwwgwowoBVO5027DtPkbad0DPzzfMs0i+oYKxjbaKWkhxrHTNOg1xlxLx6QKAgW6HbJlPiCugsmk=@vger.kernel.org
X-Gm-Message-State: AFuF++mNbGwxzjAGM+HZCXnlB0IM6tcQZ2FHwriuhi6vPj0FseRAoCDd
	hmPBodl04mR2g6b3RjjxIUCgbD6BzrfVOwx51OSSC9JNAHAP8Lhhg8xadOJtfc4VYTRCWOuCwsh
	U5EOSMk3+oCiWwbMa2N5JNOICM+hjP+6kYZQGpdC8zNbs4/2msOtGqYY5rjyQdj0J67FHfyw21V
	TROON+Xs5A8KIjjUuJ5EMKZ1f/81LMym++uF4LWQ==
X-Gm-Gg: AYBFou1sOAtNoRWCm0NxIuvrH7q4CS3990z6jvQXr0h5zBZw6SqyuUiHOskY9UXYhLn
	XW/NF7/Y58Z7/uRzDZuEFeWVW9gst9LxrPISXeGfDNvHqqeuiH4p9gSiDbUJA1YTKs23f3N5WWp
	Cl+uRY9jFjmXhrUUI8BPFGrnF3Wd0EB7A94CnKeIY3TOjIy9FBf/qdmkXU7Q==
X-Received: by 2002:a17:903:388c:b0:2d9:14e8:bcb7 with SMTP id d9443c01a7336-2dd0e8a213dmr60112265ad.3.1789056349463;
        Thu, 10 Sep 2026 09:05:49 -0700 (PDT)
X-Received: by 2002:a17:903:388c:b0:2d9:14e8:bcb7 with SMTP id
 d9443c01a7336-2dd0e8a213dmr60111795ad.3.1789056348932; Thu, 10 Sep 2026
 09:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1787817486-137277-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1787817486-137277-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 18:05:34 +0200
X-Gm-Features: AcwNN1Xzb-LRWPnhBSD2IGRooGlTH9_SP_t3vhw96kEFsd6BKI0KRfWnh7VQ644
Message-ID: <CAPx+jO-J2BxoPbDGoJnuPKe-R7GRzc78fJwvDowhTDgQz5g8ww@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: dw_mmc: replace three fallback timers with a
 single watchdog
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX4rZKLvsEudc3
 U6gwN2t6yWWdoCyzcWf6/e07k+6uR9s0iRA8G5Rc3juCA/+O+DqMFrAenKiiXieIm93ibQWlh17
 5wjzG4O4mOYnNPKLRZFadZgbcpmCkVU=
X-Proofpoint-GUID: RADfqHiCWQX0HQxeQVu7H9a4gZFpmbRY
X-Proofpoint-ORIG-GUID: RADfqHiCWQX0HQxeQVu7H9a4gZFpmbRY
X-Authority-Analysis: v=2.4 cv=EspHPicA c=1 sm=1 tr=0 ts=6aa2d565 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=s8YR1HE3AAAA:8 a=GDpu9P8s0nNUkheikvgA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX46kncFYlOIDt
 o3lHEjBhHW7+QoFA11/vu7GlyctVaBMNZ5raGe57iPXJaUZYoDJECmKfJJvunzgW+OWlilVczYU
 UYfCVZy/bc5DQXB5SFQ32PGFxRxI5XplHk5ZF5hxnb7E0XDPUrM1IEVgLduIy2Z3Pvhbc7B7+x3
 k/eUPlg2nipqwe7ZaZDE9ApGtP1sGmcR5ZcmrtJh1ilyFSqkzRuvEAbS0psugF2XRrehg7YjEoU
 ZeivQG+xrLFgxQi1QvGxVpGYbLiO7SAdh8SsmiNRa25NN4F/mae2G928SRoenZ/RcBmiZYpb4AX
 ut+w1LQnpBFm0EK4tqMh3xEqxiDGluxRoBP/xxxiVHgoxAriB3tYMCfXH8L9mqJKYowtqDbf0ye
 fB4MgZdi4PTklp0o0CeYR3QY9Nu4eshPeCDQIhb0DRKcfGCH47z3jG0JA+XVw1tWrywrcr6/t3x
 4yqspV+qZX6Tqdy/Suw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100195

On Thu, Aug 27, 2026 at 9:58=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
>
> The driver carries three fallback timers (cmd11_timer, cto_timer,
> dto_timer) added piecemeal after the hardware failed in the field.
> dto_timer exists because Synopsys confirmed that the DTO interrupt can
> be lost entirely, leaving no hardware fallback and blocking the request
> forever without software help (57e104864bc4); cto_timer came later,
> when Rockchip's reworked sample circuit was root-caused to swallow both
> CMD_DONE and response-timeout interrupts across their whole dwmmc
> family (03de19212ea3); cmd11_timer papered over voltage-switch hangs
> that reproduced reliably when ejecting/inserting UHS cards on rk3288
> (5c935165da79).
>
> Because each callback races against the very interrupt it supplements,
> all three grew the same copy-pasted defenses: re-read MINTSTS in case
> the interrupt is merely late, check whether pending_events has been set
> meanwhile, validate host->state against the leg being guarded, and only
> then synthesize the missed event -- with timer_delete_sync() calls from
> softirq context eventually needed just to contain them.  Meanwhile the
> special cases keep piling up: the EXTENDED_TMOUT quirk makes the DTO
> story differ per platform, fault injection can post DATA_ERROR ahead of
> any real completion, and every future change has to reason about up to
> three timers at once.
>
> The observation enabling the cleanup is that command, data and
> voltage-switch legs run strictly serially within a request, so a single
> hrtimer suffices.  Under irq_lock it records which pending_events bits
> are awaited along with a snapshot of host->state (dw_mci_wd_arm()),
> and producers clear that awaited mask instead of deleting any timer
> (dw_mci_wd_deliver()).  On expiry the one callback classifies what
> expired by comparing the awaited set against the named
> DW_MCI_WD_{CMD,DATA}_EVENTS masks, keeps the old MINTSTS latency check
> but re-arms instead of going passive so an interrupt lost for good
> can no longer wedge the request forever, and only then synthesizes
> exactly what its predecessor would have (RTO + command complete, or
> DRTO + data error/complete).  The per-leg deadlines -- CTO formula,
> DRTO formula, 500ms CMD11 budget -- are carried over unchanged.
>
> Apart from three behavioral deltas called out in the individual commit
> messages as well -- a single surviving watch during voltage switch
> instead of two timers racing, a stuck CMD11 aborting after exactly
> 500ms instead of racing min(cto_ms, 500ms) with -ETIMEDOUT unchanged,
> and bounded recovery from interrupt-latency peaks instead of an
> unbounded hang -- no functional change is intended.
>
> Tested on Rockchip platforms with SD card and eMMC (rv1126/rk3568/
> rk3576 boards): normal IO, suspend/resume and card removal during
> transfer.  Compile tested on every variant consuming dw_mmc.h.
>
> Next steps: first split dw_mci_work_func() into per-state handlers to
> make the transitions explicit, then go further in the sdhci direction:
> shrink the eight-state machine, drop the redundant completed_events
> bookkeeping, and end up where other host drivers already are: one state
> machine, one timer, no separate event flags.
>
>
>
> Shawn Lin (4):
>   mmc: dw_mmc: add central watchdog and convert CTO onto it
>   mmc: dw_mmc: convert DTO onto the central watchdog
>   mmc: dw_mmc: absorb CMD11 timeout into the central watchdog
>   mmc: dw_mmc: expose the watchdog state in debugfs
>
>  drivers/mmc/host/dw_mmc.c | 316 +++++++++++++++++++++++-----------------=
------
>  drivers/mmc/host/dw_mmc.h |  15 ++-
>  2 files changed, 165 insertions(+), 166 deletions(-)
>
> --
> 2.7.4
>

The series applied for next, thanks!

Kind regards
Uffe
