From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/23]  Alternative mmc structure to support pxa168, pxa910, mmp2 family SD
Date: Thu, 23 Dec 2010 00:45:32 +0100
Message-ID: <201012230045.32641.arnd@arndb.de>
References: <98992407-793C-4545-AAB3-9C80BE5BCEF5@marvell.com> <201012221525.10232.arnd@arndb.de> <09DA111A-AFD0-4214-B6DC-4236E30256FA@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:50137 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab0LVXpi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 18:45:38 -0500
In-Reply-To: <09DA111A-AFD0-4214-B6DC-4236E30256FA@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Philip Rakity <prakity@marvell.com>, Mark Brown <markb@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thursday 23 December 2010 00:21:26 Philip Rakity wrote:
> On Dec 22, 2010, at 6:25 AM, Arnd Bergmann wrote:
> > * The mails are sent as attachments, not inline
> 
> My e-mail system shows I received inline and attachments.

Ah, I didn't realize this. It should be inline-only though.
 
> > * There is no threading, better make all of the patches 
> >  replies to a first [PATCH 0/23] mail describing the
> >  overall intentions of the patch set.
> 
> What is correct format for this? 

The initial mail is free-form, just have a look at what others
do. Good things to include there are a list of patches,
a combined diffstat and a list of changes from previous
submissions.

> > * 23 patches is a lot, some of them are obvious candidates
> >  for merging, because they make no sense on their own, e.g.
> >  12 and 13, or 19 and 21.
> 
> Long discussion about this.  Went between a few BIG patches but was told that
> this makes review very difficult.  

Right, small patches are normally much preferred to big patches.
You were just taking it a bit too far.

> The patches were generated in the order that
> made sense to apply them.  Was worried that skipping one set would break 
> things.  The intent was that some of the patches could be picked up individually if the 
> philosophy for handing SD/MMC is not acceptable to the list.
> 
> I can go back and separate  arch/ patches into one set and a few patches
> for SD/MMC.  What would folks like to see.  

The way you did it was almost perfect, don't make the opposite mistake
of making the patches too big again. Splitting arch/ from drivers/
patches only makes sense if you expect different maintainers to pick
them up. In general, it's more important to keep pieces logically
together. If you introduce a new function and use it in one place,
put both the function and the user in one patch, rather than having
one patch that adds multiple unrelated functions and another that
uses all of them.
 
> How is this best handled from a subject line so it is easy to follow the threads ?

You can make multiple series, each with a patch 0/xx email in front and
the others as a reply to the first mail. Note that a good maximum number
of patches per series would be no more than 15. You can have 20 or
so if the patches are as small as the ones you sent, but if they get
too large, ten patches may be too much already.

> > * Some other patches have a S-o-b from you, but it's not the last
> >  one in the list.
> > * Please Cc the people that you have in the Signed-off-by or
> >  other headers.
> 
> 0001 was submitted by the folks in the patch.  It is NOT in linux-next and without
> it no mmp2 testing can be done on my development board.

Not sure what you mean. If you forward a patch from someone else,
you are supposed to add you s-o-b under the last one that you got,
and notify them that you are submitting the patch somewhere.

> > Using git-send-email will take care of some of these issues.
> 
> very painful -- corp e-mail issues.

Many freemail providers allow you to use arbitrary sender addresses
(gmail does not, fwiw), so you can use them with git-send-email as
long as you have access to the SMTP ports. Other people from your
company have managed fine, just ask around what they did.

	Arnd
