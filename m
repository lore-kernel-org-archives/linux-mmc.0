Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790638;
	b=e2KxikqPxQH0AFAH9b1Vw3qUT6ZAwu8J+u+WoFShbKvvmtPKSkT+wcxNCBiQrSoqPHCt
	 8qh1fvB1HRSs0J7NulXa7KZlvBgu4NQFUqkx3X0ph2a+u8SWJGIkRIo8Ric8IUMTOF2ws
	 h19vshaePaHgj0WcUdHeq4PLgMMvh0/lzjRPsjcYYR9os6oC2Vh2ahzROs39J1J8RWrBG
	 50wVdcoXZZCAS4k3mjvWdMRsZNadQ/tHEg5RgUU3rTjzZ750cavnZUyHhXLa4pzG9GC9r
	 FgYOp47AYWGb38j/Wnf58LGC1a5z0EHa/K0ZwFlYEfM9hdt+5P+plFFgKxXf/5c7BGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790638;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ril6/pwfVdg5gu9k4cDXZUxaEC5nPCVnaNVlfqYTX5c=;
	b=Sso9OPbcx9Ts027oPdDi6t8ChClZoehGd4Et64ll4RxYYAmf4PL89gogLBAIslPSjhzF
	 nDylPlhnQXnQqatkMmF0t6q0S2l+Nea+lwUaLRfkjj3QJCxc1T1u17zDRFekt/eg+kUT5
	 dUPl7Z4f6RcgWy29JkacuXniQyKkzz5LqtVDKgq262P7HEmp8FTPVxnh7BF8VqfX5XoLY
	 9jxCuPnqx+knq7T5tvim1J+mYqWI9orqFYsCF65+zPMzjqbboGFugiYFU6bFFSGQ4m3qD
	 gozhV68PjKZQipfzDwKK5Sgm8BRsZqtql4bGUUCO/IYqilNbqLWF0qB79aB6G0vAGYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d2gpw+yD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kGTB8jzV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E73606A32D
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87E73606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d2gpw+yD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kGTB8jzV
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE24wS1972383
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ril6/pwfVdg5gu9k4cDXZUxaEC5nPCVnaNVlfqYTX5c=; b=d2gpw+yDLk7DPW9o
	QXGPp1jaxL3hNRSC5p6J1ryAUl3d+8Os/28iIj0+G+knWFxNuvXDtd1PEhBAQTsn
	aaL77/ZndtjM/Ehwr+QfK/SPq0iGbPEQJRk/6TT7E3SoHCUxGT1xzPfik4VPeCW0
	Vl+j4iImF/460N6jFHNOeFC9tjRWMmWL3C1hGd3hXlgQvWZRvJ8s2cYP7fBAEXhS
	72MdBgYaZILseaCZbqfGI5V0dsGqZE3UlsA8vOIIwXBXFVAgWjxhb4VN9MPAJ1Vi
	lE8UCDwG3mPBAxBUd9cYZV/I/BZAj0hjuQtSmRy83f4mr6HfDo+QIbpKHaSoRe64
	CBk4YQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u55udx7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2f074b87307so50938835ad.2
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 06:43:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795790635; cv=none;
        d=google.com; s=arc-20260327;
        b=QtnOJWnkZNUS1l91YkiOwNC4s5BnHbeoNeBnhaOZrx7jG13YRyk+sILr+qzVSIztJ5
         CpSYyNUGNYAZoKfLUq6vfmaxUYXCMdC9GficUhLg+CtqKjE4HstXN5rmD/U84Q0xGiGm
         9/n4pzdSVeeBo25vx8VE6YPILA2EbmqsqtJ2hDJJtz5CrVZDqt0hdAD8pf+pIqgxLFPn
         9AdDoRFS1EYlhYI6/MesIVPmscGvheF8Gr0ElquSGEfsnKML9fJ1QwTJFpFZjt6RQydP
         Mnw+72XNuroLnBvQANRIRhtm4qsJdhJL3o2yKintV0Wx4phdwoCoMDI30Zqa5uIY3CXD
         1vfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ril6/pwfVdg5gu9k4cDXZUxaEC5nPCVnaNVlfqYTX5c=;
        fh=G2OXJJ5Ra3g376+xH4qpLx99V+PfQ3KVba8szRPXRW8=;
        b=AQHAPKciysDfxgR8HvSrUaycjG4O38cxlZvMwNfTK3z1RkWscvrtynxKgF/XAiPN89
         evwZAY7mp1qIN9IfWEQAumBvmBk+moCeU2L3VBHktPiuYyc4EKnovij0hJipcGVG9jE7
         FjM4ToDvVzCtwk08UDBYRoxmn0Dw2WRM/sh8Fe08v0wjw7+rsGCOgJA72kmoiLAnVSPt
         NGPCOJiyk3YIHlhlULxhSvFWsV15BLe2ULpU2G3UO670iAM9BEf+SOBFSGlbX9oVxtIy
         E2lRgUV8kk6VUEM0pX6sueyB6ESzsMXXqALtgtQdyIrOn0GFq2qJWtqk5na9HUl5MItp
         TAEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795790635; x=1796395435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ril6/pwfVdg5gu9k4cDXZUxaEC5nPCVnaNVlfqYTX5c=;
        b=kGTB8jzVBnktjMfvs1nUKCJF+7s+XIPLADFClPYus+B7R441DiLGVhhz0O7mp/n8IX
         HgmM9Mo3hkOCmkYHt2O+w8cXVc/dICV2WoBW2iGvWek6Qo+RNs7UBl+/k/Dl/emdTj6M
         ou17+3pQa2qlEoAlpfe7ggcEhBKRGI8lsHmLo46HHL/AWD6QfLDnONgmgTBI8x85SG+m
         /mYvLoQi3ejqtjulJzjK6Bwfp2C8C81d4Z9acuO5UowhogVvKhh1Y0LUX2XDZXjbkP/+
         aliTaS0jJ1YTAd/qV5OObPDFeIPhpZ/F4x/1cPyFP3Ku2endE2b1TbNor4hgiuBWYRGE
         4nGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790635; x=1796395435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ril6/pwfVdg5gu9k4cDXZUxaEC5nPCVnaNVlfqYTX5c=;
        b=e/FkuMIpXRGB1gVxAvqtD6xhqKIVURp5f8L4Rd1BmABuqLe2BXGJT2rRrXvUZsg1On
         kjZtLqFZ5j8CqibhHvQ5cuysv5gzXrMVk0j0i+1+7LhgtWEf/ZBl5Mb1CyFsd5Sw7N3s
         Hw4YpvMMoKCrE1nK6Nr+Q4/AcPru+EsZfJJdossoVP2RAGI24BNj0UCE50QtoZYakci0
         xJH4SZZB9EWfdfpT3iMY7PSvxrZO1kcdK0mlkjJF0Cd4+9qwmpR9w0YhN/YZtd5P3aIp
         acHzVrwXHziuFuZTZVQYqVlZtsKdqWhVArfTE+t6KPAFajhzwgVn3SYOLT7s3eNmUyjp
         4LWg==
X-Gm-Message-State: APuU4Z9yxQB2A2BK2V3A9L4JgH/1srpJEBy197RLzPtZH49MbjrNZg08
	dPMivAHtrl11Z5YsOLNXEzabn3KQpv+0YveZM5do9cZjP/jAoze/JGFrRtfQU4dDV6zdUnMUoP3
	r8v3NRZe+eZ4Xeq0gl1WT52yUYBB9rjZSMKlfsEGfQw2xI9c4GafR0xuNuzi04BWy1Yj9y91fp+
	B1vKqisE9ZE7fYF3p+WQwZAKlIse8jXsdOgHFDdvL0rapAVg==
X-Gm-Gg: AZFdTZeiqWqMzUkpFV15JdFbFvBYAODRU3WbugoBNfpXehBixPQn4Esl5GXx3g7km6t
	gqddr3a9jjnThDhgAe0nziofZKDA30Wj++K0IEk29mK4CnPJexKnl8ympJ7T+p816+AWEuueiPs
	StBHBDFFVEPpYd7nOux4Rq9Ly8uy7gM9NoSeTBkGgorxJcJWjZDxK+vwaBdA==
X-Received: by 2002:a17:902:cf0b:b0:2f0:25ea:8fa7 with SMTP id d9443c01a7336-2f03f18a1a5mr246985805ad.38.1795790635224;
        Fri, 27 Nov 2026 06:43:55 -0800 (PST)
X-Received: by 2002:a17:902:cf0b:b0:2f0:25ea:8fa7 with SMTP id
 d9443c01a7336-2f03f18a1a5mr246985505ad.38.1795790634777; Fri, 27 Nov 2026
 06:43:54 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104142341.50294-1-mmyangfl@gmail.com>
In-Reply-To: <20261104142341.50294-1-mmyangfl@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:43:42 +0100
X-Gm-Features: Aa3M54qV2kcyYTG3vkcpE6lAYkcRBJRplILzwvvRirUG3PSX4mnwqWiE3k-KZJQ
Message-ID: <CAPx+jO_2CpmakqD5nifE+g558_XsxFR9zKpzeKgCX1heFs8ZJg@mail.gmail.com>
Subject: Re: [PATCH] mmc: hisilicon: mv200: stop treating the CIU clock as the
 card clock
To: David Yang <mmyangfl@gmail.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX7Q9Rhl9Azrv/
 fY8v4imCAFBk5EIv+Q54Grt+JC1JfmRchhx29k/dv5MO9pa6OvxzKM93jFmyhe1jfxTdrhQ+gzo
 gcSDlnjH2WV43FUPWJUBGDWZJXMVOAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX7/0DouufZQUV
 a4ZL5h6AlzWxZhxIzcbC7xoPWVk2qClMEw6R4lJWEvlJ8lofukoAZ+WGlH5/fIkQFq93HXBddRQ
 ht0s1tAekwXRU/5o/er/QOqXbPwxo8PfDadAJw/hT9Ht9IfZPlU7uD+FBRNMOrfKrwDxygVdmAv
 lw5lhoz134NJot8uGfLJzG1gnSvFXPL8byo8Nt5h/m+B0HevzB7mjiuBAYM1AemPBbF+yIYsaD2
 v7xF7CXB73/k6IheEu4HLxdp+9mN/M1/g+RFQoqkonNBXhm6lias0ZhPaccGPMLgWGvSgtWLoeC
 /sUrr4cBuRFl84cTg9e+Z0Fzq2FpGQHcAKnY0REvwvxGc9DUveuc1ydWgFB+ks1/ODVgkh6LXpB
 HtbHs27yeYnJam0qaG2yNqYHdOgRhINOW2UYgL9hEympiFkqWZ9flXrN3SmxSeg7xG3Bdal8Vv4
 T9jA3V3CLKTLIemMQkg==
X-Proofpoint-ORIG-GUID: tzo79uF6f6QIQQ0wnjzQX7bV9jT3J193
X-Authority-Analysis: v=2.4 cv=Z795j3RA c=1 sm=1 tr=0 ts=6b09972c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=P1bdStQrB_pqgD3IWdEA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: tzo79uF6f6QIQQ0wnjzQX7bV9jT3J193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

On Wed, Nov 4, 2026 at 3:23=E2=80=AFPM David Yang <mmyangfl@gmail.com> wrot=
e:
>
> The card clock comes from the controller's own divider; the CIU only
> runs at the rates its mux offers, 25/50/100/150/200 MHz. The driver
> nevertheless asked the framework for the card clock on every
> set_ios() and warned on every refusal. The refusals are the framework
> working as designed: the 400 kHz identification clock is below the
> lowest mux rate, and clock =3D=3D 0 is a clock-stop, not a rate. On an
> Hi3798MV200H board that warning accounts for 18 of the 24 error
> lines of one boot.
>
> Ask for the rate only when there is one, ignore refusals, and read
> the settled rate back, so the divider always starts from the rate the
> framework actually provides.
>
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-hi3798mv200.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c b/drivers/mmc/host/dw_=
mmc-hi3798mv200.c
> index fda417888be9..e64d5bdc068e 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798mv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
> @@ -53,15 +53,19 @@ static void dw_mci_hi3798mv200_set_ios(struct dw_mci =
*host, struct mmc_ios *ios)
>                 val &=3D ~SDMMC_DDR_HS400;
>         mci_writel(host, DDR_REG, val);
>
> -       if (clk_set_rate(host->ciu_clk, ios->clock))
> -               dev_warn(host->dev, "Failed to set rate to %u\n", ios->cl=
ock);
> -       else
> +       if (ios->clock) {
>                 /*
> -                * CLK_MUX_ROUND_NEAREST is enabled for this clock
> -                * The actual clock rate is not what we set, but a rounde=
d value
> -                * so we should get the rate once again
> +                * The card clock comes from the controller's divider, wh=
ich
> +                * only divides down, so a fast mode needs the CIU lifted
> +                * first. Ask for the card clock and ignore the outcome: =
the
> +                * mux has nothing below 25 MHz, so the 400 kHz identific=
ation
> +                * clock is refused and just leaves the CIU where it was.
> +                * Whatever the framework settles on is the divider input=
, so
> +                * read it back; clock =3D=3D 0 is a stop request, not a =
rate.
>                  */
> +               clk_set_rate(host->ciu_clk, ios->clock);
>                 host->bus_hz =3D clk_get_rate(host->ciu_clk);
> +       }
>
>         if (phase.valid) {
>                 clk_set_phase(priv->drive_clk, phase.out_deg);
> --
> 2.53.0
>
