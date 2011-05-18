From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [RFC]mmc: fix dead lock issue when system entering S3
Date: Wed, 18 May 2011 02:58:00 -0500
Message-ID: <BANLkTi=H5NR4vzkD+X4fZXw-PPFYwO51ow@mail.gmail.com>
References: <20110517075352.GA3992@intel.com>
	<5D8008F58939784290FAB48F54975198419F75426B@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:50255 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754316Ab1ERIB7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 May 2011 04:01:59 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4I7xeDF007206
	for <linux-mmc@vger.kernel.org>; Wed, 18 May 2011 03:59:40 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4I7thKA005406
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 18 May 2011 03:55:44 -0400 (EDT)
Received: by wyb34 with SMTP id 34so1174877wyb.15
        for <linux-mmc@vger.kernel.org>; Wed, 18 May 2011 00:58:01 -0700 (PDT)
In-Reply-To: <5D8008F58939784290FAB48F54975198419F75426B@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "He, Bo" <bo.he@intel.com>

Hey,

On Tue, May 17, 2011 at 5:03 AM, Dong, Chuanxiao
<chuanxiao.dong@intel.com> wrote:
> Just found Andrei Warkentin also submitted a RFC patch, which included more fix for mounted root file system media. Please ignore this thread.

I submitted an RFC patch as an idea up for discussion, but certainly
the issue never went away :-).. Your patch will not quite work. If you
have a filesystem it will not unmount, so mmc0 (for example) will
never release, so when a new (or same) card re-enumerates, it will be
mmc1...

I believe my patch basically created "md orphans" which would be
reconnected on resume, which is bit of a really nasty hack... I'm not
sure if there is a better way. I could have sworn I saw a patch a week
ago that attempted to resolve the suspend/resume with mounted fs issue
by deferring removal until resume, but I don't see it now, and I'm not
sure if it dealt well with the whole attempting to unmount fs in mmc
block cleanup path...

I guess I can resubmit...

A
