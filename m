From: Chris Ball <cjb@laptop.org>
Subject: Re: Dynamic MMC device naming vs. bootloaders
Date: Mon, 04 Apr 2011 17:29:31 -0400
Message-ID: <m3ei5haeo4.fsf@pullcord.laptop.org>
References: <74CDBE0F657A3D45AFBB94109FB122FF0493EB33AE@HQMAIL01.nvidia.com>
	<m3r59haog5.fsf@pullcord.laptop.org>
	<74CDBE0F657A3D45AFBB94109FB122FF0493EB3428@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55094 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754194Ab1DDVYD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 4 Apr 2011 17:24:03 -0400
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0493EB3428@HQMAIL01.nvidia.com>
	(Stephen Warren's message of "Mon, 4 Apr 2011 14:07:06 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Stephen,

On Mon, Apr 04 2011, Stephen Warren wrote:
>> The standard way to solve this is to use an initrd that performs the
>> naming (and mounting) that you'd like based on characteristics of the
>> device or card -- this could include making mmcblk{0,1} always attach
>> to the controllers that you're expecting it to.  It's hard enough to get
>> device naming policy right that we don't usually try to do it in-kernel.
>
> I have a followup question: How could the initrd identify each device, in
> order to know which names to assign to them, or which one to mount?
>
> Is there a way to query the block device to determine which host controller
> ID it's connected to? Querying device size is pretty easy, but the user
> could easily happen to choose an SD card of the same size as the internal
> MMC for example.

That's a fine question.  I'm not sure what the *best* answer is, but you
have a few options:

* if your initrd contains udev, then the udev event for mmcblk creation
  looks like:

  UDEV  [1292447837.786721] add      /devices/platform/sdhci-pxa.0/mmc_host/mmc0/mmc0:d555/block/mmcblk1 (block)

  .. which contains the information you need.

* alternatively, you could grovel around sysfs:

  [root@localhost ~]# ls -la /sys/block/mmcblk0/device
  lrwxrwxrwx 1 root root 0 Jan  1  1970 /sys/block/mmcblk0/device -> ../../../mmc2:0001

So, the above tells you that on my system mmc2 (internal SD slot) hosts
mmcblk0, and mmc0 (external SD slot) hosts mmcblk1.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
