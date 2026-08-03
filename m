Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A342123C
	for <linux-mmc@vger.kernel.org>; Mon,  3 Aug 2026 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780735; cv=none; b=jBHMW9io8O+37qlc/HzCerO5ICt30w1znl+USC2SXCQ/xHPFjQhjqCTzeh758N5znEUy7/ZHhyQvFjv9BnU0djCjU27+UxR8u5rmbV+mkYKSpCAz1qDM6rjJTUU7yD9duly+1Px1JDDAgSgIy7QLsIpA+KiUfMUZTa35XwAumHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780735; c=relaxed/simple;
	bh=zV40Ig/Q47xgMmfb1w1DsDefx9nFfpfRri82MNiTCHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuKBKjVH/4OKH5l7ew+3e9Z5zlMxfhWv5tcnD/QYrfcPWc648SoRnjACNmFgN+CYzWGXRe+3OuheB1K18A39lyqy1CgXTHJ3SLXqviBB/hWGIrT/ffgf/svXZh3jSzqQ4hDtMKr1fJ/JZqftcRr5oDPexIfYXOB2xrcRfkVueoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FcsUUb6O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HDA5kLPd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FcsUUb6O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HDA5kLPd"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673H6gw61053358
	for <linux-mmc@vger.kernel.org>; Mon, 3 Aug 2026 18:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=r0BAKzWOvEXoVkK4l8UklRSB
	xzayU8+csMIB3SSayVA=; b=FcsUUb6OX4P25AIoFQL+6zEGUzyOBtu3kP10Y7uP
	5jxOEKdtYcBue0BSxy09wtdx0zSSTyIueZJH5j8s2SBXcBS+6+keWB6ezK8aHm1x
	B43GnxOuM6q37pBt62x1ruySdbx35ykrrjJJ/dQJEFoZJP9ftpoMrzP6bRe/FcDW
	4QR0IqXRonrS15OD+D8XHTIfwpTnJjDV6K6MwELVZYpSb4VT6KZkvcBLPU5litTV
	7M9w+Ne539q+lomMxcKJCCJY8j2DkQW8MvK/5enGky5nukdXZOw/bAEQvG8MtYvO
	eNQrGWKjNqWcpguHYOtrvemCd5Sv2Y4R4kpjlnpKyrWVGw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty3qga3f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 03 Aug 2026 18:12:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1a97644aso36662391cf.2
        for <linux-mmc@vger.kernel.org>; Mon, 03 Aug 2026 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785780732; x=1786385532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r0BAKzWOvEXoVkK4l8UklRSBxzayU8+csMIB3SSayVA=;
        b=HDA5kLPdBWU9ipU0JQuA3jvLv6YgRvdB2r4jJt7ywlQoz2L5qgYAsdUtRkHGrWYR3d
         c32lWAJu4rts4pZtPB+3Cfr7ich6Ik5BcGKuOShBvcAxXEaOy8Y4ONY0wOY4SmgN7Pfm
         13gIxQwL6Jbz/IED9Uo781lcrvgsz0iH8WKeq4trKMVkwGc97do8BbFABkdB7d+GDTXM
         ODQM9Liq3Gr+w2DH73mCPUhhHjbf9Zm+shAfzBm1TVR4yRnVy88kOXtiUnA6fpxmshir
         Ep5Z1GqV2qQKT0AQUgt1TQUnopBRScieNLpDJMn7Rc8gBIegMh/T1lZesfq5O0gcTFrI
         tE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785780732; x=1786385532;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r0BAKzWOvEXoVkK4l8UklRSBxzayU8+csMIB3SSayVA=;
        b=iZXKhFwxDq/AVo5qmX0JgGX73RzLqVVYHOv5OXse1YR3JHR6Ix+zs9ZikRzB9Otv8f
         2lXZeMmM/V9asJTnzlWUMR6l6xOS0rAPlJ/UTYbSUQ9tKdV+Qr/6NlZabZHJKvvHqrg2
         tYDKC4582rCS5sSvx9VI1+w7fQLRU97bvB/xSlrsPa8RUwlh4xFqpLcEwehXbY8i9gzn
         KjTa3Jsc8s1sevOtTsj+F7GnCAo5gzc/6Gq+dOTxw6RV19O9BYKdttK5GG8vjbNfsbzF
         P0LON2/jCA+31BSaQsQbxyHp1KyV6D1Y44QOXIT/CP6fqnFjfFn4ApSeh2ZE0C/XdNoW
         i1nQ==
X-Forwarded-Encrypted: i=1; AHgh+RpKmoDxbzxCfIz8KlpTxrM4gxvcTkMhjbSUGIWUARxs3daLQyspViVKj2MtCaZpuz2ov5i0mSEZbAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMMCQO1gdo94DMzIVKQ8omFlDjv9cpMO4o1zOZJnNYUHghYypD
	d4oZxvNTmpNY/NVR2rj4AZhhJMH8LmSaT/Taw4ob54nIw6bG9XX4gnKUMK7MmxBHWSW6rZk7x7g
	fFhfmylIXtwmwsMluzRQMzycKA/SQ9BeBqaak0+SR3X5QdvoMqBVAmOGZ3VUxHkU=
X-Gm-Gg: AR+sD11QDNbf9vJ0uDLrVMpoxUgAPcYxe08K4SkJB/4K3AeTXfxBKGsk6BqYGS0IvvL
	m8w8Rli2EMsQ6yqUm+p+vrwoBX3o2zoIT6HP5MBgCVOHLJvjtYAdHK/05to6zTKz3tW4vFUCFEE
	cek6nupBrTgX8zYdazZ2zsxwQnrxkkaSZjhGOtW72BGQkQmyUM5I6//gOVro36wjzt6R+Jnsg3S
	dfEexExf8HSfTOw7WPaOA3hqeNFHxuxKbBYgh4Ff3Yyk3VAFWZuGBObPlE71ZH1+xwiwk9R31tv
	VwcoHqCw4CtZ+kyG/Gz0+4R+rgSNbLm0I1aOgOeTa3YMlRHBFLrMEs7GyQs1nfVqNfQgLobs50n
	FUzhdOOjtznMSHUEobzhTWOWv+CGUjRZISbHbmIYZjEDKqmH6W/Mb8MibUNtlmBATMJyhE6tXIH
	dTqPUqmPQsaN41nA==
X-Received: by 2002:a05:622a:53c3:b0:528:3ae6:14b1 with SMTP id d75a77b69052e-52b5684b9aemr192077761cf.43.1785780731765;
        Mon, 03 Aug 2026 11:12:11 -0700 (PDT)
X-Received: by 2002:a05:622a:53c3:b0:528:3ae6:14b1 with SMTP id d75a77b69052e-52b5684b9aemr192076911cf.43.1785780731161;
        Mon, 03 Aug 2026 11:12:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f810a05b6sm15787181fa.3.2026.08.03.11.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:12:08 -0700 (PDT)
Date: Mon, 3 Aug 2026 21:12:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ebiggers@kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com,
        quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mmc: Allow host driver to control the
 re-programming of crypto keys
Message-ID: <wz2zgw7kp7vsc3r43wa2kssi4niy5itsmee5rbnki6lfvmid4z@qdt6ib3sj4wl>
References: <20260803163123.1802005-1-neeraj.soni@oss.qualcomm.com>
 <20260803163123.1802005-2-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803163123.1802005-2-neeraj.soni@oss.qualcomm.com>
X-Proofpoint-GUID: x4WlE6pmZa-T9QNQUGonukdwIEdnwTPi
X-Proofpoint-ORIG-GUID: x4WlE6pmZa-T9QNQUGonukdwIEdnwTPi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE2MiBTYWx0ZWRfX/1qCsfPzFWnP
 iKNoVy15x5ZHMk88xzO6h3U25pbzSwMLm9yR2b1wOT/lrB0tA1SGR9TFXDtNy50FzrGWQvwe6nS
 JewmsyxITpPZvQ1Gj5x2u7sFCS87EWdToFijuXCaQbQ5mItQ+I0Re+cE5CidtyuJn6Bzt5BK01z
 hTiRtDp/ZbB6hzBMoUMZ2tLrwd+81FlrZM5XNDw1tngNRxa/rlnrxeFxZNofuMiandFXz0lJT1w
 /0UrmnjfLle0L4Go5ycDuNu37GbKIMQ8/c04YuMujTLhgam5x23o++wOLc5SA/HtQF9VpS/hvUa
 dYBpXKnxeRTh5+Qzhk//xoCQCRz3zQiCLvwRJ5jPI2Qtr8Sq10aEUMlcV/v1CJxXNorfz9FEqnF
 MNV8hK1jxcKDTb8dtwHzLFYk8zie6BYlp/soDR7RJsM1laLLboROg/HyM4SPtG/SRVh6mI8ZhRm
 O2UCIpsjO/RRboCF9Ow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE2MiBTYWx0ZWRfX4qoM652k6CDI
 vAgcuEZNxBSG7qhWo8R2peG0gccgA3W7i3Q14B7SXfO06fASUnugL4//D6e/Dv1OF3lEN2s4dG/
 YqSImbdc+seD6udTSQW55LLdFZE0Hzg=
X-Authority-Analysis: v=2.4 cv=ONEXGyaB c=1 sm=1 tr=0 ts=6a70d9fc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Ria5deTLU_ndSx9n1-gA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030162

On Mon, Aug 03, 2026 at 10:01:22PM +0530, Neeraj Soni wrote:
> The register context for the crypto profile belongs to the
> sdhci/cqhci host and not the mmc card, hence re-programming should be
> managed by the host driver itself.

Don't you have a reference to the host in the function?

> 
> Add the flag MMC_CAP2_CRYPTO_NO_REPROG as part of host->caps2 to control
> reprogramming keys to crypto engine for SoCs which do not require this
> feature.
> 
> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> ---
>  drivers/mmc/core/crypto.c | 2 +-
>  include/linux/mmc/host.h  | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
> index fec4fbf16a5b..a5a90bfc634e 100644
> --- a/drivers/mmc/core/crypto.c
> +++ b/drivers/mmc/core/crypto.c
> @@ -15,7 +15,7 @@
>  void mmc_crypto_set_initial_state(struct mmc_host *host)
>  {
>  	/* Reset might clear all keys, so reprogram all the keys. */
> -	if (host->caps2 & MMC_CAP2_CRYPTO)
> +	if ((host->caps2 & MMC_CAP2_CRYPTO) && !(host->caps2 & MMC_CAP2_CRYPTO_NO_REPROG))
>  		blk_crypto_reprogram_all_keys(&host->crypto_profile);
>  }

-- 
With best wishes
Dmitry
