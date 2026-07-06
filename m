Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D661D3DDAF8
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342830; cv=pass; b=of2/DR2EvEYOYtBFbr5HVgHFs0txFQLazB/lnaytt+EQzr3ZdiYM2Z7Vf5KdZs6qT0nFTNrRlyBZb8sQyQ8tqMcc5eOZScLKldVRHCQlc8IacoMy1kC/oaGtZDzdJEnMSBXElpG5BZO/p7gXNbi2d2cVIlPWEEp9fxxpgBv4n4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342830; c=relaxed/simple;
	bh=eiqSJadHp3ISIKl/s1+4iuwWSYrVH6x6p9Y/invwboc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vza9o+3CbeJ1YplTIkCfUQKDuIrEHWS348LnnENaFKY5xjItiSdRVUGX3IfBYBT0Y3tAr7yx4G4Yg5gxxOOqQnU7g6yySc+2iUZdmcNRwimbnOF0GGdszzE8r1OKZ8llVC3oS/qOKrR++vVrZ6ztYl+/e5vZjflE1CWcqONf+lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R/oRQoK8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iuWUxTnG; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R/oRQoK8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iuWUxTnG"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxDiM366717
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 13:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	64MqRWRxznl5rkvRwGBg/kpUpb8ntoqeisI46KakmIk=; b=R/oRQoK8O3cMIjVA
	KRb9SKLzzLMRVTi/01Ri3FyaQK18ZToWGPFhrpjOKYhmKokjP8XGd3VNNvIbEJPF
	udkFmbM6NcpXMUoGCr8dLY3X/GNNbEPvkSh1j9SRkqmCuhNL+bgghJYVRh4Mp0N2
	L0wulUHg/pqzCvI19OEBhtVDY/w/hWD1pYVc+VbKcpxRMiQG3J63Ij38nHQXPmJ9
	HBAgRYorwgOSYECOkqLNxIeD5NCmPmRO+j6SFeksrpgttKuhCT0ttLdYrvUz0nJN
	dIe/2wdjRm/oW4t+hZa2vdjfjMl+mD5zB/H2+VyX9oNXB1CGxPmTyVoKMBOUFsvN
	a5v56Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891uryhy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 13:00:28 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ee40bceb55so41128516d6.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 06:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783342827; cv=none;
        d=google.com; s=arc-20260327;
        b=PDpmoM1NzigUVvD7P39YLhSFihwtNkYDl9P4ITjF3kBk9MjAuoS4XTutNfpIjKe1fs
         Fs5Tiym9PaJG6/VmpbYv6blVbTmAKevsllR2jU0L5C7mY5L08JUeRYxzE3KbWZ2OreQ+
         8Emu5tdCo0AE5KHDbpOhzP1TOBrOUMRopM9aTnHxD7NdSTVUAIjNUPNLQ5d2lgm7fMFL
         CPToc5IsWe1qCTgJmT1yTD/MWWF9EF8//Xgn7eomz1Rhj3DHzSu8s/Cg1AwlKsrcegi3
         dqVuMrqu8JMx8Ed0WzUUTdnhRYQ9lseFzaoH00Gvjs/zhgT5cnETUvpK/sOLYsV7GUIr
         ubcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=64MqRWRxznl5rkvRwGBg/kpUpb8ntoqeisI46KakmIk=;
        fh=uDmDWTT8mVyhTlobJr8w/gCL/ShAfZNi3CarKyQ463A=;
        b=DaYwV0wyO+g01T5Dj/Iwxil/PgsBoarf+baIlvu7faaEJ9bOwroUXGJMHc0lsaxBZ7
         TRyhX2oVFzOIvr1RUTJ/tFVcJlWwG8x1R/3Xzs5tYhEaeQk4iYP5wfNTr8IN3aECtP4E
         s3Sy8iKCAW/jIuHC4/aJoLwucxwawHFPxqmCcmUhmfghbontD5QOAoL04Vn1VX3CLW41
         ZxAuuq4J2syYmRR7GZjvQf+uqssGVHXt0189WdnIvZz8VudgfOYLP5Y5w11Vh7EdLC7j
         TZmB5nRPmvDEapomBr75pmH3pXOGRleH8CVCpXqpgaXdhW0BahYVnI14io62NF52IxMt
         FYhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783342827; x=1783947627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64MqRWRxznl5rkvRwGBg/kpUpb8ntoqeisI46KakmIk=;
        b=iuWUxTnGL9Gaf7YuF3SlJNzRm/qcw/PbSF42pTz4JuEYbijDJ74ZxwmARwS+fXPQcl
         GmEGeTc7GW2ELlYb+Z/egh/MAFmUzkQsJubjePQwLfMWm+ntHuiKWMCetTDijnb3a2Xm
         kzt3ahOAGH25c07/4cH2V/2EM1ukxs9TDbTiN8t+0OUPdcZeBfuypmDk7K3S6otQ9Ljo
         LevCQDtwfKaWa0j6sLn9v+hNiVOoOeR5P1j8mrC8+Zoymi+rI3vlMd3g4SdtiFCm8gLC
         8mTHcG/qJU6mvac82AtjA5ropkD8g3/OjIdfUucGTKNsS5X1C9JlhpcSisFiijByuf7C
         nLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783342827; x=1783947627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=64MqRWRxznl5rkvRwGBg/kpUpb8ntoqeisI46KakmIk=;
        b=XfLy87JXXZOn5wIMMZsEZBRenZ7ANbVfveEK7JYxtDwSl59OqVF9U2rHDnKy0E3jCh
         z95GaH+zRh75yhxVlrqVfz4LhC92OyCnVktw2XfIA99Yv8iivQcybGzGJ3Qdm0OLc7SB
         uekFDgTFkY2nzjTsVRftQmHEyUDmkQT3Sudx5TWSWhTs2gSbcbeuZtwIZU4iOxJtXWG4
         e7vKeKC36ro5Xvhvqm3PrBzgttUnWO/VurTOT8aVLFF02zkcQViWlmyWrWwYZ1+441o8
         WfC3akBXleBUG+AGUg2GE4GF/hBKhMxNDb25p2lE30hkY3XWv/zHhM+s9Xe1mNq06OTI
         IbZg==
X-Forwarded-Encrypted: i=1; AHgh+RrgzQWHOXr6ccsZt5a6Oz5oPTHtpjoHVp7By1niKNffyusRgCwqf633xtozgJLShC15LAwtOm5mtD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHYTRg/DrZP6vNIiN0agO2w/X36gWnnWtchFDxhYNPFfz4HU0l
	p7gVAM6ac0fESnWy/pQtVx1+89np1DzkfUaCwA59F/wPA6cdj/qLtQlZA7Xjz7rMxe/XnibBB1C
	alQq3vllLKt1pUshkjOVG+TAIWS/aERTHSsT+atfpyOjphjq0MyRazEOCFQca2vCNe4bPvtnLyo
	c2LqBRAD2ojwQz7V8RLu19QaekXfmhL1/QdPh+6A==
X-Gm-Gg: AfdE7cnrO7V6Kle4UKwNQi/LDbnK3h3MYM38gsBSNuzmbPdyiYtvzAj86mErYisasSR
	IV0Y4B2R5TrhelOut2ST0ZSgVLSDeOYXGbp1DPL6dgcze7VIpVA2bfSW1xoRhIsqb3TFoFgCSIT
	1ckqQ+p3KljOTzJLMLo9s874FLl1zPiL+Hv6wpDpBnw9oSsffzxXwupyNVfvQj6qIXPgIr
X-Received: by 2002:a05:6214:2683:b0:8f4:6909:2a22 with SMTP id 6a1803df08f44-8fcb54d2d56mr2281726d6.43.1783342826845;
        Mon, 06 Jul 2026 06:00:26 -0700 (PDT)
X-Received: by 2002:a05:6214:2683:b0:8f4:6909:2a22 with SMTP id
 6a1803df08f44-8fcb54d2d56mr2276366d6.43.1783342824572; Mon, 06 Jul 2026
 06:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116121004.1829223-1-neeraj.soni@oss.qualcomm.com>
 <CAPDyKFrOHqStZbsye9Quk71UGkzUxOkwG9yAGYFVvt+=nMJSyw@mail.gmail.com>
 <20260122011417.GB946159@google.com> <CAPDyKFoPVeu3xe7ZAxBTNFfHmf=f7OZ3iUG=pRG8mD=UOGNVPA@mail.gmail.com>
 <3e04735c-ce0c-b2b6-508d-57ec363b8894@oss.qualcomm.com> <625d16ec-052b-dfb2-61f4-bf0404297f28@oss.qualcomm.com>
In-Reply-To: <625d16ec-052b-dfb2-61f4-bf0404297f28@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 15:00:12 +0200
X-Gm-Features: AVVi8CesWqnHpSXsodm3hqYxrbuRIbmHfARMqjYVery7PG9F4Atk71NGD1KkCvg
Message-ID: <CAPx+jO8rUwYV6q1-RrA4aZ9XnomSf82fgf8Jh2fUC0fE03RFPw@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Eric Biggers <ebiggers@kernel.org>,
        adrian.hunter@intel.com, quic_dmukhopa@quicinc.com,
        quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_gaurkash@quicinc.com, quic_sartgarg@quicinc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Q6Zb9EsGqWGjFQZ8oTYdPGl2CF6GszCH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzMiBTYWx0ZWRfX1v0hnzJqF2WN
 1PNXTLTyuAHnMSzTMGeCC3ZAFSbe69ua5h49re2GV8QDaKwFf7M5uUuc+0+7KLJx8waRiyp9cd4
 soJG975jv9Pv5xKF0/bSPKBc5355hm0=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4ba6ec cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pEt9RQvNSq73iK8vQlYA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzMiBTYWx0ZWRfXxNwhpWnkxpow
 9gAtOjG1vJ0KwBj/XN+yQUh9Uh/95+3Lxruar/Lz1ArMS4SnNJauDwPFGa9yvrWjalOM7RYjP6l
 dDHHHpmT8QrSkw3VlYkSIQ6FM+mbnt2v0Y9AL9Nal8VKnYZqxPyqtsmKnqmvAp1p4gLu8ma+DmK
 mWKfR+vLxQRqd0z3JbSM4dvhQwl0ie/Exmj8zzU3LUkbD295tXhbd4teBS7B7A4usD3yDGYnGm9
 URwaUja4zRDMD1PKSOcgNE1H439y9cJFW0UwlG72D9l5MxfXVFTyqzUidW2aUUkKJWBD9RRLlPy
 BscTwNe+pG/xZkbEQdClAYbBGcppOpU2cg8G+ZscskMu6GzNXmpNDIsv2kth5FXSgCFbctXDd58
 y3EzND7FMCDZ5zWqxnkR3uZ0mRPR0+PyvV3ZOQOmN/hsjN/+0Z8KoQWJC8TgjdcFvCSaL/khCO4
 fN33hSbkGuO+OXtLN/w==
X-Proofpoint-ORIG-GUID: Q6Zb9EsGqWGjFQZ8oTYdPGl2CF6GszCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060132

On Wed, May 20, 2026 at 12:50=E2=80=AFPM Neeraj Soni
<neeraj.soni@oss.qualcomm.com> wrote:
>
> Hello Ulf,
>
> Can you please help to clarify? If there is no more modifications expecte=
d
> then wanted to understand when this patch can be picked for mmc-next.

Apologize for the delay. See more comments below.

>
> Regards
> Neeraj
>
> On 5/14/2026 11:26 AM, Neeraj Soni wrote:
> >
> >
> > On 1/22/2026 3:44 PM, Ulf Hansson wrote:
> >> On Thu, 22 Jan 2026 at 02:14, Eric Biggers <ebiggers@kernel.org> wrote=
:
> >>>
> >>> On Wed, Jan 21, 2026 at 03:12:43PM +0100, Ulf Hansson wrote:
> >>>>> diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
> >>>>> index fec4fbf16a5b..a5a90bfc634e 100644
> >>>>> --- a/drivers/mmc/core/crypto.c
> >>>>> +++ b/drivers/mmc/core/crypto.c
> >>>>> @@ -15,7 +15,7 @@
> >>>>>  void mmc_crypto_set_initial_state(struct mmc_host *host)
> >>>>>  {
> >>>>>         /* Reset might clear all keys, so reprogram all the keys. *=
/
> >>>>> -       if (host->caps2 & MMC_CAP2_CRYPTO)
> >>>>> +       if ((host->caps2 & MMC_CAP2_CRYPTO) && !(host->caps2 & MMC_=
CAP2_CRYPTO_NO_REPROG))
> >>>>>                 blk_crypto_reprogram_all_keys(&host->crypto_profile=
);
> >>>>
> >>>> As far as I understand, calling blk_crypto_reprogram_all_keys() woul=
d
> >>>> only be needed for those mmc hosts that lose their corresponding ICE
> >>>> context during runtime+system suspend, reset and possibly during
> >>>> ->probe().
> >>>>
> >>>> In other words, calling mmc_crypto_set_initial_state() from
> >>>> mmc_set_initial_state() looks like it's a mistake, as it has really
> >>>> nothing to do with the card's initialization, unless I have understo=
od
> >>>> this wrong!?
> >>>>
> >>>> That said, I would rather make the mtk-sd and sdhci-msm drivers to
> >>>> handle this themselves, by explicitly calling
> >>>> blk_crypto_reprogram_all_keys() when needed - and drop
> >>>> mmc_crypto_set_initial_state() altogether.
> >>>>
> >>>> For the sdhci-msm case, it seems like the only case we need to care
> >>>> about is for the reset.
> >>>>
> >>>> For mtk-sd I don't know what is needed, but possibly Eric can help o=
ut here?
> >>>
> >>> The comment for mmc_set_initial_state() says "Set initial state after=
 a
> >>> power cycle or a hw_reset."  I relied on that when I added the call t=
o
> >>> mmc_crypto_set_initial_state() back in 2020.  In the following thread=
 it
> >>> was also discussed that the code was intended to reprogram the keys o=
n
> >>> reset, not runtime suspend as that shouldn't be needed:
> >>> https://lore.kernel.org/linux-mmc/X7gQ9Y44iIgkiM64@sol.localdomain/T/=
#u
> >>
> >> The comment in the mmc_set_initial_state() is referring to the card
> >> and not the host controller. There have been some similar
> >> misunderstandings in the past for other functions in the core, sorry.
> >>
> >> In any case, I have been trying to understand where the ICE context
> >> really belongs and recently Neeraj answered that question [1].
> >>
> >>>
> >>> If that is not what it actually does, it probably would be appropriat=
e
> >>> to replace it with something else.
> >>
> >> I agree, the comment(s) could deserve some clarifications.
> >
> > Hello Ulf. Do you expect modifications in the comment for mmc_set_initi=
al_state()?
> > I am sorry i did not follow up and assumed that no more changes are exp=
ected in
> > the patch but i stil see it is not yet reviewed or approved.

There are a couple of things needed to get this merged.

1) Please split up the patch into two pieces. Let the core change be a
separate patch preceding the change to sdhci-msm.

2) Clarify in the commit messages that the register context for the
crypto profile belongs to the sdhci/cqhci host and not the mmc card,
hence re-programming should be managed by the host driver itself.
Typically that should be done from the driver's runtime suspend/resume
callbacks, even if that isn't needed for sdhci-msm, it seems.

3) To avoid breaking the support for mediatek drivers, I agree that
adding MMC_CAP2_CRYPTO_NO_REPROG as proposed, makes sense as an
intermediate step. We can look into the mtk-sd driver later on and
clean things up properly.

4) The call to blk_crypto_reprogram_all_keys() that's added to
sdhci_msm_gcc_reset(), gets called once during ->probe(), is that
sufficient then? In any I would prefer that we don't use "#ifdef
CONFIG_MMC_CRYPTO" more than needed in the code, so  please, either
add a new function within the existing section along with a stub
function or - if it works, call blk_crypto_reprogram_all_keys() from
sdhci_msm_ice_init() directly instead.

Kind regards
Uffe
