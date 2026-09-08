Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990865328D3
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880129; cv=pass; b=DBDYL/p8TFJ1sAskhmLZtohCwYugCnLm/BsKVq43Q+LTAwfWOL9TqRP0NyLI7v3eZFIG9WpXUJxnN1xGHXPvjZFT0IHhWeWbhM3P5NfmrHudWXaM8ngowlK5j+hSt+OmeXi5vWVz9ziKI/wfYduIfxl/wu4cyYOF/cg7z6Shbrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880129; c=relaxed/simple;
	bh=zm+otlW1FFj9Vt6h8zL6mo89wyK3Ohm9T7x37NJyTWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfRvBXyDags4K8Hc+L8cZAHTEhrWNPGCLFIEK8ZS/Mp8mZdBSHXxiqVm4rmt9el0g5A38U+tzLIucZT56aJxfSsRBl6CCN6PP4nz7p1SanHHlIn0vUhXjfENaC/Vqrw1eOyY06AM7QENG+Pwvx3KUTIYeT22ZHj51mrGZrmd4JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmLX27Rs; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmLX27Rs"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ce98cb8165so45353135ad.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 08:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788880114; cv=none;
        d=google.com; s=arc-20260327;
        b=TqfofhteFmEz27CzipbQc8Yt/5o9R6mDBUXK05y79Lyk1tVfFsUWIDIG5S8rEw60NK
         PExHjAwM75fDa13pgtRpJ6aa6FD48j+pADYTH5cB1HEzmCvdHkcOYXbJ3VvcbH9EO/JG
         EiZsFaTZIkPZn8CrIxawsBhWmPfVWegSXJ2KTSnAMjb6SP3dmFoBrDn84HmSOITWoEB+
         6jSyO7mFfWbl9sTk7fua/kJSZ4DZLw35Mo4xV6JQ1yht9fupMnbAdCsetoHdEVt+QGr9
         kyvsVzLkEC1KIO2BzPcUGlbj8iqU4FU1qZQuQpnkgMf5hrlFZaKLasgs/m7QoZHRAwIG
         Df3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4RqcoClyyShJ1moSh55AZK570VU7X4V6q2xrfyrqaT0=;
        fh=DsOCt2neRnS8Rw31pdEey101gsZXojFmpD1NHvQj/SE=;
        b=EtSnIp3nANPb9KLW5/sI168xdYW3SXsawITq9GwyWSpQ6FRIIS++4wG97r7GblAzd5
         CGvc0d466S1i4lLbJe2dLd7/x0diTkA4/sSeAFTmoUQjzL5cksMio5NQnQPpfFjs3CuB
         X191LRN3ovqcZJWF74LRyeUQdQ1S/JQ5uDI836yn5v/nU+137/cIRg6YXYYfVe6LLrj/
         MsjBCbCE/QDNLT2rSQMIYDwwWuA4q66ULzAeN7APWPEalq2LszOttONCPpS9yiEhvxNa
         9KKmuzgZ8TfHUVRVdnIYsKd3hMesA3qiKYcWMSE8OUuOzuXUtZCCxTWIOzc6dVB2ZZ4g
         DyOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788880114; x=1789484914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4RqcoClyyShJ1moSh55AZK570VU7X4V6q2xrfyrqaT0=;
        b=EmLX27RsQuVZHfYde3CcE/hmKuWG0G1Lo0IR7hrAO4m+U48s6vJem0UEpc/6lh3gec
         f2MvkxsVcV2CU0O3OgUDmvH2MUYtLQ0Iue+iXauiRZeDrdnT1rEd5tOUU00PpBRbAAs1
         ojDTSK64grKRo4FgLwvuvWVfT4gHXG22GWg1mU4PpcQiyYn2P6nPglV+FF+0Tu7U2fAp
         jdjFCDX1IYB62ApDFCr5CLx+0mdepcnWMf32dL7sWHUUpcd4J/GGQUp3W1kg/bq9wVOj
         9kIyF6IVXOAfKRQw0Lmxjc9vcKZ44Gyt0qaho8hPSD+LYF+s9qLYLH2HiktMBqtl/7lK
         A/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788880114; x=1789484914;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4RqcoClyyShJ1moSh55AZK570VU7X4V6q2xrfyrqaT0=;
        b=D1/57xtEwSSpwjFxzdMIavjx46Qnfse4o2CkiiEkIplRKS2rR0Wt2geCCq5FGqGSX/
         21p2gr0NpRiICV1Q1ZouNdsNdAmxtq0kD/FWM3IS/nGVFgpi6P62mbbewFS2G6Ck5mgG
         VwKteCU21jM0VtLMs8wAKOfwRQMJTB4xlXL+TPE17ZEW7ttWXhlrcz23uFEehcvVAAse
         b2BuSGBuKki4z4WyAMZD1UndHK9TumjyEVHUWNCGFybqaBXh4RwKNIBgTc9WGhcFQmLA
         9/98tc/D6IvQaV6r/G6ZgJYfitw51R4KEVnKdWNA3T2KTvlNbzOPD+8vC4g4dSp0/YC5
         wfBw==
X-Forwarded-Encrypted: i=1; AKwUvBwQTik0Md2xyEXpGoXeYxb78deADEEEYaikqHr9Hz+02Yv4kawDgMLlxozKAXEepy3354TKoiBoFxM=@vger.kernel.org
X-Gm-Message-State: AFuF++kbx7V+XE0LlqxkHeo/oEoxHxW+uDDaVZPBnt+eRjKTTA1Ll1DH
	9gjAt0VTLt8WSBTCUIkuzKDDs5f/aJ/Ff2sGWCZPDMhfEixLLHGc8p3UfkcBePDeKhPInO6FXtz
	9ZYBcESP5Lry1lvoKblaFY7xj/98L0Vs=
X-Gm-Gg: AYBFou2+2IdMpdr0LfeiCz9tdGEKTdLpK5EGLRAs0dy4y+YgeB1SnORE/urabMMR9xr
	1jzUUAhi4e+IKEt/YypgRPlxE+xcZhzFEr0uj0Wemh9N1ufcqGqde8q3UNt7M6epHAbc9hJxU46
	+GoqNOoZS4Iylrnbs4PKmnyy+tqVAREZa+oeA/MT47QbhKKhHV82+RSM4LqVSSZvwLoQ3FPMDgE
	C3qcHo98q+Wz44Ucv7lIrMgPtQVVqLlfJuav6zd98IuZLybDoc/aCHeEW2ab4rAnLaeqVLlI9l+
	Yhv8C26p5SeCAnpcZgN6h8AkwIt+gCvCl5TdaVjVPv0Fhw==
X-Received: by 2002:a17:902:da85:b0:2bd:2c3a:2a36 with SMTP id
 d9443c01a7336-2dafad14a8fmr324298895ad.0.1788880114088; Tue, 08 Sep 2026
 08:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907151428.643841-1-adrianox@gmail.com> <ap-4khETBju3X8-T@hovoldconsulting.com>
 <CAMGU2hXrURUh3NknkgLnmyiJiEwEqZdDz3Ujy5tO8oqVMD9OJw@mail.gmail.com> <aqAS_dB3_whEBd0O@hovoldconsulting.com>
In-Reply-To: <aqAS_dB3_whEBd0O@hovoldconsulting.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Tue, 8 Sep 2026 12:08:21 -0300
X-Gm-Features: AcwNN1Vku8W4cTMTepsVNM_3gykDeF4LzmE6ljoRCXSEjHLk9ryccwjKMMcpvEk
Message-ID: <CAMGU2hVkozBySFXKuQ0yvSbAUnuX4KEsu1ucNrY349yxe6xKww@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: fix use-after-free in vub300 teardown
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 8 sept 2026 a las 10:52, Johan Hovold (<johan@kernel.org>) escribi=
=C3=B3:
>
> On Tue, Sep 08, 2026 at 10:28:06AM -0300, Adriano C=C3=B3rdova wrote:
> > El mar, 8 sept 2026 a las 4:26, Johan Hovold (<johan@kernel.org>) escri=
bi=C3=B3:
> > >
> > > On Mon, Sep 07, 2026 at 12:14:28PM -0300, Adriano Cordova wrote:
> > > > Do not dereference mmc/vub300/udev after the final kref_put, becaus=
e
> > > > it can release them via mmc_free_host()/usb_put_dev().
> > > >
> > > > Fixes: 8f4d20a71022 ("mmc: vub300: fix use-after-free on disconnect=
")
> > >
> > > This commit reverted a buggy change so if anything is broken here, th=
is
> > > isn't the commit to blame.
> > >
> > > > Reported-by: syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com
> > > > Link: https://syzkaller.appspot.com/bug?extid=3Df312381a95cc080992f=
d
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > >
> > > Are you missing an Assisted-by tag?
>
> Again, are you using an LLM without disclosing it?
>

Yes, I will add the tag in the v2.

> > > > ---
> > > >  drivers/mmc/host/vub300.c | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> > > > index 2dae474dcd06..a1a6aa1aafdb 100644
> > > > --- a/drivers/mmc/host/vub300.c
> > > > +++ b/drivers/mmc/host/vub300.c
> > > > @@ -370,13 +370,14 @@ static void vub300_delete(struct kref *kref)
> > > >  {                            /* kref callback - softirq */
> > > >       struct vub300_mmc_host *vub300 =3D kref_to_vub300_mmc_host(kr=
ef);
> > > >       struct mmc_host *mmc =3D vub300->mmc;
> > > > +     struct usb_device *udev =3D vub300->udev;
> > > >
> > > >       usb_free_urb(vub300->command_out_urb);
> > > >       vub300->command_out_urb =3D NULL;
> > > >       usb_free_urb(vub300->command_res_urb);
> > > >       vub300->command_res_urb =3D NULL;
> > > > -     usb_put_dev(vub300->udev);
> > > >       mmc_free_host(mmc);
> > > > +     usb_put_dev(udev);
> > >
> > > This makes no sense at all as the driver data is freed by
> > > mmc_free_host().
> >
> > mmc_free_host() only frees mmc (struct mmc_host) and vub300
> > (struct vub300_mmc_host), but the udev (struct usb_device, linked
> > as mmc->parent) is not freed by mmc_free_host() and has to be
> > freed separately.
> >
> > But it cannot be freed before mmc_free_host(), because the kobject
> > cleanup code of mmc_host accesses it in mmc_host_classdev_release()
> > via host->parent->of_node.
>
> That's a bug in MMC core. It needs to hold a reference to the parent, or
> just store the id directly.

I understand, you are right. I will send a v2

>
> And your LLM didn't put any of this in the commit message.
>
> > > >       /*
> > > >        * and hence also frees vub300
> > > >        * which is contained at the end of struct mmc
> > > > @@ -1794,8 +1795,8 @@ static void vub300_cmndwork_thread(struct wor=
k_struct *work)
> > > >                       construct_request_response(vub300, cmd);
> > > >                       vub300->resp_len =3D 0;
> > > >                       mutex_unlock(&vub300->cmd_mutex);
> > > > -                     kref_put(&vub300->kref, vub300_delete);
> > > >                       mmc_request_done(vub300->mmc, req);
> > > > +                     kref_put(&vub300->kref, vub300_delete);
> > >
> > > This order has been here since the driver was merged.
> > >
> > > >                       return;
> > > >               }
> > > >       }
> > > > @@ -1946,8 +1947,8 @@ static void vub300_mmc_request(struct mmc_hos=
t *mmc, struct mmc_request *req)
> > > >                   satisfy_request_from_offloaded_data(vub300, cmd))=
 {
> > > >                       cmd->error =3D 0;
> > > >                       mutex_unlock(&vub300->cmd_mutex);
> > > > -                     kref_put(&vub300->kref, vub300_delete);
> > > >                       mmc_request_done(mmc, req);
> > > > +                     kref_put(&vub300->kref, vub300_delete);
> > >
> > > Same here.
> > >
> > > So if this is wrong (it does look suspicious, but this driver is just=
 a
> > > mess) then that's the commit to blame.
> >
> > Hope is more clear now, it makes sense to me, and I think the Fixes:
> > tag is right.
>
> No, these issues were there since the driver was merged, that is, they
> were introduced by commit 88095e7b473a ("mmc: Add new VUB300
> USB-to-SD/SDIO/MMC driver") in 2011. (And the of_node issue was
> introduced in 2021.)
>
> The broken devres change may or may not have masked them for a bit, but
> the revert is not the culprit here.
>
> > >
> > > >                       return;
> > > >               } else {
> > > >                       vub300->cmd =3D cmd;
>
> Johan

Adriano
