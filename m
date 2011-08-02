From: James Hogan <james.hogan@imgtec.com>
Subject: Re: A few queries dw_mmc driver
Date: Tue, 02 Aug 2011 22:47:57 +0100
Message-ID: <4E38708D.9070801@imgtec.com>
References: <CANYdXnrvEJiehbz53WHMriAqn8F0uhnCFEE=x0gy19hfTXZStw@mail.gmail.com>	<CANYdXnpG2oyXL2wVzdE=h4S1SHR_tsvoBwU4VVDQmTjtU0fL5g@mail.gmail.com> <CANYdXnrYaqck5ekWtjcP+HDmRcav3kxew6dVuv5jgemURR3uZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:28489 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755134Ab1HBVr7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 2 Aug 2011 17:47:59 -0400
In-Reply-To: <CANYdXnrYaqck5ekWtjcP+HDmRcav3kxew6dVuv5jgemURR3uZw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>, linux-mmc <linux-mmc@vger.kernel.org>, Will <will.newton@imgtec.com>

Hi Shashidhar

(resending in form that won't get bounced from linux-mmc list).

On 08/02/2011 12:53 PM, Shashidhar Hiremath wrote:
> Hi James,
>   Sorry for interrupting you,
> 
> I had a few queries on mmc driver. Can you please help on this

I've CC'd the linux-mmc list as both questions involve mostly generic MMC.

> 1>
> ------------------------------------------------------------------------------
> What do the following elements in the mmc_host struct signify:
>   max_segs,max_block_size,max_block_count,max_seg_size,max_req_size

I'm not familiar with these myself, but as far as I can tell they
signify the limits of the DMAC (which is why they're set differently
depending on whether the internal DMAC or the platform specific DMAC is
used):
http://lxr.linux.no/#linux+v3.0/drivers/mmc/host/dw_mmc.c#L1421

>   I was adding the support for Dual_Buffer Descriptors support in dw_mmc
> driver.Does it require a change in the above elements of mmc_host
> structure ?

I don't know, but I'll see if I can find out.

> ------------------------------------------------------------------------------
> 
> 2>
> ------------------------------------------------------------------------------
> I have observed in most of the drivers that the switching between PIO
> mode and the DMA mode is being done based on the data_size. Instead can
> this be made independent of data_size and be coded such that ,it only
> depends on the menu-config option and driver uses only one ?

I can see the use of that (I've forced PIO mode myself during debugging
or running mmc_test), but whether this is an acceptable thing to have
upstream as a config option I don't know.

Regards
James

