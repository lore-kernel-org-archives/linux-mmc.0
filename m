Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BC714534F
	for <linux-mmc@vger.kernel.org>; Tue, 27 Feb 2024 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047905; cv=none; b=JXpLdrQBuLyT/Tiat741Hr2Ejs19oLWgPVJqn2ZBGKvJGIpHV/Bo8hXUBnLuh/u8Ev4qkF1AAMLLMmU2X9ylKpNDYoFG5BOvY/pBKG8uQswtfpTyIA/ualBLQwAhV31lX2IPFa2sBiCzjti69fztYNPCZthQbIyaOqDLnkoojyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047905; c=relaxed/simple;
	bh=v6yybQAjFJ2C3zsbW/Boip9BqVfFpCyinrgWkMgqJaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cmJ5LqBbMqp9poXsZSykfa21N+4QjicP8YI5YY2hzGjREt2sdm+pZPYECiJvplZXJBBouHnUQYaVsXzhzwZtf6/lBORhiXETVmI7sNXIC3J546zXuI8Jo4pfXy0IUZ58fQz5XFjGNTg4cP6PXypOJFnR0ia1Ty9szBQvp8+QJq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YKUVIYfB; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKUVIYfB"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513143d3c42so553554e87.3
        for <linux-mmc@vger.kernel.org>; Tue, 27 Feb 2024 07:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709047901; x=1709652701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QqPwg+3i18/ioCqaGI7I8uzwIulXGfxqfDO8uVoxw8=;
        b=YKUVIYfBSVeAGdMInBjkz/newNIRmogr0RtEo+tHNdHbuak2PlXf2BZO3CQ5dQ+hS/
         fbkRkVdVK0vv7NjUAPlFtMU0+z74PtqSrHahSFtwwJ6kUe0qCDTcmFLriAAURkcp7lXO
         jeDIghntJVuOANQT9ESrdJzhIxybTjhLc5MKAP/icu5ZZuV0jXCcqUMVA2I7y26KKQrV
         Ky4WQjBiIcoiwZw+hZFFgHn6sHXZVM1nYIalf1L8F0Ozg7wCd1R+Ds8J3dHwB4IAtJLk
         oR691TfiKAvQlaxvO7Vq3y4AXEHyoAfKCFaLxG+FIxc+ztpHSy6FMuwT0GPg/VPTD5rn
         c8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047901; x=1709652701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QqPwg+3i18/ioCqaGI7I8uzwIulXGfxqfDO8uVoxw8=;
        b=eY1wBpHCtQchZHWZpiBEnRWeuF+W2MxBWlHuwQ97G5IW2SSDywZAClIo7mUs1DbXXk
         vWh8kf6MCoERo7gkYxgHgE4gQDCi31fOOhwC3QIagDHlnmhrlsib63aAkjtOsVu/JQK+
         Sgechh2cN6rRSTavfQkAMSoUE7o1/Izvpa4GkTr0L6xeXbmDYG9552FFvqXEB7pm3Npc
         rMdgjYLjfF3gV/ZAEGhxBVQDuWPpIdrVBJnnGopoaCLRlCzJ2M8T1RrXLMHeAINKINc3
         IufOUhyElJHgrRnUetgdJEDfIK/Dut1hwRndosS9A3SCydFZ/I2dJXLBbq/Q01wqO2Xm
         GxHg==
X-Forwarded-Encrypted: i=1; AJvYcCX4YsnGSGfmNITweqEYSA6HRN7AnGVCg2fjrxjwxWmPQMBG3V/Bzmi6sjD1ef8r8CudjXHVdmurU8dcFkIyBBTGAHB7vwjihgjE
X-Gm-Message-State: AOJu0Yz+vszckdz9cmU1C5xfGT+k15ezB7cSMm6BJpKHCoy6oeZkSMmd
	Jip7TkBOQoJNY+Rv+LQLVvaLixYB7jqQGbh0lGi0NCiCiPR0aPyW3KOxZSONP2E=
X-Google-Smtp-Source: AGHT+IEDSSiCUlmzoKgRQY8s7Pefw6eYs9eb8X4BYTdKNJWvCvgFckZVp7kIYiwX3e9kXw9nvzmzlA==
X-Received: by 2002:a05:6512:33cd:b0:512:f650:d968 with SMTP id d13-20020a05651233cd00b00512f650d968mr5995411lfg.42.1709047901175;
        Tue, 27 Feb 2024 07:31:41 -0800 (PST)
Received: from localhost.localdomain (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id h18-20020a19ca52000000b00513003b8ebesm586969lfj.135.2024.02.27.07.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:31:40 -0800 (PST)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 0/3] Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 27 Feb 2024 16:31:29 +0100
Message-Id: <20240227153132.2611499-1-jens.wiklander@linaro.org>
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

Thanks,
Jens

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
 drivers/misc/rpmb-core.c          | 258 ++++++++++++++++++++++++++++++
 drivers/mmc/core/block.c          | 153 +++++++++++++++++-
 drivers/tee/optee/core.c          |  55 +++++++
 drivers/tee/optee/ffa_abi.c       |   7 +
 drivers/tee/optee/optee_private.h |  16 ++
 drivers/tee/optee/optee_rpc_cmd.h |  35 ++++
 drivers/tee/optee/rpc.c           | 233 +++++++++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       |   6 +
 include/linux/rpmb.h              | 195 ++++++++++++++++++++++
 12 files changed, 974 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/rpmb-core.c
 create mode 100644 include/linux/rpmb.h


base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.34.1

