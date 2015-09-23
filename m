From: Grant Grundler <grundler@chromium.org>
Subject: RFC: 32-bit __data_len and REQ_DISCARD+REQ_SECURE
Date: Tue, 22 Sep 2015 18:54:19 -0700
Message-ID: <CANEJEGvXfg4O6KWBcQe4=o0ZxjehgGTBMBxNddanprBXQbr-Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33069 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbbIWByU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2015 21:54:20 -0400
Received: by ykft14 with SMTP id t14so28567030ykf.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Sep 2015 18:54:20 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Jens, Ulf,

I've run into a basic issue: BLK_SECDISCARD takes 15-35 minutes
perform a secure erase of ~23GB (mostly empty) partition on a 32GB
eMMC part (happens with two vendors). One of the vendors says it
should take less than 60 seconds. I've confirmed erasing 2GB takes
only ~6 seconds - so the vendor estimate seems reasonable.

I'm looking for (a) advice on better v3.18 solutions and (b) start
discuss future solutions for upstream kernel.

Two problems:
1) 3.18 kernel block layer wants to split up the transaction into
"max_discard_sectors" chunks. This would be fine if
max_discard_sectors was more than one or two erase groups (EG). For
one of the eMMC parts, EG size is 512KB and thus the kernel sends
46,000 commands (DISCARD w/SECURE_ERASE arg) to the eMMC device. At
the bottom I discuss why this is such a bad idea for SECURE_ERASE.

My hack to fix (1): ignore max_discard_sectors for SECURE_ERASE
(BLK_SECDISCARD):
    https://chromium-review.googlesource.com/#/c/301460/

I'm trying to recover the 9 bits that blk_rq_sectors() discards and
don't care sub-512byte block offsets.


2) Unfortunately, with the above hack, the block layer is truncating
the request to 2GB. :( Turns out several fields in the block layer are
32-bit. Notably:
    struct request.__data_len
    struct bvec_iter.bi_size
    struct bio_vec.bv_len

This is despite ioctl(BLK_SECDISCARD) having a 64-bit API to pass in
"number of bytes to erase" and the emmc spec allowing 32-bits to
specify the LBA. I looked at changing the above data structures (which
normally only need  20-bits or so) to 64-bit and it's a systemic
change. "Non-trivial" doesn't even begin to describe the scope here.

So I have an even worse hack to use 9 "zero" bits here (and this works
for 3.18 - not sure it would for 4.x kernels):
    https://chromium-review.googlesource.com/#/c/301349

9-bits gives me a bit of time until eMMC devices are > 1TB in
capacity. Maybe a few more months. :)


Last code change: I'm also not sure I need to set MMC_CAP2_HC_ERASE_SZ
but I do in this 3rd patch:
   https://chromium-review.googlesource.com/#/c/301461

sdhci-acpi and sdhci-pci drivers already do this. I didn't see an
obvious place to set this for the sdhci-tegra variant or what that
code is required to do/support when setting HC_ERASE_SZ capability.



--- Why is splitting up BLK_SECDISCARD such a bad idea? ----
Command overhead in the degenerate case is bad and probably causing
the majority of the performance loss here. I'm assuming the device can
issue lots of erase transaction in parallel. Thus sending a secure
erase command for each erase group of LBAs seems like a recipe for
very long serial sequence (which is what we are seeing).

I believe there is another problem besides command overhead: migration
of "live" data from one erase group (that we just told the device it
has to erase) to another erase group (that we will tell the device to
erase in the future).

If I'm going to erase 16GB of 32GB device, we have NO clue what data
has to move and where it will move to.  However, If I tell the device
to evacuate and erase a particular physical block, the more chunks I
have to erase, the more opportunity for the evacuated data to land in
an erase group that will get erased in a future command.

Lastly, for Android, the system is in recovery mode and doing nothing
else. So there is no reason to split up the commands into "smaller
chunks" like a normal IO (where it clearly makes sense up to a point).
Secure Erase performance is critical here. The longer Secure Erase
takes, the less likely people will do it. And I don't think the world
needs more papers on linux products that don't properly erase data.

cheers,
grant
