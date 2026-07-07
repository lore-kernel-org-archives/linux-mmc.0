Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3E3E0226
	for <linux-mmc@vger.kernel.org>; Tue,  7 Jul 2026 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419701; cv=pass; b=MeQLlvfFjpti8a69TzvFVTmr1EVA1aLormx6v5wZjXWjbbYe6h0SjrFKPlI2hGSsnE257lJzKr3LkNHKM0pcV/FLwZav7+Ee9KCebURvAdqwOhhtZILDh98UgisohaJzBKGE8No+UJAra+FchWlefVDivBXM/g8H3IzjdrUzvkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419701; c=relaxed/simple;
	bh=P7wNE9KwDPkXBfdxvhzQ0MumdXpOcQXGibUNYP6Jiag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXrsupWJFjdpKI8DvTATnRR3BbUUZpSlL4sZ2O6yCG3GKJ+pyNerG5QdsNVeRRq0BouDkFZYBp8hwvl3jEykak7aCn5UCT5TqxojnDnMAOxzmzp3J/F8jsi3udWQLSBa2TECmXaN7MzNJXARSGTI14ZrGjFAQc8bmYRFEBqXGC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DNg5NCSN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WJyzd0TR; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DNg5NCSN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WJyzd0TR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667A77DW3471485
	for <linux-mmc@vger.kernel.org>; Tue, 7 Jul 2026 10:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	65/ocuiOP/Lg2Z9GqyUJjTQQtAGNX/+jLWF3x5itRXY=; b=DNg5NCSNbM3aOTaI
	cwIJ1lwoAxPeDUAdqi8PK4WqWIAe7AgG3rbyl1QY4r7wM5ZCfw0MlGnL0P7A79K3
	f/ByeWwRIRtVfe268+KcWt4g2R7swceJdYE9HxAdJuGoy80bfIrSIT1YaO7fwA1P
	lCTRY570wGr0njozkSqbz/FYL7SluDANescjflxYDOSqSri/5Q3DtN8c+iFV1oc8
	r/eZW5G4vsH0EW5SNl6vexEsnCTx3k5lN5JNDZC5LUYfav8tetPm00SfvbNXQBep
	ezWaCNq5iMwZbNuG7LrG/ifdQwgvMER0caXcNucCa8RdOAAPF2RdrtBxgEz7VTcz
	jXzTRw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8ye0g1rr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 07 Jul 2026 10:21:37 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f1e4e0eac1so47321736d6.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jul 2026 03:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783419696; cv=none;
        d=google.com; s=arc-20260327;
        b=AVPEh5/6cKhTXFGVp02ne0PQit/CGOTB41SgaS5sL6Qn4Gu1h0XoISn6urJz9KZ3aJ
         ne5qxiYPNhm4sP2tsa6PKO7bq76VnDwuJkPmiKSZPed9IJjWkruj20XbD2BSG/WDqK+B
         FFn41X+fC/wUiPgIsSNfYTLjrMhopR6LXIgwCrcusmnehvgPBZv+ufs1Qel5nhDbAWHT
         xcNttI/QlkYcMFGcIrbKfrx8+hX1RCHERMQGBF9J92QUGf0VccKW1mLN5nmOj6J263ok
         CfOGGuEHLFYtsX/IVxFkPOQzTvnzjuhTqe9yaV0MJAwTq3vwJEslsSy6Reo9Koj3rDy3
         nwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=65/ocuiOP/Lg2Z9GqyUJjTQQtAGNX/+jLWF3x5itRXY=;
        fh=6pAuZSVqVqpSOfmfKGtIv5e668ZygKd+mAhzg8fCF8Y=;
        b=m7eBD+NP3FHNnMLJXGx++HcNffIVIHY09L/j3LXK+9lzUQg34QHSgHVd9cx7wZCkbB
         Zq2+R+I8jepS7yZGVX9fbbHSX/kdb9xDPiSxLUq5C4MGNWYqgX/Q2JGEn67gD/aNo3rp
         XofRBVUJXC1fIM2D6OMNv90FcjYdAjTglD6SxL3ZtgA8iw0qD3ZVx7TeDcZMj46zQGOQ
         dl5lEsDJOauvq4t2DjuztbXpQmbBikopX8FsTWtciyqfie0Waz9+QctteKmIvrUKEbi4
         JYMHbJDmrnnigrtbtWL4UoHRUXqBGWWzw+YQboGzrzEmknUXZCnXU+KpPmfZ52m2G2CN
         qPhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783419696; x=1784024496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65/ocuiOP/Lg2Z9GqyUJjTQQtAGNX/+jLWF3x5itRXY=;
        b=WJyzd0TRH372O1vD14ziMXmmO8WlZqHCL9c/45iYMs3nPqB6sXkgSraavPEecDadba
         R8hJ7R2nep96CVv3+zYhkEdM7n1jnp/ugzdHNtEV+JTAkdHpVbISIDy7gXWVsraUOZd+
         gYOWGg4MKS5q1Xlwzvf4ybIVhlApgjKi+eEvVQ+7tVT3H8CIyDDzzb5WvvTNuVwjwQ3T
         PafmQ2KJDO34acsWUu68fskz05FfEyYROByw7OEfzYGtq9yjKdQWbEFoU8qP4bxbTgqP
         P2bKpyYTAtRUcmWn+LitKvchTv76Ir/sFABOMAys0Fpl7mIrabXRetjzDKm5CUGu2w4r
         HMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783419696; x=1784024496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=65/ocuiOP/Lg2Z9GqyUJjTQQtAGNX/+jLWF3x5itRXY=;
        b=Rrfv86M/qkYcQea882pcE7YlrpRWXPGHSfZDXUyHS+EYlzYRbmfqBRDTuPImgTewpb
         sQJaf7Dx4vYEdqAHMLMJcbsfit74iPjm4R77Say1WeWyw+jdr4wKqI3Xe4dtjW6lOd7g
         PRqvzV1CtzhOIJzOa0GGNY/QMG59YcDwxZC3ja1EoTfLp+7eZoQ/SEM+r3yBm+VVHmQi
         SFBbvqWkbO40v24T3fvA43DO5HkEkeGU6iTdmtqyIAj1IDPtpjyaO7blw79g3KJl7Fxq
         BubpNzbD33x7cjvtjtjqChMqXtycNhANGCuJ6HvCq2QuX7IR+jPPlCx9SwR1b9pWUSjY
         o5tw==
X-Forwarded-Encrypted: i=1; AHgh+RoYz2fEvfJSMBcnGeEJa04MtO2LI+AtpqJHCasAxvEkXB+iD7B5YcUOIfCg6EQECYY7Ah0vSTHiMqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywY9VWrL5IWiT47hasssFXGR3ye/rrMhd0zvro3MCf7xA+MNdf
	qGWLoDaFqSdhItiaGQa4ust/+FuS0RgMS72CIot1NPKOrX72m+hEgTXubLG7CvL4W8+4KL6zFu7
	WAB7Hf3Yfkaw6lAd9xNH1HYEu8ojj5rDGQtUEuDjCr31TKLdKC0Mc7Slw11kb4uEd9ZaooFUCCk
	yKYRpUtJGITla1mmD/OpA7+YERXLMF5yA8fpWUTQ==
X-Gm-Gg: AfdE7clQUo+VyRabcDUp97K4MIH5O77GszFLSmbOt+tNf3m15AtEUkj7HdS6R9nm1E1
	J2o9zPiRe2Q0edkAPcMaq/Y1AMhAe1IvmKmmiVfkWszQAWax5xs+txb+SqaI3tGRmWD4zq0wysA
	Yu7BLenEjosH0Mq9m+8pmWnJUreG+ZXNipPO6NZbyBUaV/IKR+IGgVUITQkpkUuFlxKxhu
X-Received: by 2002:a05:6214:5082:b0:8f3:469e:5051 with SMTP id 6a1803df08f44-8fcb2892314mr50339356d6.18.1783419696557;
        Tue, 07 Jul 2026 03:21:36 -0700 (PDT)
X-Received: by 2002:a05:6214:5082:b0:8f3:469e:5051 with SMTP id
 6a1803df08f44-8fcb2892314mr50339036d6.18.1783419696108; Tue, 07 Jul 2026
 03:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623102353.755235-1-ben.dooks@codethink.co.uk>
 <CAPx+jO9BtwN+=Y_xLFXusTwFFv=5KDZCY_3QmSpRmskMch3W6A@mail.gmail.com> <80c8ef42-4c2b-4206-8cac-b2a32a4f2e6b@codethink.co.uk>
In-Reply-To: <80c8ef42-4c2b-4206-8cac-b2a32a4f2e6b@codethink.co.uk>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 12:21:24 +0200
X-Gm-Features: AVVi8CcW42h0uJgq0iaGGx8sOJ2Smsqf0YcrtVEWMH4vALQt193gOH6rihVlumE
Message-ID: <CAPx+jO_RNVWK=6UrrOWfpUseA+tFdMRQ18CysgzLS_WnDxiRHg@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: add declaration of dw_mci_pmops
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: -s_q4-AY9i0Z2MCmKrCvtOyNhMgp9yPU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5OSBTYWx0ZWRfX9zhM9t6YZt4y
 fpSOoKIpm/lfyACYVo0KUvUqkP279jLE6hKd7hux+97Ha8nYDWKNaJvRAEidCXTcWpVL/va3fsw
 0Iv6xmLrqqpZ+uvKUgN6Gi5AUoUBGtg=
X-Authority-Analysis: v=2.4 cv=SZfHsPRu c=1 sm=1 tr=0 ts=6a4cd331 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=1EsaE_6oAAAA:8 a=6noQlTxZJicgy54chnsA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=3ZumFrijQQ-2J9H5h8ct:22
X-Proofpoint-GUID: -s_q4-AY9i0Z2MCmKrCvtOyNhMgp9yPU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5OSBTYWx0ZWRfXwJMhOTmt/AbN
 HgQzFgGN7BGod2gsxK3upPOTZ6jw1872vv1pu90e591YyBcQ7XR1lVjEJlgyWBsK/kJ2k4zVtKq
 /RToQfan8sv5YpA4iJUDMTNd1nEBzMd88QpeGEnAVzUT5HF2T3qXGrOqHLIHPPfKszHLu7wq0UR
 +Ojq1DwCciYyoaWA1nBzsXoCOz5Dk7nN/ZWuI8dBOQOUXxb22zZ4V7wBP61aCUCF7WdX3bZf+1a
 xtXouvcAS+gfN/0ToNqs+m273JhX4oCp4DmqWl9DIQl924Njtr2RnzksFdvFgAeMPSep9Q9Cid1
 +W/rfmkleVCAzm4H05Z5yh5sjGm0r8BSWNwVmd8xQchqoYhdzy/cWQNNA0tJpNP0VYRlNCLOQkr
 aVQZ8x3JBppKtHC6vvuN1NZZ8j/4HS4LlGOj+f2BSXLDx/qiAQatZbyLxj814RijjfMWRnnADst
 K4sqh2RrMdnPnfNZZSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070099

On Mon, Jul 6, 2026 at 8:25=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.uk=
> wrote:
>
> On 06/07/2026 15:30, Ulf Hansson wrote:
> > On Tue, Jun 23, 2026 at 12:24=E2=80=AFPM Ben Dooks <ben.dooks@codethink=
.co.uk> wrote:
> >>
> >> The dw_mci_pmops is exported out of dw_mmc.c so add a declaration of
> >> it in dw_mmc.h to fix the following sparse warning:
> >>
> >> drivers/mmc/host/dw_mmc.c:3512:25: warning: symbol 'dw_mci_pmops' was =
not declared. Should it be static?
> >>
> >> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> >> ---
> >>   drivers/mmc/host/dw_mmc.h | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> >> index 9ffcd3946cff..38610c89d54a 100644
> >> --- a/drivers/mmc/host/dw_mmc.h
> >> +++ b/drivers/mmc/host/dw_mmc.h
> >> @@ -19,6 +19,8 @@
> >>   #include <linux/interrupt.h>
> >>   #include <linux/workqueue.h>
> >>
> >> +extern const struct dev_pm_ops dw_mci_pmops;
> >> +
> >
> > It's already extern declared in drivers/mmc/host/dw_mmc-pltfm.h.
> > Perhaps drop that then?
>
> so just move it into dw_mmc.h?

Yes, that seems reasonable to me.

[...]

Kind regards
Uffe
