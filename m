Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795789280;
	b=1NZNbCn8PATagT9iv1+FwplKHUuooBusu7/hnRUCPFzPd1jry1sABgSUUiZ4Kc7pKQlg
	 zxWnh5BPoGKfFua1F601pmqgq75gUCxi4NwfKY4JIMXbhyA1LoVR1AehkEazTvVqOA2mG
	 ObJtfmegHm0J1WeFUQSn3MzWnPZ1h20Q534PeSwgr1M5l3bqr8LylOFc+ol4kC4RJHymp
	 4099SfS2EOVeI0Ftuurriy6PfmbgaI0qCM/8phBrTCOHYosCnNG6zV5xV24wyA+c7VjxP
	 X7ayVf0fgjTsIXTBJSF4ey8haA5tAD26yZ4II4n7J0JV+RgquVJI5L33KzHfaCbHI0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789280;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=A5hqXiVN6bv4L4ofOORkjxRTtA0nk2YCOESocO1tEb8=;
	b=kMmqdq/F9CumaSHCQ8BtTEit7VctB8hLMte2KVgYP5/QHrtyVTreSWLe+WVizjgq+c/X
	 sHlT+yldvJeHLXl+xKX6x2WKFoMpMhMetLm77RZNw3eHI3dKGb5q5+npfLtZZDQQgCp8f
	 c3zMa8XC6G5zBdHvdfj/008CMvv/nwVBTkuoNK8mypK7kFV10NgK+oBV2xIpGyRVEWKol
	 3Qa1XCAuKYMkYOmGfAC5BOVV3QvKj9YIt3UhDs5IS06bYy9UR6XuPhrMZEBQOk8g//iNB
	 mK8NncVmQGD9bJLjCo0lkt1fkfokOs7Tyy3FyhMNdavVeVwOZev6h3hI2SqhtaxQBIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ocnuJtIg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cIERl15w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077C606A334
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5077C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ocnuJtIg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cIERl15w
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1Vl54018824
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A5hqXiVN6bv4L4ofOORkjxRTtA0nk2YCOESocO1tEb8=; b=ocnuJtIgb7VcXseS
	55P3q/4tJfp/ceCd8lq6w1hqEGN0U7sHKo7fxIAKsyMlouxnCdHakXmnOaYEWOk4
	EqcB0AYHl8TpvyLZ51S508EZ5s4itQp99npEqGA2jN8tHR50bqy75O5dpRiihDBv
	lZURgVTRInwjJyyGfLpWItlHgt5/hRPOS7Ohphdqj8SsjSBrrn4WRKjDRBUmFSpc
	M1orGqa7LlSr8fLaTsPto01YBBDM8GXRIQ+/7Ca7aBflUzA8xxOlnwIR9PcvvcPp
	fw95IhHDB4pSZ5yAGE0d5jpU1MAKlebC8e9IxaiY8FnqIhEdkVA+Yykwj3wwIbcT
	NxUiLQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73dha0x7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:21:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b3f3e256e8so7657024a91.2
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 06:21:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795789274; cv=none;
        d=google.com; s=arc-20260327;
        b=AhyM7iSV26UEWqZQxZUPh37VUXVWbfp2k6r8C5UbYvFLDLniyoqKNAOZq/pnNqKbwU
         JfDg2yQtXpbUS/7Mz010AokwyBbITxUoQ9PZWKrgx1wb59FACc93tXrJbm9neYWQnZJv
         HpDAM65woPTau4pHIG8Ncr1KUOi0DhZD+4Ab6fPEgX/2hwRFSEkAF0f9l1PryOKX7lhd
         RliWerhCaYSLy12wa8A7AAqMJvrZWyoqjQp76SKOaQ5FxU815WcWGHh3tm8eII8GDweF
         q72eZcAod0K9FgDN48cwVbuSKKDmfTGMKbvVg24RX+qM6YsqA+DjJV554CzWRurZAqHM
         Zpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A5hqXiVN6bv4L4ofOORkjxRTtA0nk2YCOESocO1tEb8=;
        fh=78itAO074P640Qkj6Z7yKbRKim62Y1K/WWFF/lx1yjo=;
        b=ORFXjexWrjTNAor9DI0e/78edZ1Zpag1XHKwc9YAGba1rbI3DOfo/+T7P497fajO7f
         bP+Toi0MSNcZhQHvONb1S7cKgDylLAaUI26LlCWCHxh+3sWDLrxQ3Knt/RuqIiyiPF0q
         vxtxHzilp26UONOXSaIa0EoL4x1BmEhGN4Dxgx87MooI+Bo79mIeVImUxXkk1ToP45yW
         ae0eY1vCyF0TqF+WLgXWJywAstLoESmBBZaz8z94/uu8E+Yn8H5DRQeNZ0/rMfWZ/sN6
         Dmn3DtvY4+a9V+WU/Vljtl0qUMQpo9z1lp1GBuqA5k74FsjYWCu/aJYPdqUNQJJTqIyx
         AiVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795789274; x=1796394074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A5hqXiVN6bv4L4ofOORkjxRTtA0nk2YCOESocO1tEb8=;
        b=cIERl15wmlUOGLbajil7pay5F0zOVTEGobNtuDhJHi3x2YWRLbPnAnuM2Y28ETF9VD
         qVw2T6eWwiac3CUxT3u4oGeTutOYgxFFrbeEIrswvHlcoa1ndAW5nZ0YCYKyyEjlUwUe
         5U5vhTbHm0+0Lz5mOo3p1vQBv6nB9t75HFFaph8UBq5ewp1ebUj02Rvk1Kn0bpEqC22G
         va2j9NzUUubOsuQvCy7vbOWBy6tkCzNZ9qqh9YRNlnCGNnN+oktzqSdOs8Fr8kI1ZgSV
         l9+yqI1Ev9bVi4uupeYWS1uucsS/q8IL76epa34Ml6rq3TLhJSSTNHRqusYe8Qz+dO7p
         +nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795789274; x=1796394074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A5hqXiVN6bv4L4ofOORkjxRTtA0nk2YCOESocO1tEb8=;
        b=dSe/s1hSUQHuvRBlHEgtGgJLtSdI0Je5SPE5yVeuuxu2VQQZ9MZBCXKMlr+cLqpXuS
         ubus6zYOzvYlo7KbLVMTRql+J+SNz/pQdXwkLINv5+glhmgusbOkl0M1BLV8pksEyNj/
         qJi2m7Rr/1a4lydQpj8uz4BNBgBFSmhSTQY1pkcLMQpx4FgthmvWEQUgSmT7sKuNlISm
         6Uqs0rjSfAWhMxpnmTpxs3xdJAj1YJZe6Gm1enzZ0rtuwczcEi/FgmcWnJ3CBRS2yNOt
         jXV/XgL9DtzwZ94LZpK3pIRwKJ75G4THH1DxZOQh0Hw0f/pZzPpnyeEGlZN3p+zsFIod
         7EFg==
X-Forwarded-Encrypted: i=1; AL+hErFJFgz6kMScGpPwtqOqIu7RITwUCBL7R9w2TKdmnnLied9RFT4qwbecC+kk5u8zrk7h5PWBwU/OEsY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8worJiMueESWy4ZEQSGnLhFWbFgKVwESgqRYonOyF+uftrj2x9
	rf0Wf4SoM2SQWvzzLQWD59kUW0h57Sr4675SbUA2Totdg5u2to3tjpxDRJjI8IfgLdFz7lFHRfi
	0QqG2am/U25i/xNpIropwD9dOp0vpSrAT0OjvyHEN8uIPoSr5QjS/AZ8V9gPTz8a+B7Rrc1hy65
	0CMRw4F3TNM3wUeCRtFH95aAur84UQAsJZtHlh1Q==
X-Gm-Gg: AZFdTZetAWW3sru+MSwXMr5JMreu7E5YuFhAcwrbf1bq9eWE58Rjnv7NVLgapha8B4Z
	odevjDGAPLmdZdmuWxh9XogffOhKukaUD7TuxHIatT03WjQC6jjZt5nRWB7sS2kk2lnm834V/yD
	XNbq/sBV97XEvszl77t3yh+KJ7lyMq3rMjeyeqG6IO7kwBp2EzkIL8/SKoRw==
X-Received: by 2002:a17:90a:e70c:b0:3b3:a9a4:a60e with SMTP id 98e67ed59e1d1-3b41c92643amr23153143a91.25.1795789273479;
        Fri, 27 Nov 2026 06:21:13 -0800 (PST)
X-Received: by 2002:a17:90a:e70c:b0:3b3:a9a4:a60e with SMTP id
 98e67ed59e1d1-3b41c92643amr23153087a91.25.1795789272789; Fri, 27 Nov 2026
 06:21:12 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109081813.3846-1-changhuang.liang@starfivetech.com>
In-Reply-To: <20261109081813.3846-1-changhuang.liang@starfivetech.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:21:01 +0100
X-Gm-Features: Aa3M54qA9bVNsH5PZixhN_9R9wb5sPnkOFjCW3Z5Z4-v6EvM4OqDvC5S8dayrX4
Message-ID: <CAPx+jO_s2hPhY3vvStjucDqMUajknKFMYavqa9Dxki0HM4wpAg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Improve eMMC performance for the StarFive JHB100 SoC
To: Changhuang Liang <changhuang.liang@starfivetech.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfX8T/+20RyWVjZ
 2e2wh7HCtAIrt0FWTNubuVKgQLemSX5+nS3LJ+eUdL99wV8hTgXZenkylXhdvX2mSKDPdrkYWMS
 stgDDzzuSyMyWTqT8FQajlab8qUcHZaoSPsDAHsV1t/Zemcus47xoNOB02zsyWoMVW4b9I8mYO6
 dSXCDiT7bnacji9+mUAmyKT3Gsi8bN6ZBfcOJnLY0a9tmpCmrVJB80ybRIJWLdXWe4eheVX6jMD
 VNd78mvoYwNRyIJaTx8NLNT1vjI+NE2xRv7xdhkJ81sVlf65YMv3rtQpbbWCUZxIlerJy68lEhL
 32mfKCyB2OthRzBDwaMcmLW2gushVU8eeCc4kY4+r3SCBLQJjgafVnCtqsiehVCaDSVsgAapREj
 8t/tIAnK3pcBgNYf1VCmJPMI0ErlDo3cVEB3kkMkY3JVJsNzE8O6Sq0GeSUZlvfQhYqz4UrYY7t
 uG0QBu1G6MiZectnoFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfX9QrZ4COgXOYi
 q5lecD3buw6XCIppt6TmvBBNieZo+UmHMkyHchD/hrKvxARIXtucCxB/RReiPMXBOs/uh92Sxvy
 L+p+kgIy24qfD6UcTytBF0tFexktzYg=
X-Authority-Analysis: v=2.4 cv=FfiiV5+6 c=1 sm=1 tr=0 ts=6b0991da cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=Bq6zwJu1AAAA:8
 a=g4n6s_l22fGBxNAyCcgA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=KQ6X2bKhxX7Fj2iT9C4S:22
X-Proofpoint-GUID: AZlDdbZ3C8vgGVM7HaOhrAVPTccK7gVE
X-Proofpoint-ORIG-GUID: AZlDdbZ3C8vgGVM7HaOhrAVPTccK7gVE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270057

On Mon, Nov 9, 2026 at 9:18=E2=80=AFAM Changhuang Liang
<changhuang.liang@starfivetech.com> wrote:
>
> This series implements programmable support for CIT, allowing host driver=
s to
> set the Send Status Command Idle Timer (CIT) in CQHCI_SSC1, either in
> nanoseconds or directly in internal timer clock cycles.
> Different platforms can improve MMC performance by configuring their resp=
ective
> CIT. This series has been tested on the JHB100 SoC.
>
> before:
> dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D1M count=3D800
> 838860800 bytes (839 MB, 800 MiB) copied, 9.38511 s, 89.4 MB/s
> dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D1M count=3D800
> 838860800 bytes (839 MB, 800 MiB) copied, 12.2127 s, 68.7 MB/s
>
> after:
> dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D1M count=3D800
> 838860800 bytes (839 MB, 800 MiB) copied, 3.19472 s, 263 MB/s
> dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D1M count=3D800
> 838860800 bytes (839 MB, 800 MiB) copied, 10.7587 s, 78.0 MB/s
>
> Changes since v2:
>
> Patch 1:
> - cqhci_set_cmd_idle_time() is removed, along with its EXPORT_SYMBOL.
> - A new internal helper, cqhci_init_cit(), computes the CIT during
>   cqhci_init(), replacing cqhci_itcf_init().
> - Replace itcf_hz with a driver-provided cit_ns field.
>
> Patch 2:
> - simply assigns cq_host->cit_ns =3D pltfm_data->cqhci_cit_ns before cqhc=
i_init().
> - dropping the post-init cqhci_set_cmd_idle_time() call and its warning p=
ath.
>
> v2: https://lore.kernel.org/all/20261104112657.110536-1-changhuang.liang@=
starfivetech.com/
> v1: https://lore.kernel.org/all/20261014121222.31385-1-changhuang.liang@s=
tarfivetech.com/
>
> Changhuang Liang (2):
>   mmc: cqhci: Add support for setting the Send Status Command Idle Timer
>   mmc: sdhci-of-dwcmshc: Set CQHCI command idle time for StarFive JHB100
>
>  drivers/mmc/host/cqhci-core.c       | 45 +++++++++++++++++++++++++++++
>  drivers/mmc/host/cqhci.h            | 13 +++++++++
>  drivers/mmc/host/sdhci-of-dwcmshc.c |  7 +++++
>  3 files changed, 65 insertions(+)
>
> --
> 2.25.1

Adrian, no rush, just wanted to point out that I am awaiting for your
review of these before proceeding.

Kind regards
Uffe
