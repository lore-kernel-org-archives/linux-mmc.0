From: Johan RUDHOLM <johan.rudholm@stericsson.com>
Subject: RE: ANNOUNCE: new "mmc-utils" repository
Date: Wed, 15 Feb 2012 13:06:19 +0100
Message-ID: <E2E6AC6BFAD06343BA2D97432459C1B60723E9886D@EXDCVYMBSTM005.EQ1STM.local>
References: <m2y5s8j86z.fsf@bob.laptop.org> <4F39F785.9070206@samsung.com>
 <E2E6AC6BFAD06343BA2D97432459C1B60723E34159@EXDCVYMBSTM005.EQ1STM.local>
 <4F3A1BD4.3010601@samsung.com> <m2mx8lihzs.fsf@bob.laptop.org>
 <E2E6AC6BFAD06343BA2D97432459C1B60723E982CA@EXDCVYMBSTM005.EQ1STM.local>
 <4F3B8F1A.4050601@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:51892 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755244Ab2BOMGg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Feb 2012 07:06:36 -0500
In-Reply-To: <4F3B8F1A.4050601@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Peppe CAVALLARO <peppe.cavallaro@st.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Jaehoon,

Jaehoon Chung wrote:

> On 02/15/2012 12:31 AM, Johan RUDHOLM wrote:
> 
> > Hi Chris, Jaehoon,
> >
> > Chris Ball wrote:
> >
> >>
> >> Hi,
> >>
> >> On Tue, Feb 14 2012, Jaehoon Chung wrote:
> >>> What kernel version is supported? up to linux-3.3? did you know?
> >>
> >> I think the only requirement is the command submission ioctl, so it
> >> should work in every kernel from 3.0 onwards.
> >
> > Actually, to be able to write to the ext csd via the ioctl, "mmc:
> core: check for zero length ioctl data" is also required. I think this
> went into 3.3-rc1.
> 
> Hi..Chris, Johan.
> 
> I think that mmc extcsd read/write <device> is something wrong..
> If mmc extcsd write /dev/mmcblk0, then boot area1/2 is power-on-write-
> protect. right?
> And i ran mmc extcsd read /dev/mmcblk0, and i printed the
> ext_csd[174](BOOT_WP_STATUS)
> That's always 0x0.
> 
> That means Boot-area1/2 is not protected.
> In do_write_extcsd(), i think that check with BOOT_WP_STATUS[174]
> whether protected or not.
> not BOOT_WP[173].
> 
> How think about?

I'm not sure... BOOT_WP_STATUS[174] was added in version 4.5, in 4.41 we only have BOOT_WP[173]. I guess we should read 174 if we have a 4.5 card, from the 4.5 spec: "To verify boot region protection read BOOT_WP_STATUS[174].", I guess this has been added because it's possible to lock only one boot partition in 4.5?

The command works fine for my 4.41 card:

# /data/mmc extcsd read /dev/block/mmcblk0
Power ro locking: possible
Permanent ro locking: possible
ro lock status: not locked
# /data/mmc extcsd write /dev/block/mmcblk0
# /data/mmc extcsd read /dev/block/mmcblk0
Power ro locking: possible
Permanent ro locking: possible
ro lock status: locked until next power on

Kind regards, Johan
