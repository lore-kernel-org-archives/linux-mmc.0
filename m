Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790633;
	b=BLlB5gEYFbGsL/E5SnDnY9F/yQIdxirLIb30NcXZHQhzTfmc3LEqnjWMD1dJl8mgmHv6
	 Jc9qu2pXQNOOmZogV4RE/fpT2cT7yhztK2yagub49KGrUsOOmSvswAX08isfvXQvMVQJo
	 98UxWn7gJirhrFzAjCfSS4S573gA6MYzw5ilbr4X7mNSrL4XUihFj6RYTK7etnuTlCAzZ
	 +/6wfuctDnusL3Al8T8Lpmm/lfiiw79fgFtdjKWGoC7dgQ36k3P68JU53Z91NTcc/6h9k
	 AB1ofyLJFMaf4wc1LRZ0XA9lvoFkcdSigfTAVcwKsdFcq58Dl3F6x0UkqaPx6JLnYSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790633;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Qov/vWJdi933tqkTpBJGy3o9z0sNW71HS63CMgKtbjc=;
	b=iIcXONmpk5hIukDfQpxqr2JrfgEvOpoiCUq3e74T7R0lF6xEUmsbl5NF2omsv5irWdVm
	 +FvIuYhyuhPsBPOW3+gUDiAVGGGJyC4ghitgIP/aW7ovGbkA2s6CjB3qG4zIyiJpDKSG1
	 R1sapB+Ci5QYBW3d17IHd5WGegp1pBHCV+vcZiR3aVd+XgJ5mHMhCm0GAIlPfJFbUe7Uv
	 SLcR3bviDr5jrdyakSHAy289QJb41SLuUdEB2ah7LmIpDt4tH4zX3yO8hbGwL+tipYMmv
	 +Cd34GN+2re2ah+zqkpfQezNKSBryTZrF2a/V7KKMRDl0mD/A5rrbelAk9pLhnAfP+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="gkIWz/iF";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DJuP3Gpz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144AC606A326
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 144AC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gkIWz/iF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DJuP3Gpz
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1HOw2683919
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qov/vWJdi933tqkTpBJGy3o9z0sNW71HS63CMgKtbjc=; b=gkIWz/iFV3w0u/Pn
	1OQIAUlMsQ2LDPqtpMp8pP/1Fgy9emY5ax7n9GGu0KfAYPG/e497m1kNP979ghtE
	f1+Q4pk71MnZ50n198nswwILRMRFwALoHLj1z/cFT8F0ZeHqhLWKpzX2hm55wjto
	9v5u0bK7RcxdvyBhtaYve0WwLiPaL8zb30OzyTS1WanN0vFHDq2yTemD03PPSEEg
	cdupaWp4Cxyh6sTaVcc7ioDxRorYNm8y1YO1xvoIsKRSJ90Qy/UJ2NuNIE7z0yGt
	vl4LVGpvmHNJwOdFCnrRs84lCYJYudiGxxpoBe/ag98U+Mlr0rfIue5E1AxD1H1s
	9ciRqw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhj3dk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:52 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd652c0385bso5488238a12.2
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 06:43:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795790632; cv=none;
        d=google.com; s=arc-20260327;
        b=s1ev8L3SQPipBwZjpSBQ8eQNN0pdcGPUuuoFNRhCsCJupXBfNq2lq46XO8Rm3gD4Vd
         nYyqwq+GIkTk8BREGvduHlv9NoW1nTGzkcSLgQEgdNahTTxIG/1Ve6FkvZsAhrL9Dfqu
         EAGpmozxndvCZPHWo5FpoEinHWHSg8VXu5X97/Wmg3x7YFKYoBy/D7PO46SmeTqoB77c
         hVQoI05O90uNaV8WAGdSBCcjcZAQYKhWQLE9oK3X0QHuuFXC19Z0pzN1sM8ES4RNhUli
         sn7U4qWT0QXhhm8fzRWyc83aIzAn9blcQK6SCSfoaDTKsNWKiqmfPewO8SuuJHFppwj2
         z68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qov/vWJdi933tqkTpBJGy3o9z0sNW71HS63CMgKtbjc=;
        fh=A9D7/PhCFTI79AVplrYgwc1uNLYW84vWP0Npr16mvKg=;
        b=KNMa+V8Gl+P+BG4BO9LAkVDqrWaC94lPh5Dwg6JzjTZAe0hQgtFTS361cn99CIf1xh
         FZHdoJ9dK9Grot3Os6PmN+akQOc5e2ikNEHfgKs6ezUdTAIn0KFkAuUaV8t0fgHv9Fm1
         5gP+cSZRwFT2c2bG+Ff3geHf2HcJSzVVfVvHinSr1Bg59dvos2U6B4XdO4bzstFw0So2
         5nU+LsBHdzk0ltdtRIm/0yWXesfMuFHQhUWrSwpSyjSQBuEJFsf8UeGOQLgkwF7cQjLj
         PoRBqIkm+XAyNywpXEPRN5S7EZjCRkTRa7aOubvXUvjsz8UpUtCH8e0iC0HXvvN7W64x
         ea0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795790632; x=1796395432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qov/vWJdi933tqkTpBJGy3o9z0sNW71HS63CMgKtbjc=;
        b=DJuP3GpzLLJGWXbEuiGFc0HqAH9biJ4jt0aFuchD2c1iRlCFlyiOKLHGQ4WZXZTQyy
         VT0pLrBMovd49nwun2zrMFIf8zcZxhwi+DOqPEBfiNQYDPSZ64pcL1nbkorTHHMBoPpI
         9Ohpc60cGVCkuWgRJT/KQXeqiTzmN/uuwXVtKYyaxDiVDkXC+TEKCRo3xm6bXEh47xVa
         bLqCyTqzuH7hwp+e3xFClcgNSf03fewsrX3136hdirnJuNXRTxKUMVvs92mdw4N4Uu6j
         BBqRwl5ORTo9eaHoI8OwyEtlYT1kb0xRfQ64yR3De2KzTlL23lxd30uDqU0+eIPMWAWB
         ggEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790632; x=1796395432;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qov/vWJdi933tqkTpBJGy3o9z0sNW71HS63CMgKtbjc=;
        b=BWhSxFWct9fvvREG88K2/XQJE2MYXdiukZYYP+5mE2ISFN48a48ayUOMq0kzsLsl7Y
         LlRLMGAg41WvLmYdf1bdMiA39P9S72Cd5M+rTz/VeXgOX6pX9NBd/tL9RdgiOfEsSbXh
         l+Taq7FMXjRHPX86oeRMmgTSERJOv19Yo7VJyklME2IvLb6A2VJ5WIsHVArUeSC9Vxup
         Tppem/56s+YNfNo2/oPnqR5IidUUqIBG/gns1fr/CXYF9cppq9i4/uB0ttVKOXmpN2V4
         6phgH9ugS3DDRzXBuPVzwF0EODWNz8Hcltx4hMm0wV8XCrKVbEG8APIuH3N33A1mwcdE
         yPzQ==
X-Forwarded-Encrypted: i=1; AL+hErHryWNlmQbVmaSzkd83dbr5RkvUZQ3yZCgltzP3XyGrOunwYJ/qcHW71C5RJQY8wQZGfmZMUUuXedc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kjD5aUIc5R+pjDd3Sorc6CyW58JgMeTshAmC7M3NYlmxv9Rmr
	MijiE/zYZnTri395v7Satg9AWo3cTblMS+6b7VKR7ZDu/IcIBakhH9hJ8czLWAl8DLdhhv2etC9
	rFSoCZQkVMc4tJiOOGy8wP+MON0vTd6QjFa92h3pWHTKY4B5JPH45QfZdtsQ8fw4u7yPGc7y0ih
	6ZxdNTsURQEUQ7zZ3sQu+j62+oKpBL8424pCjHyQ==
X-Gm-Gg: AZFdTZe0JmbIX2xWwn7qjQQA4pHR2S2P642bzN2/NF/JIQSHvrGY8BG/VQNXBXv0Iq8
	3ugGiKY19edgcBcXk4Fw11KqQOk3ouYuKfgZbQRYuJ+pQgVpOOGOc7MfoNTd7VrGIzomyahLdxJ
	ZE0/3XB/DC5Yvd2Aipjt2PyHwWkIUTMJt+bAn0fzsNNMR0L9mUBwwXgoI6bw==
X-Received: by 2002:a17:90b:288e:b0:3b3:ab75:c94f with SMTP id 98e67ed59e1d1-3b41c92a098mr23628409a91.31.1795790631634;
        Fri, 27 Nov 2026 06:43:51 -0800 (PST)
X-Received: by 2002:a17:90b:288e:b0:3b3:ab75:c94f with SMTP id
 98e67ed59e1d1-3b41c92a098mr23628367a91.31.1795790631156; Fri, 27 Nov 2026
 06:43:51 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104091731.16500-3-fourier.thomas@gmail.com>
In-Reply-To: <20261104091731.16500-3-fourier.thomas@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:43:38 +0100
X-Gm-Features: Aa3M54pZo7FzRsU8anhwNWKc0fD1cZ6meSr9t6h0-7ZseSkfhGP3uErCsIV3UyQ
Message-ID: <CAPx+jO_hrdy02Sz28JNt0vuPB_ACRp6Mf4HX_MtUV4eEiS80uA@mail.gmail.com>
Subject: Re: [PATCH] memstick: ms_block: fix double free in
 msb_ftl_initialize() error path
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulfh@kernel.org>, Yifei Gao <gyf161023@gmail.com>,
        Hemanth Selam <hemanth.selam@gmail.com>,
        Maoyi Xie <maoyixie.tju@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:SONY MEMORYSTICK SUBSYSTEM" <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX0QKs7ZJtv9tW
 RVg/nvZzLU4aw2soH7++sBuajhILT9O7Rpl5sNuvjeBen03uVyouOxF4iSTfC1OMTMQs3ae5wrC
 B9A7Vzcmam0ckctUGExy7vRw0l1aTTo=
X-Proofpoint-ORIG-GUID: Xmy3ya4N1F5qNFvTryyd6znX6G7VTjeB
X-Proofpoint-GUID: Xmy3ya4N1F5qNFvTryyd6znX6G7VTjeB
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b099728 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8 a=2Ahqu8p5lTGcgXNZxgEA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfXyPaOAPPFnE/a
 sQ7cn0W7yrZCa4PdP6iWW/y1AbA+YrSf/YQ0dbEbFFBCoUAtbbexj/elddkdovALrTY0fIvI/am
 h9Gb6Xo7wFATQorvj4EiTEStqeSTCdmzwB1cswI47iUGAeNt3ktBUXRbX+wYDsCReBsuRskvE6H
 jhZeH2ad4zrPlpZuOcUeDZWaXwo0Hh1sg3wCSkUQ9pXSlcnG+TlHrEkKcg8wKUEFDqZIn7UR1NG
 tU4K2eSZZTjWNVa0dxLfurX+0dCvEJN5WXJ8XdNtaSqmRAQ9MJMPtChV0ksFstgevrCelXo4zWq
 Fbm48BLV9W2Qh/XVD66oIj36wYDDdguH42PGoUYHdXDKIAo/0Yxak9nx+cRXmqWnhyRIkstjF+u
 ZkZ/lNJTviKn9i5HJX0wtNSv2GV1PCqhQk6ZyACWKe63yRxJXmiVYkrxsGg3YbBlYovavmjW32p
 UKEYH8BMXndgfqD+mwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

On Wed, Nov 4, 2026 at 10:19=E2=80=AFAM Thomas Fourier <fourier.thomas@gmai=
l.com> wrote:
>
> When one of the allocations in msb_ftl_initialize() fails, the function
> frees msb->used_blocks_bitmap, msb->erased_blocks_bitmap and
> msb->lba_to_pba_table but leaves the pointers set. The caller
> msb_init_card() fails and both of its callers (msb_probe() and
> msb_resume()) call msb_data_clear(), which frees the same three pointers
> again.
>
> Do not free them in msb_ftl_initialize().
>
> This bug was found statically and is theoretical.
>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_=
block.c
> index cd4ff1b79a6d..26a04cecd94b 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -1351,12 +1351,8 @@ static int msb_ftl_initialize(struct msb_data *msb=
)
>                               GFP_KERNEL);
>
>         if (!msb->used_blocks_bitmap || !msb->lba_to_pba_table ||
> -                                               !msb->erased_blocks_bitma=
p) {
> -               bitmap_free(msb->used_blocks_bitmap);
> -               bitmap_free(msb->erased_blocks_bitmap);
> -               kfree(msb->lba_to_pba_table);
> +                                               !msb->erased_blocks_bitma=
p)
>                 return -ENOMEM;
> -       }
>
>         for (i =3D 0; i < msb->zone_count; i++)
>                 msb->free_block_count[i] =3D MS_BLOCKS_IN_ZONE;
> --
> 2.53.0
>
