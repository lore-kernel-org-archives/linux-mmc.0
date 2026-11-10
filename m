Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794319414;
	b=kUICYNeT9BBTu5s7KpOFaIBf3VdWM93ut64ZGbYV0Rm1V3Ikdz5Df7LJIeFEFuEXF2nr
	 eHPqdL4bWphiP2sPUGo94qucCljNFj+hHE5Dcm0h+fHiMS4BoU+XDh5J9KbLl47lToAvZ
	 Sf2e6VQQ9VpTXN6vil48ziG/2Z0G4uSj2IthIl6ljJw8Si6j4Mr3Gi1pQg94xsxNIRClw
	 G31+Pb769Yefi70p9bIHOiMkkSzbBTD7ohlhGce/jSAvEmLtzVoyaYb9WUFBNdX9V8bk1
	 pC6wLUoWdiH0j1SYHAWsCBjsSCZuLCdrN2tDKA2Fsexhm+s8F8dBED08Aev3vPiXTdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319414;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BihLENavKtY4MSL6lyoqUvLFCi0x8GoeoxOzwMEDSI4=;
	b=VQewXU3cOHYeEYtRIA6Pf3MulpMLOb6dfibfg5oadR6dQ37j5h49xqM7w8eT2U6pV3uV
	 d6uth0Gaw7Z3D4nbbCu2ezukRO80xkWoJfpK3SVlAmqTrdqNiqCOmJzjeegSJOtESJgnc
	 QumejQO2ht72Z6rp/Q7ncgYLSXisAedytHfeFlUBBVv0FAqasWp7mpgyk4fg8BCTuSY/i
	 Y5OyHFYDTUzoAGvRsz0//XyAL2YUDbfefVw14+TujWiUr7IgdhB8m/xqkUrk84tLKX4sm
	 QqwnjtA1OxHAwGOA4mZrw6rsWEzBYys+7TEVGae97Ct0OOW6SVowRuec7wF/VEttINw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="CBEQiw/J";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MmlziztY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D34F606A325
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 14:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D34F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CBEQiw/J;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MmlziztY
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABAGf53178206
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 14:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BihLENavKtY4MSL6lyoqUvLFCi0x8GoeoxOzwMEDSI4=; b=CBEQiw/Jog76IFPM
	fHy6wxEQlnl3DZHj5qsbCcN0u8KknYI302lXuJgRF462j+aIF6V316Vd7s7zMmKo
	fKnr5rfsDPbfskswOmBsBH5OTwercl9jrxdAS7p//eStcTC3fw+NPdttp8IrS8s/
	btAk8oL37uzjzU83GRdHgKVwPYwrdVkZnm6kb0/8SoQ3+tQ7OAmxW4Pe6E5nBf1/
	kD/WWmiyq/gNU6IqcJABJNKs39/u2FmNehGS6wWpvaEKsQ+eDbOle94S7+Qhwb1X
	vPBjlLeC3RezqT/49F3/JRWUwG6hkmMmWC8we35mAkxOG8ssalJ4NcG5+3uaWwFx
	ttvVSA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyufs31e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 14:03:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed47dc8f3dso31012705ad.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 06:03:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794319412; cv=none;
        d=google.com; s=arc-20260327;
        b=pcBL7I82luxWUPbRiAXCx+qtH0NkSe9cYlikgeshkCE3wiqY1smad39FeZlqDQ5vUT
         jAivezgwSAoXF5omFpKuyX4mx6TLew1VgQ/sXLVFfyntXefxlpQrEl6/jCSZaW9zynrz
         LOHm1b3R4S18oiLosNNHiI+z8dKbhgihAbCs0rwogbhX0Mf27xlY8UA5KAhBw9icHAkG
         FmrbZX5Ce6JabDkmitSYB2GvoQJywNf8dcotu22IOjoRvI7aQycf1c/p54wqU94jda36
         yd6QwEAuw2ZYpnPtaZGJRXbqRO+zLR5DlpBIzE2KTm8rH3MnNxdP02Q69D7ze88Sx7My
         rdSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BihLENavKtY4MSL6lyoqUvLFCi0x8GoeoxOzwMEDSI4=;
        fh=AnkBrDGn5A9azm7MJPHFbiPd7soel3kuwikTppgJamo=;
        b=RVnEoTjw5F83YcdSW6MmHhwbxpvaFIx1H419Zd6hu+uX+MASVSXjBFOBXVHTtqfWLm
         nruw7sxTmv0aZHwC146iNL/eFRiG+QG/P99sXqkoIctpJqHkbwj9yG4ghNwiELHzbi8S
         X6xXXskUUM/0qlPCgWKEGln9rCLxpXK1D43z2MibfwCz/DSlixl5HCJfU58xBGUbIECf
         dMVAOGzJ9D418KpmoA88xCk+vYduuc9wGIaBiESFfnySSGeIyzJaVwX6BqXQwAjA1VyM
         slLD+ysY7yKH05ZEnXy8pQuiW4TTxhM5TQWhSVKSf+sEei+6bL7jHn8+AvXkufg0lfo2
         /JPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794319412; x=1794924212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BihLENavKtY4MSL6lyoqUvLFCi0x8GoeoxOzwMEDSI4=;
        b=MmlziztYkvF11+nobkXxPldlxN6Zj1ysli+2yxU5kTH5buuY5nS1RD0G53evk5ynm2
         eRG7o8lFq23kZZ3kElsFaltk9RHmgQ41fSTvZd9T8h+KHQY4eLhyxFM42Q2n5U7slRyi
         o2Qyunm4+tHrki24B9wl9KlxBjdTNTH+XkerX144ygOCCZUfN+x8uWJXpkdq+TRWUopL
         G6xQpyGR3tfIqvlhl28SQmxZnbZEl4s1Y/W7/XMMCzyXYMGz72OTc1PJzDRqSjJPScDC
         yuMqrvXHWOasDXJaBljMh3vGjnpbK8jXeXVOowXSI444ZiAtqjSlDL/6PAJ7XQjPR9+j
         Qukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319412; x=1794924212;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BihLENavKtY4MSL6lyoqUvLFCi0x8GoeoxOzwMEDSI4=;
        b=gazHT0YuXt976JbSijuHjeASjBTGb6I2l0m8isUcf5hJfUwwZBWF0pzFdGPgAvCseE
         RUz4Hxjxdt867HdMRnkpgWrxjTsxULE5VEzzQRMnXvFcZ4t5Ni1+nE49DwpRuTFFOZU3
         UDsFGEvv3/EW3D1TzdXxFNLXQib6fQM4/xgb9Ow7tmkux0uZPJZLPMENBU1ZsO/uFOEa
         pXA4wuZwZhrLzzAEvL7r/kai+WBHmqg+88z+pnK0tRZMcx3RyN4E8uYyitXostQ2bDHS
         rYORU2zqPUhpG1ldyz9iQfN06ndFY6DzBv12yvnWd6eBrxiPp8OOCDYvQDVfi/KL7au6
         zRjg==
X-Forwarded-Encrypted: i=1; AL+hErEf0Le4yIt+qT/QhIldlSYcxnJhyOWfX9/wCqibFIbAK+W8BAiothqiABUHsbJIj+KOsqzK4R1fTtQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GFpV6Nql3+2jaqMKQk0KrAr0PZ2E0C6FI9FIRvBfpiQCPf2/N
	SHY5RhCLmREzdFD4z+UcStojaovWQbZEAyO0L8hiZD+k1/AOPZ9fGdeU2REzArW3NO8R/4G6goN
	aigC1kv47P5/LEAi/bv/J3lJmWLXda3YV5quqNpf6qJTkF170AJ2nyT65m3iCLYq2mNNyBSrneG
	8LaKB0MCJnfB8YjAWaQqlksEnmSbm42fprJ1beHA==
X-Gm-Gg: AYBFou0NHwFn4Y6mMbL9a7ygNAeSQKgW5rL6sEki+qk8zbdO6L+A0OQ7U+c+GzdRFvT
	hTn9RtXDnJxwTF9OVfXWWxaAKlH/4XhKawHpUGfO60JOnOQBJALRdUni1Ri8rBcoLzkw9caXyrY
	7WbtHAPV8GFMgrKzerN/WzBNggWtk+q0sKOEaeOrX7ZezICmSjhFYfMD1ujQ==
X-Received: by 2002:a17:903:1ae4:b0:2e9:b7ca:cd5e with SMTP id d9443c01a7336-2edb92f019emr26700625ad.62.1794319412356;
        Tue, 10 Nov 2026 06:03:32 -0800 (PST)
X-Received: by 2002:a17:903:1ae4:b0:2e9:b7ca:cd5e with SMTP id
 d9443c01a7336-2edb92f019emr26700275ad.62.1794319411787; Tue, 10 Nov 2026
 06:03:31 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030142224.3183407-1-rojer@rojer.me>
In-Reply-To: <20261030142224.3183407-1-rojer@rojer.me>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 15:03:19 +0100
X-Gm-Features: AclHuK_1ju_Xd-WOjsEBhif3s-mayNWCfqDyHxDzBjXt_Yko6Yy63H2bsR-Bi5Q
Message-ID: <CAPx+jO8n6Y9PWDkxurwjjfGXSiGS0KWrYK0C7=5Uqic1Gn+M7w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: core: sdio: fix UHS init with fixed 1.8V vqmmc
To: Deomid rojer Ryabkov <rojer@rojer.me>
Cc: ulfh@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, llj@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: nFbwfbTQerCjot8gAl3dGovKEc0LcoQS
X-Authority-Analysis: v=2.4 cv=S6lMU4sP c=1 sm=1 tr=0 ts=6af32435 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=A47YHxouU_d3PZZ3E2YA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: nFbwfbTQerCjot8gAl3dGovKEc0LcoQS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfX2mb3XVINrYWQ
 9FpoHCo1cVpbX0p6Sv3TQpwklHxDeWfuoK7zR9xwYflzwYvLXEY36XxkyF3/6lBw+72nN2sqHe7
 NwkEjKAMxLrThb+1udtRWM0EgvoKctg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfX8StYlK+rvDm9
 j76hbvZUP9k4Fel8CQEdMVKSnon/tyEyeANJIAfQMPUAArG334syQltXRhgSYj5kO5iLrzYJy0q
 ILobqE/DJKPKWTvlUHrPsRqdmFiXmkJBl7FKGHmg7OTp7Zq/87ef7kH1E1WVFSBk4odQk/RIe8+
 aPuerGwSnFWZszDzkEjd8sP3ZBpSYgsbNhOMu+/P1ngDbAv4d5ega0KvXZ/mMSlQ2CpomNCbcuF
 QV7XlGTz+pxY4KlV7hF9nf8fDMKdltapriUIR3QcZzkN2iZhGRzFbTid7rHFkcforQa2anulrWw
 3QmEU+DAb3K2Crxujr/OmLWRY0QTzA0gX1RtZDsNFZTX0el21arUZra5pwEpb+RJened/QWeTCt
 JMkxUTGpRHlto9KiKfNqlSGB845Wk5WnL8EE+0y4/rtJIVSSpReB9TbYSf2lNz4LOT/qGXvuz5m
 2OdnmR/tOdMnCUgXeLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100055

On Fri, Oct 30, 2026 at 3:22=E2=80=AFPM Deomid rojer Ryabkov <rojer@rojer.m=
e> wrote:
>
> The Realtek RTL8822CS SDIO Wi-Fi module on the FriendlyElec NanoPi R2S
> Plus (fixed 1.8V vqmmc) reports S18A =3D 1 in its R4 response although th=
e
> bus is already at 1.8V, contrary to the SDIO Simplified Specification
> 3.00, section 3.1.2. CMD11 then times out and the module ends up at
> 50 MHz high-speed instead of SDR104. The SWT6621S behaves the same way
> and, without patch 2, doesn't come up at all.
>
> Patch 1 makes SDIO init fall back to high-speed mode if UHS init fails
> (e.g. tuning), instead of failing the card altogether.
>
> Patch 2 skips CMD11 when the host is already at 1.8V.
>
> Tested on a NanoPi R2S Plus (OpenWrt 25.12, Linux 6.12.112 with these
> patches; applies to mainline as of 2026-10-22): SDR104 at 150 MHz; iperf
> as a 5 GHz VHT80 station goes from 70/29 to 123/125 Mbit/s (rx/tx). eMMC
> (HS200) and SD card on the same SoC are unaffected. Longjian tested
> patch 2 with an SWT6621S.
>
> The device tree part for the R2S Plus is sent separately to
> linux-rockchip.
>
> Changes in v3:
> - 1/2: pass "oldcard ? NULL : card" to mmc_sdio_pre_init() instead of
>   "card !=3D oldcard ? card : NULL" (Ulf). Equivalent at that point (card
>   is either new or already oldcard), but clearer. Kept Shawn's R-b.
>
> v2: https://lore.kernel.org/linux-mmc/20261027122417.954133-1-rojer@rojer=
.me/
>
> Changes in v2:
> - 1/2: the existing CCCR fallback resets the card, it doesn't
>   power-cycle it (Shawn).
> - 2/2: note in the commit message that this relies on the fixed 1.8V
>   supply being described as vqmmc-supply (Shawn).
> - Dropped "2/2 alt", the alternative to 2/2 that kept sending CMD11.
> - Collected Reviewed-by (Shawn) and Tested-by (Longjian, 2/2; his
>   reply didn't reach the list, it was HTML).
>
> v1: https://lore.kernel.org/linux-mmc/20261023232813.2983368-1-rojer@roje=
r.me/
>
> Deomid rojer Ryabkov (2):
>   mmc: core: sdio: retry without UHS if UHS init fails
>   mmc: core: sdio: skip CMD11 if signalling is already 1.8V
>
>  drivers/mmc/core/sdio.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
>
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> --
> 2.53.0
>

The v3 applied for next, thanks!

Kind regards
Uffe
