Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794395513;
	b=KrBFcTf74xA2g+2JhwcoFkK7G0d9qPV1eKubOcGt8wleNUlngR5/9gmfxnEGSFZUONE0
	 KndDcYA5PrlxEINKEXd0w8BZL/lu2px8XHz4xscjNzbNTC0vAiMtf5Wj3o0hZB3kFq5OK
	 iCt4VSZ2U80Me/iOY7H4Mjjt1joNDcdIq5aJNnoDI/c/uxHTEAl65ZpxAFzEcM57dCPEX
	 saqDU8XtABOD+enn6yx9h8+YkcnChIVBAj/Mr+Zd6iLNM3wBPWtu1l0ZoWInwi/SIZlmB
	 O/ghdCMFFmGgtZcVTWRYb8PMc8kLRrFcNgtOBH2VhRTkWyXdvRURvPg88IcMuvHRfSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395513;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sQA6vSgV9Z7FYXqSNB/QJltNWmeQcY/nmAVpGxD2qac=;
	b=kq791JwdYMFi6RZDWUf2UtknUqS1X8w4Jji2eCCTLujmIyUvbZbdcV9id8YDTXzmfJWy
	 ndoQ9Wru65P+rDAQVK86N1kNd/3dCgtR/72Wkvf2Fr71/Vp5A1IVe9cgQ3yiBZu6SGmNa
	 tdE3a7cZe3pnz157HbviGz68ktZuK5b7WRcbdeC1hlPSy1g3+NhqkMKRWaEYcfYfmir1w
	 p4wuC5P4VABN12Rmf0xtcyskkrVSyUfZ6yqnM/NaMDh6CbeqdoiJxMCTPwvuCMSaF5X70
	 nK/8k1TNZQI3NLfy5sDl8xT8xvimo0+0iGINLbQI8uLCYIZ3Lug7fWSZSxDFPNTu2Kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="YgY/QIRr";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FQSfVKrk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA49606A8A5
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADA49606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YgY/QIRr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FQSfVKrk
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABAsLvJ3958974
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sQA6vSgV9Z7FYXqSNB/QJltNWmeQcY/nmAVpGxD2qac=; b=YgY/QIRrZFMzbzmW
	MzKRTG9aKYcVm16Ma5TDn+Ta48t7wuFi2vmti1OqRR6DR7hkq4zfPJUcw0fw94MC
	ebcCqPhwbq7hgJm0MZaH5+PdVvd6Np6d1FqrDnkQjdnob+lA734qTAvaU7fVwmpf
	0QPS4327Kij01XUc1v1JPkuD1lY1TnTsAM90K4iWsDc39alhUrdRzAU7m7ZYd7zN
	+boJTezp1cDIv4rx1rhYkr0xIqRv3BUo9EtSQ5LuRv4fTc3zKLSNNhXDG93RUYIB
	+DmPFdtXD16Np5+YY8AUEhIVakIJdQYicQ/RiXvTDRu8GFRbHDbqJk75MB2e8Z/Q
	hsbMjw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b338ns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:11:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b17b31c3beso952130a91.2
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 03:11:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794395511; cv=none;
        d=google.com; s=arc-20260327;
        b=cqUDBkCOlLp8/zRu5nkLbdUAaEIGAC9d+I0BokzSZV9h8UztQoqdVCJ6SOw974+tFD
         cY5s94xnyEAOPwZJwIa2hOoVfKLszTwFQLfjVEMa9Qt6OyucR8GG/hJXnCcW3qIqX+a+
         MnVC9/73JDpADEptAz/mLmlczr64v1Q2q6rHrqmVLCGh6vkaGNCKQJiuRF5bo/BRPu/U
         80Gype+fJ90/8U3XpIb7o0R4Mop4Bk1FC2y4ubq4mFNegluNJx5JqjGP0MwTtJRyiJRo
         xNi3Hmzwf3i/O6WBPJIElVU0K8hrUG2O+/7XmvXBHE67XASgvDncXBpTgZ6J6+puPYdF
         9OfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sQA6vSgV9Z7FYXqSNB/QJltNWmeQcY/nmAVpGxD2qac=;
        fh=jv6rfsToKWm1Tcf4LC+jMgqWnL0UONMwU4p/vgjOi1E=;
        b=rvi23PKMujkkDWfB7iT6aPu+ENlvmW2ZA4Um+FVIi6GJphNcqxjinXzGYpmwQUhhXJ
         ircRldJAQEik7rXQqOozQV6wVeVNhk612pKhId48a2k6gxFzFP7pJ/8RrksKxnn/eEIa
         tia/bLlTzOhXPPZtnfhYKGf2dmphfJpK3KkY75vYHiqojKuzp4q28JtvXz03key4Bxy3
         BY91QscLSqOfXjcHEDVon6fxWvos8wUbDwah3lpaTVaekfeYPFjzHHI7w3umD/iY04Ue
         ov+hhTEvaR4+WoID+zY5UbVpn+zLJr7wG/pv7Dohd0sVyb95qzBZT47wUQBnqzUcyjUJ
         KpLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794395511; x=1795000311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sQA6vSgV9Z7FYXqSNB/QJltNWmeQcY/nmAVpGxD2qac=;
        b=FQSfVKrkBzqBWzcY48erblgL88HpryEfy1NDvzWpxZUrAwOnIAhDXZUflLprhar/96
         6KwtenxYYbcgnDA921zegLlb3fMQ8P1AP8mSNIws+1XuPjC8A6BYWVpVJ9SjCNRyQukz
         W7jsJgQ5XqVpeW1jw+yudL0ZpFKlIv74+OxgmEqBNgS9U+4JZ+VjcZCLovH1ZdEtoQFE
         OYxb8zSBcWRkvf1qjeRldBKrJTQ6PixrZcPa5QdQu8MT/mjr3EdvxyRirpT0zFbL6AEv
         suX5dm9vOsi+XiKFT0/zDkkhFRspTKKDSVfVnDGNJCT2hQxFQUaXsORqLGFePz+VPtv3
         7Vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395511; x=1795000311;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sQA6vSgV9Z7FYXqSNB/QJltNWmeQcY/nmAVpGxD2qac=;
        b=uxOxJxBxIlVqfzNOqgTFTw92wL0uvXp+JTz8Dlm1hipzb4ZbxEHGj2A0WxjSlx7N+7
         P8rkvBrhiMbj9hxK2f3lllrpl9J06kR2+UxkpKaSKDtcEVE//ZUoekjtTmKyjli1u830
         bWGf4hvOO22c6JiTvB2h2OxXOHY5SXK6Kv1mvTIhEkgLjPviCE+T25zHNKJkuhYZlDGN
         5VvGZSAaTBSr0ZFYGKKnAcL72uKPZtxl3MhZmxecZKJtaBlxFOblk8bLzf0aO3DjbgE4
         hPNNlc0jbv7PR1MKKrau5mvwL/B83fbhw4BAS7DxOGuBafQ47XjHJ67j5KIOWYkELTgX
         mnpA==
X-Forwarded-Encrypted: i=1; AL+hErHhEBP3u6RbDkOVyhukqcfBxvXNuDwe09sEdD73J89icrwM3evkAElcolEbLcc7SrG01439ljmxMkI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zcqscUGRIQ/0ezD3/tPBrSbKRbTIGRSz4P8v4U1pgmTOe49D/
	iBVDq6cQnX4Mk+mGjc7iNIEwMLahu1xP+OUtTqvcJLDfM10RxKe6PBTl1LrJpQ46VykHGtXCj9c
	/luuwxg987X1ntEcIQxGeCavC6sCwBkYYehEbVm4f3bETCjWujsP503mUSzA4VuigZ16/wlpUlN
	3Jw2TzkYqZMjx8YaGfO3mxdpD6WrfxL9Lorv/ngfAqd6Bozw==
X-Gm-Gg: AYBFou3L1jcahGqxkKCNaHQmv2e+7l1PUtzy0eyVzwck0BN9xuHEWBe7s2sVd83iOoi
	VYeXERRxLc4CfkESMaNA9u53SLYSAS11SFtIabkK067HK1qo2z/zDFCabdKIDdVFX5YSerOeSSz
	mBcBUm73B+4NyBhK3zM+mLBMNpj6sYmcQdTX5+1dzJOg4+TmGP6YsVNZpLZg==
X-Received: by 2002:a17:90a:e7ca:b0:3b1:6e5b:c89d with SMTP id 98e67ed59e1d1-3b182fbf462mr2113807a91.53.1794395511055;
        Wed, 11 Nov 2026 03:11:51 -0800 (PST)
X-Received: by 2002:a17:90a:e7ca:b0:3b1:6e5b:c89d with SMTP id
 98e67ed59e1d1-3b182fbf462mr2113784a91.53.1794395510596; Wed, 11 Nov 2026
 03:11:50 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CGME20261110192834eucas1p1e183345528f097cb64340f36a03e4b14@eucas1p1.samsung.com>
 <1791876245-190981-1-git-send-email-shawn.lin@rock-chips.com> <4a1867dc-7bcd-4c63-bdbd-a533043cd91e@samsung.com>
In-Reply-To: <4a1867dc-7bcd-4c63-bdbd-a533043cd91e@samsung.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 12:11:39 +0100
X-Gm-Features: AclHuK-Sms5exrjRwhrlsco56VGoUf7zoR2ZorVBgLiKAOV-koszXKzt-bUZ9ek
Message-ID: <CAPx+jO-YxwhG3TpnvFBFTXmf9XCdoi4eqeHeWwqmAc9BL_v=tw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: enable MMC_CAP_DONE_COMPLETE
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af44d77 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=hD80L64hAAAA:8 a=s8YR1HE3AAAA:8
 a=prSSRhHsvR2v3qUKyjIA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0NCBTYWx0ZWRfX4DwjAY3O94mc
 gV1SYe+FQH8dB5ulya54UasLyja1aGU3d/EZu2RXFZSzkvaYTvgm+81tg32IB+OMDPm2RsVogbU
 xqCj3YcqwEuTnzhchM8yqmkTKnmupPJOcqszGrqBiqTgDtBDUgQIR2ULL+bTndF3byqHV0NlS4W
 Vum9RQau90Icuv3kV4pKsDWQ6jY3NjHziPJCTG2Deume0vT22UM5uQq0zSRYuc0TWkFRsw6DvNd
 ESK4BxpV7R0BZItzIjQakkmo/whmo3DWfDYJxLW1ziqugFr5IK9nt/WAN5H65x2lIjiOY9MJYoC
 sI9JI+bf6WDuvWkk3q/8FKKeMBU7MZ7fsXEj20lYMolOH5zcBNaBGQWYXPai2TxPHR0/tVOqmge
 8auJUA4yJeb5QvNOVXXSXP7mBEykrQ0JPuDiNkLJ50/253FWjRZFo3VgJdOtoZSvMO193fEkyme
 m5IgzvWApntW9hdcuig==
X-Proofpoint-GUID: 2Lq6Q_28c1rhakEPJYIm9wF_sGdWqDu8
X-Proofpoint-ORIG-GUID: 2Lq6Q_28c1rhakEPJYIm9wF_sGdWqDu8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0NCBTYWx0ZWRfXwuF6X/crpETD
 NFL4MNHKP0nyqH8z2xsdTEF+gco4rC856STH7OPrnkynBqryAilKTKPrepT3L9XEJJHLw2srWm9
 nPDOWcMMmExyizfxYJP8Lfo0eh0rR5c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110044

On Tue, Nov 10, 2026 at 8:28=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 13.10.2026 09:24, Shawn Lin wrote:
> > All requests issued by dw_mmc are completed from dw_mci_work_func(),
> > which runs from the system_bh_wq workqueue. It is therefore preemptible
> > context and host->lock is dropped before the completion, see
> > mmc_request_done() in dw_mci_request_end().
> >
> > The dw_mci_interrupt and the dw_mci_watchdog_fn never call mmc_request_=
done()
> > directly. So every request is completed from a sleepable context with n=
o
> > spinlock held.
> >
> > This is exactly the contract required by MMC_CAP_DONE_COMPLETE, which w=
as
> > introduced for hosts that can complete requests within mmc_request_done=
()
> > without deferring to the core's complete_work.
> >
> > Without the flag, the core records the finished request in
> > mq->complete_req and queues mq->complete_work, i.e. a second workqueue
> > dispatch plus an extra context switch per request. With the flag,
> > mmc_blk_mq_req_done() completes the request directly via
> > mmc_blk_mq_post_req() -> blk_mq_complete_request(), and a following
> > request completes the previous one inline from mmc_blk_rw_wait().
> >
> > Measured on an RK3576 SD card (dw_mmc) with:
> >
> >   perf record -a -g -F 999 -- sleep 30
> >   perf report --stdio -g graph,0.5,caller
> >
> > fio: 4k randread, ioengine=3Dlibaio
> >
> > Without the flag, the completion hot path is:
> >
> >   mmc_request_done -> mmc_blk_mq_req_done -> queue_work_on      (~4.3%)
> >   ... -> mmc_blk_mq_complete_work            (kworker/5:1H-mm, ~18.4%)
> >        -> mmc_blk_mq_complete_prev_req -> mmc_blk_mq_post_req
> >
> > with the flag the workqueue round trip disappears completely: there is =
no
> > queue_work_on and no mmc_blk_mq_complete_work in the profile anymore, a=
nd
> > the previous request is completed inline:
> >
> >   mmc_blk_mq_issue_rq -> mmc_blk_mq_post_req -> mmc_blk_mq_complete_rq
> >                                                   -> __blk_mq_end_reque=
st
> >
> > This can remove a redundant workqueue dispatch and context switch per c=
ompleted
> > request.
> >
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
>
> This patch landed yesterday in linux-next as commit 80636b762eec ("mmc: d=
w_mmc:
> enable MMC_CAP_DONE_COMPLETE"). In my tests I found that it causes seriou=
s
> problems. I found that it is responsible for corrupting root filesystem a=
nd/or
> journal.
> Reverting this on top of linux-next fixes the issue. Unfortunately I didn=
't find
> what mmc access pattern causes the corruption, but running my tests and r=
ebooting
> boards 2 or 3 times usually ended in breaking it.

Okay, that's not good! I have reverted the patch on my next branch for
now and added your reported-by tag for it.

>
>
> There must some corner case missed in the analysis behind this patch.

Yep, let's see if we can make it work. I assume the benefits should be wort=
h it.

>
>
>
> > ---
> >
> >  drivers/mmc/host/dw_mmc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index ff0b25d..bec777b 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -2945,6 +2945,8 @@ static int dw_mci_init_host_caps(struct dw_mci *h=
ost)
> >       if (mmc->caps & MMC_CAP_SDIO_IRQ)
> >               mmc->caps2 |=3D MMC_CAP2_SDIO_IRQ_NOTHREAD;
> >
> > +     mmc->caps |=3D MMC_CAP_DONE_COMPLETE;
> > +
> >       return 0;
> >  }
> >
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

Kind regards
Uffe
