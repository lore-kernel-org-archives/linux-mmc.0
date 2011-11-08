From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH v2] mmc: support BKOPS feature for eMMC
Date: Tue, 8 Nov 2011 19:37:03 +0100
Message-ID: <CAFEEs1=Zb7eXdbK11NJDxVnt2xYuxid1oX8SsPTRL0dPQwEWow@mail.gmail.com>
References: <4EB11B6B.2010909@samsung.com>
	<CAFEEs1=yF3u-xL6OnEMTfqYx6HgOaePYkhC7iOJi-=z9TjPfmw@mail.gmail.com>
	<CAELcNGQEm073tFsmSgbKzBfx=oYjZDX=EdbgWQOMZEBscsobTw@mail.gmail.com>
	<CAFEEs1==cJ_dYDgesAZcs+E=-jj7-hwwssbAsE4a9AdmED8k3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63105 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109Ab1KHShE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2011 13:37:04 -0500
Received: by vcbf1 with SMTP id f1so694629vcb.19
        for <linux-mmc@vger.kernel.org>; Tue, 08 Nov 2011 10:37:03 -0800 (PST)
In-Reply-To: <CAFEEs1==cJ_dYDgesAZcs+E=-jj7-hwwssbAsE4a9AdmED8k3A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jae hoon Chung <jh80.chung@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, svenkatr@ti.com, chuanxiao.dong@intel.com

On Tue, Nov 8, 2011 at 2:53 PM, Per Forlin <per.lkml@gmail.com> wrote:
> Hi Jaehoon,
>
> On Tue, Nov 8, 2011 at 1:43 PM, Jae hoon Chung <jh80.chung@gmail.com> wrote:
>> Hi Per.
>>
>> 2011/11/5 Per Forlin <per.lkml@gmail.com>:
>>> Hi Jaehoon,
>>>
>>> On Wed, Nov 2, 2011 at 11:28 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>> Enable eMMC background operations (BKOPS) feature.
>>>>
>>>> If URGENT_BKOPS is set after a response, note that BKOPS
>>>> are required. After all I/O requests are finished, run
>>>> BKOPS if required. Should read/write operations be requested
>>>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>>>> and then service the request.
>>>>
>>>> If you want to enable this feature, set MMC_CAP2_BKOPS.
>>>>
I'm thinking if it's good to add something in this commit message
about what has been proposed in this thread. The scope of this patch
is good and any additional optimizations could be added separately
later on.

Future considerations
 * Check BKOPS_LEVEL=1 and start BKOPS in a preventive manner.
 * Interrupt ongoing BKOPS before powering off the card.

Regards,
Per
