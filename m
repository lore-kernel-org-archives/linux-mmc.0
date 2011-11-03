From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 1/1] [PATCH v4 1/1] mmc: Support of DUAL BUFFER DESC[ring]
 mode for dw_mmc
Date: Thu, 3 Nov 2011 15:18:07 +0000
Message-ID: <CAFbHwiSahkGOd4EfYiKY-T9Segn9Nn4qSMA591SFRmMmKY67VQ@mail.gmail.com>
References: <1317123568-5203-1-git-send-email-shashidharh@vayavyalabs.com>
	<4E8BBD76.9020001@samsung.com>
	<CANYdXnpe0prpdJcYpi3yVqCecugwZ1999c2u2u6ffjXjSeCDnw@mail.gmail.com>
	<m2obwt8ju2.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47375 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670Ab1KCPSI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2011 11:18:08 -0400
Received: by vcge1 with SMTP id e1so1196178vcg.19
        for <linux-mmc@vger.kernel.org>; Thu, 03 Nov 2011 08:18:07 -0700 (PDT)
In-Reply-To: <m2obwt8ju2.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Shashidhar Hiremath <shashidharh@vayavyalabs.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org

On Thu, Nov 3, 2011 at 12:35 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Thu, Nov 03 2011, Shashidhar Hiremath wrote:
>> Hi Chris,
>> =A0 Can this patch be accepted by criteria that its an additional
>> feature supported by the hardware and hence good to have the support
>> in the driver.Also note the patch has been tested.
>
> I think Will and James should make the call on that.
>
> My own opinion is that it's not usually a good idea to merge code tha=
t
> increases complexity for no performance gain; if the feature is actua=
lly
> important, someone should find a way to finish it and measure a
> performance gain (the gain can be in any of bandwidth, memory, or
> lower CPU utilization) with it, to prove that the change is worthwhil=
e.

I'm inclined to agree. I don't want to feel like I am blocking
inclusion of anyone's hard work, but unless there is a clear advantage
for one option over the other I can't see a good reason for merging
it. At present it adds a question to the Kconfig that is pretty much
impossible for the user to answer (do I turn this feature on or off?
what is the advantage of choosing each option?).
