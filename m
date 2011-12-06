From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] mmc: debugfs: parse all ext_csd via debug_fs
Date: Tue, 06 Dec 2011 06:52:21 +0100
Message-ID: <4EDDAD95.7020500@st.com>
References: <1319468694-8773-1-git-send-email-peppe.cavallaro@st.com> <CAAgDR1N_CKnXo=G2oTHAShhgegMZF-nMySBuWebDPeu8VTEBKg@mail.gmail.com> <CACRpkda0y7cOR4EfuGLoGnD_PS1gTWqN7UA74=s2mWmEHokQhQ@mail.gmail.com> <4ECA0025.6030700@st.com> <CACRpkda4gf7dpMxzPTjNZZX1mNqS4YMv21w-xC9TFCYot3qRAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:39420 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752275Ab1LFFwm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 00:52:42 -0500
In-Reply-To: <CACRpkda4gf7dpMxzPTjNZZX1mNqS4YMv21w-xC9TFCYot3qRAg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Sebastian Rasmussen <sebras@gmail.com>, linux-mmc@vger.kernel.org

On 11/21/2011 11:08 AM, Linus Walleij wrote:
> On Mon, Nov 21, 2011 at 8:39 AM, Giuseppe CAVALLARO
> <peppe.cavallaro@st.com> wrote:
> 
>> Just to summarize: the patch works in debugfs context so the parsing doesn't
>> break the sys rules. I agree with Chris this has to be maintained for the
>> next mmc standards but IMO we can pay this waiting for having both a
>> user-space application (mmc-tool) and the ext_csd in /sys (after that the
>> ext_csd in debugfs could be completely removed).
> 
> I'm all for this patch so it gets visible in debugfs atleast,
> since people seem to need to know these things, so take that as an
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Those who want to writ userspace tools can proceed to
> implement the proper sysfs interfaces and document them.

Hello Chris.

Sorry if I disturb you, any news about the patch:

    mmc: debugfs: parse ext_csd via debug_fs (v2)

Reviewed-by Sebastian and Acked-by Linus?

Please let me know if I need to do some other work on this or if it can
be considered for mmc-next.

Best Regards
Peppe
