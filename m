From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] mmc: debugfs: parse all ext_csd via debug_fs
Date: Thu, 27 Oct 2011 09:20:23 +0200
Message-ID: <4EA90637.2010802@st.com>
References: <1319468694-8773-1-git-send-email-peppe.cavallaro@st.com> <CAAgDR1N_CKnXo=G2oTHAShhgegMZF-nMySBuWebDPeu8VTEBKg@mail.gmail.com> <4EA7EEBC.2070109@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:54125 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751950Ab1J0HUZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 03:20:25 -0400
In-Reply-To: <4EA7EEBC.2070109@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Rasmussen <sebras@gmail.com>
Cc: linux-mmc@vger.kernel.org

On 10/26/2011 1:27 PM, Giuseppe CAVALLARO wrote:
> On 10/25/2011 1:43 PM, Sebastian Rasmussen wrote:

[snip]

>> contains a numerical customer id which leads me to believe
>> that it would require some kind of list of number->name to
>> make it accessible to users, something akin to the lspci
>> database. I did write an initial draft of such a userspace tool
>> at my old employers over at ST-Ericsson and tried to open
>> source it just before I resigned, but I don't know whether it
>> has made it through the legal barrier yet. I'll let you know
>> if I see it.
> 
> Yes let me know.
> 
> Thanks for the reviewing. I'll look and fix all the points below and
> resend the patch again.

Hello Sebastian,
thanks a lot for the excellent review! I have applied all your advice
and re-send the patch (with you on CC) as V2.

Let me know.

Kind Regards
Peppe
