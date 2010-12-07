From: Philip Rakity <prakity@marvell.com>
Subject: Re: working around a Marvell wifi SDIO bug
Date: Mon, 6 Dec 2010 18:31:23 -0800
Message-ID: <B757D685-D236-4C17-AE67-CC2EC03E153D@marvell.com>
References: <AANLkTik2F_-g2beZT5mLe4+XSBL-HUKnceeKqtKQZC=g@mail.gmail.com>
 <AANLkTinPbGcxOU8w_Wy3YVe-QOYpmQm+K7sgRHd-K2vp@mail.gmail.com>
 <43E4817426ED174AA81263BCECB4351D13200C556E@sc-vexch3.marvell.com>
 <AANLkTin=H653apPnritr4j0XEunt-_To5OwKDD-G_zHH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:37549 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754321Ab0LGCho convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Dec 2010 21:37:44 -0500
In-Reply-To: <AANLkTin=H653apPnritr4j0XEunt-_To5OwKDD-G_zHH@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Daniel Drake <dsd@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Requires a script to set RFKill at startup or whenever reset is required.  
The implementation toggles the power/reset gpio signals thus resetting the wifi card. 

The implementation consists of

a) code for rfkill
b) code in the arch directory for mach-mmp/
c) code in the platform sdio driver.

Philip

On Dec 6, 2010, at 2:31 PM, Ohad Ben-Cohen wrote:

> On Mon, Dec 6, 2010 at 6:37 AM, Philip Rakity <prakity@marvell.com> wrote:
>> 
>> I have seen this solved using rfkill.  Is that acceptable?
> 
> It doesn't make a lot of sense.. rfkill is a few layers above.. and if
> any, then an rfkill implementation will eventually end up triggering
> this code and not the other way around.

