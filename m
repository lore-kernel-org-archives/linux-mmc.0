Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8059C43499F
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688884; cv=pass; b=O0gbGjOWAWa7fvWOOJimwwYegg3VdET4YfAk5xOzpIcJ6hPur7KW6wWP2ot/3JgSHKeSgm/L0vT0vuzitBdwh63D1Q82e+MXgn3bIZ0vayZwDHwMoRjA4O6xD+ndDOdrhnfHJETHK8CZS9ejmdCuTgpxsPbYNGQVaPf6xbLWDOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688884; c=relaxed/simple;
	bh=TqAhkiRrKND4/cRslNapHF64pDqhWGTExdZ5pdPADI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fquKyVvRIu8+ytBIha4YVJS+CGIRsMFOVk0kJTkJMsNNHA7DjY1PdcTXk21X/1Wby7jhP3B7DYnZz7QTA/0Qy5026VGnJKbRDlSwIVUt8JqfyMt+8p3IiNGZp76MIczfkw0u6zqD4nGE/oLtvyAVxG1DR5fk+9PsvkCsvGCVK1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hTyP8eSl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FGlb/88f; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hTyP8eSl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FGlb/88f"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqZ4G3936570
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h6hMFw5ia2G/hTScfLWqNqOkXEUjQE/tTxXoScUVfU4=; b=hTyP8eSlVJPd0Bsd
	qHagFRVk3X3XciZ8GdXV9RHg1RDzMOd1oUkdQ5kN3edY0zsYIcvZiZ7MkdeDzPr8
	rJP7nAL+oxA7xllDnwzpc2ziVW8Q5sDJrSHtYYRzYIN1SbrejAI7ipEBc4ZZqtmY
	QkBVT4i33C3FV3FsJ3xQxjvPjXGdNHslth6pi+PP5HFg9wyQt64tGpOasBQY5WEi
	4JVrzLcQT/YjtVtYZnZv9BlvMohYfI3o+pRqOzbaT4MQYRwXGF2Q46zFTE/kmBj4
	tXM1kIK1azb/UbRzUfyZfbyNUSMsE96RuHYzue+wr077ANurJCizXjGO1eD6cVrF
	0AhpfQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0bn1gres-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:42 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-880fc450073so4343834b3a.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 06:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688882; cv=none;
        d=google.com; s=arc-20260327;
        b=JeQgLNVj0qbk5T1iLNJftaWSAsuSBnMWcX2NVLcllhQVkMeOtVxmYUxfsIAHiSwwCw
         CrB0VCg8Yy00mKHiyO17bAW0qShBDJfeDwohDF0vLrRwkRPVQXxTC2YAmrFvUYo0PmNi
         tnVgMIFltbmqVLUmsXs7rKAx2tRL6wCuxYLqv1KeqE1p8cuNXdenZeWzzFa8iPzq2Utt
         E1n0ZCqrIKm8/lc3/oZuODg1EoesI+qN4k+71j6wmEFOrlBaD/WmFdt1G7NTWPn3y0jT
         SoiflF2wnk1bOmTx5UxnAvqciLYWVSx0mmpO7nLXxb7B6FURQTxIZ8oAWL/BCf6diusi
         lxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h6hMFw5ia2G/hTScfLWqNqOkXEUjQE/tTxXoScUVfU4=;
        fh=05E+Y1bfdngels/Zn1Y1DqcHThviDu7fnbE/NQIp0Lw=;
        b=ZQqARPGth1t3MQ4GfCd73DB8DAixv9d1gz41w8b2L2wGqCFMGntPdpQ8QCGyT/QNcz
         nEolB8ZVj7un0gEoQd+oBkL/c61Trr5f/IAWLm6DOlw2TqKcVaVXFBuW3k+MRKNjDP3u
         tGSXF4jN99LnPo/WveJo5Af5SalI5zWxUUCkAo2h82NS0lbN8QOMVNi9zLfunKJb4rKI
         J1zYZG7VfH6Nb0kLhW9eO0QKPtcqKOIqzzAIuY56aYvByIK8bEPsRjfFhVUfTVksUosc
         9zHY2GRV5qVe6OS6Y6xXmyBDMfVrMB2JXqdmScnWf8wrbAnUHtn7Bi/AVJpNIjzM3F8l
         TFIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790688882; x=1791293682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h6hMFw5ia2G/hTScfLWqNqOkXEUjQE/tTxXoScUVfU4=;
        b=FGlb/88fS/f9HtUuH1fZM33kT2wSeuwH+5chOfnQ5zP/CBVCaAWR13M5El4gdBawph
         VEGISYNo/RJ7mmxhg460c1ZZFy7fHMyTnUwVA1j8GYUbYwF9L36b9P6HZ1CcMAvYbvTS
         FCnLLfzo5GXB1dz3ARx8nLzOUUzucZR7CiwW/7acbyvAvN4QeIndy5zBENHOkrFuNS8s
         A8yOIJxn8yCMNX27ohZODPqLw7gpx5jNKUxnWC20ko06VTubfsrzFdRBZcnGxh7//GeB
         yeEHWEOVIp/7qecrhWdPOBKnXJvwhJFIIcVk6cVFqzx5kdP9vA25aH1sge1WqzcvCm7L
         TMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688882; x=1791293682;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h6hMFw5ia2G/hTScfLWqNqOkXEUjQE/tTxXoScUVfU4=;
        b=TwkDKiRc16REhwDygHW/059V/tFK4YjlkUZ846kcM6m5s7jHQJUQOY5J7BadBkq3bd
         tWuW2BapRsPZ89tcf7uIuWnNmr8sKpolSNbkYsxyzCBkMJoCo6zyflMuko8lO8IuG8MD
         PgzZUnVT/nEKYZt6i11b5VVjbMvku7t1snqe5EirAQRZhpJ5atU5PP5BUosksDN2C0Oz
         Meml1nmWzSaymSB6MbgraWY567pyMrUBtm4s9P4okKuZOv1mduMgcCItFeFm8pzxCK4Z
         wA1RxjcUwaGlA6AkfwQFWyZrfyZW8mnP7ochSwUFK9CFE/SEf/KUWxd3uZlpSF3Wa81i
         w2jQ==
X-Forwarded-Encrypted: i=1; AKwUvBxoj5aMJWGcQqfmvMlYphLGknpSmp4s2YLC2fEwmHqYoxjpsZZZDErBWI87YFIEp4QWZLv9p8JSW7E=@vger.kernel.org
X-Gm-Message-State: AFuF++nLZNXg5x62axis62z/BSl5rcjHU98fS5mwWyX7jvZdjqO4Ze0i
	zsc7ENx+H3EWZH1PTDT2SJjtRM6z+kxi3cUF9L7hIIwNvmNSe56N32SFsoYApRA06uZ7KGwQ3kl
	LGKI04w9bcKm10Tgl2fG76o277F18FW5HX8GiArFM/VN0NuQWEcUJ1NegYLmafRKq3exe09hgZU
	9f5sbybyH3JJeF6nJCurAQGgUIycAuqKQt4Ue1RA==
X-Gm-Gg: AYBFou1btfJ+16Wdi8bHn52TCqsA+63lPgVUn0FB+c3QnJ0MS5VQS/OmTn9ZoCL9n+e
	ud+2JzD57bBstzZ1FDz9BEybhsRJpG193UIWT5BE9cq3loTxAIWJqwDjYXWHXkVqnIbsHrH9OhM
	08YrPIW3B3d/8SxvDwY8ie9+ueli6yUm1k46zuCW6ZovHGT1XIh48VLH8aWg==
X-Received: by 2002:a05:6a00:997:b0:886:5b85:48a2 with SMTP id d2e1a72fcca58-8865b854accmr380483b3a.54.1790688881937;
        Tue, 29 Sep 2026 06:34:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:997:b0:886:5b85:48a2 with SMTP id
 d2e1a72fcca58-8865b854accmr380464b3a.54.1790688881445; Tue, 29 Sep 2026
 06:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924192955.1941-1-rajojha047@gmail.com>
In-Reply-To: <20260924192955.1941-1-rajojha047@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:34:29 +0200
X-Gm-Features: AclHuK-bovqRIjls7emdb02spwwhD6QCaXt-S_uCJFs3KYOu2v1SrBo8RyGp0aI
Message-ID: <CAPx+jO_6Caq9OM=AR00YR5qe=WGBoEUTiWmdmfCTNfn3tP6YSQ@mail.gmail.com>
Subject: Re: [PATCH] memstick: core: wait for request completion before
 freeing card
To: Raj Ojha <rajojha047@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot+ccffdf05833ebdaeae70@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX9ss0bfDEAW4E
 sleM3DlNZG6eSzcnVXoxSxNO9JLg4cszqCzHWUYJQ3AYEOW6GTS0/ZwqWrWOeefGenL1QxmXiWE
 Uf4eaPiCc2fqH6X5TDDCNOiojyFRves=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfXxK2GrhQt2li8
 k9zwmSsgpo2D2Z/dYhMGirImqJerMVAOSez62E4UzoK0xEc83sJqPw6nwskjaiz6KKzwIQ21+jG
 ibfCjEVhG+O3NR8Px5I2nTb7Ssyy2cjEdBl766VpgPnzYzcIIraiPCuFFBN/w392thv+9WR3YMr
 GUmqe1HjeLpVsA1pNk3sTygCUQXoHpM9P49GTf/wzToVXQfp/qMWXikU16ZfPG9cbY8ly1Zyemv
 p/maig/TFeILaRl8gnn+3BFmQVy7jR9x/lz918vZjiyvPCvUY2orrNteSDPQKYghN9ERbsSPKp0
 rCjJx74fwkfOdwojnpvuXc8c6QLKnXzv6U5tzONIbvpdbFoqtYuDZtWgVf6gyfAWaIFFBBmMgN0
 fM8bU07wLssNeGjCn+rQd8kUtl9K7IVfsf9fi+HgWsoxWfoCREeBXpfhUDxqSSCnEJHu+cEj9pM
 DbYKJ3LdVtGY3fo2CKQ==
X-Authority-Analysis: v=2.4 cv=JMiuIMKb c=1 sm=1 tr=0 ts=6abbbe72 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=edf1wS77AAAA:8 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8
 a=VwQbUJbxAAAA:8 a=OJ4-CXQFXB3o4ZXaK7MA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: kEEAHvopN0SR6S-ELygBYu9TYI2EH7cd
X-Proofpoint-GUID: kEEAHvopN0SR6S-ELygBYu9TYI2EH7cd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290054

On Thu, Sep 24, 2026 at 9:29=E2=80=AFPM Raj Ojha <rajojha047@gmail.com> wro=
te:
>
> In memstick_alloc_card() and memstick_set_rw_addr(),
> wait_for_completion_timeout() is used to wait for device identification
> and address configuration requests to complete.
>
> The memstick subsystem does not provide an abort or cancellation
> callback in struct memstick_host for in-flight requests. If
> wait_for_completion_timeout() expires (for instance, when a USB transfer
> or command retry is delayed), memstick_alloc_card() returns an error and
> frees the memstick_dev structure via kfree(card).
>
> However, the host controller driver (such as rtsx_usb_ms) is still
> running the request asynchronously in worker context. When the transfer
> eventually finishes, the driver writes into host->req->data, which
> points to memory inside the already freed card structure. This leads to
> a KASAN slab-use-after-free write:
>
>   BUG: KASAN: slab-use-after-free in ms_read_bytes+0x8fe/0x990
>   Write of size 1 at addr ffff88813c188079 by task kworker/1:5/5239
>   Workqueue: events rtsx_usb_ms_handle_req
>   Call Trace:
>    ms_read_bytes+0x8fe/0x990 drivers/memstick/host/rtsx_usb_ms.c:450
>    rtsx_usb_ms_issue_cmd drivers/memstick/host/rtsx_usb_ms.c:477 [inline]
>    rtsx_usb_ms_handle_req+0x557/0x1a00 drivers/memstick/host/rtsx_usb_ms.=
c:531
>    process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
>    worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
>    kthread+0x373/0x450 kernel/kthread.c:436
>
>   Allocated by task 1662:
>    memstick_alloc_card drivers/memstick/core/memstick.c:383 [inline]
>    memstick_check+0x2c1/0x10d0 drivers/memstick/core/memstick.c:452
>    process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
>
>   Freed by task 1662:
>    kfree+0x20c/0x650 mm/slub.c:6792
>    memstick_alloc_card drivers/memstick/core/memstick.c:420 [inline]
>    memstick_check+0x72b/0x10d0 drivers/memstick/core/memstick.c:452
>    process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
>
> Host controller drivers (rtsx_usb_ms, jmb38x_ms, tifm_ms, r592) already
> implement their own hardware and bus timeouts, and callers in
> mspro_block and ms_block already rely on wait_for_completion()
> unconditionally.
>
> Replace wait_for_completion_timeout() with wait_for_completion() in
> memstick_set_rw_addr() and memstick_alloc_card() so that the card
> structure is never freed while an asynchronous request is in flight.
>
> Fixes: baf8532a147d ("memstick: initial commit for Sony MemoryStick suppo=
rt")
> Reported-by: syzbot+ccffdf05833ebdaeae70@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dccffdf05833ebdaeae70
> Cc: stable@vger.kernel.org
> Signed-off-by: Raj Ojha <rajojha047@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/memstick.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/mem=
stick.c
> index 7f3f47db4c98..1a2b3c4d5e6f 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -378,9 +378,7 @@ int memstick_set_rw_addr(struct memstick_dev *card)
>  {
>         card->next_request =3D h_memstick_set_rw_addr;
>         memstick_new_req(card->host);
> -       if (!wait_for_completion_timeout(&card->mrq_complete,
> -                       msecs_to_jiffies(500)))
> -               card->current_mrq.error =3D -ETIMEDOUT;
> +       wait_for_completion(&card->mrq_complete);
>
>         return card->current_mrq.error;
>  }
> @@ -413,9 +411,7 @@ static struct memstick_dev *memstick_alloc_card(struc=
t memstick_host *host)
>                         goto err_out;
>
>                 card->next_request =3D h_memstick_read_dev_id;
>                 memstick_new_req(host);
> -               if (!wait_for_completion_timeout(&card->mrq_complete,
> -                               msecs_to_jiffies(500)))
> -                       card->current_mrq.error =3D -ETIMEDOUT;
> +               wait_for_completion(&card->mrq_complete);
>
>                 if (card->current_mrq.error)
>                         goto err_out;
> --
> 2.47.0.windows.1
