From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 09/12] mmc: sdhci-xenon: add initial Xenon eMMC driver
Date: Thu, 09 Jun 2016 16:33:50 +0200
Message-ID: <87vb1imnxt.fsf@free-electrons.com>
References: <201606092116.RFdPDzjC%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:57800 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751979AbcFIOdx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2016 10:33:53 -0400
In-Reply-To: <201606092116.RFdPDzjC%fengguang.wu@intel.com> (kbuild test
	robot's message of "Thu, 9 Jun 2016 21:45:59 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Romain Perier <romain.perier@free-electrons.com>, Omri Itach <omrii@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Shadi Ammouri <shadi@marvell.com>

Hi ,
 
 On jeu., juin 09 2016, kbuild test robot <lkp@intel.com> wrote:

> Hi,
>
> [auto build test ERROR on ulf.hansson-mmc/next]
> [also build test ERROR on v4.7-rc2 next-20160609]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Gregory-CLEMENT/Add-SDHCI-Xenon-driver/20160609-151403
> base:   https://git.linaro.org/people/ulf.hansson/mmc next
> config: ia64-allyesconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 4.9.0
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=ia64 
>
> All errors (new ones prefixed by >>):
>
>    In file included from drivers/mmc/host/sdhci-xenon.c:14:0:
>>> arch/ia64/include/uapi/asm/setup.h:7:2: error: unknown type name '__u64'
>      __u64 command_line;  /* physical address of command line arguments */
>      ^
>    arch/ia64/include/uapi/asm/setup.h:8:2: error: unknown type name '__u64'
>      __u64 efi_systab;  /* physical address of EFI system table */
>      ^
>    arch/ia64/include/uapi/asm/setup.h:9:2: error: unknown type name '__u64'
>      __u64 efi_memmap;  /* physical address of EFI memory map */
>      ^
>    arch/ia64/include/uapi/asm/setup.h:10:2: error: unknown type name '__u64'
>      __u64 efi_memmap_size;  /* size of EFI memory map */
>      ^
>    arch/ia64/include/uapi/asm/setup.h:11:2: error: unknown type name '__u64'
>      __u64 efi_memdesc_size;  /* size of an EFI memory map descriptor */
>      ^
>>> arch/ia64/include/uapi/asm/setup.h:12:2: error: unknown type name '__u32'
>      __u32 efi_memdesc_version; /* memory descriptor version */
>      ^
>>> arch/ia64/include/uapi/asm/setup.h:14:3: error: unknown type name '__u16'
>       __u16 num_cols; /* number of columns on console output device */
>       ^
>    arch/ia64/include/uapi/asm/setup.h:15:3: error: unknown type name '__u16'
>       __u16 num_rows; /* number of rows on console output device */
>       ^
>    arch/ia64/include/uapi/asm/setup.h:16:3: error: unknown type name '__u16'
>       __u16 orig_x; /* cursor's x position */
>       ^
>    arch/ia64/include/uapi/asm/setup.h:17:3: error: unknown type name '__u16'
>       __u16 orig_y; /* cursor's y position */
>       ^
>    arch/ia64/include/uapi/asm/setup.h:19:2: error: unknown type name '__u64'
>      __u64 fpswa;  /* physical address of the fpswa interface */
>      ^
>    arch/ia64/include/uapi/asm/setup.h:20:2: error: unknown type name '__u64'
>      __u64 initrd_start;
>      ^
>    arch/ia64/include/uapi/asm/setup.h:21:2: error: unknown type name '__u64'
>      __u64 initrd_size;
>      ^
>
> vim +/__u64 +7 arch/ia64/include/uapi/asm/setup.h

it seems that including asm/setup.h was a left over and was not needed,
so I remove it.

Gregory

>
> ^1da177e include/asm-ia64/setup.h      Linus Torvalds 2005-04-16   1  #ifndef __IA64_SETUP_H
> ^1da177e include/asm-ia64/setup.h      Linus Torvalds 2005-04-16   2  #define __IA64_SETUP_H
> ^1da177e include/asm-ia64/setup.h      Linus Torvalds 2005-04-16   3  
> cca97de1 include/asm-ia64/setup.h      Alon Bar-Lev   2007-02-12   4  #define COMMAND_LINE_SIZE	2048
> ^1da177e include/asm-ia64/setup.h      Linus Torvalds 2005-04-16   5  
> c140d879 arch/ia64/include/asm/setup.h David Howells  2012-03-28   6  extern struct ia64_boot_param {
> c140d879 arch/ia64/include/asm/setup.h David Howells  2012-03-28  @7  	__u64 command_line;		/* physical address of command line arguments */
> c140d879 arch/ia64/include/asm/setup.h David Howells  2012-03-28   8  	__u64 efi_systab;		/* physical address of EFI system table */
> c140d879 arch/ia64/include/asm/setup.h David Howells  2012-03-28  @9  	__u64 efi_memmap;		/* physical address of EFI memory map */
> c140d879 arch/ia64/include/asm/setup.h David Howells  2012-03-28 @10  	__u64 efi_memmap_size;		/* size of EFI memory map */
> c140d879 arch/ia64/include/asm/setup.h David Howells  2012-03-28  11  	__u64 efi_memdesc_size;		/* size of an EFI memory map descriptor */
> c140d879 arch/ia64/include/asm/setup.h David Howells  2012-03-28 @12  	__u32 efi_memdesc_version;	/* memory descriptor version */
> c140d879 arch/ia64/include/asm/setup.h David Howells  2012-03-28  13  	struct {
> c140d879 arch/ia64/include/asm/setup.h David Howells  2012-03-28 @14  		__u16 num_cols;	/* number of columns on console output device */
> c140d879 arch/ia64/include/asm/setup.h David Howells  2012-03-28  15  		__u16 num_rows;	/* number of rows on console output device */
> c140d879 arch/ia64/include/asm/setup.h David Howells  2012-03-28  16  		__u16 orig_x;	/* cursor's x position */
> c140d879 arch/ia64/include/asm/setup.h David Howells  2012-03-28  17  		__u16 orig_y;	/* cursor's y position */
>
> :::::: The code at line 7 was first introduced by commit
> :::::: c140d87995b68b428f70635c2e4071e4e8b3256e Disintegrate asm/system.h for IA64
>
> :::::: TO: David Howells <dhowells@redhat.com>
> :::::: CC: David Howells <dhowells@redhat.com>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
