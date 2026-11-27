Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790625;
	b=qAsZhB7KB2ZEj/k2Tqqf+9a40NNsUCgh5nZDrYZaUjHi33LaD1T+TPgpRQg9ZtUE7XS5
	 Hmt5KSzl93YSHS8+1flAD921gY8qzKfP1JnuRgJBa3LMc6FVm/TER2Iuc/dVN9EsghBST
	 eVubrrhNuTrcsQ0YUtaP1TEE3J8sNk4PNfBZPPCUSjTgPZIfZDZNsM2Y6gL6iBjD+nHkj
	 /rdjPq3dRVN2gOpgv8XpskWOfIJfNFyPsom8g+qMs5OzIaYJ+e3dI4RDMxqfdcvzHnsa8
	 VsBw56XsBK3k+S9yWCefGw+cMlwaCZjCc3yo2H9kE4QjNU/sRqbgnTN2+iaIW6WRwHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790625;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=WYwRYvmg1yr4hFV3xXwX6VX9Ocs8Qg1v4HgcCvCbLoE=;
	b=O4cusqrKrnO9RzSjhLMdOs5fDV+pH5ARjFHBtFfHqGYp0ar2Wf9DOQt9CIV2agldFNba
	 f1DaWAWqomWb1hTMDJJZU5UPtUxZMINtuZZoq59fsbtNn8am5QaB6mm9SbXBWiGNMfmzh
	 FWW2Pgf9pnl0dDiPfzx8Wo+KiyQbVqCp/S7GPAi+rbgNPGOPd1XCrnvTgV/QdPrKCdslm
	 H2T3jq1jI4UA3KH+7ov7+5mvP6uyra6XMQNs++m2TvnPSzU0SJ7XjrHXtzYw7slnGsnBA
	 HwJ2fxF/SOStztf6KFA6c+mdY+MLUb875g7aem65jtm4P9a1KqD8K3apyAPOoSSVd+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CiuwCcmC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R38YHaMA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC6B606A327
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DC6B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CiuwCcmC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R38YHaMA
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1VGL4018839
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WYwRYvmg1yr4hFV3xXwX6VX9Ocs8Qg1v4HgcCvCbLoE=; b=CiuwCcmC0Nw6ivfM
	V314dM28Chs5bIEhdvdUrGJCifYOGvvRP8jGtT6Ultns7ncjT114LESxPipJ8c+J
	o7y6IQDKVhs9JOYOnklwGbGNVAhdI7nGAMFCWdb6WYY2HQOcTC9/zrqTLr9sxKiX
	t7WcTcZXzHrTRXpRpqVo99eyZz0fbVM6L+rMqG4PlnuJAVqy9OO0nfd7TJ1pmfqQ
	sqyH7Vq+7nEgQL1O4JduIcXNtmDT9RXX6iKolu3Lr4EjWFUwfo8h6GlATVa4AOlO
	wewfBpN7zE/pnxUtw4QX7j2vSr4E/76eWpzm3KPdiRXs9+7uVOmY/FVAtDgFvw0v
	wbaxOA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73dha3yp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae7faf4ff7so9560354a91.3
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 06:43:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795790623; cv=none;
        d=google.com; s=arc-20260327;
        b=bMOqeudyhLZy1NyoIJU+8ObxYF6sYBeZY0PIiUK+jT7iK+FNSTFDetQCsqbFW1Q9la
         5aRITY8f7zQYSTc3QoJaPidk8dFKFfmgvGL6sKwExsMNCLUeBZXmDH3KG/CAUAmzxQgb
         UrJMFKMZJ66qtkBi5K3pzh0yv1Me+99jy1vlIPFPFZGIJwYlnC8zS1gFM9vn/L099W4K
         Ahyly0NncjKCuzqyERfGbs2H7t+0ek1UQOS90vRUcP8vlqR2mj3Guxz2gfTmDkvZTrGP
         ipgeSMVw+LaKdEeOClagzs0kPA7ELCMh5QwOraQyGpcvbe7Ptb8YYl3hEk9DQaW1eciV
         ZSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WYwRYvmg1yr4hFV3xXwX6VX9Ocs8Qg1v4HgcCvCbLoE=;
        fh=GcrTNgpv3tQKMDNc5nCzqxeSuVbHXv8ETYWCLoaMSEk=;
        b=KUu1Zs6b6AnGe4pbEMwWCyvbnjNcHoD7YE0pRdv2Xr3GNkzVzXcEtaJdhwMF+VxUAq
         jP7k7nuTHwE70U7b0olVMDG/Tx1rqFU4TdCS5gBTT/FfKFoxhVIFj7Y29+iyTGNK9Fv4
         BQ585AOz1EtnfSSuWdqoCls9QASofZcefSq8tYu7aNKCie3RpYBxxEZO8QdcEHeRd23t
         2QiEPrf5xuQMeoDzuhpGqBXu7LO5uOiVoq7O9+IjrRGa32kofyk1qjkVXesyLCKYH5nJ
         OJcax3ErwLsAzl/vG9o5mLKB4BhUpwE7GCG6Q1GoVylSIwkbI4Mn0rxCnxUNDWJZUdMn
         WRUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795790623; x=1796395423; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WYwRYvmg1yr4hFV3xXwX6VX9Ocs8Qg1v4HgcCvCbLoE=;
        b=R38YHaMAjBXNHcsgHJgxFblJfPczZ7buURFvLLDQOuLY6BOBnneYPoRX57McczePFA
         /e7Xz+E0FTYgyEYg8pp2f8BLz06b+NEVt0ClvsXsSh7DIhhlhK3PqIs9Et/J0Rt57hB0
         nTAMQeaY7Z/QRp0jMBPGBR/ldokEd5aNQY1xfOqi0qzlSGWzQJAMEI20wpKsPH5MVCIc
         i9saTl+QwwS9zDU4OiA3Lm6+UHT7yO0i5ZzfDjofWnu+Hx9xhgsF+xXpYK4YXfT7JzfM
         YujHl5za/1nr9Bt9YW2bw62AozNcshyM1CyV9FJ6pMdK6zOx5+/MBHkQk56PBhj+Yw8q
         PhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790623; x=1796395423;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WYwRYvmg1yr4hFV3xXwX6VX9Ocs8Qg1v4HgcCvCbLoE=;
        b=tj+jVCyAr1ggd7n2NEQxp/04j5Vy4KYylnZoIzF9HtqRlgEmRIugqFIhVr5UQ9BE6C
         7/DP/0zQa6uz6adacOtT50mSsW5A9/mQPzQXZ8+l82JMFBYc+yjSiiD8a2q5Vj8tdnpm
         N6VCjKz3MvhZMbNxnjGO50M2L137Z2CkFxyjWZGp3gyF9MdtUg0vzFMrEQ420LwobUzh
         Gncf5sPdaqnW6yTwUPot1hhqqkMWCuLbskbyGcPnj0kJSyzHw6ww3eH8Cn7kxr+z3+4G
         y5DC50LEAovrCND0F6oRMi26sn3Oqnb06AEzlLHo1b3apvP6MOkZEgIIFFhUlKRCx3H4
         2dWg==
X-Forwarded-Encrypted: i=1; AL+hErHd1+oQcAqJUGUFaBkwPTUz0ADgSMgPa9j4CgE3LWpAgw6wjutcxr4Wx4YxD7Qkpje7yIRjDfssupU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tOCkEqK+uUZ8aMmiW8LBXNASC2AZUaGdplhPMEZMIZ78H3adl
	AEfBUi+laMraWDEoyRMLIIPNNhn1R9zQUVP1/7s2W2Dy25MhmxKMip6Cu2mJ4FiuBPo46ZOz/pZ
	U8hms3tbmKchF5pP8x3bOah2KenAhcYE29LJrpr7EIsOmHwnhm5guZzv88aNvohv5WYCnv4dgH7
	hYUqnP4JIWLTM3uw+RSZ2qGxRiA2F3KUsqJoudVL26YA4BOg==
X-Gm-Gg: AZFdTZfiS4naoSpJ2jHX32WVTxhf6BFGEjJH8PmIvX8N1BU6vtmYOsfeqPV930z6g9H
	y4Qz+tq2ycGQMKOkylNAF+eblHW6jq6wX9jVkoRELjSd1r8BI9GqvspdSJSI2SFjg3u6Y6QxLQy
	4jPLoM88WsBR9pBUHaR1aB9zODU0jKB8N9BpHt6U2H//B2szHik6WW+OdAcg==
X-Received: by 2002:a17:90b:2e47:b0:3b4:a63:d56d with SMTP id 98e67ed59e1d1-3b41c7e119bmr24623438a91.1.1795790622848;
        Fri, 27 Nov 2026 06:43:42 -0800 (PST)
X-Received: by 2002:a17:90b:2e47:b0:3b4:a63:d56d with SMTP id
 98e67ed59e1d1-3b41c7e119bmr24623401a91.1.1795790622421; Fri, 27 Nov 2026
 06:43:42 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103192345.647483-1-kernel@picomail.one> <20261104054412.8310-1-kernel@picomail.one>
In-Reply-To: <20261104054412.8310-1-kernel@picomail.one>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:43:31 +0100
X-Gm-Features: Aa3M54qKOWtbP_f21x0lELCetsrIy47-wTE7FTFr0KH095P1fDzVSPwkO9ID7uc
Message-ID: <CAPx+jO_6CVfC+JsieB+u1z3R4b_D7GcOX8anXfgmBtd6MoozRQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: clear MQRQ_XFER_SINGLE_BLOCK for new requests
To: Jonathan Schmid <kernel@picomail.one>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX7xKbUfnafm6I
 dGlM4GEapnnIw7n9dnt7yluWYCI7HX8tePolR7aAhiPHAN1WH4lFKhdPlLZSnK7zIDVWrLTdcTE
 ExTmbLzrmwdWrFq7/wTxsq5IKADyG9o9g60mgTsxnfJp+pK4YWrPq7+Inymut4Ffn7+3Wuh4BTm
 EnOCC80fcRmgQEEx/TMcyMZK5Bl8NWjEV/JlUT9xRptfk7sYtt/NpoavA+fidKlHfWWKOE+xcxA
 qvnGU0Mw9NqTLwy5/RlI2lW2mH0+xM8+BvxLgQgRpdvcz2IkETBhoRUrnEWLRDwmN0eYO0RN5kZ
 /iTcaxFYpnZPna/KUYB5ANXwvqfltqGm5I22LTiGolZZks5U9pT3HI5AJZ2eqUdS7otJfzNGq4/
 G0VH/gIccP8h83UA4jteBPyvete+OG785DtEu2by+jl2e0N5akjuQDxR0QTUUnwO2AMBK2IjVIk
 0aGCSWJEsFoY6/w8t3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX5jRqlAbA4Srz
 ItNXIlhXiimZJE3PfvBo7EyW22NDRHMYlTufvZJbpcb6ZnsOmeKs3E3cpXNEF9+XWHhXCDhP0sp
 1TLhNEcC5evPgAcAJtBYUxedOs3E5J8=
X-Authority-Analysis: v=2.4 cv=FfiiV5+6 c=1 sm=1 tr=0 ts=6b099720 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=eT9L358XsF3sCvS_DZ4A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: A8_qK-QtsrxcVnrJh5ZgV5qMPB68JcSK
X-Proofpoint-ORIG-GUID: A8_qK-QtsrxcVnrJh5ZgV5qMPB68JcSK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270058

On Wed, Nov 4, 2026 at 6:45=E2=80=AFAM Jonathan Schmid <kernel@picomail.one=
> wrote:
>
> mmc_blk_mq_complete_rq() and mmc_blk_cqe_complete_rq() set
> MQRQ_XFER_SINGLE_BLOCK in the request PDU when a transfer fails, so the
> retry is done one block at a time. Nothing ever clears the flag again.
>
> The PDU belongs to the blk-mq tag and is reused for later requests, while
> mmc_mq_queue_rq() only resets ->retries for a new request. Every tag that
> has seen a single transfer error therefore keeps issuing single-block
> transfers (CMD17/CMD24) for the rest of the uptime.
>
> On an RK3576 board (HS400ES eMMC) with occasional data CRC errors, which
> are recovered correctly, sequential direct reads dropped from ~200 MB/s
> after boot to 3-10 MB/s within minutes and never recovered. The host
> registers showed only CMD17 with a 512 byte block size. With this change
> the read throughput stays at ~200 MB/s and writes at 60-90 MB/s while the
> data CRC errors continue to be retried.
>
> Reset the flags together with the retry counter when a request is
> prepared for the first time. Requeued requests keep RQF_DONTPREP, so the
> single-block retry of the failing request itself is unchanged.
>
> Fixes: d34124edffdb ("mmc: block: Use MQRQ_XFER_SINGLE_BLOCK for both rea=
d and write recovery")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jonathan Schmid <kernel@picomail.one>

Applied for fixes and by re-adding Shawn's reviewed-by tag, thanks!

Kind regards
Uffe


> ---
> v2: use my real name in From and Signed-off-by (Greg)
>
>  drivers/mmc/core/queue.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -301,6 +301,8 @@
>
>         if (!(req->rq_flags & RQF_DONTPREP)) {
>                 req_to_mmc_queue_req(req)->retries =3D 0;
> +               /* the request PDU is reused: don't inherit single-block =
recovery */
> +               req_to_mmc_queue_req(req)->flags =3D 0;
>                 req->rq_flags |=3D RQF_DONTPREP;
>         }
>
