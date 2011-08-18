From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: Re: [RFC PATCH] mmc: support background operation
Date: Wed, 17 Aug 2011 20:16:06 -0700
Message-ID: <4E4C83F6.6080608@linux.intel.com>
References: <4E450B21.8040502@samsung.com> <4E4A9C40.3000708@linux.intel.com> <4E4B3D76.1030506@samsung.com> <4E4BE8C6.5040106@linux.intel.com> <4E4C74EB.8050702@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21537 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754805Ab1HRDOu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Aug 2011 23:14:50 -0400
In-Reply-To: <4E4C74EB.8050702@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>

On 08/17/2011 07:11 PM, Jaehoon Chung wrote:
> Hi Jay..
>
> I didn't know the tool 'sparse'. i will check the tool for your advice.
> Thank you a lot for your help.. :)

here, I'll provide it from a write-up I did within my department. 
Unfortunately, finding documentation how to use it is pretty hard 
because very little is provided.

-------------------------------------------------
Step 9 in SubmitChecklist documentation in preparing to submit a device 
driver upstream to Linus's kernel is:

9: Check cleanly with sparse.

Sparse is a tool written by Linus that contains built-in checks
for known problematic and a set of annotations in the Linux kernel
designed to convey semantic information about types, such as what
address space pointers point to, or what locks a function acquires or
releases.  It does appear to be a useful tool to make your code that
much more tight.

The #1 problem with this tool is there is little documentation how to 
use it.  I think I figured it out how to use it, basic-wise,
with the help of searching on-line forums.

To set up and use for the first time:
1. git clone git://git.kernel.org/pub/scm/devel/sparse/sparse.git
2. cd to the sparse directory
3. make; sudo make install
4. cd to your linux kernel
5. 'make C=1 >& sparse.log' if you have not built your kernel,
OR
'make C=2 >& sparse.log' if you have already built your kernel

I HIGHLY recommend the file redirection operator because a LOT OF STUFF
GETS SPIT OUT.

6. To use other macros, do something like:

make C=1 CF=
example:
make C=2 CF="-D__CHECK_ENDIAN__" (to check endianess)

Further info:
http://en.wikipedia.org/wiki/Sparse
-------------------------------------------------

>
>> Unfortunately, I am still a little new to this area of the Linux kernel
>> so I don't quite have the background to give an intelligent answer
>> w/respect to eMMC 4.41 and BKOPS.  I just have 3 device driver accepts
>> in the TTY space, so my contributions to patches are mainly basic code
>> functionality and Linux kernel/device-driver gotchas.
>>
>> Do you know the tool 'sparse'?  It's a good thing to try once, before
>> submitting upstream, if you haven't done it.
>>
>>>
>>> Regards,
>>> Jaehoon Chung
>>>
>>>
>>>
>>
>>
>


-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
