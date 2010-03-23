From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] mmc: fix incorrect interpretation of card type bits
Date: Tue, 23 Mar 2010 07:52:58 +0200
Message-ID: <4BA8573A.5010302@nokia.com>
References: <4BA318B8.5060408@nokia.com> <20100322154318.5fffc3bf.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26011 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab0CWFxF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Mar 2010 01:53:05 -0400
In-Reply-To: <20100322154318.5fffc3bf.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Andrew Morton wrote:
> On Fri, 19 Mar 2010 08:24:56 +0200
> Adrian Hunter <adrian.hunter@nokia.com> wrote:
> 
>> From: Adrian Hunter <adrian.hunter@nokia.com>
>> Date: Fri, 19 Mar 2010 08:06:54 +0200
>> Subject: [PATCH] mmc: fix incorrect interpretation of card type bits
>>
>> In the extended CSD register the CARD_TYPE is an 8-bit value
>> of which the upper 6 bits were reserved in JEDEC specifications
>> prior to version 4.4.  In version 4.4 two of the reserved bits
>> were designated for identifying support for the newly added
>> High-Speed Dual Data Rate.  Unfortunately the mmc_read_ext_csd()
>> function required that the reserved bits be zero instead of
>> ignoring them as it should.
>>
>> This patch makes mmc_read_ext_csd() ignore the CARD_TYPE bits
>> that are reserved or not yet supported.  It also stops the
>> function jumping to the end as though an error occurred, when
>> it is only warns that the CARD_TYPE bits (that it does interpret)
>> are invalid.
> 
> I need to whine about the changelog again.
> 
> I'm guessing that the effect here is that if someone puts one of these
> new cards into an old kernel, this card will be incorrectly handled. 
> Perhaps in ways which render the whole thing useless.

This is for eMMC so that will not happen.

> If that was a good guess then this patch would be needed in earlier
> kernels too.
> 
> But it was only a guess, and I'd prefer not to have to guess.  So
> please do remember to explain things like this in the changelog?

OK.  "Backport not necessary."
