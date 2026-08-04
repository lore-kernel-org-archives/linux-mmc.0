Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F29545A2A9
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785842108; cv=pass; b=moi8prB1IMh1ZNwdr1TWJa2AhF9BDiSB+AhCrlPPs5aoOQkeXcb5A5JzA1/tUsg0/c4bfs5FiLlPtRleG9anXwJQx9qlYAxtC4IjU85JhlEZCEmLyUQ/vXgclUZrn8Y2unJ3pDExgzzuBA8nQq00em7GEPmwyEqh96EFJV3pv4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785842108; c=relaxed/simple;
	bh=B1hmO8jXIEO7PaV3TkwuJAmsXF9Gf8g1uuHWkE3kRqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e26Ma78hQVqhXJH3vJ++icORZC0IKEJYy1w6UfaB1koVsq9iHdrdkjVHZsjE85zN7pGk4D765AUknM/71Sv6aZVNLm5le6MpHpTW6aS7p2pSRz80mDKggRvYitP2DLIGVaR4G6vyMVeiGOz8X+pT2/XRg1Qce5cZPE76iROGQNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f0iRK3a+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C+7T1dFJ; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f0iRK3a+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C+7T1dFJ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748CFmv3034301
	for <linux-mmc@vger.kernel.org>; Tue, 4 Aug 2026 11:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	52R+QMzPDkl+NQTZQCm43R/hfEzoiVQdhDHxPtxU13o=; b=f0iRK3a+JbdzQPVS
	QEvAAMsYS4Il7T2OiVt+AnMEsXJwviF4eQMxFc/p6ZyvRERccvQaFMO9ezNxHZfP
	LBjOL/fsdcdThDxByKSglSxWywaNMKXvxp+kuujQHq2bCd+5IU4ZQFvdbWFE4gah
	Jk4jw6c+PL1W7alsy+cQsreOXpIXn+TAxtdKnfSPnVWP54vORVU1rnGrQOzI0NzF
	YU5qfUrANx9nnWvS9VJ227uByq2nglTUFORDs5JyldHGolKFxT58fcO+N8q675CV
	/nkLYZkYZ/m7IPtdTpKzb6aDoS9aEHiypPtHfY6+bmHXx6qj+z6NI/OIvYSWxUvr
	mEP8XA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty3qm0m4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 11:15:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e63df032bso79513385a.0
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 04:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785842105; cv=none;
        d=google.com; s=arc-20260327;
        b=du9LbfpWUImYohf+ip/v52jzvIsalP6+IT/u7kgwF3yRtsBVpn68uNwaQjTi8lcqzy
         eb487hhJTPBOSFmFtoc7g6zVNWk1C0Y5hZwgPqEP70NnLzpNafzNjxWtTq3om7QCOCK3
         m6H1L89yRBzr13tz6rwKL2LkYu8EUoCBlLEoCAAt3lM0IFsOD3S4YdBE/bL9ZPSv891R
         Bn2RT4TuD4Sn+phXvl6hKhVz5EN3Wt97kJAW8JEmrW34yaBqlNMbYxFnmN1OX6eJvDiw
         rMed9XKJeO9D5HSgIietZ9tAgJF3763DDA4Mi3+G4IbyPl+9rLNBxzHv0ctygpR2Odop
         pz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=52R+QMzPDkl+NQTZQCm43R/hfEzoiVQdhDHxPtxU13o=;
        fh=E/UpxW1kDbWp4OwAvYX3BFFH5syjPn8RNAPmHfECDMg=;
        b=pQgFxAdQfyhXDN5MGV2ZZ31Q1zLtthf/xrx7vxIy+CPzFmr00KwO3luL++yQUtIqjh
         I03SzezEvh4yRW05EOJNLwpZzYlBGVDlKCt/6iKHtz31SUvIET1jNMO/0cru8sdXC01m
         Tt/dnHnA/uIo3FxcVEUT4BSpEVK/UhKTCxIign4PziYRI2bt/bUmEFV4Z2/CwmqjUlTC
         oJPvHjSBKkpD7IRuvF6aE4NKtlcEq+BZxmjpu+UuPej33AjZ44fJnM/0EQgF7zQg3C0+
         d5525BqEgbif83vSGMJe6/HeeNfrYN7qTobkgWNidsogDJqoXD6QpfcPpG8SeywzmtbZ
         5SGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785842105; x=1786446905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=52R+QMzPDkl+NQTZQCm43R/hfEzoiVQdhDHxPtxU13o=;
        b=C+7T1dFJyPw3/2pgARO/t/2CTaA+U9esTGQWsHYGPYH3MiLJCk3r+wFNo4BrD+6fxi
         p6RYCNKhhODO5oGTO9freEEHoDNrzz4b1fiJND+2zoMTsC31+xUqo8MpPO49zVCmgXNL
         pr1S1pthFkoATkgXSEAW1EAFjlJKDntEj4jt7jYbiMB1PTUlDJby99roKhVnvIaU3XJU
         1Bhi+WROuaN3U5wVvOJ4RWdx2sKVlPpwc0EzMnPOCfXX6biq+ciuoDPnKE7qgEZGhsvl
         546oKzr1uq+Kqwyo5P5s8YMzYGCWLLYxjx6AjmEoCe4Be09VY1K6nqsDVyjgQdzpRur7
         5cIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785842105; x=1786446905;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=52R+QMzPDkl+NQTZQCm43R/hfEzoiVQdhDHxPtxU13o=;
        b=Bpwn+LWpnmIGS4gbeh+y2n8XQuT/cUjU8XNFVUGyD3+cXZfWdNJsCE2Fet3C3Z7rmK
         eGGZiQlCV26+G0muRFSH7/8lxLv7oxtEBqV3wl/2gg+obwdt8hfuqNUF6NPIMPBSJzom
         GUag1/DiHnbbcBypnSnVqLMFOu6n2IIbdRbHrDyZztWxuvKUmZ0hvyHaFUeti5AEEafq
         4uLf7fg9Rm7GJ/KmTVz1Q5250rlz689V1s5FoGHNshedzOYGyz0bzrREAVNRligHCwNW
         M2mr7a3aHYsR3pfPG9oXLMWO02j8IKHDq76Iwh48dvgExhKAg9UFfYlBmi851FymDZEp
         g8HQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqry5EvkjD4+447yjOu0xswGybDNbzvb133dZDQQrcZLQ+nR5KguQLdQeF87i0KefYwNBoX3+PlSIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzljNILFr1hnxNUMjuZcUk2qmfMkDYXcrrKvX9S8glzx45fXhkv
	JMWnknqqg4x7iBVNdMsVT0SeJu6oKq+dTln96aS3KR7w1xHJiu9PTFg5vZgjH8E4wKgllem4eTx
	G6AEoDpIIy3XSN1gr9RPqEzNuQ+qJMrYmAiqW41X2/BTmWFPbUH0HREbyPYXbEwwfB/LZgIV1YC
	C4blffh9OkCoEJk5JIsNVszvg0m7q9F5BKKcfQAyXwB+WfXYgg
X-Gm-Gg: AR+sD12bueNVhrxlL839R6luCNEMQ5nTwTlUY9EtMzIRi73Ix2OJEJqA6HbN4sfi5oJ
	gIvejlMqdLN1Fgk9QhIGHKrKRi/N/6sCcJpyN9wyom9FFVca0TgsMwexvKJheNBcWmL/21Mu7qL
	rmi0vQ0cdLZiOnbv0Ss1gREzfypOMCN/byXA8I+6ZRFe0uYSwgqNgDY55WUw==
X-Received: by 2002:a05:620a:51d9:b0:930:d48:a3d2 with SMTP id af79cd13be357-93631984d5bmr406517685a.21.1785842104819;
        Tue, 04 Aug 2026 04:15:04 -0700 (PDT)
X-Received: by 2002:a05:620a:51d9:b0:930:d48:a3d2 with SMTP id
 af79cd13be357-93631984d5bmr406512585a.21.1785842104418; Tue, 04 Aug 2026
 04:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803163123.1802005-1-neeraj.soni@oss.qualcomm.com>
 <20260803163123.1802005-3-neeraj.soni@oss.qualcomm.com> <stu224dgiay6mau2enqyf27m54laucdzqaudya6wxcnm7ldu4o@omftbvyuvmqa>
In-Reply-To: <stu224dgiay6mau2enqyf27m54laucdzqaudya6wxcnm7ldu4o@omftbvyuvmqa>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 13:14:53 +0200
X-Gm-Features: AUfX_mypoSUK91Rd8buA_r1AEfxdX1ZW90xiiqDRvPYyeMTjOiciexB82CuBqiU
Message-ID: <CAPx+jO9ikCQBLxzc8814C3LnFHQoejjpL3kUvCXE5T3OkQYz6g@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mmc: sdhci-msm: Use pm ops instead of macro to
 restore crypto keys
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neeraj Soni <neeraj.soni@oss.qualcomm.com>, ebiggers@kernel.org,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: dNYOxnRpz8P2ruK6knCF47kWsUHcDVxD
X-Proofpoint-ORIG-GUID: dNYOxnRpz8P2ruK6knCF47kWsUHcDVxD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4OSBTYWx0ZWRfXyLfngcWtq3I/
 RTLd94/lI6T4/yrMkDp5lOV3vNwP1RDbbMXfenenSZ5bN8XbWmWHtELcSV4bIeGRwTABjpEzFsF
 vIVhsGux4yZOjBxfFJABgEdcL4Q7nmNcP/x/Pebie5+Z3nk3eIq0kK1Froo8NGP+QlXkB9P7BrB
 OBK6PlJbtr5ApmvtQRulaO51AKeJms9OiAer/zq5xyFFCvaY+msgd7hMN7j49PolpgyAhDcEq22
 Zcn6/Vo6E9Pnh/4A8xIwMnti2XfMSeDnyAZRhoUm0MxSRSfMGHDndjTWApgjysS3TpFjGbdDjiu
 v2MNGZD2oaU3TqdUGBbPqFLIqGd1Ahn8b7ZaaRFm/bVcF963GetXn77qQibe6B7MrYKpNqTp4AT
 Tukg1sJ7PoEc6ASSa2xir1L5LD+0tFR+fvvGebGin+TmoTaqsAQcvoDbBMv76N7mwHM1donB1Jv
 0wAO3fCPxX+flOAiVNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4OSBTYWx0ZWRfXweFDiD1iN1jI
 WFeSt2ZUO9kr1LaWT4DnnPyUa9sDMky/gz/aYA5LTLWwwJk+bK/DpuToOGK8kUO5eTb3aK3b1sp
 r7Pf2vImQVFQJZAjec5fwLjQur+zcrA=
X-Authority-Analysis: v=2.4 cv=ONEXGyaB c=1 sm=1 tr=0 ts=6a71c9b9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=tekg7-5syIHPVG6I5CMA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040089

On Mon, Aug 3, 2026 at 8:10=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Mon, Aug 03, 2026 at 10:01:23PM +0530, Neeraj Soni wrote:
> > From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
> >
> > Inline Crypto Engine (ICE) keys are lost after hibernation entry and th=
is
> > needs to be restored when hibernation exits. ICE keys are re-programmed
> > during sdhci_msm_ice_init() but it may not cover cases where the
> > hibernation image is already restored.
> >
> > Unwrap the pm ops and use directly in driver to add the call to restore
> > Inline Crypto Engine (ICE) keys. This ensures that ICE is brought into
> > same state as before hibernation.
> >
> > Also set MMC_CAP2_CRYPTO_NO_REPROG to indicate that re-programming of I=
CE
> > keys is not needed during MMC runtime suspend/resume.
>
> Hmm, if there is a flag which controls reprogramming of the keys, why
> can't we use a default and make the core reprogram those?

The core is responsible for managing the card, but the crypto context
belongs to the host. Similar to other host registers, it's better to
let host specific drivers deal with those.

In regards to the host capabilities flags, we decided to add
MMC_CAP2_CRYPTO_NO_REPROG to avoid breaking the mtk-sd. But long term
wise, there should be nothing in the core that deals with
re-programming of ICE keys, hence MMC_CAP2_CRYPTO_NO_REPROG should be
removed at some point when we have verified the behaviour for mtk-sd
too.

>
> >
> > Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
> > Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
> > Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> > Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> > Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> > Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> > Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
> > Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> > ---
> >  drivers/mmc/host/sdhci-msm.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
>
> --
> With best wishes
> Dmitry

Kind regards
Uffe
