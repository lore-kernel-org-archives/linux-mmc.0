From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 2/2] mmc: sd: Fix sd current limit setting
Date: Wed, 18 Jul 2012 20:47:54 -0700
Message-ID: <1DB4B3FF-DB9A-4189-8F42-3374A16E79F6@marvell.com>
References: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
 <1341296172-10645-3-git-send-email-aaron.lu@amd.com>
 <CAGxe1ZF=T7GL6ZcyV-=MEd5WVWexNrUbrEZDsYGdFD+KPH4XfA@mail.gmail.com>
 <20120717134325.GA2567@localhost.localdomain>
 <87fw8qieap.fsf@octavius.laptop.org>
 <20120718050939.GA30490@srdclcs1.amd.com>
 <87liihocxj.fsf@octavius.laptop.org>
 <20120718062223.GA2711@aarontestpc.amd.com>
 <87hat4bhgn.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:57295 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752770Ab2GSDsL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Jul 2012 23:48:11 -0400
In-Reply-To: <87hat4bhgn.fsf@octavius.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Aaron Lu <aaron.lu@amd.com>, Girish K S <girish.shivananjappa@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lwe@gmail.com>


It is much cleaner solution then before !  I like it.

Reviewed-by: Philip Rakity <prakity@marvell.com>

On Jul 18, 2012, at 7:41 PM, Chris Ball wrote:

> Hi,
> 
> On Wed, Jul 18 2012, Aaron Lu wrote:
>> I've prepared the following code, please check if this is better than
>> the current one:
> 
> I think the diffstat speaks for itself.  :-)
> 
> drivers/mmc/core/sd.c    |   77 ++++++++++++++++++++++++++--------------------
> drivers/mmc/host/sdhci.c |   51 ++----------------------------
> include/linux/mmc/host.h |   22 +++----------
> 3 files changed, 51 insertions(+), 99 deletions(-)
> 
> Girish/Philip, does this look good to you too?  If so, I'll squash it
> into the original patch.
> 
> Thanks!
> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

