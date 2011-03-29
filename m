From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Tue, 29 Mar 2011 17:45:36 -0500
Message-ID: <AANLkTinMu57VyaVK3zBpePdJ-Yi=g9zt2833UtbcRpM5@mail.gmail.com>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
	<1300828300-8677-2-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og112.obsmtp.com ([64.18.0.24]:36328 "EHLO
	exprod5og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab1C2Wpj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2011 18:45:39 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2TMi1ov014083
	for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2011 18:44:01 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2TMhlRY014027
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2011 18:44:00 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so818271wwb.3
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2011 15:45:37 -0700 (PDT)
In-Reply-To: <1300828300-8677-2-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

On Tue, Mar 22, 2011 at 4:11 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> Allows device MMC boot partitions to be accessed. MMC partitions
> are treated effectively as separate block devices on the same
> MMC card.
>

Anyone has any opinions on these changes as being good or bad?
Anything I should do differently? Or does everyone like this?

Thanks ahead,
A
