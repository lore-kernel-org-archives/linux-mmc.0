From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: debugfs: parse all ext_csd via debug_fs
Date: Sat, 12 Nov 2011 02:12:34 +0100
Message-ID: <CACRpkda0y7cOR4EfuGLoGnD_PS1gTWqN7UA74=s2mWmEHokQhQ@mail.gmail.com>
References: <1319468694-8773-1-git-send-email-peppe.cavallaro@st.com>
	<CAAgDR1N_CKnXo=G2oTHAShhgegMZF-nMySBuWebDPeu8VTEBKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39556 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755846Ab1KLBMf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Nov 2011 20:12:35 -0500
Received: by iage36 with SMTP id e36so4692775iag.19
        for <linux-mmc@vger.kernel.org>; Fri, 11 Nov 2011 17:12:34 -0800 (PST)
In-Reply-To: <CAAgDR1N_CKnXo=G2oTHAShhgegMZF-nMySBuWebDPeu8VTEBKg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Rasmussen <sebras@gmail.com>
Cc: Giuseppe CAVALLARO <peppe.cavallaro@st.com>, linux-mmc@vger.kernel.org

On Tue, Oct 25, 2011 at 1:43 PM, Sebastian Rasmussen <sebras@gmail.com> wrote:
>[Giuseppe]
>> This patch enhances the debug information reported
>> for the mmc card by parsing the extended CSD registers
>> obviously according to all the current specifications.
>
> Does this belong kernel or in userspace? I'm not sure, and
> I'm hoping that any of the old-timers here chime in on it.
> Anyway I supply you with a few comments on you patch
> below...

Since it's in debugfs we can have it as verbose and whatever
weird structure we wish. Userspace tools usually don't
depend on debugfs ... except for some :-/ (see recent
ftrace vs perf debates etc etc)

To implement getting at this data in a future-proof way
from userspace we should put it in sysfs.

And if it was in sysfs we would have to follow the rule
"one value per file" with files named after each CSD/etc
field. Then to make that human-readable you would need
a userspace tool, and preferrably it should also be
documented in Documentation/ABI/testing/*

And nothing really prevents us from doing both :-)

Yours,
Linus Walleij
