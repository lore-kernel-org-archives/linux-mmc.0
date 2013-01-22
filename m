From: wwang <wei_wang@realsil.com.cn>
Subject: Re: [PATCH v4 0/8] rtsx patchset for MFD and MMC tree
Date: Tue, 22 Jan 2013 11:39:09 +0800
Message-ID: <50FE09DD.6070102@realsil.com.cn>
References: <cover.1357638064.git.wei_wang@realsil.com.cn> <50F66CAD.6090003@realsil.com.cn> <20130122033115.GY7409@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:47391 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898Ab3AVDjw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jan 2013 22:39:52 -0500
In-Reply-To: <20130122033115.GY7409@sortiz-mobl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "oakad@yahoo.com" <oakad@yahoo.com>, "bp@alien8.de" <bp@alien8.de>

=E4=BA=8E 2013=E5=B9=B401=E6=9C=8822=E6=97=A5 11:31, Samuel Ortiz =E5=86=
=99=E9=81=93:
> Hi Wei,
>
> On Wed, Jan 16, 2013 at 05:02:37PM +0800, wwang wrote:
>> =E4=BA=8E 2013=E5=B9=B401=E6=9C=8808=E6=97=A5 17:57, =E7=8E=8B=E7=82=
=9C =E5=86=99=E9=81=93:
>>> From: Wei WANG <wei_wang@realsil.com.cn>
>>>
>>> v2:
>>> 1. Add commit message for patch 2
>>> 2. Move pci_set_dma_mask before the pci_enable_device(pcidev) call
>>>
>>> v3:
>>> 1. Add commit message for patch 3
>>> 2. Add patch 8: Use macro defines to replace some variables
>>>
>>> v4:
>>> 1. Describe why patch 3 is needed
>>> 2. Modify a comment character in patch 7
>>>
>>> Wei WANG (8):
>>>    MFD:rtsx: Fix typo in comment
>>>    MFD:rtsx: Remove redundant code
>>>    MFD:rtsx: Declare that the DMA address limitation is 32bit expli=
citly
>>>    MFD:rtsx: Add callback function switch_output_voltage
>>>    MMC:rtsx: Using callback function to switch output voltage
>>>    MFD:rtsx: Add callback function conv_clk_and_div_n
>>>    MFD:rtsx: Fix checkpatch warning
>>>    MFD:rtsx: Use macro defines to replace some variables
>>>
>>>   drivers/mfd/rtl8411.c             |   29 ++++++++++++++++++++++++
>>>   drivers/mfd/rts5209.c             |   21 +++++++++++++++++
>>>   drivers/mfd/rts5229.c             |   21 +++++++++++++++++
>>>   drivers/mfd/rtsx_pcr.c            |   45 ++++++++++++++++++++++++=
+------------
>>>   drivers/mfd/rtsx_pcr.h            |    3 +++
>>>   drivers/mmc/host/rtsx_pci_sdmmc.c |   30 +++++-------------------=
-
>>>   include/linux/mfd/rtsx_common.h   |    3 +++
>>>   include/linux/mfd/rtsx_pci.h      |   27 +++++++++++++++++-----
>>>   8 files changed, 135 insertions(+), 44 deletions(-)
>>>
>> Hi Chris and Samuel:
>>
>> This patchset is trying to fix some bugs and some coding style issue=
s.
>> Would you please help to merge it to v3.8 kernel?
> I'll only take bug fixes for 3.8, even minor ones, and I don't see re=
al bug
> fixes here. Am I missing something ?
>
> Cheers,
> Samuel.
>
Hi Samuel:

The commits below are all bug fix ( fix rtl8411 specifically)

   MFD:rtsx: Add callback function switch_output_voltage
   MMC:rtsx: Using callback function to switch output voltage
   MFD:rtsx: Add callback function conv_clk_and_div_n

The other commits are for coding style issues

BR,
Wei WANG

