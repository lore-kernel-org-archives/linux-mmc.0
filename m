From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [RFC] MMC: MMC boot partitions support.
Date: Sat, 19 Mar 2011 07:13:24 -0500
Message-ID: <AANLkTinFmYQBBHQ0Uewa+3m3hkuZ4KJfdhXz4zBhz0wJ@mail.gmail.com>
References: <1300533491-2378-1-git-send-email-andreiw@motorola.com>
	<1300533491-2378-2-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:56003 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465Ab1CSMNd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Mar 2011 08:13:33 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2JCBw53016061
	for <linux-mmc@vger.kernel.org>; Sat, 19 Mar 2011 08:11:58 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2JCBb5O016033
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 19 Mar 2011 08:11:57 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so4806215wwb.3
        for <linux-mmc@vger.kernel.org>; Sat, 19 Mar 2011 05:13:24 -0700 (PDT)
In-Reply-To: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

On Sat, Mar 19, 2011 at 6:18 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
> Allows device MMC boot partitions to be accessed. MMC partitions
> are treated effectively as separate block devices on the same
> MMC card.
>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>

Oops, sorry, sent the wrong commit. Please ignore lack of error
checking around mmc_blk_part_switch inside issue_rq :<.

A
