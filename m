Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962244BCB8
	for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2026 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514916; cv=pass; b=lyhzRadcxw+QEczMi+6FxkReaw6se6H+ZlsT0gHNyzeZQKEJds4X4hIQFTAaD/j1M7A9jg+7GWlbPwBHTPceSdogVObXOkFUe7cC2XkpfhnKIB1Pd5Ei2YlyBnF3P6ijlpdOHEVW6esyzBF27NpNYKZko7T7ExSgCeI3fShnD4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514916; c=relaxed/simple;
	bh=fW/lJf2KOwA98xIgXZaecXl33Btgc1UgRDfZfpjaz5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaJOp5S9hMP7QU1YLUqoPdV0NNpyPAO7m5g7autBEv403drJfDQRQ/AxmTwP6wmagA/4+ZOLjgMCyELDOSeSHDtKglEQSZ4jU4EnONu5pKE4sbDkNztqYLGKxqqr9IefO7IuUTo74fEi5uSBZJDwayUMLzK8vzc0HgdBBJE9ysU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m/1p6bDJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q/lnRKqZ; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m/1p6bDJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q/lnRKqZ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847n1cl2839493
	for <linux-mmc@vger.kernel.org>; Fri, 4 Sep 2026 09:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2E3NOcNS0Jrf1iDrahKhhnn2EkNDFS2oGiB4m/hawxs=; b=m/1p6bDJhbcvyAvv
	FCIbW0xSwPgxhakn0b4i8Y+2HxqXcGy8P/61V702mMnKPuAiIYtbYPuJ6czD9Wfl
	PUuk84OWr+XKKSzwcP9UiwPBnDxD7N9DNZKYIgWt1i/889knJwk1B0EEM2BZ4Hvw
	twow6ujuctNrePq1ZSu+Rm+QYknyx5Abt4KneqInvIcUxqWX400zv8dIQiN4WTOK
	GnzOsOpI/nJhZ5AwY0X8BiLSvSSUmAW9TtdllRBdIFYxIwSBjZAdg1IzP5YhuoZI
	2KN5nnEqNeJzTLiHPAlfcouhH4irE5lWzDlLRej1dnoo0MUGOYXLMHfihoYcZh/x
	hf2Hiw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqtrtr1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 09:41:52 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc18ced1a5aso1594196a12.1
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 02:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514912; cv=none;
        d=google.com; s=arc-20260327;
        b=VVVOt4BGO9u2eq3ATa86iO5PEG9jji/mjUv+iuBaQQ4EI5aYvRGz9KpKxOIqd88sKM
         iyAleA9VZ03sLzgMgy0UjCJ0eTBdG05Fe7V1JjBNWpUV3bW1U/cA7UeEYCGvgnUsIpL1
         7elInvwJeXeIC9iQf4CHenD1uZMOHj8nEtexh7hBrWRVAY2EiyUqR+959HxJyTEmoiPL
         sznJGxs7QW0dfIBE8ti6XgOR8aLGOfJn0hfFC1hX87g7OGwv5NE5GsD6B1zNRsZUpH05
         oCafck8cJjnUwTlqETjNfiImsXVs2bodU3MV4zmAxpeIPjwjOFfnSODZva56ze4P+qXj
         y//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2E3NOcNS0Jrf1iDrahKhhnn2EkNDFS2oGiB4m/hawxs=;
        fh=/F7qbSRqfvDyoaFsPSdM4UxrxqyeO4oH+UiEoer/x5E=;
        b=n0XnpmlixluTm3ykGd94P2DR1c5SmcYKcY+Fht0iAqjwUeVv6uPg/Msoc5pjyp4FjC
         tgCEQsvtNJZqHgULw11bCN4qDtEF4ff5JeOeZ1DDKi0S+eT2nkKblPWWcM5TlaogJPog
         em7a0BzMDKP7J3X6ESTpXaYLa/eqxagYoOM/2qJiFb0ahTCsk3affnymhgQnCGUIf1iy
         sjtM1vn9T26isKmnbekJ8HKLP9mmwce0hZnFOFRYEyEDuMQv4qv2vm9HKpkP/+/Ee9hJ
         20IX921fYNdp9zGUw/Ln9+yegrBH9CkvhzLVsf64Hn8HQqp0s7hG+l5U8zQyvqkJbe/m
         Ru4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788514912; x=1789119712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2E3NOcNS0Jrf1iDrahKhhnn2EkNDFS2oGiB4m/hawxs=;
        b=Q/lnRKqZYZwhUZ3NPccWNqsfsJj+YynG0f2/ACXxOu8uKBASK9lxGkRUQNFnMzHrVW
         sDlsYiO2ZqRntKZDhnAeLFE1kpjm/foEMycy4pyEPunt/LVAb6suh4AedaJLib3Bm5Sx
         d591O+6GJ1Tej0nrotlor+l593+QwM1p8PVwqVjtzDMopwr7RJu1AGQRmiXoSzzdccTN
         /INfUrWLVqpay0OBSRbqJz3KKRqGwDzy6rSl6tqeCH7OdeJCMLzA9TtRn8m6NiPz4+kM
         eOPYs6zbRmrWyiWuUVXFFO81C2SEUaIANaOReyY3TWiH9SR3RhYKunuzjnbVuEOuXFyM
         nR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514912; x=1789119712;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2E3NOcNS0Jrf1iDrahKhhnn2EkNDFS2oGiB4m/hawxs=;
        b=slyXetHxU0cgrcgNKf4koLCNCNDeVsoR+8F3k4N3YiMnNnczCRbzJFTFwPc4jP28F3
         igtUnrWOPHkWQ50lgUDGmz1mOAif05C7+Wx7+WEoXDZAtc7y5wQHLTGEXZ5jw70MCkPi
         B+SdhIK49XpIypbNxwxBr34vcpJLqWubFS+sF6AHiLUFKywXPkWZx3on6RRX3clalUsf
         kZBgSkmGXWbOJa7YDLzgo8wxnHNuTVnMVfUqqenQpvNLFjlpQXGFYWB0oBGl2+I9FunG
         LrNzgMOeSPPlyEKgTFXdXcM2ZB7dEslC/x9Z/ticNAbVPGf9UWlqCD/MvtumHvQaIooS
         T1qw==
X-Gm-Message-State: AFuF++n+fzhTrsGb6R7KVzUuMUso1Zc155msD3Th4rFkJirEV5vL65zD
	oCxVG+LeinVi/jtjzAVSoSCyottmzlO//hGt8I/yZqYGixaosgwZYGXY1d8ydEYFfxslGTPx5D1
	PW/YEuNUqHHVc/WzE+7A3k0PNx4FGsrALJKAr5RHrFKOqDO7j72PohW/gBWqGvhxu/ObELFhHMv
	6vEc+b0HCVTg2lbZ/duTN6XJYIF6AU2Q+hsBZeug==
X-Gm-Gg: AYBFou3ENdxpAAidvaqVMHWiMhOTbojd8KRpAZEm2RMT8VwoAIlyCZtj/V9druyLg6e
	90mF6CS2x1Hc7xIzzy6ib9kxbGOMkwXH4BPrgM6vfgLR1dGsx4H7KU71fQ4QvLwCJvnqfby0OiY
	ITLAVPSEcz13yMtNwfHIsv6VZi/HDOgd1s7ewwKDaCZKfLZqf0NugBJtuP9g==
X-Received: by 2002:a05:6a20:a11f:b0:3c3:b57b:6285 with SMTP id adf61e73a8af0-3da3a0af18emr6356075637.13.1788514911945;
        Fri, 04 Sep 2026 02:41:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11f:b0:3c3:b57b:6285 with SMTP id
 adf61e73a8af0-3da3a0af18emr6356033637.13.1788514911524; Fri, 04 Sep 2026
 02:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814082354.211351-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260814082354.211351-1-fanwu01@zju.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:41:39 +0200
X-Gm-Features: AcwNN1WJ3FDLKcn4NhY0mFjhOVrTyC_iuBbL5V0szQwxhM0gmqimaKPle9KR43M
Message-ID: <CAPx+jO-xK2AWPL5WtOqDbBsEDtHM5d8bLhQcSUj0f+MsnjFOOQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: hsq: Fix use-after-free in retry work
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang7@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=YtA/gYYX c=1 sm=1 tr=0 ts=6a9a9260 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=9HIRHvUZk0GByUwP-94A:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: rvpsHxy01IGYsrquqprxAzohwEOKKczS
X-Proofpoint-GUID: rvpsHxy01IGYsrquqprxAzohwEOKKczS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX8IImV0RJXpcr
 W8IqafI5Off1Rvm7fy50cDSD6GNGzXTfuVSexHUylv+L4wpgew8ERWOo6Vs+tXH82hUohcccSgX
 41OTPQWS+FBscA0wMvYj0DinWtxIYR0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX7R198he/Ti2b
 ER6bHF/mWZHfBnzpHdDvCrGoxH2gLb2G+p4ackgxlByA5Cf+BeAtjenDZZxrlz/M9rKq08Mfh+M
 DkMtQv+t1DaYYJd9IJxzON/2Z1vP0zum1LeTsHAF3woS4whK4pmVH968VW+zwqWefEN9Vc9IO1+
 JarhNTLIH3cu2OlH3KnqriTueC0CFVv2a0VrASmF6Jo2WELpi6jZyHnTE1RxOb/0crZSffHItHL
 Hde8OQ0fIk7O4OgDH4rcHuuvz5i3pbLmSGrHngnw2bBTKbJBCatyQJo/zdgcZL5vKtYjuvJYNdl
 8PbuktXcYu60curQHRaH4/vInsNClg7BWYPhURfniRSL39lc0hVQfVrJtjkEwn6jHoxrQF3c3gB
 47vMik/Wu7BFGWMEmuVQulZBF7r1q3s01K4GoiktkkdTNe1xYC0JtYXyVyqj6r2ZZVnkZTC9JJS
 6dx7LH8wTwCAygkEZ2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040088

On Fri, Aug 14, 2026 at 10:23=E2=80=AFAM Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> mmc_hsq_pump_requests() queues retry_work when request_atomic() returns
> -EBUSY; today sdhci-sprd is the only consumer that implements
> request_atomic(). The work is embedded in a devm-allocated mmc_hsq, but
> is never cancelled during driver removal. Work still pending at unbind
> can therefore run after the devm allocation has been released and
> dereference hsq->mmc and hsq->mrq.
>
> Use devm_work_autocancel() to cancel and drain retry_work before the devm
> allocation is released. By the time devres cleanup begins,
> mmc_remove_host() has already stopped the host, so no new requests can
> arm the work.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: 6db96e5810e0 ("mmc: host: Introduce the request_atomic() for the h=
ost")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_hsq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> index 79836705c..57e172bd3 100644
> --- a/drivers/mmc/host/mmc_hsq.c
> +++ b/drivers/mmc/host/mmc_hsq.c
> @@ -7,6 +7,7 @@
>   * Author: Baolin Wang <baolin.wang@linaro.org>
>   */
>
> +#include <linux/devm-helpers.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
>  #include <linux/module.h>
> @@ -345,6 +346,7 @@ static const struct mmc_cqe_ops mmc_hsq_ops =3D {
>
>  int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
>  {
> +       int ret;
>         int i;
>         hsq->num_slots =3D HSQ_NUM_SLOTS;
>         hsq->next_tag =3D HSQ_INVALID_TAG;
> @@ -363,7 +365,11 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_hos=
t *mmc)
>         for (i =3D 0; i < HSQ_NUM_SLOTS; i++)
>                 hsq->tag_slot[i] =3D HSQ_INVALID_TAG;
>
> -       INIT_WORK(&hsq->retry_work, mmc_hsq_retry_handler);
> +       ret =3D devm_work_autocancel(mmc_dev(mmc), &hsq->retry_work,
> +                                  mmc_hsq_retry_handler);
> +       if (ret)
> +               return ret;
> +
>         spin_lock_init(&hsq->lock);
>         init_waitqueue_head(&hsq->wait_queue);
