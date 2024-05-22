Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B579D1171C
	for <linux-mmc@vger.kernel.org>; Wed, 22 May 2024 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392002; cv=none; b=uwbh0Ok6HHFnb2pq1Wlcd0+bhivUf81jQhE9ezmWhlaL/pxXmf7nQRe/5g+VJiuJ73UuYwK/SkQR25bAlEN9Do+1XjxsNSuPB5h9WXAl7xRngrcDBUW/LPGIwBsQ/UEnXdEjBw6LbNOpytPba0W+2SC/OfOjACWes4yqOF/HKms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392002; c=relaxed/simple;
	bh=DTuPHVySPIrytSlQQAkraU05lJwg/nz9VAI6mBTkiOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mf7MGo+habzyRfjjpdWV137c5mzGBZDBUJhC0SV+lIlWru3UF243rVYSAQMEqvVxRQGYdgUp/dXkFjTwLXZc30bBnEUaEt1zotvvrb68bL4s9/L+4o6ftRtootpwSwKTLCytFkbEJcdhmCpCY8WplReFk/BlFHD6S+EMqmo2LRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xA7BBIC0; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xA7BBIC0"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-23f9d07829bso2728232fac.3
        for <linux-mmc@vger.kernel.org>; Wed, 22 May 2024 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716391999; x=1716996799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8aume3L1m03D35QJaau4/HSPmv1c3Gln6h9PVmEraw=;
        b=xA7BBIC0mOnoCOMdmfocHSV3iV4fWe18bFiZ/1QrO6YSTcTtQDdG7EvIP0wG2I56jE
         OUnqTcK2TNin+A5bpev4qTnndmGKpZmEbY72Nf6qYfYVixHDmD+I4Vb+JblI9iuu8NaD
         tkIoezzWAFJDF/Oj87lSpwfTsKEcaDtEhvOCpGpXAnM8Cr/YuJivMVq56/2te9FYUnkg
         YtCHPybuLHmZFXe2npjlpk9uRVS3aD0f2EBU9ZCbVw3oL3Y7i56+zzWkyAUHcV04eT9K
         rmfCvXG1MNjw8ZYYiiRy9aGkG0nz+sFqP85PuENeT/a3TpxdCzUYz7YF8HSyRpMbXpFl
         BXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716391999; x=1716996799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8aume3L1m03D35QJaau4/HSPmv1c3Gln6h9PVmEraw=;
        b=OewqsL3k3MLlLEIlULt2RpfPz96+1DdgbylmGxBlDgE0hcslRlh6/qVCo0ombFHhPE
         z/rS3jtDtmbouIW5uvTtkd0O9J37ZzC2PNwVrZntWWe+9T73Veiul+sJSemfn1pYGyDf
         AV6+eVoGUoiCYjw4UMNUKzonSFtPLeh+qGWljAC0KwYUtUKb05qSXkzyevCQrWoZx2i8
         A6sxbvbBZWwU5rCiEPP1gyNV9T9iLy8KICxUXhumitjCiZKIjD4wXKCK2OhrKDz6N3Gu
         rQhHU4L/rEFaXzpBSeD/RN3nO6AcNj9HqwbGkrdQMPVL++2A9KAc7CKyPfFAJ5aftAiq
         5cYw==
X-Forwarded-Encrypted: i=1; AJvYcCVePfGkrxee44oVIK03YIWamNzX4vmJYVpUuiNWhDjUqsMHCooYBEuvu0w/KJ7InRMR4SnA5o4/bdlXoQroJYI5mqGoUmPRv8og
X-Gm-Message-State: AOJu0YxP67uC0SPkSeHtOOvBawI6daH54r4ytv7XmTwYLLlQ6KubXPVT
	qThQL5eMsbK1KPaBE3A/s3o22GeTTlGxsfFBwNpM0wIdxMYIHyrdn1ZPDGkPfYG9AInl2zbiAqy
	g2LZrHN6/w2Sh4ebM/t9Ph+j0YuWTx/6sTwIqwg==
X-Google-Smtp-Source: AGHT+IFqMvpvJULYdcMKR8qQoteoVfPgW/n3o9HiXEiJrvf8hH9SUOAqQhKFIXnTWQfl6tadPMlJegrjTgx3js5xpo0=
X-Received: by 2002:a05:6870:15c4:b0:23c:a6f8:9362 with SMTP id
 586e51a60fabf-24c68af82a2mr2585031fac.13.1716391998683; Wed, 22 May 2024
 08:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507091619.2208810-1-jens.wiklander@linaro.org> <ZkODCTnCe7l0KiFs@mecka.net>
In-Reply-To: <ZkODCTnCe7l0KiFs@mecka.net>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 22 May 2024 17:33:07 +0200
Message-ID: <CAHUa44GFd0-jB7VV2=iL0YWT9+NyY+jDZNdxpERGWODO08pFDA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Replay Protected Memory Block (RPMB) subsystem
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

Hi Manuel,

On Tue, May 14, 2024 at 5:28=E2=80=AFPM Manuel Traut <manut@mecka.net> wrot=
e:
>
> Hi Jens,
>
> thank you very much for v6! It took me some time to figure out why it is
> not working.. However it seems to be on the OP-TEE side and not related
> to this kernel series.
>
> I need this change:
>
> @@ -1214,12 +1225,13 @@ static TEE_Result tee_rpmb_init(void)
>         }
>
>         if (rpmb_ctx->reinit) {
>                 if (rpmb_ctx->legacy_operation || !rpmb_ctx->key_verified=
) {
>                         rpmb_ctx->wr_cnt_synced =3D false;
>                         rpmb_ctx->key_derived =3D false;
>                         rpmb_ctx->dev_info_synced =3D false;
>                         rpmb_ctx->reinit =3D false;
> -                       goto next;
>                 }
>                 res =3D rpmb_probe_reset();
>                 if (res) {
>
> @@ -1236,17 +1248,23 @@ static TEE_Result tee_rpmb_init(void)
>                         if (!memcmp(rpmb_ctx->cid, dev_info.cid,
>                                    RPMB_EMMC_CID_SIZE)) {
>                                 rpmb_ctx->reinit =3D false;
> +                               rpmb_ctx->legacy_operation =3D false;
>                                 return TEE_SUCCESS;
>                         }
>                 }
>         }
>
> to ensure that the non legacy mode is selected, even if the first RPMB
> request comes from a compiled in TA.

That patch didn't quite work in my case, but I think I understand
what's needed at your end.

I've prepared patches at https://github.com/OP-TEE/optee_os/pull/6852
can you try those, please?

>
> Thanks for your work, it makes it really easy now to implement ARM
> System Ready IR with an fTPM and continue the boot measurements in the
> initrd with the new tpm2.target in systemd v256.

Thanks, much appreciated.

Cheers,
Jens

>
> Regards
> Manuel
>
> On Tue, May 07, 2024 at 11:16:16AM +0200, Jens Wiklander wrote:
> > Hi,
> >
> > This patch set introduces a new RPMB subsystem, based on patches from [=
1],
> > [2], and [3]. The RPMB subsystem aims at providing access to RPMB
> > partitions to other kernel drivers, in particular the OP-TEE driver. A =
new
> > user space ABI isn't needed, we can instead continue using the already
> > present ABI when writing the RPMB key during production.
> >
> > I've added and removed things to keep only what is needed by the OP-TEE
> > driver. Since the posting of [3], there has been major changes in the M=
MC
> > subsystem so "mmc: block: register RPMB partition with the RPMB subsyst=
em"
> > is in practice completely rewritten.
> >
> > With this OP-TEE can access RPMB during early boot instead of having to
> > wait for user space to become available as in the current design [4].
> > This will benefit the efi variables [5] since we wont rely on userspace=
 as
> > well as some TPM issues [6] that were solved.
> >
> > The OP-TEE driver finds the correct RPMB device to interact with by
> > iterating over available devices until one is found with a programmed
> > authentication matching the one OP-TEE is using. This enables coexistin=
g
> > users of other RPMBs since the owner can be determined by who knows the
> > authentication key.
> >
> > The corresponding secure world OP-TEE patches are available at [7].
> >
> > I've put myself as a maintainer for the RPMB subsystem as I have an
> > interest in the OP-TEE driver to keep this in good shape. However, if y=
ou'd
> > rather see someone else taking the maintainership that's fine too. I'll
> > help keep the subsystem updated regardless.
> >
> > [1] https://lore.kernel.org/lkml/20230722014037.42647-1-shyamsaini@linu=
x.microsoft.com/
> > [2] https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee@l=
inaro.org/
> > [3] https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-=
tomas.winkler@intel.com/
> > [4] https://optee.readthedocs.io/en/latest/architecture/secure_storage.=
html#rpmb-secure-storage
> > [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Dc44b6be62e8dd4ee0a308c36a70620613e6fc55f
> > [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D7269cba53d906cf257c139d3b3a53ad272176bca
> > [7] https://github.com/jenswi-linaro/optee_os/tree/rpmb_probe_v6
> >
> > Thanks,
> > Jens
> >
> > Changes since v5:
> > Manuel Traut reported and investigated an error on an i.MX8MM, the root
> > cause was identified as insufficient alignment on frames sent to the RP=
MB
> > device. Fixed in the OP-TEE driver as described below.
> > * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
> >   - Adding a missing EXPORT_SYMBOL_GPL()
> > * "optee: probe RPMB device using RPMB subsystem"
> >   - Replacing the old OPTEE_RPC_CMD_RPMB ABI with OPTEE_RPC_CMD_RPMB_FR=
AMES
> >     to get rid of the small header struct rpmb_req (now removed) causin=
g
> >     the problem.
> >   - Matching changes on the secure side + support for re-initializing
> >     RPMB in case a boot stage has used RPMB, the latter also reported b=
y
> >     Manuel Traut.
> >
> > Changes since v4:
> > * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
> >   - Describing struct rpmb_descr as RPMB description instead of descrip=
tor
> > * "mmc: block: register RPMB partition with the RPMB subsystem"
> >   - Addressing review comments
> >   - Adding more comments for struct rpmb_frame
> >   - Fixing assignment of reliable_wr_count and capacity in mmc_blk_rpmb=
_add()
> > * "optee: probe RPMB device using RPMB subsystem"
> >   - Updating struct rpmb_dev_info to match changes in "rpmb: add Replay
> >     Protected Memory Block (RPMB) subsystem"
> >
> > Changes since v3:
> > * Move struct rpmb_frame into the MMC driver since the format of the RP=
MB
> >   frames depend on the implementation, one format for eMMC, another for
> >   UFS, and so on
> > * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
> >   - Adding Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >   - Adding more description of the API functions
> >   - Removing the set_dev_info() op from struct rpmb_ops, the needed inf=
ormation
> >     is supplied in the arguments to rpmb_dev_register() instead.
> >   - Getting rid of struct rpmb_ops since only the route_frames() op was
> >     remaining, store that op directly in struct rpmb_dev
> >   - Changed rpmb_interface_register() and rpmb_interface_unregister() t=
o use
> >     notifier_block instead of implementing the same thing ourselves
> > * "mmc: block: register RPMB partition with the RPMB subsystem"
> >   - Moving the call to rpmb_dev_register() to be done at the end of
> >     mmc_blk_probe() when the device is fully available
> > * "optee: probe RPMB device using RPMB subsystem"
> >   - Use IS_REACHABLE(CONFIG_RPMB) to determine if the RPMB subsystem is
> >     available
> >   - Translate TEE_ERROR_STORAGE_NOT_AVAILABLE if encountered in get_dev=
ices()
> >     to recognize the error in optee_rpmb_scan()
> >   - Simplified optee_rpmb_scan() and optee_rpmb_intf_rdev()
> >
> > Changes since v2:
> > * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
> >   - Fixing documentation issues
> >   - Adding a "depends on MMC" in the Kconfig
> >   - Removed the class-device and the embedded device, struct rpmb_dev n=
ow
> >     relies on the parent device for reference counting as requested
> >   - Removed the now unneeded rpmb_ops get_resources() and put_resources=
()
> >     since references are already taken in mmc_blk_alloc_rpmb_part() bef=
ore
> >     rpmb_dev_register() is called
> >   - Added rpmb_interface_{,un}register() now that
> >     class_interface_{,un}register() can't be used ay longer
> > * "mmc: block: register RPMB partition with the RPMB subsystem"
> >   - Adding the missing error cleanup in alloc_idata()
> >   - Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part(=
)
> >     instead of in mmc_rpmb_chrdev_open() and rpmb_op_mmc_get_resources(=
)
> > * "optee: probe RPMB device using RPMB subsystem"
> >   - Registering to get a notification when an RPMB device comes online
> >   - Probes for RPMB devices each time an RPMB device comes online, unti=
l
> >     a usable device is found
> >   - When a usable RPMB device is found, call
> >     optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB)
> >   - Pass type of rpmb in return value from OPTEE_RPC_CMD_RPMB_PROBE_NEX=
T
> >
> > Changes since Shyam's RFC:
> > * Removed the remaining leftover rpmb_cdev_*() function calls
> > * Refactored the struct rpmb_ops with all the previous ops replaced, in
> >   some sense closer to [3] with the route_frames() op
> > * Added rpmb_route_frames()
> > * Added struct rpmb_frame, enum rpmb_op_result, and enum rpmb_type from=
 [3]
> > * Removed all functions not needed in the OP-TEE use case
> > * Added "mmc: block: register RPMB partition with the RPMB subsystem", =
based
> >   on the commit with the same name in [3]
> > * Added "optee: probe RPMB device using RPMB subsystem" for integration
> >   with OP-TEE
> > * Moved the RPMB driver into drivers/misc/rpmb-core.c
> > * Added my name to MODULE_AUTHOR() in rpmb-core.c
> > * Added an rpmb_mutex to serialize access to the IDA
> > * Removed the target parameter from all rpmb_*() functions since it's
> >   currently unused
> >
> > Jens Wiklander (3):
> >   rpmb: add Replay Protected Memory Block (RPMB) subsystem
> >   mmc: block: register RPMB partition with the RPMB subsystem
> >   optee: probe RPMB device using RPMB subsystem
> >
> >  MAINTAINERS                       |   7 +
> >  drivers/misc/Kconfig              |  10 ++
> >  drivers/misc/Makefile             |   1 +
> >  drivers/misc/rpmb-core.c          | 233 +++++++++++++++++++++++++++++
> >  drivers/mmc/core/block.c          | 241 +++++++++++++++++++++++++++++-
> >  drivers/tee/optee/core.c          |  30 ++++
> >  drivers/tee/optee/device.c        |   7 +
> >  drivers/tee/optee/ffa_abi.c       |   8 +
> >  drivers/tee/optee/optee_private.h |  21 ++-
> >  drivers/tee/optee/optee_rpc_cmd.h |  35 +++++
> >  drivers/tee/optee/rpc.c           | 166 ++++++++++++++++++++
> >  drivers/tee/optee/smc_abi.c       |   7 +
> >  include/linux/rpmb.h              | 136 +++++++++++++++++
> >  13 files changed, 899 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/misc/rpmb-core.c
> >  create mode 100644 include/linux/rpmb.h
> >
> > --
> > 2.34.1
> >
