From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: print debug messages for runtime PM actions
Date: Wed, 20 Jul 2011 17:36:46 +0100
Message-ID: <CAGq3pz7ni49sKW2sLabAi7rof=cETEuviuQcpZPcmJOzOzmsog@mail.gmail.com>
References: <20110717153841.D4BF29D401C@zog.reactivated.net>
	<m2pql79f1s.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:46658 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab1GTQgr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jul 2011 12:36:47 -0400
Received: by fxd18 with SMTP id 18so2020876fxd.11
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jul 2011 09:36:46 -0700 (PDT)
In-Reply-To: <m2pql79f1s.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On 19 July 2011 03:31, Chris Ball <cjb@laptop.org> wrote:
> Did you consider just:
>
> =A0 =A0 =A0 =A0pr_debug("%s: %s: powering down\n", mmc_hostname(host)=
, __func__);
>
> which gets you the same CONFIG_MMC_DEBUG semantics? =A0(The messages =
will
> be at the debug loglevel rather than info, but that sounds right to m=
e.)

I did, and that would probably be fine (assuming that CONFIG_MMC_DEBUG
would actually turn it on? I can't see where that would happen), but I
was trying to make it a bit more prominent and appear the same as the
debug message from mmc_rescan_try_freq() which does it in this way.

Daniel
