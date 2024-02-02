Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304ED60BBD
	for <linux-mmc@vger.kernel.org>; Fri,  2 Feb 2024 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867985; cv=none; b=XbCAPZKJ+t/PA/D4X3MghaSWH/n4wXOkamopI83mRhjJ6On9zEAyIBxi51L9M0bXm1t2SYMplQSG9kcBZ5YkcMD3IwzslGZqvaqmgucQ9A/9cndpXg6pzFG/BEQvSY9bYRRcs3dML1/TuLQgjyMU28J+uTd/MGfG/2JQlgAlzwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867985; c=relaxed/simple;
	bh=dc8rQnh6PDoB1TWGzNuLOJkPoGzySAD7iS8TKBzVRPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MY4kHmfFoEnkcr4BPG0lK+1AvW83/C7BqeCmMjyvMLh2prQF4cXi/DZtggFzA4omSor4Eb9AveO3PKZ/QCZSpTXk8mEtQOv9Kd0iPTmo8jG58wPqh0YKBnRLJrRS3AP8O7clNgrM6AINqTfY+c4UEHleVr8qHrYXCS5RDIkn/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z2i1QSxW; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2i1QSxW"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-46b3ff62223so1954163137.0
        for <linux-mmc@vger.kernel.org>; Fri, 02 Feb 2024 01:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706867982; x=1707472782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mGyYTzfbWHLJ9icv+vr2JH/WdzWZ6KgDnIC2V14paRI=;
        b=Z2i1QSxW7NutcqfA7Zy0AUOJOb6cderHycpxrrWTlI2QqmvKyvGFtJmcs+60jtVrr2
         PNOsy2KHVdXdzCwRQi1kcXVCpWVFJTcPXJ+j3VyipMzRbDyxPF9cr5AOjp86LKKlSWJJ
         yjZHj5oqT0O6WmoTvHBtRUB9s6PDWfCs4YWfZxEexMcgcFvR9nYEfVeI8aqfVoGZqqVD
         x2MwCf4DsHtFhG6oJIRWptofVB29z4E7whwC1v7Od6oX9Nq1GcgZuo6+pzRo3rnC5bVM
         z+WgMuLDKnlE1TD0FdoVWkpfMHZo7K4novF3xeqU8aenv/UA4yrNvRzG8nOlZ9nEw4OJ
         Kvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867982; x=1707472782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGyYTzfbWHLJ9icv+vr2JH/WdzWZ6KgDnIC2V14paRI=;
        b=XHoPNdE9E6VWcotjrK9/SMY+M7iDwfkgmo9KH94FLnsj1pH1f0u6eLZPYP9rf//bz6
         /rH7RGA9EmRfVk+K7yvbV+Jc1UG5+fRiLXrIXK8h5oJH8EeEkWey3rWsB7p4ZfenzhYd
         PLFRvf7xAbFwy5W4isiKSWK4N80ZFzZA1V6p4sc558s046B1zLlOmnQL3froOus2CgCb
         klZBHonN2O1dq7y6Vk9y9kJWAn/vxpe7Mkx/HxQENKHfKHWuZ6jtQJFeM3oi3C0qAsR0
         fXubUQHjBxnhA8IZoT9DL4pyrg41V7JXIbqEN2rDer9LytOCOwYPYz+r97LDOns48ci4
         ANbw==
X-Gm-Message-State: AOJu0Yw/D9n+wT1MazdxEK+8kWUQvLx+rPp+aT7JYARE3oJeSKy0JhyL
	37ni423zb1vX/6KZsMewcowyGgLwNtSkI2tN2jiR+EgjchlVDrSVhm2gfkiIvzBv4veK1sWDxGZ
	95ylsK456mxswernmP4U9PGi2TNKgnz1Q4nAKWQ==
X-Google-Smtp-Source: AGHT+IGx011pU/uYoeRaO9GDRIyKMw5o70O5J6j1cmokVIok+jvPB4MJkIPn0wNMToA6OBf4Al+Gz7jgxs56x66TY0U=
X-Received: by 2002:a67:f61a:0:b0:46c:fc76:7746 with SMTP id
 k26-20020a67f61a000000b0046cfc767746mr1201018vso.2.1706867981911; Fri, 02 Feb
 2024 01:59:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
In-Reply-To: <20240131174347.510961-1-jens.wiklander@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 2 Feb 2024 15:29:30 +0530
Message-ID: <CAFA6WYORTtuRsoiDhjCdPwaDHyJ+ixZBu_-VQHPE2RhCprKQ0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Replay Protected Memory Block (RPMB) subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jens,

On Wed, 31 Jan 2024 at 23:14, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> It's been a while since Shyam posted the last version [1] of this patch
> set. I've pinged Shyam, but so far I've had no reply so I'm trying to make
> another attempt with the RPMB subsystem. If Shyam has other changes in mind
> than what I'm adding here I hope we'll find a way to cover that too. I'm
> calling it version two of the patchset since I'm trying to address all
> feedback on the previous version even if I'm starting a new thread.
>
> This patch set introduces a new RPMB subsystem, based on patches from [1],
> [2], and [3]. The RPMB subsystem aims at providing access to RPMB
> partitions to other kernel drivers, in particular the OP-TEE driver. A new
> user space ABI isn't needed, we can instead continue using the already
> present ABI when writing the RPMB key during production.
>
> I've added and removed things to keep only what is needed by the OP-TEE
> driver. Since the posting of [3], there has been major changes in the MMC
> subsystem so "mmc: block: register RPMB partition with the RPMB subsystem"
> is in practice completely rewritten.
>
> With this OP-TEE can access RPMB during early boot instead of having to
> wait for user space to become available as in the current design [4].
> This will benefit the efi variables [5] since we wont rely on userspace as
> well as some TPM issues [6] that were solved.
>
> The OP-TEE driver finds the correct RPMB device to interact with by
> iterating over available devices until one is found with a programmed
> authentication matching the one OP-TEE is using. This enables coexisting
> users of other RPMBs since the owner can be determined by who knows the
> authentication key.
>
> I've put myself as a maintainer for the RPMB subsystem as I have an
> interest in the OP-TEE driver to keep this in good shape. However, if you'd
> rather see someone else taking the maintainership that's fine too. I'll
> help keep the subsystem updated regardless.
>
> [1] https://lore.kernel.org/lkml/20230722014037.42647-1-shyamsaini@linux.microsoft.com/
> [2] https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee@linaro.org/
> [3] https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-tomas.winkler@intel.com/
> [4] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html#rpmb-secure-storage
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c44b6be62e8dd4ee0a308c36a70620613e6fc55f
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7269cba53d906cf257c139d3b3a53ad272176bca
>
> Thanks,
> Jens
>
> Changes since Shyam's RFC:
> * Removed the remaining leftover rpmb_cdev_*() function calls
> * Refactored the struct rpmb_ops with all the previous ops replaced, in
>   some sense closer to [3] with the route_frames() op
> * Added rpmb_route_frames()
> * Added struct rpmb_frame, enum rpmb_op_result, and enum rpmb_type from [3]
> * Removed all functions not needed in the OP-TEE use case
> * Added "mmc: block: register RPMB partition with the RPMB subsystem", based
>   on the commit with the same name in [3]
> * Added "optee: probe RPMB device using RPMB subsystem" for integration
>   with OP-TEE
> * Moved the RPMB driver into drivers/misc/rpmb-core.c
> * Added my name to MODULE_AUTHOR() in rpmb-core.c
> * Added an rpmb_mutex to serialize access to the IDA
> * Removed the target parameter from all rpmb_*() functions since it's
>   currently unused
>

Thanks for working on this. This is a huge step towards supporting TEE
kernel client drivers. IIRC you mentioned offline to test it with
virtio RPMB on Qemu. If it works then I would be happy to try it out
as well.

Along with that can you point me to the corresponding OP-TEE OS
changes? I suppose as you are just adding 3 new RPC calls in patch#3,
so we should be fine ABI wise although people have to uprev both
OP-TEE and Linux kernel to get this feature enabled. However, OP-TEE
should gate those RPCs behind a config flag or can just fallback to
user-space supplicant if those aren't supported?

-Sumit

>
>
> Jens Wiklander (3):
>   rpmb: add Replay Protected Memory Block (RPMB) subsystem
>   mmc: block: register RPMB partition with the RPMB subsystem
>   optee: probe RPMB device using RPMB subsystem
>
>  MAINTAINERS                       |   7 +
>  drivers/misc/Kconfig              |   9 ++
>  drivers/misc/Makefile             |   1 +
>  drivers/misc/rpmb-core.c          | 247 ++++++++++++++++++++++++++++++
>  drivers/mmc/core/block.c          | 177 +++++++++++++++++++++
>  drivers/tee/optee/core.c          |   1 +
>  drivers/tee/optee/ffa_abi.c       |   2 +
>  drivers/tee/optee/optee_private.h |   6 +
>  drivers/tee/optee/optee_rpc_cmd.h |  33 ++++
>  drivers/tee/optee/rpc.c           | 221 ++++++++++++++++++++++++++
>  drivers/tee/optee/smc_abi.c       |   2 +
>  include/linux/rpmb.h              | 184 ++++++++++++++++++++++
>  12 files changed, 890 insertions(+)
>  create mode 100644 drivers/misc/rpmb-core.c
>  create mode 100644 include/linux/rpmb.h
>
>
> base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
> --
> 2.34.1
>
