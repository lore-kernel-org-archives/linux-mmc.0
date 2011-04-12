From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] MMC: Fix erase/trim for certain SanDisk cards.
Date: Tue, 12 Apr 2011 14:27:21 -0500
Message-ID: <BANLkTimhzeN-8PHqiM4eu2cd4RoXXqzkaQ@mail.gmail.com>
References: <BANLkTi=N75ATcXHqbjDMpCMJ1bGnJggqog@mail.gmail.com>
	<1302638625-32106-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og107.obsmtp.com ([64.18.0.184]:33695 "EHLO
	exprod5og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519Ab1DLT1X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 15:27:23 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3CJPYcg019741
	for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 15:25:34 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3CIhZj6025675
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 15:25:33 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so9729205wyb.15
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 12:27:21 -0700 (PDT)
In-Reply-To: <1302638625-32106-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

On Tue, Apr 12, 2011 at 3:03 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> CMD38 argument is passed through EXT_CSD[113].
>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
> ---

Wrong version again, sorry! :(

A
