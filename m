From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH v3 01/12] mmc: sdhci: add support for auto CMD23
Date: Sat, 16 Apr 2011 03:17:48 -0500
Message-ID: <BANLkTimthD=bYat2zPUeL-1As8f4krnB1g@mail.gmail.com>
References: <1302863942-1774-1-git-send-email-arindam.nath@amd.com>
	<1302863942-1774-2-git-send-email-arindam.nath@amd.com>
	<BANLkTimZGonC+D0czjiY4i7pFFW=upj_qw@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB443FB6@SAUSEXMBP01.amd.com>
	<BANLkTimEKQceSiuL=dX2yhMw+MLu7BzLvQ@mail.gmail.com>
	<BANLkTimfQo7wJ3_ecs64VSp7xKJrjYdJ3w@mail.gmail.com>
	<BANLkTikoAWEMGOAHrxJT4jNknVFtyuhdqw@mail.gmail.com>
	<000001cbfbfd$efa6e120$cef4a360$@org>
	<6C03668EAF45B747AF947A1603D1B300EB444353@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og107.obsmtp.com ([64.18.0.184]:49269 "EHLO
	exprod5og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab1DPIRw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Apr 2011 04:17:52 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3G8IEBl027766
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 04:18:14 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3G8ICLQ027756
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 04:18:14 -0400 (EDT)
Received: by wwb28 with SMTP id 28so3734271wwb.3
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 01:17:48 -0700 (PDT)
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300EB444353@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Sat, Apr 16, 2011 at 1:25 AM, Nath, Arindam <Arindam.Nath@amd.com> wrote:
> Hi Subhash,

> Please keep in mind that my patch _only_ adds support for Auto CMD23, and not CMD23. CMD23 support can be made part of block layer, but Auto CMD23 is a feature as per the Host Controller Spec v3.00. So my patch takes care of the second case.

All Auto CMD23 means is that the host sends the command automatically,
instead of having some code do it manually. Auto CMD23 makes no sense
if the block layer doesn't want or need CMD23. Let me explain:
1) Not all cards support CMD23
2) Not all cards that do support CMD23 want to use it for regular
multiblock transfers for performance reasons
3) If you disregard my current patch set, then your changes, if ever
enabled for MMCs, will actually break reliable writes because current
block code sent CMD23 manually (but the CMD23 support patch set fixed
that)

That means you can't just enable it in the host just because you feel
like it. Your current host changes make the host aware of the card
capabilities, and then force policy. This violates layering and makes
everything an unmaintainable mess.

Given the existing work for plumbing normal CMD23 support, you should
take advantage of that. Your current patch does not integrate well
with it, and I've tried to make it specifically very easy to enable
enhancements like Auto-CMD23. Let me help you out:

1) If you have mmc_request->sbc - then you should set your Auto-CMD23
flag and not send mmc_request->sbc.
2) You can forget your "save stop command". The current code should
function correctly as long as you can detect the error condition as
set data->error appropriately. But of course, feel
     free to change it if you see fit. Right now the stop command is
only sent if -
     a) No mmc_request->sbc so this must have been an open-ended
multiblock transfer
     b) An error condition detected in data transfer, so the stop must
be sent anyway

Anyway I'm at your disposal to answer your questions and make sure you
can implement AutoCMD23 support on top of existing MMC subsystem
changes.

A
