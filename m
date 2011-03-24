From: Andrei Warkentin <andreiw@motorola.com>
Subject: Reliable write support.
Date: Thu, 24 Mar 2011 16:22:30 -0500
Message-ID: <1301001751-30785-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:38223 "EHLO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933904Ab1CXUlF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2011 16:41:05 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2OKdTW8016321
	for <linux-mmc@vger.kernel.org>; Thu, 24 Mar 2011 16:39:29 -0400 (EDT)
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2OKaDt5014739
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 24 Mar 2011 16:39:29 -0400 (EDT)
Received: by mail-gw0-f42.google.com with SMTP id 17so235832gwb.15
        for <linux-mmc@vger.kernel.org>; Thu, 24 Mar 2011 13:41:00 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi group,

As part of enabling maximum-reliability (at cost of performance) workarounds for MMC media whose
controllers employ a scheme, where there is usually a small (flash-page sized) and a large (erase-block sized) buffer,
I needed reliable write support. As per Arnd's feedback, I've split the reliable write support out by itself. I believe
other people were going to look at this as well (https://wiki.linaro.org/WorkingGroups/KernelConsolidation/Specs/StoragePerfEMMC).

The patch provides a mechanism by which reliable writes can be enabled if they are supported, and enables them for REQ_FUA/REQ_META write transfers.
REQ_FUA/REQ_FLUSH is a replacement for barrier bios, which were broken before anyway (couldn't handle partial completions, which are what's
going to happen for legacy reliable write support). REQ_FUA is a flag a bio submitted from the filesystem and will make sure that I/O completion
for this request is only signaled after the data has been committed to non-volatile storage. REQ_META are supposed to be used by filesystems to
mark bios that contain metadata.

The patch is against linux-next and was tested with a Toshiba MMC08G (legacy reliable write support) eMMC on x64.

ToC:
[comments] MMC: Reliable write support.

Thanks ahead of time,
A
