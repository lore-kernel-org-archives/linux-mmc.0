Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC92C1E519;
	Tue,  3 Jun 2025 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748955301; cv=none; b=ktcTVk8q+8PEbBp7ksktc3BJVWwOYPPJo2CuyAXG0bZIhhEoXugMRATUPMQtA+HLW+VVXUR8ngCs3LTcqDR4GK1bNJKfelsOG+UIiuLeCmg4/tDr2Ys4Em6YLx/c5I6lsncofpGh62F+HMuFn5D79BoJyeSsr2FziHu/Tod4lUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748955301; c=relaxed/simple;
	bh=/dAIwu0T7tzFgg3iCU6rIlWG6qfNpoFwGXKYEKntOA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSK8fKrAsmC/cE/29zp45GbCrcP07r8hIxv/65rbX7OVstGMUGPQrR5mw1QRcR6PvU+BB/tNU10nDgC6psCWSVo+JdTSn69JyqnQmf4i/Z0syuAtMHWETXJmPXYSN2BLuaRmS6r6lqrLI02puSf+2gaKtnLvJsoDbzZiqtKq/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1k0ysze; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1k0ysze"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad88105874aso879499366b.1;
        Tue, 03 Jun 2025 05:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748955298; x=1749560098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+UZHJ2oORlm9mx4aNJvJN/pklH00QSvht/GBCe488k=;
        b=O1k0yszeg3Maje+qroPtFB/G7tmsthYgSuF9mjxU+G/MWgGnJTtOm93U8h5Bwv3mL6
         kleV48tdz+p3xVED5umuwtXKgkf941/wS2XOnpX+BSbc8OnjrHH1HiR6E+wH6fOmL0SU
         +aMbdRSTERPVnAhDjZ1HqlCR/7WOHwn63Dot/veoWLqguoMhuUTb5m8yghG60PcyYSV4
         IPwKrmmRrsJkrOfYKevGlBLsDUBLuBwuvHiHzxheFdbqI24f8GMXu/LogLD8kWjXDh2v
         CvTcPs03huF5s8Ac03VZ26sOMnq6N1VhYZXs5yUw7Xnq5vNS/Y0cWg+iCnvsId2tL262
         Wzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748955298; x=1749560098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+UZHJ2oORlm9mx4aNJvJN/pklH00QSvht/GBCe488k=;
        b=FqyPEZUoNy5gwjGL09pfSbjhYFYq+/W5U9tQIGdU18XvNoNp8CwmpTBZAqn3N3Uk0r
         EzbrIU5tGJpqa8Z9Q4aW9CyKdJXSINMRKI2O8bdpvOe4fq9lGnJZ9/bMKQGmN7JNefYU
         ac1Ao59dVPk77pBj4iSHZxVmRyxftAgFZVgR9YCw/jOe54sTd92GL+EWWRniD+fSKD4h
         gAydd/pA1EuZniR8FeswqLmnDab3yd1eSGeQbDKmrzN8DSC19ubP4mNftbn+TMHMFSkl
         HaiS3AOiV7KgzdJrFgW11ajc62c/PdOSlJhKvQVsMcZ1xHLma1Df1zjaNBWH3layJ5XN
         PrEw==
X-Forwarded-Encrypted: i=1; AJvYcCUO9nY+igG3cSESzDv/kD6MCZLoTiUBVF9WdEQA3At7bF4+wm7/M6CiHphVyOEpspxGT3jAXrTU9UoE@vger.kernel.org, AJvYcCUkzEP3dY5/JBle+P8+Y7ArEdUTLKqjRUmRfhgrj88is9LHfbNVBfapa8s2JtmypuJ3OWaNRF3vLGY2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxucih+vrwvh0tBP7yQ4a/pmCCeMwFc5oilW6OLwhjNGYmlthq4
	NgYN/KRM8JhlaMHw1Vaj+uGKOhMxK7ZxD/nfidAKi+mE5qkI4TlTgotPfHuvoHoj+8j6YOna4U8
	Ta8mxvtgiJTJIlgad3Pu02DBdsUIy1k4=
X-Gm-Gg: ASbGncvT4WRSmrUlOamhS0S1GLJ+a8Tz4F/j0NMqSvbnYaJ6jy5g5V7SIJWyjqKRRxd
	mWiq4MTyp1uY4o7teQh+o3SebFqjKdf+qR63fF+W2SEeI9YRWYHfYTfMXVj5dmydUmsGDoTQvlc
	Yw0hElRE1xUnoifJ4Wu5RlYMVBDw63TzVPTl2hJtTdbUM=
X-Google-Smtp-Source: AGHT+IGDlW8MDdTNB0VgQWuhPiBRj/aK0GGHFCiZpthrYERZp7ysLrGJPfPS797EiAjNE1OLiGDDU5eJieuTQScgWVA=
X-Received: by 2002:a17:907:7b8c:b0:ad8:8529:4fa5 with SMTP id
 a640c23a62f3a-adb32580593mr2018270166b.46.1748955297934; Tue, 03 Jun 2025
 05:54:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746581751.git.zhoubinbin@loongson.cn> <704447268706b1b9f25bbe9d15459163d0ac3404.1746581751.git.zhoubinbin@loongson.cn>
 <CAPDyKFo4n=K5-SeKFpCm-0u4Bbk-E0XqUrx+KSK1yuZa35a7ug@mail.gmail.com>
In-Reply-To: <CAPDyKFo4n=K5-SeKFpCm-0u4Bbk-E0XqUrx+KSK1yuZa35a7ug@mail.gmail.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 3 Jun 2025 20:54:44 +0800
X-Gm-Features: AX0GCFti6lVzu3WMi3d-hrNdeeTMc5uSmRkY_kyrecCt1CVJXaWP6obNQRLY6Cg
Message-ID: <CAMpQs4JCaUzJXgcQwiWOoJ0YAj=ORnyaK0dC3-GamV-cbyhNnA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC
 controller driver
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf:

Sorry for the late reply.

On Mon, May 19, 2025 at 7:17=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 7 May 2025 at 09:28, Binbin Zhou <zhoubinbin@loongson.cn> wrote:
> >
> > This patch describes the two MMC controllers of the Loongson-2K2000 SoC=
,
> > one providing an eMMC interface and the other exporting an SD/SDIO
> > interface.
> >
> > Compared to the Loongson-2K1000's MMC controllers, their internals are
> > similar, except that we use an internally exclusive DMA engine instead =
of
> > an externally shared APBDMA engine.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
>
> [...]
>
> > +
> > +static void ls2k2000_mmc_fix_cmd_interrupt(struct loongson2_mmc_host *=
host,
> > +                                          struct mmc_command *cmd)
> > +{
> > +       int val;
> > +
> > +       if (cmd->opcode !=3D MMC_WRITE_BLOCK && cmd->opcode !=3D MMC_WR=
ITE_MULTIPLE_BLOCK)
> > +               return;
> > +
> > +       regmap_read_poll_timeout(host->regmap, LOONGSON2_MMC_REG_FSTS, =
val,
> > +                                (val & LOONGSON2_MMC_FSTS_TXFULL), 0, =
500);
>
> Can you please elaborate on what goes on here?

This is a controller hardware issue. We need to wait until the Tx FIFO
full flag is set before sending the write command. Otherwise, a data
timeout will occur.
>
> Note that, the mmc core uses a couple of different options to manage
> busy detection monitoring on DAT0, for those commands that need it.
>
> *) MMC_CAP_WAIT_WHILE_BUSY - if the host HW and the driver for it
> supports IRQ based busy-detection.
> *) host_ops->card_busy() callback if the HW can poll the DAT0 manually
> for busy-detection.
> *) Polling by using CMD13.
>
> [...]
>
> Kind regards
> Uffe

--
Thanks.
Binbin
