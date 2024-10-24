Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9208F1D63CB
	for <linux-mmc@vger.kernel.org>; Thu, 24 Oct 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729774663; cv=none; b=azLENLDzJRC1dZuLQN64he4onlm8w/3rmwJ+Qm/gtwUoDs63mDxOxH5fBQMENq3hxb3fQ3I1iioKV0VY3Fs7IPdoWNzIjcuZ7JEy2XkhW18UYTbLUTDE2bghGYa77n43U2WSR4T8R/GCQ8WR7xWsTtkuv//yurTykNiCtpOSGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729774663; c=relaxed/simple;
	bh=cQyhfsSc+QXVdTgShDspXvyHPJOSEjQo4rAUnpwMl4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0axCDU7bvF5NtG+7hVOrWp6DizIk/lSX85KgjJ9z8vmUdIS1E36Foh8JLC5UwS1At8tJXyYfTEnHd8xHF4Q2ht86WNwwuBghxlr/Zh9+s1OsZyREp89hIZ5zpmWOXLlXF/E5TE7e8xDzkblEbxbjMszmdA3omv3eeKQFxr+lNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=afIAjaWu; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afIAjaWu"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e5b7cd1ef5so8812437b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 24 Oct 2024 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729774660; x=1730379460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5vBhWSYNa611sIJg62H3My9cs8KLwfQc2KO3oXMo6UY=;
        b=afIAjaWuJq+WJIbHJrPuLP+k5iY2ifSmFdQ2T9uuiPBQVZizsWbxqcjCi0FsTQvhbz
         lQx1cQI2PmgOqeBimgDo1lwm5yedH48bJgwQDrPs6+w0dX2lx39kpjmNccOEVPRUWCRu
         aRcqKPMTWd6OmnP9aEf0BM/aP8pZHwXCGJ743FtJFCUZxmjlLJStMn5JwfEAEj/LKEsc
         QZVLjDDOqZ9+QlZVSxbXgqAAbl6QTQJLpOvcCvyU8gdDS141VgkGvY7evyjRDNtuWXE+
         J5eUgMvu+eATmvhMjXy+sVEPbKdaueitjOvR24WnWGXWHM9q2MmIvBj+CBU7JyYmv02d
         YSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729774660; x=1730379460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vBhWSYNa611sIJg62H3My9cs8KLwfQc2KO3oXMo6UY=;
        b=R+6gR6p3WgiEHjQH9KZiUUEI6AICs6U1VRotudQHNubtZl3I71tmKOeHvhBTIYspUd
         Zd5vzBa38tgWTmSMVn07TRolJaeGNpwq5Gqrh6coVyKxbwT6xFwbWj0VTTc74NT29fko
         9YYxEBmx+kScQqRvOJHzrHSplT1P1Q+9Pnym0RZO0m5Xz4bOR+rl3oTZUyQXBMC3cms2
         2NG8gnKyMHcKSRbr9YygRRwQMTaAbjGzrAxV0VP+U3ImUInNIYL5ADEFJ+E/0JIUZ7fL
         77Uh+1ThzUwSyyk2uBP48jc8rOINxeqZDPscbvc5fzwtkRaD9+tmQ9LxSzE/HEpWiN1z
         iShQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtkbMyHnLUKvgpEeqysjVh/eGzc6tLfKZMdTvGtN+h1W9ik6YXh4GWm0UkUghRVTlN08T87bVgeuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAIf8WHo0tfhDxnWUkLENXpMa7ETfOaQk07RBI91SqyyeoQgqN
	37WOcJTOtEGB5k1oeInF8AjskPC4LHchj5SAhwpOxzgqn9pgrSv3S2E1aMd++879I4pujnY3NVF
	I0x2pCTh+2Jt49PMUVOCYZ35dpJVV78w3od1z+g==
X-Google-Smtp-Source: AGHT+IE7NVTYCzyATqQRLTCNICXhJNdunQUxsnGa+DMBXRcbGXUcfSCZyt6G3MVbWQ4oA3XsK/sRUnX0SDF3ytvz/K4=
X-Received: by 2002:a05:690c:39c:b0:6e2:f32:bd2c with SMTP id
 00721157ae682-6e86630c0bcmr17865107b3.29.1729774660388; Thu, 24 Oct 2024
 05:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105333.4569-1-victorshihgli@gmail.com>
In-Reply-To: <20241018105333.4569-1-victorshihgli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 24 Oct 2024 14:57:04 +0200
Message-ID: <CAPDyKFrgwmPaAnv3CgH=rL9yV4JfbF9mX6nt+Wy=2OUphadZJQ@mail.gmail.com>
Subject: Re: [PATCH V23 00/16] Add support UHS-II for GL9755 and GL9767
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 12:53, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Summary
> =======
> These patches[1] support UHS-II and fix GL9755 and GL9767
> UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
>   Sequence[2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
>   [2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
>   Setting Register Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy
>   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.1
>   Packet Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> ===============
> patch#1:     for core
> patch#2-#14: for sdhci
> patch#15:    for GL9755
> patch#16:    for GL9767
>
> Tests
> =====
> Ran 'dd' command to evaluate the performance 3 times:
> (SanDisk UHS-II card on GL9755 controller)
>                              Read    Write
> UHS-II disabled (UHS-I): 81.9MB/s 51.4MB/s
> UHS-II enabled         :  206MB/s 80.5MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 82.3MB/s 49.7MB/s
> UHS-II enabled         :  208MB/s 80.8MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 82.9MB/s 50.8MB/s
> UHS-II enabled         :  205MB/s 90.0MB/s
> (SanDisk UHS-II card on GL9767 controller)
>                              Read    Write
> UHS-II disabled (UHS-I): 83.5MB/s 50.5MB/s
> UHS-II enabled         :  200MB/s 75.3MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 85.2MB/s 56.3MB/s
> UHS-II enabled         :  203MB/s 75.8MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 82.9MB/s 51.1MB/s
> UHS-II enabled         :  196MB/s 77.8MB/s
>
> Test command
> =====
> Read: dd if=/dev/mmcxxx of=/dev/null bs=4096k count=2000 iflag=direct
> Write:dd if=/dev/zero of=/dev/mmcxxx bs=4096k count=2000 oflag=direct
>
> Changes in v23 (October. 18, 2024)
> * Rebase on latest mmc/next.
> * Version 22 patch#1-patch#6 have already been applied to the mmc/next
>   branch, so the patch order for version 23 has been shifted forward.
> * Patch#1: Remove mmc_uhs2_card_prepare_cmd() function.
>            Remove mmc_sd_can_poweroff_notify() function.
>            Modify ios.timing setting in the sd_uhs2_power_off() function.
>            Restore the position of assign the host->card to original
>            position in the sd_uhs2_init_card() function.
>            Remove unnecessary error handle in the sd_uhs2_init_card()
>            function.
>            Add oldcard judgment to skip some programs in the
>            sd_uhs2_legacy_init() function.
>            Remove unnecessary error handle in the sd_uhs2_legacy_init()
>            function.
>            Remove mmc_card_set_present() function in the
>            sd_uhs2_reinit()function.

I have queued this up for next, with a few amendments and added
Adrian's acks to the SDHCI patches.

When applying, I made a couple of cleanups and fixed
sd_uhs2_power_off() to patch 1. I also took care of the checkpatch
warnings for the SDHCI patches.

That said, there are still some issues that remain to be fixed, but
let's do that on top of the $subject series. See below:

*) The error/re-init path of the card is broken, as also pointed out
by Adrian. I will work on this shortly and send patches to fix this
up, please help to review and test.
*) We should read the card's ext registers, to for example enable the
card's internal cache to be used.
*) We should avoid unnecessary commands during re-init of the card, to
decrease latency.
*) During suspend, we should probably send the go-dormant command with
the hibernate bit, rather than just doing a plain power-off.

[...]

Thanks and kind regards
Uffe
