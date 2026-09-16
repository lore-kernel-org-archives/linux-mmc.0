Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC1B501F49
	for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2026 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567946; cv=pass; b=NzroENwnxub7ft+cJXq4hA+hGrLUWrcj/yVM1dgf2Jqim0FYXVeRg+mjnPQoZPanXKswKXCKG5V4VhXUXmfkvM7DujfgJX86JBKEDZVQko6uyv8rF9e7U1aVKathw1YeT2/O1UK5zmZCzXGvpg6EmsStIQRvQNjXFt50ujyMPWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567946; c=relaxed/simple;
	bh=d7Znp5NNZxYJd4Xe/QgaIbKxuaLC2x6XIlcie67IVG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSt5uHu4pbpFg8//W9SB0Maan7NP0lmXtjSmHmcO2PuG1fPCRKPTpRXMD6zzEN15fVasIh3e7sNk8kkJ4xnvAXuojlo47Ug1RsPBSFlSvK2asCIJlyLUStjqQkGy22ICOWptCookzeytdOngrHtdr6VeZaOKAhPkvhhBGmZV9co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hZbJrQCt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PvFZd0Je; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hZbJrQCt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PvFZd0Je"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GCYW9o3636646
	for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2026 14:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d7Znp5NNZxYJd4Xe/QgaIbKxuaLC2x6XIlcie67IVG8=; b=hZbJrQCt7xfhxnKG
	PbBGY+RlohLA50nEt3lLit+T5kj2GQb0umm1euW424NEYPuNvULZDQ/0HMxuAwzH
	Ul74ycK1A/oUcAAOKrj5b6zt+rEzIEnQRcJdnB6lbCHGvtl0FQgR3gOd+VxtfqwK
	HvhKsAlhSWYTSN7pDn87NeHlr2T9psF6uqPx38K5xRFOtGQAfTCDfxJuPulg2rZ9
	5753pJkRtQ4XCSsAPtSBdx2nlUOgxZ42V/CFUA4fuFRZEXDIQUJs3TeKZeloFeiF
	X7y5m4Cpi+DGYJHc4X9Vmv7bA7xX3csTnYCPLRum/B+bVTYsAsblHP2gRU4UYnnH
	b4ldEQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqpu2sk9s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2026 14:12:23 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8699b293a80so6226437b3a.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2026 07:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789567943; cv=none;
        d=google.com; s=arc-20260327;
        b=fbG+gh6DXkbBMceTlqo35SRc4dWzxhYMf4fc4l2unhLPUpRAwRq/fMlze+zj2XRJ0l
         5G+VpqCDJDKwHX24w47wN9KoCjWLJuO2V0IDmUou1V6W0bd2BAT9dXUJTG/afEAnrPVP
         FEF8kJY0jYqcIgDN+dzOvaOgEd+eF3NO7EHPdaRXKyI8sPciBTScIJKuNSJRc3k2O1d/
         FFwmYKUiDEDatsUjIOAXEonHIcOMLv8vWUqX1nqDWFmr+T9yKxHE1iyTFETmcHqCTG0/
         YeB3Yc2iEvpZDnumZ7Iy5GzEUe9XwMey2GuaC6mEqOsXAYdXGRLlh7h7dN07OAayT4Gn
         7sYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d7Znp5NNZxYJd4Xe/QgaIbKxuaLC2x6XIlcie67IVG8=;
        fh=Nv9y5tHef6GRcJbbnQalQM6xWAkoQr/cWlXnAc6GUjo=;
        b=TDiqRZ3fZta1TbcpMWapfdos3iSvchcGPe9MOUscO932bNd4Ukl5hg8VOzgPpKCPKh
         j16BgwFF03qB1kSabNRaQb2RMppDCugkvz0TmMCSvJlq5Eit+JPf+cFa00ofHwvQCW+Q
         RNTn/QCF2XvseuKC7XvLQfozwvwFdrJtKeix4Y3LwJjTcb2N/gNbS5Uw9eQFzKWOijL8
         n93Oczlu7XApn6mNdC1VJ0l1BGpPtMUR7hZSNWZxlBdbN7+gaQbkIN83V5Y8H1cC2kNt
         T6vy0R0aDOuR+6fSJTv/ZIFNLpM/DRGDxbNLkZIyP130o3sFcgqliyrFtXRS4xJa1O9h
         q3vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789567943; x=1790172743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d7Znp5NNZxYJd4Xe/QgaIbKxuaLC2x6XIlcie67IVG8=;
        b=PvFZd0JeK1BNCWNBzotqtYpJkNXcsj9lv7tilhT+PGxw95/7ydsERZ+qhX8yss2zOg
         2/yqLKZGE7+EBXPYZ4a5e6YMrfdHl2XNC9+4iyRnfEFmYF5S4AcmEvrwUP6fUiOacDqz
         yaw3qYNU+xJK/vgJfm1ShcInb72M03rcVrgke+r4NhOFRpO7PBp8QBI8FPD7KPrFKahP
         mwy8W3fsGNdlG5RFmTLBitUTOQUFz9MusI54p5s3iJRylWLXRrA5RItDYZqnt9xRMN3V
         w1uLI9Ha09/fmTz7KUGFEtKxyEuIusFX7QjDAZSG4z12bjTfSFPhWeXj7QbNqz7E/Cki
         7rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789567943; x=1790172743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d7Znp5NNZxYJd4Xe/QgaIbKxuaLC2x6XIlcie67IVG8=;
        b=nXHX15xKMS03f3hKoHL4YY9RIy5KOYXLorJiHWIolB2YpbxLWe3nOqX6Bul99s2ZfT
         WjYj/KMTNsOU6jMmlqx0smQuOiqzSvL0vPHHRqKc8aBa06ki0RZ409/QrL8DZDeBF3aA
         aJBhSse0dF0SReStGZ+PnLGoBtoX9MgP5LahPd14SuI6u/VXS+Q+OavO6UoKgLXVl4+4
         Yv3Tz7s/a1EJJKP7fTh6iHJ9oZaXIC9uc6X2uIvBuxmb8w86GjrplCVIhMuuBAqEmxlk
         WWFEQ+lvWdQnzpbgLMfZ0UdpZ4rRBxLL89ndfso9uehG5oc80b/xfDRHnQI58zj79GTy
         z02w==
X-Gm-Message-State: AFuF++mL/PC2dNJ0C1zKatY4aWyhlLKAFtKsriUEOc1NHnEb0Y70zTFS
	+fXTL/kOfjOWTTQEOAWC6N6BxDHzUDqhwIEe+ovTPepJMZCK82kaHKTvOHKwXNTWIOWWBghIyJr
	uDXY9xZKtj4FA7m6uNsuvAfZ8fLcHPstKEGK9qxGHPMv8sBRG9PuLuow59XH3lfomKaNS+NvN81
	0lUM8qSleQRm1NlD7+YUznbZwn+uVy3eV22nMTuQ==
X-Gm-Gg: AYBFou00pF6P0t1VMu12cXU2jLMUVt0Zu9U3i3tEZHA4QJpolTcVDWDMPCqaxOFh+AY
	cOYRgNvPbCG/nFbtc03weXhmkeINWsImUtiBzXTc2Oa7dVztODijuPLZhCrWNgxawhdm2+rqQWN
	6YQQAIDQwELPCT7FnO94OO7hftCHUo/XaS6QG/sGFO4zBz9Q4h0k9UbL4Pvw==
X-Received: by 2002:a05:6a00:300c:b0:848:2e3c:9955 with SMTP id d2e1a72fcca58-872372c3f18mr6019653b3a.4.1789567942654;
        Wed, 16 Sep 2026 07:12:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:300c:b0:848:2e3c:9955 with SMTP id
 d2e1a72fcca58-872372c3f18mr6019564b3a.4.1789567942091; Wed, 16 Sep 2026
 07:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915132052.273212-1-ulf.hansson@oss.qualcomm.com>
 <20260915132052.273212-3-ulf.hansson@oss.qualcomm.com> <aqpIl5NWCFiuKy9b@hovoldconsulting.com>
 <CAPx+jO86Sy+of41dw3Gi5CNfyc5+iOyDU4CZypz4YGzG27QW0A@mail.gmail.com> <aqpovla0rTDnmwRh@hovoldconsulting.com>
In-Reply-To: <aqpovla0rTDnmwRh@hovoldconsulting.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 16:12:10 +0200
X-Gm-Features: AcwNN1UPNXOQLfdSFRPJAlCiq-g_reRwNd6uIUSpPLv6c1bEYkBTby_bsRYsWRY
Message-ID: <CAPx+jO8WS3MqzS3txy1B3FnQ9OzRjDGzxMLLZ+Mys-jqego3_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Turn mmc_alloc|free_host() into static functions
To: Johan Hovold <johan@kernel.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Mr9KhEgwdo5UvgVnWBZaX4DBTDxRdI-4
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aaaa3c7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8
 a=sgTPu796ueBBQ-pzyZoA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=xwnAI6pc5liRhupp6brZ:22
X-Proofpoint-GUID: Mr9KhEgwdo5UvgVnWBZaX4DBTDxRdI-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE5MSBTYWx0ZWRfX1n6KX5U8JFEa
 eYZ0yxaF6olMWVEs+s4ME5CxgRVMPIG8oerKvsIIblvu6pLq+X+5fbRwRlZq6FHvtgk9SqgTAEL
 /Ko+5RHI55QhFsTIkPAAgJrlHcksAhlXdv6m63fsbCBl+k1O2GV3a9ooGMD/4IGU3Mw7PTGxB7A
 HYlLmiQKVIXZMC3NFJcVTesx0N4qweKhyfo0j1pbS/TlfEPeiGlmLx1rUpPDnZGcwP1PREQDbqQ
 F/LoEq7m+nByaljCB/1qEpAa/vgUXoY9OmrlCI3OIpWYAN/aHoBZaqNHVehGl4tBtkEv3bmlSOA
 vQ0q9BpvlVAWWPtICY4RBmClkbNDZhWwHSy8HlH2XKkZ1fB/dECqv3JZ0NDsQK6ZR6gslWriaP2
 iQKhQlVNzZ53Fh/UgPAYlObqijyKFfZp33y7fCoJeG1YLF37YUBDlHAdRn/zmeh62Y6d9db53cN
 Wm+neCM6cWpCwBLN1zw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE5MSBTYWx0ZWRfX8auSJ8gqpe/A
 egNCeWFv/t0SimrGAvyk3NOhQrIXvZXUI2Sk7oKu4bGISB1bkcaaJkFWrNaY5LkxI5gT9VbpABE
 KR+P+T+JIeSqLQX7hpeyhBIKOSU6pQM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160191

On Wed, Sep 16, 2026 at 12:00=E2=80=AFPM Johan Hovold <johan@kernel.org> wr=
ote:
>
> On Wed, Sep 16, 2026 at 11:36:25AM +0200, Ulf Hansson wrote:
> > On Wed, Sep 16, 2026 at 9:43=E2=80=AFAM Johan Hovold <johan@kernel.org>=
 wrote:
> > >
> > > On Tue, Sep 15, 2026 at 03:20:46PM +0200, Ulf Hansson wrote:
> > > > From: Ulf Hansson <ulfh@kernel.org>
> > > >
> > > > As there are no longer any users of these functions, let's make the=
m
> > > > internal to the mmc core.
> > >
> > > Why would you want to do that? The devres helpers should just be simp=
le
> > > wrappers around these and sometimes devres just isn't a good fit.
> >
> > At the moment there seems to be no need for them. I would rather keep
> > API/interfaces as simple as possible, so I prefer to remove them at
> > this point.
> >
> > If we see a need for them, we can always add them back.
>
> Devres generally only works when all resources are device managed.
> Therefore you should always provide the underlying non-devres manages
> interface as well so that you don't force devres on drivers where it
> could cause trouble.
>
> > > Especially with the work cancellations present in mmc_free_host() (wh=
ich
> > > I have pointed out elsewhere should not be there), a driver may need =
to
> > > free the host before tearing down other non-devres managed resources
> > > during unbind.
> >
> > Can you please point me to such an example so I can try to understand b=
etter?
>
> We just discussed the renesas driver which can schedule rescan work
> before registering the host controller. [1]

That isn't a problem, but it's not the right thing to do as
host->rescan_disable is set.

>
> If such a driver also has non-devres managed resources that are freed
> before the work is cancelled you have a use-after-free.

If you are referring to the mmc rescan work; mmc_rescan() will just
bail out as host->rescan_disable has been set as soon as
mmc_remove_host() is called (see mmc_stop_host()). In other words, I
don't see how a use-after-free would be possible in this regard.

If you are referring to an internal work for the host, yes that needs
to be managed correctly. Although, that doesn't matter whether the mmc
host has been allocated with the resource managed variant or not.

>
> > > This may even be needed for greybus which currently destroys the
> > > connection before freeing the host.
> >
> > I looked closer at gb_sdio_remove() (the greybus sdio driver's
> > ->remove() callback) and I think the problem isn't about freeing the
> > host.
> >
> > Instead it seems like the call to mmc_remove_host() is done too late.
> > To me it looks like when the mmc core tries to power off the card
> > gracefully, through mmc_remove_host() the driver has already moved
> > into a state where it no longer accepts any requests.
>
> Yes, that looks wrong, but that's a separate issue.
>
> I only pointed at greybus as an example of a driver which has non-devres
> managed resources. If there is (rescan) work still scheduled after
> probe() or remove() returns, there's a potential use-after-free.

See above. This should not be an issue, at least it has nothing to do
whether we are using managed resources or not.

For the mmc_rescan() work to access the host internal data (for
potential causing a use-after-free), the host must have been
"started". See mmc_start|stop_host().

>
> Johan
>
>
> [1] https://lore.kernel.org/lkml/ap7CaVj82BJZgjf6@hovoldconsulting.com/

Kind regards
Uffe
