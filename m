From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: adding aliases to mmc ... again
Date: Fri, 23 May 2014 10:02:26 -0600
Message-ID: <537F7112.8000501@wwwdotorg.org>
References: <1400772623-8390-1-git-send-email-s.hauer@pengutronix.de> <537E22E3.3010601@wwwdotorg.org> <20140522182134.GD15686@pengutronix.de> <537E4EAF.5000309@wwwdotorg.org> <20140523082936.GC26228@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:41934 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbaEWQC3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 12:02:29 -0400
In-Reply-To: <20140523082936.GC26228@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Olbrich <m.olbrich@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, Fabio Estevam <festevam@gmail.com>, ptx@pengutronix.de

On 05/23/2014 02:29 AM, Michael Olbrich wrote:
> On Thu, May 22, 2014 at 01:23:27PM -0600, Stephen Warren wrote:
>> On 05/22/2014 12:21 PM, Sascha Hauer wrote:
>>> On Thu, May 22, 2014 at 10:16:35AM -0600, Stephen Warren wrote:
>>>> On 05/22/2014 09:30 AM, Sascha Hauer wrote:
>>>>> Hi all,
>>>>>
>>>>> The wish to have persistent MMC block device names for passing a suitable
>>>>> root=/dev/mmcblkX option came up several times already and has been discussed
>>>>> at least in these threads:
>>>>>
>>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-July/109984.html
>>>>> https://www.mail-archive.com/linux-mmc@vger.kernel.org/msg22104.html
>>>>> http://comments.gmane.org/gmane.linux.kernel.mmc/21519
>>>>>
>>>>> Several patches have been proposed to nail the slot index to a known number.
>>>>> Arguments against these patches were:
>>>>>
>>>>> - Use an initrd and locate the correct root device there
>>>>>   even Thomas who suggested this admitted this would be painful to do
>>>>> - use root=UUID= or root=PARTUUID=
>>>>>   This generally works but has an important downside. With the UUID
>>>>>   approach devices which should boot from the internal eMMC may start
>>>>>   booting from an external SD slot when somebody deliberately inserts
>>>>>   a SD card with the same UUID.
>>>>>
>>>>> The following patches should have the technical issues fixed. It works
>>>>> by counting the mmc aliases in the devicetree during initialization of
>>>>> the mmc framework. Those slot numbers will never be assigned to other
>>>>> hosts.
>>>>
>>>> Does it solve the following, which AFAIK has always been the primary
>>>> argument against aligning block device IDs with controller IDs:
>>>>
>>>> - User inserts SD card into MMC controller ID (or alias) 1.
>>>> - /dev/mmcblk1 now exists
>>>> - Mount /dev/mmcblk1 on /mnt/tmp
>>>> - User removes that SD card
>>>> - /dev/mmcblk1 still exists, since it's mounted so can't be deleted
>>>> after the card removal.
>>>> - User inserts SD card into MMC controller ID (or alias) 1.
>>>> - /dev/mmcblkN (N is something other than 1) now exists
>>>>
>>>> Now, the block device ID must be != the original ID, since two block
>>>> devices exist.
> 
> We could limit this to non-removable devices. This problem cannot occur
> there. Would that be acceptable?

That might work.
