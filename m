Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A750420468
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122306; cv=pass; b=tKZQW3z2kJhRRm4oAYYbgKb3cvGcIUHy7IOfBhX6KZjrysz+FN2uAKJZlQUyQypnNyUyWgo1TqG8JLirHSuYm74mLyaTejMvWCrTr0FfKGyHq4/ohYtdI8Aj5uN8w3qnp0kwM/Dd8VTnvQ0+e98sOH/c/wSj4vLH13DABSByBBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122306; c=relaxed/simple;
	bh=82a1CIjVaIoEp8Z3hlY+sGoH6EwyGXuwBgU9dhpGj2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAkL3QRT7E2qref2zUOcPQTO2BYV1u8SWyq4loxjoMU/+ld052cmDe9wg9t+HADjJ85jrc47hd8f3LuNDFaXai5Tm5czGFrjOrtnoM3JWQ4o8wTLnuUccwGqw8dC3nhQ+fsbXV17mSy5aND2aV5MPJdloCOquo0Nr+BnN+0K9Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=odGhfVEA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AavK6pzz; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="odGhfVEA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AavK6pzz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7kewh3844948
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 10:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	78LESa0xW9NBZFerb3MMp2ADRFT+Jxefko8V+gPB56Q=; b=odGhfVEArhT3oTpa
	UNv+g79x1DkOPctvaXy3KEOs2HMRh3DrAY41VjHuQi+DpdBe2UVJV/JUmNMPTXuJ
	oytpwkY5BJLf0NfjAK8oD+M/2C3OIKib2rWeYBX9sFdxPGnBOkuwMm/jvaBEDN+1
	huGkwpugBvGLBe5MSiFI496DPm6OmyszblEHo1vJKTc/197Qc2QosQble3BqW4Yl
	eC7e1C9hhsbvQThhev8tFgvZLcdH+297yMY0guLDgSG5FCBgtNr3B8lVqtRSmT+S
	ipvcQ/qbaCc+ycxFAyM+K0X2foagbU9tGfF5X80V1FUgD/hwreZecdTDdPgg6/Ii
	gcvksg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm5q42d8q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 10:25:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6f80c76e6so14390795ad.3
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 03:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789122303; cv=none;
        d=google.com; s=arc-20260327;
        b=VtQWHF6LtV89a1GKRIzxDOodUyPGdqQUW9PLd1dpt8KXworyYVp68kXEs01xip6ria
         0GGJ3NjQI1STDFobQTZnKF9ygE/E9hqpaKmBdrs4vGM35IEphf+7KmxWg/nSjVNYYhEu
         davFTjN09rauH1/gEBvigQ9+tkefxWWkfmOQo3PcoD6vxq/l6ym9p2kCiibQNBH0AGXV
         JH7AwLV5ndvJGvmStE+NMFfGPgb4JH3lV/iQXr5YeZVNpRhkAl8caTtUC9aMWPgzLd99
         27CtqKJdBi9/fkbVpKOUhwSGA2UNcg+5b9WpXnPwFyu3WNtWutjJPiH8dxyZYj8iE0Ae
         O7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=78LESa0xW9NBZFerb3MMp2ADRFT+Jxefko8V+gPB56Q=;
        fh=89Wq9AC31HYX5EXGvATa9C8NUX+KrWN7YqzhZhOsdhc=;
        b=KnjEj4GGaEzxRpN79o6g9e4uFa1PJevOd/XHjEEWuKIbCnAESrQUavs1BuCCxOUqFt
         pUGPaKZdjaE0U0Ta0O1u5EwQeF12iuRaxh1irAupKMwCwgcCQpPHY5FdLQ8bA9GCvnYL
         3vgQuDCJAhxEZA/PIYvYgSyVIE5pzGoPA6ZBi7/HhlXaG1iPVN8yCxjs2nto+M+KojfT
         ZVaep4JhfyL5G3xEMnkS71/ec23z+UCYDLmSqzulDMykDQjDoO4ldD4lF6jsoZ2NdT0x
         lbV/TbVgcc5Bcc408PoORrVQ7FqvBNRxPnm5rXJ9Q+TUX4DOYgE6f4gKqgf5oO6ZXavV
         9dcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789122303; x=1789727103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=78LESa0xW9NBZFerb3MMp2ADRFT+Jxefko8V+gPB56Q=;
        b=AavK6pzzb/+EtWhbcPeF25eA4BeXcv7jjBuGEW6VZ18GNX9Y1ztZ7FBIN+hPV01tGV
         b0iT0My14JAuUxVdLA/qpxfn7Ns+ibliNeOY7uhVf05Wl5jJJpTjEULWpvjwRnnZ01Mp
         y89Z/5siom8Dv1GbxdgicLOrSgsk2pCn9I4foTUiJn0EBagMJUwT/j2vQPrz5u5ZDwg+
         dtORApbs7IZyqUcwB15FYqMbzwogXhI0z5sKPhsv2DKJjd6cv57FzKBqgt/UtvQ/alBf
         O+ARLyihONYWnasttkxaZvOvc4RgE2cenL3VSfnMZLcWyR3I4xIU4lpqaLZBtPzI97Cp
         hC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789122303; x=1789727103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78LESa0xW9NBZFerb3MMp2ADRFT+Jxefko8V+gPB56Q=;
        b=Cb5WTmNzcYxOJWuXYU/DewY6QNVe/NVH1vcqyXwvhMH3LZa5NWGWTyqv5jb1tVGO7v
         ehhkxFpyCkaNhYZq3+HMbUalmZhrruIXiZIP4KOXb2WoZj3sF2pnyFjgQz6GoxIALLTt
         JbZpz5RmMECl9Ei3KAA14bnUa9RCI9+6H1mKFhjm1pyjAWXrKOIQoqmy1ZwxEWWjfjcP
         lX1j6t+dB8bFpEs376tDApUxvGQpRWjueuw0htUtUi1k479VojgDkVCGtX6jYoWDqrCw
         23YwzUVs/Vz/feQWksasx/5lWXamo831i0DqHatJMAjYvXcL9ZzG2+Ho10gyAbOFUgnr
         rd/w==
X-Forwarded-Encrypted: i=1; AKwUvBwM2ihmbEHBxO4z127CE+BGvrVhpcMG8c25IsisF3kwSxkKzNLLxxSNCMFk0WeH5/spiwzjmvPw1NI=@vger.kernel.org
X-Gm-Message-State: AFuF++nGG54Tn+IE7orejBLwmc3ew/cu3fnKN6uxUKvHlVopt0fEUf+6
	BCKAKByKVKZXn3EPan4gJjehh7koCe2tpVWd8ZiVpSglN80Mszy4X786jsunq50U/wq5fGUx1tn
	EwF8TIcTE9BJKyRDoQrob2DI5aDnLPqnmnrEYhmIQ6fhqQ0sSFyW0SIoyb7lhX/pdK3v4ymbrcV
	fyL6ln6uMUJPl3AfJJ/VhlrYWJ0OBzO2CsCk/3lw==
X-Gm-Gg: AYBFou0tkFaYCOEcfHRC6l5rsF70G11XVY5IGYb2b+HJQPVAPgS2AnOg5e2RlEvPD68
	2Tl1MtKuN6swvb3HWD6rQqxxA7078DO+zU+xKqX8wMwIoWS5gNE/pcpFKZblPIBUc46G+DoMjO0
	Iphvk9bdzegtWCYkil3SRR2efeVq8tjZweflg0ZsVWhUnqK1U1o2WKYgL5jg==
X-Received: by 2002:a17:902:ce10:b0:2db:3729:22de with SMTP id d9443c01a7336-2dd29e0ecddmr78785495ad.0.1789122302657;
        Fri, 11 Sep 2026 03:25:02 -0700 (PDT)
X-Received: by 2002:a17:902:ce10:b0:2db:3729:22de with SMTP id
 d9443c01a7336-2dd29e0ecddmr78784975ad.0.1789122302247; Fri, 11 Sep 2026
 03:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828034413.26115-1-vulab@iscas.ac.cn>
In-Reply-To: <20260828034413.26115-1-vulab@iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:24:51 +0200
X-Gm-Features: AcwNN1XuNmS6ZmC3zC50AvK74TcgQGnHr3WRdBGIk1rjeJOFMseQergQI0Iq6fc
Message-ID: <CAPx+jO9v5rD57kjhnNnzUOVu8Li+zjpnKBO_UksGET1nURJmJg@mail.gmail.com>
Subject: Re: [PATCH] memstick: ms_block: Fix memcmp() size in msb_resume card validation
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: uuxQotn69BjPIo6pJyleN8mz5XPA2nRr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NSBTYWx0ZWRfX5RQG0r/iq25T
 y+GKTrGkJyYXnswBl1T9dPVerGnUp20mg7z+pwQkOduQpudD+VJ8AA5AshoJLChsZ4Q5OqFZZ8W
 5CjkMjtKKOwayWciC6JrC81AzIX/LiI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NSBTYWx0ZWRfX2jZzYKVqaUBj
 nLAYK6f7g67unAHCjd0OASwSx9HilbTXYajidS2v296F5uN4xgLUOydaEEWUpHlt777x1iqUb3o
 Gg/CU8YAcnKhdKSypyfkWj1hmIHMrdNLPj2YQ3ECZYZxcUJ9DHeuxDtpPBPZL5zRka6Ipv+jdQs
 h5wVqwfraSD91AFR285vjjdgpcLv/WMYwuTxZpAikOPy+eV5GDMjcML8XmEC3gMiZFHG6NQsgKR
 6IKzxQEQOlCkqNsHG3k21gds9SHlWIYYFj95wzByuTpRS0IvfOtW3skanQ4ekt00VJniNTJE2pB
 Fk4tgl707yf/l5/0in0AZCdjIJzvpGBxW5mB85nN30FO3YDlvFNksbRrIWk1D56uyR4xmcnC2zu
 9cLSoAgaU5pRYrMxNkTnxsisFzghnBzjyB2yNAy5SX3f+ybuT60m8K8pDDXpvNEpyqPwxp2SAkq
 FTsYxK3oVaT1JY6T3cA==
X-Proofpoint-ORIG-GUID: uuxQotn69BjPIo6pJyleN8mz5XPA2nRr
X-Authority-Analysis: v=2.4 cv=Wsa+otfv c=1 sm=1 tr=0 ts=6aa3d6ff cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=65QBhM1G5XyreR3ueWYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110145

On Fri, Aug 28, 2026 at 5:44=E2=80=AFAM Haotian Zhang <vulab@iscas.ac.cn> w=
rote:
>
> In msb_resume(), the LBA-to-PBA table comparison passes
> the entry count msb->logical_block_count directly to memcmp().
> Since msb->lba_to_pba_table is an array of u16, only half
> of the table is compared, so a replaced or changed card whose
> mapping differs only in the latter entries can be wrongly
> treated as the same card, keeping stale cache/FTL state.
>
> Change the memcmp() size argument to msb->logical_block_count *
> sizeof(*msb->lba_to_pba_table) so that the full table
> is compared.

I don't have the sony memory stick spec at hand, but could it be that
the comparison deliberately is done like it is?

Kind regards
Uffe

>
> Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/memstick/core/ms_block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_=
block.c
> index 1af157ce0a63..589ee2eb1a60 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -2246,7 +2246,7 @@ static int msb_resume(struct memstick_dev *card)
>
>         if (msb->logical_block_count !=3D new_msb->logical_block_count ||
>                 memcmp(msb->lba_to_pba_table, new_msb->lba_to_pba_table,
> -                                               msb->logical_block_count)=
)
> +                       msb->logical_block_count * sizeof(*msb->lba_to_pb=
a_table)))
>                 goto out;
>
>         if (msb->block_count !=3D new_msb->block_count ||
> --
> 2.43.0
