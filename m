From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] omap_hsmmc - use threaded irq handler for card-detect.
Date: Mon, 02 Jan 2012 19:17:51 -0500
Message-ID: <m24nwdprkg.fsf@bob.laptop.org>
References: <20111230123513.6a843526@notabene.brown>
	<CAF=Qhp3aM4o59Lpbf0zrDdjrgbmO6sA-vfOM1wU4iDtDjNKUow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42633 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439Ab2ACASO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2012 19:18:14 -0500
In-Reply-To: <CAF=Qhp3aM4o59Lpbf0zrDdjrgbmO6sA-vfOM1wU4iDtDjNKUow@mail.gmail.com>
	(Kishore Kadiyala's message of "Fri, 30 Dec 2011 02:18:34 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Cc: NeilBrown <neilb@suse.de>, Tony Lindgren <tony@atomide.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

Hi Neil,

On Fri, Dec 30 2011, Kishore Kadiyala wrote:
> On Thu, Dec 29, 2011 at 8:35 PM, NeilBrown <neilb@suse.de> wrote:
>>
>>
>> As the card-detect irq handler just schedules work to be done by
>> a thread, we can use request_threaded_irq to do much of the work for
>> us. =C2=A0This means that interrupts which arrive by handle_nested_i=
rq
>> actually work.
>>
>> Reviewed-by: Felipe Balbi <balbi@ti.com>
>> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
>> Signed-off-by: NeilBrown <neilb@suse.de>
>
> I have done some thing similar but didn't pushed it  :-(
> Anyways
> Acked-by:  Kishore Kadiyala <kishorek.kadiyala@gmail.com>

Pushed with Kishore's ACK to mmc-next for 3.3, thanks.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
