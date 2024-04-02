Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7DA78676
	for <linux-mmc@vger.kernel.org>; Tue,  2 Apr 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055467; cv=none; b=ZxNQQPkXGxFF2ttsMv0yS9OzvYxFpiiWc7kc79z+nJw8oKxn8gW9SEGbroAXmZamoOPWmkm06/nUfROnmOL9nzSLe+9r1LXbqY+1R7kcL009aeqq+8nXrgmGuUqefryT+kuUABYNzMS8X3RsAVLrBr7OBDkRN6yHMAjW1UJ9SpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055467; c=relaxed/simple;
	bh=MoUrPKF4mT+ZIjapolm/OCQrFTK7WPovqRRSlPWDuys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCTr0CZ9cLF3iOtMOwIgyVi66YplCtAdin4fJ0QUWIRr+/Qh5Zh7V5gAfy3ecGhqLqyg4oSXcxMWk9IrnQeCzBNE7BnYFoVFH7gRWgdqZcu/Sag31MTW/RNSM+XMnwTSNKUBpX/cNGY5NGfuFjeaGOXklT+yYw+UzwRRA0kX0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pB/6zwjl; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pB/6zwjl"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6153d85053aso1158827b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 02 Apr 2024 03:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712055463; x=1712660263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c+bH1dcjs6zDVZ1ImLFhp01I2B4zDMhqEFRoX+MCErg=;
        b=pB/6zwjlGT1tMOmyq6oWjfdsbzgKuVqxNqphkE8Ix9MDS/rMOK4UdfdEQbNTbJv/yX
         Hj2S+2EhLBn1mdaWbz4h/8XrX9j/cH3MBYlYTADfmOtUIvJX+4RdMFia7GNB+yy8i/VM
         2yzGWJ5VmsOUzhAp0oD0EmVBPRXnSVbSaROIx66DldUWH07OQ74P2q1/YFJ9/xvNoqrf
         FlpbKtBfuBH8pIWeD8T+ykK6Zm5qwWmOL3su1bsAIs7GxvILhxq6/7MIbzOOWHv0jsdG
         phO+AWiPmgq5MwNNPbPgDvFiBSjwwVm82Kzl7jC2k8bJC/MR3t4SHYjj8+S0dguQZdpj
         1WiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055463; x=1712660263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+bH1dcjs6zDVZ1ImLFhp01I2B4zDMhqEFRoX+MCErg=;
        b=ijY1BnBsgM+bZ0b2OhkhLTK9QJyCWzqhcsZLdwh1APZbE3oagpUWI0OhzOjXARx4uU
         2O77yGEUtMQHhnEXx+kC5q26+aIdX97LY5qqD4qneLPWNbcWGgc6J3CBI8OEu6TCNwWg
         zswTndW4tu6ubH9wBh8dSLUXI8TZQeg5kOCS44GjUTW8D+snWYI0cR7liPZ4UmVLREUc
         he2246kdkBPUn9CBrxCsprm2pKP6QChpFuMwBd6GHnAYsB2iV6cxqJzmOTkDUiHGRfa5
         lou9h4VVOiagSB6C9QtiERUqYn98EnrfGUILUM7F38kxQw8dIGoPP1m0bLEZSs5fn29O
         c2nQ==
X-Gm-Message-State: AOJu0YwavX9RborDQMkUBwioR1gsb2hl5aNFEnc5vqaNqrKpZUXPICfX
	LjYo9Jx6nM2OZLOPhaZoQt/N9uCBq6cBJyJGCNqKTLCc+vSwY2vvvxXwXzT3FNTifo8yUa+4uhQ
	8XFHBz8iQPnbNKpeNs5cFbrMtZqSBMkZ2pk1vQGjugZsCF4a2
X-Google-Smtp-Source: AGHT+IE/WD+y67NutlzWsjb1SjGUE/jcIigt/4dfgy8gOQu7jaQ82mg1Kr4nW/JrRWpythMVdxYQ5Gupa34+RSOKXLw=
X-Received: by 2002:a0d:e784:0:b0:608:dc99:b217 with SMTP id
 q126-20020a0de784000000b00608dc99b217mr10641192ywe.50.1712055462367; Tue, 02
 Apr 2024 03:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329072839.1400-1-avri.altman@wdc.com>
In-Reply-To: <20240329072839.1400-1-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Apr 2024 12:57:06 +0200
Message-ID: <CAPDyKFrtwt3MH_JuF3VA=aNyKM=wtnngqwa1Zn=uDSJQ_si9qg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc-utils: man 1 mmc-utils
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 at 08:28, Avri Altman <avri.altman@wdc.com> wrote:
>
> I have put together a draft man page for mmc-utils.  The contents are
> from mmc-utils help documents and edited for brevity.  The point is not
> to replace the existing docmentation, but to serve as a quick reference.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>
> Changelog:
> v2->v3: Fix some more spelling mistakes
>
> v1->v2: Fix some spelling mistakes
> ---
>  Makefile |   9 +-
>  mmc.1    | 308 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 312 insertions(+), 5 deletions(-)
>  create mode 100644 mmc.1
>
> diff --git a/Makefile b/Makefile
> index 10b78ab..a890833 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -21,6 +21,7 @@ prefix ?= /usr/local
>  bindir = $(prefix)/bin
>  LIBS=
>  RESTORE_LIBS=
> +mandir = /usr/share/man
>
>  progs = mmc
>
> @@ -29,7 +30,7 @@ ifdef C
>         check = sparse $(CHECKFLAGS)
>  endif
>
> -all: $(progs) manpages
> +all: $(progs)
>
>  .c.o:
>  ifdef C
> @@ -43,16 +44,14 @@ mmc: $(objects)
>  manpages:
>         $(MAKE) -C man
>
> -install-man:
> -       $(MAKE) -C man install
> -
>  clean:
>         rm -f $(progs) $(objects)
>         $(MAKE) -C man clean
>
> -install: $(progs) install-man
> +install: $(progs)
>         $(INSTALL) -m755 -d $(DESTDIR)$(bindir)
>         $(INSTALL) $(progs) $(DESTDIR)$(bindir)
> +       $(INSTALL) -m 644 mmc.1 $(DESTDIR)$(mandir)/man1
>
>  -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
>
> diff --git a/mmc.1 b/mmc.1
> new file mode 100644
> index 0000000..e153557
> --- /dev/null
> +++ b/mmc.1
> @@ -0,0 +1,308 @@
> +.TH mmc\-utils 1 "April 2024" "User Manual"
> +.SH NAME
> +mmc \-  a tool for configuring MMC storage devices
> +.SH SYNOPSIS
> +.B mmc
> +[\fIoptions\fR] [\ mmc\-block\-device\fR]...
> +.SH DESCRIPTION
> +.B mmc-utils
> +is a single-threaded tool that will perform a specified type of mmc action as specified by the user.
> +.br
> +The typical use of mmc-utils is to access the mmc device either for configuring or reading its configuration registers.
> +.SH OPTIONS
> +.TP
> +.BI extcsd " " read " " \fIdevice\fR
> +Read and prints the extended csd register
> +.TP
> +.BI extcsd " " write " " \fIoffset\fR " " \fIvalue\fR " " \fIdevice\fR
> +Write \fIvalue\fR at \fIoffset\fR to the device's extcsd
> +.TP
> +.BI writeprotect " " boot " " get " " \fIdevice\fR
> +Print the boot partitions write protect status
> +.TP
> +.BI writeprotect " " boot " " set " " \fIdevice\fR " " [\fInumber\fR]
> +Set the boot partition write protect status for the device.
> +.br
> +If \fInumber\fR is passed (0 or 1), only protect that specified eMMC boot partition, otherwise protect both.
> +.br
> +It will be write-protected until the next boot.
> +.TP
> +.BI writeprotect " " user " " set " " \fItype\fR " " \fIstart\-block\fR " " \fIblocks\fR " " \fIdevice\fR
> +Set the write protect configuration for the specified region of the user area for the device.
> +.br
> +\fIstart\-block\fR specifies the first block of the protected area.
> +.br
> +\fIblocks\fR specifies the size of the protected area in blocks.
> +.br
> +NOTE! The area must start and end on Write Protect Group boundaries, Use the "writeprotect user get" command to get the Write Protect Group size.
> + \fItype\fR is one of the following:
> +.RS
> +.RS
> +.TP
> +.B none
> +Clear temporary write protection.
> +.TP
> +.B temp
> +Set temporary write protection.
> +.TP
> +.B pwron
> +Set write protection until the next power on.
> +.RE
> +.RE
> +.TP
> +.BI writeprotect " " user " " get " " \fIdevice\fR
> +Print the user area's write protect configuration for the device.
> +.TP
> +.BI disable " " 512B " " emulation " " \fIdevice\fR
> +Set the eMMC data sector size to 4KB by disabling emulation on the device.
> +.TP
> +.BI gp " " create " " \fIdry\-run\fR " " \fIlength\-KiB\fR " " \fIpartition\fR  " " \fIenh\-attr\fR " " \fIext\-attr\fR " " \fIdevice\fR
> +Create general purpose partition for the device.
> +.br
> +NOTE!  This is a one-time programmable (irreversible) change.
> +.br
> +To set enhanced attribute to general partition being created set \fIenh\-attr\fR to 1 else set it to 0.
> +.br
> +To set extended attribute to general partition set \fIenh\-attr\fR to 1,2 else set it to 0.
> +.br
> +\fIdry\-run\fR is one of the following:
> +.RS
> +.RS
> +.TP
> +.B \-y
> +PARTITION_SETTING_COMPLETED in the extcsd will get set and the partitioning operation will take effect and be finalized.
> +.TP
> +.B \-c
> +more partitioning settings are still to come - partitioning operation will not take effect.
> +.TP
> +.B otherwise
> +These changes will not take effect neither now nor after a power cycle.
> +.RE
> +.RE
> +.TP
> +.BI enh_area " " set " " \fIdry\-run\fR " " \fIstart\-KiB\fR " " \fIlength\-KiB\fR " " \fIdevice\fR
> +Enable the enhanced user area for the device.
> +.br
> +NOTE!  This is a one-time programmable (irreversible) change.
> +\fIdry\-run\fR is as above.
> +.TP
> +.BI write_reliability " " set " " " \fIdry\-run\fR " " \fIpartition\fR " " \fIdevice\fR
> +Enable write reliability per partition for the device.
> +.br
> +NOTE!  This is a one-time programmable (irreversible) change.
> +\fIdry\-run\fR is as above.
> +.TP
> +.BI status " " get " " \fIdevice\fR
> +Print the response to STATUS_SEND (CMD13).
> +.TP
> +.BI bootpart " " enable " " \fIboot\-partition\fR " " \fIsend\-ackn\fR " " \fIdevice\fR
> +Enable the boot partition for the device.
> +Disable the boot partition for the device if is \fIboot\-partition\fR set to 0.
> +.br
> +To receive acknowledgment of boot from the card set \fIsend\-ackn\fR to 1, else set it to 0.
> +.TP
> +.BI bootbus " " set " " \fIboot\-mode\fR " " \fIreset\-boot\-bus\-conditions\fR " " \fIboot\-bus\-width\fR " " \fIdevice\fR
> +Set Boot Bus Conditions.
> +.br
> +\fIboot\-mode\fR is one of the following: single_backward, single_hs, or dual.
> +.br
> +\fIreset\-boot\-bus\-conditions\fR is one of the following: x1 or retain.
> +.br
> +\fIboot\-bus\-width\fR is one of the following: x1, x4, or x8.
> +.TP
> +.BI bkops_en " " \fImode\fR " " \fIdevice\fR
> +Enable the eMMC BKOPS feature on the device.
> +The auto (AUTO_EN) setting is only supported on eMMC 5.0 or newer.
> +.br
> +NOTE!  Setting manual (MANUAL_EN) is one-time programmable (irreversible) change.
> +.br
> +\fImode\fR is one of the following:
> +.RS
> +.RS
> +.TP
> +.B auto
> +Auto bkops is set
> +.TP
> +.B manual
> +Manual bkops is set
> +.RE
> +.RE
> +.TP
> +.BI hwreset " " enable " " \fIdevice\fR
> +Permanently enable the eMMC H/W Reset feature on the device.
> +.br
> +NOTE!  This is a one-time programmable (irreversible) change.
> +.TP
> +.BI hwreset " " disable " " \fIdevice\fR
> +Permanently disable the eMMC H/W Reset feature on the device.
> +.br
> +NOTE!  This is a one-time programmable (irreversible) change.
> +.TP
> +.BI sanitize " " \fIdevice\fR " " \fI[timeout_ms]\fR
> +Send Sanitize command to the device.
> +This will delete the unmapped memory region of the device.
> +.TP
> +.BI rpmb " " write\-key " " \fIrpmb\-device\fR " " \fIkey\-file\fR
> +Program authentication key which is 32 bytes length and stored in the specified file.
> +.br
> +Also you can specify '-' instead of key file path to read the key from stdin.
> +.br
> +NOTE!  This is a one-time programmable (irreversible) change.
> +.TP
> +.BI rpmb " " read\-counter " " \fIrpmb\-device\fR
> +Counter value for the \fIrpmb\-device\fR will be read to stdout.
> +.TP
> +.BI rpmb " " read\-block " " \fIrpmb\-device\fR " " \fIaddress\fR " " \fIblocks-\count\fR " " \fIoutput-\file\fR " " [\fIkey\-file\fR]
> +Blocks of 256 bytes will be read from \fIrpmb\-device\fR to output
> +file or stdout if '-' is specified. If key is specified - read
> +data will be verified.
> +.TP
> +.BI rpmb " " write\-block " " \fIrpmb\-device\fR " " \fIaddress\fR " "  \fI256\-byte\-data\-file\fR " " \fIkey\-file\fR
> +Block of 256 bytes will be written from data file to
> +\fIrpmb\-device\fR.
> +.br
> +Also you can specify '-' instead of key file path or data file to read the data from stdin.
> +.TP
> +.BI cache " " enable " " \fIdevice\fR
> +Enable the eMMC cache feature on the device.
> +.br
> +NOTE! The cache is an optional feature on devices >= eMMC4.5.
> +.TP
> +.BI cache " " disable " " \fIdevice\fR
> +Disable the eMMC cache feature on the device.
> +.br
> +NOTE! The cache is an optional feature on devices >= eMMC4.5.
> +.TP
> +.BI csd " " read " " \fidevice\-path\fR
> +Print CSD data from \fIdevice\-path\fR.
> +The device path should specify the csd sysfs file directory.
> +.TP
> +.BI cid " " read " " \fIdevice\-path\fR
> +Print CID data from \fIdevice\-path\fR.
> +The device path should specify the cid sysfs file directory.
> +.TP
> +.BI scr " " read " " \fIdevice\-path\fR
> +Print SCR data from \fIdevice\-path\fR.
> +The device path should specify the scr sysfs file directory.
> +.TP
> +.BI ffu " " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
> +Run Field Firmware Update with \fIimage\-file\-name\fR on the device.
> +.br
> +[\fIchunk\-bytes\fR] is optional and defaults to its max - 512k. should be in decimal bytes and sector aligned.
> +.br
> +if [\fIchunk\-bytes\fR] is omitted, mmc-utils will try to run ffu using the largest possible chunks: max(image-file, 512k).
> +.TP
> +.BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
> +Send Erase CMD38 with specific argument to the device.
> +.br
> +NOTE!: This will delete all user data in the specified region of the device.
> +.br
> +\fItype\fR is one of the following: legacy, discard, secure-erase, secure-trim1, secure-trim2, or trim.
> +.TP
> +.BI gen_cmd " " read " \fidevice\fR [\fIarg\fR]
> +Send GEN_CMD (CMD56) to read vendor-specific format/meaning data from the device.
> +.br
> +NOTE!: [\fIarg\fR] is optional and defaults to 0x1. If [\fIarg\fR] is specified, then [\fIarg\fR]
> +must be a 32-bit hexadecimal number, prefixed with 0x/0X. And bit0 in [\fIarg\fR] must be 1.
> +Normally this command is aimed to extract a device-health info from the device.
> +.TP
> +.BI softreset " " \fIdevice\fR
> +Issues a CMD0 softreset, e.g. for testing if hardware reset for UHS works
> +.TP
> +.BI boot_operation " " \fIboot\-data\-file\fR " " \fIdevice\fR
> + Does the alternative boot operation and writes the specified starting blocks of boot data into the requested file.
> +Note some limitations:
> +.RS
> +.RS
> +.TP
> +.B 1)
> +The boot operation must be configured first, e.g. via bootbus and/or bootpart commands
> +.TP
> +.B 2)
> +The MMC must currently be running at the bus mode that is configured for the boot operation (HS200 and HS400 not supported at all).
> +.TP
> +.B 3)
> +Only up to 512K bytes of boot data will be transferred.
> +.TP
> +.B 4)
> +The MMC will perform a soft reset, if your system cannot handle that do not use the boot operation from mmc-utils.
> +.RE
> +.RE
> +.TP
> +.BI \-\-help " " | " " help " " | " " \-h
> +Show the help
> +.TP
> +.BI \fIcmd\fR " " \-\-help
> +Show detailed help for that specific \fIcmd\fR or subset of commands.
> +.SH "RPMB COMMANDS"
> +The RPMB partition on the eMMC devices is a special area used for storing cryptographically safe information signed by a
> +special secret key.
> +.br
> +To write and read records from this special area, authentication is needed.
> +.br
> +The RPMB area is *only* and *exclusively* accessed using ioctl()s from user-space.
> +.br
> +RPMB commands are send using the mmc multi-ioctl, thus ensures that the atomic nature of the rpmb access operation.
> +.br
> +The rpmb device given as a parameter to the rpmb commands is not a block device but a char device.
> +.br
> +This was done to help the mmc driver to account for some of the rpmb peculiarities.
> +.SH "EXAMPLES"
> +.RE
> +.P
> +.B RPMB examples
> +.RS
> +Program rpmb key using the stdin option:
> +.RS
> +.P
> +$ echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | mmc rpmb write-key /dev/mmcblk0rpmb -
> +.RE
> +.P
> +Read 2 blocks starting address 2 and output the received content to stdout. Verify the received frames using the key (not mandatory):
> +.RS
> +.P
> +$ echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | mmc rpmb read-block /dev/mmcblk0rpmb 0x02 2 -
> +.RE
> +.P
> +Read 2 blocks without verification starting address 2 and output the received content to /tmp/block:
> +.RS
> +.P
> +$mmc rpmb read-block /dev/mmcblk0rpmb 0x02 2 /tmp/block
> +.RE
> +.P
> +Write a string of 'a's to address 2. both the input and key uses stdin interface:
> +.RS
> +.P
> +$ (awk 'BEGIN {while (c++<256) printf "a"}' | echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH) | mmc rpmb write-block /dev/mmcblk0rpmb 0x02 - -
> +.RE
> +.P
> +.RE
> +.P
> +.B Field Firmware Update (ffu) examples
> +.RS
> +Do ffu using max-possible chunk size:  If the fluf size < 512k, it will be flushed in a single write sequence.
> +.RS
> +.P
> +$ mmc ffu IO4e0aC2056001801M1100042AE1.fluf /dev/mmcblk0
> +.RE
> +.P
> +Same as above, this time use a 4k chunks:
> +.RS
> +.P
> +$ mmc ffu IO4e0aC2056001801M1100042AE1.fluf /dev/mmcblk0 4096
> +.RE
> +.P
> +.RE
> +.SH AUTHORS
> +.B mmc-utils
> +was written by Chris Ball <cjb@laptop.org> and <chris@printf.net>.
> +.br
> +It is currently maintained by Ulf Hansson <ulf.hansson@linaro.org>.
> +.SH "REPORTING BUGS"
> +Report bugs to the \fBmmc\fR mailing list <linux-mmc@vger.kernel.org>.
> +.SH "SEE ALSO"
> +For further documentation see \fBREADME\fR.
> +.br
> +A short intro - https://docs.kernel.org/driver-api/mmc/mmc-tools.html
> +.br
> +official git tree - https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
> --
> 2.42.0
>
