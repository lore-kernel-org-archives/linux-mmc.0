Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793370982;
	b=lCmqpAmjVzUEFm277zzHdyTclIQrF4F5K38/Gz6qGXC4aahPqrPSm7F67KqmexU9gMqa
	 AgLVuLdX4gOips83rLU1q6nZ0/OUmOMh+g9V0Q3UvfnOUYW/D8Lv3kv9at1uY5lbWJezC
	 HUttIWe2tQYGRn3TcSjUEEXoqAxt6TiWzJY8sObZcbPiqKhYiZEVeFiJ2G+/Dl7oMxpOB
	 qqy5z2Gf4MbpBMCY9PjY+1vfhMie06RTKrT/cnUEPjrG9++efy/4xm60KsELQ1Uq2u+pA
	 UunC2HpT8aNGkM+l6Ggx78i71Ye1du/8Y6mUQa9OiOqmK6ec8RZ/uldAfxG1WUeRr7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=J4apMJBTp7WdrBg4suFHTn5q3Lrcb7dvdWPvcbdMeiQ=;
	b=xQA5bK42JnId+pIX+SzeskGqPAlx2S47dy/F/gztGbmS31CznskTnQF3Bzal728FiVMN
	 xs6GbtM0eZeCKHxn/Md0FS/DbObGM8Uoj0Qv0VA2llocPHR9H2EvVlEADo2HOOzLxcOT8
	 gmZuM9cxOn0WNpngF/YDkkYequkdEoeutAs9vHaDealwo3ltA6M+erpm2zD5RwvY7bjX2
	 7MpYat7972m+Xo1y+UEgVXe/QDdtYmQy6e4DLZpoFlSKd/4fufnF4Y6K3m106WCrSFjs2
	 D1DuKWZDDio3zRMXu6TfSFHujyWT7gnOcc1z+vebNzM5iPjNv640n2ahHVYlR7aOuNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ndvex3Bl;
	arc=fail smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D87606A31A
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8D87606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ndvex3Bl
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso1141048a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 07:36:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793370980; cv=none;
        d=google.com; s=arc-20260327;
        b=MEey+oLyJUbg4wmjHnVojn4FHeYrjDAvxFAOUjFRazD5EvMOPysnX+vrrehtGo0YlA
         527TAvLkPl6eYGX/5MGDUT9pUqvrgwUn6cyW9q00f+rWE3vi2euWEP+Q9i51AfFEfZMA
         MPLmOkpwOaexOBOKULtsUIOA8cK+AjKNihkMft1TQZAi3avbTj0EfcJOJ8xDSk81yxs9
         Vx8BxHRXgqs8PeQe7UyQ+ApRF33FLg40kxIb8I4Gkgd/5E+/62bS2+jITGKnp+zCY1jg
         pWv0FBLyH0S3XvY5NoIJxX07WA9dIk8O1aD5Lx7ymXSJlp9jpaR7uA5Pin5TRQ/STG3M
         iLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J4apMJBTp7WdrBg4suFHTn5q3Lrcb7dvdWPvcbdMeiQ=;
        fh=gMZ/4b2yFZ2AqtY7WURuLPmsn9DfaRtSJiKl1owskLU=;
        b=Cwhn+IauAEa2GMfs4VZplLg9wCoav0yfr1PDlnuBn8A60vvnrnOP86yDx2IzNiK9Ek
         lF2DT22KmGm8/yOQgmmZIpKnuG6wyCA/Zaf/gK/Qs9ejxf8vo0lxPHHubVlsnhrBf3jr
         qTJ6F46p1KHrSeewvO6Jx1ypu/wyYVErKbS9nxWUjyONBvcBj9mXXXy5dqQ9MWUY+fnC
         MdmA+rZ59uzC6h5PNAgNEe2rnFuy/yEuYM7pIALK1PlVbt1EofrA/mfAP7sPTB6FV0M7
         o02f5eCHl5vP99kGqkkbLWY8w59NvGUdPd3BtbaBu/eejQVNym0tnSJociRnPtV5Wxhw
         ZTSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793370980; x=1793975780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J4apMJBTp7WdrBg4suFHTn5q3Lrcb7dvdWPvcbdMeiQ=;
        b=Ndvex3BltjFehYl2G/oYONTnTGU07HrztEr9qfUelrnSpHWiZOSm0EfDP5jwqYFkt5
         WzdoGX794XnJj3asgrPtaZeHxeEYaFG7iKK/dQbS9224lVfcGRHhOGY6fgDCZei6XLtW
         GjPUulLx5r07+pyU6XXso4uGPi8GYTy8P+iZm6pwYEFdYBfgTFmqMqwd/y25Ml5dbGUb
         /rkPGKDj0iXaFvS179wVOXovmjIgWMK8sv0lR5cCY3ni1dF5b1q2+drGoFqhLHqt2gle
         Pf/fUBH6Jow5RC5NnGvfDBhk9F0TWkJqdNmGgbSFAOgfB5oJIHvLRgRqY7b9zEHfRkZW
         AYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370980; x=1793975780;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J4apMJBTp7WdrBg4suFHTn5q3Lrcb7dvdWPvcbdMeiQ=;
        b=xtPzFa+WgLmM0SC4jkMlVHJB6WIDzSKGADyTW5PzWD95ow0PoAtMsW2XZiKE5Q6Ycj
         3B+ZPEnBtRs1bTVzY03J0Uj6w+5I+lglEqWaoUd5NJ+ogVhODV818c6tw2pRlItYY2ZO
         gCYq/u6mdG53M7EBh/V9zR1xa3uTcIDfQGfzZvufg+3Yz6yznNxiXj7ebV4T0v4YHUmG
         SsL2Xokc/ucFLuue5I+00Cu8I+oqXpDqlip1ueUUHuZqQSQLP56lgMg1winxockqyIMH
         dnJK4XcUaerIP8GC182BMK4zghsHtXYFGqHFdujPn+P7DKMUTYvZGiTHuyveKRcKAoM1
         xrLQ==
X-Gm-Message-State: AFq9FYIS0TRk0Nz+8Na31ttAhJMT4QW8dTSZAMGCshAiEbEfl2f7E4q6
	k8NSgjGBaXUtE8A6rQ/52v3x3Vf4Zth0KQ1IKESoIV1ihu1EIQHA8yfRsQHONXqbBK4YmHd1dFd
	RFLqQI+69gXq9EmrG+uhrYGt9hsntB3M=
X-Gm-Gg: AYBFou0Vng9m9gFcp1jOWnecxligJRzbD4fnv3185Vn5yRZFnneK7RKpQlS2PpVAXtN
	ALQTBS81z2DVOY9cZHfIkmkvMirsMYadaSFoh9Hw6RzjHieZkqcEXseD6rHqn17SVt3qWCChIiL
	ZeZFvgnkwcirm/JgsdLT3H/Wr3L+To3HBC2hKfojKNlWVnkhqAxjXnVvFhB443g6ck72ey3V6nf
	AdFYMi4n+H4ZTQAwB+9hKOzAaBH9Bn/ArXwllG1dvGH2wboXDgyVnjr9W5Tfl5NLkZVkLIGblow
	ACbGLPimiw1/euH4EfKKuctK7nXj0D+UJAE86rCEF3HMUvj2uU59X+OUTzRizTS5/w6yohNCx8l
	riczBvvddCGCUpkjMJ1SXHEkcfRjK4Kvy+5Zd8yEHNumRSK/0Vml0ejR5S2XpdGupVSYiEI8=
X-Received: by 2002:a05:6402:322:b0:6b3:b7bf:ac53 with SMTP id
 4fb4d7f45d1cf-6b4d33c6adamr1283454a12.4.1793370980086; Fri, 30 Oct 2026
 07:36:20 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030143151.2916788-1-codex@local.invalid>
In-Reply-To: <20261030143151.2916788-1-codex@local.invalid>
From: Samarth Narang <samarth.colleges@gmail.com>
Date: Fri, 30 Oct 2026 10:36:08 -0400
X-Gm-Features: AclHuK_uFaRH3rHXTBPe7XlybWVryPD5O6NwDMdPcOAxOE20GZyoJyLrqAWMhsc
Message-ID: <CAAbz3fQReXcfPVHnTo6DkjUdMxYcjQVU2iOoZVFYzuv56FoKCQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sh_mmcif: unmap DMA buffers only after the transfer
 has stopped
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, the sender header on this mail came from a misconfigured local
git identity. I can do a patch resend if required.

Best,
Samarth


On Fri, Oct 30, 2026 at 10:31=E2=80=AFAM Codex <samarth.colleges@gmail.com>=
 wrote:
>
> From: Samarth Narang <samarth.colleges@gmail.com>
>
> When sh_mmcif_end_cmd() is woken by a data error interrupt or a DMA
> timeout, the DMA descriptor may still be active. However, the function
> unmaps data->sg before clearing BUF_ACC_DMAREN/DMAWEN and calling
> dmaengine_terminate_sync(), potentially releasing the mapping while the
> controller is still accessing it.
>
> Since data errors can be triggered by the card, a faulty or malicious
> card may cause DMA accesses to continue after unmapping, potentially
> affecting reused IOVA or SWIOTLB mappings or causing premature cache
> maintenance on non-coherent systems.
>
> Move the unmap after DMA termination so that the mapping remains valid
> until the transfer has either completed normally or been terminated
> synchronously.
>
> Fixes: eae309836509 ("mmc: sh_mmcif: Terminate DMA transactions when dete=
cting timeout or error")
> Assisted-by: LLM
> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
> ---
> This issue was identified through static analysis of DMA lifecycle
> ordering and has not been validated on hardware.
>
> Since the request pages are not released until mmc_request_done() is
> called after DMA termination, direct-mapped pages remain owned by the
> request. The potential exposure is therefore limited to the DMA mapping
> layer, including IOVA or SWIOTLB slot reuse and premature cache
> maintenance on non-coherent systems.
>
> The fix also relies on dmaengine_terminate_sync() stopping the channel
> correctly on both MMCIF DMA providers. However, shdma clears CHCR.DE
> without confirming that the channel has stopped, while rcar-dmac polls
> the bit for approximately 1 ms but only logs a timeout if it remains
> set.
>
>  drivers/mmc/host/sh_mmcif.c |   23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 8bd9cdeda..7b33f832b 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1173,15 +1173,6 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host =
*host)
>         time =3D wait_for_completion_interruptible_timeout(&host->dma_com=
plete,
>                                                          host->timeout);
>
> -       if (data->flags & MMC_DATA_READ)
> -               dma_unmap_sg(host->chan_rx->device->dev,
> -                            data->sg, data->sg_len,
> -                            DMA_FROM_DEVICE);
> -       else
> -               dma_unmap_sg(host->chan_tx->device->dev,
> -                            data->sg, data->sg_len,
> -                            DMA_TO_DEVICE);
> -
>         if (host->sd_error) {
>                 dev_err(host->mmc->parent,
>                         "Error IRQ while waiting for DMA completion!\n");
> @@ -1208,6 +1199,20 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host =
*host)
>                         dmaengine_terminate_sync(host->chan_tx);
>         }
>
> +       /*
> +        * An error IRQ or a timeout wakes us up while the DMA transfer m=
ay
> +        * still be running: only unmap once it has completed or been
> +        * terminated above.
> +        */
> +       if (data->flags & MMC_DATA_READ)
> +               dma_unmap_sg(host->chan_rx->device->dev,
> +                            data->sg, data->sg_len,
> +                            DMA_FROM_DEVICE);
> +       else
> +               dma_unmap_sg(host->chan_tx->device->dev,
> +                            data->sg, data->sg_len,
> +                            DMA_TO_DEVICE);
> +
>         return false;
>  }
>
>
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
