From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Sat, 6 Nov 2010 10:38:42 -0700
Message-ID: <041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com>
References: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com>
 <AANLkTi=6FeuxhEL1ht4thc6PQ05wLFo7d2NA-XUYwHxy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:37448 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751315Ab0KFRir convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 6 Nov 2010 13:38:47 -0400
In-Reply-To: <AANLkTi=6FeuxhEL1ht4thc6PQ05wLFo7d2NA-XUYwHxy@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linus.Walleij@stericsson.com" <linus.Walleij@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


We need a way to specify

a) Hardware can support clock gating
setting the clock to 0 in the call to set_ios (with hardware clock gating enabled) becomes a no-op so some care is needed which is why I suggested another field in the ios structure.

When clock gating is enabled with SDIO cards we have seen 
a) Missed Interrupts
b) Transactions not completed

We think this is because some SDIO cards need n clocks after the xfer completes from the host point of view to be in a state to handle clocks off.  n clocks should be 8 for SD 3.0 but in sometimes the cards need more.  We have seen SDIO cards work with no clocks needed and some needing more then 12 clocks.  This is completely understandable considering that clock gating is a new feature.  


b) hardware doing clock gating with SDIO is BAD -- we see the same issues that s/w clock gating patch see's ..  The sdio cards do not work correctly.

c) The quirk is needed to tell the core/ layer that h/w support is available.

On Nov 6, 2010, at 10:24 AM, Ohad Ben-Cohen wrote:

> Hi Phillip,
> 
> On Sat, Nov 6, 2010 at 1:38 AM, Philip Rakity <prakity@marvell.com> wrote:
>> d) keep sdio clock gating OFF -- need this from our experience.
> 
> I'm really interested to hear more about that one - what issues did you see ?
> Can you please elaborate ?
> 
> Thanks,
> Ohad.

