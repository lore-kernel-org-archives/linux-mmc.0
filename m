Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795711903;
	b=ytwEiDNzczMhb32EdfBeVYqxVaW88KLG1dJfWxLNDYEAypeex5Qa/A6/X7vY0RV5T/au
	 jDUNU/ZRv0LU2fX9jAYQ4oCjjRYrfF2r4fv9sUY3I7MUmBUrCQF3Crd2kYdwKWhKaBklh
	 TVn0IOJGEKWfHs8XWQZNyQJH5Wgu2aU2//8eZKfg14lX7TycW7x0DKUkd3TA9bAe9DWZv
	 y9WSylUWPyed3qd1OeaDEJid6lXKfTtEOoJVVtjNrLWmFsV54RUFCidg1Zlk+Zz8KM2sk
	 YKPcDXF9wPg8whgP+rGAFCwX6s/tXI7Uem4SLvR5DA4WX2URDI0SaNaGj6ZTbtFLnPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711903;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4L45K5UzzHSSd9C5bR3fkwjaNK7JRzE0XRNmy460r9o=;
	b=DCXY32bZ3NTiab3fCXpeXim47ABPMfBHVskbGRc2sKymKYhv46kvKe/0t+jXeIJf5/jG
	 AcGI5wOw8H5P3ew+fSKkQkGYdlY/e84esfpyed+3E3Yu8CoG559Z+hgIXp6NLtkiEI56d
	 Vm1WeWZgRNM6564aR6PB3bnGCx/wN1VvRBbeIAP7Vx/aDBfM21+ZEsxKepAQPWyzu/TM2
	 bXsmm9Lnt7XC0hRaGqGz4yNR2QAouJvGpvmHtNLwCc7I9PrCH7RQrwrKQQLX4m13Gwou7
	 mbV2sUGMdW0ILKlRpk3LI2PXnRkNkcJ7/iLyvF6WNh/ZkKfIv0Lr/fei5OHYQscVZkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VUXwsLnE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=amGfpBzH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB9F606A323
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 16:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDB9F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VUXwsLnE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=amGfpBzH
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQFu9VL3328839
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 16:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4L45K5UzzHSSd9C5bR3fkwjaNK7JRzE0XRNmy460r9o=; b=VUXwsLnERin7OHsu
	YlLK/cimg/N6nMwtb/3rFcpTDCS0vg6LajJtxShugWutizcqc4BlTZ7M8Hk+AzA1
	2h0ErmKLGxEdvk/fVu2qs+h+rFQQDjNHaF63+PaWnhJrxh3M9wud0nV2y3SpYSnY
	yrQYkXmANJX6tF26ZAq2Y1Fju3zWRtKvoYUUYnb3oTjQOxEB1vTMEjepS8BcF6C5
	N26j5DjPdfos/ks8jEk2Dph01gCbVcXUhZvjnJZM+I0uXYCIFvAE8KD7sTI0vNpr
	256p1oKqxZX6sennbCWMvGUG6Z63ikwLLWptj3M/2qnhPUBGs8HI86z7FM7XH3K2
	AeMgMQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahw8u3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 16:51:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b45655b428so6073373a91.0
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 08:51:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795711901; cv=none;
        d=google.com; s=arc-20260327;
        b=e17OG8srGV+pNQ2u/9SuzLVmmP28tFQVcELU19vCyXiMJ3b4KcKQKztZQcP3FdAiO/
         tFO+7uupwz7chODrqrqwFv24B3RK8lQgaYoyGcUK6i0p307Jd8yt8VkOt/dd0eLeQ2zD
         ii9AwLQ3GsGU0H1NccZWbUUm9GaDTEIOciOFV/wG7WUJgBSEL3AOrREE/VHWCLK9ACXp
         COB+FN5QZOh7vIEH2h7V1w/8iZ11ZO0NPhHamRIL3wQ4I45ZcUF3QotTNcsIvnZi0m7a
         sdIcEdNxR+C4I+ozlCVQ37pEHAzpEPuAWQN925pq3/avRXUgbarMBbBCm3W9CUfbdr9B
         2yQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4L45K5UzzHSSd9C5bR3fkwjaNK7JRzE0XRNmy460r9o=;
        fh=78jDE0jfwdIARYiSjEGav94JdqlTBafuMXI+TjZQXus=;
        b=ePr7Qp7KHT0ZCCrUcUVeEDA/4shL6QaW0RCXNM5ZDg6J3PjkKwHGZ2wsnAXYqxsrw+
         rAnvYciuX4UThXedN596VH0lP0Cvjxwr9/IYnc6GLItWWE4F5HZRA7ndh4o+iYPJJ/rK
         OC8VlzN8O7pEy+YFsbDmn5rjnTChqp5SA+3t9ZqGetXictg1KKlggSiLK47YUsgfwK7H
         u3sagYLhoIwJSVznWqUfLZcBMdqV/O7WkIFG2FLYV2dtsZLUqUS0dN4A8VJjzmtf+Nlp
         BT+RGmU3eqmilX5F/lgpEeT35xKiIfBH6qfuthJ9n5FGa9x0Jl4weaJNshkTjT/yK2ag
         xy/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795711901; x=1796316701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4L45K5UzzHSSd9C5bR3fkwjaNK7JRzE0XRNmy460r9o=;
        b=amGfpBzHCD+BX3hHvBWyv85KpPxZp1lsG0jrWfKICQO8+qxsxydACyJ/k2pZkB9wrh
         K11phOjYC+i9MkSiFNNpLJlArjBJ4s7L0nip6nX7phSlrgvS2XiLEw241yRx0NaIXfv0
         StBJ1LctBqXzcafTuvvbtl1I68UproQLBd5Ht0wDoMnFt0UNlKF4KJFYV2jKFjxSVaXy
         jBIJ/KRWkA8GeQApAYQ8r427F2+kYChCaA5UDmaE772JhtKfbHle2ygH4o1Zy3tbyFmR
         37r1/f/cvtVc88voNNvOlzD4lNWHJRQQxcZJiFQpfAW3VHcoE2O04Nw8j8/I4ss+/faP
         RDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795711901; x=1796316701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4L45K5UzzHSSd9C5bR3fkwjaNK7JRzE0XRNmy460r9o=;
        b=lGYrVbbYBbmAAtNeXMpWTNC+eHBxFvv38B47f/UL5otSu9CPVgl3Qaez1Gn4TIFqeX
         T+hRzFYn4TGII18D3GNLW/FOSGr2BHne9aS4+U8OVOXO8Xm9Qql4zvIQ2+1d1MAeGSOB
         adqG9h8OhDkVxtbt/0OZoj9+Nt6lnrvkUAeXjsu+WZ7TN20VMUF4RVysIl4PT5DVOMkB
         f5OZg0OsKyb7aqHd1oyRR8OxBi5k6wHOQynX+CJAwShW8AI4mYOlx95X+nQbbDzCG1sx
         tF/pVyNZqS0l8QVprkpagnEnkldlKyAaXDvfM57/tcfvUOZf2frf9bYcx3ycDZ+tbMeg
         DTMw==
X-Forwarded-Encrypted: i=1; AL+hErHuHE5SrMiqL8UdEp7G5twZ42LcE2fgyCmW3nOnmo0Zhck5A+dTtvO0iH+ZCZScRswgnKyaC2pRP8k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SnPJwLfTH/VNEf1DXE0hmsq1nsnRDISEP6oWve73O74xEOiV6
	Hv9ZXFLPUr8vfhZHfBYibVJEoclbO+zu8AjxTfSLE9883ZGuhGoa3KiRlSPDKXVrIaykvVUJdH2
	/826PvaESCpajHRxlwM03FbSKnVDZgKORCzCt6IA+noUXjbvsCXLNVs29gkcqwAnVGfvZoGQQl/
	4Nr+gRm2Cm9vGGw+8qmoFTMspPf0jPus5Q+x19Cw==
X-Gm-Gg: AZFdTZdi7Ibar2awlYCWW4Zt7QczRttvThCUdL5MWiKWOyCO1L0fW3vwFgO0m+oe0/b
	4LQD4j04/vDO2IJ0Ww3io297PEgwjVavtE/ESXcvJHd1jDBJhgdhm4FAxe+0LaClLFWXOYBPd3M
	VNRM1Kiw+UWKZXIs7l1e54mr0VT7mNgaBtLGtlyW3eFdMTULuYUufSRnolTg==
X-Received: by 2002:a17:90b:388c:b0:3b0:a378:1cf with SMTP id 98e67ed59e1d1-3b41c9b2d39mr21437074a91.22.1795711901524;
        Thu, 26 Nov 2026 08:51:41 -0800 (PST)
X-Received: by 2002:a17:90b:388c:b0:3b0:a378:1cf with SMTP id
 98e67ed59e1d1-3b41c9b2d39mr21437054a91.22.1795711901047; Thu, 26 Nov 2026
 08:51:41 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103183030.81078-1-jernej.skrabec@gmail.com>
In-Reply-To: <20261103183030.81078-1-jernej.skrabec@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 17:51:29 +0100
X-Gm-Features: Aa3M54rgEbRi4FWdDNfEkN6ZYS8yeQYigoLC6T4hTzlJeEwKiPC6M76vYk98AsQ
Message-ID: <CAPx+jO9=UzwQVnmUfTpOoYxYhjEPv9V9AyMOCWv7iXDw41bZ_Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: sunxi: fixes and preparation for A523 UHS support
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Anfernee Cao <anferneemelokc5@gmail.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: w2iHpHbjUm-fcKIKOrSk_XBb7FuIfwQs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA2NiBTYWx0ZWRfX5BSo7G+nmsLJ
 fpB3OZhVBjlzaWlWQHL5SBWxHz2IhmQv62VgIecOqFz+tV48Xcp5Kt6bjX3WI0NCKcev4LVH2p2
 LQCxlZF3zrW7oQzxdTjJqbzX2k/7Ro8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA2NiBTYWx0ZWRfXzkpM+oAFjkY+
 3w0QibhoClfAXjuSlwLgKEqf3DBMK8nyTEIwIOeh8/xI7l/zPS5T/hLJE3WemuKSqTuh+jgNZvP
 i03uvaP92bphZYkTwp6jmf9gmDB10oT+spgMOxT0xGmAGZ7044iX6C694WzCqrRQ6yzS1HtXcQH
 6AQQgdpGvuIvtE62kliPDMFagLnctCZPQO/nZUUutnEOHpss0ZYkJJot9KWtVof5o8Ria7XxM7N
 zicXNFoPSiSYHSJ8kz8LgozIzlV1MSqrxtpuW3zqM6a29Txm9QFNJHTYnU/f0iXahKTQH01UfGo
 EHhIVqaryuMCM64ChqTQ+9wBMpSZPUlrJaT+wEutCO8cDYKp0ttgDhDEMItcDcYpZ+zISylmh7/
 ixqLFoeBQxAA9lxknw5YVB6hfZqqy4S3711jo5daqI5uTcY6BD+b3cu0A3TuszUcccIC5uJ/TfF
 /a6fl1zC5hGTLQBCZTw==
X-Proofpoint-ORIG-GUID: w2iHpHbjUm-fcKIKOrSk_XBb7FuIfwQs
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b08639e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8 a=8rAQGYXpxwjhbX_W7ZcA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260066

On Tue, Nov 3, 2026 at 7:31=E2=80=AFPM Jernej Skrabec <jernej.skrabec@gmail=
.com> wrote:
>
> This series fixes a bug in the sunxi-mmc driver and paves the way for
> SD card UHS-I support on the A523, which will follow in a later series
> together with the A523 clock phases, delay-chain tuning and the PF bank
> supply switch.
>
> Patch 1 fixes the manual stop command error reporting: a successful
> manual stop command is still reported as failed, while a failed one
> stores the error in its response instead.
>
> The remaining patches improve the DMA setup and error reporting, which
> the UHS-I work builds upon: a DMA mask matching the shifted IDMA
> addresses, IDMA descriptors built from the mapped DMA segments as the
> DMA API requires, and CRC errors reported as -EILSEQ instead of
> -ETIMEDOUT, so the MMC core can request retuning.
>
> The series is based on mmc next, but depends on commit 5e32202f532d
> ("mmc: sunxi: fix clock and runtime PM leaks on probe failure") from
> mmc fixes, which adds the error_disable_mmc label used by patch 2.
>
> Tested on H3, H6 and H616 SoCs, on multiple boards, including Tanix TX6
> and OrangePi Plus2E.
>
> Best regards,
> Jernej
>
> Jernej Skrabec (4):
>   mmc: sunxi: Report manual stop errors correctly
>   mmc: sunxi: Set the IDMA DMA mask
>   mmc: sunxi: Build IDMA descriptors from mapped SG list
>   mmc: sunxi: Distinguish CRC and timeout errors
>
>  drivers/mmc/host/sunxi-mmc.c | 122 +++++++++++++++++++++++------------
>  1 file changed, 81 insertions(+), 41 deletions(-)
>
>
> base-commit: fd9af27f6c2319713bb23832066585f8a59a1771
> prerequisite-patch-id: 8d600908a2eb84acfcd034482dd6e345242f1464
> --
> 2.43.0
>

Patch1 applied for fixes, thanks! Patch2 needs a rebase, so please
submit a new version for the remaining pieces in the series.

Kind regards
Uffe
