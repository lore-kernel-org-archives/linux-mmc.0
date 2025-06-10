Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314AA2C17A3
	for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560015; cv=none; b=teugzKw3i+S5Pdpelf+7a5hBIjAM4G3hkWg8oF18+VgdfXkrqt1DKwxNjAoQDP39UUuLeppE5R57RiJTmtdU4i9F1gaAfmcjK2JzNpEMKh4A3Ku5j5YxjYpAQ/4hVsHFp2BDp4/kB58n6bqvGqapNf7eAOI3vwfx98QHIYkJq7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560015; c=relaxed/simple;
	bh=BdEOtlwKT5cm8r2CwV8DPp+MGOvYNyQWEEliBnZf68w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBQtdnfCN00lvQxYLq9WgKFbpDqSawIvv52Cvj2CXOUpDuo+BOmsOkiGhq8aJiT4rJpzZmvIaQo+Fo2GdE+dKfyMMPq/cND5SQng1g9qjpItPN6dVp3xcchQ19XmJMhiFUOyoxH5R080xS31BH7/+IlioO+e0lo6Wh7Ud+w1qa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JEHtCXEb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JEHtCXEb"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-adb2bb25105so864100566b.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 05:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749560011; x=1750164811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ua43JbNUP+RRPO3HRaTeqoeNTy0CSQSVsdia/VGFSEg=;
        b=JEHtCXEbzOuiQwxAWbrFgpoH1kg3gXqgolDuApgn/XttVi+ZBDshB2ZecwisSQl60R
         lBpk3PX0665VCIEILCp8SlNQO9vXMeNB/5tv8v+A9rDRe//eWBHHc3jvdKhNx/ls3tPN
         GCVDdq3z+VmSUG1eoI3RlMEzmPC6rgRkTNOQn2QMumqIiuKKBimCIG019Mr05uTUWc0O
         /8csdJqAfMLU+vz8YWZkHWo5pU21HUZJoHwTuf3Wwa/P523LGSuU2K7t3M7HS2nzu/Vc
         dZetiT3HSM/7Ip5nbjgwm4I/+pjFwUbU334vuR+x4kfBN2Q6CrAnNkp0S3G9VdyvmFKS
         MpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560011; x=1750164811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ua43JbNUP+RRPO3HRaTeqoeNTy0CSQSVsdia/VGFSEg=;
        b=tx7VTkOAWcQhcsj9QCcF9MDEmj8j87hlvUiBJyGHs2E1rgYTbtkVzuBIBMdFjoMC0d
         OqeflxY4yqIXCkWtEuIDJTPxyMQl6jDVcxLJQIx8Leo46KtsF9OVaW9bEsvnobGBLsnX
         LhSnsVlqvDlpH/pORf8Oz3AfLW0l72DBZdpnE8GUT4h5/GMbVE5Qi2UNo4Iqq1DXLrhd
         BqL/OOEu9Axmnpw1vjS7/PoCFAK9cZWQARv2H9eq6k9lN/wkjdiHs2vy1HNG/wVMdwqQ
         7FBZLMCvBu5U+TYIELI/crOM14ZutbLg3i9QTfp6pTPNS08jDF5AnSlwUhPqoOiCK/wd
         vR5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsLL6UGtn04iQXHj2Uq8vJd3agqwNMCMnXBGwKdLMQ0FAcsqGS+EXNxtsqzYiHssVC4WW0D2AG1w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdAq+CqVDbLBgd/q3In3HL55NL7U5Ar/2NOsZqr/4HzpmLazwy
	zyXupT49xWAIdQr1IwZOlwcSt21ISk7y64cwdsGv5DtWnZ0OHjpNM5c0Iu+SaclvsXXmSZVmIuw
	vNo2WwEKEWKXHR58S+qkVvYtMqnYoY3JVkIy+jK3W4Q==
X-Gm-Gg: ASbGncvwXyiyZH/auVC+EDRxq94f3S/3GxdwR4rmUOkYJI8/Nbj2Tt1+l0DX0qUk3Jo
	njpLw//LG2BBkUjqlxU0w3iuIZlMQ/bFhJfRrlz4ZJRt7DjwL7lHsaB+k+Ij1yX8fNXiRJ53LQk
	HCcciboLE2cuEdHD1FV5BC2DNL0BYUa5jsM4pS1zYyV03j
X-Google-Smtp-Source: AGHT+IE0dnXtTd0cJKE4NbTH+mEK1zcSfNIzItd4LPIjOHRSwOojAZ1aIgIzoBnogv+j1Y6Xx9Qy218nbJLUy1UaMQg=
X-Received: by 2002:a17:907:94c8:b0:ad8:91e4:a91c with SMTP id
 a640c23a62f3a-ade1aab9825mr1680318466b.29.1749560011469; Tue, 10 Jun 2025
 05:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746581751.git.zhoubinbin@loongson.cn> <704447268706b1b9f25bbe9d15459163d0ac3404.1746581751.git.zhoubinbin@loongson.cn>
 <CAPDyKFo4n=K5-SeKFpCm-0u4Bbk-E0XqUrx+KSK1yuZa35a7ug@mail.gmail.com> <CAMpQs4JCaUzJXgcQwiWOoJ0YAj=ORnyaK0dC3-GamV-cbyhNnA@mail.gmail.com>
In-Reply-To: <CAMpQs4JCaUzJXgcQwiWOoJ0YAj=ORnyaK0dC3-GamV-cbyhNnA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Jun 2025 14:52:52 +0200
X-Gm-Features: AX0GCFv5tUexuVjVKPNZfCscSU_1kpR3xlCvzeNqP1bE90dtiqOaTc7DD1DnFvo
Message-ID: <CAPDyKFo5BjZsst=vXhU8Rv2HN-Ewy8vwnyFkZdo1-XCXX0_wsA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC
 controller driver
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Jun 2025 at 14:54, Binbin Zhou <zhoubb.aaron@gmail.com> wrote:
>
> Hi Ulf:
>
> Sorry for the late reply.
>
> On Mon, May 19, 2025 at 7:17=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Wed, 7 May 2025 at 09:28, Binbin Zhou <zhoubinbin@loongson.cn> wrote=
:
> > >
> > > This patch describes the two MMC controllers of the Loongson-2K2000 S=
oC,
> > > one providing an eMMC interface and the other exporting an SD/SDIO
> > > interface.
> > >
> > > Compared to the Loongson-2K1000's MMC controllers, their internals ar=
e
> > > similar, except that we use an internally exclusive DMA engine instea=
d of
> > > an externally shared APBDMA engine.
> > >
> > > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> >
> > [...]
> >
> > > +
> > > +static void ls2k2000_mmc_fix_cmd_interrupt(struct loongson2_mmc_host=
 *host,
> > > +                                          struct mmc_command *cmd)
> > > +{
> > > +       int val;
> > > +
> > > +       if (cmd->opcode !=3D MMC_WRITE_BLOCK && cmd->opcode !=3D MMC_=
WRITE_MULTIPLE_BLOCK)
> > > +               return;
> > > +
> > > +       regmap_read_poll_timeout(host->regmap, LOONGSON2_MMC_REG_FSTS=
, val,
> > > +                                (val & LOONGSON2_MMC_FSTS_TXFULL), 0=
, 500);
> >
> > Can you please elaborate on what goes on here?
>
> This is a controller hardware issue. We need to wait until the Tx FIFO
> full flag is set before sending the write command. Otherwise, a data
> timeout will occur.

Okay, thanks for clarifying. Please add a comment in the code about
this as I think it useful to know.

Moreover, I think we should have the value of the timeout specified in a de=
fine.

[...]

Kind regards
Uffe
