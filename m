Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D639B943
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941952; cv=pass; b=CbDESTkzdRon5v83XI46JnIC9AoTK4dp/y7wkBn4xNDLezm0AnNRHdJpWdG6QPbX23cMcR90D7zZU0gZippOi2+WOQyX6hVb25TDAAeWAWbRYiKjVmqJtigVR8xp0EwK5vUR3I1byxmPl/npGftaEFzxBFmdwuwGPml0FngbOv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941952; c=relaxed/simple;
	bh=ZRGoY9q99BR8Axa+S16hc0vxzHUMhRSz/trmr2E+FKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSmj9Cvfjd0IF0VuW1JCj31IvDJSIsKNQ65DD6Dq57ede3Y4Znp07BU0ntuDd5Ddmk2+dlC6du88VW6NHW4cwxFBYC77QhXtYoK6W72wXT7VDN4eI4Bfpg5CMghg0oQ87Bxm41TgYzyySfQfcjbxtDMpT66hAYtZsIp5MwBoOjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=glaNHVX/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g9G4qzjk; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="glaNHVX/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g9G4qzjk"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DAbbaU507347
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 11:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wmql/FzFonHQgDxSHyUiWckSb/PpQbz6mJOTjLyUE6A=; b=glaNHVX/HpOXHSH+
	zMl040MnWOmaaS0o7BZOm+v8KUabPlGE+zHqBIc8fna4JpbR4edFHczh2cn9M3Z/
	iD+j+rnvR0XVjBoWuKntIRkrFwgAaIpjUxeL2aumZ7BB7SDN6PaqLjlxxW0L+/ll
	dK4rkQ4IwHVldWM0VKQvl/EEnQJbRMo+dS4Ouc8u8tG3KpDhYOLqqT/qooyXj2tg
	lNo6yLPQ0geChLNEwzmj/VqZLRjrhbFP0RyLGseNpwF5Kk0644NZLrFfsPWWfs3v
	SEiiItj5XyvfurDyjKdEzsnqrcn6F37RXL4CKqB+hlzdMgAQ/H7bRz91593WuSD4
	wjuGmA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8h81b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 11:25:50 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f0c46bfb6dso62696546d6.1
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 04:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783941949; cv=none;
        d=google.com; s=arc-20260327;
        b=fRBit36RkS5WWFVWK+LM9xt1tNveqXbFsjBZ5LsC+pHEnLO/EfHIUWDP/uUze2Pk/k
         Gw4minXLMovEdrzyJOkWy2Yz/SnXCKGxok4urbG86YGz9E1skCIdY7SYIofnd0dvqY9B
         x4uhOPKnUIiKpKyp6HmrItzW48BQrFqHesIhdbv7UnaKuS2v4MmalJYtBS5DDJdif2Hk
         lcoN5GFPgCVeRKB/fgKZcGZPXYVlWIG0mur9Q66WMAK4s7zVBIPlZaLhP4bmfp0mIphs
         H3s/yjSE9Z4wMC1ERJPeegqT7CAtgGC6+q4Sh4ZtgKAVjgh11BNmKRtUGGQUPRm42IEO
         9HfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wmql/FzFonHQgDxSHyUiWckSb/PpQbz6mJOTjLyUE6A=;
        fh=gKBv62QlNbVJpsxgsZzaqwtGKLgljk1NGYQUWd+K8jo=;
        b=MelPwZFyU6kLLD10RYZiUM9byz/F+BPpLC1mboOp2z1mip30TyqnuXV3kUo3C2fu7X
         Wz7YFA8U+5iYrJMNBf20XQq6KFPkWALRR9HTqF/tIS608xqzJTDy5UeWggvHPx8WOjAc
         JC4BH93TUtat19+LKUfBno1zgsJZHuQskQw/4jtQ8bR+4LADNwNzdMeFj6fExB8Z/9IT
         7QnpAoQFf9C/Bl1tD8cOkAxOIe9VduoNoen1M21cJv+khvFnBxX+Lfk/yYzD216Lgcgy
         RlkFpKikx+khp4aWa7DnxLAg2E23jrh0elQn//EkK8waTn04C1xiTbW/QOU5drjbQqlE
         /9rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783941949; x=1784546749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wmql/FzFonHQgDxSHyUiWckSb/PpQbz6mJOTjLyUE6A=;
        b=g9G4qzjk5o1jKUh45m0wkp3yNnypa0ZUOhWjocwXNJGAOXC0w5rPk9wVYQlb0gK8y+
         aIHxoUmRW6jvl55PvVlrzcWx9Vdim/3YaMh+58oChIMV29s9UZ5N/bXahMOXeMN3AmBE
         ZKEdgjKR+9nQnG8sB6yWGJENUnqtmXZ7mGRwh4Em7PgzIGSMHtez8bP2S0ayGhHyaM6B
         cQHGx8Uctz8orn2c3xjtQvXr2W22Jw1fvEx8rEHPJbRjVxneS6nm92/jBEl9fcqXfmcG
         sKyR88FBlEu1Enf0aKRnjhY2UfsIDDefEl1ukkKLhi7muaOY5jrNwx2+yq+Jkc602oJE
         XZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783941949; x=1784546749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wmql/FzFonHQgDxSHyUiWckSb/PpQbz6mJOTjLyUE6A=;
        b=TYOMcvulW7hHxx2o9069lr2KB3RikZHk/u6ioXyRk4IFKgZtzMgafEvuPPhyk3orPz
         mw1hdS86B0j5mA0Yp04tspI3Bv+UagzPHGNU/+rLHDTc12mmRicuBkfutN7YUtdtqYwk
         VyknxPSbCWYCi/bmd6Yf5M0oB1SfxzSpBq/DZqlDLAtx7UnfjsmyQmKO4a1Hsakdr04U
         IoEMe4/GP96/Bou0fLgYT7QXwuhS3sHsKW2uPYkOTrKdWc8zLPwJYHcmCLWd1hF3VMsf
         upbzXSSgExy3OSlhbzeGnHGn+yU1ga5uS54pDBx+ev4Udet4PLIWcMc6Qw0jO5gJjpxf
         dhLg==
X-Forwarded-Encrypted: i=1; AHgh+RrbcBlGJQ9g2aYMCeDWCYYq88/8NgbTep0haiVbJXfoZYYEmlz+EkVqdjzcyaDcohsb9dqfhGz45kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEhBCnfAbIbmxpnb8zNNcRGG4m+kbtj8X7eWhT0zWA1sl2/99+
	t6nzNQFUlmzLKgITGtQ0/4ZXhxniqopqsIzyVSUgPWE1ZlF/mSu72LMw99fWMgV/zikW08qVHGn
	136/e56lYK1CjuDmpNBpFPgJOij3VPaOzZIppCdLs94qVrlTMwNonrJo6RzrquN6cCDpdl7veP/
	x4pmLZrhFwKDlwqlI9Mis60uK9oh+SHAa+oaz1M7lkyg5rmA==
X-Gm-Gg: AfdE7cmV/NwutMway/T96GqyUbxstnIT+RQ0XQrgMK46RgVqal0Oe+xOb2VFhv53QDV
	yD2NeUWyKYNbpmb3tCzpaMAG/7xIZDvOD5o4bHc/ZVQ5oso0dnq0BmJTTRcMZmX/ihSRxi95qye
	l78CmwM6R3fg10pAbUO2zC9xZ8rxInIDNDtKMboqPtrbpKaxfY4Td1R1ekG0kydYMURqKP
X-Received: by 2002:ad4:5f0a:0:b0:8f0:2fca:8246 with SMTP id 6a1803df08f44-90402b6bd86mr93792506d6.52.1783941949308;
        Mon, 13 Jul 2026 04:25:49 -0700 (PDT)
X-Received: by 2002:ad4:5f0a:0:b0:8f0:2fca:8246 with SMTP id
 6a1803df08f44-90402b6bd86mr93792346d6.52.1783941948958; Mon, 13 Jul 2026
 04:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710161254.569883-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20260710161254.569883-1-ben.dooks@codethink.co.uk>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:25:37 +0200
X-Gm-Features: AUfX_mzRQn22JQOKwATy1sxrUjGLvp8aQQY0JOw-Ui990Kn-Cug7L-3BDHCGsVM
Message-ID: <CAPx+jO9sjDisn1Dg-UhzMOTy9wUVw8bFvDqmbkhF_Q=btiKj4Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: move declaration of dw_mci_pmops
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: HBCsfCX1KWbUrbKOUTEL00mjh1L_Ut_D
X-Proofpoint-ORIG-GUID: HBCsfCX1KWbUrbKOUTEL00mjh1L_Ut_D
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a54cb3e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=1EsaE_6oAAAA:8 a=85MDVHd0U-6iORKUYm8A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=3ZumFrijQQ-2J9H5h8ct:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfX1aCCrJXOCKG6
 Uze+SKfjrz8e0mxiijRkGnsRBbZYPFrZ/zbY6AeWkSJGUMuuSmh/+lxtx7y8WUJ/fXWwREzG/GG
 bWJbNKAWkb8P5hSg3OqrWr3lQxbaewI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfX1K85elGj5RTA
 EXaNzsN7BdZCxb8HPn++aOn0wdN53bUmoSrd9LaxwEmUoibq61RRVkkUj2CV54t9EYA7rQLXdQN
 wcVhVGvrik2DE8WOmh4c3tYOc+cFRB/MTem/1jHujG0UH0Fnok0KT0zTTRbn+VUklajH+h6qMUR
 FWlL01I1rJz2eJ7aO+IK4sN8Izz4vCveGB2x2244YQ03zok4xRkUAPAJiv0lHBlPjXMPmOK5slR
 9k0Mdm6/dP77oeN70yeEyIkwqd4Z6x9Oi7h7JX1tFotBgbPCSqLME2d9u8qF3P1fZaQf8e4uxi2
 qzg11N3jJ2wm4rqcms2Y7zzqCTzMUvbdlQzPDHzXECrOpqvl54oX+mQZAAFZ1G25XVg+t0saiC6
 wkFO+8wov1euRA0FDV9ATmJF6cHxhc10JeR2czKZltSrAGi4zqQT3o6KdLRGx64jJyyRKwneKVu
 Nv7h2U0CA51+0Bi4HRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130119

On Fri, Jul 10, 2026 at 6:13=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.u=
k> wrote:
>
> The dw_mci_pmops is exported out of dw_mmc.c so move the declaration of
> ton dw_mmc.h from dw_mmc-pltfm.h to fix the following sparse warning:
>
> drivers/mmc/host/dw_mmc.c:3512:25: warning: symbol 'dw_mci_pmops' was not=
 declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2:
>   - changed to moving the definition and re-worded commit
> ---
>  drivers/mmc/host/dw_mmc-pltfm.h | 1 -
>  drivers/mmc/host/dw_mmc.h       | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.h b/drivers/mmc/host/dw_mmc-pl=
tfm.h
> index ef1b05d484c3..f3193662abf1 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.h
> +++ b/drivers/mmc/host/dw_mmc-pltfm.h
> @@ -11,6 +11,5 @@
>  extern int dw_mci_pltfm_register(struct platform_device *pdev,
>                                 const struct dw_mci_drv_data *drv_data);
>  extern void dw_mci_pltfm_remove(struct platform_device *pdev);
> -extern const struct dev_pm_ops dw_mci_pmops;
>
>  #endif /* _DW_MMC_PLTFM_H_ */
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 9ffcd3946cff..38610c89d54a 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -19,6 +19,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/workqueue.h>
>
> +extern const struct dev_pm_ops dw_mci_pmops;
> +
>  enum dw_mci_state {
>         STATE_IDLE =3D 0,
>         STATE_SENDING_CMD,
> --
> 2.37.2.352.g3c44437643
>
