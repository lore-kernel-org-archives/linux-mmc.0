Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD154431
	for <linux-mmc@vger.kernel.org>; Thu,  2 Jan 2025 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735822173; cv=none; b=KQ0CExVDMysaeGmNrIzCLOw5cFjKmdtiul0qTVBYtm/43egcj/fLCMZ2zXWyztD+RF1GnQqfy20HJT5uRJwLO0LaMZr/OilAqbmkMdy+6eSVM25bqIbX0loJAvnLCQHPlPFj+LwwI/9wd/CVg6X6xwrgchohaXrDu/u30Df1wg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735822173; c=relaxed/simple;
	bh=UUYkoAmU6dLDhGR30yetWeVORSdo9VhQcDcLe0LE4RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeYrQnlwSiGvsnEMfGimzZSm1z2tZ03nti2LaJRo2r30Muacmxb+BWz7nvd/SYYNdoA8yO3JaTPzwjsQT3gOd5WCTmk2aAufokIORup3l2T91O7FHUDY3+F7939yfkLLDA1lTmCOAeRlBD/8HQHkMNfJBsFgEuPLEgc1b5wELAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 591CF11FB;
	Thu,  2 Jan 2025 04:49:58 -0800 (PST)
Received: from [10.1.34.17] (e127648.arm.com [10.1.34.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 598313F673;
	Thu,  2 Jan 2025 04:49:29 -0800 (PST)
Message-ID: <191d74ae-aefb-42fa-b96e-1904bfc4b329@arm.com>
Date: Thu, 2 Jan 2025 12:49:27 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [eMMC] - Partition on eMMC boot block device is not visible
 anymore in kernel v6.1.53 and above
To: "Torrelli, Maxime" <Maxime.Torrelli@conduent.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "Bove, Frederic" <Frederic.Bove@conduent.com>
References: <PAYP264MB3440EA9BD04E467466A0DAE495142@PAYP264MB3440.FRAP264.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <PAYP264MB3440EA9BD04E467466A0DAE495142@PAYP264MB3440.FRAP264.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/2/25 08:07, Torrelli, Maxime wrote:
> Hello dear MMC community,
> 
> I hope my request does not break any rule regarding this mailing list and its use. If it does, please let me know how to proceed.

It doesn't.

> 
> We recently tried to migrate from kernel v5.10 to v6.6. During this migration we discovered that a partition stored in an eMMC boot disk was not visible anymore from the system (i.e. /dev/mmcblk2boot0p1 does not exist).
> 
> Please find below the detailed list of block disks of the eMMC:
>     * brw-rw---- 1 root disk 179,  0 Oct 10 17:41 /dev/mmcblk2
>     * brw-rw---- 1 root disk 179,  8 Oct 10 17:40 /dev/mmcblk2boot0
>     * brw-rw---- 1 root disk 179, 16 Oct 10 17:40 /dev/mmcblk2boot1
>     * brw-rw---- 1 root disk 179, 24 Oct 10 17:40 /dev/mmcblk2gp0
>     * brw-rw---- 1 root disk 179, 25 Oct 10 17:41 /dev/mmcblk2gp0p1
>     * brw-rw---- 1 root disk 179, 32 Oct 10 17:40 /dev/mmcblk2gp1
>     * brw-rw---- 1 root disk 179, 33 Oct 10 17:41 /dev/mmcblk2gp1p1
>     * brw-rw---- 1 root disk 179,  1 Oct 10 17:41 /dev/mmcblk2p1
>     * brw-rw---- 1 root disk 179,  2 Oct 10 17:41 /dev/mmcblk2p2
>     * crw------- 1 root root 243,  0 Oct 10 17:41 /dev/mmcblk2rpmb
> 
> After analysis, we discovered the reason. When the version v6.1.53 was released, a change in file block/ioctl.c added the following lines to the function "blkpg_do_ioctl":
>       > + if (disk->flags & GENHD_FL_NO_PART)
>       > +      return -EINVAL;
> This check was then moved to block/partitions/core.c when v6.1.76 was released. This change added the following lines in the function "bdev_add_partition" are :
>       > + if (disk->flags & GENHD_FL_NO_PART) {
>       > +      ret = -EINVAL;
>       > +      goto out;
>       > + }

Seems to only be consistent now with the definition of GENHD_FL_NO_PART. Your real issue is
commit f5b4d71f72c5 ("mmc: card: Prevent partition scan for the eMMC boot areas")

> 
> With kernel v5.10 the partition /dev/mmcblk2boot0p1 was not visible at boot but a simple call to "partx -a /dev/mmcblk2boot0" allowed us to access this partition. With kernel v6.1.53 and above, "partx -a /dev/mmcblk2boot0" fails and we cannot access the partition.
> 
> What is the reason for this change ?
> 
> Is there any rule forbidding to create a partition in an eMMC boot block disk ?

It was just deemed unlikely to be useful since most systems use eMMC boot partition
feature very early in the boot process to read blobs essentially.

What does yours do?

If you know the offset the partition is at you can pass that to mount.
