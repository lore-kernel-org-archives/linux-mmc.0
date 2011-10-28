From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] mmc: debugfs: parse all ext_csd via debug_fs
Date: Fri, 28 Oct 2011 09:51:30 +0200
Message-ID: <4EAA5F02.2080702@st.com>
References: <1319468694-8773-1-git-send-email-peppe.cavallaro@st.com> <CAAgDR1N_CKnXo=G2oTHAShhgegMZF-nMySBuWebDPeu8VTEBKg@mail.gmail.com> <4EA7EEBC.2070109@st.com> <CAAgDR1NhqOkDZ8M18Uc6CtWtZSy153wOnuxjhQ-m7aitPwitLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:41876 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755064Ab1J1Hvj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Oct 2011 03:51:39 -0400
In-Reply-To: <CAAgDR1NhqOkDZ8M18Uc6CtWtZSy153wOnuxjhQ-m7aitPwitLQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Rasmussen <sebras@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hello Sebastian,

On 10/27/2011 4:19 PM, Sebastian Rasmussen wrote:
> Hi!
> 
>> Before the patch the output from /sys/kernel/debug/mmc0/mmc0:0001/ext_csd
>> was a big number and I had many problems parsing it in real-time.
>> [...]
>> In any case, the patch wants to help to directly get the ext_csd in a
>> human format.
> 
> Yes, I realize this. However I'm unsure whether this parsing should be
> done in kernelspace at all. If your patch is accepted then it is obvious
> that people think this belongs in kernelspace rather than in userspace.

I've found really useful to have this kind of parsing in Kernel space
because, fortunately, we are also using the kernel to validate the HW on
our platforms.
In my experience, on the validation side (where people are nor Linux
Kernel developers although very skilled on other topics) is needed to
have a simplified environment (for example a minimal RAM rootFS) so,
instead of using user-space tools etc. (IMO), it can help to have all
the necessary information from the Kernel itself.
Somebody could also say that, for not a Linux expert, it is tricky  to
walk through a /sys FS ;-).

At any rate, it's not a big problem to have user-space applications to
parse this kind of information. I love tools like ethtool on network side.

In that case, I do hope, the patch will be useful for the user-space.  ;-)

> In addition I wonder what the rationale is behind placing the CID, SCR
> and CSD registers under /sysfs and EXT_CSD under debugfs. Not that you
> have chosen this, but do you know why they are accessible at different
> locations?

Yes, we have seen this but, frankly, I cannot explain why ext_csd are in
debugFS. Maybe, for historical reasons....  ext_csd are on new SPEC
versions and will come later.

/sys/kernel/debug/mmc0/mmc0\:0001/ext_csd
/sys/devices/platform/sdhci.0/mmc_host/mmc0/mmc0:0001/cid
/sys/devices/platform/sdhci.0/mmc_host/mmc0/mmc0:0001/csd

If we accept to have the ext_csd parsed in /sys/kernel/debug I agree
with you that we could also have csd and cid treated in the same way.
In that case, I promise you to work on that and post new patches asap.

>> Maybe, there is some user-space application to do this job that I do not
>> know. :-(
> 
> I  have not seen such a program myself, however I have been asking
> my former colleagues to make such a program open source. I will keep
> you uptodate if I hear from them and they provide me with the source.
> 
>>> BTW, you are parsing EXT_CSD here, but then one really
>>> should expand CSD, SCR, CID as well. One of those
>> Yes we could parse CID and CSD too. I guess in another patch.
> 
> I agree.
> 
>> Please consider this patch for the ext_csd entry in /sys.
> 
> I guess Chris Ball is the one to convince here, not me. :)

I added Chris on CC. Welcome yours advice.

>>> contains a numerical customer id which leads me to believe
>>> I did write an initial draft of such a userspace tool at my old
>>> employers over at ST-Ericsson and tried to open source it just
>>> before I resigned, but I don't know whether it has made it
>>> through the legal barrier yet. I'll let you know if I see it.
>> Yes let me know.
> 
> I have been in contact with my former colleagues how promised to
> try to get it through legal. As it stands I can only hope...
> 
>> Thanks for the reviewing. I'll look and fix all the points below and
>> resend the patch again.
> 
> Cool, I noticed that you have already sent v2. :)

:-)

Regards
Peppe

> 
>  / Sebastian
> 

