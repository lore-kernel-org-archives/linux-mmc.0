Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793523303;
	b=dAM0RFi11Ivi4kevSacvDAhe1rHY47EvzN8BBvOxBmgl9oZ4qYPBfj8Tp+WqFB5ZtmBb
	 4pBpPzjMvAj3/XCAQlnHkfpi46cyeucxN9simfr3+bhm+N/rN54y9IL8RAR3FZfO4VwMQ
	 b+I9UngfpRmJsXqMrXcfIoOq7LQgtCFxOg0CS3tp/qDrCl/hfhfAddii5Ri2eXlJETzOL
	 CBKGzvU5Ao1kOh3IgAqm6Nq1gN9AzrIl7IxUALAYaKj3BeQ5CHhwxvblK7FwF5r2ChhNj
	 KYRQJRrtRfjdhfc67TitpHeg98lt0sPudLIYYyN9sG5BeGlCPyqykIiWHvTjsY5qn1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793523303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=VOlyAtS6nw4UaimVZudbFA9N9IY+hFNzuca71S7UO7A=;
	b=0cbIhUeJho+jB0JRU8E/1Byy5IfOn/nDiB6E7V4mlPuHENjS2HqIfZgEpoQW7eCh51fG
	 czYJvlqnX2la/4pM8gEp1+oMg1tvegyAoMhWW+69zIUkvQnvLmXISgrRCpUKc6zwRr6A4
	 FlwFuT6iv+AihMHIn8WOSRS46pUlJDFkHw68eK/3o/Yo6UZ0mrbEEZIqZhA3Me51k2yAw
	 0/8R038qEQsTARjAztt/I6DZ0ooZpqKjycoLf6A5in/QrBYPlw9c11SMJJ46N+AEiR55M
	 hOad+IWXhk6c0CrT2+ZT0i8R7FL348Ih8Dz4ePRVpro2ZOENR03bzvUSGr8pBwMvL+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UtptKx8T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B2A606A324
	for <linux-mmc@vger.kernel.org>; Sun,  1 Nov 2026 08:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87B2A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UtptKx8T
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c169ae1cb26so498032466b.1
        for <linux-mmc@vger.kernel.org>; Sun, 01 Nov 2026 01:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793523301; cv=none;
        d=google.com; s=arc-20260327;
        b=EOzCdE+bOGc9KlZq9XpkmisFjPyoOL8oc05Ej23rfV0hcEelPEyOBOEovyIAGB2xBn
         z4NMXLwXVPZTIAIB4FkgEz68GPkLzW7L7u4N+g+L2eeWaWiQ/QLCa79QEJfXfX3LJOy/
         DN2HoKnyQzc+I7K02XUwpp0u4wDeXSBRyHBrEmg19yMPOylvWsMPMZn0iaNjGeK8vJJQ
         99c/PHmMMGlW6N27viKNEbIasWD+/mE59OTog+59zbAgPPVFeo07yMhg9bUsz2ctnGv+
         cwRnW+Ws0GXAnFHYjfS44Y24DtijTzNMWj5qAvWveX2/ywb/++SQCRLmVAl+IDVR2A40
         NeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VOlyAtS6nw4UaimVZudbFA9N9IY+hFNzuca71S7UO7A=;
        fh=FV/mz9SkAHoYmcNi0OKYF3pI8UXBM6h3aNJlJo0Mm6g=;
        b=bT788bCe8g7ax6JIJHiPL+FKtff7NKrlzk6wG4vJUxVUyUsJlYK2fEFI/uxcEZlLEh
         JtC8+M2z4021KL9t7oUt53tSaiwaT84BdAXiKCrLI3QKwXjZNeNINmT03yKUpzOtMh5z
         V6hQE3YD9OhjZg1nxSdqyoTzaiq7EOXBby8Y6ErcYnTztWcIW1sQ7V2skJZRPP1d+aNd
         nZTUodRqo+p7IYo/Zz1B6N3fWKE3Ro4AXzRbRrSxEawW711qfgLPqCo1tNwZvCVF7yQm
         WUUJg/LofKEmvsE5Qc/U9NVV807XfIbGZnjCsUtnw7NrOc73MHhS6Wwpn/g8Tu4c4uL/
         jMBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793523301; x=1794128101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VOlyAtS6nw4UaimVZudbFA9N9IY+hFNzuca71S7UO7A=;
        b=UtptKx8TutLvQs817OYtwPOPEPh+dLsj2XekbS98eJjkoXEBi+hGgApuZeZZWdoDmn
         TfxCbpDBmKYyE+dQS/M4pcNI3Jp9z0WhuYC48eHPNz4ubJpkul+buS1/fUrVtKcgR2OF
         xzACxDesFXphjqzmWa/226XQgvJOTmzHPHmEGv2qRQsoCXSumzKFzBVl051oms0ZbwgS
         8YmkUNEUZKsWQzkuiFDksBXCHEyRksx0zx0EXP6eubYEHkM5qZ6r2EeXKwOJLaknCzBc
         D9tsdQxreKhTQ1T8rQURiEcGVyZAtIAGuvlY41u7n3duUuQ852Od9UVxSUeuaDj8VE3b
         dcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793523301; x=1794128101;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VOlyAtS6nw4UaimVZudbFA9N9IY+hFNzuca71S7UO7A=;
        b=zRdwIF+X2rhb25fYPjMED26PJFIcJAvBhImxAirB6LfGdd95asB7wBpmK7U9DcXpsz
         2y+z2vyQllrA+pCluT2d6+h/uisrsRs+Zr91ad7DGYiEDtXSCtKZNAqoClHw45YtuNek
         e6DOVHRyAZ39dcRVmQaDVb14PhNEXu6irjlQFC3/C3bUsy6TpqjXxNfVpOja3XhHnuTf
         k9x7wrdZn9zoJT0Rvw5tSVoI01qA0w3JeYZmpIU8lKgDoJeHYu6kE8xtlJ8KdsWX7Tx6
         Ja5bZQ2UE0hfJKVWvTQaKi3RbSILGz5DJHwlFjy51nzkG2BUFQ5/+r122NPAvk6b3J+s
         LjMQ==
X-Gm-Message-State: AFq9FYLPsbHXbhxt75o/QhLjCKBToheBps/FkUnhnl26qxm3D08D5GaX
	yzejb3IuXI+lb0Lia2jRPIrJ8ksoPDJXKUf9C6lg8THBbWAhIj0zMtzLCO4Lt2IYpaQcYXZTSus
	kkILmVozZSaEQWUo2ULvEhGw77ykFTqc=
X-Gm-Gg: AYBFou0AzUUdAFMCDt/nDjmEtA9v/T+rW05n3A93++gdkScwypU3Q8ZAi9sI5jQXygR
	EvbfD9GX8TOV1tVWh+aOCrjqE76qeu2VlkJHAuRUSqbqto+9GOx7eEi4g/N+9DZQo8myOPjSHBt
	/wttFWprl83vEVj/wpdcLkXOuWtJzYe0bG9aKSokVRNb2dRp56SFsdTuJYdo/xn3zRL0P8E0mLM
	wZg1zYhcZ7+PVo/1E+IGflkwHNBqDjBz6dQFEwgJVEgLnKbbyoZcc0VQ2hS8cmTNMYZjHVEHNKY
	B6lOaDSqqcdxpVStCJLzDAAoCgh0YixtNqiOMYTfGmjQoM6QfmnuhlfRQrt8U8PMWLbRzOziXKT
	2wEnDMMw/A+h765BG46smdjdqI8bUE2cy3Fe3/w==
X-Received: by 2002:a17:906:c112:b0:c41:9a35:17a2 with SMTP id
 a640c23a62f3a-c49d14eac79mr860609266b.31.1793523300772; Sun, 01 Nov 2026
 01:55:00 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031200925.3364-1-yuanzhenpeng210@gmail.com>
 <CAFBinCBo0C=KABcg5ueDTRSJhF9vmWnPwYHbaMGTOYppOsabwA@mail.gmail.com> <CAEDN0nDjYLE5hy7gVLQ3hv1WESVJQWgc7T_8aLqzRui036A-_A@mail.gmail.com>
In-Reply-To: <CAEDN0nDjYLE5hy7gVLQ3hv1WESVJQWgc7T_8aLqzRui036A-_A@mail.gmail.com>
From: HELPMEEADICE <yuanzhenpeng210@gmail.com>
Date: Sun, 1 Nov 2026 16:54:49 +0800
X-Gm-Features: AclHuK83pVomP0hrq6j_fybbi3W3-j8J1pzjtv8v1_2m4qUqV-NOu-WaXgCPqzA
Message-ID: <CAEDN0nBEK5PvkV-eC11XHYG04Occgs6o9_9K67OZn+xtkh68yQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: meson-mx-sdhc: add DMA bounce buffer support
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mmc@vger.kernel.org, ulfh@kernel.org, neil.armstrong@linaro.org, 
	khilman@baylibre.com, jbrunet@baylibre.com, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin,

Thank you again for your feedback!

I've completed the comparison between the original driver,
MMC_CAP2_MERGE_CAPABLE, and the 128 KiB bounce buffer implementation
on my Xunlei OneCloud (Amlogic S805).

The results show that MMC_CAP2_MERGE_CAPABLE alone does not improve
performance on this platform.

Runtime instrumentation confirmed that:

- dma_get_merge_boundary() returns 0.
- host->can_dma_map_merge remains 0.
- The block queue's max_segments remains 1.
- The merge-only variant behaves essentially the same as the original drive=
r.

Here are the sequential read results (MiB/s, mean of 5 runs):

                 Baseline   Merge-only   Bounce
    4 KiB          11.81       12.20      13.01
   64 KiB          12.88       12.80      57.52
  128 KiB          12.97       12.80      67.68
    1 MiB          13.11       13.05      69.43

The bounce buffer improves sequential read throughput by up to 5.3x
and sequential write throughput by up to 2.1x.

For the 128 KiB sequential read test, instrumentation showed that the
number of MMC data requests decreased from 70,599 to 2,465, with the
average request size increasing from approximately 4 KiB to 118 KiB.

I also tested DMA mapping with 33 physically non-contiguous pages.
dma_map_sg() returned 33 DMA segments, confirming that these pages
cannot be merged into a single DMA segment on this platform.

For safety, the tested merge-only variant included a check to reject
DMA mappings with more than one segment. The pure one-line variant was
not executed.

Additionally, I addressed the issue identified by Sashiko by checking
cmd->error before copying bounced read data back and reporting
bytes_xfered.

All 135 fio jobs completed successfully. SHA256 and CRC32C integrity
checks passed, with no MMC errors observed. Fault injection testing
has not yet been performed.

Based on these results, the bounce buffer appears necessary to support
larger MMC requests on this hardware.

I plan to incorporate the error handling fix into the next revision of
the patch.

Please let me know if you have any further suggestions.

Best regards,
Zhenpeng


HELPMEEADICE <yuanzhenpeng210@gmail.com> =E4=BA=8E2026=E5=B9=B411=E6=9C=881=
=E6=97=A5=E5=91=A8=E6=97=A5 16:46=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Martin,
>
> Thank you again for your feedback!
>
> I've completed the comparison between the original driver, MMC_CAP2_MERGE=
_CAPABLE, and the 128 KiB bounce buffer implementation on my Xunlei OneClou=
d (Amlogic S805).
>
> The results show that MMC_CAP2_MERGE_CAPABLE alone does not improve perfo=
rmance on this platform.
>
> Runtime instrumentation confirmed that:
>
> dma_get_merge_boundary() returns 0.
>
> host->can_dma_map_merge remains 0.
>
> The block queue's max_segments remains 1.
>
> The merge-only variant behaves essentially the same as the original drive=
r.
>
> Here are the sequential read results (MiB/s, mean of 5 runs):
>
>              Baseline   Merge-only   Bounce
> 4 KiB          11.81       12.20      13.01
>
> 64 KiB 12.88 12.80 57.52
> 128 KiB 12.97 12.80 67.68
> 1 MiB 13.11 13.05 69.43
>
> The bounce buffer improves sequential read throughput by up to 5.3x and s=
equential write throughput by up to 2.1x.
>
> For the 128 KiB sequential read test, instrumentation showed that the num=
ber of MMC data requests decreased from 70,599 to 2,465, with the average r=
equest size increasing from approximately 4 KiB to 118 KiB.
>
> I also tested DMA mapping with 33 physically non-contiguous pages. dma_ma=
p_sg() returned 33 DMA segments, confirming that these pages cannot be merg=
ed into a single DMA segment on this platform.
>
> For safety, the tested merge-only variant included a check to reject DMA =
mappings with more than one segment. The pure one-line variant was not exec=
uted.
>
> Additionally, I addressed the issue identified by Sashiko by checking cmd=
->error before copying bounced read data back and reporting bytes_xfered.
>
> All 135 fio jobs completed successfully. SHA256 and CRC32C integrity chec=
ks passed, with no MMC errors observed. Fault injection testing has not yet=
 been performed.
>
> Based on these results, the bounce buffer appears necessary to support la=
rger MMC requests on this hardware.
>
> I plan to incorporate the error handling fix into the next revision of th=
e patch.
>
> Please let me know if you have any further suggestions.
>
> Best regards,
> Zhenpeng
>
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> =E4=BA=8E2026=E5=
=B9=B411=E6=9C=881=E6=97=A5=E5=91=A8=E6=97=A5 05:17=E5=86=99=E9=81=93=EF=BC=
=9A
>>
>> Hi,
>>
>> Thank you for this patch!
>>
>> On Sat, Oct 31, 2026 at 9:09=E2=80=AFPM ZHENPENG YUAN <yuanzhenpeng210@g=
mail.com> wrote:
>> >
>> > The Meson MX SDHC controller uses a single DMA address for each
>> > transfer. Since the driver leaves max_segs at the MMC core default
>> > of 1, large I/O requests are split into single-segment requests,
>> > typically 4 KiB each.
>> >
>> > On an Amlogic S805, this limits eMMC sequential read throughput
>> > to approximately 15 MiB/s despite using HS200 timing.
>> >
>> > Add a 128 KiB DMA bounce buffer for multi-segment requests and
>> FWIW, while reviewing your patch I found that Amlogic actually uses a
>> 512KiB bounce buffer in their downstream driver: [0]
>>
>> > advertise up to 64 scatterlist segments. Single-segment requests
>> > continue to use direct DMA. If buffer allocation fails, fall back
>> > to the original single-segment limit.
>> >
>> > Testing on a Xunlei OneCloud (Meson8b, Samsung 8GME4R eMMC)
>> > running Linux 7.3.1:
>> >
>> >   Block size       Before       After
>> >   4 KiB            14.47        14.69 MiB/s
>> >   64 KiB           15.06        63.21 MiB/s
>> >   128 KiB          15.08        75.13 MiB/s
>> >   1 MiB            15.07        75.93 MiB/s
>> >
>> > For a 128 MiB sequential read, block requests decreased from
>> > 32768 to 1024.
>> That's a nice performance improvement!
>>
>> > Direct I/O SHA256 readback verification and fio CRC32C write
>> > verification passed. No MMC errors were observed.
>> >
>> > Assisted-by: LLM
>> > Signed-off-by: ZHENPENG YUAN <yuanzhenpeng210@gmail.com>
>> Could you please compare your patch to simply setting mmc->caps2 |=3D
>> MMC_CAP2_MERGE_CAPABLE; ?
>> From what I understand this will allow physically contiguous SG
>> entries to be merged by mmc core.
>>
>> Ulf: the code here looks similar to the sdhci.c implementation. I'm
>> wondering if there were any plans to somehow move this to MMC core.
>>
>>
>> Best regards,
>> Martin
>>
>>
>> [0] https://github.com/endlessm/linux-meson/blob/d6e13c220931110fe676ede=
6da69fc61a7cb04b6/arch/arm/mach-meson8/include/mach/sd.h#L627
