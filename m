Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5D52CCD1
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688878; cv=pass; b=p7psAn0dWVgB2ajbyMldC0+Bh69qcy3hQJvAQVTvnR23ZKY0JmQ9vgmAN4vj+iBPoZ7fA3PlUgaN6+FXlhCFyCyKPiTZhkZuAn9IHOvlsDdD0jRmQaOpr0bnRV1KOuy1opwtJQmBZc0/9/p5Dg0pNnuzCZkxCfurMa0vwXR/GGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688878; c=relaxed/simple;
	bh=xdAkZd2wEtIoQEl11DFO4OvMmjAe6ExswhaBRGpMuvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mC00iOjT1gGE1W2fVWfTRd+4Pg4XUiaDBuB+mlIWBpCatk4sGksjaHa6Hc4rQ092lS6saqryRevAXg1FKhRqZnj7+yMC05M+IyhgRS0o6FyEqo/c3D72c+56laWYGpXVvUn8iiP2c876DfR63VDp/Rf5svAOWL4k6B81V5Cnjuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IFEhf0Ud; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D9RdHZ60; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFEhf0Ud";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D9RdHZ60"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqfnJ204926
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x/2VXyKrtJRQUAGUnEdsbXiw+HTTQZmGx3h46vcFaWo=; b=IFEhf0Ud7N/myDr9
	dLIQf2PtBHG5tRGHFDZBLNYABTA5pWlKH8qzWR5BhGhNXLZjK+ggxr++/zuXpVXT
	wKvHX4iKg5orbC9X56+b2eG+WUbFNxYpjEoqamEadkWMlZ8ihIM/LVaVCGXgOGbk
	nrMKd2GbFoXav4wWyw974YdtjxdITOkq2CcF/pUspJCGlRuyLuJvNNkpqs43NDE7
	7HNiN9pDz4icUxxOjqp2vdDWw476FL5iCDWrhUf35g6nh7VhINafnuCEMHMlJJ+F
	Sre+nuWsMB1CfhuOWtokiZECNgdwiShed4KDSrcLQ3iyJGMr/HZitIkTNrqxedDx
	l7ZLpQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144u7p8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so4907956a91.3
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 06:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688874; cv=none;
        d=google.com; s=arc-20260327;
        b=aT+1tZwtnWXQAcKEjDfiHzUG8/V3+EQvyAmXUoBfF2IT2bhlNxWAsHl7/cfRPmP4wh
         emB/vlxvXDARs/X4UrRgfSjnPZZA2Jd48OGWCQ63mTofrfBgOClcP+HG4wOWYXsD+F49
         N2/x0Gs3EPdyFtToUkKHC3RitIWEBfX7BIbZbcJoRD1jW2zkT+C1Kc4NNw0aWL8cZpVo
         DffkI7YRBv2DJAmYhVU/agRAHyq0pxsYzaHdiBZ/bx1b6kQxPsQK/CVqnhg+ddMjy14F
         hkjftDuSB0uzmUv7AW0jmehV3EWZl5xf1oUV1IjSS9NmATZIgA0J6QanPEBFbPeINIQj
         2P9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x/2VXyKrtJRQUAGUnEdsbXiw+HTTQZmGx3h46vcFaWo=;
        fh=DggcHni0tX7/RLa9rPPNf5/6VfzMLzG9L8gSV0Nu/K4=;
        b=GK9rEgBkRLTQu2uvfvUvq3mGSOwQiFOlNnEtJ8XekiWsciCzV1+jHCvxs3e1OmNpWX
         VnvVK2NDmuCX6ANhW48T8QM4kzI8IA0FqnLpxEZ4zhDC1GL56mWaH7RhZYumnGza0zSa
         mQGNf7vBs+jqZrTnvIFuW7cOzXlFt3F2bic93YJ+a82pJuYO7prRhxvRHtrxJlcmQNsl
         qcWw4HvGo4ckNj62dkvSDz0D37GFUP1GFIYKWcLRxqa0urGkfA9tR/lBZuVgVbQ7pfL8
         BvclKADtdaSWAu5hV167C34fYW6QzU5APkzDR0R276dy3u4Ve9ORUmzfTCaWeX8Rvf3c
         qMSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790688874; x=1791293674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x/2VXyKrtJRQUAGUnEdsbXiw+HTTQZmGx3h46vcFaWo=;
        b=D9RdHZ60vY//Yly2E58uO7k3QJiYSZpGywkoxYTirU3WSSABNKYpVdKfSORMXYmv3y
         /IE2TuWY5m8+YX0dNO1gHASWqw1X0SSzd6pPthZvtGEnChn9RTTEnh2mFuAZOtU1/BgR
         MKkaKntroYAFGcW7Ssx6C7sHPH/nsbwn6d701OurQ91Ah+Rg8mF2sdBWKpBcwC1vq31B
         Wq8T7uSt68QpZJLR/7uRUmuX830mVbf5LOgeOSWpNMdd9jpVcFDB424Jk6EKusjc/Gmu
         RW2YJciVnNA0hX/ufzbqk94Hz3PJHbCtxk8/j2IB2dHtdSJHROdJLsozHravMpk879Ty
         +7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688874; x=1791293674;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x/2VXyKrtJRQUAGUnEdsbXiw+HTTQZmGx3h46vcFaWo=;
        b=UTneZZW1B/vp0gyGbLfut84/kHt3bzxBPIZchmFwHNNF8cY9B7gY3dJHwiOeLToEeH
         DgtstN4CsBV0QqR6AxgvSX4703iPQO9oROC+7l0Mkasg5YFD2dQhvFlZVziNj5C4u7fg
         CP8OpD8uZb+zEgvxh5mgt2oxsxjvmJMaCHDrsRpLr1Ll2XXIk8g+0e3Xsfv4cG55+L4O
         ZenvltrmI6DQhtPKHj4Lnd/HIF8Ra0HyPERTu4uact7h0f7HUqGUFqu07Ku8+ceVSKM5
         oF2kjXMje4Oc+35VS7n4yhcgYam99MF1aBz2OXoy+WaqC93exUMOVTXfuXiXkD4LfJgw
         Pt3w==
X-Forwarded-Encrypted: i=1; AKwUvBydRECsc7OId5hwmYNCEzGbWNE++cwlznMUbS9BdWWkhFnn+o9Tz6CZx5+NycFB95cU4+xVXb0+ZCw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcGuMjrwsw6n8JgVmWzW+d1pTDHIL9vBFob/yowluhtT2C8kNT
	5K20bx3tfRLJzAmlQOxF0Uff2eiLQ5lM0CMtoA5NotcQeLzsN/6YZmvkheMPHmQIwZ020ZWfQtS
	JZRnFAiOMenVGtbiotkIDBj/B9GjDrbNqjPk8sB8Pz3xAuHI89dSxpUJF/GXftvIJtIxH0phuN4
	uN46bl33LYXDkuZAWNL8uc4LscK/ESYZCzm9jaPQ==
X-Gm-Gg: AYBFou0OzC9CvE2Gk0sxE8Nz8QDsVBokUXDkdZzs3Yyx7E4T5y0NcDsH2aTIRf0Kp/O
	NjZdu49pGxoQFjZxitEu6wMvBxO3Qtiwr4Gn65cz0xXYhozG3cW4ITZ5b9Wh9Zcmxn8xmQncGXr
	xGrdLnLNHjd3bVAz6vDgrAWnZK62tUZ7Su7XJ/tjzvfTecPV+e8tnnPUgoYw==
X-Received: by 2002:a17:90b:1e46:b0:3a4:a356:a716 with SMTP id 98e67ed59e1d1-3a4a356a7ecmr1558966a91.29.1790688874493;
        Tue, 29 Sep 2026 06:34:34 -0700 (PDT)
X-Received: by 2002:a17:90b:1e46:b0:3a4:a356:a716 with SMTP id
 98e67ed59e1d1-3a4a356a7ecmr1558949a91.29.1790688874007; Tue, 29 Sep 2026
 06:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1790239823-139583-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1790239823-139583-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:34:22 +0200
X-Gm-Features: AclHuK8vqjp48snGXlwW_zoh_B_cN1oS8M-VQfMQ2R6Q0iq5J1fEVGI6-ZRkA_0
Message-ID: <CAPx+jO-pAm6CNL2PT3uzpL6jLL59f+hsPfuTwDNgiufaXh5pSw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add mmc_send_tuning_timeout() and use it in dw_mmc-rockchip
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MyBTYWx0ZWRfX0BZPIUXb8wG0
 DXavcGEE42KNZXuOtXl1TJ/tFKeZ9SbsiUnzo/8R4HVrAnOD8CZWXOp9hYsB4AXx3LHjuOmEQKc
 4kkzqtwxYJmwe6IbkihFwJV9CGUA5w4JYeCk+GjEF3VeUaKSMCLiugkpcWMys8behEyBpp2j6S+
 YIdMhFfphR2VGsozJ2JIC2u8xWIenSzdq3r4tbnYNmxQfqL3HsfKPxbhhShZT+S7KGNp6kd2+WA
 FDfgThnkPLVh5cpJgWjwDrB7lLgAJawk61pQaH8WmfWmivLXleR5Ydf3WNOcPLTb7BamDLPnXET
 VNOgbEMVxF+wkMRo0OpZOj2GyS1sdOWh2LHWZG68TPn7CWRTXDoVEUTCeaD1gFtD23Pj/fP7kxO
 be9AlSTnxIopnvzaT117omRtRvK2BFhQBURfDvBJCw9JrgDkD00LSRwGG8F/TrA1bgEhAjwjkXQ
 /N9YVngU4afKmEX/neA==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abbbe6b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=s8YR1HE3AAAA:8
 a=4vQkTXLE28ycPxZ2AeQA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: QAuZADU3REGBSn-5NkMRrkshkTChWLll
X-Proofpoint-GUID: QAuZADU3REGBSn-5NkMRrkshkTChWLll
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MyBTYWx0ZWRfXy3nsYGDG1zl2
 XXix0yNjrihfka2ub4Iw4TOlIbZX904yJqdpndledWt33CqquLf/3o3XA2MIcU8MHIezcykRg0E
 HxYtfqtSaO1EmpjbfqjC6/aiaS+7358=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290053

On Thu, Sep 24, 2026 at 10:51=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.co=
m> wrote:
>
>
> The tuning specs guarantee that a *sequence* of 40 tuning commands
> completes within 150 ms, exclusive of any host overhead:
>
>   eMMC, JESD84-B51B 6.6.5.1 "Sampling Tuning Sequence for HS200":
>
>     "The Device is guaranteed to complete a sequence of 40 times CMD21
>      executions within 150 ms. This is exclusive of any host overhead."
>
>   SD Physical Layer Specification Version 4.00:
>
>     "The card shall complete a sequence of 40 times CMD19 executions
>      in no more than 150ms. The tuning process is normally shorter than
>      40 executions of CMD19, and therefore should be shorter than
>      150 ms."
>
> mmc_send_tuning() however applied that 150 ms as the data timeout of
> every single CMD19/CMD21, i.e. 40x the per-execution budget implied
> by the specs (150 ms / 40 =3D 3.75 ms of device time, excluding host
> overhead).
>
> The data timeout only matters for tuning commands where the device
> never returns the tuning block at all; a wrong sampling phase
> normally fails fast with a CRC error instead.  Waiting 150 ms per
> such test makes software phase scanning painfully slow.  With
> dw_mmc-rockchip HS200 eMMC the TMOUT register saturates at ~112 ms
> for the requested 150 ms, and dw_mmc-rockchip's execute_tuning() scans ev=
ery
> phase of the tuning window, stalling that long on each phase that
> misses the window.  Multi-second boot slowdowns have been reported[1].
>
> This also increases the cost of runtime re-tuning, not just the tuning
> performed at enumeration time.  So this series introduces a new helper
> for host drivers to provide their own timeout for each tuning command.
>
> [1] Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221781
>
>
> Changes in v2:
> - Let drivers provide the timeout via a new mmc_send_tuning_timeout()
>   instead of shortening the default for everybody, as suggested by
>   Adrian, so it is less likely to cause a regression.
> - Split into two patches; mmc_send_tuning() keeps its current
>   behaviour (150 ms) and dw_mmc-rockchip opts in with 5 ms.
>
> Shawn Lin (2):
>   mmc: core: add mmc_send_tuning_timeout()
>   mmc: dw_mmc-rockchip: use a tighter per-command tuning timeout
>
>  drivers/mmc/core/mmc_ops.c         | 22 +++++++++++++++-------
>  drivers/mmc/host/dw_mmc-rockchip.c |  2 +-
>  include/linux/mmc/host.h           |  2 ++
>  3 files changed, 18 insertions(+), 8 deletions(-)
>
> --
> 2.7.4
>

The v2 series applied for next, thanks!

I decided to not tag this for stable kernels, but if you decide to
send manual backports I am all for it!

Kind regards
Uffe
