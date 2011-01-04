From: Sujit Reddy <sujitreddy243@gmail.com>
Subject: Re: eMMC sector/byte access mode validation
Date: Tue, 4 Jan 2011 22:29:32 +0530
Message-ID: <AANLkTi=HAY1MSMwhRvkae2c1VotJgcKp2oTa8Vjc_FD+@mail.gmail.com>
References: <AANLkTinn8EOuiB7ufMFxu=4vCf1K1==oj7Yqni_pbMjc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62800 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab1ADQ7e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 11:59:34 -0500
Received: by pzk35 with SMTP id 35so1523622pzk.19
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jan 2011 08:59:33 -0800 (PST)
In-Reply-To: <AANLkTinn8EOuiB7ufMFxu=4vCf1K1==oj7Yqni_pbMjc@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, akpm@linux-foundation.org, prakity@marvell.com

Hi,

Any comments on below mentioned query?

Thanks
Sujit

On Thu, Dec 23, 2010 at 1:35 PM, Sujit Reddy <sujitreddy243@gmail.com> wrote:
> Hi,
>
> According to eMMC spec v4.3, Section 6.1 says that greater than 2GB
> density cards are sector addressable and less than 2GB are byte addressable.
> But Section 7.3.3 says that OCR bit 30 needs to be used which access mode
> the host must use for all its future transactions.
>
> In mainline kernel the support for less than 2GB cards is by checking
> the density of card.
> If it is greater than 2GB it is assumed to be supporting sector addressing.
>
> But actually we need to check the OCR value to determine the correct access mode
> See patch (http://www.spinics.net/lists/linux-mmc/msg01466.html) by Philip.
>
> Some eMMC cards even though less than 2GB have SEC_COUNT value defined
> in EXT_CSD register but does not support sector access mode.
>
> I have a couple of questions here:
> 1) Are there any cards that support only byte access mode even though
> the density is
> greater than 2GB?
> 2) If there are cards which have capacity less than 2GB and supports only sector
> access mode then what's the solution? I am not sure If there are any such cards.
>
> Philip's patch handles both these scenarios effectively.
> Can anyone mention the reason not taking Philip's patch into account,
> which I feel is much
> more fool proof than the implementation in mainline kernel
> (http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg02307.html)?
>
> Thanks
> Sujit
>
