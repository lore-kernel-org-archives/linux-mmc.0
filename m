Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2F107A6
	for <linux-mmc@vger.kernel.org>; Mon,  6 May 2024 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984507; cv=none; b=r0SY3Teo5r3RHpBITnDHZSyXibPIAF6glVmYS1Sy/BXGiP6aRgHB7kYZkZUDeq1LosUcQOmgZLGt4bNRGORDpmHWqS+CsAIMmxkqL7Xz/L8UkTfafNDj1m3wnhmXUyKt9KWzI9U3m5E7Rfnws8ledcqX/AEHqdVrFbLf78nfsI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984507; c=relaxed/simple;
	bh=/RI0n8YBStPO4GWaYlWI5GP6zx5TFLri7qBGlJPHRdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9BHXF7dq7/cmuvVXYHivd+Q3ox7pERG5Quq/+XLnAE29CbRQ9ULKC0C5g80hdaZWwatSz7EgrVCRWwTAzpLDeKM5gJaWRpAc1bKTsifgFq71d0MQ4mM816mv737X7eV/nSMhTHfI9DLQMwybfZlHKKxzyXRJ+EvXDahNa7H5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bd+guOFP; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bd+guOFP"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f055c08220so430621a34.0
        for <linux-mmc@vger.kernel.org>; Mon, 06 May 2024 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714984504; x=1715589304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cl82or32+HMklYE2/qW0027vhWN+f6Mtpy9tX8JqrLM=;
        b=bd+guOFPcD2Ka4Yi54n1R4npGsjMmW+McYw4L8sJGNWYK49659HTQV1+JKJIFrvnM3
         n5T7bKGAzifVnsJaFoN2kM6SN90ID0X7phzf6BvSmCVZ7623XMd3Y/uffR8bpxytFL1S
         1hj93M0j8gd81ETnUHFDfxjJkOZIJccyjeYgHCfmp8vc1HAzmDQFkbn5/U1b/ahr/m0K
         Ymdboh89kcJl8BTujppaV+TB1xSV2AtiXVvw0zSuQRAk57XtD//hu2JUiHR+Q9bAELbn
         yNHw1KDXxhsjeTdjsvcXRuoCSkSFs/eH/P4tlWTF2/8eKOQkVyk9fCmYz74ns45YqkeH
         nh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714984504; x=1715589304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cl82or32+HMklYE2/qW0027vhWN+f6Mtpy9tX8JqrLM=;
        b=Zh1qDr0b4T/ChsMV7e6JhxqLGJHpmBEfqlBKHvLcbrCGslCAfWnmGlAgNEDQAKVqV6
         lIB0Xg0LHYGj++0JHpbn1rz7bMNXfo2FNWOXO2mSZEecExP8l47BgDAzf4eGZnNLRdzK
         0O3WkiSh4kUE/FGhkzY3UMpg52DSacYIlCauo+I0MsULkUhJEav45JWbpRxRpT0PQ/gG
         FdeNqnNpfIPL5vJg5ozom+IoKhI5y+kgLc0wl+VqtOSK+YdY5J3XKhLUslnMLORX5iRa
         c7pbBToYiSNsyzR3L9cpR+8vX0LqkPuWw2FDGEBUQyuoMMGwUCTC6rTfXw06jwgYded6
         ipag==
X-Forwarded-Encrypted: i=1; AJvYcCWUKYD9PSmYtfHPftZANuiG75qrnzpBfLGXDw31QKufayEwOb15pgq1konFCAp1055QbmpTnd10WVZw8JCWCn5kd2n8HRuydgPO
X-Gm-Message-State: AOJu0YyIx+JlpowAWtlyameyyNGQ0SRIYbNKN8NkGls37HKRM3PNyBoZ
	X35ndFTZkn6VPh8OvszVv9bKY3tifRzWil3izVMlbc2SHGLoyqcuAAc17NWiRQrNq4rA/dl2VIK
	1fo09DyiR/4yDKatbGYHuPtQu2RsRfuuBcJmm/g==
X-Google-Smtp-Source: AGHT+IEkW7T5CQhyeqmSlHuisdfcaUlqU8az6cBxqJ4J35d4b1NiK5CHY+ZPFiN6HEU+aU6NkXLame+lrsLlRzjG5Zs=
X-Received: by 2002:a05:6830:1213:b0:6ee:3d3b:734b with SMTP id
 r19-20020a056830121300b006ee3d3b734bmr12512911otp.2.1714984504155; Mon, 06
 May 2024 01:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422091936.3714381-1-jens.wiklander@linaro.org>
 <20240422091936.3714381-4-jens.wiklander@linaro.org> <Zioezu_sOqJ0xC6u@mecka.net>
 <CAHUa44EJrWoJabHJTABfPFswAp0PiTaTSrrdomhrQvciDxXDCQ@mail.gmail.com> <ZjT2thFR0oZ96g4M@mecka.net>
In-Reply-To: <ZjT2thFR0oZ96g4M@mecka.net>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 6 May 2024 10:34:52 +0200
Message-ID: <CAHUa44FOLg=eMCL9PWoJmtDzKQrOGk3551qHrc_V8JuSNtkhYg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] optee: probe RPMB device using RPMB subsystem
To: Manuel Traut <manut@mecka.net>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 4:37=E2=80=AFPM Manuel Traut <manut@mecka.net> wrote=
:
>
> On Fri, Apr 26, 2024 at 03:40:50PM +0200, Jens Wiklander wrote:
> > On Thu, Apr 25, 2024 at 11:13=E2=80=AFAM Manuel Traut <manut@mecka.net>=
 wrote:
> > >
> > > On Mon, Apr 22, 2024 at 11:19:36AM +0200, Jens Wiklander wrote:
> > > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to prob=
e and
> > > > use an RPMB device via the RPMB subsystem instead of passing the RP=
MB
> > > > frames via tee-supplicant in user space. A fallback mechanism is ke=
pt to
> > > > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > > > available.
> > > >
> > > > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > > > devices until one is found with the expected RPMB key already
> > > > programmed.
> > >
> > > I tested this with fTPM running as built-in TA in optee_os.
> > > The first user of the TA is u-boot. u-boot handles the RPMB requests.
> > >
> > > If the tpm-ftpm-tee kernel driver gets probed it triggers also some
> > > RPMB requests. However they are not handled by the new RPMB subsystem=
.
> > >
> > > I did some workaround (see below) but I guess this no good solution.
> > > Need to think longer about this..
> >
> > That's interesting. Again, thanks for testing.
> >
> > >
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > >  drivers/tee/optee/core.c          |  30 ++++
> > > >  drivers/tee/optee/device.c        |   7 +
> > > >  drivers/tee/optee/ffa_abi.c       |   8 ++
> > > >  drivers/tee/optee/optee_private.h |  21 ++-
> > > >  drivers/tee/optee/optee_rpc_cmd.h |  35 +++++
> > > >  drivers/tee/optee/rpc.c           | 232 ++++++++++++++++++++++++++=
++++
> > > >  drivers/tee/optee/smc_abi.c       |   7 +
> > > >  7 files changed, 339 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > > index 3aed554bc8d8..082691c10a90 100644
> > > > --- a/drivers/tee/optee/core.c
> > > > +++ b/drivers/tee/optee/core.c
> > > > @@ -11,6 +11,7 @@
> > > >  #include <linux/io.h>
> > > >  #include <linux/mm.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/rpmb.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/string.h>
> > > >  #include <linux/tee_drv.h>
> > > > @@ -80,6 +81,31 @@ void optee_pool_op_free_helper(struct tee_shm_po=
ol *pool, struct tee_shm *shm,
> > > >       shm->pages =3D NULL;
> > > >  }
> > > >
> > > > +void optee_bus_scan_rpmb(struct work_struct *work)
> > > > +{
> > > > +     struct optee *optee =3D container_of(work, struct optee,
> > > > +                                        rpmb_scan_bus_work);
> > > > +     int ret;
> > > > +
> > > > +     if (!optee->rpmb_scan_bus_done) {
> > > > +             ret =3D optee_enumerate_devices(PTA_CMD_GET_DEVICES_R=
PMB);
> > > > +             optee->rpmb_scan_bus_done =3D !ret;
> > > > +             if (ret && ret !=3D -ENODEV)
> > > > +                     pr_info("Scanning for RPMB device: ret %d\n",=
 ret);
> > > > +     }
> > > > +}
> > > > +
> > > > +int optee_rpmb_intf_rdev(struct notifier_block *intf, unsigned lon=
g action,
> > > > +                      void *data)
> > > > +{
> > > > +     struct optee *optee =3D container_of(intf, struct optee, rpmb=
_intf);
> > > > +
> > > > +     if (action =3D=3D RPMB_NOTIFY_ADD_DEVICE)
> > > > +             schedule_work(&optee->rpmb_scan_bus_work);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  static void optee_bus_scan(struct work_struct *work)
> > > >  {
> > > >       WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> > > > @@ -161,6 +187,8 @@ void optee_release_supp(struct tee_context *ctx=
)
> > > >
> > > >  void optee_remove_common(struct optee *optee)
> > > >  {
> > > > +     rpmb_interface_unregister(&optee->rpmb_intf);
> > > > +     cancel_work_sync(&optee->rpmb_scan_bus_work);
> > > >       /* Unregister OP-TEE specific client devices on TEE bus */
> > > >       optee_unregister_devices();
> > > >
> > > > @@ -177,6 +205,8 @@ void optee_remove_common(struct optee *optee)
> > > >       tee_shm_pool_free(optee->pool);
> > > >       optee_supp_uninit(&optee->supp);
> > > >       mutex_destroy(&optee->call_queue.mutex);
> > > > +     rpmb_dev_put(optee->rpmb_dev);
> > > > +     mutex_destroy(&optee->rpmb_dev_mutex);
> > > >  }
> > > >
> > > >  static int smc_abi_rc;
> > > > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.=
c
> > > > index 4b1092127694..4274876857c8 100644
> > > > --- a/drivers/tee/optee/device.c
> > > > +++ b/drivers/tee/optee/device.c
> > > > @@ -43,6 +43,13 @@ static int get_devices(struct tee_context *ctx, =
u32 session,
> > > >       ret =3D tee_client_invoke_func(ctx, &inv_arg, param);
> > > >       if ((ret < 0) || ((inv_arg.ret !=3D TEEC_SUCCESS) &&
> > > >                         (inv_arg.ret !=3D TEEC_ERROR_SHORT_BUFFER))=
) {
> > > > +             /*
> > > > +              * TEE_ERROR_STORAGE_NOT_AVAILABLE is returned when g=
etting
> > > > +              * the list of device TAs that depends on RPMB but a =
usable
> > > > +              * RPMB device isn't found.
> > > > +              */
> > > > +             if (inv_arg.ret =3D=3D TEE_ERROR_STORAGE_NOT_AVAILABL=
E)
> > > > +                     return -ENODEV;
> > > >               pr_err("PTA_CMD_GET_DEVICES invoke function err: %x\n=
",
> > > >                      inv_arg.ret);
> > > >               return -EINVAL;
> > > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_ab=
i.c
> > > > index ecb5eb079408..a8dfdb30b4e8 100644
> > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > @@ -7,6 +7,7 @@
> > > >
> > > >  #include <linux/arm_ffa.h>
> > > >  #include <linux/errno.h>
> > > > +#include <linux/rpmb.h>
> > > >  #include <linux/scatterlist.h>
> > > >  #include <linux/sched.h>
> > > >  #include <linux/slab.h>
> > > > @@ -934,6 +935,7 @@ static int optee_ffa_probe(struct ffa_device *f=
fa_dev)
> > > >       optee_cq_init(&optee->call_queue, 0);
> > > >       optee_supp_init(&optee->supp);
> > > >       optee_shm_arg_cache_init(optee, arg_cache_flags);
> > > > +     mutex_init(&optee->rpmb_dev_mutex);
> > > >       ffa_dev_set_drvdata(ffa_dev, optee);
> > > >       ctx =3D teedev_open(optee->teedev);
> > > >       if (IS_ERR(ctx)) {
> > > > @@ -955,6 +957,9 @@ static int optee_ffa_probe(struct ffa_device *f=
fa_dev)
> > > >       if (rc)
> > > >               goto err_unregister_devices;
> > > >
> > > > +     INIT_WORK(&optee->rpmb_scan_bus_work, optee_bus_scan_rpmb);
> > > > +     optee->rpmb_intf.notifier_call =3D optee_rpmb_intf_rdev;
> > > > +     rpmb_interface_register(&optee->rpmb_intf);
> > > >       pr_info("initialized driver\n");
> > > >       return 0;
> > > >
> > > > @@ -968,6 +973,9 @@ static int optee_ffa_probe(struct ffa_device *f=
fa_dev)
> > > >       teedev_close_context(ctx);
> > > >  err_rhashtable_free:
> > > >       rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_f=
n, NULL);
> > > > +     rpmb_dev_put(optee->rpmb_dev);
> > > > +     mutex_destroy(&optee->rpmb_dev_mutex);
> > > > +     rpmb_interface_unregister(&optee->rpmb_intf);
> > > >       optee_supp_uninit(&optee->supp);
> > > >       mutex_destroy(&optee->call_queue.mutex);
> > > >       mutex_destroy(&optee->ffa.mutex);
> > > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/=
optee_private.h
> > > > index 7a5243c78b55..ae72f3dda1d2 100644
> > > > --- a/drivers/tee/optee/optee_private.h
> > > > +++ b/drivers/tee/optee/optee_private.h
> > > > @@ -8,6 +8,7 @@
> > > >
> > > >  #include <linux/arm-smccc.h>
> > > >  #include <linux/rhashtable.h>
> > > > +#include <linux/rpmb.h>
> > > >  #include <linux/semaphore.h>
> > > >  #include <linux/tee_drv.h>
> > > >  #include <linux/types.h>
> > > > @@ -20,11 +21,13 @@
> > > >  /* Some Global Platform error codes used in this driver */
> > > >  #define TEEC_SUCCESS                 0x00000000
> > > >  #define TEEC_ERROR_BAD_PARAMETERS    0xFFFF0006
> > > > +#define TEEC_ERROR_ITEM_NOT_FOUND    0xFFFF0008
> > > >  #define TEEC_ERROR_NOT_SUPPORTED     0xFFFF000A
> > > >  #define TEEC_ERROR_COMMUNICATION     0xFFFF000E
> > > >  #define TEEC_ERROR_OUT_OF_MEMORY     0xFFFF000C
> > > >  #define TEEC_ERROR_BUSY                      0xFFFF000D
> > > >  #define TEEC_ERROR_SHORT_BUFFER              0xFFFF0010
> > > > +#define TEE_ERROR_STORAGE_NOT_AVAILABLE 0xF0100003
> > > >
> > > >  #define TEEC_ORIGIN_COMMS            0x00000002
> > > >
> > > > @@ -197,6 +200,12 @@ struct optee_ops {
> > > >   * @notif:           notification synchronization struct
> > > >   * @supp:            supplicant synchronization struct for RPC to =
supplicant
> > > >   * @pool:            shared memory pool
> > > > + * @mutex:           mutex protecting @rpmb_dev
> > > > + * @rpmb_dev:                current RPMB device or NULL
> > > > + * @rpmb_scan_bus_done       flag if device registation of RPMB de=
pendent devices
> > > > + *                   was already done
> > > > + * @rpmb_scan_bus_work       workq to for an RPMB device and to sc=
an optee bus
> > > > + *                   and register RPMB dependent optee drivers
> > > >   * @rpc_param_count: If > 0 number of RPC parameters to make room =
for
> > > >   * @scan_bus_done    flag if device registation was already done.
> > > >   * @scan_bus_work    workq to scan optee bus and register optee dr=
ivers
> > > > @@ -215,9 +224,15 @@ struct optee {
> > > >       struct optee_notif notif;
> > > >       struct optee_supp supp;
> > > >       struct tee_shm_pool *pool;
> > > > +     /* Protects rpmb_dev pointer */
> > > > +     struct mutex rpmb_dev_mutex;
> > > > +     struct rpmb_dev *rpmb_dev;
> > > > +     struct notifier_block rpmb_intf;
> > > >       unsigned int rpc_param_count;
> > > > -     bool   scan_bus_done;
> > > > +     bool scan_bus_done;
> > > > +     bool rpmb_scan_bus_done;
> > > >       struct work_struct scan_bus_work;
> > > > +     struct work_struct rpmb_scan_bus_work;
> > > >  };
> > > >
> > > >  struct optee_session {
> > > > @@ -280,8 +295,12 @@ int optee_cancel_req(struct tee_context *ctx, =
u32 cancel_id, u32 session);
> > > >
> > > >  #define PTA_CMD_GET_DEVICES          0x0
> > > >  #define PTA_CMD_GET_DEVICES_SUPP     0x1
> > > > +#define PTA_CMD_GET_DEVICES_RPMB     0x2
> > > >  int optee_enumerate_devices(u32 func);
> > > >  void optee_unregister_devices(void);
> > > > +void optee_bus_scan_rpmb(struct work_struct *work);
> > > > +int optee_rpmb_intf_rdev(struct notifier_block *intf, unsigned lon=
g action,
> > > > +                      void *data);
> > > >
> > > >  int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct t=
ee_shm *shm,
> > > >                              size_t size, size_t align,
> > > > diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/=
optee_rpc_cmd.h
> > > > index f3f06e0994a7..f351a8ac69fc 100644
> > > > --- a/drivers/tee/optee/optee_rpc_cmd.h
> > > > +++ b/drivers/tee/optee/optee_rpc_cmd.h
> > > > @@ -16,6 +16,14 @@
> > > >   * and sends responses.
> > > >   */
> > > >
> > > > +/*
> > > > + * Replay Protected Memory Block access
> > > > + *
> > > > + * [in]     memref[0]            Frames to device
> > > > + * [out]    memref[1]            Frames from device
> > > > + */
> > > > +#define OPTEE_RPC_CMD_RPMB           1
> > > > +
> > > >  /*
> > > >   * Get time
> > > >   *
> > > > @@ -103,4 +111,31 @@
> > > >  /* I2C master control flags */
> > > >  #define OPTEE_RPC_I2C_FLAGS_TEN_BIT  BIT(0)
> > > >
> > > > +/*
> > > > + * Reset RPMB probing
> > > > + *
> > > > + * Releases an eventually already used RPMB devices and starts ove=
r searching
> > > > + * for RPMB devices. Returns the kind of shared memory to use in s=
ubsequent
> > > > + * OPTEE_RPC_CMD_RPMB_PROBE_NEXT and OPTEE_RPC_CMD_RPMB calls.
> > > > + *
> > > > + * [out]    value[0].a           OPTEE_RPC_SHM_TYPE_*, the paramet=
er for
> > > > + *                       OPTEE_RPC_CMD_SHM_ALLOC
> > > > + */
> > > > +#define OPTEE_RPC_CMD_RPMB_PROBE_RESET       22
> > > > +
> > > > +/*
> > > > + * Probe next RPMB device
> > > > + *
> > > > + * [out]    value[0].a           Type of RPMB device, OPTEE_RPC_RP=
MB_*
> > > > + * [out]    value[0].b           EXT CSD-slice 168 "RPMB Size"
> > > > + * [out]    value[0].c           EXT CSD-slice 222 "Reliable Write=
 Sector Count"
> > > > + * [out]    memref[1]       Buffer with the raw CID
> > > > + */
> > > > +#define OPTEE_RPC_CMD_RPMB_PROBE_NEXT        23
> > > > +
> > > > +/* Type of RPMB device */
> > > > +#define OPTEE_RPC_RPMB_EMMC          0
> > > > +#define OPTEE_RPC_RPMB_UFS           1
> > > > +#define OPTEE_RPC_RPMB_NVME          2
> > > > +
> > > >  #endif /*__OPTEE_RPC_CMD_H*/
> > > > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > > > index e69bc6380683..a3e4c1830f39 100644
> > > > --- a/drivers/tee/optee/rpc.c
> > > > +++ b/drivers/tee/optee/rpc.c
> > > > @@ -7,6 +7,7 @@
> > > >
> > > >  #include <linux/delay.h>
> > > >  #include <linux/i2c.h>
> > > > +#include <linux/rpmb.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/tee_drv.h>
> > > >  #include "optee_private.h"
> > > > @@ -255,6 +256,228 @@ void optee_rpc_cmd_free_suppl(struct tee_cont=
ext *ctx, struct tee_shm *shm)
> > > >       optee_supp_thrd_req(ctx, OPTEE_RPC_CMD_SHM_FREE, 1, &param);
> > > >  }
> > > >
> > > > +static void handle_rpc_func_rpmb_probe_reset(struct tee_context *c=
tx,
> > > > +                                          struct optee *optee,
> > > > +                                          struct optee_msg_arg *ar=
g)
> > > > +{
> > > > +     struct tee_param params[1];
> > > > +
> > > > +     if (!IS_ENABLED(CONFIG_RPMB)) {
> > > > +             handle_rpc_supp_cmd(ctx, optee, arg);
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     if (arg->num_params !=3D ARRAY_SIZE(params) ||
> > > > +         optee->ops->from_msg_param(optee, params, arg->num_params=
,
> > > > +                                    arg->params) ||
> > > > +         params[0].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPU=
T) {
> > > > +             arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     params[0].u.value.a =3D OPTEE_RPC_SHM_TYPE_KERNEL;
> > > > +     params[0].u.value.b =3D 0;
> > > > +     params[0].u.value.c =3D 0;
> > > > +     if (optee->ops->to_msg_param(optee, arg->params,
> > > > +                                  arg->num_params, params)) {
> > > > +             arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     mutex_lock(&optee->rpmb_dev_mutex);
> > > > +     rpmb_dev_put(optee->rpmb_dev);
> > > > +     optee->rpmb_dev =3D NULL;
> > > > +     mutex_unlock(&optee->rpmb_dev_mutex);
> > > > +
> > > > +     arg->ret =3D TEEC_SUCCESS;
> > > > +}
> > > > +
> > > > +static int rpmb_type_to_rpc_type(enum rpmb_type rtype)
> > > > +{
> > > > +     switch (rtype) {
> > > > +     case RPMB_TYPE_EMMC:
> > > > +             return OPTEE_RPC_RPMB_EMMC;
> > > > +     case RPMB_TYPE_UFS:
> > > > +             return OPTEE_RPC_RPMB_UFS;
> > > > +     case RPMB_TYPE_NVME:
> > > > +             return OPTEE_RPC_RPMB_NVME;
> > > > +     default:
> > > > +             return -1;
> > > > +     }
> > > > +}
> > > > +
> > > > +static int rpc_rpmb_match(struct rpmb_dev *rdev, const void *data)
> > > > +{
> > > > +     return rpmb_type_to_rpc_type(rdev->descr.type) >=3D 0;
> > > > +}
> > > > +
> > > > +static void handle_rpc_func_rpmb_probe_next(struct tee_context *ct=
x,
> > > > +                                         struct optee *optee,
> > > > +                                         struct optee_msg_arg *arg=
)
> > > > +{
> > > > +     struct rpmb_dev *rdev;
> > > > +     struct tee_param params[2];
> > > > +     void *buf;
> > > > +
> > > > +     if (!IS_REACHABLE(CONFIG_RPMB)) {
> > > > +             handle_rpc_supp_cmd(ctx, optee, arg);
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     if (arg->num_params !=3D ARRAY_SIZE(params) ||
> > > > +         optee->ops->from_msg_param(optee, params, arg->num_params=
,
> > > > +                                    arg->params) ||
> > > > +         params[0].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPU=
T ||
> > > > +         params[1].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTP=
UT) {
> > > > +             arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > > > +             return;
> > > > +     }
> > > > +     buf =3D tee_shm_get_va(params[1].u.memref.shm,
> > > > +                          params[1].u.memref.shm_offs);
> > > > +     if (!buf) {
> > > > +             arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     mutex_lock(&optee->rpmb_dev_mutex);
> > > > +     rdev =3D rpmb_dev_find_device(NULL, optee->rpmb_dev, rpc_rpmb=
_match);
> > > > +     rpmb_dev_put(optee->rpmb_dev);
> > > > +     optee->rpmb_dev =3D rdev;
> > > > +     mutex_unlock(&optee->rpmb_dev_mutex);
> > > > +
> > > > +     if (!rdev) {
> > > > +             arg->ret =3D TEEC_ERROR_ITEM_NOT_FOUND;
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     if (params[1].u.memref.size < rdev->descr.dev_id_len) {
> > > > +             arg->ret =3D TEEC_ERROR_SHORT_BUFFER;
> > > > +             return;
> > > > +     }
> > > > +     memcpy(buf, rdev->descr.dev_id, rdev->descr.dev_id_len);
> > > > +     params[1].u.memref.size =3D rdev->descr.dev_id_len;
> > > > +     params[0].u.value.a =3D rpmb_type_to_rpc_type(rdev->descr.typ=
e);
> > > > +     params[0].u.value.b =3D rdev->descr.capacity;
> > > > +     params[0].u.value.c =3D rdev->descr.reliable_wr_count;
> > > > +     if (optee->ops->to_msg_param(optee, arg->params,
> > > > +                                  arg->num_params, params)) {
> > > > +             arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     arg->ret =3D TEEC_SUCCESS;
> > > > +}
> > > > +
> > > > +/* Request */
> > > > +struct rpmb_req {
> > > > +     u16 cmd;
> > > > +#define RPMB_CMD_DATA_REQ      0x00
> > > > +#define RPMB_CMD_GET_DEV_INFO  0x01
> > > > +     u16 dev_id;
> > > > +     u16 block_count;
> > > > +     /* Optional data frames (rpmb_data_frame) follow */
> > > > +};
> > > > +
> > > > +#define RPMB_REQ_DATA(req) ((void *)((struct rpmb_req *)(req) + 1)=
)
>
> This is the root cause for the non page aligned buffer we discussed in
>
> v5 2/3 mmc: block: register RPMB partition with the RPMB subsystem

Thanks for tracking this down. I'll fix it in the v6.

Cheers,
Jens
