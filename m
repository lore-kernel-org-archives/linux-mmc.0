Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793283452;
	b=aI7vi72n1yuqbhfXvuP50QO1tkeWoiViUl/OaPL51n8GrTBbILzV7FaiORL2AOd1Xk4H
	 2nyMlW/WsAEnT95RkikvkqrSHq9u31kNKMNtcbcnaw45zU2ZLjMr/0EV1+HTPC4vFBb0P
	 tUVTDgu0yS3FPbYfE5vXfmyUYR6prUpH1iK2IGlrnl6RnkRHxt/19U519YJbhancHcbtv
	 IchVxzCOydHlmCXMJk+1igpwREdLfcLRQ2ay1jTef1R55/o1ox3XiVtWVay5JBEffh2xC
	 Au2bhRc2dwHf/dYQa09BoYu3fhewgoLuS3N2MnpfT/LFtxS02E18EUh6ErLWXW3O75Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283452;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XePhe4mIyzoHuWMx1ZSPHH7Ab0CP3siwIwYmV+A8biQ=;
	b=PZhuHbFjigpxzk6Lp0vD3dsQdbQZdKBD2TzAhJ96g0hxNcCpz4emCebm3a1yEftCiZxp
	 ioSTklcWisUJmAo4XNJ4oiq1peOzj5XVpEcV6VNnsjSU2qkuHXz10GQid/vlqlhUVkkcg
	 xXkhA7X0uZwVug9ld733WNTvHZOeOeemYQDH+S8m47Twk/9bowu7L0EMwk3r5ubFe008q
	 OFD3nxUF2lEROOlTvEX1PBV915n1UoYZtxATFwDFZOON6b7wev4jOycLUMrww12BXse5Y
	 wJmVkDmFjCbPXzYGSqLYy8wHYzpt/NwDAG4EYlpGfWXrYqdZpwjvGZl6OGbjvLQR74Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MQtlFtN3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Sw/b8bTs";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F1606A31E
	for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2026 14:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC3F1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MQtlFtN3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sw/b8bTs
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCeB8p068287
	for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2026 14:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XePhe4mIyzoHuWMx1ZSPHH7Ab0CP3siwIwYmV+A8biQ=; b=MQtlFtN3Sm1zrKcl
	CXdHmjk1+4i2GVB87eTjCAk2iZ8XgI1ju1LAU9fXlFhNV3lr/9IrVHRJwAFbmdkm
	Yz7HoDbI3x23yjz2RH8Y3Buc3UnPlD7fF/Ua3OZYZE3Q6G3I1mAxGmbI3ZOnuBy3
	eia7RL+aIosfPaxgTMXhqvIFStyY4pkAGFJOMM+U+SSBGWn6HtliMKf4PNqmhyFe
	fnPaDJzPbHlf5JWHqENY1GquhwD1AiQPuMErzzn7/YMg0dl8MXa+Cy/mnjFjGFeV
	QKy32Fe913pIGO8sJQKEwvtopj3vAplKqWNOyhSRzxFOIwTfa+59EEnBiURPWoSJ
	S55T+A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkxsht5jj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2026 14:17:29 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so2338914a12.1
        for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2026 07:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793283449; cv=none;
        d=google.com; s=arc-20260327;
        b=pp06AtWCPmf8xD+a9eZ4q99X1mczz4UUopGR1rLhI6vH8KUl0J1n03tQgRWBKH8T8z
         5TqJcpMDWWm/XU/b0icZRe4Fj2DCs1fsQEpkAgpBZG7HLlLkGMDv9pp4noS3dyT7WMpy
         cB46f0Z0Np9VDlOKB4J2UIZ09AIyDSntP8LsPckJMoCoMi/+l2quNaBtyMFL/YZX4skK
         m5fIW0SA0KcY9zfFNSThLiI2VRWr2/yY+rDmpCjHNgT8BOsaCw3tvPritdGVcW2G6ioe
         S2vT3gw8+RkgJULbhRUJKjfuAI8lj6bL3+fOZpWmJPJxS6KNWlxtfdyzSQwpE1R6Mcli
         RArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XePhe4mIyzoHuWMx1ZSPHH7Ab0CP3siwIwYmV+A8biQ=;
        fh=1PWjehdQOcZr7pNrrZuBGvJo9HpJnySpoatOiGqEBf8=;
        b=O9WaeHOEAnkYOVQVUtdey3YA14wL0qhcQFR637jFVZmhOJK/h1HDfiRSnJf1xFyZGa
         31Xs1tYVCn8vA/vG1Sau+tEOzjYWVY6dgMFSzMryUxNYoe5hvLeKazBdJX5XM5LXhreF
         lZ0I0w0BBAq49qIw6y9e+SMcPlzbtj0bD5QEDx6GRMf4DHRyp9JKvdh1Z89W6VEAUS5Y
         5mXKNXd9wPLqtQABXWyMOpLeGTnMD7pnoIx6hVMUC4Ba7LSK0N10DAiKvaDq3qladJ8w
         6Tt8tlbq26l6iJQ1SKT5EUYHTr4larx8Wntm9TAayJTZx+tk7+KlOgPedqj1Vm0mU3Qr
         GpYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793283449; x=1793888249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XePhe4mIyzoHuWMx1ZSPHH7Ab0CP3siwIwYmV+A8biQ=;
        b=Sw/b8bTsQfxu/z+k24fBLGT07MMd7ACMJvRejrPM90Mr1uFqvVz16CsrSostXfY+eU
         iQZoq1Al076DAAb7Sv2WGFUUs5Sb+06UlXNNplNwuSV0RZ+avbRAKFBf0wZtrGaJPcuF
         jOL0yqyzDsgIkuQE3RuZMnpg5D3gWVYOxC4DelV3Fw9VbzUNdiKUSTi3pCxPAhau1IYg
         8COh687ecHXdvwQjXKfcfydzNMOJacKDJUV77XStTrqUobbXTaTjmAt9KHshYCIOFr/M
         kp99KYBINixmPgc+5RcfQ07HADZYh2J/S+fN/rATga7TVck/wS0LMmtXsUsxUJft4KM9
         V1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283449; x=1793888249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XePhe4mIyzoHuWMx1ZSPHH7Ab0CP3siwIwYmV+A8biQ=;
        b=wRh0NIHrTFUDvVwrlHIEB9f7Hjy9+Gygv8+9AeWBluUmLT4Ha2hy+IDqgYEUGOJOQW
         m3b2KwwStp47Pb1ndyJf/DWiL8j6XW3307F/9zd44tYlcZzBZCrn3b5ALGLvjypw8Grv
         2nxyEOuGxp3r0bVZ6I4+SWncTFv8CQMGI0xxYwm9LHTZ2f8rJG+w69CMty/oM/grt0FX
         WbBa+MAuAMA0MWj/LMrMGti+Gk4abnx3NFF9mEA/T02y85eSoENn4msBQf7sy/jm9VNM
         bVv74VLwbOpwqp6NFpVf7NBSBJqBUPhVj6JTJZYddTt21f3muS5/xiEAvaiUyRE1VY9k
         /7yw==
X-Forwarded-Encrypted: i=1; AKwUvBwvahHdfNPNk5kZMoj2/lsdT6KgIQjYTEHzPVxkuvwT4PWSLx74zK/ZhfJzndBr/bUwZfwi1jS2WpY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsLccakSPZVAKrXEdu/RcDV0qZ/Nk/uObDywmP/ZU9SNYA/EH0
	6krg2XVoxY2dBYVpkxhlvZPjrxQUlc+/tuh6XAE7abQo1BWkXkwJxMRe1dE0Yv47P9/KeyOzXFy
	SqU/EGRcoDgwYYBLlE7+7rD9Z+77l8r+azEf9RsCnAoBF4XxT1BKtM0MZIOezJHUOtE+FNZA0/y
	luegYL3f5U6ScUa2XsFg1jgEO5h2WWvIOGqTASlw==
X-Gm-Gg: AYBFou1Xj/EsPgR5SEnV3oCQbuR6PKCYhhQyl/qgzf0nITM8SiCD5tDAoAdtnDm1Yes
	Ec1+pjaReZ2WEij1GQUBPBBG7yWs/34Z9knP556dg3vt/rZ40nv5XWvYs6AOsWjFr4AQp35E72L
	EcaFYzpHVWPaGfu+prIPIuRCRTr8JlzLscgfYTjfyGrYvvTgBpW+WNP9x2xA==
X-Received: by 2002:a05:6a20:6a0d:b0:3e3:1013:4665 with SMTP id adf61e73a8af0-3e90234d9cfmr5486424637.48.1793283448667;
        Thu, 29 Oct 2026 07:17:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a0d:b0:3e3:1013:4665 with SMTP id
 adf61e73a8af0-3e90234d9cfmr5486382637.48.1793283448152; Thu, 29 Oct 2026
 07:17:28 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-qcom_ice_pm_enable-v1-0-f7a84086c651@oss.qualcomm.com>
In-Reply-To: <20261022-qcom_ice_pm_enable-v1-0-f7a84086c651@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 15:17:15 +0100
X-Gm-Features: AclHuK-yG8GjI7p3wdC6k_i_FEVr3l0Mml-BhNjxuIZOPYfSt36zwQfp3z00yhg
Message-ID: <CAPx+jO_ywfJUAGs6Zo8yJyTpqui=qN-T9qqWN2hKCyeegAeF=A@mail.gmail.com>
Subject: Re: [PATCH 0/3] ICE: Enable runtime PM support
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: shSijODKVspH0HHBHvyd6J9HjfzpPzLT
X-Authority-Analysis: v=2.4 cv=H6BOUOYi c=1 sm=1 tr=0 ts=6ae35579 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=MNM1_axOnic6cDGTpHIA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1NSBTYWx0ZWRfX3jgo3M6lzYn2
 YeP8PKsDxZ77llHL01DB9+g/asS2zaffrszmPvjL1zHbPgse1r0NVovVE4wStPksmr+C5pJgKXX
 BrZBm6bODCxmni+296WbpatE+x5F0TU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1NSBTYWx0ZWRfX/wIwZs7J7l92
 iRdi9wbpw6jgErgIudfB/AZqpN+G6kqZgSaFTycAuISW5zogEmhkJGL3+MdenVBhv1Ynheymcj4
 IOlvPPyKY9pHyFyNWa9/y60zCdJNa0tS6x3Yr4nE+l36V7bRkiBzk7hZYYYIhZikSFQ6WTziDlU
 PJgWZCwf/pJ+yJx4HfPsdPB4NcK3aHhELcV6QhjOlhPT8uWP1L1hUzVAZfp5jtSODbAMWUcnlGG
 VFMI2QRdsfM0438IEPmi4ZHwlgUX1ntkEvQNsrBVO200u5S0oB0Ip5LBdahLVmQt0Sr6QQy8o8b
 dsMiDdfSHgeau4whh+Jq8y9K2x4unP876XsBu80T+zjeU0Bc8gyU87Jtsjt/mAfyQsGu1lPPIRT
 G3QGQd4G39qPqBWDCc4tRyZLUzAAgVbzU+4jv7GPMc9k+Ye2dKFehz24HO+n6Osk1Zwfc9u6czW
 aXCCDcNsezNjJZ4nKkw==
X-Proofpoint-ORIG-GUID: shSijODKVspH0HHBHvyd6J9HjfzpPzLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290055

On Thu, Oct 22, 2026 at 11:52=E2=80=AFAM Kuldeep Singh
<kuldeep.singh@oss.qualcomm.com> wrote:
>
> This series fixes ICE clock lifetime handling when ICE is modeled as a
> standalone device and referenced by storage controllers through
> qcom,ice.
>
> Currently, ICE driver enables clocks during probe and keeps them
> prepared after probe completes. This keeps the ICE clock voted even when
> the storage controller is idle. Add runtime PM support to the ICE driver
> so the standalone ICE device can enable clocks for probe-time register
> access, then disable them and remain suspended while idle.
>
> While enabling runtime PM in ice exposed couple of sequence bugs in
> storage drivers(ufs and sdhci-msm) as any key programming call used to
> go ice and never complaint as ice-clocks were always on.
> Example, unclocked register access happened from ufs/mmc in
> qcom_ice_program_key().
>
> qcom_ice_writel(ice, 0x0, QCOM_ICE_REG_CRYPTOCFG(slot));
>
> Fixing this issue require ice instance at early ufs/emmc probe so that
> correct sequence is established and ice is ready to accept key program
> calls from blk-crypto or any explicit storage operation.
>
> Merge strategy:
> Patch 1/3 and 2/3 are storage driver fixes and should be available
> before patch 3/3 lands otherwise will result in bootup crash.

Then it's perhaps better to send patch1 and patch2 first to get them
landed as fixes and for stable kernels, then when that is done, please
resubmit patch3 separately.

Kind regards
Uffe

>
> Validation:
> Tested on shikra-evk, kodiak rb3-gen2 and sm8750-mtp.
>
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---
> Kuldeep Singh (3):
>       mmc: sdhci-msm: Enable ICE before enabling crypto support
>       ufs: ufs-qcom: Enable ICE before enabling crypto support
>       soc: qcom: ice: Add runtime PM support
>
>  drivers/mmc/host/sdhci-msm.c |  21 ++-----
>  drivers/soc/qcom/ice.c       | 139 ++++++++++++++++++++++++++++++++++++-=
------
>  drivers/ufs/host/ufs-qcom.c  |  29 ++++++---
>  3 files changed, 142 insertions(+), 47 deletions(-)
> ---
> base-commit: 9a482184d910775cf648863148944945b74e2815
> change-id: 20261022-qcom_ice_pm_enable-3c5d21b99e42
>
> Best regards,
> --
> Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>
