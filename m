Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56EF19047A
	for <linux-mmc@vger.kernel.org>; Mon, 20 Oct 2025 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965964; cv=none; b=Mey5L4lIKbsMr89hq5GWZK6ef30QT555D+kJkeQ83l7/ihsh7ExK23W8carXWuuBAzVo8EU/5W7V6mnE/ofmzL0q3hVVll9CBRz7aiyEHTEsDVWtAGBIdwpfgkk3vW5q9yWAPV1qvOamPiZ6CBV0Fw5PyrgDtP+CjyVVvWPDgaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965964; c=relaxed/simple;
	bh=dcGsIZhyf36iZn4REHPSPWQwJiuw8vu1Pra01rnH3FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ousZhA065o3KmteSFnJER3fswSPQUd5yjnmaQWI9Xxoml8GwamffJQXS8mhSi/eWzOiKhdQW9qfd4Dn1GGNHXtGDSEr4/rY4BGycH6q2VHUoX7FoqGe8P/aNNOH23aotxXWup+olJZGw7vSdkkec0vmUTQS6OjSK9Kq8K6dspNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTx5PHzv; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTx5PHzv"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8923b2d9954so182998885a.0
        for <linux-mmc@vger.kernel.org>; Mon, 20 Oct 2025 06:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760965961; x=1761570761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBUVnqjCVXD8SXpPqOAGtUoqSANNBD407KWXGjM/EKI=;
        b=PTx5PHzvBZNXoeOIzPACUlPW1+e/B0BIL1rHJEE8FWhioTeTJUh9FcjyIMQvq5Tziz
         zH5FMWKTUEr2T/KOqnSc1z4VkMEEwKuL1Dm9nCpzKvE7BhKXAG5tpMVK5IqwpKclf7eQ
         eurVpeMaMOzqMP8vPzxTuvUWGUbCxSKKbyeO57xWp1DhZj39x4TDablu4wArT3R6lJwh
         Bxi34U3DZ9D4YE4bfs1CJWLbTwRGzX0kcr14tHZNFMwfWydAscpw8KLAu4m5CJbBJhOk
         Fug9mBQp7GXHppliF9eMV6IGUJLldF+L1Up1x0KUNvGMQeky5Xo535QLW7VXTn7ViACw
         4O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760965961; x=1761570761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBUVnqjCVXD8SXpPqOAGtUoqSANNBD407KWXGjM/EKI=;
        b=HOGwJzrq1z+s7dO+FnXZmaoU6lvMWPegjC3y30KavSdyoXWH7LvpuQC+Ihs3WRTiHT
         X1u1StUNbCdIJHPxfoMugoylZbejmSMqmbruxrOuAv62VFbH0Hg/hYTpLxk06bP/8Fbs
         4pyqvhNGn/K9TSPrW1/hxhD4tS2alRRIBpsU8XJw4ATJfXoG3IOIiLw8t1GBteyLA7H2
         zN6FgmZL9LMlLnOmBS5RFO3cZP/hp7tZcfrVdDCfQXVffo/zGv9lfM3oUqOHD2n4FUjt
         z9AwHRGPjDG7QJbVNbE58NDE8qs1awgXCRcuS6OVqzJtFWyMnpBbFWKixFucCIizrbIs
         jDxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe0/EfIbdSvv4Oq4yUllsRIoIAq0TLJwCOkhKtvBamhEDr3J30B9fFHHRJH44x+IsnhUYr/rPKNm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP1SbA+yIAuqDMd7MQUajVchPkAlh6vIJ7Ca3XSJVBdlMMb+QC
	+DrMvGDHMPU97oE+KZY8IhWx8qH89MVWEDpCnyiRByUZGVfTGQgquXX7lPYReMKG1qY5k++GClg
	NMxtsk/0m62Vd+0WBRt98YGruHedKhbg=
X-Gm-Gg: ASbGncsXL4udXNfQzf3hRpe1hhMIt5Oar8z9lY/tJvAuqYci5W8BMc9oD2daYUmCze0
	Mr5fBkvQC6zwGFDZBBig5gTBiFuOt0KDmpa3R2+LcJ9zb/kuwIDbkedv8Nbp7uEJgISneS/8WkU
	HJo1KCW+tCoqm+iXGxDUfIt89Z4DJGrbvqEsLWrOkKQ+zIhUZm06ldrNNFG7sxI8gujnt6szw8y
	wYKl6LFvQ/QiPKnk/M8BOvDFoX/+u0CdLC1BrKNxIAtcRJg23FKxiTyWQFrBeeDWW6LGd7z
X-Google-Smtp-Source: AGHT+IGWxr/3mKdNcivZNd9RwVP4zsx46rNQciik7IpucNlg5iFi2P+OzOHQU96V44rleOE6oK0rCgpnktT11M7Pzus=
X-Received: by 2002:a05:620a:4143:b0:864:ed9b:d4be with SMTP id
 af79cd13be357-890707fd73dmr1295127685a.47.1760965961487; Mon, 20 Oct 2025
 06:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1760924981-52339-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1760924981-52339-1-git-send-email-shawn.lin@rock-chips.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 20 Oct 2025 17:12:26 +0400
X-Gm-Features: AS18NWBpmljHOpflw5MLbHoh6UVu36WNpev9Zr5hHNHjSKmGAymIDUgODLvValE
Message-ID: <CABjd4Yx6AzeC2sn5UMa0sKG+BSV6tp8kYPQhyiE43jFQQxeB9Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Change DLL_STRBIN_TAPNUM_DEFAULT
 to 0x4
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On Mon, Oct 20, 2025 at 5:00=E2=80=AFPM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
> strbin signal delay under 0x8 configuration is not stable after massive
> test. The recommandation of it should be 0x4.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks a lot for this patch! With this applied, I'm finally getting
stable eMMC operation on a TouchFly CX3576AN board (based on the
Rockchip RK3576) I'm currently working on. Note that I've also applied
Sebastian's CQE patches [1], but the controller still kept hanging up
without your patch applied in addition. HS400 and CQE seem to work
well now.

My eMMC module identifies itself as follows:
name:SCA32G
manfid:0x0000df
hwrev:0x0
fwrev:0x100050514002b300
oemid:0x0118
rev:0x8
cmdq_en:1

So,
Tested-by: Alexey Charkov <alchark@gmail.com>

Best regards,
Alexey

[1] https://lore.kernel.org/linux-rockchip/20251014-rockchip-emmc-cqe-suppo=
rt-v1-0-918f03de0cb1@collabora.com/
