Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16AA351C11
	for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760034; cv=pass; b=bTMNJ2HUNZxJYT+M5jmOPRHRtUU/waeVdLmQVBm5J6pkWwKrM1rsmi2h7jvNo8HJJTyX/Bqh2EcgIXU5Gt70zY6e3oM97olBksTI9XCHADpdEgSDOOyx5GrmzG5WY4I1shg4fzKaq7ZrIyP2jUMDqM1waR/jHEqhFobOzVuMHLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760034; c=relaxed/simple;
	bh=C7nj/SN7aM5XkOBbeD4RxwRFjpE3jc8JoF/6l0m6azw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YW/K/4jhgeyHE34Umj7k8p9p6LtAw61OGGh4LRfh2NRfozQ93FT7jFe2z/JmtK2uYmTZiOPmpjvYKz3tOAv0yPDwctyn/CdfezELKfMFljVoDVa3oKiE6CkEpzAsI3Te+4TllvQnGlgwuvo1DYLwA6uhf7aBaU/xMVutS59j1Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X0+ErsIH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QXUGB0hG; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X0+ErsIH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QXUGB0hG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7dQ0D2119059
	for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 09:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iPoikiBYO5NXXA1YDb4euULYj/GMIMikR+EDZceXnz0=; b=X0+ErsIHQKmpcMoq
	cY7nspCnSo/VJmG/U4YR6MAWrOWRu/uLLvTT2KNeiNZXdr3VvNDgdWKBTfFPFMAB
	knLMEVZ9LbvhZndKGdKxWRMwWELWcwo6paFxmucqTU7x7N33eiQvot+TYJFab3rz
	QvBm1gXZymZ5PNfhOmsj4o/CUd51AAmtvvPW+hfwvjjc3Bfuz37IMmet52jDowH2
	Uv5lDsmLQFfZhdhqwZWvtGCAZPCtwRboK2oJ1fHkKfRxVJApMIMTg8mtb1qKHcVs
	PTuutpQIwtDIfufDaZ86bhOsGvKYeNhx7aezMaalU4nDgcbQC9Z9hcgWbeii67b1
	HXHL4w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rhehyus-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 09:20:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-88629a452e0so1183409b3a.2
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 02:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790760031; cv=none;
        d=google.com; s=arc-20260327;
        b=OST4Q3ryTS60bgHPrlDYVhsIjlsGfRaWhNiYMvKV8OLUSRHpkQIPXKjEnBDj0Q8ds4
         s3NNkXvEAdS10iFhdo0w17VQNPPKcLn0lLNP7ojilpF8F9rLDcs7UN4ikqwph5geNVIc
         S7/5f0D8oH4QE+oQRZ3YHZbWFe0y+F7hI+R1ZIjLPjzLgiEkPdghWaCEYfzF2DG8uofm
         JauzAfb9WOHsogl7BbD1kZ1ANjEuv0kTmR63JAB4IbECc26V2dsXYiK/Cq3fFn/UEweo
         8U9MhoucWetCFZXulbZjc392FJPPjH4viZOwUcmDBCDRSkgC3Gznc0GwR2l9edyuUcTu
         r4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iPoikiBYO5NXXA1YDb4euULYj/GMIMikR+EDZceXnz0=;
        fh=HY1VRrziXR+/SrGN9zBRgg44GMMSZwdtdOw17DiwnSA=;
        b=ROqhKG/yfCLXCJYyyjId3V14HmYFDTQk3rpqLwlDX2skmOcvT+SfEecXXupWGA4MVO
         NiDGUaTvTUFkmfaMwmwezmqulIE/zKXS17dOwNA4+jPaAmr5VvHP3z7CWipXBx8NBYK4
         LpPet3TSIP4Rw41odCAC00AeDQVkNC47Oye4P36/JjbbSvf/qWrmEoanpVloch/opwEm
         MsiEw41XEbg2qIXMQNtC10BjL/WwEkJv6ATWPidDa2hrLoFj4vxI9OaUoW19IwjmdoNa
         ARA8yDKPa5Dbhc/mLOsTO7KOdisiFo4a9YcSAi6GA0hBkXiUbS0LPdVRiZVv96nS/6LU
         n/PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790760031; x=1791364831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iPoikiBYO5NXXA1YDb4euULYj/GMIMikR+EDZceXnz0=;
        b=QXUGB0hG9SdqbapPBJnKBdfp6sAMyw5ClYArTTr8VpBLxCFApoTryrTJFm8/D1D3fj
         +NrKpp5sfd4FSACGzi991gurRURYi5ZIGk3fhTQ/jhjO1FBVaBeUyLN1y8pHlKrDCmVH
         0EpRFruypwB1YeAlGWH6ZHQ0Y4LHio97XkvJH60oCT1HaaMfdRhoNU7v47zLMbRVjzfd
         Osb/ZN7xeUwsykCScH/Tm3aGqiDa86ILuqoqytlVoQMGTP6jfBAO5Qsz9u7HfqP4IA5q
         tdXKZ93U9OAYbLXmfVH788TTW3r5G8fhJ0KG5+Zzae98L6yyl+gYHB5lyWWiIzpR5LA6
         cAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790760031; x=1791364831;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iPoikiBYO5NXXA1YDb4euULYj/GMIMikR+EDZceXnz0=;
        b=n+hW6kRt1+dAUiT/Eh8nPxbKPE4dBWiilliPc1EijABq9f9q0dlW/3rIwzU10eQoy9
         s/TwnVeiDW9h68BkXqcQvuxM1kImhk5tozCa+4Lk5irVC/rLqE/jP5eTVdUurIgDCGM7
         jr6avhDrXS5jdUbWfmuh6jTKAX9EyKS+GgWpkrYqEh2B9RHXmjNlqWliAhEAd0G8jUiu
         JcqRUScVmrm5gO91jsD/oXnLcHXc2bdwnav27hw+Oj0n5RmgZJZnLPUfHJuIL5hTuJKQ
         JJALIBTNANLtOzN/gMNHOqPa7dE/VScC1utxez8AONvRA78C79qa9CFkZgsoLIx3qXz9
         lfqw==
X-Forwarded-Encrypted: i=1; AKwUvBxFTa7LqwOOCtKgG8riJk4kkB/mvr5Kk3riW+Jc9oOS+OOdMZayDztMnK6zYTQTdhOiER9Kw5/bJeI=@vger.kernel.org
X-Gm-Message-State: AFuF++nHjUNcpZh0ydSNDzwABMO4b9Hl0gXyDoGPJCre0ovi9uMF85sH
	/Tk8E7dWsGgaHzykdxWy4cyrGBumJFkbs6pCIGemS1vI1PTN8avxPlXK63fo7yrRRgQN6cOBy71
	s5vq28N/xG9eodsZ/s3hCkv+PKw6z2mFbLwEGikKAr5+axPwgZB25T59rFqr2h/MA2wVtiQRKjF
	jhi76u6oD/7uKm7p5dyy3KM5SRIaGSoNBar/Ow3Q==
X-Gm-Gg: AYBFou31ddFEpytq3t7OLEX9HlOQW8z8leg+ERXcdHYnaKbYCSZR4OszkdBT9jtce/O
	DaaqLqOpOvrBplGkQrsIKFUKKeWrFUqXAGmY1pfhp3WMGqruULhIf3a3jlQJprcxkCRNWguk5hV
	6+uWRXjTWz7xGrVWAnvrE64rnKQr0b21kaXNbmMPiNWLlP/pQ6T/neoM8YNw==
X-Received: by 2002:a05:6a00:430a:b0:886:29a4:a00 with SMTP id d2e1a72fcca58-8874b357ec8mr579679b3a.47.1790760030644;
        Wed, 30 Sep 2026 02:20:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:430a:b0:886:29a4:a00 with SMTP id
 d2e1a72fcca58-8874b357ec8mr579659b3a.47.1790760030158; Wed, 30 Sep 2026
 02:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919100408.113979-1-ngocthang2710.1999@gmail.com>
 <CAPx+jO-JBBLNCUrnB0UaMSPu7ajwsrEQMPJ1SfH2PccCR5VnCA@mail.gmail.com>
 <CAPx+jO9iva6YnKba8aEuOHURiZKjh2+wvhfC97bZ22UjGsXgNw@mail.gmail.com> <20260929161228.128616-1-ngocthang2710.1999@gmail.com>
In-Reply-To: <20260929161228.128616-1-ngocthang2710.1999@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 11:20:18 +0200
X-Gm-Features: AclHuK8jHONrdOCeZsLZItG4tKcWfeOo22urrMSWFA2-DdVmhUDJGdy_KmDXg6Y
Message-ID: <CAPx+jO-FBNsZFvfep-2SpqDFm3kYA=RpcF0CZx-kj0XH2juijQ@mail.gmail.com>
Subject: Re: [PATCH] memstick: core: reclaim the request before freeing a
 timed-out card
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, Raj Ojha <rajojha047@gmail.com>,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+3ee5da0319ca17ef1f4e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: TWYiubbqiJUt6YQvR-XBxTXarJsSYcZs
X-Proofpoint-ORIG-GUID: TWYiubbqiJUt6YQvR-XBxTXarJsSYcZs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzNyBTYWx0ZWRfX9jaKZMy1s/k5
 C3i5MknlwPJ2LNFGPBDcuP15V8pV3GPQTSOL31bYC3ZaqPDN63hivUccHxi794ujUwhSmnNHiTq
 IXpWccfJ9zEjPiKUhjAFTQP1UDbGfRgCqteJ4bLLtWpWH8AbsY35Gd/AQ/wxQy53ZDs6lxPe7SG
 XXGvSvTK/ns3KjlHZdAI6U9pDh3xI1GLlbed6iVgMFoRt0n5LCIeLkpXA8IqMUeOy40hjRqrcAq
 CHvPmH96lOy7lrGI/CfnAIIijQl/ZNZlnAzq875pqpBbovSnFDqhDJ0Te8JsKYpolL9I5sR3Ti4
 MjJ1QMk1CuAU4k1sqH1gxFdlpqu6MPuxCidl2khtDuf/8BpAiAiI4LAMTELEKVCN9TQmQxM8lT2
 9wjHdTCpqYDYW46Tm8bVyhJkIHOFZ7XT7+o40E0WIKUqzE2uLuTN4p7yTDYDvguWMsEO7yqlR9i
 1JB8w0eP2GhDJly0yEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzNyBTYWx0ZWRfX2MOVmPyBA1FN
 V7AGLnzrVLT+n17NkHur/9qI4aD4A0J9IvOW7sssWABk8QJ8gL3Jp3FtnWcEMIW++YPGnQVJ4I6
 kiSdOGe7GBDgMebnw9K+jVPq/OSbuWY=
X-Authority-Analysis: v=2.4 cv=Tu1zFzXh c=1 sm=1 tr=0 ts=6abcd45f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=KUFF4FggBersskXqLM0A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300037

On Tue, Sep 29, 2026 at 6:12=E2=80=AFPM Nguyen Ngoc Thang
<ngocthang2710.1999@gmail.com> wrote:
>
> On Tue, Sep 29, 2026 at 12:57 PM Ulf Hansson wrote:
> > Reviewing another patch [1] for the same issue, indicates the memstick
> > host drivers are already managing the timeout themselves. So, even if
> > your approach seems reasonable, I decided to go with the other
> > solution for now.
>
> Fine with me. Raj's patch fixes the UAF in my reproducer as well.
>
> One concern: it is effectively a revert of b65e630a55a4 ("memstick: Add
> timeout to prevent indefinite waiting"), which was the backstop for the
> rtsx_usb_ms remove race that 99d7ab8db9d8 ("memstick: Fix deadlock by
> moving removing flag earlier") only narrowed.
>
> memstick_check() can still pass the host->removing check just before
> rtsx_usb_ms_drv_remove() sets eject/removing. Its next request then
> reaches rtsx_usb_ms_request(), which drops it because eject is set, so
> nobody completes mrq_complete. With an unbounded wait, memstick_check()
> never returns and memstick_remove_host() blocks in flush_workqueue()
> forever. (cancel_work_sync() in drv_remove cancelling a queued
> handle_req before it picks up the request looks like another way to
> get there.)
>
> I reproduced it in QEMU with dummy_hcd + raw-gadget emulating an
> RTS5129, widening the window with a debug msleep() right after the
> host->removing check and unplugging the device during it:
>
>   INFO: task kworker/u10:3:65 blocked for more than 20 seconds.
>   Workqueue: kmemstick memstick_check
>    __wait_for_common
>    memstick_check
>
>   INFO: task kworker/1:1:33 blocked for more than 20 seconds.
>   Workqueue: usb_hub_wq hub_event
>    __flush_workqueue
>    memstick_remove_host
>    rtsx_usb_ms_drv_remove
>    platform_remove
>    ...
>    rtsx_usb_disconnect
>    usb_disconnect
>    hub_event
>
> The same test on mainline (500 ms timeout) recovers fine.

Okay, I see. Thanks for looking into this!

So we are solving one problem and re-introducing another. :-)

>
> Since memstick hosts are expected to always complete a request, I think
> the right follow-up is in rtsx_usb_ms: complete requests with an error
> after eject instead of dropping them. I can send that as a separate
> rtsx_usb_ms patch on top of Raj's, if that works for you.

Please do, that would be great!

Kind regards
Uffe
