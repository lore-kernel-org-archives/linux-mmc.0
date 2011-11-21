From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: debugfs: parse all ext_csd via debug_fs
Date: Mon, 21 Nov 2011 11:08:25 +0100
Message-ID: <CACRpkda4gf7dpMxzPTjNZZX1mNqS4YMv21w-xC9TFCYot3qRAg@mail.gmail.com>
References: <1319468694-8773-1-git-send-email-peppe.cavallaro@st.com>
	<CAAgDR1N_CKnXo=G2oTHAShhgegMZF-nMySBuWebDPeu8VTEBKg@mail.gmail.com>
	<CACRpkda0y7cOR4EfuGLoGnD_PS1gTWqN7UA74=s2mWmEHokQhQ@mail.gmail.com>
	<4ECA0025.6030700@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45797 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291Ab1KUKI0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2011 05:08:26 -0500
Received: by iage36 with SMTP id e36so7073189iag.19
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2011 02:08:25 -0800 (PST)
In-Reply-To: <4ECA0025.6030700@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: Chris Ball <cjb@laptop.org>, Sebastian Rasmussen <sebras@gmail.com>, linux-mmc@vger.kernel.org

On Mon, Nov 21, 2011 at 8:39 AM, Giuseppe CAVALLARO
<peppe.cavallaro@st.com> wrote:

> Just to summarize: the patch works in debugfs context so the parsing doesn't
> break the sys rules. I agree with Chris this has to be maintained for the
> next mmc standards but IMO we can pay this waiting for having both a
> user-space application (mmc-tool) and the ext_csd in /sys (after that the
> ext_csd in debugfs could be completely removed).

I'm all for this patch so it gets visible in debugfs atleast,
since people seem to need to know these things, so take that as an
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Those who want to writ userspace tools can proceed to
implement the proper sysfs interfaces and document them.

Thanks,
Linus Walleij
