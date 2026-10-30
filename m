Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357985;
	b=sFCc37kykGY0dHLbIpkUEP9euxwjKqo5iwAJSzukHh9o8M6J8kvL0BnqdS9bAzqmopuI
	 VOQj+WI6oIzZdSSk35xaNDzJLquiAUeGxaILnbTeVsyXiQ2rvrW0RgdGVlzMk4wHAcKtk
	 kmE9NT038xSeAB+0QlVqJMT28tjYMZNgZKjJNN2nuiVH62GvP5kG0PCrevAzGWOiDUQ8u
	 dCy5oGdh9vlzYI2gT/oP+ggL1HaUnNHJwqw9XHsVggNiztYSNKINv0Ed+6TZT0/rAh48j
	 xaPJpYb7R37kh6lw2NI6gtUfbm9EX0NQiJala7zuDeqK9nKK47DzvJDasSldF7N1r7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357985;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3h0VoqWdyEGPZhM02EobSUR6ttbQ5ta3ZpYxlyDqGzY=;
	b=e2ZpoNnvErXQ8ceyxjh2drsJ72gicsiltLHLIPccp2PUFebuH8jeHyVIDUEFqDVqbIOc
	 VQcmatRWmUJ0dEZYPVFHkhnoXcJFlx4QWzNrX4lDERwbzJdjZ8W65uZ9RLIQMq/ubbtxc
	 +59B3YbyxbdPlmgF1Mn6Mdcp9JN+c1H3T41xa1Sm009pgHM6u+rJRU+iycNjZ59VCOR7X
	 qezuO0LdyQpBVzLGzQKV6sAi2Obz+y5Y2I/mTf/LRNuKRBFY1bANz5XCiDABm/ewVKH9T
	 8PZnkgSr5pANfGs3prXOPuRT1Y5WvNiBtrOGcvEdV8DkjW6tm3zbaeABdLBG8dKNvcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FoN5mx08;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U2MME4E9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE175606A31F
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 10:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE175606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FoN5mx08;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U2MME4E9
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8F1ef1120516
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 10:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3h0VoqWdyEGPZhM02EobSUR6ttbQ5ta3ZpYxlyDqGzY=; b=FoN5mx08YJMEym5Q
	rgXbClm55skGvq4gNRlOdq3VYj5bvbzTVDcDlzPDAfW2MBCLQpT331mdy1eBbaJ/
	/7BVMVBBszlN4oUHv0gPezwhdeyVijSytqhboPbeT7xM6EZ0ccfy8dlweducXX/N
	q82t80W2DpqBfcMZsLacaTuavA4WkryeZQGbD6gJQ2ifRuEpWxVarNVORqlPbrMI
	KQPOC0Zx/ZmogLXzEQTpOuK80NdtABggXJe1AyhEinXsZnlbeQQzO0WgVJVO4ucP
	ETs8cseSTsYNqB/r3G1Y6hozHOerakapy+NBcEQo7pH3h+ZyCspbbTxOMKUsTh4H
	LfVVcA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pjjng-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 10:59:43 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ab67ff8ec3so446070a91.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 03:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793357983; cv=none;
        d=google.com; s=arc-20260327;
        b=rn//1UdbfIAOPO+bS/My1fM01TFsa2pmOt/QHyYPDuHAOkNzzIo2YENyPDYw2M8w0r
         +k5A+2ffc9zYqdfyE+x4CKMplWspko48hoW6CW/HA/JwO7Lzz4XbmLzj0RZ9C8OhYHAi
         K1K7w1bXCmMAWMl7HPhLZ3oyLUtkg1jfoFxfcsT6MMUGA4C6wt3KqvaIr9vyXDk4Qsqd
         Zd1HKZBQMUroTvMznY+CJXnV0bOiQu9TiDLbsxBn6WZEQ6Y3dJJTTdKLS8UqHAgXJQ63
         G79P4GfnpuV7ahtAy5GQNXxM/t/3W/kN4ho3/bepsKDDJSVwgy/7TiYCV3gv0WI583iM
         J31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3h0VoqWdyEGPZhM02EobSUR6ttbQ5ta3ZpYxlyDqGzY=;
        fh=sbmnTI6AmaldILJeN5SEgmVUvcmzQC1v6qpGxZxUgWo=;
        b=USnO1WAqR++6YZGg1mBP5mDa7SGIN7B0+vvfpnkDy38Z4Ny/MdaG0idXLJ7jdHyqB4
         15/BBjkJQRAZJF89bhXI/1zWvVBA9bofJXNi2chydxsKH/maXW7WgZc4xp8tLnRN4TRO
         Nsp+fXkNXDu1N9apMBC5bx5alKiamIGWD9atqsLfuyO9Mo8halWu15EGOXcS3Io2PPk/
         QnSzrZFF+OAKAmWR1ajze8ONhFYFoCHLc6j1RCe5AD9uOR5nYi+ca3RxU8J5XDrX2yl+
         1cbbThKEkb6w4iWhVHsiY6u+5pPw4i2jvHKXSaPvDrX71fO3omYimDBI5LuqH1XIojJP
         2MHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793357983; x=1793962783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3h0VoqWdyEGPZhM02EobSUR6ttbQ5ta3ZpYxlyDqGzY=;
        b=U2MME4E9u0dEPktcvBOK+5rTWe+VYOqcIbLgTa7ux9ZkH7SP7fERIZR9o5oQUqVGhI
         HFbJjYNf7P2xvqL3ytiZVJBxyZ3G+bp27OO5JxnzbvReT6QrbfZc9f0l5vKYsAziP38V
         VXYDDCTeYt6nylnPMkOpB3ZZIxmYLYU+Dr0lxuFuaZpjQFqAydYB/VLMnP6SRrMgcp1l
         2c3izN2aKKnnlVIg+VZpMsacJP3dUWYIdJu2YdvxLsNBVbcEP4eXmQo0D5/YtAyMaSG+
         TzDXDYSm1CZk0fP8cKAdL/wZCJ4RH1lUTCTwIn/Fpr38hGIXvPD/2M02VLpVYscZy9RX
         N7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357983; x=1793962783;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3h0VoqWdyEGPZhM02EobSUR6ttbQ5ta3ZpYxlyDqGzY=;
        b=o13f46RkxxI+ET0UynzC2lKhx/FAQOqhsedylZJb4BcH8xD5RVvmmYQjzKhlBbD9Dt
         2c2fkP/7n/uwyjZrDn5r/gwrw3ht0Q/s8ul6t+HkJYXU5wVn7snGiqju1o6cqbD+Qi0F
         HfCKGUkvqkJa6Y3B5YN6T85NjjaFjR2aOEZ3dPkod2glhHMZL73xGkJLC56gpxz8szyU
         gGNy8PBk3l1XiPkt6Ec9VdMlEp7iar34NXp1FudTOz8Nd6ymVBdQetv0cTzxkoyhzeoS
         a+6dYU2caU0vrRDmsIbwKT22Q8/5UL4dMZFclQ1id7nZ6emSYctcGQwE7R6jPVKvqwuv
         saxw==
X-Forwarded-Encrypted: i=1; AKwUvBxGHfJHF52luJ+D+v9/xVRRIev4/TWBCGt1NU5vb3CTkSwEUTHjNUS83Z6Y762mMbUMij0IumaRZ3k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJM/JLPjqGXFeAkW4mwT+Sv6F1EFGF8Kz3QIQUBulgBdIg0itb1
	+m7m1N65I2oO9s1vI4cs1xr5gGDNBjj2mVkMS9QVZZNp8NNCUlI+JaKTlKzesLlqlRt9dI5L2Oz
	vr6OCX/kHubBHO5uoVUjiItUEW/y0Rf/k9uvtp9wmieOwSiXJsCzR9U1CL7LpOhc2Fh7GiLYVkw
	wTgPm6u8jFsD8X4EBSx2UwBCJQrwKgE0h+mEbBfg==
X-Gm-Gg: AYBFou1nzQMS8Xl5OloAaZywnq2CHGZpJhtVqV2cRSVcVUaCSgRiSe/hNry3GoMI/6N
	fGyHmeBGaQTAzqINM5dYTvTF0EICAk6chmUvKIZvsrO1LJ+RCDsjoGjsMeLgcEM6uJYVZnO1MNg
	tYqRBEb+jnnjivbOS1hNos+vfpppU00eF/Yzg+kKPaQc+WgbBMlHgRWwZyRQ==
X-Received: by 2002:a17:90b:2751:b0:3a4:b3ac:904c with SMTP id 98e67ed59e1d1-3ae8984ec60mr1499298a91.51.1793357983159;
        Fri, 30 Oct 2026 03:59:43 -0700 (PDT)
X-Received: by 2002:a17:90b:2751:b0:3a4:b3ac:904c with SMTP id
 98e67ed59e1d1-3ae8984ec60mr1499273a91.51.1793357982451; Fri, 30 Oct 2026
 03:59:42 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009-meson-gx-busy-timeout-v3-0-67d0db3a8328@iav.lv>
In-Reply-To: <20261009-meson-gx-busy-timeout-v3-0-67d0db3a8328@iav.lv>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:59:30 +0100
X-Gm-Features: AclHuK_ToRvM7ToPCV5jS32tMVtZ5JO73u8yLnSIIXc_hjp9eNCpwZsxviWTqwQ
Message-ID: <CAPx+jO9tr__fFj6ftwbd+VP-GAA66=T8DfHgcDcZLhHhEGY=og@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mmc: meson-gx: honour the busy timeout for R1b commands
To: iav@iav.lv
Cc: Ulf Hansson <ulfh@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX8MmCNq72WlGH
 G5X3sMpC0l4xT/+LkcjKQDyOIwFvJgJYm9C7+rFjDWW85gBh7bW+hfU4/+ip0j6sbzI9EGsAKcO
 RCKPFYmkM7pXp9HSt9gLKRlq6O4DzCCOuoiHfwtEhoOFm8UBNY4zRhG/nkAKe2C8eWqOCTvC4iW
 YUMMMwkw6vRvbaAmQ0AA6ZhZJoErkn3FMJu0h7TNktpUUU8vSm3wdHkx/vJWayX6s5qwUK42kFz
 1bMf7xXkI0cm1wr2V+fB7dH9NrIr7q9lUfvR1SjRu9ALz/N0hSLSgGzoX3tJ/UnKuwWv6X422uU
 /TiZSNHkoshNSEk2RWyeigCROhSs6WWChKrBpCYebeGV9ebSL7Fjvx95e8nrjAAD22OJUG2tHyM
 xARyv/tIK493XX/Cczot11HVeiKXhkf05+W9zawGvBy5zGI9B3qQvu3LIJa3sq2gMWdtLKAqWpF
 WRMb7pbpZ8JDpkXtvMg==
X-Proofpoint-ORIG-GUID: b3x2v8-ixLW8CpsJBrTdRJSnpkjjfYlM
X-Proofpoint-GUID: b3x2v8-ixLW8CpsJBrTdRJSnpkjjfYlM
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae4789f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=r9kgVt4VC4hP7zZAK8AA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX7KbLjs3g5Iwm
 HLS+EFcsBLkOms6aMsD2dHhizugWQwtX3zfeSYuEILp3ozyTlGCJASQTxRhuUhk/kAxBpLBdffr
 2fNVeNLo1JfUxhzrRlSuYkdTNTVoBEo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300043

On Fri, Oct 9, 2026 at 7:03=E2=80=AFPM Igor Velkov via B4 Relay
<devnull+iav.iav.lv@kernel.org> wrote:
>
> For a command without data the driver programs a fixed 1024 ms into the
> CMD_CFG timeout field and does not tell the core how long the controller
> can wait for busy. Erase and cache flush then fail with -110 on eMMC.
> Patch 3 fixes card_busy, which reported a busy card free; patch 4 makes
> the core rely on it.
>
> Tested on ODROID-N2+ (S922X), 256 GB eMMC, btrfs root with discard=3Dasyn=
c,
> Armbian builds in docker as load. Without the series (7.3-rc6): 262
> errors in 3 h and 68 in 2.5 h in two runs; the first came 4 and 43 min
> into the build. With v1 (7.3-rc6): 0 in 16 h, 2.4 h of it under the
> build. With v3: 0 in a 37 min kernel build and in a 20 GiB write +
> fstrim; a sanitize went out as R1 and the core polled DAT0 for 523 ms
> until the card was back in TRAN. On 7.1 with the previous eMMC module
> a synthetic test (20 GiB write + fstrim) gave 48 errors without the
> patches, 0 and 0 with them.
>
> ODROID-N2 (S922X), 128 GB Kingston eMMC, 20 GiB write + fstrim:
> without the series an erase hit the 1024 ms limit and failed with -110
> in 3 of 3 runs. With v3, in 3 such runs and a fill of the card to 85 %
> with rm + fstrim, 5 erases took over 1024 ms, up to 1219 ms, and
> completed; 0 errors.
>
> ODROID-HC4, SD card in SDR104 at 1.8 V: 0 errors in 5 boots.
>
> The timeout is rounded up to a power of two: the field holds powers of
> two only, and the timeout is a lower bound. MMC_CAP_WAIT_WHILE_BUSY is
> not set: I have not checked that the controller waits for busy on every
> R1b command, HS400 switches included.
>
> ---
> Changes in v3:
> - Clamp cmd->busy_timeout to the range of the field before rounding it
>   up to a power of two: the rounding of a value above 2^31 overflowed
>   unsigned int (Sashiko).
> - New patch 3: card_busy reports busy from DAT0 alone. It required
>   DAT0..3 all low and reported a busy card free (Sashiko).
> - Link to v2: https://lore.kernel.org/r/20261008-meson-gx-busy-timeout-v2=
-0-8bde1adfb5b4@iav.lv

The v3 applied for fixes, thanks!

[...]

Kind regards
Uffe
