From: "panduranga" <x0125717@ti.com>
Subject: Re: [PATCH 1/5] omap: panda: wlan board muxing
Date: Mon, 14 Feb 2011 13:31:21 +0530
Message-ID: <FBC9ED9F50B94DFFB6CAE483EF20F1C7@MINX0125717>
References: <1297667958-22377-1-git-send-email-panduranga_mallireddy@ti.com> <1297667958-22377-2-git-send-email-panduranga_mallireddy@ti.com> <AANLkTik4+CRp8B8Ajnpy-_k1m+=MZNe62c2WG8cjaz-D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59200 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab1BNIBr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 03:01:47 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, "Mallireddy, Panduranga" <panduranga_mallireddy@ti.com>
Cc: "Coelho, Luciano" <coelho@ti.com>, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, "Gabay, Benzy" <benzyg@ti.com>, "Gurumath, Pradeep" <pradeepgurumath@ti.com>, "Mahaveer, Vishal" <vishalm@ti.com>, "Boudet, Xavier" <x-boudet@ti.com>, "Jain, Naveen" <naveen_jain@ti.com>, "Savoy, Pavan" <pavan_savoy@ti.com>, "Halli, Manjunatha" <manjunatha_halli@ti.com>, tony@atomide.com, cjb@laptop.org

Hi Ohad,

I will modify the patch accordingly.

Regards,
Pandu.

----- Original Message ----- 
From: "Ohad Ben-Cohen" <ohad@wizery.com>
To: "Mallireddy, Panduranga" <panduranga_mallireddy@ti.com>
Cc: "Coelho, Luciano" <coelho@ti.com>; <netdev@vger.kernel.org>; 
<linux-omap@vger.kernel.org>; <linux-mmc@vger.kernel.org>; "Gabay, Benzy" 
<benzyg@ti.com>; "Gurumath, Pradeep" <pradeepgurumath@ti.com>; "Mahaveer, 
Vishal" <vishalm@ti.com>; "Boudet, Xavier" <x-boudet@ti.com>; "Jain, Naveen" 
<naveen_jain@ti.com>; "Savoy, Pavan" <pavan_savoy@ti.com>; "Halli, 
Manjunatha" <manjunatha_halli@ti.com>; <tony@atomide.com>; <cjb@laptop.org>
Sent: Monday, February 14, 2011 12:54 PM
Subject: Re: [PATCH 1/5] omap: panda: wlan board muxing


Hi Pandu,

On Mon, Feb 14, 2011 at 9:19 AM,  <panduranga_mallireddy@ti.com> wrote:
> + /* WLAN IRQ - GPIO 53 */
> + OMAP4_MUX(GPMC_NCS3, OMAP_MUX_MODE3 | OMAP_PIN_INPUT_PULLUP),

Actually we don't need to pull up the IRQ line -  it is always held by
the 1271 device, and there's no need for the host to pull it up
(wasting some power while doing it).

We have that on the ZOOM, but that's not necessary, and will be fixed
there, too.

Thanks,
Ohad.

