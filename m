From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: ANNOUNCE: new "mmc-utils" repository
Date: Mon, 20 Feb 2012 15:09:36 +0100
Message-ID: <4F425420.6000809@st.com>
References: <m2y5s8j86z.fsf@bob.laptop.org> <4F3BAB56.80606@st.com> <m2wr7ogqxm.fsf@bob.laptop.org> <4F3BB671.9040208@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:56871 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752788Ab2BTOJr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Feb 2012 09:09:47 -0500
In-Reply-To: <4F3BB671.9040208@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On 2/15/2012 2:43 PM, Giuseppe CAVALLARO wrote:
> On 2/15/2012 2:35 PM, Chris Ball wrote:
>> Hi,
>>
>> On Wed, Feb 15 2012, Giuseppe CAVALLARO wrote:
>>> Hi Chris
>>>
>>> On 2/12/2012 6:03 PM, Chris Ball wrote:
>>>> Hi,
>>>>
>>>> I've created a repository for userspace mmc tools now:
>>>>
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git
>>>>
>>>> At the moment the only commands supported are Johan Rudholm's extcsd
>>>> write-protect commands, exposed as:
>>>>
>>>>    ./mmc extcsd read /dev/mmcblkX
>>>>    ./mmc extcsd write /dev/mmcblkX
>>>
>>>
>>> Is it worth now trying to add the logic behind the patch (mmc: debugfs:
>>> parse ext_csd via debug_fs (v2)) I sent time ago to parse the EXT_CSD?
>>> I can do that on mmc-utils if not yet done. Pls let me know.
>>
>> Yes, please.  (If you look farther down in the same message I did
>> mention adding it!)
>>
>> I think you can add it all to mmc extcsd read, rather than introducing
>> a new command.
> 
> Agree! I'll do that and provide a patch asap.

Hello Chris

I've sent the patch to this mailing list.
I will try to do further improvements starting from this first patch,
especially to add new parsing conditions for all the register bits (that
can be done later according to what we actually need to expose and
parser and what you suggest).

Regards
peppe

> 
> peppe
> 
>>
>> Thanks,
>>
>> - Chris.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

