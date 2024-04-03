Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476D8146A7E
	for <linux-mmc@vger.kernel.org>; Wed,  3 Apr 2024 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149128; cv=none; b=IXOMOt7ofRjqqMmOT+ktHQTRXRfNStKV02VuV8stMfDa+HkGFKSIG6ZryPyimWEodPw6LQXF/71kkxe7pJhuSsc0o9MtMgGJRvKtmraw3t4epH5t46uuofaIW92MMJsxzBX+ggQHMtTj9tNg9xtX6qFdr6uLDTE/8Rx1FGX0aQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149128; c=relaxed/simple;
	bh=OsoqVk51WrhmAN1JSaWdIu3pG6JoBIal7hDnV9i4/MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWdmNnJ/v/ZuvGf9Sl+p7m0wFyrwkjGVrJixpE732BgH4WGQdMU0Zww78LcS3JLBRFmRSmxk/3iS6VaE4ENU7ep1a73JBOoL83uZ0vAcBR+wO+GCDadVHeRZYkldRr14Bu7rDtuA3cfavb3BCf3dc1PmBTPtkZSmZwn75YJNKQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cdvjg6O5; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdvjg6O5"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-479ba1de2d0so82952137.3
        for <linux-mmc@vger.kernel.org>; Wed, 03 Apr 2024 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712149125; x=1712753925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vXe3H9k36Byv0xoqVxTSndFLXyxkCsLhAfCpstPyJE=;
        b=cdvjg6O5TWz4/X1wQpp3GHKbh+hlnOe0nsUXru6foiD8olBk4sba4oHh7GPIVemGSp
         wECFBA0UzJSFTuhXvCkXiGEcQSLkpdDA4F0Apocic1QGFDN6VuIt+TYRU29gy3gfxAY7
         7NIYxB+tM7OaZEDTBc+afPG6nVh7wHMB7aQxMPT8d98xuGqZaRZ0NeaGqKs7kppFH2Xf
         mcU8hgXRq+QiLz5zhd87NrsciGu0jAMyakCGuo+JrbFpTWJ9KwSOYCjt96xyK/xlY9gt
         Bk9EiCGqrA0fAx0VlQEKHVJ9GxjUYHZ8xMr5h1FGEO6OpL79OwBRteXdl2LcsVw5oik7
         Xi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712149125; x=1712753925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vXe3H9k36Byv0xoqVxTSndFLXyxkCsLhAfCpstPyJE=;
        b=gt6zWStIkziuIeE7vxMhAP7i5TpW4dvW5zeDCmo3+C/wrbnmP0ncihMWHkAiQYPxtn
         8JG0u+sxyrqN7NqsIQUDw0MRppzdiHNYcH8VBMjPJOZ2wgraBuPPFyHgGV4dD1A52pG2
         u830/aUkya/CsV1sbU+WjGHEEoLc5n5Ho+b3zeq+pD7izU4vwd12qjPhdWIbyg69eszS
         3PL7UVrSlSv4FyDUBKkIjitQF0oB8mYHi5cYlVSdBmIGxWD7QG03ISUfJ/Rt7uuPmpqQ
         y5vx1l1qdNVjuZcg4GtIy2O8vAU/RvaJiRuGWlziJCyBB7da0ODtc23L7vuQ+nXDY3UN
         YDMA==
X-Forwarded-Encrypted: i=1; AJvYcCX4W4nhkK870Qe3FfbVsR6tVrX3VG9Gfce2RUbkkK35lBF2eGI4R5vfp8fvPnhKfC3jntWmjXlkAAOP/qdBSpTBf3vDXCckjgyF
X-Gm-Message-State: AOJu0Ywhfai78P1Gr8tp1pBmZaop5iNxHo0doQHp0fOIRzu+oZTKUoiW
	i8V/IociAOBbniysA+Sx6NjQWnhSjK7DLTWM4vofR10QEZdOCnNONPHxO9wM44kzjXPYGEPsPHr
	2zAZXEaPlL2X2XF8tm3a+ftC89FklMMLtytBEO+Vh/Ks22+SXmfs=
X-Google-Smtp-Source: AGHT+IEDwKdHKghmOlrl6izEm+5no7UIuITz7RN2aASE/V6bEenGrlKVssuMKrdKj6pgzJL1v0fOJF7tTfmc2LsBDXI=
X-Received: by 2002:a05:6102:d8c:b0:478:3f57:966d with SMTP id
 d12-20020a0561020d8c00b004783f57966dmr13777300vst.26.1712149125169; Wed, 03
 Apr 2024 05:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-4-jens.wiklander@linaro.org> <CAFA6WYOZQwo1qJWXV+W9t6ZChkWJwzg_0mtAJ2K+viHRdvH2ig@mail.gmail.com>
 <CAHUa44H0sV5yYD6b8vb3b=GvFokxC9xgjFFVkj4Dk0YAVm=X7Q@mail.gmail.com>
In-Reply-To: <CAHUa44H0sV5yYD6b8vb3b=GvFokxC9xgjFFVkj4Dk0YAVm=X7Q@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 3 Apr 2024 18:28:34 +0530
Message-ID: <CAFA6WYOhFLh7k0XQnA22-92DmuCVqEvfpTSa5kdAqO_hNTztaw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] optee: probe RPMB device using RPMB subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Mar 2024 at 21:39, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Fri, Mar 1, 2024 at 11:28=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > Hi Jens,
> >
> > On Tue, 27 Feb 2024 at 21:01, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe =
and
> > > use an RPMB device via the RPBM subsystem instead of passing the RPMB
> >
> > s/RPBM/RPMB/
> >
> > Here are other places too in this patch-set.
> >
> > > frames via tee-supplicant in user space. A fallback mechanism is kept=
 to
> > > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > > available.
> > >
> > > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > > devices until one is found with the expected RPMB key already
> > > programmed.
> >
> > I would appreciate it if you could add a link to OP-TEE OS changes in
> > the cover-letter although I have found them here [1].
> >
> > [1] https://github.com/jenswi-linaro/optee_os/commits/rpmb_probe/
>
> OK, I'll add a link in the coverletter of the next patch set.
>
> >
> > >
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  drivers/tee/optee/core.c          |  55 +++++++
> > >  drivers/tee/optee/ffa_abi.c       |   7 +
> > >  drivers/tee/optee/optee_private.h |  16 ++
> > >  drivers/tee/optee/optee_rpc_cmd.h |  35 +++++
> > >  drivers/tee/optee/rpc.c           | 233 ++++++++++++++++++++++++++++=
++
> > >  drivers/tee/optee/smc_abi.c       |   6 +
> > >  6 files changed, 352 insertions(+)
> > >
> > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > index 3aed554bc8d8..6b32d3e7865b 100644
> > > --- a/drivers/tee/optee/core.c
> > > +++ b/drivers/tee/optee/core.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/io.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/module.h>
> > > +#include <linux/rpmb.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/string.h>
> > >  #include <linux/tee_drv.h>
> > > @@ -80,6 +81,57 @@ void optee_pool_op_free_helper(struct tee_shm_pool=
 *pool, struct tee_shm *shm,
> > >         shm->pages =3D NULL;
> > >  }
> > >
> > > +static void optee_rpmb_scan(struct work_struct *work)
> > > +{
> > > +       struct optee *optee =3D container_of(work, struct optee, scan=
_rpmb_work);
> > > +       bool scan_done =3D false;
> > > +       u32 res;
> > > +
> > > +       do {
> > > +               mutex_lock(&optee->rpmb_dev_mutex);
> > > +               /* No need to rescan if we haven't started scanning y=
et */
> > > +               optee->rpmb_dev_request_rescan =3D false;
> > > +               mutex_unlock(&optee->rpmb_dev_mutex);
> > > +
> > > +               res =3D optee_enumerate_devices(PTA_CMD_GET_DEVICES_R=
PMB);
> > > +               if (res && res !=3D TEE_ERROR_STORAGE_NOT_AVAILABLE)
> >
> > I suppose this hasn't been tested for a negative case since
> > optee_enumerate_devices() won't return this error code (see [2]).
> > However, I would prefer to use GP Client error code:
> > TEEC_ERROR_ITEM_NOT_FOUND here instead.
> >
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/tee/optee/device.c#n43
>
> I prefer TEE_ERROR_STORAGE_NOT_AVAILABLE since that's the code GP says
> a TA should get when storage is unavailable.
> TEEC_ERROR_ITEM_NOT_FOUND is less specific. Anyway, I'll need to
> translate the code in get_devices().

Okay, that's fair.

>
>
> >
> > > +                       pr_info("Scanning for RPMB device: res %#x\n"=
, res);
> > > +
> > > +               mutex_lock(&optee->rpmb_dev_mutex);
> > > +               /*
> > > +                * If another RPMB device came online while scanning,=
 scan one
> > > +                * more time, unless we have already found an RPBM de=
vice.
> > > +                */
> > > +               scan_done =3D (optee->rpmb_dev ||
> >
> > I suppose we don't need to check for optee->rpmb_dev here since a
> > successful return from
> > optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB) would ensure that
> > the RPMB device has been found.
>
> That makes sense, I'll check the return value instead.
>
> >
> > > +                            !optee->rpmb_dev_request_rescan);
> > > +               optee->rpmb_dev_request_rescan =3D false;
> > > +               optee->rpmb_dev_scan_in_progress =3D !scan_done;
> > > +               mutex_unlock(&optee->rpmb_dev_mutex);
> > > +       } while (!scan_done);
> > > +}
> > > +
> > > +void optee_rpmb_intf_add_rdev(struct rpmb_interface *intf,
> > > +                             struct rpmb_dev *rdev)
> > > +{
> > > +       struct optee *optee =3D container_of(intf, struct optee, rpmb=
_intf);
> > > +       bool queue_work =3D true;
> > > +
> > > +       mutex_lock(&optee->rpmb_dev_mutex);
> > > +       if (optee->rpmb_dev || optee->rpmb_dev_scan_in_progress) {
> >
> > Can we use work_pending() instead of our custom
> > optee->rpmb_dev_scan_in_progress flag?
>
> That seems racy, or am I missing something?
>

You are right and even work_busy() is documented to provide unreliable
results. So I am rather thinking about just queuing the work and
thereby scanning for devices unconditionally. I suppose the extra
logic to check if we don't try to register duplicate devices can go
under optee_enumerate_devices().

> >
> > > +               queue_work =3D false;
> > > +               if (optee->rpmb_dev_scan_in_progress)
> > > +                       optee->rpmb_dev_request_rescan =3D true;
> > > +       }
> > > +       if (queue_work)
> > > +               optee->rpmb_dev_scan_in_progress =3D true;
> > > +       mutex_unlock(&optee->rpmb_dev_mutex);
> > > +
> > > +       if (queue_work) {
> > > +               INIT_WORK(&optee->scan_rpmb_work, optee_rpmb_scan);
> > > +               schedule_work(&optee->scan_rpmb_work);
> >
> > Can we reuse optee->scan_bus_work rather than introducing a new one her=
e?
>
> No, both may be active at the same time.

Actually both of them are using system_wq underneath, so it shouldn't
be a problem if both are active at the same time as they can be queued
simultaneously, right?

> We'd have to merge
> optee_rpmb_scan() and optee_bus_scan(), but I'm not sure it's worth
> it.
>
> >
> > > +       }
> > > +}
> > > +
> > >  static void optee_bus_scan(struct work_struct *work)
> > >  {
> > >         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> > > @@ -161,6 +213,7 @@ void optee_release_supp(struct tee_context *ctx)
> > >
> > >  void optee_remove_common(struct optee *optee)
> > >  {
> > > +       rpmb_interface_unregister(&optee->rpmb_intf);
> > >         /* Unregister OP-TEE specific client devices on TEE bus */
> > >         optee_unregister_devices();
> > >
> > > @@ -177,6 +230,8 @@ void optee_remove_common(struct optee *optee)
> > >         tee_shm_pool_free(optee->pool);
> > >         optee_supp_uninit(&optee->supp);
> > >         mutex_destroy(&optee->call_queue.mutex);
> > > +       rpmb_dev_put(optee->rpmb_dev);
> > > +       mutex_destroy(&optee->rpmb_dev_mutex);
> > >  }
> > >
> > >  static int smc_abi_rc;
> > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.=
c
> > > index ecb5eb079408..befe19ecc30a 100644
> > > --- a/drivers/tee/optee/ffa_abi.c
> > > +++ b/drivers/tee/optee/ffa_abi.c
> > > @@ -7,6 +7,7 @@
> > >
> > >  #include <linux/arm_ffa.h>
> > >  #include <linux/errno.h>
> > > +#include <linux/rpmb.h>
> > >  #include <linux/scatterlist.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/slab.h>
> > > @@ -934,6 +935,7 @@ static int optee_ffa_probe(struct ffa_device *ffa=
_dev)
> > >         optee_cq_init(&optee->call_queue, 0);
> > >         optee_supp_init(&optee->supp);
> > >         optee_shm_arg_cache_init(optee, arg_cache_flags);
> > > +       mutex_init(&optee->rpmb_dev_mutex);
> > >         ffa_dev_set_drvdata(ffa_dev, optee);
> > >         ctx =3D teedev_open(optee->teedev);
> > >         if (IS_ERR(ctx)) {
> > > @@ -955,6 +957,8 @@ static int optee_ffa_probe(struct ffa_device *ffa=
_dev)
> > >         if (rc)
> > >                 goto err_unregister_devices;
> > >
> > > +       optee->rpmb_intf.add_rdev =3D optee_rpmb_intf_add_rdev;
> > > +       rpmb_interface_register(&optee->rpmb_intf);
> > >         pr_info("initialized driver\n");
> > >         return 0;
> > >
> > > @@ -968,6 +972,9 @@ static int optee_ffa_probe(struct ffa_device *ffa=
_dev)
> > >         teedev_close_context(ctx);
> > >  err_rhashtable_free:
> > >         rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_f=
n, NULL);
> > > +       rpmb_dev_put(optee->rpmb_dev);
> > > +       mutex_destroy(&optee->rpmb_dev_mutex);
> > > +       rpmb_interface_unregister(&optee->rpmb_intf);
> > >         optee_supp_uninit(&optee->supp);
> > >         mutex_destroy(&optee->call_queue.mutex);
> > >         mutex_destroy(&optee->ffa.mutex);
> > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/op=
tee_private.h
> > > index 7a5243c78b55..1e4c33baef43 100644
> > > --- a/drivers/tee/optee/optee_private.h
> > > +++ b/drivers/tee/optee/optee_private.h
> > > @@ -8,6 +8,7 @@
> > >
> > >  #include <linux/arm-smccc.h>
> > >  #include <linux/rhashtable.h>
> > > +#include <linux/rpmb.h>
> > >  #include <linux/semaphore.h>
> > >  #include <linux/tee_drv.h>
> > >  #include <linux/types.h>
> > > @@ -20,11 +21,13 @@
> > >  /* Some Global Platform error codes used in this driver */
> > >  #define TEEC_SUCCESS                   0x00000000
> > >  #define TEEC_ERROR_BAD_PARAMETERS      0xFFFF0006
> > > +#define TEEC_ERROR_ITEM_NOT_FOUND      0xFFFF0008
> > >  #define TEEC_ERROR_NOT_SUPPORTED       0xFFFF000A
> > >  #define TEEC_ERROR_COMMUNICATION       0xFFFF000E
> > >  #define TEEC_ERROR_OUT_OF_MEMORY       0xFFFF000C
> > >  #define TEEC_ERROR_BUSY                        0xFFFF000D
> > >  #define TEEC_ERROR_SHORT_BUFFER                0xFFFF0010
> > > +#define TEE_ERROR_STORAGE_NOT_AVAILABLE 0xF0100003
> > >
> > >  #define TEEC_ORIGIN_COMMS              0x00000002
> > >
> > > @@ -197,6 +200,8 @@ struct optee_ops {
> > >   * @notif:             notification synchronization struct
> > >   * @supp:              supplicant synchronization struct for RPC to =
supplicant
> > >   * @pool:              shared memory pool
> > > + * @mutex:             mutex protecting @rpmb_dev
> > > + * @rpmb_dev:          current RPMB device or NULL
> > >   * @rpc_param_count:   If > 0 number of RPC parameters to make room =
for
> > >   * @scan_bus_done      flag if device registation was already done.
> > >   * @scan_bus_work      workq to scan optee bus and register optee dr=
ivers
> > > @@ -215,9 +220,17 @@ struct optee {
> > >         struct optee_notif notif;
> > >         struct optee_supp supp;
> > >         struct tee_shm_pool *pool;
> > > +       /* Protects rpmb_dev pointer and rpmb_dev_* */
> > > +       struct mutex rpmb_dev_mutex;
> >
> > Given my comments above, do we really need this mutex?
>
> I don't see how we can do without the mutex.

See if it is possible with the above mentioned approach.

-Sumit
