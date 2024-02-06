Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FDA130AE9
	for <linux-mmc@vger.kernel.org>; Tue,  6 Feb 2024 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217974; cv=none; b=L45mbbMa/j6IlEEXLCAJMPSnPYHpnXz39/6BaLonoSEm2v8vg6tNKUW132fMRchUoUMmJ6CuMHGWQ5X/LIbvPtKM12gB0gTkvtZvRQI1qstnvJRZWTv8xm57G4k3q9LpCE3lcezM8XTuI3c+zuBs8mhfYsEZJ7A1Ni2X5B3nODU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217974; c=relaxed/simple;
	bh=eWGar3ehc9D3CTd1YwKjKYD86VEg4tR8XJ41GtCC418=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWd21Mw8BycfXr2zT56dbD7R99l5zN434lzGb/IaJtLL5raxGGIDhPhNc30PaWZjygBU0L37zsORsUDaEPjYoQof+Mua50WClQfA7API+zlNQRUtVh49N9lHM0LG0ktQLhbHOvF/QOTapN1DEJEdCwaRcr9MUFdunD48fTEOa8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IOC+Dkv/; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOC+Dkv/"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d643a40a91so1403760241.0
        for <linux-mmc@vger.kernel.org>; Tue, 06 Feb 2024 03:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707217972; x=1707822772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QWO9cv59VFMVcgxftdSchJ1bJs3AtyhEa4Wv6ViEgyM=;
        b=IOC+Dkv/fTKSlBsKwIzuHGcrsUHKC3rqAHAcZU4jYVjjtfo1b4lovUfmV29C+yYHZ1
         2ZYcz7Scz/auW6yKfbteFvFtDnuqwZ5bwZM70e3wuTfkuUkO/fBZApXnNaX1KCdj6pK6
         Q1PS36RNfHepWVTKyEIAm6oSnkKE6ydNj+/fJgsk6SCyyG82YRnuSuL9fIOGAzfYlIBb
         cmL6StHTWQ+6G78Yfko6Um9Xbk5n+EuT8TFLAZZyC1QQgEidtumGFE7KFByDJadsmeP/
         MNyrmZE06QWzT296KsmouLHBFuLbVfQFowTBTs6DoKjWoxron8M8v6zxMJqZQz4UKP5u
         T//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707217972; x=1707822772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWO9cv59VFMVcgxftdSchJ1bJs3AtyhEa4Wv6ViEgyM=;
        b=FTUSbwJvXzTUcMy4QOJOk0qlTn31jCikpoJBc201Gpnfz5ZQySFhvivDF14qcRV52L
         CzfiJQwNJTREEx8msZI35Y8LHmWVYc0/n74ZXEhXceTleb10bhwR1dyJ7RmXiTS/iWkq
         nk88oMCjV0NICzxsFbGjtwvfLzayqPhocthYwUZAoQD2waPTft84UDRlAuV4BTHAApZw
         +tFWE4rlB3EhkhpHaIEbG+Xch1yQWEgiOiue0aORC+ApiXprL4p0nHYXxDgzMVVL3FQV
         ZSjL1WsKtd7DdPxWODmy8G2ORTgo57hh8H9wCPBPwvv3M2KWA/wXZtUfJezHcOayKswQ
         4xAA==
X-Gm-Message-State: AOJu0Yy/b6v+hnyFkj/98ipn89SueCvB4ZHalqR3Efyk8AmHS/NuhNsu
	dPVX76JuipeNYHamSz9NsIQ40YtKBLxKL2Pv/YPwm0ULkezjpVIMh9w+pQ/u7AprrIG3xj4ZhCp
	+G8JJPk2FSR72Hfjuq1+RZ/hW37H7OWKQfPMKwQ==
X-Google-Smtp-Source: AGHT+IExt9KbOkFbxjIkwcdrbrIwP17LujEz8x7z/nHeSwCIo+gickjxcPx4b911VpEVokUFSS38lHkDtC7pDORrng4=
X-Received: by 2002:a05:6102:38cd:b0:46d:49ac:6ec4 with SMTP id
 k13-20020a05610238cd00b0046d49ac6ec4mr62190vst.19.1707217971860; Tue, 06 Feb
 2024 03:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org> <20240131174347.510961-4-jens.wiklander@linaro.org>
In-Reply-To: <20240131174347.510961-4-jens.wiklander@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 6 Feb 2024 16:42:40 +0530
Message-ID: <CAFA6WYPATEXUNfYHA1abup=kYBREJq7y=D9d1DdkJCxXqPhgAQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] optee: probe RPMB device using RPMB subsystem
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
> Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe and
> use an RPMB device via the RPBM subsystem instead of passing the RPMB
> frames via tee-supplicant in user space. A fallback mechanism is kept to
> route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> available.
>
> The OP-TEE RPC ABI is extended to support iterating over all RPMB
> devices until one is found with the expected RPMB key already
> programmed.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c          |   1 +
>  drivers/tee/optee/ffa_abi.c       |   2 +
>  drivers/tee/optee/optee_private.h |   6 +
>  drivers/tee/optee/optee_rpc_cmd.h |  33 +++++
>  drivers/tee/optee/rpc.c           | 221 ++++++++++++++++++++++++++++++
>  drivers/tee/optee/smc_abi.c       |   2 +
>  6 files changed, 265 insertions(+)
>

[snip]

>  #endif /*__OPTEE_RPC_CMD_H*/
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index e69bc6380683..6fd6f99dafab 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/rpmb.h>
>  #include <linux/slab.h>
>  #include <linux/tee_drv.h>
>  #include "optee_private.h"
> @@ -255,6 +256,217 @@ void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm)
>         optee_supp_thrd_req(ctx, OPTEE_RPC_CMD_SHM_FREE, 1, &param);
>  }
>
> +static void handle_rpc_func_rpmb_probe_reset(struct tee_context *ctx,
> +                                            struct optee *optee,
> +                                            struct optee_msg_arg *arg)
> +{
> +       struct tee_param params[1];
> +
> +       if (!IS_ENABLED(CONFIG_RPMB)) {
> +               handle_rpc_supp_cmd(ctx, optee, arg);
> +               return;
> +       }
> +
> +       if (arg->num_params != ARRAY_SIZE(params) ||
> +           optee->ops->from_msg_param(optee, params, arg->num_params,
> +                                      arg->params) ||
> +           params[0].attr != TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT) {
> +               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +               return;
> +       }
> +
> +       params[0].u.value.a = OPTEE_RPC_SHM_TYPE_KERNEL;
> +       params[0].u.value.b = 0;
> +       params[0].u.value.c = 0;
> +       if (optee->ops->to_msg_param(optee, arg->params,
> +                                    arg->num_params, params)) {
> +               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +               return;
> +       }
> +
> +       mutex_lock(&optee->rpmb_dev_mutex);
> +       rpmb_dev_put(optee->rpmb_dev);
> +       optee->rpmb_dev = NULL;
> +       mutex_unlock(&optee->rpmb_dev_mutex);
> +
> +       arg->ret = TEEC_SUCCESS;
> +}
> +
> +static int rpc_rpmb_match(struct device *dev, const void *data)
> +{
> +       return 1;
> +}
> +
> +static void handle_rpc_func_rpmb_probe_next(struct tee_context *ctx,
> +                                           struct optee *optee,
> +                                           struct optee_msg_arg *arg)
> +{
> +       struct rpmb_dev *start_rdev;
> +       struct rpmb_dev *rdev;
> +       struct tee_param params[2];
> +       void *buf;
> +
> +       if (!IS_ENABLED(CONFIG_RPMB)) {
> +               handle_rpc_supp_cmd(ctx, optee, arg);
> +               return;
> +       }
> +
> +       if (arg->num_params != ARRAY_SIZE(params) ||
> +           optee->ops->from_msg_param(optee, params, arg->num_params,
> +                                      arg->params) ||
> +           params[0].attr != TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT ||
> +           params[1].attr != TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT) {
> +               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +               return;
> +       }
> +       buf = tee_shm_get_va(params[1].u.memref.shm,
> +                            params[1].u.memref.shm_offs);
> +       if (!buf) {
> +               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +               return;
> +       }
> +
> +       mutex_lock(&optee->rpmb_dev_mutex);
> +       start_rdev = optee->rpmb_dev;
> +       rdev = rpmb_dev_find_device(NULL, start_rdev, rpc_rpmb_match);
> +       rpmb_dev_put(start_rdev);
> +       optee->rpmb_dev = rdev;
> +       mutex_unlock(&optee->rpmb_dev_mutex);
> +
> +       if (!rdev) {
> +               arg->ret = TEEC_ERROR_ITEM_NOT_FOUND;

One of the major comments I have here is regarding how this implicit
dependency on eMMC driver probe is met here. What if OP-TEE based
fTPM/EFI client driver probes before eMMC driver?

-Sumit
