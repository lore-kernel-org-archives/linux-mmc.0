From: Daniel Drake <drake@endlessm.com>
Subject: Re: Acer ES1-432 eMMC not detected, mmc_select_hs200 fails
Date: Thu, 23 Feb 2017 11:15:19 -0600
Message-ID: <CAD8Lp46vRL1utrH1fR7LRVkMLx3n2SW0xQqR6D=vWjke0P7jDg@mail.gmail.com>
References: <CAD8Lp46nvb0cL-7gJXh1XPL0gvGM=-uRcm93dv1s2chks4gZuQ@mail.gmail.com>
 <ce5edf5a-40ba-eedd-2f93-7c941ca94134@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ot0-f172.google.com ([74.125.82.172]:36762 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdBWRPV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Feb 2017 12:15:21 -0500
Received: by mail-ot0-f172.google.com with SMTP id j38so28293496otb.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Feb 2017 09:15:21 -0800 (PST)
In-Reply-To: <ce5edf5a-40ba-eedd-2f93-7c941ca94134@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Chris Chiu <chiu@endlessm.com>, Linux Upstreaming Team <linux@endlessm.com>

Hi Adrian,

On Wed, Feb 15, 2017 at 1:00 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Upstream we no longer check for CRC errors after the HS200 switch.
> Here is the relevant patch which will be in v4.10
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ef3d232245ab7a1bf361c52449e612e4c8b7c5ab

We have confirmed that this solves the issue.

Thanks!
Daniel
