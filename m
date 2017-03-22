From: Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: Possible bug in mmc-utils: Is MMC 'partition setting completed'
 required for 'write reliability'?
Date: Wed, 22 Mar 2017 13:25:00 +0200
Message-ID: <0fab4456-cb52-2af2-6598-b363a0e390f5@vaisala.com>
References: <70BB63196E12E948A726997ECFE8646BC0CD58D9@Elexis-Exch02.elexisad.net>
 <00b923df-6aad-6428-3247-ead8995066c1@vaisala.com>
 <70BB63196E12E948A726997ECFE8646BC0CD5932@Elexis-Exch02.elexisad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:55341 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759229AbdCVLZE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 07:25:04 -0400
In-Reply-To: <70BB63196E12E948A726997ECFE8646BC0CD5932@Elexis-Exch02.elexisad.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Brinkmann, Harald" <Harald.Brinkmann@bst-international.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>

Hi,

On 03/22/2017 12:41 PM, Brinkmann, Harald wrote:
> 
> On Wed, 2017-03-22 at 11:13 +0200, Tomas Melin wrote:
>> On 03/20/2017 05:40 PM, Brinkmann, Harald wrote:
>>>
>>> I am having problems with the 'mmc' userspace command in mmc-utils.
>>> This call:
>>>
>>>> /usr/bin/mmc write_reliability set -y 0 /dev/mmcblk1
>>>
>>> results in:
>>>
>>>> setting OTP PARTITION_SETTING_COMPLETED!
>>>> Setting OTP PARTITION_SETTING_COMPLETED failed on /dev/mmcblk1
>>>
>>> Which is not too surprising, since I only want to set the write
>>> reliability bit and did not touch any (mmc-)partition information, so
>>> that it probably still is invalid.
>>
>> My experience is that you need to first do the partitioning before the write
>> reliability flag can be set. This is because the partition for which the write
>> reliability gets set, first needs to be configured for enhanced mode (enh_area set).
> 
> Yes, that is what the mmc utility makes you do, but I think is not
> supported by the standard. I am looking at "Embedded Multi-Media Card
> (e.MMC) Electrical Standard (5.1)" JESD84-B51.
> 
> Chapter 6.2 describes the "Partition Management" and that includes these
> settings (Chapter 6.2.4):
> 
> GP_SIZE_MULT_GP0 - GP_SIZE_MULT_GP3 [154:143]
> PARTITIONS_ATTRIBUTE                [156]
> EXT_PARTITIONS_ATTRIBUTE            [53:52]
> ENH_START_ADDR                      [139:136]
> ENH_SIZE_MULT                       [159:157]
> 
> Most particularly this chapter does *NOT* mention
> 
> WR_REL_SET                          [167]
> 
> at all!

>From Section 6.6.8 Data Write in the same standard:

"...This write must happen as part
of the partitioning process and must occur before the
PARTITION_SETTING_COMPLETED bit is set.
The changes made to the WR_REL_SET register will not have an impact until the
partitioning process is
complete (i.e., after the power cycle has occurred and the partitioning has
completed successfully). Data
reliability settings for partitions that do not exist in the device have no
impact on the device."

So the setting of WR_REL_SET is connected to the partitioning of the device. And
as long as the partitioning is not set, iirc the PARTITION_SETTING_COMPLETED bit
will not be accepted to be set by the device.

Regards
Tomas


> 
> And neither does the chapter about 'reliable write' (7.4.78) refer to
> the partition setup.
> 
> What I am looking for is a definite answer to whether my interpretation
> of the standard is correct or not. If it is correct, then the 'mmc
> write_reliability set' implementation is wrong.
> 
> Additionally this:
> 
>> /usr/bin/mmc write_reliability set -n 0 /dev/mmcblk1
> 
> should not do anything because of the -n (dry run-)option, but the write
> reliability bit is still being set.
> 
> FYI: Our intention is to keep the User Data Area in one piece, i.e. no
> eMMC-partitioning at all, and enable 'reliable write', but no other
> enhancements, for the entire User Data Area.
> 
>>> If I then type:
>>>
>>>> /usr/bin/mmc extcsd read /dev/mmcblk1
>>>
>>> that reliable write bit is shown as set:
>>>
>>>> Write reliability setting register [WR_REL_SET]: 0x01
>>
>> The bit gets set, but is it still on after a reboot?
> 
> Yes, it is.
> 
> 
> Best regards
> 
> i.A. Harald Brinkmann
> 
> --
> 
> BST eltromat International GmbH
> Werk Leopoldshöhe
> Herforder Straße 249-251
> D-33818 Leopoldshöhe
> 
> T:      +49 (5208) 987-513
> 
> E:      harald.brinkmann@bst-international.com
> W:      http://www.bst-eltromat.com
> 
> 
> 
> 
> _______________________________________________________
> Amtsgericht Bielefeld, HRB Nr. 30830
> Geschäftsführer Kristian Jünke, Dr. Johann-Carsten Kipp, Dr. Gunter
> Tautorus
> Sitz der Gesellschaft: Bielefeld
> Vertrauliche E-Mail von BST eltromat International GmbH
> 
