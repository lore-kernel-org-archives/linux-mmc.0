From: Chris Ball <cjb@laptop.org>
Subject: Re: ANNOUNCE: new "mmc-utils" repository
Date: Wed, 15 Feb 2012 08:35:33 -0500
Message-ID: <m2wr7ogqxm.fsf@bob.laptop.org>
References: <m2y5s8j86z.fsf@bob.laptop.org> <4F3BAB56.80606@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41131 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758310Ab2BONfo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Feb 2012 08:35:44 -0500
In-Reply-To: <4F3BAB56.80606@st.com> (Giuseppe CAVALLARO's message of "Wed, 15
	Feb 2012 13:55:50 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org, Johan RUDHOLM <johan.rudholm@stericsson.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

Hi,

On Wed, Feb 15 2012, Giuseppe CAVALLARO wrote:
> Hi Chris
>
> On 2/12/2012 6:03 PM, Chris Ball wrote:
>> Hi,
>> 
>> I've created a repository for userspace mmc tools now:
>> 
>> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git
>> 
>> At the moment the only commands supported are Johan Rudholm's extcsd
>> write-protect commands, exposed as:
>> 
>>    ./mmc extcsd read /dev/mmcblkX
>>    ./mmc extcsd write /dev/mmcblkX
>
>
> Is it worth now trying to add the logic behind the patch (mmc: debugfs:
> parse ext_csd via debug_fs (v2)) I sent time ago to parse the EXT_CSD?
> I can do that on mmc-utils if not yet done. Pls let me know.

Yes, please.  (If you look farther down in the same message I did
mention adding it!)

I think you can add it all to mmc extcsd read, rather than introducing
a new command.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
