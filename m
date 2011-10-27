From: Sebastian Rasmussen <sebras@gmail.com>
Subject: Re: [PATCH] mmc: debugfs: parse all ext_csd via debug_fs
Date: Thu, 27 Oct 2011 16:19:01 +0200
Message-ID: <CAAgDR1NhqOkDZ8M18Uc6CtWtZSy153wOnuxjhQ-m7aitPwitLQ@mail.gmail.com>
References: <1319468694-8773-1-git-send-email-peppe.cavallaro@st.com>
	<CAAgDR1N_CKnXo=G2oTHAShhgegMZF-nMySBuWebDPeu8VTEBKg@mail.gmail.com>
	<4EA7EEBC.2070109@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42795 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313Ab1J0OTC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 10:19:02 -0400
Received: by ggnb1 with SMTP id b1so2677186ggn.19
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2011 07:19:01 -0700 (PDT)
In-Reply-To: <4EA7EEBC.2070109@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org

Hi!

> Before the patch the output from /sys/kernel/debug/mmc0/mmc0:0001/ext_csd
> was a big number and I had many problems parsing it in real-time.
>[...]
> In any case, the patch wants to help to directly get the ext_csd in a
> human format.

Yes, I realize this. However I'm unsure whether this parsing should be
done in kernelspace at all. If your patch is accepted then it is obvious
that people think this belongs in kernelspace rather than in userspace.

In addition I wonder what the rationale is behind placing the CID, SCR
and CSD registers under /sysfs and EXT_CSD under debugfs. Not that you
have chosen this, but do you know why they are accessible at different
locations?

> Maybe, there is some user-space application to do this job that I do not
> know. :-(

I  have not seen such a program myself, however I have been asking
my former colleagues to make such a program open source. I will keep
you uptodate if I hear from them and they provide me with the source.

>> BTW, you are parsing EXT_CSD here, but then one really
>> should expand CSD, SCR, CID as well. One of those
> Yes we could parse CID and CSD too. I guess in another patch.

I agree.

> Please consider this patch for the ext_csd entry in /sys.

I guess Chris Ball is the one to convince here, not me. :)

>> contains a numerical customer id which leads me to believe
>> I did write an initial draft of such a userspace tool at my old
>> employers over at ST-Ericsson and tried to open source it just
>> before I resigned, but I don't know whether it has made it
>> through the legal barrier yet. I'll let you know if I see it.
> Yes let me know.

I have been in contact with my former colleagues how promised to
try to get it through legal. As it stands I can only hope...

> Thanks for the reviewing. I'll look and fix all the points below and
> resend the patch again.

Cool, I noticed that you have already sent v2. :)

 / Sebastian
