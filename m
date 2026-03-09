Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FB43D7D83
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070312; cv=pass; b=mxZePoKAlfFC/9iPqpaWn4hgKpOSHD5hzoO3kgdtQJXbzXxsyM/9Bok4Bt3/OQzkElo5hb+Nf3JrKekMCevmFfgcUbWDy5njIQRoplpxqchQDKU6NHk1Ibq9FiCHQ2lYwbM+QYaADE7DkQPYlgT9cJuJurFlCgC/LEhY0Notx9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070312; c=relaxed/simple;
	bh=X4iZhElZiqQhLsc+HE815O54rp2BjBnsxJg+ObtrQac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKnbQKwy23ln+OaZhqrOm9i9yMwFmPy2ir85h+Nd013YHsIs9hONR4zUhMosiN7u1s8rldUHPc7kjH3zhsMO0wHqVgdjKn5vA+m4RVBTb+CLUiQUlfDI687CIHd4VGQ2g4vP3Ww7zVZmF2O7N6jm+qSg9BHK6v7cpMSo2TJG2Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MlKUimUG; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MlKUimUG"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d74872c5b1so40679a34.2
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 08:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773070310; cv=none;
        d=google.com; s=arc-20240605;
        b=DJtIdlVe7nUKYKDRXQQf+m5b5Za01YIftu5Hg7IdGmrBV7ZBbgrGYCsyMhZgTgKHx+
         pjg6N16V6ro/yBa7ajncxJT0MDjbHBjmKj0bprbWDyDybIX97Zuho1M/N3nuVh0NiwBq
         VUdVEFoZhPIFFbHe78EF/HWt3231yJfaagbQtM1la04ma2obGLO1XZGsdFyCmdAmhtqL
         OYrZoRlspDRK9EAKHP0auTXIP6czWEjUG+JTT+PQwaeQXtv2OfdCMXyNV+yPbZo7W3k8
         OQ0Qfv58frWL7lMrkgM5kKLDeIE+045u/iTPKE6sJwtlFj9hoavEDFay4ZJLpyqDmxMx
         pa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oeNCYoeh9aVUManQKA2h7rmbYGtX7bI6QzEClpFzvxQ=;
        fh=pDzAOaz8+H5kfR5VfycrMva4JWRXrBDz0wPJTPRRwFM=;
        b=Vc9eUMEWkbrzGGHgz4AbV39Q+GLyvNJvlIifTt4q/AeToaLpzB4rH/HocJCofwptck
         zYGf8f3PShfGjIg3ZH6jFYZ+ZgroTFq/Bz2+5eNrKUV6yuOCMiNygHadByYqID3XjuBX
         fM3j3zxHj6sNdpUn0SxbcnWVdHl+09+j2gpfKtOVLj39v6f+t7PmFSn8LmhcwjlShpmy
         oiss3pMcahNOF1zzPuSiDuG6duaIdYJyhKuwZizV9aF9ENZQUUaf9gPG8h7PRDHRaf0P
         +m57MoEEzygCJGI2cdFxTkeALFceKXZ+DqaQlRy79AiWDbGHUjcxoGUNq6U24LDd2x4V
         LBiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773070310; x=1773675110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeNCYoeh9aVUManQKA2h7rmbYGtX7bI6QzEClpFzvxQ=;
        b=MlKUimUGje76EscbzLWcSlldqq111vtCpVcyo/wqC3rEMLkggIaJYPQ5AZQNQyihZs
         3ckPLpELVWUhsH1zg3WeNE8Jni+YaIjg/7CJERYYjynYc5kaGbWgeowbFNmJmEfzvFpt
         5ObBykiAohDjN4EDRisb0wT/BsZKh1kgXNqIK6FM1bQmQ+MsD8+WMQQ0N0r0IN6DmQvC
         Jnpow2om0w7St/ILTer4drfq6zGiEWKWS4W2LB6u1cZ8x9hi0Gwp4bzxS+Jpp82hS0fi
         VhzFedI3MMB6aDgc3a7W983nJDl2xZBgggGLLqmZEbMEatoBqk4jVBusq8YwPVGb5EmI
         wAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070310; x=1773675110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oeNCYoeh9aVUManQKA2h7rmbYGtX7bI6QzEClpFzvxQ=;
        b=OpPKWb4wRFpvXDytu0e97Um9gpofIloV7nCzK5gWWaqKzhf+IVbgFgiNfoka7SfSlZ
         QBC2L3YvLBBcH5Iq38l83dxWATsI5ANWFANxvzMaHSz7wwUDS6k2RtRNo18of0lTbAde
         Wo+uh0UZUXb1pglRI9u/Un+1UXOGFBaeW7MWssFiUFLaHABo6jW28R9Ej18xMiwM9t8F
         O2LKdZRz99hb/nYJ51m1jrCMurlRNGqA5G1zXHEWQPTUIbx/mOLO6bQqDOOs6bDc+twx
         tDtsJkMb2g4ZPA6K4LMTHGklno7oz9Gp9x6EoSx62JtBv55X8kaEdsNZbvvD6tpDWp8F
         OCkw==
X-Forwarded-Encrypted: i=1; AJvYcCXUej4iDmmUsbSVFLa65exooFLNNe8zmbs+MZwN0m4VRRMvUrFWevp2CmWYIdmrc3tXE+rbDRLk/cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ6sDLzxeq617WbQaS0O5Yho+lIrmIQe2DoGJ2fTwKWOaU1slv
	EO+1eP8a4NGS2xuH4giEyHgeGJ93qDV8gqrlQ0k5nxvzBH/0a8McS/RiStMDIddJ8ghcee03Gld
	YLxkKqqU8f22cFggX83p2MF+hQwsNHzIQ4ulA5YGDKg==
X-Gm-Gg: ATEYQzwMsfZMeXQkIyxPj/9nLqqRlyHz0eVCUv/f64trNAOOL4z00BsmkOy4xjjjB82
	IACrrSMMxUGlY8V2Wo8Xy91nRCqgg8PbIgpkM4x1B2LOiZL6/z7vzyA4oSnBUKnsCLQa7Rg/POr
	+5IRwtMtjPdXE8ndoROcyW7UQRxHrn5HLLRLnI4TtSjIDeyJgI9W0hyvPBkUqdZUp+GMS7W7n1i
	4xSmlEyS02gm2zejHbCoon0XtYQKhhK6hEJnWjBCvhqr2ucpqFx7YdQGLBB88+TflSmxWc+L4hk
	pn1c/DRUVkgcu+6ZSQ==
X-Received: by 2002:a05:6830:4486:b0:7d7:4cf3:76eb with SMTP id
 46e09a7af769-7d74cf37b02mr2194872a34.4.1773070309370; Mon, 09 Mar 2026
 08:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309062840.2937858-2-iam@sung-woo.kim> <202603090911.0DdOwjTR-lkp@intel.com>
In-Reply-To: <202603090911.0DdOwjTR-lkp@intel.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 9 Mar 2026 08:31:38 -0700
X-Gm-Features: AaiRm52Z14MD0OSGkRezE5rp23B4YvHF_3hxCrYP4X9p-5DR-qWhmespFt1uSGc
Message-ID: <CADUfDZqBZWwy+6XOde_aZTwLisRP8j5qRqB6X_EJJPr+wmdGZQ@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: nvme: Fix general protection fault in nvme_setup_descriptor_pools()
To: kernel test robot <lkp@intel.com>
Cc: Sungwoo Kim <iam@sung-woo.kim>, Jens Axboe <axboe@kernel.dk>, 
	Josef Bacik <josef@toxicpanda.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, oe-kbuild-all@lists.linux.dev, 
	Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nbd@other.debian.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 1:42=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Sungwoo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on axboe/for-next]
> [also build test ERROR on device-mapper-dm/for-next linus/master v6.16-rc=
1 next-20260306]
> [cannot apply to linux-nvme/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Sungwoo-Kim/blk-mq=
-nvme-Fix-general-protection-fault-in-nvme_setup_descriptor_pools/20260309-=
143107
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git f=
or-next
> patch link:    https://lore.kernel.org/r/20260309062840.2937858-2-iam%40s=
ung-woo.kim
> patch subject: [PATCH] blk-mq: nvme: Fix general protection fault in nvme=
_setup_descriptor_pools()
> config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/202=
60309/202603090911.0DdOwjTR-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260309/202603090911.0DdOwjTR-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603090911.0DdOwjTR-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> error[E0308]: mismatched types
>    --> rust/kernel/block/mq/operations.rs:274:28
>    |
>    274 |         init_request: Some(Self::init_request_callback),
>    |                       ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn p=
ointer, found fn item
>    |                       |
>    |                       arguments to this enum variant are incorrect
>    |
>    =3D note: expected fn pointer `unsafe extern "C" fn(_, _, _, i32) -> _=
`
>    found fn item `unsafe extern "C" fn(_, _, _, u32) -> _ {block::mq::ope=
rations::OperationsVTable::<T>::init_request_callback}`
>    help: the type constructed contains `unsafe extern "C" fn(*mut binding=
s::blk_mq_tag_set, *mut bindings::request, u32, u32) -> i32 {block::mq::ope=
rations::OperationsVTable::<T>::init_request_callback}` due to the type of =
the argument passed

Looks like the type of _numa_node in the signature of
init_request_callback() needs to be updated accordingly from c_uint to
c_int.

Best,
Caleb


>    --> rust/kernel/block/mq/operations.rs:274:23
>    |
>    274 |         init_request: Some(Self::init_request_callback),
>    |                       ^^^^^---------------------------^
>    |                            |
>    |                            this argument influences the type of `Som=
e`
>    note: tuple variant defined here
>    --> /opt/cross/rustc-1.88.0-bindgen-0.72.1/rustup/toolchains/1.88.0-x8=
6_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/option.rs:597:=
5
>    |
>    597 |     Some(#[stable(feature =3D "rust1", since =3D "1.0.0")] T),
>    |     ^^^^
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
