From: Chris Ball <cjb@laptop.org>
Subject: Re: UHS-I voltage switching on OLPC XO-1.75
Date: Mon, 05 Nov 2012 08:46:19 -0500
Message-ID: <87d2zsb1sk.fsf@octavius.laptop.org>
References: <CAMLZHHQfQ26E+BH2sqV9CGyso+uuKHC=WMaqehzBo9_Gr_kyPQ@mail.gmail.com>
	<10400F30-0A08-4B95-9C62-018A3AD4068B@nvidia.com>
	<87hap4b3f6.fsf@octavius.laptop.org>
	<39289E1F-1E14-4A2D-8ACD-8F8E84342FB4@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44387 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932208Ab2KENq0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 Nov 2012 08:46:26 -0500
In-Reply-To: <39289E1F-1E14-4A2D-8ACD-8F8E84342FB4@nvidia.com> (Philip
	Rakity's message of "Mon, 5 Nov 2012 14:20:36 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@nvidia.com>
Cc: Daniel Drake <dsd@laptop.org>, Johan Rudholm <jrudholm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kevin Liu <keyuan.liu@gmail.com>

Hi, adding Kevin,

On Mon, Nov 05 2012, Philip Rakity wrote:
> On Nov 5, 2012, at 1:11 PM, Chris Ball <cjb@laptop.org> wrote:
>
>> Hi,
>> 
>> On Mon, Nov 05 2012, Philip Rakity wrote:
>>> Hi Daneil, Chris,
>>> 
>>> I reviewed kevin's patch in September which fixes this issue.  Chris
>>> -- can we pull it into mmc-next ?  This patch is okay as a standalone
>>> change.
>
> That was the original intent.
>
> The question is what to do if no regulator.  regulator_get was
> returning NULL in Daniel;s case.
> IS_ERR patch was not taken so UHS support was removed.  
> The intent of the original code was to remove UHS support if there was
> a regulator but it could not support voltage switching.

So this patch does fix a real bug, other than the pr_info -- by affecting
whether we disable UHS in the else clause -- and the commit message
doesn't mention the existence of that real bug at all, and performs a
cosmetic fix for vmmc at the same time as a semantic fix for vqmmc.
That's terrible.

I'll merge Kevin's patch after adding a commit message that explains
what's actually going on.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
