From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: RE: [RFC] sdhci: use ios->clock to know when sdhci is idle
Date: Thu, 30 Dec 2010 18:37:39 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A47331E875CD@shsmsx501.ccr.corp.intel.com>
References: <1293023621-3077-1-git-send-email-tardyp@gmail.com>
	<41EFD7A46E18724CAB128DAD00733480193D2AE61C@shsmsx502.ccr.corp.intel.com>
	<AANLkTinYWODS785AefQ7hV+urPkAn1+En-fZEaFQygLG@mail.gmail.com>
	<CE761E84DADF2947A4AF22FB8D97A47331E86F6E@shsmsx501.ccr.corp.intel.com>
 <AANLkTimB7h0ZxvSOt2dUkO90RxE2c3Bu3CRqpasgzxw=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59873 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752977Ab0L3Khn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Dec 2010 05:37:43 -0500
In-Reply-To: <AANLkTimB7h0ZxvSOt2dUkO90RxE2c3Bu3CRqpasgzxw=@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Pierre Tardy <tardyp@gmail.com>, "Yuan, Hang" <hang.yuan@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Maxim Levitsky <maximlevitsky@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>

>> So, why we have to move to the 'aggressive clock gating framework'?
>
>The aggressive clock gating makes more sense since the different
>drivers will know better how to handle the gating. ios with f=0 can
>be interpreted differently. Else every driver has to register
>runtime PM hooks for this, which is less elegant.

Thanks for the response. I just curious that is this the only reason to change the framework? To my understanding, seems it's not a very strong reason :-)

Take the example of sd/mmc card -
by using the aggressive clock gating framework, it means the host controller will gate (clock gating or power gating) itself if not receiving requests for 8 clocks even if the request queue of mmc block driver is not empty at that time. So the host controller has to be gated / ungated repeatedly until the current request queue of mmc block driver becomes empty. I don't think this is elegant since most of the gating / ungating operations are not necessary.

Instead, if we do it in the mmc block driver by just call the pm_runtime_put() once the current request queue is empty and call pm_runtime_get() once any new request comes, then the host controller can be gated/ungated appropriately.

Thanks.

Regards,
Yunpeng
