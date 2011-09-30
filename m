From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] mmc: dw_mmc: add write/read function for DATA register
Date: Fri, 30 Sep 2011 11:10:12 +0100
Message-ID: <4E859584.1030402@imgtec.com>
References: <4E857FE6.5020208@samsung.com> <4E8584EA.5000900@imgtec.com> <4E859365.8060601@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:41128 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab1I3KKQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 30 Sep 2011 06:10:16 -0400
In-Reply-To: <4E859365.8060601@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, kyungmin.park@samsung.com, Will Newton <will.newton@imgtec.com>

Hi

On 09/30/2011 11:01 AM, Jaehoon Chung wrote:
> Hi James.
> 
>> Can I suggest that instead of having 6 new macros with offset parameters
>> from the reg parameter (after all, the caller can just add the offset to
>> the reg argument just as easily), you simply store the data register
>> offset (what is currently DATA+host->data_offset) instead of
>> host->data_offset, and use that instead of DATA. That would be simpler
>> and more readable.
> 
> 
> Sure..i understood your suggestion. But i think that need check the
> version-id. i will also consider more..:)

Yes, I mean where you currently set host->data_offset depending on the
version id, set it to e.g. DATA or DATA_PRE240A (maybe DATA_LEGACY)
depending on the version id. Then use host->data_offset instead of DATA
everywhere else.

> 
>>
>> DATA should probably be defined as the most up to date value, and define
>> another one for pre-240A versions.
> 
> 
> Right. i wonder why changed the DATA register :(

Indeed, hopefully now they'll have twice as much space for normal
registers and won't have to change it again. I'm just happy they didn't
move the version id register!

Cheers
James

> 
> Best Regards,
> Jaehoon Chung

