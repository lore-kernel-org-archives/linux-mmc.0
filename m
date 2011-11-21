From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] mmc: debugfs: parse all ext_csd via debug_fs
Date: Mon, 21 Nov 2011 08:39:17 +0100
Message-ID: <4ECA0025.6030700@st.com>
References: <1319468694-8773-1-git-send-email-peppe.cavallaro@st.com> <CAAgDR1N_CKnXo=G2oTHAShhgegMZF-nMySBuWebDPeu8VTEBKg@mail.gmail.com> <CACRpkda0y7cOR4EfuGLoGnD_PS1gTWqN7UA74=s2mWmEHokQhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:48189 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753997Ab1KUHjn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2011 02:39:43 -0500
In-Reply-To: <CACRpkda0y7cOR4EfuGLoGnD_PS1gTWqN7UA74=s2mWmEHokQhQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>
Cc: Sebastian Rasmussen <sebras@gmail.com>, linux-mmc@vger.kernel.org

Hello Linus, Chris,

On 11/12/2011 2:12 AM, Linus Walleij wrote:
> On Tue, Oct 25, 2011 at 1:43 PM, Sebastian Rasmussen<sebras@gmail.com>  wrote:
>> [Giuseppe]
>>> This patch enhances the debug information reported
>>> for the mmc card by parsing the extended CSD registers
>>> obviously according to all the current specifications.
>>
>> Does this belong kernel or in userspace? I'm not sure, and
>> I'm hoping that any of the old-timers here chime in on it.
>> Anyway I supply you with a few comments on you patch
>> below...
>
> Since it's in debugfs we can have it as verbose and whatever
> weird structure we wish. Userspace tools usually don't
> depend on debugfs ... except for some :-/ (see recent
> ftrace vs perf debates etc etc)
>
> To implement getting at this data in a future-proof way
> from userspace we should put it in sysfs.
>
> And if it was in sysfs we would have to follow the rule
> "one value per file" with files named after each CSD/etc
> field. Then to make that human-readable you would need
> a userspace tool, and preferrably it should also be
> documented in Documentation/ABI/testing/*
>
> And nothing really prevents us from doing both :-)

Thanks for all advice and review, I've not clear if at this stage the 
patch will be added in mmc-next.

Just to summarize: the patch works in debugfs context so the parsing 
doesn't break the sys rules. I agree with Chris this has to be 
maintained for the next mmc standards but IMO we can pay this waiting 
for having both a user-space application (mmc-tool) and the ext_csd in 
/sys (after that the ext_csd in debugfs could be completely removed).

Let me know.

Best Regards
Giuseppe

>
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

