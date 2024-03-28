Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CF280614
	for <linux-mmc@vger.kernel.org>; Thu, 28 Mar 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633045; cv=none; b=IC2FTv1wjctzxxKP9DOBmHj+eLF2KPzznKCb6WG1psOjsOTvuCC0GDNCNFCTuFUzrC4KTn0psEnJHjXAXX/a+er7NLoVYP60gH4lJXz10M5tuHPuyPZjS6FaPD1qXG0OGaiNp6ICCIfkg6IcOKqNYZ2RVOYW7XEiB1GDDwgMiaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633045; c=relaxed/simple;
	bh=vhptj9/Vq4Rm0PoGzxaGiCJqIgDUZwkAbXDvc9ksjDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgN6inN/ovWlrjJszV3kOk9Gb1jIBPa0jYUZNi3OGakT8xG0bzJipNNDl0lRViN+cSJthN3n8PyMIrfYShxRNrta+z2yqrwCf9ULwx7d2dZYlCdr32Av9KkCljuanvikuF/ZzXfBTv8BRdyTKmy9/VZ7zp13K4SUpLP5oZBKYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gquCu54b; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gquCu54b"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc742543119so993854276.0
        for <linux-mmc@vger.kernel.org>; Thu, 28 Mar 2024 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711633042; x=1712237842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhptj9/Vq4Rm0PoGzxaGiCJqIgDUZwkAbXDvc9ksjDI=;
        b=gquCu54b7my9LLg/q4oPnqkKhGJwkL7ltG07Je+mkXnkO0tce3QQpinYIyA7vcMP/8
         Sauy3czMzIHrSZ3M3UhQ+GugaxC245fv7DBzi8sGuKlDvKv23NV1VgjUUzcezwu/i0ml
         3HrBrO9F758spxgQNWF+Ci5uC4PqVuJlKBak5mCFxHIhRfXo6w6Nmf2on3E6OtKniUNV
         LT+M+VYkCIqd8Ya+BOtEl1V3iANk+gyZjZ1mB7ci4WB+l2OjnJnP7F4pH66J5T09vOM3
         DIs8FWa5IPBud/6lNqR+RP9dQvkjXcvuHeTQr6oNe2jFd3rTU0IALrzYHbQvhymkZzQM
         YC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711633042; x=1712237842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhptj9/Vq4Rm0PoGzxaGiCJqIgDUZwkAbXDvc9ksjDI=;
        b=DX/BLsIOcBd8aTD8riu6eeEIPO7zgIzMG6ia+SoSU0hOttr6m4lK9r62zC2ZOcP4gg
         iwWXOfJXjmCp6qDMgEI7HJsnVMT7LOPpPSwnbsksCFaGzCkB3g5RSubCcD/H07LkBQUE
         s78ksKMNaRkFSWou9x2NzvB3KPXvop0Ta76FEbKWRemYBpjtp7WMLtd2w97untPwuAVR
         s/cOvnG2nFIgRTV5o362XLeSMncOF7co1diMvMnU6zX80GM+XuHFOmWLzZFzzmXdOYru
         b9d69LcNdV3PWOs9sa49kur+tdgCbdPUQqDJhtF2SGZwhXVbbeJ6OGNuRxWFlyU+Lksl
         S0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXXUWjX7vsYUnGD9JDch8tClz99Mnkip/vJrjIEuYojktBL64bw9U/5HtRXYNpJVmmlY9+TW2COhQmoN9viBGJGM2eanfrj8qMo
X-Gm-Message-State: AOJu0YyNJhQ8eAXAeXD3XwBTKKx4A/giPwRhqtaD6hOaVA+rucVtlM7B
	abmtBFXR4st1qAuh52HJJJh71DYzGuqJYLZPyyczaSSgKfpw5cXY0N9tTugRkzBASpw5RxHwyVN
	qRvRmYbUZ1fSevHFkJEPmWiuC8rp2ueh+mQCDWQ==
X-Google-Smtp-Source: AGHT+IGjGHEbsk10nKTaVGgOOQzkHc5Qm9STf87bHGVpMP0DEmjO9lKjEWUgvRJ23UvcJC23rRkiymMtwiTmbVMLRs0=
X-Received: by 2002:a25:b9ca:0:b0:dd1:3cc1:5352 with SMTP id
 y10-20020a25b9ca000000b00dd13cc15352mr2820459ybj.15.1711633040798; Thu, 28
 Mar 2024 06:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-10-apais@linux.microsoft.com> <CAPDyKFpuKadPQv6+61C2pE4x4FE-DUC5W6WCCPu9Nb2DnDB56g@mail.gmail.com>
In-Reply-To: <CAPDyKFpuKadPQv6+61C2pE4x4FE-DUC5W6WCCPu9Nb2DnDB56g@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 14:37:09 +0100
Message-ID: <CACRpkdZ7wAbtTUmmLCef7KnATmfZeAL26Q-gLqnGe3CdZ3+O3A@mail.gmail.com>
Subject: Re: [PATCH 9/9] mmc: Convert from tasklet to BH workqueue
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-kernel@vger.kernel.org, tj@kernel.org, 
	keescook@chromium.org, vkoul@kernel.org, marcan@marcan.st, sven@svenpeter.dev, 
	florian.fainelli@broadcom.com, rjui@broadcom.com, sbranden@broadcom.com, 
	paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com, 
	manivannan.sadhasivam@linaro.org, vireshk@kernel.org, Frank.Li@nxp.com, 
	leoyang.li@nxp.com, zw@zh-kernel.org, wangzhou1@hisilicon.com, 
	haijie1@huawei.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, afaerber@suse.de, 
	logang@deltatee.com, daniel@zonque.org, haojian.zhuang@gmail.com, 
	robert.jarzmik@free.fr, andersson@kernel.org, konrad.dybcio@linaro.org, 
	orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, 
	patrice.chotard@foss.st.com, wens@csie.org, jernej.skrabec@gmail.com, 
	peter.ujfalusi@gmail.com, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, jassisinghbrar@gmail.com, 
	mchehab@kernel.org, maintainers@bluecherrydvr.com, 
	aubin.constans@microchip.com, manuel.lauss@gmail.com, mirq-linux@rere.qmqm.pl, 
	jh80.chung@samsung.com, oakad@yahoo.com, hayashi.kunihiko@socionext.com, 
	mhiramat@kernel.org, brucechang@via.com.tw, HaraldWelte@viatech.com, 
	pierre@ossman.eu, duncan.sands@free.fr, stern@rowland.harvard.edu, 
	oneukum@suse.com, openipmi-developer@lists.sourceforge.net, 
	dmaengine@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-mediatek@lists.infradead.org, 
	linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 1:54=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:

> At this point we have suggested to drivers to switch to use threaded
> irq handlers (and regular work queues if needed too). That said,
> what's the benefit of using the BH work queue?

Context:
https://lwn.net/Articles/960041/
"Tasklets, in particular, remain because they offer lower latency than
workqueues which, since they must go through the CPU scheduler,
can take longer to execute a deferred-work item."

The BH WQ is controlled by a software IRQ and quicker than an
ordinary work item.

I don't know if this little latency could actually affect any MMC
device, I doubt it.

The other benefit IIUC is that it is easy to mechanically rewrite tasklets
to BH workqueues and be sure that it is as fast as the tasklet, if you want
to switch to threaded IRQ handlers or proper work, you need to write a
lot of elaborate code and test it (preferably on real hardware).

Yours,
Linus Walleij
