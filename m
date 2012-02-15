From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: ANNOUNCE: new "mmc-utils" repository
Date: Wed, 15 Feb 2012 14:43:13 +0100
Message-ID: <4F3BB671.9040208@st.com>
References: <m2y5s8j86z.fsf@bob.laptop.org> <4F3BAB56.80606@st.com> <m2wr7ogqxm.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:48049 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756133Ab2BOOJj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2012 09:09:39 -0500
In-Reply-To: <m2wr7ogqxm.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Johan RUDHOLM <johan.rudholm@stericsson.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

On 2/15/2012 2:35 PM, Chris Ball wrote:
> Hi,
> 
> On Wed, Feb 15 2012, Giuseppe CAVALLARO wrote:
>> Hi Chris
>>
>> On 2/12/2012 6:03 PM, Chris Ball wrote:
>>> Hi,
>>>
>>> I've created a repository for userspace mmc tools now:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git
>>>
>>> At the moment the only commands supported are Johan Rudholm's extcsd
>>> write-protect commands, exposed as:
>>>
>>>    ./mmc extcsd read /dev/mmcblkX
>>>    ./mmc extcsd write /dev/mmcblkX
>>
>>
>> Is it worth now trying to add the logic behind the patch (mmc: debugfs:
>> parse ext_csd via debug_fs (v2)) I sent time ago to parse the EXT_CSD?
>> I can do that on mmc-utils if not yet done. Pls let me know.
> 
> Yes, please.  (If you look farther down in the same message I did
> mention adding it!)
> 
> I think you can add it all to mmc extcsd read, rather than introducing
> a new command.

Agree! I'll do that and provide a patch asap.

peppe

> 
> Thanks,
> 
> - Chris.

