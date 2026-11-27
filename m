Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790621;
	b=2L7tWwQcWiIfmTFyBTo6pDxS25FbSbSv65sxCa8La6lk7ko0ANB4z++FaN69udp1y4//
	 t3akRmPoxOD0FVRF8OrH3B8ZwIdAX8mk41LR1bIqxmhN5iUEn9AvAcwDEaFJOgpg2uae0
	 SrR8FPeWAj+gb3kmEyL+JRxmVSGc/QqUpDnKwO8j1ziDxT0fmCAnwdN2n/8+MU6szH4/h
	 XYtd4mYmH0ikt1V2aQhbxTJO0u5gfWyqEs5+7W7vVH/wdqM7iuF89E7wQIF0AbQRigIJa
	 SAk19QXmiRwh8SfNi8topOCww4K0pqpYwS/vPUo4n7klbxzXPS6DO5b/7OvbsD7dVKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790621;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RRK9YDLFBZXwKuXQtKu/5tdjSq98zFs+D+5971VO7Ts=;
	b=1YUYdtdlsp5X7VI67l2YJKtHgzqfuJd9LGJc8YFy2yjjhocn4pFXKA6t9farwiaGvoyU
	 r36jdHY8HEg7z5O+vO/A20+DGKRK50ela9bzB7yzYSw1btoDgEccJldfdwurBgiRRXQIB
	 d0HlpaCmwGkckANSXXkjtVIpjPtVl5fuPJ0cFcLGE1zX8w6sj1rTlorVrbrb5m+JXS104
	 qrMI74u9pmSmsMSjkA8CixXJ6fiEJHlzNpIGQoqfokkAcMOgM6GJOl9CyW1SZ9ef6n9Pc
	 8UoVyj+t6gxRdQeE/5Rqs+lRKVANg8Fh/AYScTfKh2hTE0/hBCMxYA8MItGa7gJhPPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hqqAxN0G;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ive80ljp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01C606A31C
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C01C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hqqAxN0G;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ive80ljp
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1Jb72683930
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RRK9YDLFBZXwKuXQtKu/5tdjSq98zFs+D+5971VO7Ts=; b=hqqAxN0GNzYrANOV
	N2LnDp+WhRYAw5kO2qoaodHMWpgO1mRSPdHr6G4WTJr5xKodB9R6r09G2H4x/iqE
	PnyZsab4IDxYmr0fxMvAGWKx9GqI5zzxccRRLd0p4C6/Soqs8dBhPFfgRXvUMc7Z
	4V3Ck2+Z7aLypxXvpTLf2sDY5GKFou7RenLThyN+AFu2KnWq8lMuilTB9U06dXHf
	VXyhsr/dwmTe7fzQGf7UvGCxTFwUEWo+mixbwtNFIxcRbedlpKm+6A6B0G/FkSsX
	X+7ANsCnk0zfTQgnlSwTHDSmiBCXJoNdeNdulwyyXatOHD8AroEeHbqvjdzlkMfW
	ooGJpQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhj3cr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:39 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b40b011aa4so9984140a91.0
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 06:43:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795790619; cv=none;
        d=google.com; s=arc-20260327;
        b=AOKKnQ9l8ViOztEk6pPASK0FEMPVaeLBNGkweJ9eb1HEaNeGB96rGuymATC2Am/IdB
         3F7v5kMRZrDe5U0V9w5V/RQMnq5ctqikCxpGfQk1xW5Go5qWwpb5G24vIRjTTXSqH1tu
         rDomzKSzAgexxbZyk6c32HQFs44jQdCZqz8bXPzLq3PZ2K+1M2mT8uMNL7fJddwzYljs
         m8ZjU+tzg3p7V85XEkmA/fL2W+rdiI+y4Ukn4QzedYZArGirX2qA71ve9QpZn9ecuIGy
         4B4qumAN7RW9Ld2aZP4tCrijHxElf70Vsvmimd1PtwX+fiqcWaEKyfOU96bb9a2jlq9p
         XPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RRK9YDLFBZXwKuXQtKu/5tdjSq98zFs+D+5971VO7Ts=;
        fh=VPhM2gQVaGNhuEuaNcr7tXwdNffK/fMT7f7KeTs8yUI=;
        b=hm86xeJ5gXwRs6hWaBJgIgdDrhKVVVeCGNlxTPGTNgj8RjQoXq9zeJ9Bu5iWiD9W68
         JQWiqMFsUMQ8e3ikozcMlrUqX8JBNpniGKdtqmtk3p1Sz9szB9pPJexpaib8GC/qRmGU
         MIHE1g9xn/rYGce+oYzE+ppIeQPCh43nhjDvAvIbWBULXidIgfq9aDkDkDVnWSY3P/b7
         1IPRmltqz5Ao55hUV96wIo5TQa8npLo7PupfIzdxdCCncnzLiKRpuKzW9XR2e1ktOReA
         mZPXMWKpMhxknUPBiDbNZZi43fVB35AXj0fSdA6YKqGHWvo0OoyQHhRi7Xx31rY4ymGv
         wzqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795790619; x=1796395419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RRK9YDLFBZXwKuXQtKu/5tdjSq98zFs+D+5971VO7Ts=;
        b=Ive80ljphiblUd6oBrSDkkQ4Ujj+O7m1A6KYZfCqm8isuPE1D2SomIvANEOHE+vK+d
         mhuWn6OT6I3yKbjAGNsoEL3sxBcgZB/guqEV3EvRjmXGcNPDHNOlBSoQ2S3YGdrLMW9B
         6S70TD8PGZMz9hclf1njOAvGt1xl315sSiDAOAXG4bu9wOSNTfrll/quSk/ZPIpr97XD
         oMojht29XHNS91l+byTSsGC//gQsWJaB2brp3HkQLzPr6pVVsHkr08ecbhYXZ6NoZJQ7
         jmL2PnZL5iiiSjX/o4wqgfuYLeJeEMEwl38sJkwrz+Jl9tTfTYrZwaFI9vfkpe0ES0uC
         YZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790619; x=1796395419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RRK9YDLFBZXwKuXQtKu/5tdjSq98zFs+D+5971VO7Ts=;
        b=qGkJUT1qCiWy1iMZkj6yFSzuoSBqbmHFJugeozBpPBLavEl/5D3lofjtiCiphG/fv7
         DvmnpscGj4qCaLz1HkG1XWH32S0XiJ84Fdgi6oxFbnxaaoc56DRKYGaDq53WdsCm8qWg
         Z1WQjLMpYvqtDcv+CxaTqVwppIpx2QX6qRJlBEpNDDTw0RKAHlb4BHYLAqeMXMIZ7U0a
         bUdMCYTK8xDlxj3szN7h+jqMa/ua413dxkcdrPARVHVW31j/B793c32qWrxZHnqmnMPg
         rdoXxx2tobkPKSxU1lpp9ud8cPvC28qa9fTtv3ANhEAzf69OS743CwZYVD3OXOdfuRAf
         9gOA==
X-Forwarded-Encrypted: i=1; AL+hErECpNoE7F6Lm0zqyahFNdCy9YHTXiD2Iims6uPi1LTS4RQ7MmrOf+OPIB7yNWS/nY7K8JphykBA4jo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/y8tKbtolPcT7YZNnaLthXhrcy/ai3v+HnvdXynv3txbQ0qOIy
	lRUKfUtD8xxaJN78WBPakEoJONAXtO6dzJLkF9mNR2LK8tzZlJwuDL53txmlGPU38j3sGPjFD/H
	+CGckrG3ptNE9KKqLlVIIYj69S2MR10bvqGmCj9gTd0iy9L54+Wxxjtp/QWTCPNy+MlHR7zWKLx
	1GAeeolcY/cBL4P1z7Gn1wcUTkSaQXqj2xDbdB+g==
X-Gm-Gg: AZFdTZceJnHu4/bvg4zDCnpTZhnmoMT/8xFuIH7cQht0kJeCrfCGkyJxqR/M3p15Of6
	u4kU2sg5oPbKyU+ME2K7IyJuwJEJWjUiisH3hmaR1xy5EHlecz8zTwQaggaxP3P74dIRemservz
	C8zQLVXcmMd8Lv+Wjqu4BlNop4ppA9uLIQte2kfeNjph0rOGsGP9uQOVeyvA==
X-Received: by 2002:a17:90b:4a47:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3b41c8fe84amr25941786a91.10.1795790619029;
        Fri, 27 Nov 2026 06:43:39 -0800 (PST)
X-Received: by 2002:a17:90b:4a47:b0:3a8:9d0d:ca50 with SMTP id
 98e67ed59e1d1-3b41c8fe84amr25941754a91.10.1795790618594; Fri, 27 Nov 2026
 06:43:38 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-db9e3c75b3-memstick-1@mail.sdu.edu.cn>
In-Reply-To: <20261104-db9e3c75b3-memstick-1@mail.sdu.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:43:27 +0100
X-Gm-Features: Aa3M54rAfwIYDABxWCNYEdkvpiiKvboY2-gyIiFTT9Xk0nwjfgKFrPw3cxJtvSk
Message-ID: <CAPx+jO-e4iQtrziy=MJ7zbTRbvEJzQkrU=31J-L1DSKVj1_aYg@mail.gmail.com>
Subject: Re: [PATCH] memstick: ms_block: Fix potential block buffer leak
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX3FyTMVH6ymds
 XC8whwjs8LiaWYKzJvKQ6mZNOSAuyNLYk5+QGHtBqSzvNKSLxMY4oPsByPOH8ezL8ljjoOjnMsK
 reb2wJU1vP26qkUiZGiW8ljavIp9QEA=
X-Proofpoint-ORIG-GUID: o9Bv7jcKzCczKGsiXRPDqEvVU3HwHKK3
X-Proofpoint-GUID: o9Bv7jcKzCczKGsiXRPDqEvVU3HwHKK3
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b09971b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=ZXBGRh9IYtYWsRDO8FYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX3AnzJu28gl5a
 b6VXJU3STnAS6kIREwGbSREIuk2u32mZq9AlqXXTFASs1Mj4RAOq7IrnfL1zte4p58b7nbp13qD
 Sw0GeENYmsQf80ABRdo0Whm4BftCJvgJIBx1prEvxUX3OBEJY/Gfhk+eHKks/ZKuEmBcaqXEzpz
 Gxpv8zKTTL97f1G7LUEkGlV3Wk6xB5qbya9Z0hohcq9EZhiaRNL7jnXl9X2Jq3jE+htBM/DzzIu
 Fr5UrPbY0vdctlCfkX4x5Iy2l2PIa7Fi5lHT6yNn+ecfKxL+9U625NkArnUXQJ6IXpOEWYQCuG7
 TIIelB1RNuLYS2gRN6h8HfGuTQQe+ofPhowsgsXyOf/Lt6gjpUuhtUC973PUea/fjTNXGgHEfYy
 HB2KXaEFT+6XRZW5cYhgaoormGCUDTl75Q9KuzbC2NiQaMnjIm665tQoNbEt8KgH7Y5qfE/Jrrc
 lMuzUQgSAHTphhbGUIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

On Wed, Nov 4, 2026 at 3:33=E2=80=AFAM Guangshuo Li <liguangshuo@mail.sdu.e=
du.cn> wrote:
>
> msb_init_card() allocates a block buffer, but msb_data_clear() does
> not free it. The buffer is leaked on probe failure, removal and
> when discarding the temporary card state used during resume.
>
> Free it with the other allocations in msb_data_clear().
>
> This issue was found by our static analysis tool under development.
>
> Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Build-tested the changed object with x86_64 GCC W=3D1, using defconfig
> with the driver dependencies enabled. No hardware/kernel runtime test or =
full linked-kernel
> build.
> OpenAI Codex assisted with source review, patch implementation and
> commit-message drafting. The submitter has reviewed the changes.
>
>  drivers/memstick/core/ms_block.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_=
block.c
> index cd4ff1b79a6d..d62350f9ef5b 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -1953,6 +1953,7 @@ static void msb_data_clear(struct msb_data *msb)
>         bitmap_free(msb->erased_blocks_bitmap);
>         kfree(msb->lba_to_pba_table);
>         kfree(msb->cache);
> +       kfree(msb->block_buffer);
>         msb->card =3D NULL;
>  }
>
>
> base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
