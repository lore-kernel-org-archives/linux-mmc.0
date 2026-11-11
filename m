Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794397530;
	b=d7RxPWffPXLenzQQLJawFZBiuyU0BxNzoDQE7F1n4JSU1aykTdriYqeaqkURCpI0wp/X
	 SaYYC0CMkXcjlYh7P3e5UyH4Avjn8XrTnNWEr2bmNtlXwtOv7HF5wtxF8OTR8X1fUylZU
	 8+jReVra8+eNQD9eOJeOPegq2IQyOObqcFNAQWwy5pNFQGrseDPPIHS6jE3fwTTXLSC0Y
	 6kwK2ssB9BlPwnsYui7F+eNSROYTv4BJ7NDBkgaflh2RDnR4LfsEbkohZFhFkpPvkZKAq
	 Ny2bwRDFa22PbWkwusYiFxLlrEj5v5YHURxbKTH47wz9Pz+q7MsdBgiLj7zkwycn+Qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397530;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=q0f/nKKS99c+OXd0pNSkdGGj5E5C7wcV8OUVHeCUNZk=;
	b=Le7dE6JkgHDHygtyhfp0OlbLPIeZv3l7QmwoLRCCYNbt/yhzd2gC2rcXK0KEhtT3CuVp
	 +YMa98woTeaUTdfouOvuVlmQAbpmWLC4ZGWNLcef/W2RP0C9cawUKTI6/Gkf8UcYFe9cc
	 ukK8h+zznHWSHSWPGIfc3kQ9JbDciJFSrz5gPjEPOPckMOtjW0raPAwaf3oX8ppBj0Jzn
	 s9fkZgofAqLUvy2nyqPIgf8jr1x5F1eY0gP7d2EVHt3UtlhpZ4xjCtHd6uO2Emt2KQ27z
	 iCHv0lYirFDcSzzsJTGcLPWCOFC7B6ctVxThjcVOaqf5XqQT4Fd4ztIYgDIpKs1tU9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Oao7cg3U;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fizQnXXV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AE2606A8A2
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6AE2606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Oao7cg3U;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fizQnXXV
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABANi8m012836
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q0f/nKKS99c+OXd0pNSkdGGj5E5C7wcV8OUVHeCUNZk=; b=Oao7cg3UF7NY6s+z
	6sW8VGmSVL1tUcLz3+LDLQmI0pzReNMUHEIgkamwDqPzh/A0eObRQwhRTn+e4aTI
	1A80EEiKnMZiJTb9IaIAy/HvIgjnx5P6/OrgQT7hzBA2dRze6Tze0Z7HCkOdETHJ
	ednLib0DRUXjYHTDe2ENXQ7uPJGRqAq8DCgWe76cnvLvkIxsjH2rmqkuNz+/5e5P
	l1K1OFHHemH9G7qONWVEmv3rok3JdA20MD5zkVLQLMlemnp016+1diLiNAuMIYxw
	vr0lt58mfSwxUpidowIJ2ZLRRlWUgpW7J3r6SF+gNnLzBvkfKIu7dnUmQ/9x4s32
	aLLlPw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvpjjra0q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:45:28 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b09a466295so2604594a91.2
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 03:45:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794397527; cv=none;
        d=google.com; s=arc-20260327;
        b=ZR+LpVIFCc0h/5llqaGBVi8suO53k3R0LHO7+RbQZg4SE0nZvfW6G6s5Pj43hdY01w
         DuC0YFmAz15VJSFlX3yrpIpO8BnrWGM7PC47n7XqY5yi4diuBwxCJN0B5QDZz2u8rGgw
         bnYlYUKHMaj0qJwQVIV+PEOfvj5fWNQ/NNWXCrCMtAWX/qHHwcFU9cSsU34B2ZP6znOW
         fKVRF0N991yLH14Cu8gAHW+QaPIGoC0MlOrGFTzb0wCFoQFFHvdS6n09M9F6qunnz725
         Hfg57zdVzTaLL7nNAQ0Azvfw6yTQNH9bw4kmt/iDQXMwcGAv0B2N4h7tds9ApfX2l6Jx
         4LfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q0f/nKKS99c+OXd0pNSkdGGj5E5C7wcV8OUVHeCUNZk=;
        fh=3WbTKLwQSK/lMP5U8XRxJ7QBpKeeHA4X4sNYEaub8GA=;
        b=CK2ZYXEmBvpTVcz62Vcd9q3N1tFMXpbggOWhhANbrFOkS1x3EN5JbkzGquz16Fs/9t
         5o01kOLYr7w5e9KpYoILpV69Bw+p2Z33IDkM/KkOPohZ/9UneT0OxyDJKBCclyN+YP4X
         oby6NseYdfNWfdj/PV4r892/LHPS0S5+siOPmqgZjoRhrOE7/acHPol4zlhjPcvdwsYw
         JmTN8Yt4PO4XMV9EyYSAhKMQ/lUry/tGsnSOkknnJxmMFF6DbsekR/9xQ+sgVeMWKlql
         AITgfK//JGPSjhaDREb94Dxyv8QGgF90LspzGskWSKDFyhY8HyyQYbQhqvKj59fJUXzM
         1+PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794397527; x=1795002327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q0f/nKKS99c+OXd0pNSkdGGj5E5C7wcV8OUVHeCUNZk=;
        b=fizQnXXV0pB8LTuJ5973+bMig8pBhhl1S7kOBtZF8l6oi4ls4XzIHrUbcdlQCxUy7c
         qO9puod2T/SqaNt+dmLEAEgEEbaUppL8+8Qa/Z1OrGNgpIKBFyGTm3sJVnkm1fT8qkRb
         u/tG4lNqrHO5ScQDyIuCj7cA2iiIvmF6MK94dih6OqkID2A9ky0azhmfzdHoVceqAyof
         nLo0oj/5LYObgYxFELjujuxynoto/2tsGMXI7ZB3MOJJyBJA2OMVzE9Q4UYNe4oI30dN
         +LQbBpfsvaQkFCEw/GP7TbBAWB+Tg4EN7AY+9HyyKKizmjvqzVeo22Bhk3a9q01FsNkF
         HdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794397527; x=1795002327;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q0f/nKKS99c+OXd0pNSkdGGj5E5C7wcV8OUVHeCUNZk=;
        b=QwboyUsP2FtmaD5Fa4/0alBoKdCcLsc9gsXr8Q19Q60us6wQYBOHFePOYhUTI/KheZ
         TJDzMcAzhn3gkEg6RNG5ErsqyP+qxD0gub5rxQTBDmsCJrTIduj1gxBBaqcM8tXnnxA2
         XqDuHKnHpgjC0ewAk87dcSS2HRM3RtO3GCRSL7ORFhynitvZtzEuasw7v6zI1sCJnIzL
         JTZVJwK+G+Hv8g9fcroiA+im1ZKPXRl/6UN/N1DbaFKrYVDL5y4d6vO81WLYBibaoUbR
         5g+BRkcSdNKEJHzSeEcBlIntCUIA+difJ5LkMa8h16cn7n+dQEoHonZwus/GSABuRBx8
         Mp0w==
X-Gm-Message-State: APuU4Z9DaQS/hE7DDm1E8lb3Q5I4ZA1MjvltVlSJVeeKnbumDLUZMLF9
	fU6PXzamjvNLtC9/GgxoiVjt1z1WbF2VbreXwt52WrlSYW9qulfx/H5W/iJB7ncQJMgjdIhK5YA
	zltxqMxmL+pctncWipnzriTagSmvVWaET2d5R716lzJjRcL70JCJzu2nq9nRZRP3o8oLIi8vd+k
	oZt7G5ufLcTmWsZIQ8lAE++xSbDr320EZz3t9Zdg==
X-Gm-Gg: AYBFou3aj9n6UKFszG+JomD7gGLNq0x6RbR7DR5FaN4hvkQA2VMSJ75bPo/aUdNS19Q
	p6/cr/VbA8omI//P1axaLJoqEsvxrUpT2+Z0LbSVo0W86M0sow18m0qYw9mO5Qk06QOtXPjR62E
	Skr+I2MxVuiyqJ34tj/f+EYv+M+VWk/GZIdi4tH9as7sI3Q7gnfZJaHkUw7A==
X-Received: by 2002:a17:90a:d648:b0:3b0:91ce:6726 with SMTP id 98e67ed59e1d1-3b182f670bfmr2139912a91.21.1794397527190;
        Wed, 11 Nov 2026 03:45:27 -0800 (PST)
X-Received: by 2002:a17:90a:d648:b0:3b0:91ce:6726 with SMTP id
 98e67ed59e1d1-3b182f670bfmr2139888a91.21.1794397526705; Wed, 11 Nov 2026
 03:45:26 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030215427.488298-1-marex@nabladev.com> <CAPx+jO8sc8gbxNQTjK2tx+1UPLqwwEof3E9vknHNc4kmbeB7oA@mail.gmail.com>
 <51207e63-ec60-4805-bf6a-b10647ee3866@nabladev.com>
In-Reply-To: <51207e63-ec60-4805-bf6a-b10647ee3866@nabladev.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 12:45:15 +0100
X-Gm-Features: AclHuK_0eILUxZKoBqhaHYOj-lAecM7Lt5i6JT97Kq2dLHdRsEfKiZp-ve4mj5M
Message-ID: <CAPx+jO89Z0Z241L1jyB_3sUygdEwGicqT-WfHc6ppG8egHUO2w@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: handle mmc power up
To: Marek Vasut <marex@nabladev.com>
Cc: linux-mmc@vger.kernel.org,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ulf Hansson <ulfh@kernel.org>, kernel@dh-electronics.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0NiBTYWx0ZWRfX1vdcYul78IQl
 Uyb1m1jZJY5Y8+c8T5HVUhPlK57tyYQaYEIWjFYqwI4I4oogfk8OOCVZogcGKtNwJsgOElli98t
 v3i5iABbyBAvmX71TOhfXHp75Pa/7BgFzOgLnDGENth2eMcO5zCQ+go87BQdjdtqx0dqmTb0/pZ
 x6tZLJL+ztA3kiRRrZG+k/xlrEQwdOcqCwLT0rdMctyz11NP60o8338STIbLl4Kz2QoYoJ9IR/T
 4piEE8hnRS+/qpgRJCWg/SdMzS+Ju8/SbqE3y2DYuqhtWK5Umu55bKZqOC/6/JbHGryXUc5NhQT
 7Uy6hiV9uPLQL5yM+vWtMZARU9ogdHV7yNvjE5NzsAfFuY9ewwLL7oEPbSdoq3YIwPJ8nwqBkIk
 j48aSRvzWXEGDKJlG6wWnG2dJsEhUcXYx7UogBh/mAO/b2DEtFBKq0+aREkZNGCr5S3knMaFRWC
 0BBJVzyfcniiK0tmY5g==
X-Proofpoint-ORIG-GUID: t5xLeBDXYX6Iziy8OSVqx61sWUB7PtnL
X-Authority-Analysis: v=2.4 cv=FeuiV5+6 c=1 sm=1 tr=0 ts=6af45558 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=p-LfKV-GAAAA:8 a=8b9GpE9nAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=zk4-lHRcAAAA:8 a=JfrnYn6hAAAA:8 a=phlkwaE_AAAA:8
 a=sBGgpDb1PmiqPw1N_U4A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=97BuGM4RKn6GwmfqMd6i:22 a=T3LWEMljR5ZiDmsYVIUa:22 a=7cv85riZL9-k45RWW8P6:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=uKTQOUHymn4LaG7oTSIC:22
X-Proofpoint-GUID: t5xLeBDXYX6Iziy8OSVqx61sWUB7PtnL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0NiBTYWx0ZWRfXzbZnFvnVsD+8
 AF6EkUsTm1eUajJlwxw7a+7S9CIILT/8aKRoT1V00K6NCvGaPJpnnIVB2sNUdZN+KsGkdvGIzVo
 67bA/q8Jn+nkJQP78bo2Fd1KlOSLiPk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110046

On Wed, Nov 11, 2026 at 5:14=E2=80=AFAM Marek Vasut <marex@nabladev.com> wr=
ote:
>
> On 11/10/26 2:32 PM, Ulf Hansson wrote:
> > On Fri, Oct 30, 2026 at 10:54=E2=80=AFPM Marek Vasut <marex@nabladev.co=
m> wrote:
> >>
> >> From: Christophe Kerello <christophe.kerello@foss.st.com>
> >>
> >> Manage MMC POWER UP state like MMC POWER OFF state. In case of low
> >> power use cases, it will avoid random initialization timeout. This
> >> fixes a failure to switch DDR52 eMMC to 8 bit mode due to -EILSEQ
> >> returned from mmc_get_ext_csd() in mmc_compare_ext_csds() called
> >> from mmc_select_bus_width() after Standby1 suspend/resume cycle.
> >>
> >> Fixes: 46b723dd867d ("mmc: mmci: add stm32 sdmmc variant")
> >> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> >> Signed-off-by: Marek Vasut <marex@nabladev.com>
> >> ---
> >> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> >> Cc: Christophe Kerello <christophe.kerello@foss.st.com>
> >> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> >> Cc: Ulf Hansson <ulfh@kernel.org>
> >> Cc: kernel@dh-electronics.com
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-mmc@vger.kernel.org
> >> Cc: linux-stm32@st-md-mailman.stormreply.com
> >> ---
> >> Marek: Update commit message
> >> ---
> >>   drivers/mmc/host/mmci_stm32_sdmmc.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mm=
ci_stm32_sdmmc.c
> >> index 9dc51859c2e51..659a5040729e9 100644
> >> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> >> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> >> @@ -368,7 +368,8 @@ static void mmci_sdmmc_set_pwrreg(struct mmci_host=
 *host, unsigned int pwr)
> >>          if (dlyb && dlyb->ops->set_input_ck)
> >>                  dlyb->ops->set_input_ck(dlyb);
> >>
> >> -       if (ios.power_mode =3D=3D MMC_POWER_OFF) {
> >> +       if (ios.power_mode =3D=3D MMC_POWER_OFF ||
> >> +           ios.power_mode =3D=3D MMC_POWER_UP) {
> >>                  /* Only a reset could power-off sdmmc */
> >>                  reset_control_assert(host->rst);
> >>                  udelay(2);
> >
> > What exactly will this reset?
> The controller.

Okay, I see.

In that case, this reset also makes us reset preceding updates to any
other registers, for example the clock register. I would not recommend
doing that here, but perhaps there is no better option.

If I may I suggest an alternative solution, perhaps we can manage this
in the ->runtime_resume() callback instead. If the power_mode =3D=3D
MMC_POWER_OFF, perhaps do this reset there instead? Would that work?

Anothing thing that caught my eyes was the MCI_STM32_PWR_CYC bit that
gets written at MMC_POWER_OFF. This bit becomes cached in
host->pwr_reg, hence it's also rewritten at MMC_POWER_ON. Is that
intentional?

Kind regards
Uffe
