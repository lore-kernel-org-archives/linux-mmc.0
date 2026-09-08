Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515B8551987
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874114; cv=pass; b=XfVSexkJsuy06NBq85gW0XGxECv/P0voyZurNv/7xFVZ9QqQBVi8dFZR838aSBNZcaVbrpZPUKPp7KNNdI1lht4YUQP6M6JayW91stdeky9ymaoo2CiLlLF+MKv+ydEwDcHewEAIZm8J3XIHJ3PIUn0N4Ma3wbi1UGp7+sFCC/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874114; c=relaxed/simple;
	bh=XrWPQdu6aVkIEftfYKLA9OZgTitSQ0N+EPeHqgtL9RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dgx3nq2+FRkTvmplJZ31R9uSeOpH7zT1EO3IH1ATZDz260euKIShl6fSnTCBHhePbIAfOjLyzC636jTFTatWVlnerfm5OxyKkR3cfDncdYJZGTm2Y8zfSZh8vze5xybdhvcW3uS9QACn+z0Mai3+XKx/+yzJaILSIg9qeV97O+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDzKyIQe; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDzKyIQe"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8625b35df89so90031b3a.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 06:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788874098; cv=none;
        d=google.com; s=arc-20260327;
        b=iTP0dHk2X1zSk5HAcMvYIvn2xuBNsM/jhsZU8YPQeT+HvZtoO1wxu14T+jynoLSP0j
         kncp0mRtx3QbXfO0FQmx6PKZ7jqdh6rrlCnxMMKY06LfFkLAo9x99F15PJ0IxwiXKwwZ
         Hryof0/v8SP+Uy5EZV2xxq55MuikjxO3kERw6rWS8XZqu1SDTZHVudIJ6hPI2oxBvwNU
         FENLog11ZAu0xIKTa82PmgQOO6ugFGzq68t8Xoa7xs4AoLEi00b0nZrOZGAbL6fmTAud
         ezrzNUy+5lAc1nlYlkmtOzBaPHzpqEPpJaCTMlPo9DVgD2GzGDNVE7pbtVhubFoTAJs1
         NcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JKqux52iVKTfYQy6cAyWyQ3ntl+32JLmlvNYP6anbHY=;
        fh=/Qi6Q9OQe16Lw+ETU96MGFwKeOKm86rZT9hmojGdYos=;
        b=Xv3P2fwx2ZATkCL0yIp6f3Q/JRkREEMpBMgzqnJqhkcA7mCFvcITDXOsyB6x+lBN4/
         ZJqsfnu7BdaV32c6sU3oKwij1yfe5Y0zt4njMPmYepXEDp22qcKrOZU7AAwEwV1RSpjb
         mwGy7BQf9y1J1h/MiQKrFSBsEVofWrmDRoIO2uQ/X+ouKnRb4a98UzQJWl7W3bJ7CZOH
         DG1TySieQ4LYTE85pNleVqANalE54kwc9HhTTTmIwfBDb3hvhTx3pAUo+oVdYVCnT0ZY
         FvYuSvmBQ5OBPgKm3ahA/mA8mlS32th8xB9OYK4tQSa9WfBYpSe8miSrlj3tcGfeTVwY
         gT0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788874098; x=1789478898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JKqux52iVKTfYQy6cAyWyQ3ntl+32JLmlvNYP6anbHY=;
        b=GDzKyIQe6gkTpY6dg7Tc7eMqvtKCONPfezqQzQ5kSDS69CAoCuxI+JOe9Ujb/wFLW4
         NNv+wf/qu5jdSqGH7GT5mO72kF2aRTO2AuMqtrXHH7wlTZ4+aSuFaIJWNgQUXuAMYx7L
         UOXdcc7cxtrl+qMW51cYjvQYfA/iqjn8lj81IVJQxRjJq1gfEBFvoqh+lJXly7YKFn31
         tKPwVvmvAVxONDj/w2fFNezBOlbgpMWRrSC6k0kPaKxjvM9ePRZMOPaXiM8t3LZzy41R
         //xbVtYL4P+kxfcx0gk3zPTtdLqVTnyxH1f72xn30RhM3jKP1qExiEcevXkcF6slhrMp
         xLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788874098; x=1789478898;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JKqux52iVKTfYQy6cAyWyQ3ntl+32JLmlvNYP6anbHY=;
        b=ePpTYqhfjy+vMTfHDycMQevxPkNdHoddf//XB7chdTd34CEv2OpGHxI8frJlc8KHNn
         l+d94dl/YttwRpXefbt60Kei8HJPatYHI3wXHEQ3GxCN8x/8261hB/mX3MC9Z5JTQldI
         tQtxBMrd7p3ooYR+2NdMXGOHXoNLQMb4E7mazy00v1ZVpuOB+Hy1NRWcVYDmCH0fpPdR
         y6B3IeXQDryegZUKUHKiJgvux6GEEo+bDsLSsvBi0yKT1bqZmTs4dGVA2SOCW8Bp2Vqc
         RIU8l52aFgYqI+ESY5k+4Bu9NI9+ZaLTeS+s1inn9Q4LSH2/YnVwUa40djbXEIwQbP1e
         M4TQ==
X-Forwarded-Encrypted: i=1; AKwUvBw0XyNmRMpGjOV3bsxlUIgIgtJV6N7RX137rPpegdaXmhlW2/uVUWV6viV1Mi/RnIvmYSUXw18CZdI=@vger.kernel.org
X-Gm-Message-State: AFuF++nPH1fHRKvMmwx/8az8FV9z9YDIe4ctWISQzU+EwAkNvYbawJsA
	CQfVVx8j2yhfLBbG/X5KVjCMNhWoAWrwJjdJ6Mo2vrY2y24DRxA/HqNhgTVbLmZfmM0HC68b24Y
	TTcgJvgNvnnxDS8VKvu7lX96xl9tOW2o=
X-Gm-Gg: AYBFou27P+KZ0o/siOuZAx3u+eg6z+gVxnckXl5Pipv6VAzfFqbUoTPtAUmf4XpD/sY
	udrRogaxHEdstNIhOxxMkO5e1uZftlPg05Tt8KVjIuSI/oFdadzg3kkuGdU+o1Wb+1i/SoZS/VI
	+bHkA8VUjSJnLDNGNq++UcWzRTQKrz65wIbnRXc5OJflLy0iWv61phqv+uXH0rz3VBb1aKwiIjc
	AF0wfhEzBxtqJfSdKIquYzHqmxIAaVZ9B0iaHYqS6xkY0Ru0PF4TVd7wLokP2hVDGlBor1/5Vj7
	vUVdRIUzy9qvMUtR0QeppBziWX/9ERzxyXzQUof3gOk0brvUVEI6kWh0
X-Received: by 2002:a05:6a00:1395:b0:84e:cd14:aeba with SMTP id
 d2e1a72fcca58-86698fe1ea8mr6346255b3a.6.1788874097889; Tue, 08 Sep 2026
 06:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907151428.643841-1-adrianox@gmail.com> <ap-4khETBju3X8-T@hovoldconsulting.com>
In-Reply-To: <ap-4khETBju3X8-T@hovoldconsulting.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Tue, 8 Sep 2026 10:28:06 -0300
X-Gm-Features: AcwNN1UwNNi1uUL8ZrK4YlYg6vVWK6_rZXfk738aK_31iCexOOmSxAgWI8zqjXg
Message-ID: <CAMGU2hXrURUh3NknkgLnmyiJiEwEqZdDz3Ujy5tO8oqVMD9OJw@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: fix use-after-free in vub300 teardown
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 8 sept 2026 a las 4:26, Johan Hovold (<johan@kernel.org>) escribi=
=C3=B3:
>
> On Mon, Sep 07, 2026 at 12:14:28PM -0300, Adriano Cordova wrote:
> > Do not dereference mmc/vub300/udev after the final kref_put, because
> > it can release them via mmc_free_host()/usb_put_dev().
> >
> > Fixes: 8f4d20a71022 ("mmc: vub300: fix use-after-free on disconnect")
>
> This commit reverted a buggy change so if anything is broken here, this
> isn't the commit to blame.
>
> > Reported-by: syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?extid=3Df312381a95cc080992fd
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
>
> Are you missing an Assisted-by tag?
>
> > ---
> >  drivers/mmc/host/vub300.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> > index 2dae474dcd06..a1a6aa1aafdb 100644
> > --- a/drivers/mmc/host/vub300.c
> > +++ b/drivers/mmc/host/vub300.c
> > @@ -370,13 +370,14 @@ static void vub300_delete(struct kref *kref)
> >  {                            /* kref callback - softirq */
> >       struct vub300_mmc_host *vub300 =3D kref_to_vub300_mmc_host(kref);
> >       struct mmc_host *mmc =3D vub300->mmc;
> > +     struct usb_device *udev =3D vub300->udev;
> >
> >       usb_free_urb(vub300->command_out_urb);
> >       vub300->command_out_urb =3D NULL;
> >       usb_free_urb(vub300->command_res_urb);
> >       vub300->command_res_urb =3D NULL;
> > -     usb_put_dev(vub300->udev);
> >       mmc_free_host(mmc);
> > +     usb_put_dev(udev);
>
> This makes no sense at all as the driver data is freed by
> mmc_free_host().

mmc_free_host() only frees mmc (struct mmc_host) and vub300
(struct vub300_mmc_host), but the udev (struct usb_device, linked
as mmc->parent) is not freed by mmc_free_host() and has to be
freed separately.

But it cannot be freed before mmc_free_host(), because the kobject
cleanup code of mmc_host accesses it in mmc_host_classdev_release()
via host->parent->of_node.

>
> >       /*
> >        * and hence also frees vub300
> >        * which is contained at the end of struct mmc
> > @@ -1794,8 +1795,8 @@ static void vub300_cmndwork_thread(struct work_st=
ruct *work)
> >                       construct_request_response(vub300, cmd);
> >                       vub300->resp_len =3D 0;
> >                       mutex_unlock(&vub300->cmd_mutex);
> > -                     kref_put(&vub300->kref, vub300_delete);
> >                       mmc_request_done(vub300->mmc, req);
> > +                     kref_put(&vub300->kref, vub300_delete);
>
> This order has been here since the driver was merged.
>
> >                       return;
> >               }
> >       }
> > @@ -1946,8 +1947,8 @@ static void vub300_mmc_request(struct mmc_host *m=
mc, struct mmc_request *req)
> >                   satisfy_request_from_offloaded_data(vub300, cmd)) {
> >                       cmd->error =3D 0;
> >                       mutex_unlock(&vub300->cmd_mutex);
> > -                     kref_put(&vub300->kref, vub300_delete);
> >                       mmc_request_done(mmc, req);
> > +                     kref_put(&vub300->kref, vub300_delete);
>
> Same here.
>
> So if this is wrong (it does look suspicious, but this driver is just a
> mess) then that's the commit to blame.

Hope is more clear now, it makes sense to me, and I think the Fixes:
tag is right.

>
> >                       return;
> >               } else {
> >                       vub300->cmd =3D cmd;
>
> Johan

Best,
Adriano
