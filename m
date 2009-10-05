From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PULL REQUEST] MMC and TMIO updates
Date: Mon, 5 Oct 2009 13:18:31 +0900
Message-ID: <aec7e5c30910042118o49f0f42bpbebfd9abd84b45b@mail.gmail.com>
References: <c09aa50a0910041024s2e48ce92kfc55b6692b02a7af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:57631 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbZJEETJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2009 00:19:09 -0400
Received: by gxk4 with SMTP id 4so3486236gxk.8
        for <linux-mmc@vger.kernel.org>; Sun, 04 Oct 2009 21:18:32 -0700 (PDT)
In-Reply-To: <c09aa50a0910041024s2e48ce92kfc55b6692b02a7af@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Phil Blundell <pb@handhelds.org>, linux-mmc@vger.kernel.org, sameo@openedhand.com, philipp.zabel@gmail.com, akpm@linux-foundation.org, Paul Mundt <lethal@linux-sh.org>

Hi Ian,

On Mon, Oct 5, 2009 at 2:24 AM, Ian Molton <ian@mnementh.co.uk> wrote:
> Hi folks,
>
> Andrew, can you please pull
>
> git//git.mnementh.co.uk/linux-2.6-im tmio_clockpower
>
> Thanks!

So I did a second round of testing on my kfr2r09 board, and the
updated version of the patch is still working fine.

To fulfill the dependencies for my SuperH Mobile SDHI driver I simply
cherry picked the single patch "MMC: hardware abstraction for CNF
area" that can be found here:

http://git.mnementh.co.uk/cgi-bin/gitweb.cgi?p=linux-2.6-im.git;a=commitdiff_plain;h=4cd83bd05e6c817a4a72ababd82bf5ae700c021d

Thanks for your help!

/ magnus
