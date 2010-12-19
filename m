From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Sun, 19 Dec 2010 12:00:06 +0200
Message-ID: <AANLkTi=AnsLbL4vfNC++CxVdP5hDMCxifXcQthYExQbH@mail.gmail.com>
References: <AANLkTi=32bqipN5U00La-B7JSgTC1bHgMev=xUSF6kRN@mail.gmail.com> <Pine.LNX.4.44L0.1012181547580.7965-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61869 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab0LSKA1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Dec 2010 05:00:27 -0500
Received: by iyi12 with SMTP id 12so1458989iyi.19
        for <linux-mmc@vger.kernel.org>; Sun, 19 Dec 2010 02:00:26 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1012181547580.7965-100000@netrider.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>

On Sat, Dec 18, 2010 at 11:20 PM, Alan Stern <stern@rowland.harvard.edu=
> wrote:
>> They would also gain deterministic and controllable behavior that we
>> can't guarantee when we rely on a context switch, because obviously
>> the latter yields different results for different platforms and
>> workloads (for the exact same subsystem).
>
> Like I said before, it's a trade-off. =A0There are arguments for both
> sides, and which is better is unclear. =A0Rafael has to make a judgme=
nt
> call.

This calls for power measurements and analysis which may demonstrate
whether such a change is beneficial or not (and if yes, how much, and
under which workloads/setups).

Sadly I don't have the equipment to perform those measurements, which
I think are imperative to justify such a patch: IMHO the commit log
must include numbers...

Again, Rafael and Alan, thanks for your time and attention.

Ohad.
