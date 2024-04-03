Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A81069302
	for <linux-mmc@vger.kernel.org>; Wed,  3 Apr 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134458; cv=none; b=nyObh7e6USSI1x8Lspey4fLC9p7N87c0qoW9s1Orz0Df0mapSEIVxtNEEVk9COzVq/YqhSRXIIhNoOVzBbLrQxtNk+QUBJQb1Kfkr9qL4BsRkSz2hGz7PnUFsFqM82rjaDMNo6H86cGZnazc6hsTmB03HsQSW/d1jtYvlr1aiW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134458; c=relaxed/simple;
	bh=tphQMlxXfj94sQmU9WvMO9Ly9qqZqs3IYO1KFpzl2dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1Ebf8ZrBrDsVkpBeGnn8OaHXVAi0cbA2om0VSX0YJ/4NvdGp9F74Nd+FtirGj2Nmmay2oTnS74npT0y1hPXeGfT1HpIrhnigft5Ycdp2IEJ8TAlvXnMeTivelcR1eDXBOkcBMq3KlYwoPdJNflomd+Y0I7XXg7uWOurLBy6I/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QK1yOyhq; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QK1yOyhq"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a128e202b6so2014742eaf.2
        for <linux-mmc@vger.kernel.org>; Wed, 03 Apr 2024 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712134454; x=1712739254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAQoe+KPiy+sOp8T5fmyx200mSrFzvOF6EO15y9FXl8=;
        b=QK1yOyhqXIcazhXN7djuLQA5Yj8vYNo+eOnoNkoJ+EEt0nqdsYTtxwmCYeOHsch8F6
         k2zfoME+exX8r4bWq5wa7RMtsU3Ez9PFYkbo6twf6PPbqZtZyCtLj3CO/AEHG8PvmC71
         6H+0onQMIaW1JMTkNY6ITjXY8ImeSN1UhemPS3UnP865cdLarPdqRTteT4q2OaXAj49v
         8XEy6diKa+I1bwm+34IYNxZ8RbmI+IDvjoj0fNNTjrqEU9ZzEHehaRmfb0qzCh6J8Iq9
         P/er7ZHf4uhnTH7Hr+SyhT2m4vmfNcIrUDZe/Bx+DzoU8hcMp1hUwYx82udX6OnHLU0q
         RyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712134454; x=1712739254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAQoe+KPiy+sOp8T5fmyx200mSrFzvOF6EO15y9FXl8=;
        b=G9qE5ok9YuWqGExdpShw7M1xUJt0ImuDfpRi02xgrKtJWhmHr+BRzRXMqwC8cnE1XB
         EhMUVV46OiFQ3oeXsvOxSqRAJgIOiL5SfQkYOXZ3ZW4H7QMMeblYFaQmHmCustcHY1iv
         gdgPm1zm57kxEdR/KhCNRneCYibt5iSC70Y8MC/9iQ27WgB1feiFrNvlLf5QKfOUZGcd
         HmMQ3INl4+HKVl+WLIV3XNAaQws2up2cjA9RJPNleKhzsBQBd/zvzH3eYCL7spQcCeTF
         ryyC44MBb/l951Xw+wKkpi6bPgzUt8giclNZA/WB3uL0qTSgF1ql0krJECdvb0Yg9x0R
         Rvtg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ/uRKBCxG/F44d4qBD/cW/lMnoIyzYVxGEFauXt1k8oZyYqqJ4zShLVWQneSro38E5LeodruU83GsdztBXOb92QwaBX3s5FRl
X-Gm-Message-State: AOJu0Yx9kn5U1XWO40m4Aowkd7syXAhU920C/oWItJojEIzTV1aMmkUc
	6hECGTWkb3YwqS5IvMIdj+N1JKCcOEqGvZcc7Iv3mSOgNouN99jU9+QPDNhQoPxF3m4MJnTHnyr
	/dBz9IF5b88POC0bf4t1QZHYGTPZeV4W+NaDStg==
X-Google-Smtp-Source: AGHT+IHkZepq7aTafh0HxBLIxweJZ2fHAPK+jdFkf8SwufI6M0a6JAvbgwUN7+X8k22zqLDhJWsYmWAQpZkuZbn/Dyg=
X-Received: by 2002:a05:6820:217:b0:5a4:77f2:1c9f with SMTP id
 bw23-20020a056820021700b005a477f21c9fmr15203421oob.6.1712134454221; Wed, 03
 Apr 2024 01:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-2-jens.wiklander@linaro.org> <CACRpkdZBWBio8kvKuVzj2CknCb4eS=VB2EqUsAK-vf4e328icg@mail.gmail.com>
In-Reply-To: <CACRpkdZBWBio8kvKuVzj2CknCb4eS=VB2EqUsAK-vf4e328icg@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 3 Apr 2024 10:54:03 +0200
Message-ID: <CAHUa44FWRizv39wRJ8ku2v02pDB8_J6BmSk27NrA_UHv4cqNkw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:24=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> Hi Jens,
>
> thanks for your patch!
>
> On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
>
> > A number of storage technologies support a specialised hardware
> > partition designed to be resistant to replay attacks. The underlying
> > HW protocols differ but the operations are common. The RPMB partition
> > cannot be accessed via standard block layer, but by a set of specific
> > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> > partition provides authenticated and replay protected access, hence
> > suitable as a secure storage.
> >
> > The initial aim of this patch is to provide a simple RPMB driver
> > interface which can be accessed by the optee driver to facilitate early
> > RPMB access to OP-TEE OS (secure OS) during the boot time.
> >
> > A TEE device driver can claim the RPMB interface, for example, via
> > rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> > provides a callback to route RPMB frames to the RPMB device accessible
> > via rpmb_route_frames().
> >
> > The detailed operation of implementing the access is left to the TEE
> > device driver itself.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> I would mention in the commit that the subsystem is currently
> only used with eMMC but is designed to be used also by UFS
> and NVME. Nevertheless, no big deal so:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> > +config RPMB
> > +       tristate "RPMB partition interface"
> > +       depends on MMC
>
> depends on MMC || SCSI_UFSHCD || NVME_CORE
> ?
>
> Or do we want to hold it off until we implement the backends?

Correct, I think we should hold it off until then.

Thanks,
Jens

>
> Yours,
> Linus Walleij
