From: Andrei Warkentin <andreiw@motorola.com>
Subject: MMC block quirk support + Toshiba performance quirk
Date: Tue,  1 Mar 2011 16:09:01 -0600
Message-ID: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og103.obsmtp.com ([64.18.0.145]:43152 "EHLO
	exprod5og103.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828Ab1CAV7T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 16:59:19 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p21LOi2P021381
	for <linux-mmc@vger.kernel.org>; Tue, 1 Mar 2011 16:24:44 -0500 (EST)
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com [209.85.161.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p21LOJbu021260
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 1 Mar 2011 16:24:44 -0500 (EST)
Received: by mail-gx0-f170.google.com with SMTP id 1so769968gxk.15
        for <linux-mmc@vger.kernel.org>; Tue, 01 Mar 2011 13:24:28 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

This patch set is meant for as a review for comments, and is the
result of the discussion on MMC quirks. Sorry ahead of time if I didn't
format this correctly. It's my first tiem with git mail-send :-).

=46or 1/3: Arnd suggested setting the default write alignment to
adjust on to be 32K. Since I don't have conclusive data and I don't
have a large set of flash memory to test on, the default behavior is
"do nothing", i.e. only quirk 3/3 sets the parameter to 8K as per=20
manufacturer suggestion.

Table of Contents:
[RFC 1/3] MMC: Adjust unaligned write accesses.
[RFC 2/3] MMC: Add block quirks support.
[RFC 3/3] MMC: Toshiba eMMC - Split 8K-unaligned accesses.

Here is an example of the effects of 3/3 on the Toshiba MMC32G card.

Before -

/data/flashbench -A -b 1024 /dev/block/platform/sdhci-tegra.3/by-name/c=
ache=20
write align 8388608	pre 3.84ms	on 7.45ms	post 4.32ms	diff 3.37ms
write align 4194304	pre 3.53ms	on 6.43ms	post 3.28ms	diff 3.02ms
write align 2097152	pre 4.1ms	on 7.19ms	post 3.99ms	diff 3.14ms
write align 1048576	pre 4.2ms	on 7.54ms	post 4.38ms	diff 3.26ms
write align 524288	pre 4.19ms	on 7.37ms	post 4.37ms	diff 3.1ms
write align 262144	pre 4.2ms	on 7.52ms	post 4.38ms	diff 3.23ms
write align 131072	pre 4.19ms	on 7.48ms	post 4.38ms	diff 3.2ms
write align 65536	pre 4.19ms	on 7.38ms	post 4.38ms	diff 3.1ms
write align 32768	pre 4.17ms	on 7.44ms	post 4.37ms	diff 3.17ms
write align 16384	pre 3.67ms	on 146ms	post 3.55ms	diff 143ms
write align 8192	pre 3.63ms	on 137ms	post 3.54ms	diff 134ms
write align 4096	pre 4.35ms	on 4.42ms	post 4.24ms	diff 121=C2=B5s
write align 2048	pre 4.4ms	on 4.18ms	post 4.43ms	diff -235734

8KB write alignment -

/data/flashbench -A -b 1024 /dev/block/platform/sdhci-tegra.3/by-name/c=
ache
write align 8388608	pre 3.22ms	on 6.48ms	post 3.24ms	diff 3.25ms
write align 4194304	pre 3.43ms	on 6.67ms	post 3.4ms	diff 3.25ms
write align 2097152	pre 3.54ms	on 6.81ms	post 3.35ms	diff 3.37ms
write align 1048576	pre 3.68ms	on 6.77ms	post 3.57ms	diff 3.14ms
write align 524288	pre 3.64ms	on 6.9ms	post 3.66ms	diff 3.25ms
write align 262144	pre 3.65ms	on 6.9ms	post 3.33ms	diff 3.41ms
write align 131072	pre 3.64ms	on 6.9ms	post 3.68ms	diff 3.24ms
write align 65536	pre 3.65ms	on 6.89ms	post 3.4ms	diff 3.37ms
write align 32768	pre 3.39ms	on 6.78ms	post 3.67ms	diff 3.25ms
write align 16384	pre 3.67ms	on 6.89ms	post 3.67ms	diff 3.22ms
write align 8192	pre 3.68ms	on 6.89ms	post 3.66ms	diff 3.22ms
write align 4096	pre 3.74ms	on 3.73ms	post 3.73ms	diff -4281ns
write align 2048	pre 3.73ms	on 3.73ms	post 3.73ms	diff 2.59=C2=B5s
