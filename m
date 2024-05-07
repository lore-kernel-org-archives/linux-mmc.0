Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F6914D420
	for <linux-mmc@vger.kernel.org>; Tue,  7 May 2024 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073408; cv=none; b=isSDjk4La77WY9WBnp5ICsxvz+GfvXDnfMC3XN086YNWvHTL+LO8Of3NAegwDigtF/TMiMZ7AyvRBnsEzS/ZUbmKqBawpmuqj71799wOnRV1ktF4yWaSz9Rh+0eCfn7YgRxlREt8E8ZfcxdrRHbxbaermkb9nyvsuzEaF5iEmkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073408; c=relaxed/simple;
	bh=ZlFj5mE6OAnUWsN7WRwEHHNDMDdnvkwd2e0VijNGXzs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uqPDcEoKc/fpHW1SElqlQBtuAcFpfVPNY8bIEpKO4k74Qy0/G8J/h+AWi9nvfCvCTn2IF0awQ+huFLNnnD/Mvb/WAmSxkJWd5qtsG+MVloP9cw9x8c5eW//UbUxH/dvjpHCwaawVEZ9nQ5at7BYWZZg6Z1loK4UQ2SDKQpi/1zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fH2yJVU7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fH2yJVU7"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a934ad50so637527466b.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 May 2024 02:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715073405; x=1715678205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TWFAIax7VgJLZxRlWO/4+BtD7d88wmBQmcI+YeYknLY=;
        b=fH2yJVU77NtsEfkpS6kmlwVNYevL7P1/nR/3Emd4WkumDTh2XBo7kMKPWL0FI38KtO
         e3mg4xfSLDmxgdteqT82bGrCmDLOc7szuiPi8IhZIl1Gk4zpqaXqh6o+M9VjuAQT2Dpf
         aLXPxX4LyEsPrynqw0EmeERTmKoCXCm/fImnZmh+AyxwJQgG5TqNGGn/gjlxKFxV/h4C
         /9aLD/+y/yoYRhq1AjY9G/STGl2X5c4n4jKWSGPUddI7xvzcG1etolo8J3OXu9C5k1ej
         gfTYzfxDZ/ftVaV8Br6m4DVvTXshBWfGg5XVfayXBGvvZFkNKolcxirDBcENOtqut0YF
         yU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715073405; x=1715678205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWFAIax7VgJLZxRlWO/4+BtD7d88wmBQmcI+YeYknLY=;
        b=kMqc/thE/vmqxg/b8G6fo0te2V2ijCCfPFZnb+RoKX4AX6Mz97DcevJ5Exoi5g/0A2
         k0dtMb6T9sNmkPEZTDTp1d30m5mxa5qU/HSLWDF4gzqksxIJz2gc5xHoAeSCz9ccN2Bu
         U7PvnYPpE1TeQ3bJBz97WsoLArxsiIG0z1azURMa4FR/T0NfdjKgMHyQqkkza9ZW30P7
         j5sOjCsdjEugZ1OaaS2dFjlHwwEIIb66yCJluC2aQ76X8UzrVFbX4sFw/feMtwVVYJiA
         z1a2Ph/pIHci2/PPZhFavhnWDOYDj162v40mRIU4IRk9NmaqTmd5JDQfSmVxvAwNiX8w
         Nw9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKIZo0cctYsx9KenPUrQ+m+IP5bSjP8X7l4b/gM4+CJWrTFxzfTAWhglLkF01ll1NDBhY1ALiOUPEgGBZygXKyP7iczG2H2JYr
X-Gm-Message-State: AOJu0Yy6OVSeypdTNBGGCMKmIwSi9uwtpPMtoP9nOjDgHskoojfu2DCU
	MWyf6y3ow9pHSkULNR2Dz6jd78KIFU2wVQQHKAegVQMI610jnsaIDh2nR0rIoVU=
X-Google-Smtp-Source: AGHT+IEHkV+dxQN39dASSA+4rssDDDEvk7fegprmsO5hRlrhJRTjV5H4N1Mnt6oCq8E5JymnbLiWMw==
X-Received: by 2002:a17:907:50f:b0:a59:9c4d:da3c with SMTP id wj15-20020a170907050f00b00a599c4dda3cmr6249505ejb.40.1715073404835;
        Tue, 07 May 2024 02:16:44 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709061d4700b00a59a93a3ef4sm3976134ejh.149.2024.05.07.02.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:16:44 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Manuel Traut <manut@mecka.net>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v6 0/3] Replay Protected Memory Block (RPMB) subsystem
Date: Tue,  7 May 2024 11:16:16 +0200
Message-Id: <20240507091619.2208810-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This patch set introduces a new RPMB subsystem, based on patches from [1],
[2], and [3]. The RPMB subsystem aims at providing access to RPMB
partitions to other kernel drivers, in particular the OP-TEE driver. A new
user space ABI isn't needed, we can instead continue using the already
present ABI when writing the RPMB key during production.

I've added and removed things to keep only what is needed by the OP-TEE
driver. Since the posting of [3], there has been major changes in the MMC
subsystem so "mmc: block: register RPMB partition with the RPMB subsystem"
is in practice completely rewritten.

With this OP-TEE can access RPMB during early boot instead of having to
wait for user space to become available as in the current design [4].
This will benefit the efi variables [5] since we wont rely on userspace as
well as some TPM issues [6] that were solved.

The OP-TEE driver finds the correct RPMB device to interact with by
iterating over available devices until one is found with a programmed
authentication matching the one OP-TEE is using. This enables coexisting
users of other RPMBs since the owner can be determined by who knows the
authentication key.

The corresponding secure world OP-TEE patches are available at [7].

I've put myself as a maintainer for the RPMB subsystem as I have an
interest in the OP-TEE driver to keep this in good shape. However, if you'd
rather see someone else taking the maintainership that's fine too. I'll
help keep the subsystem updated regardless.

[1] https://lore.kernel.org/lkml/20230722014037.42647-1-shyamsaini@linux.microsoft.com/
[2] https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee@linaro.org/
[3] https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-tomas.winkler@intel.com/
[4] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html#rpmb-secure-storage
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c44b6be62e8dd4ee0a308c36a70620613e6fc55f
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7269cba53d906cf257c139d3b3a53ad272176bca
[7] https://github.com/jenswi-linaro/optee_os/tree/rpmb_probe_v6

Thanks,
Jens

Changes since v5:
Manuel Traut reported and investigated an error on an i.MX8MM, the root
cause was identified as insufficient alignment on frames sent to the RPMB
device. Fixed in the OP-TEE driver as described below.
* "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
  - Adding a missing EXPORT_SYMBOL_GPL()
* "optee: probe RPMB device using RPMB subsystem"
  - Replacing the old OPTEE_RPC_CMD_RPMB ABI with OPTEE_RPC_CMD_RPMB_FRAMES
    to get rid of the small header struct rpmb_req (now removed) causing
    the problem.
  - Matching changes on the secure side + support for re-initializing
    RPMB in case a boot stage has used RPMB, the latter also reported by 
    Manuel Traut.

Changes since v4:
* "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
  - Describing struct rpmb_descr as RPMB description instead of descriptor
* "mmc: block: register RPMB partition with the RPMB subsystem"
  - Addressing review comments
  - Adding more comments for struct rpmb_frame
  - Fixing assignment of reliable_wr_count and capacity in mmc_blk_rpmb_add()
* "optee: probe RPMB device using RPMB subsystem"
  - Updating struct rpmb_dev_info to match changes in "rpmb: add Replay
    Protected Memory Block (RPMB) subsystem"

Changes since v3:
* Move struct rpmb_frame into the MMC driver since the format of the RPMB
  frames depend on the implementation, one format for eMMC, another for
  UFS, and so on
* "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
  - Adding Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
  - Adding more description of the API functions
  - Removing the set_dev_info() op from struct rpmb_ops, the needed information
    is supplied in the arguments to rpmb_dev_register() instead.
  - Getting rid of struct rpmb_ops since only the route_frames() op was
    remaining, store that op directly in struct rpmb_dev
  - Changed rpmb_interface_register() and rpmb_interface_unregister() to use
    notifier_block instead of implementing the same thing ourselves
* "mmc: block: register RPMB partition with the RPMB subsystem"
  - Moving the call to rpmb_dev_register() to be done at the end of
    mmc_blk_probe() when the device is fully available
* "optee: probe RPMB device using RPMB subsystem"
  - Use IS_REACHABLE(CONFIG_RPMB) to determine if the RPMB subsystem is
    available
  - Translate TEE_ERROR_STORAGE_NOT_AVAILABLE if encountered in get_devices()
    to recognize the error in optee_rpmb_scan()
  - Simplified optee_rpmb_scan() and optee_rpmb_intf_rdev()

Changes since v2:
* "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
  - Fixing documentation issues
  - Adding a "depends on MMC" in the Kconfig
  - Removed the class-device and the embedded device, struct rpmb_dev now
    relies on the parent device for reference counting as requested
  - Removed the now unneeded rpmb_ops get_resources() and put_resources()
    since references are already taken in mmc_blk_alloc_rpmb_part() before
    rpmb_dev_register() is called
  - Added rpmb_interface_{,un}register() now that
    class_interface_{,un}register() can't be used ay longer
* "mmc: block: register RPMB partition with the RPMB subsystem"
  - Adding the missing error cleanup in alloc_idata()
  - Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
    instead of in mmc_rpmb_chrdev_open() and rpmb_op_mmc_get_resources()
* "optee: probe RPMB device using RPMB subsystem"
  - Registering to get a notification when an RPMB device comes online
  - Probes for RPMB devices each time an RPMB device comes online, until
    a usable device is found
  - When a usable RPMB device is found, call
    optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB)
  - Pass type of rpmb in return value from OPTEE_RPC_CMD_RPMB_PROBE_NEXT

Changes since Shyam's RFC:
* Removed the remaining leftover rpmb_cdev_*() function calls
* Refactored the struct rpmb_ops with all the previous ops replaced, in
  some sense closer to [3] with the route_frames() op
* Added rpmb_route_frames()
* Added struct rpmb_frame, enum rpmb_op_result, and enum rpmb_type from [3]
* Removed all functions not needed in the OP-TEE use case
* Added "mmc: block: register RPMB partition with the RPMB subsystem", based
  on the commit with the same name in [3]
* Added "optee: probe RPMB device using RPMB subsystem" for integration
  with OP-TEE
* Moved the RPMB driver into drivers/misc/rpmb-core.c
* Added my name to MODULE_AUTHOR() in rpmb-core.c
* Added an rpmb_mutex to serialize access to the IDA
* Removed the target parameter from all rpmb_*() functions since it's
  currently unused

Jens Wiklander (3):
  rpmb: add Replay Protected Memory Block (RPMB) subsystem
  mmc: block: register RPMB partition with the RPMB subsystem
  optee: probe RPMB device using RPMB subsystem

 MAINTAINERS                       |   7 +
 drivers/misc/Kconfig              |  10 ++
 drivers/misc/Makefile             |   1 +
 drivers/misc/rpmb-core.c          | 233 +++++++++++++++++++++++++++++
 drivers/mmc/core/block.c          | 241 +++++++++++++++++++++++++++++-
 drivers/tee/optee/core.c          |  30 ++++
 drivers/tee/optee/device.c        |   7 +
 drivers/tee/optee/ffa_abi.c       |   8 +
 drivers/tee/optee/optee_private.h |  21 ++-
 drivers/tee/optee/optee_rpc_cmd.h |  35 +++++
 drivers/tee/optee/rpc.c           | 166 ++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       |   7 +
 include/linux/rpmb.h              | 136 +++++++++++++++++
 13 files changed, 899 insertions(+), 3 deletions(-)
 create mode 100644 drivers/misc/rpmb-core.c
 create mode 100644 include/linux/rpmb.h

-- 
2.34.1

