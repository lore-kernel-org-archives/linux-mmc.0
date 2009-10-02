From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: TMIO MMC: full patchset.
Date: Fri, 2 Oct 2009 09:55:31 +0200
Message-ID: <74d0deb30910020055r52d75399r568e76ccd0f7ca38@mail.gmail.com>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
	 <aec7e5c30909300441w6ca07dd9o889590c6100b846b@mail.gmail.com>
	 <c09aa50a0909301315o683322e4k4b85e21ab473341e@mail.gmail.com>
	 <aec7e5c30909301830s2d3ba9r39cce5cd57e87025@mail.gmail.com>
	 <20090930183932.7b90456f.akpm@linux-foundation.org>
	 <aec7e5c30910012317w52c639f0lc87a60c9fc1b51e2@mail.gmail.com>
	 <c09aa50a0910020023l22478ac2v1205f6c90994b3f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:51770 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756745AbZJBHz2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2009 03:55:28 -0400
Received: by bwz6 with SMTP id 6so767245bwz.37
        for <linux-mmc@vger.kernel.org>; Fri, 02 Oct 2009 00:55:32 -0700 (PDT)
In-Reply-To: <c09aa50a0910020023l22478ac2v1205f6c90994b3f8@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Magnus Damm <magnus.damm@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, sameo@openedhand.com, pb@handhelds.org

On Fri, Oct 2, 2009 at 9:23 AM, Ian Molton <ian@mnementh.co.uk> wrote:
> I'd prefer to see both the superH and ASIC3 MFD core drivers working
> with the new tmio-mmc.c without needing changes made to tmoi-mmc.c
> before we merge anything. I expect you can get the superH MFD driver
> written in about 15 minutes (copy tc6387xb, drop the CNF related io,
> and tweak to taste), so it shouldnt be much of a hardship.
>
> I *think* I've done enough to support superH now, but I'd like to be
> sure, and thus wait for Philipp to have his say.
>
> It wont take long, be patient.

Yes, bear with me for two more days.
I'll test on ASIC3 this weekend, the static int base_shift approach
looks ok to me.

regards
Philipp
