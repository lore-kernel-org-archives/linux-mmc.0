Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2983264EF
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352840; cv=pass; b=kDa9pR1qOO+7skW+Rc7QXyPo7BOSCeCgqIu1eU4/n4Lv96lfi5DVfn7jAB2KrvzpFREhLoFtgFD2FolKhdsB0AwmtTSkS5PV/Dx3w+I57CkB1gx6zqTh8YS+HpKAdvbPoPY/Vyp04FFDmYYIRIatKyDUZTJkU8Fy60quzL0I1yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352840; c=relaxed/simple;
	bh=ROLBZEYE5vxTY3nPfX9XobjIWN7a1URZryrvEM53uAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+IdyQkjTaGpe3EF9w/1ZMBwEQoNbtWcHfU+auOIytQ3w7j73XRg/9DhnTyH83ziSE+4KEmWG4v+JgFWWQLMR8u0K6wTHPaSPZ81scSPPlbnR0DorjE4Qs3GTC8fYD3+FVKICrc6MhB0zmt7242CuJUMvjgpa5VnszV/Uupxicw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ijaq7VHE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gRuGJA4q; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ijaq7VHE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gRuGJA4q"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFDqb809697
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0jikZ3Ymo69yXeMRA8MQ46X465mR4QTnWqJhbceHG2E=; b=Ijaq7VHEiMt6/Qzv
	5oMidvHAkR6M2CVzikiHqXI5Fe1/2NEAQejn3iN4QqIjeYyuVJrsUOJ7lDdpi/06
	3TjmoR6+OoVdK4k4B7T2Ywjy1DYFFVxhSmafM+d6vfVgzItj0ukqeli/OB+9HdcM
	WKrh/aKegmhTLutikp8d2X5CY6wCB2yjyJTv7TRt7rbeWHMxa6RpTRKf9IvJfie+
	4E0EcFhvpyFg2mQnopjttKW9sRULZ8glArZK1xyhcK1pFBSfleXqX6doGJIUiSZw
	WV7JeM8T6SpUAwGDXyWQB/j7E0CZmkm2FDpLxe8+zQU++WsBwfsB5SG0qs7Nzexc
	552knw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsa2ap-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:47:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d7886cdso65911851cf.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352837; cv=none;
        d=google.com; s=arc-20260327;
        b=RVSBcelSaMNqybLSqCSBpxLTrBgOGfOHwHrZJFn9dCZsEF6317j39swEcl+Es4o+R1
         ugC/BCSyBXPVGow4MhfxbCLQbWH7CE3ZQKWj9H7DGINWJsCCaC6Dt+b/196tRLoFtLA5
         tyopuFtwN+ZKibEq8ths++gXnGSUSVNh00e0Vqy1YHLgu/BRdl/XS5M7BbjO6Rk91xLF
         5zhVNRafexSNvwzzkO4HA2RNO1CB5sCHOiWJjHOyw7Uqn1zrtzAIucqpuhl+K8UEQSrw
         wcQYDNFtgc1MlXPhT1HaME4YFR262Y/7i+rtRJ3HAnK4t2ePBfLA1liY8I1Kdb9tLd9T
         cJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0jikZ3Ymo69yXeMRA8MQ46X465mR4QTnWqJhbceHG2E=;
        fh=uCagoZ9gv4I7yCkEJ66tQwHN6GHOKaIgvXVNG4m2ff8=;
        b=N6q0eVs6gzXkkdnUXSUonkAN+v826D+Bad9F2diLHwwVC9uW1OY8aFBCa8FMCVkAot
         66exwyUzvV7HcssCMJCLHt6sgl0WKUBKoLTI8oJlXyY2g8kH5CM/eZrGhI2pb/ikGVdY
         QkA63z3go81IK8yk8p8uGrIU7l3JurFQinaEf+bMr8r9XnCs1Sr+yiOEd9u6xX93qH15
         iapfON0HhOczNdypAuseT6/+AmbzsrOHAv3PQQAMVOe/1sXPYEuTV66fr17far1WS23b
         p4e0vTxhKUPmDXJGNfDOHWwmxjs7vjT94HqRTOm3tBVKpCJI2NWMmsACmf2ZZ9Bq/p8z
         MasA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352837; x=1783957637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jikZ3Ymo69yXeMRA8MQ46X465mR4QTnWqJhbceHG2E=;
        b=gRuGJA4qFMKTCFAcgUumrHAEpkuYk6IqU0EsI/HiKm3Q3urumhRWG/ZNZ2WqTXFlnu
         zgUbtA+IOS2LktqUX44eWkbZsnNCbl8SCFncvn/mKj+4jAdMNh/AmdU7E4/vh/nlGQCE
         CJix3EJI/YmoqNwG9CEWUioxGlfSYqT1gIXO0WIpuzLXJZPKiZaa10lr9F8VX1eH0GRH
         03FxS67Kd+zxDQsyDXvsQRbgkFuoXvDOUYQPrrkjbwM12tJ9JSi4M4Bq6xWFL/m9B0zT
         zolYYkjUrJHFKoVU3M6R46xPBlvrWrSFSXOd/VAr8avwlVsplTLO4tdSfaw0lua9vtA1
         i+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352837; x=1783957637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0jikZ3Ymo69yXeMRA8MQ46X465mR4QTnWqJhbceHG2E=;
        b=OHHDel73bvBbCexnYBVaw8ouP3rA43JNnqYBrgt5qH7wW+JqT3IQYV7cxsoFiqKGZJ
         b0oGuxQTwR4Q2DRsq/eQneRHDJOp8Tt2UaiwB9EykEBXk4vi1y4+ECliWzgO3sl20oLl
         CzVZ3qpqD4QMpbfpJnKnWgwOhDNZk6G7F3iLkHU4bS4LwKDQU2dZ3/ouWpkUarzl2xu3
         uayIZQmukh8YyUMA8rBoPNW+xBchxdNTC5pS1zo7fAM8f1ImSaUmmPtysGYz3MkwCkvp
         ZqChuS0r2TisYDWUj6J+TMDmMslF85TAuXfY9Wf3g1yVlw2+HCbV9e/7aBIH4sYNayg+
         e12g==
X-Forwarded-Encrypted: i=1; AHgh+RqXw/k/Ik9t9UBJ9eETn6hA+grDoxN/86rKRLJsSvEn7a3OXimT2THGjW2z6FXC3iIjTJBvbdpN/Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtCiXr8ry9DZ8rIZyd0QW9mqlZkPhuzDtZvfDh3UCUWvHJQ2h2
	DqR29Wqv1Ivg/Ue/tdmPzu2Fu9NpYwRjRM8oUrXruh2UsT7CRO6ojxlOPV2d9GVhLbtOuUAbHqq
	AxwDBPmHZNVfGtj6hTmi/EkGdTWcw4fxI+tRSUV/AmnyW2t53Us5nDXCOs4pJXOyRg8Ov+GWbar
	d3RisRwLgQUhkFjF2ovqSdYk32DZmmva7v7rRirQ==
X-Gm-Gg: AfdE7clVzFeLf75oVRLZ7S9+9QtUtN5o3RzWFEOz4BA/vTJtREWb5OpnzgTIfQRaLkw
	9EtwgHvMKFEFGIsb4aQTpBKeNmBsB6g537PSMYBxDhD2F1BRRK3wgDcwFPjTosYKBhSa63FsHae
	U6qAg48JLn1BmZPfpnWKCf0lLd11hoSzeMhO85r6v4gL+NMZgU4ETyoKey73EXiNp33HeC
X-Received: by 2002:ac8:5f4b:0:b0:517:5f04:f24c with SMTP id d75a77b69052e-51c7486a883mr12597771cf.39.1783352836528;
        Mon, 06 Jul 2026 08:47:16 -0700 (PDT)
X-Received: by 2002:ac8:5f4b:0:b0:517:5f04:f24c with SMTP id
 d75a77b69052e-51c7486a883mr12597281cf.39.1783352836087; Mon, 06 Jul 2026
 08:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622145036.513129-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20260622145036.513129-1-ben.dooks@codethink.co.uk>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:47:04 +0200
X-Gm-Features: AVVi8CdxB4f0J770ftKfn13KGpUeOdTUqPNc6o1_HATkdwT6JnE7nxMy7t83S1A
Message-ID: <CAPx+jO9w_v+hFKMzoeeazFmphOkD1M3JM34BjhbPq8xmKO4bRA@mail.gmail.com>
Subject: Re: [PATCH] mmc: cqhci: fix to missed endian conversions
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: uqFA5tTeBJRt1vJJ94xVQbtdOUSD4Oop
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfXxECcGZ6xI7e2
 A8jmPeRwQAPITdiUTk66AifzZzmDrzTPL4gk3pD0ewkzx7PU/xpk+oBY/5M1ZyTK97EddX1dYWs
 GCHJXtEcs6CXIaoJspGt5gLmipp/uYkFT4g1vfB2lltWMwFLl/DdmF8WCBN3L/94nL+hk5kXnFt
 AdWNMZucEXkND4cVyCUoyzh6O2jbKnGvhHSCanZXU7zw1gLtaQlYOkuABPG4sNL9ALdVaKeeAG9
 j5mPtMnE0vvBHCL03SKePb/D8lE41YipkLr2cu+W7lHm8XC9NqcUZqrd89R0Y2YcvwLw8Ok2QQt
 GgKHXoWgQDle6LivBykJhM3EP4mlmEM6s0dpaNRp0eaO04dFG00oAX2RWA7jNt4UzXC12KQOIqm
 x9Y764RVz29AW8rois+Pf0tlbyH9nRN+GslJ0PmpMlfLyH6qhhX/ba62vPgQurLM868MJNvUsum
 eJT/jEIAIvkFrzqHMaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX75yPIZ2QjsU5
 fdgwJMYhUe25jv3MhgQhS3XWg/Xlr4B2OZqfL016W79LdFuHsvV1H4kEMvUU/vHp5IRlYyTm912
 nqSZj0mU0XsBpj1+2DZNKF+Cxg/KB4g=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4bce05 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=1EsaE_6oAAAA:8 a=7ykj5hz2VLDXz9oXxOIA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=3ZumFrijQQ-2J9H5h8ct:22
X-Proofpoint-GUID: uqFA5tTeBJRt1vJJ94xVQbtdOUSD4Oop
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060160

On Mon, Jun 22, 2026 at 4:50=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.u=
k> wrote:
>
> Fix two places where the wrong type or conversion of little-endian
> types to fix the following sparse warnings:
>
> drivers/mmc/host/cqhci-core.c:487:15: warning: incorrect type in assignme=
nt (different base types)
> drivers/mmc/host/cqhci-core.c:487:15:    expected restricted __le32 [user=
type]
> drivers/mmc/host/cqhci-core.c:487:15:    got int
> drivers/mmc/host/cqhci-core.c:566:19: warning: incorrect type in assignme=
nt (different base types)
> drivers/mmc/host/cqhci-core.c:566:19:    expected unsigned long long [use=
rtype] *task_desc
> drivers/mmc/host/cqhci-core.c:566:19:    got restricted __le64 [usertype]=
 *
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci-core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.=
c
> index 178277d90c31..00614b500b2b 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -484,11 +484,11 @@ void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr,=
 int len, bool end,
>  {
>         __le32 *attr =3D (__le32 __force *)desc;
>
> -       *attr =3D (CQHCI_VALID(1) |
> -                CQHCI_END(end ? 1 : 0) |
> -                CQHCI_INT(0) |
> -                CQHCI_ACT(0x4) |
> -                CQHCI_DAT_LENGTH(len));
> +       *attr =3D cpu_to_le32((CQHCI_VALID(1) |
> +                            CQHCI_END(end ? 1 : 0) |
> +                            CQHCI_INT(0) |
> +                            CQHCI_ACT(0x4) |
> +                            CQHCI_DAT_LENGTH(len)));
>
>         if (dma64) {
>                 __le64 *dataddr =3D (__le64 __force *)(desc + 4);
> @@ -542,7 +542,7 @@ static int cqhci_prep_tran_desc(struct mmc_request *m=
rq,
>  static void cqhci_prep_dcmd_desc(struct mmc_host *mmc,
>                                    struct mmc_request *mrq)
>  {
> -       u64 *task_desc =3D NULL;
> +       __le64 *task_desc =3D NULL;
>         u64 data =3D 0;
>         u8 resp_type;
>         u8 *desc;
> @@ -574,7 +574,7 @@ static void cqhci_prep_dcmd_desc(struct mmc_host *mmc=
,
>                  CQHCI_CMD_TIMING(timing) | CQHCI_RESP_TYPE(resp_type));
>         if (cq_host->ops->update_dcmd_desc)
>                 cq_host->ops->update_dcmd_desc(mmc, mrq, &data);
> -       *task_desc |=3D data;
> +       *task_desc |=3D cpu_to_le64(data);
>         desc =3D (u8 *)task_desc;
>         pr_debug("%s: cqhci: dcmd: cmd: %d timing: %d resp: %d\n",
>                  mmc_hostname(mmc), mrq->cmd->opcode, timing, resp_type);
> --
> 2.37.2.352.g3c44437643
>
