Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB4514774
	for <linux-mmc@vger.kernel.org>; Thu, 17 Sep 2026 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650616; cv=pass; b=gnx4DXSrNuga0GvDjk9yaoAo/UoJSXEYqQghETILuQoD+iIccWL17GiO0QMMb++agTimidFWJ5EXA/NmcephDEtjlINiPAqGQRSZ7BmxvxgkVlWI2FRq9VJT8qbSM+rkVn1IeSd9XFqJRImV3FtDhxkUEmUuhfz+VrFTewn1sj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650616; c=relaxed/simple;
	bh=dSn/lYCGf47xluUTvALJXGbm/i/dzTFyyRRAL+e7HRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKEhkeAKp4IvtLPjJ31+Lcfk4Ke6Nup9c4iILVE4U2/u+13Nk7HL6eWOz7urAMst10xExZLn+drrljq1eLg43OANFyfqermS32LxmYhwrjRCSyg4a/U3B5rVQooLpWJUJ7cmtuDHHEywPLGSORvOmgvsHFimtQVn32EP693ose8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h5LO6BYp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ijyCWsoi; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h5LO6BYp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ijyCWsoi"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HBopPx2013128
	for <linux-mmc@vger.kernel.org>; Thu, 17 Sep 2026 13:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dSn/lYCGf47xluUTvALJXGbm/i/dzTFyyRRAL+e7HRw=; b=h5LO6BYpTXAH5nwx
	VwuBSfEzIGBVZY+9K99uOxxLNxaGkJyTt4VyrwOZoNAcIhfJeVVSAZ0eCaIQaJvS
	nDVEOCFYHSRyevvYxRN1OWXFxpvJz3jbojOzibn8tN8m54CTzFz6Ac9mjN6JA+dq
	pjPJ2KGX4qfNJTznoMF9junvBNjI2gDnqyYGB7Mb2+jxCxx9Lc0W50NkZSoQnd15
	WvZyMJQ8f6ojh0k3aD687Sdon0RPTgkQ0kO/g0rU/8BaMDwpAT7IT08qPc95tjEJ
	Mj+NIYVuL5xZvvLVQ/0eLmGn3p6czFlPjWYh9vvJHXu6UEqYdabOfzVt5bKjiKMR
	XbgxQw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grfppg9ce-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 17 Sep 2026 13:10:08 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so1733897a91.0
        for <linux-mmc@vger.kernel.org>; Thu, 17 Sep 2026 06:10:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789650608; cv=none;
        d=google.com; s=arc-20260327;
        b=YzDiVLEzYCKx9NKVgD1It0BvX40d/b4PBVSu4erh06f2ZyXH5oeCRDscXBAmQevcnM
         8PiBzZ+EGN6MVeLXZCpZM4RCGz2QvdXfyOk6AEUxOEVMyapFERNXN4vHs3/WiMv+FDts
         DA4Wj7EleVDUDXUYTh7/Jvm/cnP0YDSmhxc6BWCS1jzkHqu2WWvaBxtLIBgw61KVHPpy
         oXcrbgfO0rNgGMSWRuPPhs5djkM6VaHZ4lVlUyOa7vcGTAG6JMBO6hz9a1zTnzHJ2jnI
         h1FkJE1fr4iwu62mXjnMcB83uHYSNXML9hJm1kknCGaCKQ4fPLnSvGmLnWvUYx+0t01r
         wsxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSn/lYCGf47xluUTvALJXGbm/i/dzTFyyRRAL+e7HRw=;
        fh=Nv9y5tHef6GRcJbbnQalQM6xWAkoQr/cWlXnAc6GUjo=;
        b=qVnmDIhBIsaVS0AkVmPobo5mSDW1EalhYLiibAiHWyhpaNCYGB3LySRZCN5x0nBId5
         MWa05Hhr3nI6uQPij76sG8MxIQ9QXkFo3jG10dS06lZkDHT4WNZVoASBb0uoC2BsOV60
         KRW/NEwh/5mtRZmnbBfUTZ5NKQf15n6nJAYvGwgqGvA6nNC25e0WKwC6j5w0UafD9pMW
         vyNZgi/xVZhgx+OWnd/7abYXztTeT980fGb5mjN3IW6yeleiKxq7fjjfV49ltCJ3YVv7
         cQMwuVnqTj14y1Luru+/mruyy6Dcouq+M4uP4MyiKIUyQdXZG3Q9DwvoXZFArNgmWgoK
         AOBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789650608; x=1790255408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dSn/lYCGf47xluUTvALJXGbm/i/dzTFyyRRAL+e7HRw=;
        b=ijyCWsoit4oqsavP6utjnmAj9dlRZGniBMbrAKl9nel08X72/JFlWBwLpB/bwW4fY8
         A03WrJ+gtgkijRIKhJHOhe9gX581DWw8oKemynMVTUIsR9TsThcXFcYsceOjwuOc2yda
         bIMTavfmFlO3xP2UXZkwRNWW8oP0pGZ8RlLTCtOotKxQNZvzoRXWySlfDtdVEJhVT4Md
         LT6jQ1BdGKg+arXMC3JlI422C4/EL/q/c5ke8czKiK1f8lqaynOYzz9GfGUtdhzO1d4O
         i2rPIsvSZUPOyg2MiTjOSJDVba6oAqFEL9ofhAYcjiVv8hCvMmQe5OQ+ow41aNNGI7yG
         eRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789650608; x=1790255408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dSn/lYCGf47xluUTvALJXGbm/i/dzTFyyRRAL+e7HRw=;
        b=H2O4XBKVqaUpL1YBW4NsvFOPOrATdjoAw2RKtPU4zGfwo5TQvnVn5KIrDqxEc/Wta4
         sRm7UF3l0wPqlUD3/pkQiOvynRdDUOpNtqqCzevWDTE71CiNnCS87ZYLf6V860iWYdph
         LsQ0pNLh63R9+Z6tnJHEYaTJTRzmRANRK9DHSCQolzz93qpEvyAxaIGU+GiZKCyIsnqA
         1sSYxuNose2f3Iiu21sYqG6hOu+HRDWyHTGGNMlKeeBY57VqIJ3nlPJ/bBjaA78oWD+1
         YuJoOJxgyzwZOsNDawxgimBmBvtZtF+ukVy4ApfIbo+vhSuex0qw0Rft2x/Vpiohw4nl
         tQ9Q==
X-Gm-Message-State: AFuF++lJkgPLvEiGxvuYX12dx65ylq4KBpEJPlhjIj+Sk0I+RW1pEQB2
	3LeD8x/YShP6MUd/ElsXyBCfc6snNzQhOnMvdm+6ULFHKrpkwFnvhZyo2O37r3lHbWMqbXqX2yC
	7GqPYlCQrW+fu3t33dOXmJKgcLnbLliQ3tylASSsBaPF2Z21J5hBeWf8c5gvKJkqIgZhwxWxYAk
	xuJJA+3CUE/PvtsmyT2W4bs2IDuwYnbC+dkrX0nA==
X-Gm-Gg: AYBFou1OcpEKPDpg3N8tTyGOvZY2FP0Y9g7UuvEr57q3qTWrubyuslJg7quYqh0x9WI
	hZneedpS8PaqI5nJ3gW62TDtRkbbjn0rGHpCTGfbo5lrj7AMdW7uzKkXPdArLVtfWr1f0L9qXgA
	TcQjDNJ4AAs6ptIDWo2E65oN11T60x/DScITS7KhOtzsm+pCggrkGDUi9V6Q==
X-Received: by 2002:a17:903:40cc:b0:2dd:7979:246 with SMTP id d9443c01a7336-2dd8e633921mr148273455ad.16.1789650607508;
        Thu, 17 Sep 2026 06:10:07 -0700 (PDT)
X-Received: by 2002:a17:903:40cc:b0:2dd:7979:246 with SMTP id
 d9443c01a7336-2dd8e633921mr148272805ad.16.1789650606942; Thu, 17 Sep 2026
 06:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915132052.273212-1-ulf.hansson@oss.qualcomm.com>
 <20260915132052.273212-3-ulf.hansson@oss.qualcomm.com> <aqpIl5NWCFiuKy9b@hovoldconsulting.com>
 <CAPx+jO86Sy+of41dw3Gi5CNfyc5+iOyDU4CZypz4YGzG27QW0A@mail.gmail.com>
 <aqpovla0rTDnmwRh@hovoldconsulting.com> <CAPx+jO8WS3MqzS3txy1B3FnQ9OzRjDGzxMLLZ+Mys-jqego3_w@mail.gmail.com>
 <aqudoCAtZTgq_31Y@hovoldconsulting.com>
In-Reply-To: <aqudoCAtZTgq_31Y@hovoldconsulting.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 15:09:56 +0200
X-Gm-Features: AcwNN1XmCRz3ewGD_qaDz6B9arOOIwfnzlm8ZiND-YnUnSWbnYkPL_h4vprGqQc
Message-ID: <CAPx+jO8ETnyiZ8i2AJKa03HZ-iOryjf3Y8DPOqqvu-W_9ThZFQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Turn mmc_alloc|free_host() into static functions
To: Johan Hovold <johan@kernel.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: -R6f9RoKRcYzdwf7ZeyH0Gof5bhAeDtZ
X-Authority-Analysis: v=2.4 cv=YcYodARf c=1 sm=1 tr=0 ts=6aabe6b0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=ODYK8XF4EdztDUzRPCIA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: -R6f9RoKRcYzdwf7ZeyH0Gof5bhAeDtZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE4NSBTYWx0ZWRfX5DhmHDOw0779
 l9y+4ZTIXjTI9CRmy/fZBFUFVCZUbGsDJYmpP7tkbbSY/K51SvddJXmvxY7UEFwI6gXRfRfsG7F
 fsmev2BrKTLk5MGTcEW7nNEuGnE1GnEW1MAO0cq1zqNDQAGs3gp8lVNUBK00Vc7GsZ7QCU1GagD
 rQaxS9sI7Zqy3xO7bJIgUoO17J1CzKkEoG5nhQ98NPS7H7GiR7zNdVwv5ewjCz7uSBWg6yeY0A2
 y3Jo/8HnLKdNr46501lH6C+BDNkKVcL4adFlsZt98kUBAdJCJxNVzNvUVRfAmg6jEAOVEeUtr7a
 aGo2SEoFLFhtII/D1F6NUJ3JGaa91NNzgWH3oT1Adv1/vwdtriTFt43Vs8AjnOjJD5txo6v2CGT
 Sg+slIEROoxvK1DfihPgTV9RiNiiZQ0/VE1O2hg5DcQT4pLzOgOocVctqjDK0CnDmWf7Sn/TfWF
 vjH3ek5eL2AKRiNBN/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE4NSBTYWx0ZWRfX8z+nedUMt9Pd
 eAVWeM8RqzlherXWlsndwMooAxiT93BYxZEAoU2WKbzpyP1aeipet2YyL3PJxc+tQV/VRBi8hGx
 M4MNc6jBN0N0d1HKGm7d4ONJ1vFqLzk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170185

On Thu, Sep 17, 2026 at 9:58=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Wed, Sep 16, 2026 at 04:12:10PM +0200, Ulf Hansson wrote:
> > On Wed, Sep 16, 2026 at 12:00=E2=80=AFPM Johan Hovold <johan@kernel.org=
> wrote:
>
> > > Devres generally only works when all resources are device managed.
> > > Therefore you should always provide the underlying non-devres manages
> > > interface as well so that you don't force devres on drivers where it
> > > could cause trouble.
> > >
> > > > > Especially with the work cancellations present in mmc_free_host()=
 (which
> > > > > I have pointed out elsewhere should not be there), a driver may n=
eed to
> > > > > free the host before tearing down other non-devres managed resour=
ces
> > > > > during unbind.
> > > >
> > > > Can you please point me to such an example so I can try to understa=
nd better?
> > >
> > > We just discussed the renesas driver which can schedule rescan work
> > > before registering the host controller. [1]
> >
> > That isn't a problem, but it's not the right thing to do as
> > host->rescan_disable is set.
>
> Ok, good, I see now that you also cancel the rescan work when the host
> is stopped so that seems fine even if the second cancel when freeing the
> host is unexpected and bit misleading (as it was added to work around a
> driver doing something it should not have).
>
> > > If such a driver also has non-devres managed resources that are freed
> > > before the work is cancelled you have a use-after-free.
> >
> > If you are referring to the mmc rescan work; mmc_rescan() will just
> > bail out as host->rescan_disable has been set as soon as
> > mmc_remove_host() is called (see mmc_stop_host()). In other words, I
> > don't see how a use-after-free would be possible in this regard.
>
> Looks like you also recently fixed a related issue with sdio interrupt
> work which also wasn't stopped (see commit 6feadbecdae6 ("mmc: core:
> Cancel SDIO IRQ work before freeing host")).
>
> So I was referring to all work which may still be running after
> mmc_remove_host() and potentially call back into the driver being
> unbound.

Okay, I see and understand your concern.

Although, if things work as they *should*, the mmc core must not call
back into the host driver when mmc_remove_host() has returned.

*If* that would be the case, then there is a bug in the mmc core that
needs to be fixed.

>
> A quick look at a driver using sdio_signal_irq() indicates that this may
> still be racy. In dw_mci_remove() the host is removed and clocks
> disabled before freeing the host and cancelling the sdio work. A racing
> interrupt could have scheduled work that may result in MMIO accesses
> with clocks disabled.

In this case, mmc_remove_host() also removes the corresponding SDIO
functional devices that correspond to the SDIO card, see
mmc_sdio_remove().

This leads to the SDIO functional driver's ->remove() callback being
called and from there it's expected that the SDIO irqs gets released
(see sdio_card_irq_put()), which must be done with the mmc host
claimed. If this isn't happening, it's a bug in the SDIO functional
driver.

Yes, there may still be an sdio_irq_work scheduled beyond this, but
when it runs and claims the host in sdio_run_irqs(), it sees that
there is no SDIO irqs enabled anymore and just returns. So, there
should be no calls back into the host beyond mmc_remove_host().

>
> > > I only pointed at greybus as an example of a driver which has non-dev=
res
> > > managed resources. If there is (rescan) work still scheduled after
> > > probe() or remove() returns, there's a potential use-after-free.
> >
> > See above. This should not be an issue, at least it has nothing to do
> > whether we are using managed resources or not.
>
> Sure, if mmc core guarantees that no callbacks are made despite the work
> being left running it should be fine. But that does not seem to be the
> case with sdio interrupts currently.

See above. SDIO irqs should work perfectly fine too.

>
> But regardless of any potential races in mmc core, my devres comment is
> a more general one: subsystems should not force devres on anyone.

I understand your point, but I don't agree, at least for mmc.

Instead my take is; come with a use case where devres doesn't work and
I am perfectly fine to bring back the non-devres helpers.

Kind regards
Uffe
