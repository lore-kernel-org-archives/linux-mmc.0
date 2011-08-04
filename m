From: James Hogan <james.hogan@imgtec.com>
Subject: Re: A few queries dw_mmc driver
Date: Thu, 04 Aug 2011 11:20:32 +0100
Message-ID: <4E3A7270.8030304@imgtec.com>
References: <CANYdXnrvEJiehbz53WHMriAqn8F0uhnCFEE=x0gy19hfTXZStw@mail.gmail.com>	<CANYdXnpG2oyXL2wVzdE=h4S1SHR_tsvoBwU4VVDQmTjtU0fL5g@mail.gmail.com> <CANYdXnrYaqck5ekWtjcP+HDmRcav3kxew6dVuv5jgemURR3uZw@mail.gmail.com> <4E38708D.9070801@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:60010 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752594Ab1HDKUe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 4 Aug 2011 06:20:34 -0400
In-Reply-To: <4E38708D.9070801@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>, linux-mmc <linux-mmc@vger.kernel.org>, Will <will.newton@imgtec.com>

Hi Shashidhar

On 08/02/2011 10:47 PM, James Hogan wrote:
>>   I was adding the support for Dual_Buffer Descriptors support in dw_mmc
>> driver.Does it require a change in the above elements of mmc_host
>> structure ?
> 
> I don't know, but I'll see if I can find out.

The initial IDMAC settings were relatively sane defaults taken from the
original NXP driver, and things that were deducted from the source. Most
of the values pertain to the block layer:

* max_seg_size   /* upper limit on size of a coalesced segment */
* max_segs       /* upper limit on hw data segments in a request */
* max_req_size   /* maximum number of bytes in one request */
* max_blk_size   /* maximum size of one mmc block */
* max_blk_count  /* maximum number of blocks in one request */

They may not be the most efficient defaults, as they used the whole of
the IDMAC bandwidth (max_segs and max_blk_count are the size of the
whole ring buffer, and max_seg_size is the size of the largest DMA
transferrable block) but this shouldn't hinder a dual-buffered
implementation.

Cheers
James

