From: Philip Rakity <prakity@nvidia.com>
Subject: Re: When bus width detection procedure takes place, kernel cannot
 lock on correct bus width
Date: Fri, 22 Mar 2013 19:56:10 +0100
Message-ID: <C0EB07A4-F566-4865-BF4C-D9668C527203@nvidia.com>
References: <87ip4qdybr.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:17585 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781Ab3CVS4L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Mar 2013 14:56:11 -0400
In-Reply-To: <87ip4qdybr.fsf@octavius.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "elad.yi@gmail.com" <elad.yi@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Elad,

Please supply the name of the spec which shows that this field is dependent on bit width.

I checked my sd / emmc specs and do not see this.

regards,

Philip


On Mar 17, 2013, at 5:07 AM, Chris Ball <cjb@laptop.org> wrote:

> Hi Elad, I'm forwarding your bug report to the linux-mmc@ list.
> 
> - Chris.
> 
> 
> I've been working on a bringup of an new board in Harmonic Inc.
> This board uses Sandisk iNand eMMC flash.
> I've noticed that the mmc driver keeps detecting 1 bit width although HW
> supports 4 bit, looked into it, and found the problem. In line 571 at mmc.c:
> There is:
>    /* only compare read only fields */
>    err = !((card->ext_csd.raw_partition_support ==
>            bw_ext_csd[EXT_CSD_PARTITION_SUPPORT]) &&
>        (card->ext_csd.raw_erased_mem_count ==
>            bw_ext_csd[EXT_CSD_ERASED_MEM_CONT]) &&
>        (card->ext_csd.rev ==
>            bw_ext_csd[EXT_CSD_REV]) &&
>        (card->ext_csd.raw_ext_csd_structure ==
>                ...
> 
> The problem is that raw_partition_support is not the same when setting width of
> 4 bits instead of 1 bit, and shouldn't be compared at all although it is read
> only.
> this should be changed to:
>    /* only compare read only fields */
>    err = !((card->ext_csd.raw_erased_mem_count ==
>            bw_ext_csd[EXT_CSD_ERASED_MEM_CONT]) &&
>        (card->ext_csd.rev ==
>            bw_ext_csd[EXT_CSD_REV]) &&
>        (card->ext_csd.raw_ext_csd_structure ==
>                ...
> 
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

